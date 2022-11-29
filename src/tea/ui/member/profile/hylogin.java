package tea.ui.member.profile;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import tea.ui.TeaServlet;
import tea.entity.member.Profile;
import javax.servlet.http.HttpSession;

public class hylogin extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws UnsupportedEncodingException, IOException
    {
         request.setCharacterEncoding("UTF-8");
        //TeaSession teasession = new TeaSession(request);
        String member = request.getParameter("member");
        String password = request.getParameter("password");
        String password_1 = request.getParameter("password_1");
        try
        {
            if (password.equals(password_1) && member != null && member.length() > 0)
            {
                boolean check = Profile.isPassword(member, password);
                if (check)
                {
                    HttpSession session = request.getSession(true);
                    session.setAttribute("member", member);
                    session.setAttribute("password", password);
                    response.sendRedirect("/jsp/registration/login.jsp?member="+member);
                } else
                {
                    response.sendRedirect("/jsp/info/Succeed.jsp?info=" + "Member or Password Erorr!");
                }
            }
        }catch(Exception ex)
        {
               System.out.print(ex.toString());
               response.sendRedirect("/jsp/info/Succeed.jsp?info=" + "Erorr!");
        }
    }
    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
    }
}
