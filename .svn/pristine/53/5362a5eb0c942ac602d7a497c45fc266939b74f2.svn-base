// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2004-9-24 12:47:18
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   Contacts.java

package tea.ui.member.contact;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.CGroup;
import tea.entity.member.Contact;
import tea.html.*;
import tea.htmlx.FPNL;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class Contacts extends TeaServlet
{

    public Contacts()
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
            if(!teasession._rv.isSupport())
            {
                response.sendError(403);
                return;
            }
            String qs = request.getQueryString();
            qs = qs == null ? "" : "?" + qs;
            response.sendRedirect("/jsp/message/Contacts.jsp" + qs);

            /*
                        String s = request.getParameter("CGroup");
                        String s1 = CGroup.getMember(s);
                        int i = CGroup.getType(s);
                        boolean flag = s1.equals(teasession._rv._strR);
                        byte byte0 = 100;
                        if(flag)
                        {
                            CGroup cgroup = CGroup.find(teasession._rv._strR, s);
                            String s2 = cgroup.getName(teasession._nLanguage);
                            Text text = new Text(hrefGlance(teasession._rv) + ">" + new Anchor("CGroups", super.r.getString(teasession._nLanguage, "CGroups")) + ">" + s2);
                            text.setId("PathDiv");
                            PrintWriter printwriter = response.getWriter();
                            printwriter.print(text);
                            String s4 = request.getParameter("Pos");
                            int j = s4 != null ? Integer.parseInt(s4) : 0;
                            int l = Contact.count(teasession._rv._strR, s);
                            Form form = new Form("foDelete", "GET", "DeleteContacts");
                            form.add(new HiddenField("CGroup", s));
                            Table table = new Table();
                            table.setCellSpacing(5);
                            table.setCaption(l + "  " + super.r.getString(teasession._nLanguage, "Contacts"));
                            if(l != 0)
                            {
                                boolean flag2 = true;
                                Row row = new Row();
                                row.add(new Cell(new Text(super.r.getString(teasession._nLanguage, "To") + "  ")));
                                row.add(new Cell(new Text("  ")));
                                row.add(new Cell(new Text(super.r.getString(teasession._nLanguage, "CcMembers") + "  ")));
                                row.add(new Cell(new Text("  ")));
                                row.add(new Cell(new Text(super.r.getString(teasession._nLanguage, "Bcc") + "  ")));
                                row.add(new Cell(new Text("  ")));
                                row.add(new Cell(new Text(super.r.getString(teasession._nLanguage, "Delete") + "  ")));
                                row.add(new Cell(new Text(super.r.getString(teasession._nLanguage, "  "))));
                                table.add(row);
                                Row row1;
                                for(Enumeration enumeration = Contact.find(teasession._rv._strR, s, j, byte0); enumeration.hasMoreElements(); table.add(row1))
                                {
                                    RV rv = (RV)enumeration.nextElement();
                                    String s6 = rv.toString();
                                    row1 = new Row();
                                    row1.add(new Cell(new CheckBox("to", false, s6)));
                                    row1.add(new Cell(new Text("  ")));
                                    row1.add(new Cell(new CheckBox("cc", false, s6)));
                                    row1.add(new Cell(new Text("  ")));
                                    row1.add(new Cell(new CheckBox("bcc", false, s6)));
                                    row1.add(new Cell(new Text("  ")));
                                    row1.add(new Cell(new CheckBox(s6, false)));
                                    row1.add(new Cell(getRvDetail(rv, teasession._nLanguage,request.getContextPath())));
                                    row1.add(new HiddenField("Contacts", s6));
                                    row1.setId(flag2 ? "OddRow" : "EvenRow");
                                    flag2 = !flag2;
                                }

                            }
                            form.add(table);
                            printwriter.print(form);
                            printwriter.print(new FPNL(teasession._nLanguage, "Contacts?CGroup=" + s + "&Pos=", j, l, byte0));
                            printwriter.print(new Button(1, "CB", "CBNew", super.r.getString(teasession._nLanguage, "CBNew"), "window.open('NewContacts?CGroup=" + s + "', '_self');"));
                            printwriter.print(new Button(1, "CB", "CBInsertMemberID", super.r.getString(teasession._nLanguage, "CBInsertMemberID"), "window.open('javascript:insertMemberID();', '_self');"));
                            if(l != 0)
                                printwriter.print(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDeleteSelected") + "')){window.open('javascript:foDelete.submit();" + "', '_self');}"));
                            printwriter.print(new Languages(teasession._nLanguage, request));
                            printwriter.close();
                            return;
                        }
                        if(i != 0)
                        {
                            CGroup cgroup1 = CGroup.find(s1, s);
                            String s3 = cgroup1.getName(teasession._nLanguage);
                            Text text1 = new Text(hrefGlance(new RV(s1, s1),request.getContextPath()) + ">" + new Anchor("CGroups", super.r.getString(teasession._nLanguage, "CGroups")) + ">" + s3);
                            text1.setId("PathDiv");
                            PrintWriter printwriter1 = beginOut(response, teasession);
                            printwriter1.print(text1);
                            String s5 = request.getParameter("Pos");
                            int k = s5 != null ? Integer.parseInt(s5) : 0;
                            int i1 = Contact.count(s1, s);
                            Form form1 = new Form("foDelete", "GET", "DeleteContacts");
                            form1.add(new HiddenField("CGroup", s));
                            boolean flag1 = CGroup.isUseAsMyOwnCGroup(teasession._rv._strR, s);
                            Text text2 = new Text(super.r.getString(teasession._nLanguage, "UseAsMyOwnCGroup") + ": " + new Radio("UseAsMyOwnCGroup", 1, flag1) + super.r.getString(teasession._nLanguage, "Yes") + " " + new Radio("UseAsMyOwnCGroup", 0, !flag1) + super.r.getString(teasession._nLanguage, "No") + " &nbsp;" + new Anchor("javascript:foDelete.submit();", super.r.getString(teasession._nLanguage, "Submit")));
                            form1.add(text2);
                            Table table1 = new Table();
                            table1.setCellSpacing(5);
                            table1.setCaption(i1 + " " + super.r.getString(teasession._nLanguage, "Contacts"));
                            if(i1 != 0)
                            {
                                boolean flag3 = true;
                                Row row2 = new Row();
                                row2.add(new Cell(new Text(super.r.getString(teasession._nLanguage, "To") + "  ")));
                                row2.add(new Cell(new Text("  ")));
                                row2.add(new Cell(new Text(super.r.getString(teasession._nLanguage, "CcMembers") + "  ")));
                                row2.add(new Cell(new Text("  ")));
                                row2.add(new Cell(new Text(super.r.getString(teasession._nLanguage, "Bcc") + "  ")));
                                row2.add(new Cell(new Text("  ")));
                                if(i == 3)
                                    row2.add(new Cell(new Text(super.r.getString(teasession._nLanguage, "Delete") + "  ")));
                                row2.add(new Cell(new Text(super.r.getString(teasession._nLanguage, "  "))));
                                table1.add(row2);
                                Row row3;
                                for(Enumeration enumeration1 = Contact.find(s1, s, k, byte0); enumeration1.hasMoreElements(); table1.add(row3))
                                {
                                    RV rv1 = (RV)enumeration1.nextElement();
                                    String s7 = rv1.toString();
                                    row3 = new Row();
                                    row3.add(new Cell(new CheckBox("to", false, s7)));
                                    row3.add(new Cell(new Text("  ")));
                                    row3.add(new Cell(new CheckBox("cc", false, s7)));
                                    row3.add(new Cell(new Text("  ")));
                                    row3.add(new Cell(new CheckBox("bcc", false, s7)));
                                    row3.add(new Cell(new Text("  ")));
                                    if(i == 3)
                                        row3.add(new Cell(new CheckBox(s7, false)));
                                    row3.add(new Cell(getRvDetail(rv1, teasession._nLanguage,request.getContextPath())));
                                    row3.add(new HiddenField("Contacts", s7));
                                    row3.setId(flag3 ? "OddRow" : "EvenRow");
                                    flag3 = !flag3;
                                }

                            }
                            form1.add(table1);
                            printwriter1.print(form1);
                            printwriter1.print(new FPNL(teasession._nLanguage, "Contacts?CGroup=" + s + "&Pos=", k, i1, byte0));
                            if(i == 2 || i == 3)
                                printwriter1.print(new Button(1, "CB", "CBNew", super.r.getString(teasession._nLanguage, "CBNew"), "window.open('NewContacts?CGroup=" + s + "', '_self');"));
                            if(i == 3 && i1 != 0)
                                printwriter1.print(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDeleteSelected") + "')){window.open('javascript:foDelete.submit();" + "', '_self');}"));
                            printwriter1.print(new Button(1, "CB", "CBInsertMemberID", super.r.getString(teasession._nLanguage, "CBInsertMemberID"), "window.open('javascript:insertMemberID();', '_self');"));
                            printwriter1.print(new Languages(teasession._nLanguage, request));
                            endOut(printwriter1, teasession);
                            return;
                        } else
                        {
                            outText(teasession,response, super.r.getString(teasession._nLanguage, "Unviewable"));
                            return;
                        }
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
        super.r.add("tea/ui/member/contact/CGroups").add("tea/ui/member/contact/Contacts");
    }
}
