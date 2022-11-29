package tea.ui.node.type.account;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import tea.entity.node.*;

public class EditNetPay extends tea.ui.TeaServlet
{
    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            String account = (request.getParameter("account"));
            float money = (Float.parseFloat(request.getParameter("money")));
            java.util.Date date = (tea.htmlx.TimeSelection.makeTime(request.getParameter("date")));
            NetPay.create(account, money, date);
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
        response.sendRedirect("/jsp/type/account/EditNetPay.jsp");
    }
}
