package tea.ui.node.type.stock;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.Node;
import tea.entity.node.Stock;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.db.DbAdapter;

public class DeleteStock extends TeaServlet
{

    public DeleteStock()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);

            int id = Integer.parseInt(teasession.getParameter("Stockid"));
            int listing = Integer.parseInt(teasession.getParameter("Listing"));
            int page = Integer.parseInt(teasession.getParameter("Page"));
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            /*DbAdapter dbadapter = new DbAdapter();
                         dbadapter.executeUpdate("delete from stock where id =" + id);
                         dbadapter.close();*/
            tea.entity.node.Stock stock = tea.entity.node.Stock.find(id);
            stock.delete();
            response.sendRedirect("Node?node=" + teasession._nNode + "&stocksearch=1&Listing=" + listing + "&Page=" + page);
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }

}
