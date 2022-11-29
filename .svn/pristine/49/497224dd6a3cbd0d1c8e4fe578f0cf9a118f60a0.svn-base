package tea.ui.member.profile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import javax.servlet.ServletException;
import java.sql.SQLException;
import tea.entity.member.InCarteMethod;
import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServletResponse;
import tea.ui.TeaSession;
import tea.entity.member.Profile;
import tea.ui.TeaServlet;

public class DeleCarte extends TeaServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response) throws IOException
    {
        TeaSession teasession = new TeaSession(request);
        String[] checkBox = teasession.getParameterValues("oper");

        InCarteMethod  icm = new InCarteMethod();
        try
        {
           for(int i = 0; i < checkBox.length; i ++){
               int checkBoxValue = Integer.parseInt(checkBox[i]);
               icm.deleteCarte(checkBoxValue);
           }
           response.sendRedirect("/jsp/profile/receivecarte.jsp");
        }catch (SQLException ex)
        {
            ex.getStackTrace();
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
    }

}
