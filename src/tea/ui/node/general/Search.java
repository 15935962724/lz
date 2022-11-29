package tea.ui.node.general;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.Date;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import tea.entity.RV;
import tea.entity.node.*;
import tea.html.*;
import tea.htmlx.*;
import tea.http.MultipartRequest;
import tea.resource.Common;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class Search extends TeaServlet
{
    private Row getBuy(Node node, int i, int j) throws SQLException
    {
        Row row = new Row();
        Commodity.find(i);
        if ((node.getOptions() & 0x40000L) != 0)
        {
            int k = Node.find(node.getFather()).getFather();
            Node node1 = Node.find(k);
            String picture = node1.getPicture(j);
            if (picture != null && picture.length() > 0)
            {
                row.add(new Cell(new Anchor("Node?node=" + k, new Image(picture))));
            } else
            {
                row.add(new Cell());
            }
            Cell cell2 = new Cell(node1.getAnchor(j));
            if (node1.getType() == 12)
            {
                cell2.add(new Break());
                cell2.add(getAuthor(node1, k, 0, j));
                cell2.add(new Break());
                Book book = Book.find(k);
                String s = book.getPublisher(j);
                try
                {
                    int id = Integer.parseInt(s);
                    s = Node.find(id).getAnchor(j).toString();
                } catch (NumberFormatException ex)
                {
                }
                cell2.add(new Text(s));
            }
            row.add(cell2);
        } else
        {
            String picture = node.getPicture(j);
            if (picture != null && picture.length() > 0)
            {
                row.add(new Cell(new Anchor("Node?node=" + i, new Image(picture))));
            } else
            {
                row.add(new Cell());
            }
            Cell cell = new Cell(node.getAnchor(j));
            row.add(cell);
        }
        Cell cell1 = new Cell();
        int l = 0;
        for (Enumeration enumeration = BuyPrice.find(i); enumeration.hasMoreElements(); )
        {
            int i1 = ((Integer) enumeration.nextElement()).intValue();
            String s = super.r.getString(j, Common.CURRENCY[i1]);
            BuyPrice buyprice = BuyPrice.find(i, i1);
            BigDecimal bigdecimal = buyprice.getList();
            BigDecimal bigdecimal1 = buyprice.getPrice();
            if (l == 0)
            {
                cell1.add(new Text("<font>" + super.r.getString(j, "BuyPList") + ":" + s + bigdecimal + "</font>"));
            } else
            {
                cell1.add(new Text("<br><font>" + super.r.getString(j, "BuyPList") + ":" + s + bigdecimal + "</font>"));
            }
            cell1.add(new Text("<font> " + super.r.getString(j, "BuyPPrice") + ":" + s + bigdecimal1 + "</font>"));
            if (bigdecimal.compareTo(new BigDecimal(0.0D)) != 0)
            {
                cell1.add(new Text("<font> " + super.r.getString(j, "YouSave") + ":" + bigdecimal.subtract(bigdecimal1).divide(bigdecimal, 4).multiply(new BigDecimal(100D)) + "% </font>"));
            }
            l++;
        }
        row.add(cell1);
        return row;
    }

    private Row getBook(Node node, int i, int j) throws SQLException
    {
        Row row = new Row();
        String picture = node.getPicture(j);
        if (picture != null && picture.length() > 0)
        {
            row.add(new Cell(new Anchor("Node?node=" + i, new Image(picture))));
        } else
        {
            row.add(new Cell());
        }
        Cell cell = new Cell(node.getAnchor(j));
        cell.add(new Break());
        cell.add(getAuthor(node, i, 0, j));
        cell.add(new Break());
        Book book = Book.find(i);
        String s = book.getPublisher(j);
        try
        {
            int id = Integer.parseInt(s);
            s = Node.find(id).getAnchor(j).toString();
        } catch (NumberFormatException ex)
        {
        }
        cell.add(new Text(s));
        row.add(cell);
        Cell cell1 = new Cell();
        for (Enumeration enumeration = Node.findSons(i, null, 0, 10); enumeration.hasMoreElements(); cell1.add(new Break()))
        {
            int k = ((Integer) enumeration.nextElement()).intValue();
            Node node1 = Node.find(k);
            cell1.add(node1.getAnchor(j));
        }
        row.add(cell1);
        return row;
    }

    public Search()
    {
    }

    private Text getAuthor(Node node, int i, int j, int k) throws SQLException
    {
        Text text = new Text();
        Author author;
        for (Enumeration enumeration = Author.findByNodeType(i, j); enumeration.hasMoreElements(); )
        {
            int l = ((Integer) enumeration.nextElement()).intValue();
            author = Author.find(l);

            String s = author.getName(k);
            try
            {
                int id = Integer.parseInt(s);
                s = Node.find(id).getAnchor(k).toString();
            } catch (NumberFormatException ex)
            {
            }
            text.add(new Text(s));
        }
        return text;
    }

    private Row getDefault(Node node, int i, int j) throws SQLException
    {
        Row row = new Row();
        String picture = node.getPicture(j);
        if (picture != null && picture.length() > 0)
        {
            row.add(new Cell(new Anchor("Node?node=" + i, new Image(picture))));
        } else
        {
            row.add(new Cell());
        }
        Cell cell = new Cell(node.getAnchor(j));
        row.add(cell);
        row.add(new Cell());
        return row;
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            Node node = Node.find(teasession._nNode);
            String s = request.getParameter("SearchFor");
            String s1 = s;
            if (s == null)
            {
                s = "";
            } else
            {
                try
                {
                    s1 = new String(s.getBytes("ISO-8859-1"));
                } catch (Exception exception1)
                {
                }
            }
            int i = 0;
            int j = 0;
            String s2 = request.getParameter("MatchStyle");
            if (s2 != null)
            {
                i = Integer.parseInt(s2);
            }
            if (request.getParameter("MatchField1") != null)
            {
                j |= 1;
            }
            if (request.getParameter("MatchField2") != null)
            {
                j |= 2;
            }
            if (request.getParameter("MatchField4") != null)
            {
                j |= 4;
            }
            if (request.getParameter("MatchField16") != null)
            {
                j |= 0x10;
            }
            if (request.getParameter("MatchField32") != null)
            {
                j |= 0x20;
            }
            if (request.getParameter("MatchField64") != null)
            {
                j |= 0x40;
            }
            if (request.getParameter("MatchField8") != null)
            {
                j |= 8;
            }
            String s3 = request.getParameter("MatchField");
            if (s3 != null)
            {
                j = Integer.parseInt(s3);
            }
            int type = Integer.parseInt(request.getParameter("type"));
            int i1 = 0;
            String s5 = request.getParameter("CreatorStyle");
            if (s5 != null)
            {
                i1 = Integer.parseInt(s5);
            }
            String s6 = request.getParameter("Creator");
            if (s6 == null)
            {
                s6 = node.getCreator()._strR;
            }
            int j1 = 1;
            String s7 = request.getParameter("Area");
            if (s7 != null)
            {
                j1 = Integer.parseInt(s7);
            }
            int k1 = teasession._nNode;
            String s8 = request.getParameter("ThisTree");
            if (s8 != null)
            {
                k1 = Integer.parseInt(s8);
            }
            String s9 = request.getParameter("ThisCommunity");
            if (s9 == null)
            {
                s9 = node.getCommunity();
            }
            int l1 = 0;
            String s10 = request.getParameter("ByStyle");
            if (s10 != null)
            {
                l1 = Integer.parseInt(s10);
            }
            String s11 = request.getParameter("By");
            String s12 = request.getParameter("ByText");
            String s13 = "Search?SearchFor=" + URLEncoder.encode(s, "UTF-8") + "&Type=" + type + "&CreatorStyle=" + i1 + "&Creator=" + s6 + "&Area=" + j1 + "&ThisTree=" + k1 + "&ThisCommunity=" + s9 + "&ByStyle=" + l1;
            if (s11 != null)
            {
                s13 = s13 + "&By=" + s11;
            }
            if (s12 != null)
            {
                s13 = s13 + "&ByText=" + s12;
            }
            s13 = s13 + "&MatchStyle=" + i;
            s13 = s13 + "&MatchField=" + j;
            long l2 = System.currentTimeMillis() - 0x757b12c00L;
            String s14 = request.getParameter("StartTime");
            if (s14 != null)
            {
                l2 = Long.parseLong(s14);
            } else
            {
                try
                {
                    Date date = TimeSelection.makeTime(teasession.getParameter("StartYear"), teasession.getParameter("StartMonth"), teasession.getParameter("StartDay"), teasession.getParameter("StartHour"), teasession.getParameter("StartMinute"));
                    l2 = date.getTime();
                } catch (Exception exception2)
                {
                }
            }
            Date date1 = new Date(l2);
            long l3 = System.currentTimeMillis() + 0x757b12c00L;
            String s15 = request.getParameter("StopTime");
            if (s15 != null)
            {
                l3 = Long.parseLong(s15);
            } else
            {
                try
                {
                    Date date2 = TimeSelection.makeTime(teasession.getParameter("StopYear"), teasession.getParameter("StopMonth"), teasession.getParameter("StopDay"), teasession.getParameter("StopHour"), teasession.getParameter("StopMinute"));
                    l3 = date2.getTime();
                } catch (Exception exception3)
                {
                }
            }
            Date date3 = new Date(l3);
            s13 = s13 + "&StartTime=" + l2;
            s13 = s13 + "&StopTime=" + l3;
            String s16 = request.getParameter("Pos");
            int i2 = s16 == null ? 0 : Integer.parseInt(s16);
            String s17 = request.getParameter("TimeType");
            int j2 = s17 == null ? -1 : Integer.parseInt(s17);
            s13 = s13 + "&TimeType=" + j2;
            String s18 = request.getParameter("CreatorType");
            int k2 = s18 == null ? 0 : Integer.parseInt(s18);
            s13 = s13 + "&CreatorType=" + k2;
            String qs = request.getQueryString();
            qs = qs == null ? "" : "?" + qs;
            response.sendRedirect("/jsp/general/Search.jsp" + qs);
            PrintWriter printwriter = response.getWriter();
            printwriter.print(node.getAncestor(teasession._nLanguage, "Path"));
            Form form = new Form("foSearch", "POST", "Search");
            form.add(new HiddenField("Node", teasession._nNode));
            Table table = new Table();
            Row row = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "SearchFor") + ":"), true));
            Cell cell = new Cell(new TextField("SearchFor", s1, 50, 255));
            DropDown dropdown = new DropDown("MatchStyle", i);
            dropdown.addOption(0, super.r.getString(teasession._nLanguage, "MatchOnAllWords"));
            dropdown.addOption(1, super.r.getString(teasession._nLanguage, "MatchOnAnyWords"));
            dropdown.addOption(2, super.r.getString(teasession._nLanguage, "MatchExactPhase"));
            cell.add(dropdown);
            row.add(cell);
            table.add(row);
            Row row1 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Options") + ":"), true));
            Cell cell1 = new Cell();
            cell1.add(new CheckBox("MatchField1", (j & 1) != 0));
            cell1.add(new Text(super.r.getString(teasession._nLanguage, "Subject")));
            cell1.add(new CheckBox("MatchField2", (j & 2) != 0));
            cell1.add(new Text(super.r.getString(teasession._nLanguage, "Keywords")));
            cell1.add(new CheckBox("MatchField4", (j & 4) != 0));
            cell1.add(new Text(super.r.getString(teasession._nLanguage, "Briefing")));
            cell1.add(new CheckBox("MatchField16", (j & 0x10) != 0));
            cell1.add(new Text(super.r.getString(teasession._nLanguage, "Section")));
            cell1.add(new CheckBox("MatchField32", (j & 0x20) != 0));
            cell1.add(new Text(super.r.getString(teasession._nLanguage, "Talkback")));
            cell1.add(new CheckBox("MatchField64", (j & 0x40) != 0));
            cell1.add(new Text(super.r.getString(teasession._nLanguage, "ChatRoom")));
            cell1.add(new Text(" &nbsp;("));
            cell1.add(new CheckBox("MatchField8", (j & 8) != 0));
            cell1.add(new Text(super.r.getString(teasession._nLanguage, "FullTextSearch")));
            cell1.add(new Text(")"));
            row1.add(cell1);
            table.add(row1);
            Row row2 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Type") + ":"), true));
            row2.add(new Cell(new TypeSelection(teasession._strCommunity, teasession._nLanguage, type)));
            table.add(row2);
            Row row3 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Creator") + ":"), true));
            DropDown dropdown1 = new DropDown("CreatorStyle", i1);
            for (int i3 = 0; i3 < PickNode.CREATOR_STYLE.length; i3++)
            {
                dropdown1.addOption(i3, super.r.getString(teasession._nLanguage, PickNode.CREATOR_STYLE[i3]));
            }
            Cell cell2 = new Cell(dropdown1);
            cell2.add(new TextField("Creator", s6));
            DropDown dropdown2 = new DropDown("CreatorType", k2);
            dropdown2.addOption(0, super.r.getString(teasession._nLanguage, "NodeCreator"));
            dropdown2.addOption(1, super.r.getString(teasession._nLanguage, "Talkbacker"));
            dropdown2.addOption(2, super.r.getString(teasession._nLanguage, "Chater"));
            cell2.add(dropdown2);
            row3.add(cell2);
            table.add(row3);
            Row row4 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "From") + ":"), true));
            DropDown dropdown3 = new DropDown("Area", j1);
            dropdown3.addOption(0, super.r.getString(teasession._nLanguage, "ThisTree"));
            dropdown3.addOption(1, super.r.getString(teasession._nLanguage, "ThisCommunity"));
            dropdown3.addOption(2, super.r.getString(teasession._nLanguage, "AllCommunities"));
            Cell cell3 = new Cell(dropdown3);
            cell3.add(new TextField("ThisCommunity", s9));
            cell3.add(new TextField("ThisTree", k1));
            row4.add(cell3);
            table.add(row4);
            if (l1 != 0 && s11 != null && s12 != null)
            {
                form.add(new HiddenField("ByStyle", l1));
                form.add(new HiddenField("By", s11));
                form.add(new HiddenField("ByText", s12));
                Row row5 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, Node.SEARCH_BY[l1]) + ":"), true));
                row5.add(new Cell(new Text(s12)));
                table.add(row5);
            }
            Row row6 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "StartTime") + ":"), true));
            Cell cell4 = new Cell(new TimeSelection("Start", date1));
            row6.add(cell4);
            table.add(row6);
            Row row7 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "StopTime") + ":"), true));
            Cell cell5 = new Cell(new TimeSelection("Stop", date3));
            row7.add(cell5);
            table.add(row7);
            Row row8 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, " ") + " "), true));
            DropDown dropdown4 = new DropDown("TimeType", j2);
            dropdown4.addOption( -1, super.r.getString(teasession._nLanguage, "NoTimeLimit"));
            dropdown4.addOption(0, super.r.getString(teasession._nLanguage, "NodeCreateTime"));
            dropdown4.addOption(1, super.r.getString(teasession._nLanguage, "NewsIssueTime"));
            dropdown4.addOption(2, super.r.getString(teasession._nLanguage, "TalkbackTime"));
            dropdown4.addOption(3, super.r.getString(teasession._nLanguage, "ChatTime"));
            Cell cell6 = new Cell(dropdown4);
            row8.add(cell6);
            table.add(row8);
            form.add(table);
            form.add(new Button(super.r.getString(teasession._nLanguage, "Search")));
            printwriter.print(form);
            int j3 = Node.countSearchx(s, teasession._nLanguage, type, i1, s6, j1, k1, s9, l1, s11, i, j, date1, date3, j2, k2);
            Table table1 = new Table(j3 + " " + super.r.getString(teasession._nLanguage, "Results") + " &nbsp;\n" + super.r.getString(teasession._nLanguage, "CurrentPosition") + ": " + i2);
            table1.setBorder(1);
            table1.setId("SearchResultTable");
            for (Enumeration enumeration = Node.findSearchx(s, teasession._nLanguage, type, i1, s6, j1, k1, s9, l1, s11, i2, 25, i, j, date1, date3, j2, k2); enumeration.hasMoreElements(); )
            {
                int k3 = ((Integer) enumeration.nextElement()).intValue();
                Node node1 = Node.find(k3);
                switch (node1.getType())
                {
                case 4: // '\004'
                    table1.add(getBuy(node1, k3, teasession._nLanguage));
                    break;
                case 12: // '\f'
                    table1.add(getBook(node1, k3, teasession._nLanguage));
                    break;
                default:
                    table1.add(getDefault(node1, k3, teasession._nLanguage));
                    break;
                }
            }
            printwriter.print(table1);
            printwriter.print(new FPNL(teasession._nLanguage, s13 + "&Pos=", i2, j3));
            printwriter.print(new Languages(teasession._nLanguage, request));
            printwriter.close();
        } catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/node/general/Search").add("tea/ui/member/offer/Offers").add("tea/ui/member/offer/ShoppingCarts").add("tea/ui/node/type/buy/BuyPrices").add("tea/ui/node/type/buy/EditBuyPrice").add("tea/ui/member/buypoint/BuyPoints").add("tea/ui/node/general/EditNode").add("tea/ui/node/section/Sections").add("tea/ui/node/listing/EditListing");
    }
}
