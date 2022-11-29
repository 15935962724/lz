package tea.ui.member.work;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.work.WorkTable;
import tea.html.*;
import tea.htmlx.*;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class WorkTableStatus extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse httpservletreponse) throws IOException,ServletException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                httpservletreponse.sendRedirect("/servlet/StartLogin?community=" + teasession._strCommunity);
                return;
            }
            String ssend = request.getParameter("Senders");
            String sreciever = request.getParameter("Recievers");
            String month = request.getParameter("Month");
            String day = request.getParameter("Day");
            String year = request.getParameter("Year");
            String sp = request.getParameter("Pos");
            int pos = sp != null ? Integer.parseInt(sp) : 0;
            String s = request.getParameter("Found");
            String ign = request.getParameter("Ignore");
            boolean flag = s != null;
            int n = 0;
            boolean flagignore = ign == null;
            PrintWriter printwriter = httpservletreponse.getWriter();
            Form form = new Form("foToo","POST","");
            Cell cell0 = new Cell(super.r.getString(teasession._nLanguage,"WorkTableStatus"));
            cell0.setAlign(2);
            form.add(new Row(cell0));
            form.add(new Break());
            form.add(new Row(new Cell(new Text("<hr>"))));
            Table table = new Table();
            table.setAlign(2);
            table.setWidth("750");
            table.setCols(5);
            table.setCellSpacing(1);
            table.setBorder(1);
            table.setId("WorkTableStatus");
            Cell cell10 = new Cell(new Text(super.r.getString(teasession._nLanguage,"ProjectName")));
            cell10.setWidth("20%");
            cell10.setAlign(2);
            Cell cell11 = new Cell(new Text(super.r.getString(teasession._nLanguage,"Sender")));
            cell11.setWidth("20%");
            cell11.setAlign(2);
            Cell cell12 = new Cell(new Text(super.r.getString(teasession._nLanguage,"Manager")));
            cell12.setWidth("20%");
            cell12.setAlign(2);
            Cell cell13 = new Cell(new Text(super.r.getString(teasession._nLanguage,"Reciever")));
            cell13.setWidth("20%");
            cell13.setAlign(2);
            Cell cell14 = new Cell(new Text(super.r.getString(teasession._nLanguage,"Status")));
            cell14.setWidth("20%");
            cell14.setAlign(2);
            Row row1 = new Row(cell10);
            row1.add(cell11);
            row1.add(cell12);
            row1.add(cell13);
            row1.add(cell14);
            row1.setId("WorkTableStatusRow");
            table.add(row1);

            for(Enumeration enu = WorkTable.findManagerStatus(teasession._rv._strV);enu.hasMoreElements();)
            {
                Row row2;
                int works = ((Integer) enu.nextElement()).intValue();
                WorkTable worktable = WorkTable.find(works);
                String projectname = worktable.getProjectName(teasession._nLanguage);
                String sender = worktable.getSender();
                String reciever = worktable.getReciever();
                String manager = worktable.getManager();
                int status = worktable.getStatus();
                Cell cell20 = new Cell(super.r.getString(teasession._nLanguage,projectname));
                cell20.setAlign(2);
                cell20.setWidth("20%");
                Cell cell21 = new Cell(sender);
                cell21.setAlign(2);
                cell21.setWidth("20%");
                Cell cell22 = new Cell(manager);
                cell22.setAlign(2);
                cell22.setWidth("20%");
                Cell cell23 = new Cell(reciever);
                cell23.setAlign(2);
                cell23.setWidth("20%");
                Cell cell24 = new Cell(new Anchor("Work?Work=".concat(String.valueOf(String.valueOf(works))),super.r.getString(teasession._nLanguage,"PleaseWaitManagerDesign")));
                cell21.setAlign(2);
                cell21.setWidth("20%");
                row2 = new Row(cell20);
                row2.add(cell21);
                row2.add(cell22);
                row2.add(cell23);
                row2.add(cell24);
                row2.setId("WorkTableStatusRow1");
                table.add(row2);
            }

            for(Enumeration enu = WorkTable.findRecieverStatus(teasession._rv._strV);enu.hasMoreElements();)
            {
                Row row2;
                int works = ((Integer) enu.nextElement()).intValue();
                WorkTable worktable = WorkTable.find(works);
                String projectname = worktable.getProjectName(teasession._nLanguage);
                String sender = worktable.getSender();
                String reciever = worktable.getReciever();
                String manager = worktable.getManager();
                int status = worktable.getStatus();
                Cell cell20 = new Cell(super.r.getString(teasession._nLanguage,projectname));
                cell20.setAlign(2);
                cell20.setWidth("20%");
                Cell cell21 = new Cell(sender);
                cell21.setAlign(2);
                cell21.setWidth("20%");
                Cell cell22 = new Cell(manager);
                cell22.setAlign(2);
                cell22.setWidth("20%");
                Cell cell23 = new Cell(reciever);
                cell23.setAlign(2);
                cell23.setWidth("20%");
                Cell cell24 = new Cell();
                cell21.setAlign(2);
                cell21.setWidth("20%");
                switch(status)
                {
                case 1: // '\001'
                    cell24.add(new Anchor("Work?Work=".concat(String.valueOf(String.valueOf(works))),super.r.getString(teasession._nLanguage,"PleaseRecieverDesign")));
                    break;

                case 2: // '\002'
                    cell24.add(new Anchor("Work?Work=".concat(String.valueOf(String.valueOf(works))),super.r.getString(teasession._nLanguage,"PleaseFillInCompleteDate")));
                    break;
                }
                row2 = new Row(cell20);
                row2.add(cell21);
                row2.add(cell22);
                row2.add(cell23);
                row2.add(cell24);
                row2.setId("WorkTableStatusRow1");
                table.add(row2);
            }

            for(Enumeration enu = WorkTable.findSenderStatus(teasession._rv._strV);enu.hasMoreElements();)
            {
                Row row2;
                int works = ((Integer) enu.nextElement()).intValue();
                WorkTable worktable = WorkTable.find(works);
                String projectname = worktable.getProjectName(teasession._nLanguage);
                String sender = worktable.getSender();
                String reciever = worktable.getReciever();
                String manager = worktable.getManager();
                int status = worktable.getStatus();
                Cell cell20 = new Cell(super.r.getString(teasession._nLanguage,projectname));
                cell20.setAlign(2);
                cell20.setWidth("20%");
                Cell cell21 = new Cell(sender);
                cell21.setAlign(2);
                cell21.setWidth("20%");
                Cell cell22 = new Cell(manager);
                cell22.setAlign(2);
                cell22.setWidth("20%");
                Cell cell23 = new Cell(reciever);
                cell23.setAlign(2);
                cell23.setWidth("20%");
                Cell cell24 = new Cell(new Anchor("Work?Work=".concat(String.valueOf(String.valueOf(works))),super.r.getString(teasession._nLanguage,"PleaseFillInCompleteStatus")));
                cell21.setAlign(2);
                cell21.setWidth("20%");
                row2 = new Row(cell20);
                row2.add(cell21);
                row2.add(cell22);
                row2.add(cell23);
                row2.add(cell24);
                row2.setId("WorkTableStatusRow1");
                table.add(row2);
            }

            Button btn = new Button("",super.r.getString(teasession._nLanguage,"Return"),"history.back()");
            btn.setType(1);
            Cell cell3 = new Cell();
            cell3.add(btn);
            cell3.setAlign(2);
            cell3.setColSpan(5);
            cell3.setId("WorkTableStatusRow");
            table.add(new Row(cell3));
            form.add(table);
            Form form1 = new Form("foNew","POST","WorkTableStatus");
            form1.add(new HiddenField("Found","ON"));
            Cell cell4 = new Cell(super.r.getString(teasession._nLanguage,"WorkTableSearch"));
            cell4.setWidth("750");
            cell4.setAlign(2);
            form1.add(new Row(cell4));
            form1.add(new Row(new Cell(new Text("<hr>"))));
            Table table1 = new Table();
            table1.setAlign(2);
            table1.setWidth("750");
            Cell cell50 = new Cell(super.r.getString(teasession._nLanguage,"Sender"));
            cell50.setAlign(2);
            cell50.setWidth("25%");
            cell50.add(new TextField("Senders","",8,20));
            Cell cell51 = new Cell(super.r.getString(teasession._nLanguage,"Reciever"));
            cell51.setAlign(2);
            cell51.setWidth("25%");
            cell51.add(new TextField("Recievers","",8,20));
            Cell cell52 = new Cell(super.r.getString(teasession._nLanguage,"IgnoreDate"));
            cell52.setAlign(2);
            cell52.setWidth("35%");
            cell52.add(new CheckBox("Ignore",false));
            cell52.add(new tea.htmlx.TimeSelectionForSearch("",new Date(),true,false));
            Cell cell53 = new Cell(new Button(super.r.getString(teasession._nLanguage,"Search")));
            cell53.setAlign(2);
            cell53.setWidth("15%");
            Row row5 = new Row(cell50);
            row5.add(cell51);
            row5.add(cell52);
            row5.add(cell53);
            table1.add(row5);
            form1.add(table1);
            if(flag)
            {
                String days[] = new String[3];
                if(month != null)
                {
                    days[0] = month;
                }
                if(day != null)
                {
                    days[1] = day;
                }
                if(year != null)
                {
                    days[2] = year;
                }
                n = WorkTable.countSearch(ssend,sreciever,days,flagignore);
                if(n != 0)
                {
                    Cell cell7 = new Cell(super.r.getString(teasession._nLanguage,"Result"));
                    cell7.setAlign(2);
                    form1.add(new Row(cell7));
                    form1.add(new Row(new Cell(new Text("<hr>"))));
                    Table table2 = new Table();
                    table2.setAlign(2);
                    table2.setWidth("750");
                    table2.setCols(5);
                    table2.setCellSpacing(1);
                    table2.setBorder(1);
                    table2.setId("WorkTableStatus");
                    Cell cell60 = new Cell(new Text(super.r.getString(teasession._nLanguage,"ProjectName")));
                    cell60.setWidth("20%");
                    cell60.setAlign(2);
                    Cell cell61 = new Cell(new Text(super.r.getString(teasession._nLanguage,"Sender")));
                    cell61.setWidth("20%");
                    cell61.setAlign(2);
                    Cell cell62 = new Cell(new Text(super.r.getString(teasession._nLanguage,"Manager")));
                    cell62.setWidth("20%");
                    cell62.setAlign(2);
                    Cell cell63 = new Cell(new Text(super.r.getString(teasession._nLanguage,"Reciever")));
                    cell63.setWidth("20%");
                    cell63.setAlign(2);
                    Cell cell64 = new Cell(new Text(super.r.getString(teasession._nLanguage,"Status")));
                    cell64.setWidth("20%");
                    cell64.setAlign(2);
                    Row row6 = new Row(cell10);
                    row6.add(cell11);
                    row6.add(cell12);
                    row6.add(cell13);
                    row6.add(cell14);
                    row6.setId("WorkTableStatusRow");
                    table2.add(row6);

                    for(Enumeration enu = WorkTable.findSearch(ssend,sreciever,days,flagignore,pos,15);enu.hasMoreElements();)
                    {
                        Row row2;
                        int works = ((Integer) enu.nextElement()).intValue();
                        WorkTable worktable = WorkTable.find(works);
                        String projectname = worktable.getProjectName(teasession._nLanguage);
                        String sender = worktable.getSender();
                        String reciever = worktable.getReciever();
                        String manager = worktable.getManager();
                        int status = worktable.getStatus();
                        Cell cell20 = new Cell(super.r.getString(teasession._nLanguage,projectname));
                        cell20.setAlign(2);
                        cell20.setWidth("20%");
                        Cell cell21 = new Cell(sender);
                        cell21.setAlign(2);
                        cell21.setWidth("20%");
                        Cell cell22 = new Cell(manager);
                        cell22.setAlign(2);
                        cell22.setWidth("20%");
                        Cell cell23 = new Cell(reciever);
                        cell23.setAlign(2);
                        cell23.setWidth("20%");
                        Cell cell24 = new Cell();
                        cell21.setAlign(2);
                        cell21.setWidth("20%");
                        switch(status)
                        {
                        case 0: // '\0'
                            cell24.add(new Anchor("Work?Work=".concat(String.valueOf(String.valueOf(works))),super.r.getString(teasession._nLanguage,"PleaseWaitManagerDesign")));
                            break;

                        case 1: // '\001'
                            cell24.add(new Anchor("Work?Work=".concat(String.valueOf(String.valueOf(works))),super.r.getString(teasession._nLanguage,"PleaseRecieverDesign")));
                            break;

                        case 2: // '\002'
                            cell24.add(new Anchor("Work?Work=".concat(String.valueOf(String.valueOf(works))),super.r.getString(teasession._nLanguage,"PleaseFillInCompleteDate")));
                            break;

                        case 3: // '\003'
                            cell24.add(new Anchor("Work?Work=".concat(String.valueOf(String.valueOf(works))),super.r.getString(teasession._nLanguage,"PleaseFillInCompleteStatus")));
                            break;

                        case 4: // '\004'
                            cell24.add(new Anchor("Work?Work=".concat(String.valueOf(String.valueOf(works))),super.r.getString(teasession._nLanguage,"WorkTableComplete")));
                            break;

                        case 10: // '\n'
                            cell24.add(new Anchor("Work?Work=".concat(String.valueOf(String.valueOf(works))),super.r.getString(teasession._nLanguage,"ManagerNotAgree")));
                            break;
                        }
                        row2 = new Row(cell20);
                        row2.add(cell21);
                        row2.add(cell22);
                        row2.add(cell23);
                        row2.add(cell24);
                        row2.setId("WorkTableStatusRow1");
                        table2.add(row2);
                    }

                    form1.add(table2);
                }
            }
            printwriter.print(form);
            printwriter.print(form1);
            printwriter.print(new Languages(teasession._nLanguage,request));
            if(flagignore)
            {
                FPNL fpnl = new FPNL(teasession._nLanguage,String.valueOf(String.valueOf((new StringBuilder("WorkTableStatus?Found=ON&Ignore=true&Senders=")).append(ssend).append("&Recievers=").append(sreciever).append("&Pos="))),pos,n);
                fpnl.setPage(15);
                printwriter.print(fpnl);
            } else
            {
                FPNL fpnl = new FPNL(teasession._nLanguage,String.valueOf(String.valueOf((new StringBuilder("WorkTableStatus?Found=ON&Senders=")).append(ssend).append("&Recievers=").append(sreciever).append("&Month=").append(month).append("&Day=").append(day).append("&Year=").append(year).append("&Pos="))),pos,n);
                fpnl.setPage(15);
                printwriter.print(fpnl);
            }
            printwriter.close();
        } catch(Exception exception)
        {
            httpservletreponse.sendError(400,exception.toString());
            exception.printStackTrace();
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/member/work/WorkTableStatus");
    }
}
