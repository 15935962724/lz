package tea.ui.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.net.*;
import tea.ui.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.admin.*;
import tea.entity.member.*;
import tea.entity.node.*;
import tea.entity.site.*;


public class EditAdminList extends TeaServlet
{
  public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
  {
    request.setCharacterEncoding("UTF-8");
    TeaSession teasession = new TeaSession(request);
    if (teasession._rv == null)
    {
      response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
      return;
    }
    String nu = teasession.getParameter("nexturl");
    String member = teasession._rv._strV;
    String name = teasession.getParameter("name");
    String field = teasession.getParameter("field");
    try
    {
      AdminList al = AdminList.find(member, name);
      al.set(field);
    } catch (Exception ex)
    {
      ex.printStackTrace();
    }
    response.sendRedirect("/jsp/info/Succeed.jsp?nexturl=" + URLEncoder.encode(nu, "UTF-8"));
  }
}
