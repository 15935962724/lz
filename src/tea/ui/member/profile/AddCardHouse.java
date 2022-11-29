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

public class AddCardHouse extends TeaServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response) throws IOException
   {
       request.setCharacterEncoding("UTF-8");
       TeaSession teasession = new TeaSession(request);
       String cardName = teasession.getParameter("cardname");
       InCarteMethod  icm = new InCarteMethod();
       try
       {
           String name = teasession._rv._strV;
           icm.addCard(cardName,name);
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
