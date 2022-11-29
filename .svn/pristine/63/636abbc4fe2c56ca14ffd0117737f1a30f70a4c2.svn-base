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

public class DeleCarte1 extends TeaServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response) throws IOException
   {
       TeaSession teasession = new TeaSession(request);
       String[] checkBox = teasession.getParameterValues("oper2");
       InCarteMethod  icm = new InCarteMethod();
       try
       {
          for(int i = 0; i < checkBox.length; i ++){
              int checkBoxValue = Integer.parseInt(checkBox[i]);
              icm.deleteCarte(checkBoxValue);
          }
          response.sendRedirect("/jsp/profile/cartewarehouse.jsp?cardtypeid="+request.getParameter("cardtypeid"));
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
