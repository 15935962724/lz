// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3)
// Source File Name:   WorkServlet.java

package tea.ui.member.work;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.work.WorkTable;
import tea.html.*;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class WorkServlet extends TeaServlet
{

	public WorkServlet()
	{
	}

	public void service(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
	{
		try
		{
			TeaSession teasession = new TeaSession(request);
			if (teasession._rv == null)
			{
				response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
				return;
			}
			int i = teasession._nLanguage;
			int workno = Integer.parseInt(request.getParameter("Work"));
			WorkTable worktable = WorkTable.find(workno);
			int curStatus = worktable.getStatus();
			if (request.getMethod().equals("GET"))
			{
				Table tiptable = new Table();
				tiptable.setWidth("80%");
				tiptable.setBorder(1);
				tiptable.setCaption(r.getString(i, "StatusTips"));
				Row rr = new Row();
				Cell cc = new Cell();
				cc.add(new Text(r.getString(i, "Status_".concat(String.valueOf(String.valueOf(curStatus))))));
				rr.add(cc);
				tiptable.add(rr);
				Table sendtable = new Table();
				sendtable.setCellSpacing(1);
				sendtable.setCellPadding(3);
				sendtable.setWidth("80%");
				sendtable.setBorder(1);
				Row row1 = new Row();
				Cell cell_11 = new Cell();
				cell_11.setWidth("15%");
				cell_11.add(new Text(r.getString(i, "ProjectName")));
				row1.add(cell_11);
				Cell cell_12 = new Cell();
				cell_12.add(new Text(worktable.getProjectName(i)));
				row1.add(cell_12);
				Cell cell_13 = new Cell();
				cell_13.setWidth("15%");
				cell_13.add(new Text(r.getString(i, "Sender")));
				row1.add(cell_13);
				Cell cell_14 = new Cell();
				cell_14.add(new Text(worktable.getSender()));
				row1.add(cell_14);
				sendtable.add(row1);
				Row row2 = new Row();
				Cell cell_21 = new Cell();
				cell_21.add(new Text(r.getString(i, "PStartDate")));
				row2.add(cell_21);
				Cell cell_22 = new Cell();
				cell_22.add(new Text(worktable.getPStartDate().toString()));
				row2.add(cell_22);
				Cell cell_23 = new Cell();
				cell_23.add(new Text(r.getString(i, "PStopDate")));
				row2.add(cell_23);
				Cell cell_24 = new Cell();
				cell_24.add(new Text(worktable.getPStopDate().toString()));
				row2.add(cell_24);
				sendtable.add(row2);
				Row row3 = new Row();
				Cell cell_31 = new Cell();
				cell_31.add(new Text(r.getString(i, "WorkRequire")));
				row3.add(cell_31);
				Cell cell_32 = new Cell();
				cell_32.setColSpan(3);
				cell_32.add(new Text(worktable.getRequire(i)));
				row3.add(cell_32);
				sendtable.add(row3);
				Row row35 = new Row();
				Cell cell_351 = new Cell();
				cell_351.add(new Text(r.getString(i, "Files")));
				row35.add(cell_351);
				Cell cell_352 = new Cell();
				cell_352.setColSpan(3);
				if (worktable.getFileFlag())
					cell_352.add(new Anchor("WorkFile?Work=".concat(String.valueOf(String.valueOf(workno))), worktable.getFileName()));
				else
					cell_352.add(new Text(r.getString(i, "NoFiles")));
				row35.add(cell_352);
				sendtable.add(row35);
				Row row4 = new Row();
				Cell cell_41 = new Cell();
				cell_41.add(new Text(r.getString(i, "Manager")));
				row4.add(cell_41);
				Cell cell_42 = new Cell();
				cell_42.add(new Text(worktable.getManager()));
				row4.add(cell_42);
				Cell cell_43 = new Cell();
				Cell cell_44 = new Cell();
				if (curStatus == 0 && teasession._rv._strV.equals(worktable.getManager()))
				{
					Form form1 = new Form("form1", "POST", "Work?Work=".concat(String.valueOf(String.valueOf(workno))));
					form1.add(new HiddenField("status", 1));
					form1.add(new Button(r.getString(i, "Grant")));
					cell_43.add(form1);
					Form form2 = new Form("form2", "POST", "Work?Work=".concat(String.valueOf(String.valueOf(workno))));
					form2.add(new HiddenField("status", 10));
					form2.add(new Button(r.getString(i, "Deny")));
					cell_44.add(form2);
				} else if (curStatus >= 1)
				{
					cell_43.add(new Text(r.getString(i, "SignDate")));
					cell_44.add(new Text(worktable.getSendSignDate().toString()));
				} else
				{
					cell_43.add(new Text(r.getString(i, "Waiting")));
					cell_44.add(new Text("......"));
				}
				row4.add(cell_43);
				row4.add(cell_44);
				sendtable.add(row4);
				Table errorTable = new Table();
				Table rtable = new Table();
				if (curStatus != 10)
				{
					if (curStatus >= 1)
					{
						rtable.setCellSpacing(1);
						rtable.setBorder(1);
						rtable.setWidth("80%");
						rtable.setCellPadding(3);
						Row rr1 = new Row();
						Cell cc_11 = new Cell();
						cc_11.add(new Text(r.getString(i, "Reciever")));
						rr1.add(cc_11);
						Cell cc_12 = new Cell();
						cc_12.setColSpan(3);
						cc_12.add(new Text(worktable.getReciever()));
						rr1.add(cc_12);
						rtable.add(rr1);
						Row rr2 = new Row();
						Cell cc_21 = new Cell();
						Cell cc_22 = new Cell();
						Cell cc_23 = new Cell();
						Cell cc_24 = new Cell();
						if (teasession._rv._strV.equals(worktable.getReciever()))
						{
							if (curStatus == 1)
							{
								cc_21.add(new Text(r.getString(i, "BeginWork")));
								Form form3 = new Form("form3", "POST", "Work?Work=".concat(String.valueOf(String.valueOf(workno))));
								form3.add(new HiddenField("status", 2));
								form3.add(new Button(r.getString(i, "BeginWorkButton")));
								cc_22.add(form3);
								cc_22.setColSpan(3);
								rr2.add(cc_21);
								rr2.add(cc_22);
							} else if (curStatus > 1)
							{
								cc_21.add(new Text(r.getString(i, "StartWorkDate")));
								cc_22.add(new Text(worktable.getStartDate().toString()));
								if (curStatus == 2)
								{
									cc_23.add(new Text(r.getString(i, "isWorkStop")));
									Form form4 = new Form("form4", "POST", "Work?Work=".concat(String.valueOf(String.valueOf(workno))));
									form4.add(new HiddenField("status", 3));
									form4.add(new Button(r.getString(i, "WorkFinished")));
									cc_24.add(form4);
								}
								if (curStatus > 2)
								{
									cc_23.add(new Text(r.getString(i, "StopWorkDate")));
									cc_24.add(new Text(worktable.getStopDate().toString()));
								}
								rr2.add(cc_21);
								rr2.add(cc_22);
								rr2.add(cc_23);
								rr2.add(cc_24);
							}
						} else if (curStatus == 1)
						{
							cc_21.add(new Text(r.getString(i, "WorkTableStatus")));
							cc_22.add(new Text(r.getString(i, "Waiting")));
							cc_22.setColSpan(3);
							rr2.add(cc_21);
							rr2.add(cc_22);
						} else if (curStatus > 1)
						{
							cc_21.add(new Text(r.getString(i, "StartWorkDate")));
							cc_22.add(new Text(worktable.getStartDate().toString()));
							if (curStatus == 2)
							{
								cc_23.add(new Text(r.getString(i, "WorkStatus")));
								cc_24.add(new Text(r.getString(i, "Working")));
							}
							if (curStatus > 2)
							{
								cc_23.add(new Text(r.getString(i, "StopWorkDate")));
								cc_24.add(new Text(worktable.getStopDate().toString()));
							}
							rr2.add(cc_21);
							rr2.add(cc_22);
							rr2.add(cc_23);
							rr2.add(cc_24);
						}
						rtable.add(rr2);
						if (curStatus >= 3)
						{
							Row rr3 = new Row();
							Cell cc_31 = new Cell(new Text(" "));
							cc_31.add(new Text(r.getString(i, "CheckOut")));
							Cell cc_32 = new Cell(new Text(" "));
							cc_32.setColSpan(3);
							if (curStatus == 3)
								if (teasession._rv._strV.equals(worktable.getSender()))
								{
									Form form5 = new Form("form5", "POST", "Work?Work=".concat(String.valueOf(String.valueOf(workno))));
									form5.add(new HiddenField("status", 4));
									form5.add(new TextArea("Complete", "", 8, 56));
									form5.add(new Button(r.getString(i, "Submit")));
									cc_32.add(form5);
								} else
								{
									cc_32.add(new Text(r.getString(i, "Waiting")));
								}
							if (curStatus == 4)
								cc_32.add(new Text(worktable.getComplete(i)));
							rr3.add(cc_31);
							rr3.add(cc_32);
							rtable.add(rr3);
						}
					}
				} else
				{
					Row errorRow = new Row();
					Cell errorCell = new Cell();
					Text tt = new Text(r.getString(i, "DenyTable"));
					errorCell.add(tt);
					errorRow.add(errorCell);
					errorTable.add(errorRow);
				}
				PrintWriter printwriter = response.getWriter();
				printwriter.print("<div align=\"center\">");
				printwriter.print(tiptable);
				printwriter.println("<br><br>");
				sendtable.setCaption(r.getString(i, "SendTable"));
				printwriter.print(sendtable);
				if (curStatus >= 1 && curStatus != 10)
				{
					printwriter.println("<br><br>");
					rtable.setCaption(r.getString(i, "RecieveTable"));
					printwriter.print(rtable);
				}
				if (curStatus == 10)
					printwriter.print(errorTable);
				printwriter.print("</div>");
				printwriter.print(new Languages(teasession._nLanguage, request));
				printwriter.close();
			} else
			{
				int _Status = Integer.parseInt(request.getParameter("status"));
				switch (_Status)
				{
				case 1: // '\001'
					worktable.setSendDesignDate();
					worktable.setStatus(_Status);
					break;

				case 2: // '\002'
					worktable.setStartDate();
					worktable.setStatus(_Status);
					break;

				case 3: // '\003'
					worktable.setStopDate();
					worktable.setStatus(_Status);
					break;

				case 4: // '\004'
					String completee = request.getParameter("Complete");
					worktable.setCompleteDate();
					worktable.setComplete(completee);
					worktable.setStatus(_Status);
					break;

				case 10: // '\n'
					worktable.setSendDesignDate();
					worktable.setStatus(_Status);
					break;
				}
				response.sendRedirect("Work?Work=".concat(String.valueOf(String.valueOf(workno))));
			}
		} catch (Exception exception)
		{
		}
	}

	public void init(ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
		r.add("tea/ui/member/work/WorkServle");
	}
}
