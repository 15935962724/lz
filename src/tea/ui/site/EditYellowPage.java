package tea.ui.site;

import tea.ui.TeaServlet;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;
import tea.ui.TeaSession;
import java.text.*;

public class EditYellowPage extends TeaServlet
{

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
            if (!tea.entity.site.License.getInstance().getWebMaster().equals(teasession._rv._strR))
            {
                response.sendError(403);
                return;
            }
            String member = request.getParameter("member");
            String brokage = request.getParameter("brokage");
            String act = request.getParameter("act");
            if ("del".equals(act))
            {
                tea.entity.site.YellowPageBrokage ypb = tea.entity.site.YellowPageBrokage.find(member, brokage);
                ypb.delete();
            } else
            {
                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
                java.util.Date time = null;
                try
                {
                    time = sdf.parse(request.getParameter("time"));
                } catch (ParseException ex)
                {
                }
                java.util.Date nextTime = null;
                try
                {
                    nextTime = sdf.parse(request.getParameter("nexttime"));
                } catch (ParseException ex)
                {
                }
                java.math.BigDecimal price = null;
                try
                {
                    price = new java.math.BigDecimal(request.getParameter("price"));
                } catch (Exception ex1)
                {
                }
                tea.entity.site.YellowPage yp = tea.entity.site.YellowPage.find(member);
                yp.set(request.getParameterValues("domain"), Integer.parseInt(request.getParameter("states")), time, price, nextTime, request.getParameter("mailid"), request.getParameter("mailpw"));
                if (brokage.length() > 0)
                {
                    tea.entity.site.YellowPageBrokage ypb = tea.entity.site.YellowPageBrokage.find(member, brokage);
                    java.math.BigDecimal brokage_price = null;
                    try
                    {
                        brokage_price = new java.math.BigDecimal(request.getParameter("brokage_price"));
                    } catch (Exception ex1)
                    {
                    }
                    java.math.BigDecimal brokage_pay = null;
                    try
                    {
                        brokage_pay = new java.math.BigDecimal(request.getParameter("brokage_pay"));
                    } catch (Exception ex1)
                    {
                    }
                    int brokage_states = Integer.parseInt(request.getParameter("brokage_states"));
                    ypb.set(brokage_pay, brokage_states, brokage_price);
                }
            }
            response.sendRedirect("/jsp/site/EditYellowPage.jsp?member=" + member);
        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }
}
