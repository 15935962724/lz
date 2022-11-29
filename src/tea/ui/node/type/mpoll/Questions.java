package tea.ui.node.type.mpoll;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.node.type.mpoll.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class Questions extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        ServletContext application = this.getServletContext();
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            if(h.member < 1)
            {
                out.println("<script>mt.show('您还没有登录或登录已超时！请重新登录',2,'/');</script>");
                return;
            }
            if("sequence".equals(act))
            {
                String[] qs = h.get("questions").split("[|]");
                for(int i = 1;i < qs.length;i++)
                {
                    Question a = new Question(Integer.parseInt(qs[i]));
                    a.set("sequence",String.valueOf(i * 10));
                }
                return;
            }
            int question = h.getInt("question");
            Question t = question < 1 ? new Question(0) : Question.find(question);
            if("add".equals(act))
            {
                int poll = h.getInt("poll");
                int type = h.getInt("type");
                if(type > 20) //题库
                {
                    t = Question.find(type).clone(poll);
                } else
                {
                    t.poll = poll;
                    t.type = type;
                    t.name[1] = Question.QUESTION_TYPE[t.type];
                    t.sequence = (int) (System.currentTimeMillis() / 1000);
                    t.set();
                    if(t.type < 3)
                    {
                        for(int i = 1;i < 4;i++)
                        {
                            Choice c = new Choice(0);
                            c.question = t.question;
                            c.name[1] = "第" + i + "选项";
                            c.sequence = i;
                            c.set();
                        }
                    }
                }
                question = t.question;
            } else if("del".equals(act)) //删除
            {
                Poll p = Poll.find(t.poll);
                if(p.question == t.question)
                {
                    out.print("<script>mt.show('“过滤问题”不可删除！');</script>");
                    return;
                }
                t.delete();
                question = 0;
            } else if("edit".equals(act)) //编辑
            {
                t.name[0] = h.get("name0");
                t.name[1] = h.get("name1");
                t.content[0] = h.get("content0");
                t.content[1] = h.get("content1");
                t.required = h.getBool("required");
                //t.value = h.get("value");
                t.answer = h.getInt("answer");
                t.width = h.getInt("width");
                t.sequence = h.getInt("sequence");
                t.set();
                if(t.type < 3)
                {
                    StringBuilder sb = new StringBuilder();
                    sb.append("DELETE FROM " + Poll.PR + "Choice WHERE question=" + t.question + " AND choice NOT IN(");
                    String[] arr = h.getValues("choices");
                    if(arr != null)
                    {
                        for(int i = 0;i < arr.length;i++)
                        {
                            Choice c = Choice.find(Integer.parseInt(arr[i]));
                            c.name[1] = h.get("cname1_" + c.choice);
                            c.name[0] = h.get("cname0_" + c.choice);
                            c.sequence = (int) (System.currentTimeMillis() / 1000);
                            c.set();
                            sb.append(c.choice).append(",");
                        }
                    }
                    DbAdapter.execute(sb.append("0)").toString());
                    //新增
                    String[] n1 = h.getValues("cname1");
                    String[] n0 = h.getValues("cname0");
                    for(int i = 0;i < n1.length - 1;i++)
                    {
                        Choice c = new Choice(0);
                        c.question = t.question;
                        c.name[1] = n1[i];
                        c.name[0] = n0[i];
                        c.sequence = (int) (System.currentTimeMillis() / 1000);
                        c.set();
                    }
                }
                question = 0;
            } else if("clone".equals(act)) //复制
            {
                question = t.clone(t.poll).question;
            }
            out.print("<script>parent.location.replace('/jsp/type/mpoll/Questions.jsp?poll=" + t.poll + "&question=" + question + "&top=" + h.getInt("top") + "');</script>");
            //out.print("<script>mt.show('数据修改成功！',1,'/admin/poll/Questions.jsp?poll=" + t.poll + "&question=" + question + "');</script>");
        } catch(Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
