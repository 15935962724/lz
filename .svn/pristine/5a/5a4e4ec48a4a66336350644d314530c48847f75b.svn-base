package tea.ui.member.sms;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.TeaServlet;
import tea.entity.member.*;

public class EditSMSEnterprise extends TeaServlet
{
    //Initialize global variables
    public void init() throws ServletException
    {
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            String community = request.getParameter("community");

            int code = Integer.parseInt(request.getParameter("code"));
            SMSEnterprise se = SMSEnterprise.find(code);

            if (request.getParameter("smsenterprise") != null) //充值
            {
                int smsenterprise = Integer.parseInt(request.getParameter("smsenterprise"));
                java.math.BigDecimal balance = new java.math.BigDecimal(request.getParameter("balance"));
//                java.math.BigDecimal price = new java.math.BigDecimal(request.getParameter("price"));
                se.setBalance(balance); //企业中的充值金额
                SMSEnterprise2.create(code, balance);
                response.sendRedirect("/jsp/sms/SMSEnterprise2.jsp?community=" + community + "&Node=" + teasession._nNode + "&code=" + code);
            } else //创建企业
            {
                if (request.getParameter("delete") != null)
                {
                    se.delete();
                } else
                {
                    String pwd = request.getParameter("pwd");
                    String scode = request.getParameter("scode");
                    String name = request.getParameter("name");
                    se.set(pwd, scode,name);
                }
                response.sendRedirect("/jsp/sms/SMSEnterprise.jsp?community=" + community + "&Node=" + teasession._nNode);
            }
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }

    //Clean up resources
    public void destroy()
    {
    }
}
