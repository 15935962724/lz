package tea.ui.node.type.account;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.node.*;
import tea.entity.*;

public class EditAccount extends tea.ui.TeaServlet
{
    //Initialize global variables
    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            String account = request.getParameter("account");
            int type = Integer.parseInt(request.getParameter("type"));
            int currency = Integer.parseInt(request.getParameter("currency"));
            float balance = Float.parseFloat(request.getParameter("balance"));
            float yearbenefit = Float.parseFloat(request.getParameter("yearbenefit"));
            int term = Integer.parseInt(request.getParameter("term"));
            java.util.Date maturity = Entity.sdf.parse(request.getParameter("maturity"));
            int states = Integer.parseInt(request.getParameter("states"));
            Account.create(account, type, currency, balance, yearbenefit, term, maturity, states);

            response.sendRedirect("/jsp/type/account/EditAccount.jsp");
        } catch (Exception ex)
        {
            ex.printStackTrace();
            response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(ex.getMessage(), "UTF-8"));
        }
    }

    //Clean up resources
    public void destroy()
    {
    }
}
