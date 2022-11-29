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

public class UpCardName extends TeaServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response) throws IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        String cid = teasession.getParameter("cid");
        int Icid = Integer.parseInt(cid);
        String cardName = request.getParameter("cardname");
        System.out.println(cardName);
        InCarteMethod icm = new InCarteMethod();
        try
        {
            icm.upCardName(Icid, cardName);
            response.sendRedirect("/jsp/profile/cartewarehouse.jsp?cardtypeid=1");
        } catch (IOException ex)
        {
            ex.getStackTrace();
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
