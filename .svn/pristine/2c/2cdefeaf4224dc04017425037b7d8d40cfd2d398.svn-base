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
 subcode:    企业号码;
 password:   密码；
 返回值：     剩余短信条数
 */

public class GetReverseCount extends HttpServlet
{

    public GetReverseCount()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {

            SmsServices ss = new SmsServices();
            int subcode = Integer.parseInt(request.getParameter("subcode"));
            String password = request.getParameter("password");
            PrintWriter out = response.getWriter();
            if (ss.validSub(subcode, password))
            {
                int i = ss.GetReverseCount(subcode, password); //取得回复选信条数
                out.println(i);
            } else
            {
                out.println(0);
            }
        } catch (Exception exception)
        {
            exception.printStackTrace();
        }
    }


}
