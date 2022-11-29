package tea.ui.member.profile;

import tea.ui.TeaServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import tea.ui.TeaSession;
import tea.entity.member.Profile;
import tea.entity.member.InCarteMethod;
import java.sql.*;

public class InsertCarte extends TeaServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response) throws IOException
    {
        TeaSession teasession = new TeaSession(request);
        String member = teasession._rv._strV;
        String companyName = request.getParameter("comname");
        InCarteMethod  icm = new InCarteMethod();
        try
        {
            icm.insertCarte(member, companyName);

        }  catch (SQLException ex)
        {
            ex.getStackTrace();
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
    }

}
