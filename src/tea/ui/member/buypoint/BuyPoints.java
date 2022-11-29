// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3)
// Source File Name:   BuyPoints.java

package tea.ui.member.buypoint;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.BuyPoint;
import tea.entity.member.BuyPointTitle;
import tea.html.*;
import tea.htmlx.Languages;
import tea.resource.Common;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class BuyPoints extends TeaServlet
{

    public BuyPoints()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            String s = request.getParameter("Operation");
            String s1 = request.getParameter("Vendor");
            if(s1 == null)
                s1 = "";
            int i = 0;
            try
            {
                i = Integer.parseInt(request.getParameter("BuyPointTitle"));
            } catch(Exception _ex)
            {}
            if(s == null)
                s = "";
            else
            if(s.equals("InputBuyPoint"))
            {
                response.sendRedirect("InputBuyPoint?BuyPointTitle=" + i);
                return;
            }
            PrintWriter printwriter = response.getWriter(); //beginOut(response, teasession);
            for(Enumeration enumeration = BuyPoint.findVendor(teasession._rv);enumeration.hasMoreElements();)
            {
                RV rv = (RV) enumeration.nextElement();
                Table table = new Table(r.getString(teasession._nLanguage,"Vendor") + ": " + rv._strR);
                table.setTitle(r.getString(teasession._nLanguage,"Currency") + "\n" + " &nbsp;" + "\n" + r.getString(teasession._nLanguage,"CurrentPoint") + "\n" + " &nbsp;" + "\n" + r.getString(teasession._nLanguage,"UsedPoint") + "\n");
                Row row;
                for(Enumeration enumeration2 = BuyPoint.find(rv,teasession._rv);enumeration2.hasMoreElements();table.add(row))
                {
                    int j = ((Integer) enumeration2.nextElement()).intValue();
                    BuyPoint buypoint = BuyPoint.find(j);
                    row = new Row(new Cell(new Text(r.getString(teasession._nLanguage,Common.CURRENCY[buypoint.getCurrency()]))));
                    Cell cell = new Cell(new Text(" &nbsp;"));
                    cell.setAlign(3);
                    row.add(cell);
                    Cell cell1 = new Cell(new Text(" " + buypoint.getCurrentPoint()));
                    cell1.setAlign(3);
                    row.add(cell1);
                    Cell cell3 = new Cell(new Text(" &nbsp;"));
                    cell3.setAlign(3);
                    row.add(cell3);
                    Cell cell5 = new Cell(new Text(" " + buypoint.getUsedPoint()));
                    cell5.setAlign(3);
                    row.add(cell5);
                }

                printwriter.print(table);
                Form form = new Form("foEdit" + rv._strR,"POST","BuyPoints");
                form.add(new HiddenField("Operation",""));
                form.add(new HiddenField("Vendor",rv._strR));
                DropDown dropdown = new DropDown("BuyPointTitle","");
                dropdown.addOption(0,"***********");
                int l;
                String s2;
                for(Enumeration enumeration4 = BuyPointTitle.find(rv._strR);enumeration4.hasMoreElements();dropdown.addOption(l,s2))
                {
                    l = ((Integer) enumeration4.nextElement()).intValue();
                    BuyPointTitle buypointtitle = BuyPointTitle.find(l);
                    s2 = buypointtitle.getTitle();
                }

                form.add(new Text(dropdown.toString()));
                form.add(new Anchor("javascript:document.foEdit" + rv._strR + ".Operation.value='Edit';foEdit" + rv._strR + ".submit();",r.getString(teasession._nLanguage,"GetPoints")));
                if(teasession._rv._strR.equals(rv._strR))
                {
                    form.add(new Anchor("javascript:document.foEdit" + rv._strR + ".Operation.value='InputBuyPoint';foEdit" + rv._strR + ".submit();",r.getString(teasession._nLanguage,"InputPoints")));
                    form.add(new Anchor("EditBuyPointTitle","_blank",r.getString(teasession._nLanguage,"NewCommodity")));
                }
                printwriter.print(form);
                if(s1.equals(rv._strR) && i != 0)
                {
                    Form form1 = new Form("foEdit" + rv._strR + rv._strV,"POST","ConvertBuyPoint");
                    form1.add(new HiddenField("RVendor",rv._strR));
                    form1.add(new HiddenField("VVendor",rv._strV));
                    BuyPointTitle buypointtitle1 = BuyPointTitle.find(i);
                    Table table2 = new Table("<font>" + r.getString(teasession._nLanguage,"Vendor") + ": " + rv._strR + " - " + buypointtitle1.getTitle() + "</font>");
                    if(buypointtitle1.getAccountTitle().length() != 0)
                    {
                        Row row2 = new Row(new Cell(new Text("<font>" + buypointtitle1.getAccountTitle() + ":</font>"),true));
                        Cell cell8 = new Cell();
                        cell8.add(new TextField("Account","",20,255));
                        row2.add(cell8);
                        table2.add(row2);
                    } else
                    {
                        form1.add(new HiddenField("Account",""));
                    }
                    if(buypointtitle1.getPasswordTitle().length() != 0)
                    {
                        Row row3 = new Row(new Cell(new Text("<font>" + buypointtitle1.getPasswordTitle() + ":</font>"),true));
                        Cell cell9 = new Cell();
                        cell9.add(new TextField("Password","",20,255));
                        row3.add(cell9);
                        table2.add(row3);
                    } else
                    {
                        form1.add(new HiddenField("Password",""));
                    }
                    if(buypointtitle1.getOtherIDTitle().length() != 0)
                    {
                        Row row4 = new Row(new Cell(new Text("<font>" + buypointtitle1.getOtherIDTitle() + ":</font>"),true));
                        Cell cell10 = new Cell();
                        cell10.add(new TextField("OtherID","",20,255));
                        row4.add(cell10);
                        table2.add(row4);
                    } else
                    {
                        form1.add(new HiddenField("OtherID",""));
                    }
                    form1.add(table2);
                    form1.add(new Button(r.getString(teasession._nLanguage,"Submit")));
                    printwriter.print(form1);
                }
            }

            Table table1;
            for(Enumeration enumeration1 = BuyPoint.findCustomer(teasession._rv);enumeration1.hasMoreElements();printwriter.print(table1))
            {
                RV rv1 = (RV) enumeration1.nextElement();
                table1 = new Table(r.getString(teasession._nLanguage,"Customer") + ": " + rv1._strR);
                table1.setTitle(r.getString(teasession._nLanguage,"Currency") + "\n" + " &nbsp;" + "\n" + r.getString(teasession._nLanguage,"CurrentPoint") + "\n" + " &nbsp;" + "\n" + r.getString(teasession._nLanguage,"UsedPoint") + "\n");
                Row row1;
                for(Enumeration enumeration3 = BuyPoint.find(teasession._rv,rv1);enumeration3.hasMoreElements();table1.add(row1))
                {
                    int k = ((Integer) enumeration3.nextElement()).intValue();
                    BuyPoint buypoint1 = BuyPoint.find(k);
                    row1 = new Row(new Cell(new Text(r.getString(teasession._nLanguage,Common.CURRENCY[buypoint1.getCurrency()]))));
                    Cell cell2 = new Cell(new Text(" &nbsp;"));
                    cell2.setAlign(3);
                    row1.add(cell2);
                    Cell cell4 = new Cell(new Text(" " + buypoint1.getCurrentPoint()));
                    cell4.setAlign(3);
                    row1.add(cell4);
                    Cell cell6 = new Cell(new Text(" &nbsp;"));
                    cell6.setAlign(3);
                    row1.add(cell6);
                    Cell cell7 = new Cell(new Text(" " + buypoint1.getUsedPoint()));
                    cell7.setAlign(3);
                    row1.add(cell7);
                }

            }

            printwriter.print(new Languages(teasession._nLanguage,request));
            printwriter.close(); //printwriter.close();
            return;
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        r.add("tea/ui/member/buypoint/BuyPoints").add("tea/ui/node/type/buy/EditBuyPrice").add("tea/ui/member/offer/Offers");
    }
}
