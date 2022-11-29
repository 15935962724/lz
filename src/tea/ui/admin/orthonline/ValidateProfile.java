package tea.ui.admin.orthonline;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.*;
import tea.entity.node.*;
import tea.ui.TeaSession;
import tea.entity.member.*;
import java.security.NoSuchAlgorithmException;

public class ValidateProfile extends tea.ui.TeaServlet
{
    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        r.add("tea/ui/util/SignUp1").add("/tea/ui/node/type/sms/EditUser");
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        try
        {
            String act = teasession.getParameter("act");
            String nu = teasession.getParameter("nexturl");
            boolean _bAffirm = teasession.getParameter("affirm") != null;
            boolean _bCancel = teasession.getParameter("cancel") != null;
            String MemberId = teasession.getParameter("MemberId");


            if (_bAffirm) // 确认会员
            {
                MemberId = teasession.getParameter("member");
                if (!Profile.isExisted(MemberId))
                { // 1169607402250=该会员不存在或已经取消了验证. <A href="/">回首页</A> <A href="javascript:window.opener=null;windown.close();">关闭</A>
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "1169607402250"), "UTF-8"));
                    return;
                }
                Profile p = Profile.find( MemberId);
                if (p.isValidate())
                { // 1169607851484=该会员已经通过验证了,无需在此验证. <A href="/">回首页</A> <A href="javascript:window.opener=null;windown.close();">关闭</A>
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "1169607851484"), "UTF-8"));
                    return;
                }
     
                String dig = BBS.md5(MemberId + p.getTime().getTime());
                String validate = teasession.getParameter("validate");
                if (dig.equals(validate))
                {
                    p.setValidate(true);
                    response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "ValidateSucceed"), "UTF-8"));
                } else
                {
                    // 1169607769453=验证码错误. <A href="/">回首页</A> <A href="javascript:window.opener=null;windown.close();">关闭</A>
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "1169607769453"), "UTF-8"));
                }
                return;
            } else // 取消会员
            if (_bCancel)
            {
                MemberId = teasession.getParameter("member");
                if (!Profile.isExisted(MemberId))
                { // 1169607402250=该会员不存在或已经取消了验证. <A href="/">回首页</A> <A href="javascript:window.opener=null;windown.close();">关闭</A>
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "1169607402250"), "UTF-8"));
                    return;
                }
                Profile p = Profile.find(MemberId);
                if (p.isValidate())
                { // 1169607667296=该会员已经验证了,不能取消. <A href="/">回首页</A> <A href="javascript:window.opener=null;windown.close();">关闭</A>
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "1169607667296"), "UTF-8"));
                    return;
                }
             
                String dig = BBS.md5(MemberId + p.getTime().getTime());
                String validate = teasession.getParameter("validate");
                if (dig.equals(validate))
                {
                    if (request.getParameter("ok") == null)
                    {
                        response.setContentType("text/html;charset=UTF-8");
                        java.io.PrintWriter out = response.getWriter();
                        out.print("<HTML><HEAD>                                                                       ");
                        out.print("<link href=/res/" + teasession._strCommunity + "/cssjs/community.css rel=stylesheet type=text/css>             ");
                        out.print("<SCRIPT LANGUAGE=JAVASCRIPT SRC=/tea/tea.js  ></SCRIPT>                            ");
                        out.print("<meta http-equiv=Content-Type content=text/html; charset=UTF-8 >                   ");
                        out.print("</HEAD>                                                                            ");
                        out.print("<body>                                                                             ");
                        out.print("<h1>" + r.getString(teasession._nLanguage, "INFO") + "</h1>                            ");
                        out.print("<div id=head6><img height=6></div>                                                 ");
                        out.print("<form action=\"/servlet/EditProfileBBS\" method=post >");
                        out.print("<input type=hidden name=validate2 value=" + request.getParameter("validate2") + " >");
                        out.print("<input type=hidden name=validate value=" + validate + " >");
                        out.print("<input type=hidden name=member value=" + MemberId + " >");
                        out.print("<input type=hidden name=community value=" + teasession._strCommunity + " >");
                        out.print("<input type=hidden name=Node value=" + teasession._nNode + " >");
                        out.print("<input type=hidden name=cancel value=ON >");
                        out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter >                       ");
                        out.print("<tr><td>" + r.getString(teasession._nLanguage, "MemberId") + "</td><td>" + MemberId + "</td></tr>                    ");
                        out.print("<tr><td>" + r.getString(teasession._nLanguage, "EmailAddress") + "</td><td>" + p.getEmail() + "</td></tr>                    ");
                        out.print("<tr><td>" + r.getString(teasession._nLanguage, "1169608574768") + "</td><td>" + p.getTime() + "</td></tr>                    ");
                        out.print("<tr><td colspan=2 align=center>" + r.getString(teasession._nLanguage, "1169608574765") + "</td></tr>");
                        out.print("<tr><td colspan=2 align=center><input type=submit name=ok value=" + r.getString(teasession._nLanguage, "1169608574766") + ">  <input type=button value=" + r.getString(teasession._nLanguage, "1169608574767") + " onclick=\" window.opener=null;window.open('/','_self'); \" ></td></tr></table>");
                        out.print("</form></DIV>                                                                             ");
                        out.print("<div id=head6><img height=6></div>                                                 ");
                        out.print("</body>                                                                            ");
                        out.print("</HTML>                                                                            ");
                        out.close();
                    } else
                    {
                        p.delete(teasession._nLanguage);
                        response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "CancelSucceed"), "UTF-8"));
                    }
                } else
                {
                    // 1169607769453=验证码错误. <A href="/">回首页</A> <A href="javascript:window.opener=null;windown.close();">关闭</A>
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "1169607769453"), "UTF-8"));
                }
                return;
            }
        } catch (Exception ex)
        {
            ex.printStackTrace();
            response.sendRedirect("/jsp/info/Error.jsp?info=" + ex.getMessage());
        }
    }

    // Clean up resources
    public void destroy()
    {
    }
}
