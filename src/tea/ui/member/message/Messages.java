package tea.ui.member.message;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Enumeration;
import javax.mail.FetchProfile;
import javax.mail.Folder;
import javax.mail.Multipart;
import javax.mail.Part;
import javax.mail.internet.InternetAddress;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import tea.entity.RV;
import tea.entity.member.EmailBox;
import tea.entity.member.Message;
import tea.entity.member.MessageRead;
import tea.html.Anchor;
import tea.html.Button;
import tea.html.Cell;
import tea.html.CheckBox;
import tea.html.Form;
import tea.html.HiddenField;
import tea.html.HtmlElement;
import tea.html.List;
import tea.html.ListItem;
import tea.html.Row;
import tea.html.Table;
import tea.html.Text;
import tea.htmlx.FPNL;
import tea.htmlx.HintImg;
import tea.htmlx.MessageUI;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class Messages extends TeaServlet
{

	public Messages()
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
			response.sendRedirect("/jsp/message/Messages.jsp?" + request.getQueryString());
			/*
			 * String s = request.getParameter("Folder"); if(s == null) s = "Inbox"; boolean flag = false; if(s.equals("Sent")) flag = true; String s1 = request.getParameter("Pos"); int i = s1 == null ? 0 : Integer.parseInt(s1); int j = Message.count(s, teasession._rv); Form form = new
			 * Form("foDelete", "GET", "DeleteMessages"); form.add(new HiddenField("Operation", "")); form.add(new HiddenField("MessageFolder", "")); form.add(new HiddenField("Folder", s)); Table table = new Table(); table.setId("MessageBodyInnerDiv"); table.setCellPadding(0);
			 * table.setCaption("&nbsp;" + j + " " + super.r.getString(teasession._nLanguage, s) + super.r.getString(teasession._nLanguage, "Messages")); if(j != 0) { if(s.equals("Sent") || s.equals("Draft")) table.setTitle("&nbsp;\n" + super.r.getString(teasession._nLanguage, "Receiver") + "\n" +
			 * super.r.getString(teasession._nLanguage, "Subject") + "\n" + super.r.getString(teasession._nLanguage, "Time") + "\n"); if(s.equals("Inbox") || s.equals("Trash")) table.setTitle("&nbsp;\n" + super.r.getString(teasession._nLanguage, "Sender") + "\n" +
			 * super.r.getString(teasession._nLanguage, "Subject") + "\n" + super.r.getString(teasession._nLanguage, "Time") + "\n"); boolean flag1 = true; Row row; for(Enumeration enumeration = Message.find(s, teasession._rv, i, 25); enumeration.hasMoreElements(); table.add(row)) { int k =
			 * ((Integer)enumeration.nextElement()).intValue(); Message message = Message.find(k); RV rv = message.getFrom(); String s3 = message.getFEmail(); java.util.Date date = message.getTime(); int l = message.getType(); int j1 = message.getHint(); message.getOptions(); String s6 =
			 * message.getSubject(teasession._nLanguage); boolean flag3 = false; boolean flag4 = false; RV rv1 = null; String s7 = ""; if(rv._strR.length() != 0) if(message.isSingleEmailReceiver(rv)) s7 = message.findSingleEmailReceiver(rv); else if(message.isSingleRVReceiver(rv)) { rv1 =
			 * message.findSingleRVReceiver(rv); flag4 = MessageRead.isRead(k, rv1); } boolean flag5 = message.isMultipleReceiver(rv); boolean flag6 = message.getMessageCGroup().length() != 0; boolean flag7 = message.getMessageCommunity().length() != 0; if(rv1 == null && s7.length() == 0 && !flag5 &&
			 * !flag6 && !flag7) flag3 = flag ? MessageRead.isRead(k) : MessageRead.isRead(k, teasession._rv); else flag3 = flag ? MessageRead.isReadExcludeSender(k, rv) : MessageRead.isRead(k, teasession._rv); row = new Row(new Cell(new CheckBox(Integer.toString(k), false))); Cell cell1 = new
			 * Cell(); Cell cell2 = new Cell(); if(s.equals("Inbox") || s.equals("Trash")) { String s8 = ""; if(s3 != null && s3.length() != 0) s8 = (new Anchor("NewMessage?Receiver=" + s3, "_blank", new Text(s3))).toString(); else s8 = hrefGlanceWithName(rv,
			 * teasession._nLanguage,request.getContextPath()).toString(); cell1.add(new Text("<font>" + s8 + "</font>")); cell2.add(new Text("<font>" + (new SimpleDateFormat("yyyy.MM.dd hh:mm aaa")).format(date) + "</font>")); cell1.setId(flag3 ? "MessageRead" : "MessageUnread");
			 * cell2.setId(flag3 ? "MessageRead" : "MessageUnread"); row.add(cell1); } if(s.equals("Sent") || s.equals("Draft")) { if(flag5 || flag6 || flag7) { cell1.add(new Anchor("MessageReaders?Message=" + k, "_blank", new Text(super.r.getString(teasession._nLanguage, "MessageReaders"))));
			 * cell2.add(new Text("<font>" + (new SimpleDateFormat("yyyy.MM.dd hh.mm aaa")).format(date) + "</font> ")); } else if(s7.length() != 0) { cell1.add(new Text((new Anchor("NewMessage?Receiver=" + s7, "_blank", new Text(s7))).toString())); cell2.add(new Text("<font>" + (new
			 * SimpleDateFormat("yyyy.MM.dd hh.mm aaa")).format(date) + "</font> ")); } else if(rv1 != null) { cell1.add(new Text(hrefGlanceWithName(rv1, teasession._nLanguage,request.getContextPath()).toString())); if(flag4) { java.util.Date date1 = MessageRead.getTime(k, rv1); cell2.add(new
			 * Text("<font>" + (new SimpleDateFormat("yyyy.MM.dd hh.mm aaa")).format(date1) + "</font> ")); } else { cell2.add(new Text("<font>" + (new SimpleDateFormat("yyyy.MM.dd hh.mm aaa")).format(date) + "</font> ")); } } else { cell1.add(new Text(hrefGlanceWithName(teasession._rv,
			 * teasession._nLanguage).toString())); cell2.add(new Text("<font>" + (new SimpleDateFormat("yyyy.MM.dd hh.mm aaa")).format(date) + "</font> ")); } cell1.setId(flag3 ? "MessageRead" : "MessageUnread"); cell2.setId(flag3 ? "MessageRead" : "MessageUnread"); row.add(cell1); } Cell cell3 =
			 * new Cell(new Anchor("Message?Folder=" + s + "&Message=" + k, new Text(new HintImg(teasession._nLanguage, j1) + " <font>" + s6 + "</font>"))); cell3.setId(flag3 ? "MessageRead" : "MessageUnread"); row.add(cell3); row.add(cell2); row.add(new HiddenField("Messages",
			 * Integer.toString(k))); row.setId(flag1 ? "OddRow" : "EvenRow"); flag1 = !flag1; }
			 *  } form.add(table); form.add(new Text("<br><br>")); if(s.equals("Inbox")) { List list = new List(); Object obj = null; boolean flag2 = false; for(Enumeration enumeration1 = EmailBox.find(teasession._rv._strR); enumeration1.hasMoreElements();) { String s2 =
			 * (String)enumeration1.nextElement(); EmailBox emailbox = EmailBox.find(teasession._rv._strR, s2); String s4 = emailbox.getPop3User(); String s5 = emailbox.getPop3Passwd(); int i1 = emailbox.getPop3Options(); if(s4.length() != 0 && s5.length() != 0) getEmails(s2, request,
			 * teasession._rv, teasession._nLanguage, response); if(s4.length() == 0 || s5.length() == 0 && (i1 & 4) == 0) { flag2 = true; byte byte0 = -1; ListItem listitem = new ListItem(new Anchor("EditEmailBox?EmailBox=" + s2, new Text((byte0 != -1 ? Integer.toString(byte0) : "") + " " + s2)));
			 * list.add(listitem); } }
			 *
			 * if(flag2) { form.add(new Text(super.r.getString(teasession._nLanguage, "NeedUserOrPassword"))); form.add(list); } } form.add(new FPNL(teasession._nLanguage, "Messages?Folder=" + s + "&Pos=", i, j)); form.add(new Text("<br>")); form.add(new Button(1, "CB", "CBNewMessage",
			 * super.r.getString(teasession._nLanguage, "CBNewMessage"), "window.open('NewMessage', '_blank');")); if(j > 0) { if(s.equals("Draft")) form.add(new Button(1, "CB", "CBSend", super.r.getString(teasession._nLanguage, "CBSend"), "if(confirm('" + super.r.getString(teasession._nLanguage,
			 * "ConfirmSendSelected") + "')){window.open('javascript:document.foDelete.Operation.value=\\'Send\\';foDelete.submit();" + "', '_self');}")); if(!s.equals("Trash")) { form.add(new Button(1, "CB", "CBTrash", super.r.getString(teasession._nLanguage, "CBTrash"), "if(confirm('" +
			 * super.r.getString(teasession._nLanguage, "ConfirmTrashSelected") + "')){window.open('javascript:document.foDelete.Operation.value=\\'Trash\\';foDelete.submit();" + "', '_self');}")); form.add(new Button(1, "CB", "CBTrashAll", super.r.getString(teasession._nLanguage, "CBTrashAll"),
			 * "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmTrashAll") + "')){window.open('DeleteAllMessage?Operation=TrashAll&Folder=" + s + "', '_self');}")); } form.add(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" +
			 * super.r.getString(teasession._nLanguage, "ConfirmDeleteSelected") + "')){window.open('javascript:foDelete.submit();" + "', '_self');}")); form.add(new Button(1, "CB", "CBDeleteAll", super.r.getString(teasession._nLanguage, "CBDeleteAll"), "if(confirm('" +
			 * super.r.getString(teasession._nLanguage, "ConfirmDeleteAll") + "')){window.open('DeleteAllMessage?Folder=" + s + "', '_self');}")); if(s.equals("Inbox") || s.equals("Trash")) form.add(new Button(1, "CB", "CBBlock", super.r.getString(teasession._nLanguage, "CBBlock"), "if(confirm('" +
			 * super.r.getString(teasession._nLanguage, "ConfirmBlockSelected") + "')){window.open('javascript:document.foDelete.Operation.value=\\'Block\\';foDelete.submit();" + "', '_self');}")); form.add(MessageUI.getMessageFolderSelection(super.r, teasession)); } Cell cell = new Cell();
			 * cell.add(form); Table table1 = MessageUI.getTable(cell, super.r, teasession, request); PrintWriter printwriter = response.getWriter(); printwriter.print(table1); printwriter.close();
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
		super.r.add("tea/ui/member/message/MessageFolders").add("tea/ui/member/message/Messages").add("tea/ui/member/email/EmailBoxs").add("tea/ui/member/contact/CGroups").add("tea/ui/member/messagefolder/ManageMessageFolders");
	}

	public void getEmails(String s, HttpServletRequest request, RV rv, int i, HttpServletResponse response) throws Exception
	{
		TeaSession teasession = new TeaSession(request);
		EmailBox emailbox = EmailBox.find(Integer.parseInt(s));
		String s1 = emailbox.getPop3User();
		String s2 = emailbox.getPop3Passwd();
		HttpSession session = request.getSession(true);
		if (s1 != null)
			session.setAttribute("tea." + rv._strR + "." + s + ".User", s1);
		else
			return;
		if (s2 != null)
			session.setAttribute("tea." + rv._strR + "." + s + ".Passwd", s2);
		else
			return;
		boolean flag = false;
		try
		{
			Folder folder = emailbox.openFolder();
			if (folder != null)
			{
				int j = folder.getMessageCount();
				if (j == 0)
					return;
				javax.mail.Message amessage[] = folder.getMessages();
				FetchProfile fetchprofile = new FetchProfile();
				fetchprofile.add(javax.mail.FetchProfile.Item.ENVELOPE);
				fetchprofile.add("X-mailer");
				folder.fetch(amessage, fetchprofile);
				for (int k = 0; k < amessage.length; k++)
				{
					String s3 = null;
					Object obj = null;
					javax.mail.Address aaddress[];
					if ((aaddress = amessage[k].getFrom()) != null)
					{
						for (int l = 0; l < aaddress.length; l++)
						{
							InternetAddress ia = (InternetAddress) aaddress[l];
							s3 = ia.getAddress();
							String s4 = ia.getPersonal();
						}
					}
					java.util.Date date = amessage[k].getSentDate();
					String s5 = amessage[k].getSubject();
					if (s3.toLowerCase().indexOf("163.com") != -1)
						try
						{
							s5 = new String(s5.getBytes("gb2312"), "ISO-8859-1");
						} catch (Exception exception2)
						{
						}
					if (s5 == null || s5.length() == 0)
						s5 = "<No Subject>";
					int l1 = 0;
					try
					{
						//l1 = Message.create(teasession._strCommunity, rv, s3, false, 0, 0, 0,s,null,null,null,null, i, s5, null, null, null, null, null);
					} catch (Exception exception3)
					{
					}
					Message message = Message.find(l1);
					//message.setTime(date);
					boolean flag1 = false;
					outPart(message, amessage[k], 0, s3, flag1);
				}

				emailbox.closeFolder();
				Socket socket = null;
				PrintWriter printwriter = null;
				BufferedReader bufferedreader = null;
				try
				{
					socket = new Socket(emailbox.getPop3Server(), emailbox.getPop3Port());
					socket.setSoTimeout(30000);
					printwriter = new PrintWriter(socket.getOutputStream(), true);
					bufferedreader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
					bufferedreader.readLine();
					printwriter.println("USER " + s1);
					bufferedreader.readLine();
					printwriter.println("PASS " + s2);
					bufferedreader.readLine();
					for (int i1 = 1; i1 <= j; i1++)
					{
						printwriter.println("DELE " + i1);
						bufferedreader.readLine();
					}

					printwriter.println("QUIT");
					bufferedreader.readLine();
					printwriter.close();
					bufferedreader.close();
					socket.close();
				} catch (Exception exception1)
				{
				} finally
				{
					if (printwriter != null)
						try
						{
							printwriter.close();
						} catch (Exception exception5)
						{
						}
					if (bufferedreader != null)
						try
						{
							bufferedreader.close();
						} catch (Exception exception6)
						{
						}
					if (socket != null)
						try
						{
							socket.close();
						} catch (Exception exception7)
						{
						}
				}
			}
		} catch (Exception exception)
		{
			exception.printStackTrace();
		}
	}

	int outPart(Message message, Part part, int i, String s, boolean flag) throws Exception
	{
		int j = i;
		if (part.isMimeType("text/*"))
		{
			Object obj = part.getContent();
			String s1 = obj.toString();
			String s2 = null;
			try
			{
				s2 = part.getFileName();
			} catch (Exception exception)
			{
			}
			if (s2 != null)
			{
				j++;
				if (s2.toLowerCase().endsWith(".rtf"))
				{
					BufferedInputStream bufferedinputstream1 = new BufferedInputStream((InputStream) obj);
					int i1 = bufferedinputstream1.available();
					byte abyte1[] = new byte[i1];
					bufferedinputstream1.read(abyte1, 0, i1 - 1);
					String path = super.write(message.community, abyte1, ".gif");
					message.createAttachment(j, s2, path);
				} else
				{
					String path = super.write(message.community, s1.getBytes("ISO-8859-1"), ".txt");
					message.createAttachment(j, s2, path);
				}
			} else
			{
				boolean flag1 = false;
				if (flag && s.toLowerCase().indexOf("sina.com") != -1)
					flag1 = true;
				if (s.toLowerCase().endsWith("yahoo.com.cn"))
					flag1 = true;
				if (flag1)
					try
					{
						s1 = new String(s1.getBytes("gb2312"), "ISO-8859-1");
					} catch (Exception exception1)
					{
					}
				//message.setContent(s1);
			}
		} else if (part.isMimeType("multipart/*"))
		{
			flag = true;
			Multipart multipart = (Multipart) part.getContent();
			for (int k = 0; k < multipart.getCount(); k++)
				j = outPart(message, ((Part) (multipart.getBodyPart(k))), j, s, flag);

		} else if (part.isMimeType("message/rfc822"))
		{
			j = outPart(message, (Part) part.getContent(), j, s, flag);
		} else
		{
			Object obj1 = part.getContent();
			if (obj1 instanceof InputStream)
			{
				j++;
				BufferedInputStream bufferedinputstream = new BufferedInputStream((InputStream) obj1);
				int l = bufferedinputstream.available();
				byte abyte0[] = new byte[l];
				bufferedinputstream.read(abyte0, 0, l - 1);

				String path = super.write(message.community, abyte0, ".gif");
				message.createAttachment(j, part.getFileName(), path);
			}
		}
		return j;
	}
}
