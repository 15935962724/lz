package tea.ui.node.type.buy;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.BuyPrice;
import tea.entity.node.Node;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class DeleteBuyPrice extends TeaServlet
{

    public DeleteBuyPrice()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            tea.entity.node.Node node = tea.entity.node.Node.find(teasession._nNode);
            if (teasession._rv == null)
            {
                if ((node.getOptions1() & 1) == 0)
                {
                    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                    return;
                }
            } else
            {
                tea.entity.node.AccessMember obj_am = tea.entity.node.AccessMember.find(node._nNode, teasession._rv.toString());
                if (!node.isCreator(teasession._rv) && !obj_am.isProvider(node.getType()))
                {
                    response.sendError(403);
                    return;
                }
            }
            int commodity = Integer.parseInt(request.getParameter("commodity"));
            BuyPrice buyprice = BuyPrice.find(Integer.parseInt(request.getParameter("commodity")), Integer.parseInt(request.getParameter("Currency")));
            buyprice.delete();
            response.sendRedirect("/jsp/type/buy/BuyPrices.jsp?node=" + teasession._nNode + "&commodity=" + commodity);
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }
}
