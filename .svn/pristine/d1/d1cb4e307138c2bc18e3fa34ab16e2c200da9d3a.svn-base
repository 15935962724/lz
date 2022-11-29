package tea.ui.member.community;

import java.io.IOException;
import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.*;
import tea.entity.site.*;
import tea.entity.member.*;
import tea.ui.*;
import tea.service.*;

public class Subscribers extends TeaServlet
{

	public void init(ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
		super.r.add("/tea/ui/member/community/Communities").add("/tea/ui/member/community/OrganizingCommunities").add("/tea/ui/member/community/Subscribers");
	}

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		try
		{
			TeaSession teasession = new TeaSession(request);
			if (teasession._rv == null)
			{
				response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
				return;
			}
			if (request.getMethod().equals("GET"))
			{
				/*
				 * Form form = new Form("foDelete", "GET", "DeleteSubscribers"); form.add(new HiddenField("Community", s)); Table table = new Table(); table.setCellSpacing(5); int j = Subscriber.count(s); table.setCaption(j + " " + super.r.getString(teasession._nLanguage, "Subscribers")); if (j != 0) { boolean flag = true; Row row = new Row(); row.add(new Cell(new Text(super.r.getString(teasession._nLanguage, "To") + " "))); row.add(new Cell(new Text(" "))); row.add(new Cell(new
				 * Text(super.r.getString(teasession._nLanguage, "CcMembers") + " "))); row.add(new Cell(new Text(" "))); row.add(new Cell(new Text(super.r.getString(teasession._nLanguage, "Bcc") + " "))); row.add(new Cell(new Text(" "))); row.add(new Cell(new Text(super.r.getString(teasession._nLanguage, "Delete") + " "))); row.add(new Cell(new Text(super.r.getString(teasession._nLanguage, " ")))); table.add(row); Row row1; for (Enumeration enumeration = Subscriber.find(s, i, byte0);
				 * enumeration.hasMoreElements(); table.add(row1)) { RV rv = (RV) enumeration.nextElement(); String s2 = rv.toString(); row1 = new Row(); row1.add(new Cell(new CheckBox("to", false, s2))); row1.add(new Cell(new Text(" "))); row1.add(new Cell(new CheckBox("cc", false, s2))); row1.add(new Cell(new Text(" "))); row1.add(new Cell(new CheckBox("bcc", false, s2))); row1.add(new Cell(new Text(" "))); row1.add(new Cell(new CheckBox(s2, false))); row1.add(new Cell(getRvDetail(rv,
				 * teasession._nLanguage,request.getContextPath()))); row1.add(new HiddenField("Subscribers", s2)); row1.setId(flag ? "OddRow" : "EvenRow"); flag ^= true; } } form.add(table); PrintWriter printwriter = response.getWriter(); printwriter.print(text); printwriter.print(form); printwriter.print(new FPNL(teasession._nLanguage, "Subscribers?Community=" + s + "&Pos=", i, j, byte0)); printwriter.print(new Button(1, "CB", "CBInsertMemberID",
				 * super.r.getString(teasession._nLanguage, "CBInsertMemberID"), "window.open('javascript:insertMemberID();', '_self');")); if (teasession._rv.isWebMaster() || teasession._rv.isOrganizer(s)) { printwriter.print(new Button(1, "CB", "CBNew", super.r.getString(teasession._nLanguage, "CBNew"), "window.open('NewSubscribers?Community=" + s + "', '_self');")); if (j != 0) { printwriter.print(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"),
				 * "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDeleteSelected") + "')){window.open('javascript:foDelete.submit();" + "', '_self');}")); printwriter.print(new Button(1, "CB", "CBDeleteAll", super.r.getString(teasession._nLanguage, "CBDeleteAll"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDeleteAll") + "')){window.open('DeleteAllSubscribers?Community=" + s + "', '_self');}")); } } printwriter.print(new Languages(teasession._nLanguage,
				 * request)); printwriter.close();
				 */
				response.sendRedirect("/jsp/community/Subscribers.jsp?community=" + teasession._strCommunity);
			} else
			{
				String members[] = request.getParameterValues("members");
				if (request.getParameter("export") != null || request.getParameter("exportall") != null)
				{
					response.setContentType("application/x-msdownload");
					response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("file.xls", "UTF-8"));
					java.io.OutputStream os = response.getOutputStream();
					jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
					jxl.write.WritableSheet ws = wwb.createSheet("工作表1", 0);
					try
					{
						Communitysubscriber cs = Communitysubscriber.find(teasession._strCommunity);
						String exports[] = cs.getExports().split("/");
						for (int i = 1; i < exports.length; i++)
						{
							ws.addCell(new jxl.write.Label(i - 1, 0, r.getString(teasession._nLanguage, cs.FIELD_TYPE[Integer.parseInt(exports[i])])));
						}
						if (request.getParameter("exportall") != null)
						{ // fm1073,指定要安注册时间降序
							java.util.Enumeration e = Subscriber.find(teasession._strCommunity, " ORDER BY time DESC", 0, Integer.MAX_VALUE); //
							for (int i = 1; e.hasMoreElements(); i++)
							{
								RV rv = (RV) e.nextElement();
								export(teasession._strCommunity, rv._strV, exports, teasession._nLanguage, ws, i);
							}
						} else if (members != null)
						{
							for (int i = 0; i < members.length; i++)
							{
								export(teasession._strCommunity, members[i], exports, teasession._nLanguage, ws, i + 1);
							}
						}
					} finally
					{
						wwb.write();
						wwb.close();
						os.close();
					}
					return;
				} else if (members != null)
				{
					for (int i = 0; i < members.length; i++)
					{
						Subscriber s = Subscriber.find(teasession._strCommunity, new RV(members[i]));
						Profile p = Profile.find(members[i]);
						if (request.getParameter("clearpassword") != null)
						{
							p.setPassword("111111");
						} else
						{
							Community c = Community.find(teasession._strCommunity);
							String subject = null;
							StringBuilder sb = new StringBuilder();
							if (request.getParameter("delete") != null)
							{
								s.delete();
								// p.delete(teasession._nLanguage);
								subject = c.getName(teasession._nLanguage) + ":审核不通过";
								sb.append(p.getLastName(teasession._nLanguage)).append(p.getFirstName(teasession._nLanguage)).append("先生/女士,您好,您在<a href=http://").append(request.getServerName()).append(" target=_blank>").append(c.getName(teasession._nLanguage)).append("</a>网站注册的用户,没有通过了管理人员的审核.");
							} else if (request.getParameter("auditing") != null)
							{
								String year = request.getParameter(members[i] + "_termYear");
								if (year != null)
								{
									java.util.Date term = p.sdf.parse(year + "-" + request.getParameter(members[i] + "_termMonth") + "-" + request.getParameter(members[i] + "_termDay"));
									s.setTerm(term);
									subject = c.getName(teasession._nLanguage) + ":审核通过";
									sb.append(p.getLastName(teasession._nLanguage)).append(p.getFirstName(teasession._nLanguage)).append("先生/女士,您好,您在<a href=http://").append(request.getServerName()).append(" target=_blank>").append(c.getName(teasession._nLanguage)).append("</a>网站注册的用户,已通过了管理人员的审核,欢迎您随时进行相关的操作.");
								}
							}
							if (subject != null)
							{
								sb.insert(0, c.getMailBefore(teasession._nLanguage));
								sb.append(c.getMailAfter(teasession._nLanguage));

								Email.create(teasession._strCommunity,null,p.getEmail(), subject, sb.toString());
							}
						}
					}
				}
				response.sendRedirect("/jsp/info/Succeed.jsp?nexturl=" + java.net.URLEncoder.encode("/jsp/community/Subscribers.jsp?community=" + teasession._strCommunity, "UTF-8"));
			}
		} catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
	}

	private void export(String community, String member, String exports[], int language, jxl.write.WritableSheet ws, int i) throws Exception
	{
		Profile p = Profile.find(member);
		Class c = p.getClass();
		for (int j = 1; j < exports.length; j++)
		{
			int field = Integer.parseInt(exports[j]);
			String _strField = Communitysubscriber.FIELD_TYPE[Integer.parseInt(exports[j])];

			String value;
			if (field == 0)
			{
				value = p.getMember();
			} else if (field == 3)
			{
				value = p.getBirthToString();
			} else if (field == 5)
			{
				value = r.getString(language, p.isSex() ? "Man" : "Woman");
			} else
			{
				if (field < 30)
				{
					java.lang.reflect.Method m = c.getMethod("get" + _strField, (Class[]) null);
					value = (String) m.invoke(p, (Object[]) null);
				} else
				{
					java.lang.reflect.Method m = c.getMethod("get" + _strField, new Class[]{Class.forName("java.lang.Integer")});
					value = (String) m.invoke(p, new Object[] { new Integer(language) });
				}
			}
			ws.addCell(new jxl.write.Label(j - 1, i, value));
		}
	}
}
