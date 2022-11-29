package tea.ui.member.profile;

import tea.ui.TeaServlet;
import javax.servlet.http.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import tea.entity.node.*;
import tea.ui.TeaSession;
import java.io.IOException;
import tea.entity.admin.*;
import tea.entity.*;
import tea.entity.member.*;
import java.sql.SQLException;

public class ApplyAdmin extends TeaServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response) throws IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        int language = teasession._nLanguage;
        String community = teasession.getParameter("community"); //teasession._strCommunity;
        String name = teasession.getParameter("firstname"); //公司名称
        String member = teasession.getParameter("member");
        String password = teasession.getParameter("password");
        String linkmanname = teasession.getParameter("linkmanname");
        String phone = teasession.getParameter("phone");
        String fax = teasession.getParameter("fax");
        String email = teasession.getParameter("email");
        String mobile = teasession.getParameter("mobile");
        String qq = teasession.getParameter("qq");
        String msn = teasession.getParameter("msn");
        String path = teasession.getParameter("path");
        int i = path.lastIndexOf(".");
        String exname;
        if (i != -1)
        {
            exname = path.substring(i).toLowerCase();
        } else
        {
            exname = ".gif";
        }

        if (qq == null || qq == "")
        {
            qq = "qq";
        }
        if (msn == null || msn == "")
        {
            msn = "msn";
        }
        try
        {
            int cardtype = Integer.parseInt(teasession.getParameter("cardtype"));
            String card = teasession.getParameter("card");
            String introduce = teasession.getParameter("introduce");
            byte by[] = teasession.getBytesParameter("picture");
            if (by == null)
            {
                return;
            }
            String documents = super.write(community, by, exname);
            int manage_type = Integer.parseInt(teasession.getParameter("manage_type"));
            String role = teasession.getParameter("role");
            Hotel_application hotel = new Hotel_application();
            if (teasession.getParameter("editadmin") != null)
            {
                hotel.set(member, language, password, name, linkmanname, phone, fax, email, mobile, qq, msn, cardtype, card, introduce, documents, manage_type, community);
                response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode("修改成功!<a href=/jsp/admin>酒店管理中心</a> ", "UTF-8"));
            } else
            {
                try
                       {
                           if (Hotel_application.isExist(member) || Profile.isExist(member, password)||Profile.isLExisted(member,teasession._nLanguage))
                           {
                               response.sendRedirect("/jsp/registration/applyadmin.jsp?has='has'");
                               return;
                           }
                       } catch (Exception ex)
                       {
                           ex.printStackTrace();
        }
                hotel.create(member, language, password, name, linkmanname, phone, fax, email, mobile, qq, msn, cardtype, card, introduce, documents, manage_type, community);
                // AdminUsrRole.create(community, member, "/" + role + "/", "/", 0, "/");//添加角色
                RV rv = new RV(member);
                HttpSession session = request.getSession(true);
                Logs.create(teasession._strCommunity, rv, 1, teasession._nNode, request.getRemoteAddr());
                OnlineList ol_obj = OnlineList.find(session.getId());
                ol_obj.setMember(member);
                session.setAttribute("tea.RV", rv);
                response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode("酒店管理员用户申请成功，请等待管理员审核！<a href=/jsp/admin>酒店管理中心</a> <a href=/servlet/Folder?node=2&language=1>返回首页</a>   ", "UTF-8"));
            }
            return;
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
    }
}
