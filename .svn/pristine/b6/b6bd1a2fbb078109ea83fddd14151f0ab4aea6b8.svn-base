package tea.service.oasms;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.service.SMS;
import tea.service.oasms.SmsServices;
import tea.entity.member.SMSProfile;

/* 设置手机回复短信
 参数说明：
 subcode:    子号;
 password:   密码；

 返回值  表格形式 字符串
 */

public class SetReverse extends HttpServlet
{

    public SetReverse()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            String subcode = request.getParameter("subcode");
            String password = request.getParameter("password");
 	    String autoreverse = request.getParameter("reverse");
            int auto=Integer.parseInt(autoreverse);
            //PrintWriter out=response.getWriter();
            SmsServices ss = new SmsServices();
            ss.setReverse(subcode, password,auto);
            ServletOutputStream servletoutputstream = response.getOutputStream();
            String s="1";
            byte abyte0[] = s.getBytes();
            response.setContentLength(abyte0.length);
            servletoutputstream.write(abyte0);
            servletoutputstream.close();

        } catch (Exception exception)
        {

            exception.printStackTrace();

        }
    }


}
