package tea.ui.node.type.account;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.node.*;
import tea.entity.*;

public class EditBargaining extends tea.ui.TeaServlet
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
            String account = request.getParameter("account");
            java.util.Date date = Entity.sdf.parse(request.getParameter("datetime"));
            float adopt = Float.parseFloat(request.getParameter("adopt"));
            float memory = Float.parseFloat(request.getParameter("memory"));
            float balance = Float.parseFloat(request.getParameter("balance"));
            String explain = request.getParameter("explain");
            Bargaining.create(account, date, adopt, memory, balance, explain);
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
        response.sendRedirect("/jsp/type/account/EditBargaining.jsp");
    }
}
