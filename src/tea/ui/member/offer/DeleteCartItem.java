package tea.ui.member.offer;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.node.Buy;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class DeleteCartItem extends TeaServlet
{

    public DeleteCartItem()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            Buy buy = Buy.find(Integer.parseInt(request.getParameter("CartItem")));
            RV rv;
            if (buy.getStatus() == Buy.BUY_PENDING_BG) //后台添加的商品
            {
                String member = request.getParameter("member");
                rv = new RV(member);
            } else
            {
                rv = teasession._rv;
            }
            if (!rv.equals(buy.getMember()))
            {
                response.sendError(403);
                return;
            }
            buy.delete();
            String nexturl = request.getParameter("nexturl");
            if (nexturl == null)
            {
                nexturl = "ShoppingCarts";
            }
            response.sendRedirect(nexturl);
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }
}
