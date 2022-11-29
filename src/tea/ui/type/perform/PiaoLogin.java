package tea.ui.type.perform;


import java.io.IOException;


import javax.servlet.*;

import javax.servlet.http.*;
import tea.entity.*;
import tea.entity.member.*;

import tea.entity.site.*;
import tea.ui.*;
import tea.service.SMS;
import tea.entity.admin.AdminUsrRole;
import tea.entity.bpicture.Bperson;

public class PiaoLogin extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        java.io.PrintWriter out = response.getWriter();

        try
        {

            TeaSession teasession = new TeaSession(request);
            String errurl = "/servlet/StartLogin%3FNode%3D" + teasession._nNode;

            String LoginId = teasession.getParameter("LoginId"); //用户名
            if(LoginId == null || (LoginId = LoginId.trim()).length() < 1)
            {
                response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"InvalidMemberId"),"UTF-8") + "&nexturl=" + errurl);
                return;
            }
            LoginId = LoginId.toLowerCase();
            HttpSession session = request.getSession(true);
            //判断验证码
            String sv = (String) session.getAttribute("sms.vertify");
            String vertify = request.getParameter("vertify");
            if(sv != null && vertify != null)
            {
                if(!sv.equals(vertify.trim()))
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"ConfirmCodeError"),"UTF-8") + "&nexturl=" + errurl);
                    return;
                }
            }

            String s1 = request.getParameter("Password"); //密码
            String nu = request.getParameter("nexturl"); //连接

            RV rv = new RV(LoginId);
            //判断用户名和密码
            if(!Profile.isPassword(rv._strV,s1)) // lt,
            {
                if(teasession._strCommunity.equals("bigpic"))
                {
                    errurl = "/servlet/Folder?node=2198284&language=1";
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("会员ID和密码不匹配。（您提供的会员ID为" + LoginId + "）","UTF-8") + "&nexturl=" + errurl);
                } else
                {
                    // response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"InvalidPassword"),"UTF-8") + "&nexturl=" + errurl);
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"您填写的用户名或密码错误,请重新填写."),"UTF-8") + "&nexturl=" + errurl);
                }
                return;
            }
            //判断key盘 是否绑定

            String serialnum = teasession.getParameter("serialnum");

            if(serialnum != null && serialnum.length() > 0 && !"webmaster".equals(LoginId))
            {
                ProfileBBS pbobj = ProfileBBS.find(teasession._strCommunity,LoginId);
                if(!ProfileBBS.isKey(teasession._strCommunity,LoginId,serialnum))
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"您所使用的KEY盘没有绑定用户【" + LoginId + "】,请重填写!"),"UTF-8") + "&nexturl=" + errurl);
                    return;
                }
            }

            Logs.create(teasession._strCommunity,rv,1,teasession._nNode,request.getRemoteAddr());

            OnlineList ol_obj = OnlineList.find(session.getId());

            ol_obj.setMember(LoginId);

            //
            Profile p = Profile.find(LoginId);
            Cookie cs = new Cookie("tea.RV",java.net.URLEncoder.encode(LoginId + "," + SMS.md5(String.valueOf(p.getTime().getTime())),"UTF-8"));
            cs.setPath("/");
            String sn = request.getServerName();
            int j = sn.indexOf(".");
            if(j != -1 && sn.charAt(sn.length() - 1) > 96)
            {
                cs.setDomain(sn.substring(j));
            }
            response.addCookie(cs);
            //session.setAttribute("tea.RV", rv);

            //判断登录用户的角色是什么，来决定跳转
            tea.entity.admin.AdminUsrRole auobj = tea.entity.admin.AdminUsrRole.find(teasession._strCommunity,LoginId);
            if(auobj.getRole().indexOf("/377/") > -1) //是这个角色//票务员的
            {
                nu = "/jsp/admin/indextopVotes.jsp";
            } else
            {
                nu = "/jsp/admin/indextop.jsp";
            }

            ///////////////////////////////////////////////////////////

            response.sendRedirect(nu);
            return;

        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        } finally
        {
            out.close();
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("/tea/ui/node/type/sms/EditUser");
    }
}
