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
import tea.entity.member.*;

/* 发送短信服务
 参数说明：
 message ： 要发送的消息
 tonumber:  目标手机号
 fincode:   企业号码;
 finpassword:  密码；
 subcode:   企业号码;
 subpassword:  密码；
 */
public class Send extends HttpServlet
{
    public Send()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        // 企业
        int fincode = Integer.parseInt(request.getParameter("fincode"));
        String pwd = request.getParameter("finpassword");
        // 子号
        int subcode = Integer.parseInt(request.getParameter("subcode"));
        String subpassword = request.getParameter("subpassword");

        String tonumber = request.getParameter("tonumber");
        String msg = request.getParameter("message");

        SMS sms = new SMS();
        System.out.println("企业号" + fincode + "/" + pwd + " 子号:" + subcode + "/" + subpassword + " 短信:" + tonumber + "/" + msg);
        PrintWriter out = response.getWriter();
        SmsServices ss = new SmsServices();
        String rs = "1/出现错误/0/" + tonumber + "/0";
        try
        {
            SMSEnterprise se = SMSEnterprise.find(fincode);
            if (pwd.equals(se.getPwd()) && ss.validSub(subcode, subpassword)) // 验证用户名密码
            {
                rs = sms.send(subcode, tonumber, msg, "");
                System.out.println("发送结果:" + tonumber + "\t" + rs);

                String s[] = rs.split("/");
                int hits = Integer.parseInt(s[2]);
                se.setHits(hits);
            }
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
        out.print(rs);
        out.close();
    }
}
