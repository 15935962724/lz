package tea.ui.node.type.sms;

import java.io.*;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import tea.db.DbAdapter;
import tea.resource.Common;
import tea.resource.Resource;
import tea.ui.TeaServlet;

public class EditUser extends TeaServlet
{
	public EditUser()
	{
	}

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            HttpSession httpsession = request.getSession(true);
            String PhoneNumber = request.getParameter("PhoneNumber");
            String RealName = request.getParameter("RealName");
            String NickName = request.getParameter("NickName");
            String Email = request.getParameter("Email");
            int IDType = Integer.parseInt(request.getParameter("IDType"));
            String IDNumber = request.getParameter("IDNumber");
            int ad = 0;

            if (request.getParameter("checkbox") != null)
            {
                ad = 1;
            }

            DbAdapter dbadapter = new DbAdapter();
            try
            {
        			dbadapter.executeUpdate("INSERT INTO SMSuser(phonenumber,realname,nickname,email,idtype,idnumber,ad,password)VALUES("+
        					DbAdapter.cite(PhoneNumber) + ", " + DbAdapter.cite(RealName) + ", " + DbAdapter.cite(NickName) + ", " + DbAdapter.cite(Email) + ", " + IDType + ", " + DbAdapter.cite(IDNumber) + ", " + ad+")");

                response.sendRedirect("/sms/login/regsuccess.htm");

            } catch (Exception exception)
            {
                response.sendRedirect("/sms/login/loginerror3.htm");

            } finally
            {
                dbadapter.close();
            }

        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }

	public void init(ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
	}
}
