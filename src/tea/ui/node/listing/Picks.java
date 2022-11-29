package tea.ui.node.listing;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.*;
import tea.entity.site.TypeAlias;
import tea.html.*;
import tea.htmlx.Go;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class Picks extends TeaServlet
{

    public Picks()
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
            int i = Integer.parseInt(teasession.getParameter("Listing"));
            Listing listing = Listing.find(i);
            Node node = Node.find(listing.getNode());
            if(!node.isCreator(teasession._rv) && AccessMember.find(node._nNode,teasession._rv._strV).getPurview() < 2)
            {
                response.sendError(403);
                return;
            }
            if(request.getMethod().equals("GET"))
            {
                String qs = request.getQueryString();
                qs = qs == null ? "" : "?" + qs;
                response.sendRedirect("/jsp/listing/Picks.jsp" + qs);
                return; /*
                        PrintWriter printwriter = response.getWriter();
                        printwriter.print(node.getAncestor(teasession._nLanguage, "Path"));
                       // System.out.println(listing.getPick());

                        if(listing.getPick() == 0)
                        {
                            Table table = new Table(super.r.getString(teasession._nLanguage, "PickManual"));
                            table.setCellPadding(5);
                            table.setTitle(super.r.getString(teasession._nLanguage, "Community") + "\n" + super.r.getString(teasession._nLanguage, "Type"));
                            Row row;
                            for(Enumeration enumeration = PickManual.findByListing(i); enumeration.hasMoreElements(); table.add(row))
                            {
                                int j = ((Integer)enumeration.nextElement()).intValue();
                                PickManual pickmanual = PickManual.find(j);
                                row = new Row();
                                String s = pickmanual.getCommunity();
                                if(s.equals(""))
                                    row.add(new Cell(new Text(super.r.getString(teasession._nLanguage, "AllCommunities"))));
                                else
                                    row.add(new Cell(new Text(s)));
                                int j1 = pickmanual.getType();
                                int k1 = pickmanual.getTypeAlias();
                                if(j1 == 255)
                                    row.add(new Cell(new Text(super.r.getString(teasession._nLanguage, "AllTypes"))));
                                else
                                if(k1 == 0)
                                {
                                    row.add(new Cell(new Text(super.r.getString(teasession._nLanguage, Node.NODE_TYPE[j1]))));
                                } else
                                {
                                    TypeAlias typealias = TypeAlias.find(k1);
                                    row.add(new Cell(new Text("<font>" + typealias.getName(teasession._nLanguage) + "</font>")));
                                }
                                row.add(new Cell(new Button(1, "CB", "CBEdit", super.r.getString(teasession._nLanguage, "CBEdit"), "window.open('EditPickManual?node=" + teasession._nNode + "&Listing=" + i + "&PickManual=" + j + "', '_self');")));
                                row.add(new Cell(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDelete") + "')){window.open('DeletePickManual?node=" + teasession._nNode + "&Listing=" + i + "&PickManual=" + j + "', '_self');}")));
                            }

                            printwriter.print(table);
                            printwriter.print(new Button(1, "CB", "CBNew", super.r.getString(teasession._nLanguage, "CBNew"), "window.open('EditPickManual?node=" + teasession._nNode + "&Listing=" + i + "', '_self');"));
                        }
                        if(listing.getPick() != 0 && listing.getType() != 1)
                        {

                            Table table1 = new Table(super.r.getString(teasession._nLanguage, "PickFrom"));
                            table1.setCellPadding(5);
                            table1.setTitle(super.r.getString(teasession._nLanguage, "FromStyle") + "\n" + super.r.getString(teasession._nLanguage, "FromCommunity") + "\n" + super.r.getString(teasession._nLanguage, "FromNode") + "\n");
                            Row row1;
                            for(Enumeration enumeration1 = PickFrom.findByListing(i); enumeration1.hasMoreElements(); table1.add(row1))
                            {
                                int k = ((Integer)enumeration1.nextElement()).intValue();
                                PickFrom pickfrom = PickFrom.find(k);
                                row1 = new Row();
                                int l = pickfrom.getFromStyle();
                                row1.add(new Cell(new Text(super.r.getString(teasession._nLanguage, PickFrom.FROM_STYLE[l]))));
                                if(l == 1)
                                    row1.add(new Cell());
                                else
                                    row1.add(new Cell(new Text(pickfrom.getFromCommunity())));
                                row1.add(new Cell(Node.find(pickfrom.getFromNode()).getAnchor(teasession._nLanguage)));
                                row1.add(new Cell(new Button(1, "CB", "CBEdit", super.r.getString(teasession._nLanguage, "CBEdit"), "window.open('EditPickFrom?node=" + teasession._nNode + "&Listing=" + i + "&PickFrom=" + k + "', '_self');")));
                                row1.add(new Cell(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDelete") + "')){window.open('DeletePickFrom?node=" + teasession._nNode + "&Listing=" + i + "&PickFrom=" + k + "', '_self');}")));
                            }

                            printwriter.print(table1);
                            printwriter.print(new Button(1, "CB", "CBNew", super.r.getString(teasession._nLanguage, "CBNew"), "window.open('EditPickFrom?node=" + teasession._nNode + "&Listing=" + i + "', '_self');"));
                            table1 = new Table(super.r.getString(teasession._nLanguage, "PickNode"));
                            table1.setCellPadding(5);
                            table1.setTitle(super.r.getString(teasession._nLanguage, "Style") + "\n" + super.r.getString(teasession._nLanguage, "Type") + "\n" + super.r.getString(teasession._nLanguage, "CreatorStyle") + "\n" + super.r.getString(teasession._nLanguage, "RCreator") + "\n" + super.r.getString(teasession._nLanguage, "VCreator") + "\n" + super.r.getString(teasession._nLanguage, "StartStyle") + "\n" + super.r.getString(teasession._nLanguage, "StopStyle") + "\n");
                            Row row2;
                            for(Enumeration enumeration2 = PickNode.findByListing(i); enumeration2.hasMoreElements(); table1.add(row2))
                            {
                                int i1 = ((Integer)enumeration2.nextElement()).intValue();
                                PickNode picknode = PickNode.find(i1);
                                row2 = new Row();
                                int l1 = picknode.getNodeStyle();
                                row2.add(new Cell(new Text(super.r.getString(teasession._nLanguage, PickNode.NODE_STYLE[l1]))));
                                int j2 = picknode.getType();
                                int k2 = picknode.getTypeAlias();
                                if(j2 == 255)
                                    row2.add(new Cell(new Text(super.r.getString(teasession._nLanguage, "AllTypes"))));
                                else
                                if(k2 == 0)
                                {
                                    row2.add(new Cell(new Text(super.r.getString(teasession._nLanguage, Node.NODE_TYPE[j2]))));
                                } else
                                {
                                    TypeAlias typealias1 = TypeAlias.find(k2);
                                    row2.add(new Cell(new Text("<font>" + typealias1.getName(teasession._nLanguage) + "</font>")));
                                }
                                int l2 = picknode.getCreatorStyle();
                                row2.add(new Cell(new Text(super.r.getString(teasession._nLanguage, PickNode.CREATOR_STYLE[l2]))));
                                if(l2 != 0)
                                {
                                    row2.add(new Cell(new Text(picknode.getRCreator())));
                                    row2.add(new Cell(new Text(picknode.getVCreator())));
                                } else
                                {
                                    row2.add(new Cell());
                                    row2.add(new Cell());
                                }
                                int i3 = picknode.getStartStyle();
                                int j3 = picknode.getStartTerm();
                                row2.add(new Cell(super.r.getString(teasession._nLanguage, PickNode.TERM_STYLE[i3]) + (i3 != 0 ? " " + (j3 > 0 ? "+" : "") + j3 + " " + super.r.getString(teasession._nLanguage, "Hours") : "")));
                                int k3 = picknode.getStopStyle();
                                int l3 = picknode.getStopTerm();
                                row2.add(new Cell(super.r.getString(teasession._nLanguage, PickNode.TERM_STYLE[k3]) + (k3 != 0 ? " " + (l3 > 0 ? "+" : "") + l3 + " " + super.r.getString(teasession._nLanguage, "Hours") : "")));
                                row2.add(new Cell(new Button(1, "CB", "CBEdit", super.r.getString(teasession._nLanguage, "CBEdit"), "window.open('EditPickNode?node=" + teasession._nNode + "&Listing=" + i + "&PickNode=" + i1 + "', '_self');")));
                                row2.add(new Cell(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDelete") + "')){window.open('DeletePickNode?node=" + teasession._nNode + "&Listing=" + i + "&PickNode=" + i1 + "', '_self');}")));
                            }

                            printwriter.print(table1);
                            printwriter.print(new Button(1, "CB", "CBNew", super.r.getString(teasession._nLanguage, "CBNew"), "window.open('EditPickNode?node=" + teasession._nNode + "&Listing=" + i + "', '_self');"));
                            table1 = new Table(super.r.getString(teasession._nLanguage, "PickNews"));
                            table1.setCellPadding(5);
                            table1.setTitle(super.r.getString(teasession._nLanguage, "IssueTerm") + "\n");
                            Row row3;
                            for(Enumeration enumeration3 = PickNews.findByListing(i); enumeration3.hasMoreElements(); table1.add(row3))
                            {
                                int i2 = ((Integer)enumeration3.nextElement()).intValue();
                                PickNews picknews = PickNews.find(i2);
                                row3 = new Row(new Cell(new Text(Integer.toString(picknews.getIssueTerm()))));
                                row3.add(new Cell(new Button(1, "CB", "CBEdit", super.r.getString(teasession._nLanguage, "CBEdit"), "window.open('EditPickNews?node=" + teasession._nNode + "&Listing=" + i + "&PickNews=" + i2 + "', '_self');")));
                                row3.add(new Cell(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDelete") + "')){window.open('DeletePickNews?node=" + teasession._nNode + "&Listing=" + i + "&PickNews=" + i2 + "', '_self');}")));
                            }

                            printwriter.print(table1);
                            printwriter.print(new Button(1, "CB", "CBNew", super.r.getString(teasession._nLanguage, "CBNew"), "window.open('EditPickNews?node=" + teasession._nNode + "&Listing=" + i + "', '_self');"));
                        }
                        Form form = new Form("foEdit", "POST", "Picks");
                        form.add(new HiddenField("Node", teasession._nNode));
                        form.add(new HiddenField("Listing", i));
                                         int listingtype=listing.getType();*/
               /*
                                                if (listingtype==2)
                                                {
                                    SmsService ss= new SmsService();

                                                        Table table = new Table("服务信息");
                                   Row row1=new Row(new Cell(new Text("服务代码：")));
                                   row1.add(new Cell(new TextField("service", ss.getService(i))));
                                                   Row row2 = new Row(new Cell(new Text("服务费用：")));
                                   row2.add(new Cell(new TextField("fee", ss.getFee(i))));
                                  Row row3 = new Row(new Cell(new Text("服务说明：")));
                                  row3.add(new Cell(new TextArea("beizu",ss.getbeizu(i), 2, 60)));
                                   table.add(row1);
                                  table.add(row2);
                                 table.add(row3);
                                                  form.add(table);

                                                }
                */
               /*
                                           form.add(new Go(teasession._nLanguage, 1));
                           printwriter.print(form);
                           printwriter.print(new Languages(teasession._nLanguage, request));
                           printwriter.close();*/
            } else
            {
                /*int fee = Integer.parseInt(request.getParameter("fee"));
                                   String service=request.getParameter("service");
                                   String beizu=request.getParameter("beizu");
                                      SmsService sss= new SmsService();
                                   sss.service_edit(service,i,fee,beizu);
                 */
                if(request.getParameter("GoBack") != null)
                    response.sendRedirect("EditListing?node=" + teasession._nNode + "&Listing=" + i);
                else
                    response.sendRedirect("Node?node=" + teasession._nNode + "&edit=ON");
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
//        super.r.add("tea/ui/node/listing/Picks");
    }
}
