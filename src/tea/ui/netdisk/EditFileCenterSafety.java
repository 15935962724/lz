package tea.ui.netdisk;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

import tea.db.DbAdapter;
import tea.entity.admin.*;
import tea.ui.*;
import tea.entity.netdisk.*;
import java.sql.SQLException;
import tea.entity.netdisk.*;

public class EditFileCenterSafety extends TeaServlet
{
  public void init(ServletConfig servletconfig) throws ServletException
  {
    super.init(servletconfig);
  }

  //Process the HTTP Get request
  public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
  {
    request.setCharacterEncoding("UTF-8");
    TeaSession teasession = new TeaSession(request);
    if (teasession._rv == null)
    {
      response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(request.getHeader("referer"), "UTF-8"));
      return;
    }
    String act = request.getParameter("act");
    int filecenter = Integer.parseInt(request.getParameter("filecenter"));
    try
    {
      if ("edit".equals(act))
      {
        int filecentersafety = Integer.parseInt(request.getParameter("filecentersafety"));
        int purview = Integer.parseInt(request.getParameter("purview"));
        int style = Integer.parseInt(request.getParameter("style"));
        String role = request.getParameter("role");
        String unit = request.getParameter("unit");
        String member = request.getParameter("member");
        member = member.replaceAll("; ", "/");
        if (!member.startsWith("/"))
        {
          member = "/" + member;
        }
        if (filecentersafety == 0)
        {
          FileCenterSafety.create(teasession._strCommunity, filecenter, style, purview, role, unit, member);
        } else
        {
          FileCenterSafety obj = FileCenterSafety.find(filecentersafety);
          obj.set(style, purview, role, unit, member);
        }
      } else if ("delete".equals(act))
      {
        int filecentersafety = Integer.parseInt(request.getParameter("filecentersafety"));
        FileCenterSafety obj = FileCenterSafety.find(filecentersafety);
        obj.delete();
      } else if ("extend".equals(act))
      {
        FileCenter obj = FileCenter.find(filecenter);
        boolean extend = request.getParameter("extend") != null;
        obj.setExtend(extend);
      } else if ("reset".equals(act))
      {
        FileCenter obj = FileCenter.find(filecenter);
        String path = obj.getPath();
        DbAdapter db = new DbAdapter();
        try
        {
          db.executeUpdate("DELETE FROM FileCenterSafety WHERE community=" + db.cite(teasession._strCommunity) + " AND filecenter IN( SELECT filecenter FROM FileCenter WHERE path LIKE " + db.cite(path + "_%") + " )");
          db.executeUpdate("UPDATE FileCenter SET extend=1 WHERE community=" + db.cite(teasession._strCommunity) + " AND path LIKE " + db.cite(path + "_%"));
        } finally
        {
          db.close();
        }
        FileCenter._cache.clear();
      }
    } catch (SQLException ex)
    {
      ex.printStackTrace();
    }
    response.sendRedirect("/jsp/netdisk/FileCenterSafetys.jsp?community=" + teasession._strCommunity + "&filecenter=" + filecenter);
  }

  //Clean up resources
  public void destroy()
  {
  }
}
