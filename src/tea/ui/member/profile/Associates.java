// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2003-6-27 9:51:28
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   Associates.java

package tea.ui.member.profile;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Associate;
import tea.entity.node.Node;
import tea.html.*;
import tea.htmlx.FPNL;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class Associates extends TeaServlet
{

    public Associates()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            String qs = request.getQueryString();
            qs = qs == null ? "" : "?" + qs;
            response.sendRedirect("/jsp/profile/Associates.jsp" + qs);
            /*   TeaSession teasession = new TeaSession(request);
                        if(teasession._rv == null)
                        {
                            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                            return;
                        }
                        Text text = new Text(hrefGlance(teasession._rv) + ">" + new Anchor("Profile", super.r.getString(teasession._nLanguage, "Profile")) + ">" + super.r.getString(teasession._nLanguage, "Associates"));
                        text.setId("PathDiv");
                        String s = request.getParameter("Pos");
                        int i = s == null ? 0 : Integer.parseInt(s);
                        Table table = new Table();
                        int j = Associate.count(teasession._rv._strR);
                        table.setCaption(j + " " + super.r.getString(teasession._nLanguage, "Associates"));
                        if(j != 0)
                        {
                            table.setTitle(super.r.getString(teasession._nLanguage, "MemberId") + "\n" + " &nbsp;" + "\n" + super.r.getString(teasession._nLanguage, "Positions") + "\n" + " &nbsp;" + "\n" + super.r.getString(teasession._nLanguage, "Managers") + "\n" + " &nbsp;" + "\n" + "<font>" + super.r.getString(teasession._nLanguage, "Providers") + "</font>" + "\n" + " &nbsp;" + "\n");
                            Row row;
                            for(Enumeration enumeration = Associate.find(teasession._rv._strR, i, 25); enumeration.hasMoreElements(); table.add(row))
                            {
                                String s1 = (String)enumeration.nextElement();
                                Associate associate = Associate.find(teasession._rv._strR, s1);
                                int k = associate.getPositions();
                                int l = associate.getManagers();
                                int i1 = associate.getProviders0();
                                int j1 = associate.getProviders1();
                                row = new Row(new Cell(s1));
                                row.add(new Cell(new Text("  ")));
                                Cell cell = new Cell();
                                for(int k1 = 0; k1 < Associate.ASSOCIATE.length; k1++)
                                    if((k & 1 << k1) != 0)
                                        cell.add(new Text(super.r.getString(teasession._nLanguage, Associate.ASSOCIATE[k1]) + " "));

                                row.add(cell);
                                row.add(new Cell(new Text("  ")));
                                Cell cell1 = new Cell();
                                for(int l1 = 0; l1 < Associate.ASSOCIATE.length; l1++)
                                    if((l & 1 << l1) != 0)
                                        cell1.add(new Text(super.r.getString(teasession._nLanguage, Associate.ASSOCIATE[l1]) + " "));

                                row.add(cell1);
                                row.add(new Cell(new Text("  ")));
                                Cell cell2 = new Cell();
                                for(int i2 = 0; i2 < Node.NODE_TYPE.length; i2++)
                                    if(((i2 < 32 ? i1 : j1) & 1 << i2 % 32) != 0)
                                        cell2.add(new Text(super.r.getString(teasession._nLanguage, Node.NODE_TYPE[i2]) + " "));

                                row.add(cell2);
                                row.add(new Cell(new Text("  ")));
                                if(teasession._rv.isHR())
                                {
                                    row.add(new Cell(new Button(1, "CB", "CBEdit", super.r.getString(teasession._nLanguage, "CBEdit"), "window.open('EditAssociate?Associate=" + s1 + "', '_self');")));
                                    row.add(new Cell(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDelete") + "')){window.open('DeleteAssociate?Associate=" + s1 + "', '_self');}")));
                                }
                            }

                        }
                        PrintWriter printwriter = response.getWriter();
                        printwriter.print(text);
                        printwriter.print(table);
                        printwriter.print(new FPNL(teasession._nLanguage, "Associates?Pos=", i, j));
                        printwriter.print(new Break());
                        if(teasession._rv.isHR())
                            printwriter.print(new Button(1, "CB", "CBNew", super.r.getString(teasession._nLanguage, "CBNew"), "window.open('EditAssociate', '_self');"));
                        printwriter.print(new Languages(teasession._nLanguage, request));
                        printwriter.close();
             */
        } catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/member/profile/ProfileServlet").add("tea/ui/member/profile/Associates");
    }
}
