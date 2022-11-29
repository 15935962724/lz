package tea.ui.node.type.smsd; //tea.ui.node.type.sms;

import java.io.*;
import java.util.Date;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.db.DbAdapter;
import tea.entity.RV;
import tea.entity.node.*;
import tea.entity.site.License;
import tea.entity.site.TypeAlias;
import tea.html.*;
import tea.htmlx.*;
import tea.http.MultipartRequest;
import tea.resource.Common;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class deleteSubscribe extends TeaServlet
{

    public deleteSubscribe()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);

            String mobile = teasession.getParameter("mobile");
            String password = teasession.getParameter("password");

            int k2 = Integer.parseInt(teasession.getParameter("subcribe"));

            Sms Sms = new Sms();
            Sms.deleteSubcribe(mobile, password, k2);

        } catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/node/type/sms/EditSubscribe");
    }
}
