package tea.service.oasms;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import tea.service.*;
import tea.entity.member.*;

// OA 系统取子号码  由服务器自动生成  返回调用端   返回格式 为  子号&密码
public class GetSubNumber extends HttpServlet
{

        public GetSubNumber()
        {
        }

        public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
        {
                SMS sms = new SMS();
                // 企业
                int fincode = Integer.parseInt(request.getParameter("fincode"));
                String subcode = request.getParameter("subcode");
                String _strAssigncode = request.getParameter("assigncode");
                // 个人
                String password = request.getParameter("password");
                String tonumber = request.getParameter("tonumber");
                PrintWriter out = response.getWriter();
                SmsServices ss = new SmsServices();
                String msg = "";
                try
                {
                        SMSEnterprise se = SMSEnterprise.find(fincode);
                        if (password.equals(se.getPwd())) // 验证用户名密码
                        {
                                if (ss.getBalance(fincode, password) > 0)
                                {
                                        if ((_strAssigncode != null) && (!_strAssigncode.equals("")))
                                        {
                                                int assigncode = Integer.parseInt(_strAssigncode);
                                                if (ss.existSubNumber(assigncode))
                                                {
                                                        out.print("3"); // 指定的子号已存在
                                                        return;
                                                } else
                                                {
                                                        msg = ss.getSubNumber2(assigncode, fincode, tonumber);
                                                }
                                        } else if ((subcode == null) || subcode.equals(""))
                                        {
                                                msg = ss.getSubNumber(fincode, tonumber);
                                        } else
                                        {
                                                msg = ss.getSubNumber1(Integer.parseInt(subcode), fincode, tonumber);
                                        }
                                        // 余额减一
                                        se.setHits(1);
                                        // SMSEnterprise.find(fincode).getScode(),
                                        sms.send(1110, tonumber, "您的子号,密码分别为：" + msg, ""); // 发到手机
                                } else
                                {
                                        msg = "1"; // 余额不足
                                }
                        } else
                        {
                                msg = "2"; // 密码错误
                        }
                        out.print(msg);
                } catch (Exception ex)
                {
                        ex.printStackTrace();
                }
                out.close();
        }
}
