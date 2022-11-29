// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   TradeCVoice.java

package tea.ui.member.order;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.member.Trade;
import tea.ui.TeaServlet;

public class TradeCVoice extends TeaServlet
{

    public TradeCVoice()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        try
        {
            Trade trade = Trade.find(Integer.parseInt(request.getParameter("Trade")));
            outStream(response, trade.getCVoice());
        }
        catch(Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }
}
