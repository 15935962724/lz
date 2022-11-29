package tea.ui.member.profile;

import tea.entity.member.InCarteMethod;
import javax.servlet.ServletConfig;
import java.io.IOException;
import javax.servlet.ServletException;
import tea.ui.TeaSession;
import java.sql.SQLException;
import tea.ui.TeaServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpLocation extends TeaServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response) throws IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        String[] checkBox = teasession.getParameterValues("oper2");
        String cardtypeid1 = request.getParameter("cardtypeid");

        String cartypeid = teasession.getParameter("oper1");
        int Icartypeid = Integer.parseInt(cartypeid);
        InCarteMethod icm = new InCarteMethod();
        try
        {
            for(int i = 0; i < checkBox.length; i ++){
                int Icid = Integer.parseInt(checkBox[i]);
                icm.upLocation(Icartypeid, Icid);

            }
            response.sendRedirect("/jsp/profile/cartewarehouse.jsp?cardtypeid=" + cardtypeid1);
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
