package tea.ui.member.profile;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.*;
import tea.db.*;
import tea.entity.member.*;

public class ProfileEnterpriseServlet extends HttpServlet
{

    // Initialize global variables
    public void init() throws ServletException
    {
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
            String member = teasession.getParameter("txtUserName");
            String community = teasession.getParameter("community");
            if (Profile.isExisted(member))
            {
                response.sendRedirect("/jsp/info/Alert.jsp?community=" + teasession._strCommunity + "&info=" + java.net.URLEncoder.encode("会员已存在.", "UTF-8"));
                return;
            }
            ProfileEnterprise pe = ProfileEnterprise.find(member, community);
            pe.setName(teasession.getParameter("txtMem_Name"));
            pe.setSynopsis(teasession.getParameter("txtComIntr"));
            pe.setProperty(teasession.getParameter("lstComType"));
            try
            {
                pe.setSize(Integer.parseInt(teasession.getParameter("lstSize")));
            } catch (NumberFormatException ex1)
            {
            }
            pe.setCalling(teasession.getParameter("lstIndustry"));
            pe.setLinkman(teasession.getParameter("txtLinkManName"));
            pe.setLinkmansex(!teasession.getParameter("rdoGender").equals("0"));
            pe.set();
            String pwd = teasession.getParameter("txtConPassword");
            String email = teasession.getParameter("txtEmail");
            String sn = request.getServerName() + ":" + request.getServerPort();
            Profile p = Profile.create(member, pwd, community, email, sn);
            p.setAddress(teasession.getParameter("txtAddress"), teasession._nLanguage);
            p.setWebPage(teasession.getParameter("txtMem_Url"), teasession._nLanguage);
            p.setFax(teasession.getParameter("txtFax"), teasession._nLanguage);
            p.setTelephone(teasession.getParameter("txtPhone"), teasession._nLanguage);
            p.setZip(teasession.getParameter("txtZipCode"), teasession._nLanguage);
            String nexturl = teasession.getParameter("nexturl");
            if (nexturl != null)
            {
                response.sendRedirect(nexturl);
            } else
            { // response.sendRedirect("/jsp/user/regsuccess.jsp");
                response.setContentType("text/html;charset=UTF-8");
                java.io.PrintWriter out = response.getWriter();
                out.println(new tea.html.Script("window.alert('您好,您的信息我们已收到,我们的市场人员会在两个工作日内与你取得联系!已确认你是否能够通过审核!谢谢您对我们信任与支持!');window.location.replace('" + request.getContextPath()
                                                + "/servlet/Node?node=" + teasession._nNode + "','_self')"));
                out.close();
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
