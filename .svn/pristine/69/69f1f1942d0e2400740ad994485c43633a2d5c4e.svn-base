package tea.ui.node.type;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.ui.*;
import tea.entity.*;
import tea.entity.node.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.ui.TeaSession;
import net.mietian.convert.*;

public class Courses extends HttpServlet
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
            out.println("<script>var mt=parent.mt;</script>");
            if(h.member < 1)
            {
                out.print("<script>mt.show('对不起，您还没有登陆，请先登陆！',2,'/servlet/StartLogin?node=" + h.node + "');</script>");
                return;
            }
            String info = "操作执行成功！";
            Node n = Node.find(h.node);
            if(act.startsWith("plan")) //我要报名
            {
                if("planadd".equals(act)) //我要报名_链接
                {
                    ArrayList al = CoursePlan.find(" AND node=" + h.node + " AND member=" + h.member,0,1);
                    if(al.size() > 0)
                    {
                        CoursePlan t = (CoursePlan) al.get(0);
                        out.print("<script>mt.show('您于" + MT.f(t.time,1) + "时间，已经报名了该课程！');</script>");
                        return;
                    }
                    out.print("<script>parent.location='/html/Home/folder/33-1.htm?course=" + h.node + "';</script>");
                } else if("planadd2".equals(act)) //提交
                {
                    CoursePlan t = new CoursePlan(0);
                    t.node = h.node;
                    t.member = h.member;
                    t.payment = h.getInt("payment");
                    t.ispay = t.state = 1;
                    t.time = new Date();
                    t.set();
                    //报名人数
                    Course c = Course.find(t.node,h.language);
                    c.set("quantity",String.valueOf(++c.quantity));
                    info = "报名成功！感谢您报名参加“" + n.getSubject(h.language) + "”培训，培训时间于" + MT.f(n.getStartTime()) + "开始，请准时到场！";
                } else
                {
                    int courseplan = h.getInt("courseplan");
                    String[] arr = courseplan < 1 ? h.getValues("courseplans") : new String[]
                                   {String.valueOf(courseplan)};
                    if("plandel".equals(act)) //删除
                    {
                        for(int i = 0;i < arr.length;i++)
                        {
                            CoursePlan t = CoursePlan.find(Integer.parseInt(arr[i]));
                            if(t.ispay == 2)
                            {
                                out.print("<script>mt.show('抱歉，已付款的报名，不可删除！');</script>");
                                return;
                            }
                            t.delete();
                            //报名人数
                            Course c = Course.find(t.node,h.language);
                            c.set("quantity",String.valueOf(--c.quantity));
                        }
                    } else if("planstate".equals(act)) //审核
                    {
                        int state = h.getInt("state");
                        for(int i = 0;i < arr.length;i++)
                        {
                            CoursePlan t = CoursePlan.find(Integer.parseInt(arr[i]));
                            t.set("state",String.valueOf(t.state = state));
                        }
                    } else if("planispay".equals(act))
                    {
                        String paynote = h.get("paynote");
                        int ispay = h.getInt("ispay");
                        for(int i = 0;i < arr.length;i++)
                        {
                            CoursePlan t = CoursePlan.find(Integer.parseInt(arr[i]));
                            t.price = Course.find(t.node,h.language).price;
                            t.ispay = ispay;
                            t.paymember = h.member;
                            t.paytime = new Date();
                            t.paynote = paynote;
                            t.set();
                        }
                    }
                }
            } else if("del".equals(act)) //删除
            {
                n.delete(h.language);
            } else if("hidden".equals(act)) //发布
            {
                n.setHidden(!n.isHidden());
            } else if("edit".equals(act)) //编辑
            {
                String subject = h.get("subject");
                String content = h.get("content");
                Date starttime = h.getDate("starttime");
                Date stoptime = h.getDate("stoptime");
                if(n.getType() == 1)
                {
                    int sequence = Node.getMaxSequence(h.node) + 10;
                    int options1 = n.getOptions1();
                    Category cat = Category.find(h.node); //101
                    h.node = Node.create(h.node,sequence,n.getCommunity(),new RV(h.username),cat.getCategory(),(options1 & 2) != 0,n.getOptions(),options1,h.language,starttime,stoptime,new Date(),n.getStyle(),n.getRoot(),n.getKstyle(),n.getKroot(),null,h.language,subject,"","",content,null,"",0,null,"","","","",null,null);
                    n.finished(h.node);
                } else
                {
                    n.set(h.language,subject,content);
                    n.setStartTime(starttime);
                    n.setStopTime(stoptime);
                }
                Course t = Course.find(h.node,h.language);
                t.org = h.get("org");
                t.address = h.get("address");
                t.tel = h.get("tel");
                t.price = h.getFloat("price");
                t.regstop = h.getDate("regstop");
                t.quantity = h.getInt("quantity");
                t.set();

                if(nexturl.length() < 1)
                    nexturl = "/html/course/" + h.node + "-" + h.language + ".htm";
            } else if("attch0".equals(act)) //上传课件_视频
            {
                out.println("<script>mt.show('上传完成，开始转换格式...',0);function f(d){mt.progress(d.progress,100,'已转：<br/>大小：'+mt.f(d.size,2)+' KB　时间：'+d.time);};</script>");
                out.flush();

                int attch = h.getInt("attch");
                Attch a = Attch.find(attch);
                Video v = new Video(application.getRealPath(a.path));
                a.length = v.duration;
                v.qscale = (int) ((100 - h.getInt("qscale")) * 2.55);
                a.width = v.width = h.getInt("width");
                a.height = v.height = h.getInt("height");
                String path = "/res/" + h.community + "/flv/" + (a.node / 2000) + "/" + h.node + "-" + a.attch;
                a.path2 = path + "-" + Math.random() + ".flv";
                boolean rs = v.start(application.getRealPath(a.path2),out);
                if(rs)
                {
                    a.path3 = path + ".jpg";
                    v.pic(10,application.getRealPath(a.path3));
                } else
                {
                    info = "视频格式转换失败！";
                }
                a.set();
                Filex.logs("video.txt","附件：" + attch + "　转换：" + v.file + "　结果：" + rs + "　信息：" + v.error);
                //
                String voice = MT.f(n.getVoice(h.language),"|");
                voice += a.attch + "|";
                n.set("voice",h.language,voice);
            } else if("attch1".equals(act)) //上传课件_文档
            {
                int attch = h.getInt("attch");
                Attch a = Attch.find(attch);
                a.set("state",a.state = "paper");
                //
                String files = MT.f(n.getFile(h.language),"|");
                files += a.attch + "|";
                n.set("filedata",h.language,files);
            } else if("attchdel".equals(act)) //删除课件
            {
                int attch = h.getInt("attch");
                String voice = MT.f(n.getVoice(h.language),"|");
                voice = voice.replaceAll("\\|" + attch + "\\|","|");
                n.set("voice",h.language,voice);
                //
                String files = MT.f(n.getFile(h.language),"|");
                files = files.replaceAll("\\|" + attch + "\\|","|");
                n.set("filedata",h.language,files);
            }
            TeaServlet.delete(n);

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
}
