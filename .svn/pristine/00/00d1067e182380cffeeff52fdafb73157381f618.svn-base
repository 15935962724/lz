// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2004-9-24 10:30:34
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   MessageFolderSubscribers.java

package tea.ui.member.messagefolder;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.MessageFolder;
import tea.html.*;
import tea.htmlx.FPNL;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class MessageFolderSubscribers extends TeaServlet
{

	public MessageFolderSubscribers()
	{
	}

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		try
		{
			TeaSession teasession = new TeaSession(request);
			if (teasession._rv == null)
			{
				response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
				return;
			}
			if (!teasession._rv.isSupport())
			{
				response.sendError(403);
				return;
			}

			StringBuilder sb = new StringBuilder("?");
			java.util.Enumeration enumer = request.getParameterNames();
			while (enumer.hasMoreElements())
			{
				String str = enumer.nextElement().toString();
				sb.append(str + "=" + request.getParameter(str) + "&");
			}
			sb.setLength(sb.length() - 1);
			response.sendRedirect("/jsp/message/MessageFolderSubscribers.jsp" + sb.toString());

			// String s = request.getParameter("MessageFolder");
			// String s1 = MessageFolder.getMember(s);
			// int i = MessageFolder.getType(s);
			// int j = MessageFolder.getOptions(s);
			// boolean flag = s1.equals(teasession._rv._strR);
			// byte byte0 = 100;
			// if(flag)
			// {
			// MessageFolder messagefolder = MessageFolder.find(teasession._rv._strR, s);
			// String s2 = messagefolder.getName(teasession._nLanguage);
			// Text text = new Text(hrefGlance(teasession._rv) + ">" + new Anchor("ManageMessageFolders", super.r.getString(teasession._nLanguage, "ManageFolders")) + ">" + new Anchor("MessageFolderContents?MessageFolder=" + s, "_self", new Text(s2)));
			// text.setId("PathDiv");
			// PrintWriter printwriter = response.getWriter();
			// printwriter.print(text);
			// String s4 = request.getParameter("Pos");
			// int k = s4 != null ? Integer.parseInt(s4) : 0;
			// int i1 = MessageFolder.count(s);
			// Form form = new Form("foDelete", "GET", "DeleteMessageFolderSubscribers");
			// form.add(new HiddenField("MessageFolder", s));
			// Table table = new Table();
			// table.setCellSpacing(5);
			// table.setCaption(i1 + " " + super.r.getString(teasession._nLanguage, "MessageFolderSubscribers"));
			// if(i1 != 0)
			// {
			// boolean flag1 = true;
			// Row row = new Row();
			// row.add(new Cell(new Text(super.r.getString(teasession._nLanguage, "To") + " ")));
			// row.add(new Cell(new Text(" ")));
			// row.add(new Cell(new Text(super.r.getString(teasession._nLanguage, "CcMembers") + " ")));
			// row.add(new Cell(new Text(" ")));
			// row.add(new Cell(new Text(super.r.getString(teasession._nLanguage, "Bcc") + " ")));
			// row.add(new Cell(new Text(" ")));
			// row.add(new Cell(new Text(super.r.getString(teasession._nLanguage, "Delete") + " ")));
			// row.add(new Cell(new Text(super.r.getString(teasession._nLanguage, " "))));
			// table.add(row);
			// Row row2;
			// for(Enumeration enumeration = MessageFolder.findSubscribers(s, k, byte0); enumeration.hasMoreElements(); table.add(row2))
			// {
			// RV rv = (RV)enumeration.nextElement();
			// String s6 = rv.toString();
			// row2 = new Row();
			// row2.add(new Cell(new CheckBox("to", false, s6)));
			// row2.add(new Cell(new Text(" ")));
			// row2.add(new Cell(new CheckBox("cc", false, s6)));
			// row2.add(new Cell(new Text(" ")));
			// row2.add(new Cell(new CheckBox("bcc", false, s6)));
			// row2.add(new Cell(new Text(" ")));
			// row2.add(new Cell(new CheckBox(s6, false)));
			// row2.add(new Cell(getRvDetail(rv, teasession._nLanguage,request.getContextPath())));
			// row2.add(new HiddenField("MessageFolderSubscribers", s6));
			// row2.setId(flag1 ? "OddRow" : "EvenRow");
			// flag1 = !flag1;
			// }
			//
			// }
			// form.add(table);
			// printwriter.print(form);
			// printwriter.print(new FPNL(teasession._nLanguage, "MessageFolderSubscribers?MessageFolder=" + s + "&Pos=", k, i1, byte0));
			// if(i1 != 0)
			// {
			// printwriter.print(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDeleteSelected") + "')){window.open('javascript:foDelete.submit();" + "', '_self');}"));
			// printwriter.print(new Button(1, "CB", "CBInsertMemberID", super.r.getString(teasession._nLanguage, "CBInsertMemberID"), "window.open('javascript:insertMemberID();', '_self');"));
			// }
			// printwriter.print(new Languages(teasession._nLanguage, request));
			// printwriter.close();
			// return;
			// }
			// if(i != 0)
			// {
			// MessageFolder messagefolder1 = MessageFolder.find(s1, s);
			// String s3 = messagefolder1.getName(teasession._nLanguage);
			// Text text1 = new Text(hrefGlance(new RV(s1, s1),request.getContextPath()) + ">" + new Anchor("ManageMessageFolders", super.r.getString(teasession._nLanguage, "ManageFolders")) + ">" + new Anchor("MessageFolderContents?MessageFolder=" + s, "_self", new Text(s3)));
			// text1.setId("PathDiv");
			// PrintWriter printwriter1 = beginOut(response, teasession);
			// printwriter1.print(text1);
			// String s5 = request.getParameter("Pos");
			// int l = s5 != null ? Integer.parseInt(s5) : 0;
			// int j1 = MessageFolder.count(s);
			// Form form1 = new Form("foDelete", "GET", "DeleteMessageFolderSubscribers");
			// form1.add(new HiddenField("MessageFolder", s));
			// Table table1 = new Table();
			// table1.setCellSpacing(5);
			// table1.setCaption(j1 + " " + super.r.getString(teasession._nLanguage, "MessageFolderSubscribers"));
			// if(j1 != 0)
			// {
			// boolean flag2 = true;
			// Row row1 = new Row();
			// row1.add(new Cell(new Text(super.r.getString(teasession._nLanguage, "To") + " ")));
			// row1.add(new Cell(new Text(" ")));
			// row1.add(new Cell(new Text(super.r.getString(teasession._nLanguage, "CcMembers") + " ")));
			// row1.add(new Cell(new Text(" ")));
			// row1.add(new Cell(new Text(super.r.getString(teasession._nLanguage, "Bcc") + " ")));
			// row1.add(new Cell(new Text(" ")));
			// if(i == 3)
			// row1.add(new Cell(new Text(super.r.getString(teasession._nLanguage, "Delete") + " ")));
			// row1.add(new Cell(new Text(super.r.getString(teasession._nLanguage, " "))));
			// table1.add(row1);
			// Row row3;
			// for(Enumeration enumeration1 = MessageFolder.findSubscribers(s, l, byte0); enumeration1.hasMoreElements(); table1.add(row3))
			// {
			// RV rv1 = (RV)enumeration1.nextElement();
			// String s7 = rv1.toString();
			// row3 = new Row();
			// row3.add(new Cell(new CheckBox("to", false, s7)));
			// row3.add(new Cell(new Text(" ")));
			// row3.add(new Cell(new CheckBox("cc", false, s7)));
			// row3.add(new Cell(new Text(" ")));
			// row3.add(new Cell(new CheckBox("bcc", false, s7)));
			// row3.add(new Cell(new Text(" ")));
			// if(i == 3)
			// row3.add(new Cell(new CheckBox(s7, false)));
			// row3.add(new Cell(getRvDetail(rv1, teasession._nLanguage,request.getContextPath())));
			// row3.add(new HiddenField("MessageFolderSubscribers", s7));
			// row3.setId(flag2 ? "OddRow" : "EvenRow");
			// flag2 = !flag2;
			// }
			//
			// }
			// form1.add(table1);
			// Form form2 = new Form("foDelete1", "GET", "DeleteMessageFolderContents");
			// form2.add(new HiddenField("Operation", ""));
			// form2.add(new HiddenField("MessageFolder0", s));
			// form2.add(new HiddenField("MessageFolder", s));
			// boolean flag3 = MessageFolder.isUseAsMyOwnMessageFolder(teasession._rv._strR, s);
			// Text text2 = new Text(super.r.getString(teasession._nLanguage, "UseAsMyOwnMessageFolder") + ": " + new Radio("UseAsMyOwnMessageFolder", 1, flag3) + super.r.getString(teasession._nLanguage, "Yes") + " " + new Radio("UseAsMyOwnMessageFolder", 0, !flag3) + super.r.getString(teasession._nLanguage, "No") + " &nbsp;" + new Anchor("javascript:foDelete1.submit();", super.r.getString(teasession._nLanguage, "Submit")));
			// form2.add(text2);
			// printwriter1.print(form1);
			// printwriter1.print(form2);
			// printwriter1.print(new FPNL(teasession._nLanguage, "MessageFolderSubscribers?MessageFolder=" + s + "&Pos=", l, j1, byte0));
			// if(i == 3 && j1 != 0)
			// printwriter1.print(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDeleteSelected") + "')){window.open('javascript:foDelete.submit();" + "', '_self');}"));
			// if(j1 != 0)
			// printwriter1.print(new Button(1, "CB", "CBInsertMemberID", super.r.getString(teasession._nLanguage, "CBInsertMemberID"), "window.open('javascript:insertMemberID();', '_self');"));
			// printwriter1.print(new Languages(teasession._nLanguage, request));
			// endOut(printwriter1, teasession);
			// return;
			// } else
			// {
			// outText(teasession,response, super.r.getString(teasession._nLanguage, "Unviewable"));
			// return;
			// }
		} catch (Exception exception)
		{
			response.sendError(400, exception.toString());
			exception.printStackTrace();
			return;
		}
	}

	public void init(ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
		super.r.add("tea/ui/member/contact/CGroups").add("tea/ui/member/contact/Contacts").add("tea/ui/member/message/MessageFolders").add("tea/ui/member/message/Messages").add("tea/ui/member/messagefolder/ManageMessageFolders");
	}
}
