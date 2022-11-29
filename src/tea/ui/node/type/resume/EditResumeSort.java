package tea.ui.node.type.resume;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.node.*;
import tea.entity.member.*;
import tea.ui.*;

public class EditResumeSort extends HttpServlet
{

    //Initialize global variables
    public void init() throws ServletException
    {
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        if(teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
            return;
        }
        String nu = request.getParameter("nexturl");
        try
        {
            int type = Integer.parseInt(request.getParameter("type"));

//            if (request.getParameter("standby") != null)
//            { //备用
//                type = 1;
//            } else if (request.getParameter("value") != null)
//            { //有价值
//                type = 2;
//            } else if (request.getParameter("not") != null)
//            { //不合格
//                type = 3;
//            } else if (request.getParameter("del") != null)
//            { //删除
//                type = 4;
//            }

            String rs[] = request.getParameterValues("resumes");
            for(int index = 0;index < rs.length;index++)
            {
                int resume = Integer.parseInt(rs[index]);
                int job = Integer.parseInt(request.getParameter("job" + resume));
//                if (type == 4 && applyAmount != null && ResumeSorttype == null)
//                {
//                    JobApply.find(Integer.parseInt(applyAmount), resume).delete();
//                } else
                // {
                ResumeSort obj = ResumeSort.find(teasession._rv.toString(),resume,job);
                obj.set(type);
                if(type == 4)
                { //
                    Job jobj = Job.find(obj.getJob(),teasession._nLanguage);
                    Node n = Node.find(obj.getJob());
                    Node n2 = Node.find(resume);

                    Profile p = Profile.find(n2.getCreator().toString());
                    //发送外部邮件
                    tea.service.SendEmaily se = new tea.service.SendEmaily(teasession._strCommunity);
                    se.sendEmail(p.getEmail(),"怡康科技有限公司-面试通知","您应聘的是" + n.getSubject(teasession._nLanguage) + "的职位，请带好自己的证件和简历，于3日内到北京市海淀区上地东路京蒙高科大厦一层面试！");
                    //发送手机
                    String info = SMSMessage.create(teasession._strCommunity,teasession._rv._strV,p.getMobile(),teasession._nLanguage,"面试通知：您投递的" + n.getSubject(teasession._nLanguage) + "的职位，请带好自己的证件和简历，于3日内到北京市海淀区上地东路京蒙高科大厦一层面试！");
                    System.out.println(info);
//                    obj.set(1); //通知面试发送成功后 把简历重新加到 人才库里面
                    Node.setTypealias(4,resume);
                }
                // }
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
        response.sendRedirect("/jsp/info/Succeed.jsp?community=" + teasession._strCommunity + "&nexturl=" + java.net.URLEncoder.encode(nu,"UTF-8"));
    }

    //Clean up resources
    public void destroy()
    {
    }
}
