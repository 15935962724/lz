package tea.ui.member.order;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.member.Trade;
import tea.ui.TeaServlet;

public class TradeVVoice extends TeaServlet
{

    public TradeVVoice()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        try
        {
            Trade trade = Trade.find(Integer.parseInt(request.getParameter("Trade")));
            outStream(response, trade.getVVoice());
        }
        catch(Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }
}
