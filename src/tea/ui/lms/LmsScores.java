package tea.ui.lms;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.lms.*;
import tea.entity.member.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.regex.*;
import org.apache.poi.ss.usermodel.*;

public class LmsScores extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        response.setHeader("Content-Encoding","nogzip");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        ServletContext application = this.getServletContext();
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt;</script>");
            if(h.member < 1)
            {
                out.print("<script>top.location.replace('/servlet/StartLogin?community=" + h.community + "');</script>");
                return;
            }
            String info = "操作执行成功！";
            String key = h.get("lmsscore");
            int lmsscore = key == null ? 0 : Integer.parseInt(MT.dec(key));
            if("del".equals(act)) //删除
            {
                LmsScore t = LmsScore.find(lmsscore);
                t.delete();
            } else if("edit".equals(act)) //编辑
            {
                LmsScore t = LmsScore.find(lmsscore);
                //t.member = h.getInt("member");
                //t.lmsorg = h.getInt("lmsorg");
                t.lmsplan = h.getInt("lmsplan");
                //
                String tmp = h.get("lmscourse");
                ArrayList al = LmsCourse.find(" AND name=" + DbAdapter.cite(tmp),0,Integer.MAX_VALUE);
                if(al.size() != 1)
                {
                    out.print("<script>mt.show('抱歉，课程“" + tmp + "”不存在！');</script>");
                    return;
                }
                t.lmscourse = ((LmsCourse) al.get(0)).lmscourse;
                //t.name = h.get("name");
                t.card = h.get("card");
                t.ticket = h.get("ticket");
                t.score = h.getFloat("score");
                if(t.lmsscore < 1)
                {
                    t.time = new Date();
                }
                t.set();
            } else if("imp".equals(act)) //导入
            {
                for(int j = 0;j < 20;j++)
                    out.write("// 显示进度条  \n");
                info = imp(h,out);
                if(!info.startsWith("操作"))
                    nexturl = "";
            }
            out.print("<script>mt.show('" + info + "',1,'" + nexturl + "');</script>");
        } catch(Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }

    public static String imp(Http h,Writer out) throws SQLException
    {
        int type = h.getInt("type");
        Workbook wbs = Lms.conv(Http.REAL_PATH + h.get("file"));
        if(wbs == null)
            return "抱歉，请上传xls、xlsx格式文件！";
        Pattern YM = Pattern.compile("(\\d+)年(\\d+)月");

        int a1 = 0,a2 = 0;
        Sheet s = wbs.getSheetAt(0);
        ArrayList lss = new ArrayList();
        for(int i = 1;i <= s.getLastRowNum();i++)
        {
            Row r = s.getRow(i);
            if(r == null)
                continue;
            int j = 0;
            String th = null;
            try
            {
                th = "省份";
                String city = Lms.f(r,j++);
                //
                th = "省机构";
                String org = Lms.f(r,j++);
                //
                th = "学习中心";
                org = Lms.f(r,j++);
                if((MT.f(city) + MT.f(org)).length() < 1) //空白行（某此单元格中有空格），一班在未尾会出现。
                    continue;
                ArrayList al = LmsOrg.find(" AND isasp=0 AND orgname=" + DbAdapter.cite(org),0,Integer.MAX_VALUE);
                if(al.size() != 1)
                {
                    return "抱歉，学习中心“" + org + "”不存在！";
                }
                int lmsorg = ((LmsOrg) al.get(0)).lmsorg;
                //
                th = "姓名";
                String name = Lms.f(r,j++);
                //
                th = "证件号";
                String card = Lms.f(r,j++);
                al = Profile.find1(" AND deleted=0 AND type NOT IN(1,4) AND card=" + DbAdapter.cite(card),0,Integer.MAX_VALUE);
                if(al.size() < 1)
                    al = Profile.find1(" AND deleted=0 AND type NOT IN(1) AND card=" + DbAdapter.cite(card),0,Integer.MAX_VALUE);
                if(al.size() != 1)
                {
                    return "抱歉，学员“" + card + "”不存在！";
                    //Filex.logs("score.txt","文件：" + file + "　　姓名：" + name + "　　证件号：" + card + "　　学员不存在！");
                    //continue;
                }
                Profile p = (Profile) al.get(0);
                int member = p.getProfile();
                //
                th = "准考证号";
                String ticket = Lms.f(r,j++);
                if(out != null)
                {
                    out.write("<script>mt.progress(" + i + "," + s.getLastRowNum() + ",'姓名：" + name + "　准考证：" + ticket + "');</script>");
                    out.flush();
                }
                al = LmsScore.find(" AND member=" + member + " AND ticket!=" + DbAdapter.cite(ticket),0,1);
                if(al.size() > 0) //准考证号 变更
                {
                    LmsScore ls = (LmsScore) al.get(0);
                    return "抱歉，学员“" + card + "”的准考证号是“" + ls.ticket + "”还是“" + ticket + "”？";
                }
                al = LmsScore.find(" AND member!=" + member + " AND ticket=" + DbAdapter.cite(ticket),0,1);
                if(al.size() > 0) //准考证号 重复
                {
                    LmsScore ls = (LmsScore) al.get(0);
                    return "抱歉，准考证号“" + ticket + "”已被学员“" + ls.card + "”使用！";
                }
                //
                th = "考试计划";
                String plan = Lms.f(r,j++);
                Matcher m = YM.matcher(plan); //2014年5月 转为 201405
                if(m.find())
                {
                    plan = m.group(2);
                    plan = m.group(1) + (plan.length() < 2 ? "0" : "") + plan;
                }
                //Cell c = r.getCell(j++);
                //Date time = c.getDateCellValue();
                //String plan = MT.f(time);
                //plan = plan.substring(0,4) + plan.substring(5,7);
                al = LmsPlan.find(" AND status IN(2,4) AND name=" + DbAdapter.cite(plan),0,Integer.MAX_VALUE);
                if(al.size() != 1)
                {
                    return "抱歉，考试计划“" + plan + "”不存在！";
                }
                LmsPlan lp = (LmsPlan) al.get(0);
                int lmsplan = lp.lmsplan;
                //
                th = "考试科目";
                String course = Lms.f(r,j++);
                if(!course.endsWith("）"))
                    course += "（二）";
                al = LmsCourse.find(" AND name=" + DbAdapter.cite(course),0,Integer.MAX_VALUE);
                if(al.size() != 1)
                {
                    return "抱歉，课程“" + course + "”不存在！";
                }
                int lmscourse = ((LmsCourse) al.get(0)).lmscourse;
                //
                th = "总成绩";
                Cell c = r.getCell(j++);
                float score = Float.parseFloat(c.toString());
                //
                LmsScore t = LmsScore.find(member,lmsplan,lmscourse);
                if(t.lmsscore > 0)
                {
                    if(type == 2)
                        continue;
                    if(type == 3)
                        return "抱歉，“" + card + "”已存在！";
                    a2++;
                } else
                {
                    a1++;
                    t.time = lp.time; //new Date();
                }
                t.lmsorg = lmsorg;
                t.ticket = ticket;
                t.name = name;
                t.card = card;
                t.score = score;
                lss.add(t);
                //注册 改为 已确认
                if(p.getType() == 2)
                    p.setType(3);
                if(!ticket.equals(p.getCardnumber()))
                    p.setCardnumber(ticket);
            } catch(Throwable ex)
            {
                ex.printStackTrace();
                return "位置：" + (i + 1) + "x" + j + "<br/>列名：" + th + "<br/>错误：" + ex.toString();
            }
        }
        for(int i = 0;i < lss.size();i++)
        {
            LmsScore ts = (LmsScore) lss.get(i);
            ts.set();
        }
        return "操作执行成功！<br/>新增：" + a1 + "条　替换：" + a2 + "条";
    }
}
