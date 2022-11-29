package tea.ui.member.profile;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Coupon;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class DeleteCoupon extends TeaServlet
{

    public DeleteCoupon()
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
            if (!teasession._rv.isAccountant())
            {
                response.sendError(403);
                return;
            }
            Coupon.find(Integer.parseInt(request.getParameter("Coupon"))).delete(teasession._nLanguage);
            response.sendRedirect("Coupons");
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }
}
