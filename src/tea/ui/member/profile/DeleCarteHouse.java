package tea.ui.member.profile;

import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletException;
import java.sql.SQLException;
import javax.servlet.ServletConfig;
import tea.entity.member.InCarteMethod;
import javax.servlet.http.HttpServletResponse;
import tea.ui.TeaSession;
import tea.ui.TeaServlet;

public class DeleCarteHouse extends TeaServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response) throws IOException
    {
        TeaSession teasession = new TeaSession(request);
        String radio = teasession.getParameter("oper1");
        InCarteMethod icm = new InCarteMethod();
        try
        {


                int intRadio = Integer.parseInt(radio);
                icm.delCarteHouse(intRadio);

            response.sendRedirect("/jsp/profile/cartewarehouse.jsp?cardtypeid=1");
        } catch (SQLException ex)
        {
            ex.getStackTrace();
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
    }

}
