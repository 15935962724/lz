package tea.service.oasms;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServlet;
import tea.service.SMS;
import tea.service.oasms.SmsServices;

/* OA 系统充值服务
 参数说明：
 fincode:    企业号码;
 password:   密码；
 返回值：     剩余短信条数
 */

public class GetBalance extends HttpServlet
{

    public GetBalance()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            int fincode = Integer.parseInt(request.getParameter("fincode"));
            String password = request.getParameter("password");
            PrintWriter out = response.getWriter();
            //取得剩余选信条数
            SmsServices ss = new SmsServices();
            int i = ss.getBalance(fincode, password);
            out.println(i);

        } catch (Exception exception)
        {
            exception.printStackTrace();
        }
    }


}
