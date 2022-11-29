package tea.ui.util;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.member.Message;
import tea.entity.member.Profile;
import tea.entity.*;
import tea.entity.site.*;
import tea.http.RequestHelper;
import tea.resource.Resource;
import tea.service.Robot;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import javax.servlet.http.*;
import tea.entity.member.*;

public class RetrievePassword extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        if(request.getMethod().equals("GET"))
        {
            response.sendRedirect("/jsp/util/RetrievePassword.jsp?" + request.getQueryString());
            return;
        }
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try
        {
            Http h = new Http(request);
            String member = h.get("member");
            String email = h.get("email");
            if(email != null)
            {
                HttpSession session = request.getSession(true);
                String vertify = h.get("vertify");
                if(vertify == null || !vertify.equals(session.getAttribute("sms.vertify")))
                {
                    out.print("<script>alert(\"验证码 不正确!\");history.back();</script>");
                    return;
                }
                Profile p = Profile.find(member);
                if(!email.equals(p.getEmail()))
                {
                    out.print("<script>alert(\"会员号 和 电子邮箱 不匹配!\");history.back();</script>");
                    return;
                }
                String sn = request.getServerName(),webn = Community.find(h.community).getName(h.language);
                String c = "你好," + member + "( " + email + " ): <BR><BR>" + "感谢您使用 <A href=http://" + sn + ">" + webn + "</A> 帐户。<br/><br/>您的密码是:" + p.getPassword();
                boolean flag = Email.create(h.community,null,email,webn + ":密码找回",c);
                out.print("<script>alert(\"邮件已发件! 请查收!\");history.back();</script>");
                return;
            } else
            {
                Community community = tea.entity.site.Community.find(teasession._nNode);
                String info = null;
                /*
                 * if (!RequestHelper.isIdentifier(s)) { //printwriter1.print(super.r.getString(teasession._nLanguage, "InvalidMemberId")); info = super.r.getString(teasession._nLanguage, "InvalidMemberId"); } else
                 */
                if(Profile.isExisted(member))
                {
                    Profile profile = Profile.find(member);
                    String s1 = profile.getPassword();
                    String s2 = profile.getEmail();
                    if(s2 != null && s2.length() > 0)
                    {} else
                    {
                        s2 = member;
                    }
                    String s3 = community.getEmail();
                    String subject = super.r.getString(teasession._nLanguage,"RetrievePassword") + " - " + community.getName(teasession._nLanguage); // License.getInstance().getWebName();
                    String content = super.r.getString(teasession._nLanguage,"InfRetrieveResultIs") + "\n" + member + "/" + s1 + "\n" + RequestHelper.format(super.r.getString(teasession._nLanguage,"InfFindMoreHelp"),s3);
                    String contentcsv = super.r.getString(teasession._nLanguage,"InfRetrieveResultIs") + "\n" + member + "\n" + RequestHelper.format(super.r.getString(teasession._nLanguage,"InfFindMoreHelp"),"csvclub@csvclub.org");

                    int i = Message.create(teasession._strCommunity,s2,member,teasession._nLanguage,subject,content);
                    try
                    {
                        //Robot.activateRoboty(teasession._nNode, i);
                        tea.service.SendEmaily se = new tea.service.SendEmaily(teasession._strCommunity);
                        if("csvclub".equals(teasession._strCommunity))
                        {
                            StringBuilder strs = new StringBuilder();
                            strs.append(contentcsv);
                            strs.append(" http://csvclub.redcome.com/jsp/user/ChangePasswordMd5.jsp?member=").append(member);
                            se.sendEmail(s2,subject,strs.toString());
                        } else
                        {
                            se.sendEmail(s2,subject,content);
                        }
                    } catch(Exception _ex)
                    {
                    }
                    // response.sendRedirect("/jsp/util/RetrievePassword.jsp?Msg="+RequestHelper.format(super.r.getString(teasession._nLanguage, "InfPasswordSent"), s2));
                    info = RequestHelper.format(super.r.getString(teasession._nLanguage,"InfPasswordSent"),s2);
                } else
                {
                    info = RequestHelper.format(super.r.getString(teasession._nLanguage,"NotExist"),member);
                }
                response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(info,"UTF-8"));
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/util/RetrievePassword");
    }
}
