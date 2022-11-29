// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   stock.java

package tea.ui.node.listing;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.db.DbAdapter;
import java.sql.SQLException;
import tea.htmlx.TimeSelection;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class stock extends TeaServlet
{

    public stock()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            String s = teasession.getParameter("OpeningPrice_cnoochk");
            String s1 = teasession.getParameter("High_cnoochk");
            String s2 = teasession.getParameter("Low_cnoochk");
            String s3 = teasession.getParameter("ClosingPrice_cnoochk");
            String s4 = teasession.getParameter("PerChange_cnoochk");
            String s5 = teasession.getParameter("Volume_cnoochk");
            String s6 = teasession.getParameter("OpeningPrice_cnoocny");
            String s7 = teasession.getParameter("High_cnoocny");
            String s8 = teasession.getParameter("Low_cnoocny");
            String s9 = teasession.getParameter("ClosingPrice_cnoocny");
            String s10 = teasession.getParameter("PerChange_cnoocny");
            String s11 = teasession.getParameter("Volume_cnoocny");
            String s12 = teasession.getParameter("OpeningPrice_cnoocshk");
            String s13 = teasession.getParameter("High_cnoocshk");
            String s14 = teasession.getParameter("Low_cnoocshk");
            String s15 = teasession.getParameter("ClosingPrice_cnoocshk");
            String s16 = teasession.getParameter("PerChange_cnoocshk");
            String s17 = teasession.getParameter("Volume_cnoocshk");
            String s18 = teasession.getParameter("OpeningPrice_hgcash");
            String s19 = teasession.getParameter("High_hgcash");
            String s20 = teasession.getParameter("Low_hgcash");
            String s21 = teasession.getParameter("ClosingPrice_hgcash");
            String s22 = teasession.getParameter("PerChange_hgcash");
            String s23 = teasession.getParameter("Volume_hgcash");
            float f = Float.parseFloat(s);
            float f1 = Float.parseFloat(s1);
            float f2 = Float.parseFloat(s2);
            float f3 = Float.parseFloat(s3);
            float f4 = Float.parseFloat(s4);
            int i = Integer.parseInt(s5);
            float f5 = Float.parseFloat(s6);
            float f6 = Float.parseFloat(s7);
            float f7 = Float.parseFloat(s8);
            float f8 = Float.parseFloat(s9);
            float f9 = Float.parseFloat(s10);
            int j = Integer.parseInt(s11);
            float f10 = Float.parseFloat(s12);
            float f11 = Float.parseFloat(s13);
            float f12 = Float.parseFloat(s14);
            float f13 = Float.parseFloat(s15);
            float f14 = Float.parseFloat(s16);
            int k = Integer.parseInt(s17);
            float f15 = Float.parseFloat(s18);
            float f16 = Float.parseFloat(s19);
            float f17 = Float.parseFloat(s20);
            float f18 = Float.parseFloat(s21);
            float f19 = Float.parseFloat(s22);
            int l = Integer.parseInt(s23);
            java.util.Date date = TimeSelection.makeTime(teasession.getParameter("Issue1Year"), teasession.getParameter("Issue1Month"), teasession.getParameter("Issue1Day"));
            java.util.Date date1 = TimeSelection.makeTime(teasession.getParameter("Issue2Year"), teasession.getParameter("Issue2Month"), teasession.getParameter("Issue2Day"));
            java.util.Date date2 = TimeSelection.makeTime(teasession.getParameter("Issue3Year"), teasession.getParameter("Issue3Month"), teasession.getParameter("Issue3Day"));
            java.util.Date date3 = TimeSelection.makeTime(teasession.getParameter("Issue4Year"), teasession.getParameter("Issue4Month"), teasession.getParameter("Issue4Day"));
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeUpdate("insert into stock(stockid,stockname,openingprice,date,high,low,closingprice,percentchange,volume,estockname) values ('ceon'," + DbAdapter.cite("0883.HK \u4E2D\u6D77\u6CB9\u9999\u6E2F") + "," + f + "," + DbAdapter.cite(date) + "," + f1 + "," + f2 + "," + f3 + "," + f4 + "," + i + ",'0883.HK CNOOCLTD. HONGKONG')");
                db.executeUpdate("insert into stock(stockid,stockname,openingprice,date,high,low,closingprice,percentchange,volume,estockname) values ('600583ss'," + DbAdapter.cite("CEO.N \u4E2D\u6D77\u6CB9 \u7EBD\u7EA6") + "," + f5 + "," + DbAdapter.cite(date1) + "," + f6 + "," + f7 + "," + f8 + "," + f9 + "," + j + ",'CEO.N CNOOCLTD. NEWYORK')");
                db.executeUpdate("insert into stock(stockid,stockname,openingprice,date,high,low,closingprice,percentchange,volume,estockname) values ('2883hk'," + DbAdapter.cite("600583.SS \u6D77\u6CB9\u5DE5\u7A0BA\u80A1") + "," + f10 + "," + DbAdapter.cite(date2) + "," + f11 + "," + f12 + "," + f13 + "," + f14 + "," + k + ",'600583.SS CNOOC Engineering Ltd. SHANGHAI')");
                db.executeUpdate("insert into stock(stockid,stockname,openingprice,date,high,low,closingprice,percentchange,volume,estockname) values ('0883hk'," + DbAdapter.cite("2883.HK \u4E2D\u6D77\u6CB9\u7530\u670D\u52A1") + "," + f15 + "," + DbAdapter.cite(date3) + "," + f16 + "," + f17 + "," + f18 + "," + f19 + "," + l + ",'2883.HK COSL HONGKONG')");
            }
            catch(Exception exception1)
            {
                throw new SQLException(exception1.toString());
            }
            finally
            {
                db.close();
            }
            response.sendRedirect("Node?node=" + teasession._nNode + "&stockinput=1&Listing=" + teasession.getParameter("Listing"));
        }
        catch(Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }
}
