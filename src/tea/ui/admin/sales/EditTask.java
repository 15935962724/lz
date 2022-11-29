package tea.ui.admin.sales;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.entity.admin.*;
import tea.entity.admin.sales.*;
import tea.entity.member.*;
import jxl.write.*;
import tea.entity.RV;

public class EditTask extends TeaServlet
{

    // Initialize global variables
    public void init() throws ServletException
    {
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        try
        {
            String act = teasession.getParameter("act");
            String nexturl = teasession.getParameter("nexturl");

            int taid = 0;
            String _strTaid = teasession.getParameter("taid");
            if (_strTaid != null && _strTaid.length() > 0)
            {
                taid = Integer.parseInt(_strTaid);
            }
            // 修改任务的状态
            if ("zhuangtai".equals(act))
            {
                Task taobj = Task.find(taid);
                Date time = new Date();

                int fettle = Integer.parseInt(teasession.getParameter("fettle"));
                int wearhours = Integer.parseInt(teasession.getParameter("wearhours"));
                int wearminutes = Integer.parseInt(teasession.getParameter("wearminutes")); // 完成任务耗时
                String ztcontent = teasession.getParameter("ztcontent");

                String subject = taobj.getMotif(); // 任务主题
                int worklog = taobj.getWorklog();

                String content = subject + "," + ztcontent; // 完成情况
                if (worklog > 0)
                {
                    Worklog work1 = Worklog.find(worklog);
                    work1.set(taobj.getFlowitem(), "", 0, time, false, content, 0, "", false, false, wearhours, wearminutes);
                } else if (fettle == 2)
                {
                    worklog = Worklog.create(teasession._strCommunity, teasession._rv._strV, taobj.getFlowitem(), "", 0, time, false, content, 0, "", "", "", false, false, wearhours, wearminutes);
                }
                taobj.set(fettle, taid, teasession._strCommunity, ztcontent, worklog);

                response.sendRedirect(nexturl);
                return;
            } else if ("edittaskconsign".equals(act))
            {
                String consign = request.getParameter("consign");
                if (consign != null && consign.length() > 2)
                {
                    TaskConsign.create(taid, teasession._rv.toString(), consign);
                }
                response.sendRedirect(nexturl);
                return;
            } else if ("deletetaskconsign".equals(act))
            {
                TaskConsign tc = TaskConsign.find(taid, teasession._rv._strV);
                tc.delete();
                response.sendRedirect(nexturl);
                return;
            } else if ("exporttask".equals(act)) // 客户提交需求->导出excel
            {
                response.setContentType("application/x-msdownload");
                response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode(request.getServerName() + ".xls", "UTF-8"));

                String motif = request.getParameter("motif");
                String attime = request.getParameter("attime");
                int fettle = Integer.parseInt(request.getParameter("fettle"));
                String sql = request.getParameter("sql");

                WritableWorkbook wwb = jxl.Workbook.createWorkbook(response.getOutputStream());
                WritableSheet ws = wwb.createSheet(request.getServerName(), 1);
                ws.addCell(new Label(0, 0, "任务主题"));
                ws.addCell(new Label(1, 0, "状态"));
                ws.addCell(new Label(2, 0, "创建时间"));
                ws.addCell(new Label(3, 0, "任务接纳人"));
                ws.addCell(new Label(4, 0, "所属项目"));

                Enumeration e = Task.findByCommunity(teasession._strCommunity, sql, 0, Integer.MAX_VALUE);
                for (int i = 1; e.hasMoreElements(); i++)
                {
                    int id = ((Integer) e.nextElement()).intValue();
                    Task obj = Task.find(id);
                    Flowitem fobj = Flowitem.find(obj.getFlowitem());

                    ws.addCell(new Label(0, i, obj.getMotif()));
                    ws.addCell(new Label(1, i, Task.FETTLE[obj.getFettle()]));
                    ws.addCell(new Label(2, i, obj.getTimes().toString()));
                    ws.addCell(new Label(3, i, obj.getAssigneridToString(teasession._nLanguage)));
                    ws.addCell(new Label(4, i, fobj.getName(teasession._nLanguage)));
                }
                wwb.write();
                wwb.close();
                return;
            }
            Task taobj = Task.find(taid);
            String assigner = teasession.getParameter("assigner");
            String motif = teasession.getParameter("motif");
            Date attime = null;
            if (teasession.getParameter("attime") != null && teasession.getParameter("attime").length() > 0)
            {
                attime = Task.sdf.parse(teasession.getParameter("attime"));
            }
            String remark = teasession.getParameter("remark");
            int fettle = 0;
            if (teasession.getParameter("fettle") != null && teasession.getParameter("fettle").length() > 0)
            {
                fettle = Integer.parseInt(teasession.getParameter("fettle"));
            }
            int pri = 0;
            if (teasession.getParameter("pri") != null && teasession.getParameter("pri").length() > 0)
            {
                pri = Integer.parseInt(teasession.getParameter("pri"));
            }
            String assignerid = teasession.getParameter("assignerid");
            assignerid = "/" + assignerid + "/";
            int flowitem = 0; // 项目的ID号
            if (teasession.getParameter("flowitem") != null && teasession.getParameter("flowitem").length() > 0)
            {
                flowitem = Integer.parseInt(teasession.getParameter("flowitem"));
            }

            String acceefile = "";
            byte by[] = teasession.getBytesParameter("acceefile"); // 附件的路径
            String acceename = teasession.getParameter("acceefileName"); // 附件的原名字

            if (teasession.getParameter("clear1") != null)
            {
                acceefile = "";
            } else if (by != null)
            {
                acceefile = write(teasession._strCommunity, by, ".gif");
            } else
            {
                acceefile = taobj.getAcceefile();
                acceename = taobj.getAcceename();
            }
            String str = "/jsp/admin/sales/task.jsp";

            if ("clien".equals(act)) // 判断是否为客户
            {
                Flowitem flobj = Flowitem.find(flowitem);
                assignerid = flobj.getManager(); // 项目经理的用户
                str = "/jsp/admin/sales/clienttask.jsp";
            }
            int taskfrequency = 0;
            if (teasession.getParameter("Taskfrequency") != null && teasession.getParameter("Taskfrequency").length() > 0)
            {
                taskfrequency = Integer.parseInt(teasession.getParameter("Taskfrequency"));
            }
            /*********任务频率添加的地方**/
            int datefq = 0;
            String _strDatefq = teasession.getParameter("datefq");
            if (_strDatefq != null && _strDatefq.length() > 0)
            {
                datefq = Integer.parseInt(_strDatefq);
            }
            int frequency = 0;
            if (teasession.getParameter("frequency") != null && teasession.getParameter("frequency").length() > 0)
            {
                frequency = Integer.parseInt(teasession.getParameter("frequency"));
            }
            String week = null;
            StringBuilder weeks = new StringBuilder();
            int month = 0;
            if (teasession.getParameter("month") != null && teasession.getParameter("month").length() > 0)
            {
                month = Integer.parseInt(teasession.getParameter("month"));
            }
            Date expressdate = null;
            if (teasession.getParameter("expressdate") != null && teasession.getParameter("expressdate").length() > 0)
            {
                expressdate = Taskfrequency.sdf.parse(teasession.getParameter("expressdate"));
            }
            Date Enddatetime = null;
            if (teasession.getParameter("Enddatetime") != null && teasession.getParameter("Enddatetime").length() > 0)
            {
                String da=teasession.getParameter("Enddatetime");
                Enddatetime = Taskfrequency.sdf.parse(teasession.getParameter("Enddatetime"));
            } else
            {
                Enddatetime = Taskfrequency.sdf.parse("2017-01-01");
            }
            int task = 0;
            if (teasession.getParameter("task") != null && teasession.getParameter("task").length() > 0)
            {
                task = Integer.parseInt(teasession.getParameter("task"));
            }

            if (taid > 0)
            {
                if (datefq == 1) //yes
                {
                    for (int i = 0; i < Taskfrequency.WEEKS.length; i++)
                    {
                        String its = teasession.getParameter("week" + i);
                        if (its != null)
                        {
                            weeks.append("/" + its);
                        }
                        week = weeks.toString();
                    }
                }

                taobj.set(assigner, motif, attime, remark, fettle, pri, teasession._rv.toString(), teasession._strCommunity, assignerid, flowitem, acceefile, acceename);
                Taskfrequency.set(assigner, motif, attime, remark, fettle, pri, teasession._rv.toString(), teasession._strCommunity, assignerid, flowitem, acceefile, acceename, frequency, datefq, week, month, expressdate, task, Enddatetime, taskfrequency);
            } else
            {
                if (datefq == 1) //yes
                {
                    for (int i = 0; i < Taskfrequency.WEEKS.length; i++)
                    {
                        String its = teasession.getParameter("week" + i);
                        if (its != null)
                        {
                            weeks.append("/" + its);
                        }
                        week = weeks.toString();
                    }
                    Taskfrequency.create(assigner, motif, attime, remark, fettle, pri, teasession._rv.toString(), teasession._strCommunity, assignerid, flowitem, acceefile, acceename, frequency, datefq, week, month, expressdate, task, Enddatetime);
                    int num = Taskfrequency.backnum();
                    Task.createTask(assigner, motif, attime, remark, fettle, pri, teasession._rv.toString(), teasession._strCommunity, assignerid, flowitem, acceefile, acceename, num, datefq);

                } else
                {

                    Task.create(assigner, motif, attime, remark, fettle, pri, teasession._rv.toString(), teasession._strCommunity, assignerid, flowitem, acceefile, acceename);
                    ////////////发送站内消息/////////////////////////////////
                    String as[] = assignerid.split("/");
                    for (int i = 1; i < as.length; i++)
                    {
                        Message.create(teasession._strCommunity, teasession._rv._strV, as[i], teasession._nLanguage, teasession._rv + " 给您下达了新任务", motif);
                    }
                }
            }
            response.sendRedirect(str);
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }

    // Clean up resources
    public void destroy()
    {
    }
}
