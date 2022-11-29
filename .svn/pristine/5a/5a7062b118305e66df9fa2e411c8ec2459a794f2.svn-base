package tea.ui.member.profile;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Coupon;
import tea.entity.member.CouponMember;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class DeleteCouponMember extends TeaServlet
{

    public DeleteCouponMember()
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
            int i = Integer.parseInt(request.getParameter("Coupon"));
            Coupon coupon = Coupon.find(i);
            if (!coupon.getMember().equals(teasession._rv._strR) || !teasession._rv.isAccountant())
            {
                response.sendError(403);
                return;
            }
            CouponMember.delete(i, request.getParameter("Member"));
            response.sendRedirect("CouponMembers?Coupon=" + i);
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }
}
