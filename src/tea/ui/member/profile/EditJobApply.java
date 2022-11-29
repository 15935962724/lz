package tea.ui.member.profile;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import tea.ui.*;
import tea.entity.*;
import tea.db.*;
import tea.resource.*;
import tea.entity.site.*;
import tea.entity.node.*;
import tea.entity.member.*;
import java.sql.SQLException;
import java.util.zip.*;

public class EditJobApply extends TeaServlet
{

    // Initialize global variables
    public void init() throws ServletException
    {
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        Resource r = new Resource("/tea/resource/Job");
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            String act = request.getParameter("act");
            if ("editapply2".equals(act))
            {
                String jobs[] = request.getParameterValues("jobs");
                if (jobs != null)
                {
                    for (int i = 0; i < jobs.length; i++)
                    {
                        int job = Integer.parseInt(jobs[i]);
                        JobApply apply = JobApply.find(job, teasession._nNode);
                        if (!apply.isExists())
                        {
                            JobApply.create(teasession._nNode, job, 0);
                        }
                    }
                }
                response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "1167544889437"), "UTF-8")); // 申请职位成功！该职位已经存入<A
                // href='/jsp/type/job/AppHistory.jsp'>已申请职位</A>记录
            } else if ("down".equals(act))
            {
                response.setHeader("Content-disposition", "attachment; filename=" + "expertdoc.zip");
                String rs[] = request.getParameterValues("resumes");

                if (rs != null)
                {
                    ZipOutputStream zos = new ZipOutputStream(response.getOutputStream());
                    for (int i = 0; i < rs.length; i++)
                    {
                        int resume = Integer.parseInt(rs[i]);

                        int job = Integer.parseInt(request.getParameter("job" + rs[i]));
                        JobApply ja = JobApply.find(resume, job);
                        ApplyTable at = ApplyTable.find(ja.getApplyTable());
                        if (at.isExists())
                        {
                            File f = new File(Common.REAL_PATH + at.getFile());
                            byte by[] = new byte[(int) f.length()];
                            FileInputStream fis = new FileInputStream(f);
                            fis.read(by);
                            fis.close();
                            //
                            zos.putNextEntry(new ZipEntry(at.getMember() + "_" + at.getName()));
                            zos.write(by);
                        }
                    }
                    zos.close();

//  byte   b[]   =   new   byte[512];
//  ZipOutputStream zout = new ZipOutputStream(response.getOutputStream());
//
//
//            for (int i = 0; i < rs.length; i++)
//                         {
//                             int resume = Integer.parseInt(rs[i]);
//                             int job = Integer.parseInt(request.getParameter("job" + rs[i]));
//
//       JobApply ja = JobApply.find(resume, job);
//       ApplyTable at = ApplyTable.find(ja.getApplyTable());
//                InputStream   in   =   new   FileInputStream(Common.REAL_PATH+at.getFile());
//                ZipEntry   e   =   new   ZipEntry((Common.REAL_PATH+at.getFile()).replace(File.separatorChar,'/'));
//                zout.putNextEntry(e);
//                int   len=0;
//                while((len=in.read(b))   !=   -1)   {
//                    zout.write(b,0,len);
//                    }
//                zout.closeEntry();
//              //   print(e);
//                }
//
//
//            zout.close();


                }
                return;
            } else
            {
                int resume = Integer.parseInt(teasession.getParameter("resume"));

                int count = 0;
                tea.db.DbAdapter dbadapter = new tea.db.DbAdapter();
                try
                {
                    count = dbadapter.getInt("SELECT COUNT(resume) FROM JobApply WHERE job=" + teasession._nNode + " AND resume IN (SELECT n.node FROM Resume r INNER JOIN Node n ON n.node=r.node WHERE n.vcreator=" + DbAdapter.cite(teasession._rv.toString()) + ")");
                } finally
                {
                    dbadapter.close();
                }
                Communityjob cj = Communityjob.find(teasession._strCommunity);
                if (count <= 0 && (JobApply.countByResume(resume) < cj.getMaxSum()||cj.getMaxSum()==0)) // 会员是否申请过本职位&&一份简历最多申请三个职位
                {
                    int at = Integer.parseInt(teasession.getParameter("applytable"));
                    JobApply.create(resume, teasession._nNode, at);
                    // ////////////////////////////发送电子邮件

                    Community community = Community.find(teasession._nNode);
                    String webn = community.getName(teasession._nLanguage);
                    String web = community.getWebName();
                    String s1 = teasession._rv._strR;
                    Node node = Node.find(teasession._nNode);
                    // ///////////发送到申请者
                    String conent = s1 + " 你好!<br>欢迎来到" + webn + "<a href=" + web + ">" + web + "</a><br>时间:" + (new java.util.Date()) + "<BR>申请的职位:" + node.getSubject(teasession._nLanguage) + "<hr size=1>" + "本邮件为系统自动发送，请不要回复本邮件。本公司招募人才工作承蒙大力支持，非常感谢。如果一个月内我们没有再次联系您，说明该岗位已有合适的人选。但我们已经将您的资料列入储备人才档案，如果有合适的职位，我们将及时同您联系。"; //期待有机会邀请您加盟中国海洋石油事业！ 最后对您应征本公司的热诚致以诚挚的谢意。 中国海洋石油总公司人力资源部
                    String str = "申请职位-确认信 " + webn;
                    Profile profile = Profile.find(teasession._rv._strR);
                    String s5 = profile.getEmail();
                    tea.service.SendEmaily se = new tea.service.SendEmaily(teasession._strCommunity);
                    se.sendEmail(s5, str, conent);
                    // ///////发送到HR

                    RV rv = node.getCreator();
                    if (Profile.find(rv._strR).isJobMailMsg())
                    {
                        conent = rv._strR + " 你好!<br>欢迎来到" + webn + "<a href=" + web + ">" + web + "</a><br>时间:" + Profile.sdf2.format(new java.util.Date()) + "<BR>" + s1 + " 申请的职位 " + node.getSubject(teasession._nLanguage);
                        str = "申请职位 " + webn;
                        s5 = Profile.find(rv._strR).getEmail();
                        // 读取文件
                        String filepath = null;
                        if (at != 0) // 如果有申请表
                        {
                            filepath = "/tea/app/at" + at + ".doc";
                        }
                        se.sendEmail(s5, str, conent);
                    }
                    // //发送完毕
                    response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "1167544889437"), "UTF-8")); // 申请职位成功！该职位已经存入<A
                    // href='/jsp/type/job/AppHistory.jsp'>已申请职位</A>记录
                    return;
                }

                // 你已经申请过该职位,不必再次投递简历,或你已经用本简历申请三个职位了.查看<a href='/jsp/type/job/AppHistory.jsp'>申请记录</a>
               // response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "1167545046234"), "UTF-8"));
                response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode("你已经申请过该职位,不必再次投递简历了.查看<a href='/jsp/type/job/AppHistory.jsp'>申请记录</a>", "UTF-8"));
            }
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }

    // Clean up resources
    public void destroy()
    {
    }
}
