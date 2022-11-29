package tea.service.oasms;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServlet;
import tea.service.SMS;
/* OA 系统充值服务
参数说明：
fincode:    企业号码;
cardnumber: 卡号；
password:   充值密码；

*/

public class AddBalance extends HttpServlet
{

    public AddBalance()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        try
        {
     	 String fincode = request.getParameter("fincode");
         String cardnumber = request.getParameter("cardnumber");
         String password = request.getParameter("password");
         PrintWriter out=response.getWriter();
         //充值
		 out.println("0");

		}
        catch(Exception exception)
        {
          exception.printStackTrace();
        }
    }


}
