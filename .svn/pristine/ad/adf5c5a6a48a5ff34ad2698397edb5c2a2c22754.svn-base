package tea.service.oasms;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.service.SMS;
import tea.service.oasms.SmsServices;

/* 取得手机回复短信
 参数说明：
 subcode:    子号;
 password:   密码；

 返回值  表格形式 字符串
 */

public class GetReverse extends HttpServlet
{

    public GetReverse()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            int subcode = Integer.parseInt(request.getParameter("subcode"));
            String password = request.getParameter("password");
            //PrintWriter out=response.getWriter();
            SmsServices ss = new SmsServices();
            String s = ss.getReverse(subcode, password);
            ServletOutputStream servletoutputstream = response.getOutputStream();
            byte abyte0[] = s.getBytes();
            response.setContentLength(abyte0.length);
            servletoutputstream.write(abyte0);
            servletoutputstream.close();
            // out.println(ss.getReverse(subcode,password));
        } catch (Exception exception)
        {
            exception.printStackTrace();
        }
    }
}
