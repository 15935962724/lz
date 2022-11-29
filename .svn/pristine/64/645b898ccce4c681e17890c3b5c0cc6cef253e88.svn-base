package tea.ui.member.profile;
import tea.ui.TeaServlet;
import tea.entity.node.Caller;
import java.io.UnsupportedEncodingException;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletException;
import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServletResponse;
import tea.ui.TeaSession;
public class auditcaller extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws UnsupportedEncodingException, IOException
     {
          request.setCharacterEncoding("UTF-8");
          TeaSession teasession = new TeaSession(request);
          String member = teasession.getParameter("member");
          String  password =teasession.getParameter("password");
          String mobile =teasession.getParameter("mobile");
          String site =teasession.getParameter("site");
          String firstname =teasession.getParameter("firstname");
          int  sex = Integer.parseInt( teasession.getParameter("sex"));
          int cardtype = Integer.parseInt( teasession.getParameter("cardtype"));
          System.out.println("member " +member+" password "+password+" telephone "+mobile+" site "+site+" firstname "+firstname);
          String card = teasession.getParameter("card");
          try
          {
               Caller.update(member,teasession._nLanguage,site,password,mobile,firstname,sex,teasession._strCommunity,cardtype,card);
               response.sendRedirect("/jsp/registration/caller.jsp?member="+java.net.URLEncoder.encode(member,"UTF-8"));
          }catch(Exception ex)
          {
             System.out.print( ex.toString());
             response.sendRedirect("/jsp/info/Succeed.jsp?info=" + "Error!");
          }
      }
      public void init(ServletConfig servletconfig) throws ServletException
      {
          super.init(servletconfig);
      }

}
