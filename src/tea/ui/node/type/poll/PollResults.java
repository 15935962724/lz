package tea.ui.node.type.poll;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.node.*;
import tea.html.*;
import tea.htmlx.FPNL;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.db.DbAdapter;

public class PollResults extends TeaServlet
{

    public PollResults()
    {
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

            String act = teasession.getParameter("act");
            if ("export".equals(act))
            {
                response.setContentType("application/x-msdownload");
                response.setHeader("Content-Disposition", "attachment; filename=" + new String("投票结果-1.xls".getBytes("GBK"), "ISO-8859-1"));

                int poll = Integer.parseInt(request.getParameter("poll"));
                jxl.write.WritableWorkbook wb = jxl.Workbook.createWorkbook(response.getOutputStream());
                jxl.write.WritableSheet ws = wb.createSheet("work", 1);
                int cols = 0;
                ws.addCell(new jxl.write.Label(cols++, 0, "会员ID"));
                ws.addCell(new jxl.write.Label(cols++, 0, "积分"));
                StringBuilder sb = new StringBuilder("/");
                java.util.Enumeration enumeration3 = Poll.find(" AND node=" + poll); // AND type=2
                while (enumeration3.hasMoreElements())
                {
                    int poll_id = ((Integer) enumeration3.nextElement()).intValue();
                    sb.append(poll_id).append("/");
                    Poll poll_obj = Poll.find(poll_id);
                    ws.addCell(new jxl.write.Label(cols++, 0, poll_obj.getQuestion()));
                }
                ws.addCell(new jxl.write.Label(cols, 0, "时间"));
                String ps[] = sb.toString().split("/");
                DbAdapter db = new DbAdapter();
                try
                {
                    db.executeQuery("SELECT DISTINCT vmember FROM PollResult WHERE node=" + poll);
                    for (int rows = 1; db.next(); rows++)
                    {
                        String member = db.getString(1);
                        cols = 0;
                        String name = member;
                        if (member.length() == 32 && member.equals(member.toUpperCase()))
                        {
                            name = "匿名";
                        }
                        //会员ID
                        ws.addCell(new jxl.write.Label(cols++, rows, name));

                        ///积分
                        PollPoint pp_obj = PollPoint.find(poll, member);
                        ws.addCell(new jxl.write.Number(cols++, rows, pp_obj.getPoint()));

                        String time = null;
                        for (int i = 1; i < ps.length; i++)
                        {
                            PollResult obj = PollResult.find(Integer.parseInt(ps[i]), member);
                            String value;
                            if (obj.getAnswer() > 0)
                            {
                                value = PollChoice.find(obj.getAnswer()).getChoice();
                            } else
                            {
                                value = obj.getText(teasession._nLanguage);
                            }
                            ws.addCell(new jxl.write.Label(cols++, rows, value));
                            time = obj.getTimeToString();
                        }
                        if (time == null || time.length() < 1)
                        {
                            java.util.Enumeration enumeration5 = Poll.find(" AND node=" + poll);
                            if (enumeration5.hasMoreElements())
                            {
                                int poll_id = ((Integer) enumeration5.nextElement()).intValue();
                                PollResult obj = PollResult.find(poll_id, member);
                                time = obj.getTimeToString();
                            }
                        }
                        ws.addCell(new jxl.write.Label(cols++, rows, time));
                    }
                } finally
                {
                    db.close();
                }
                wb.write();
                wb.close();
                return;
            }

            /*
                 String qs=request.getQueryString();
                 qs=qs==null?"":"?"+qs;
                 response.sendRedirect("/jsp/type/poll/PollResults.jsp"+qs);
             */
            /*
                         TeaSession teasession = new TeaSession(request);
                         Node node = Node.find(teasession._nNode);
                         int i = node.getOptions();
                         int j = node.getOptions1();
                         int k = AnonPollResult.getResult(teasession._nNode, 1);
                         int l = AnonPollResult.getResult(teasession._nNode, 2);
                         int i1 = AnonPollResult.getResult(teasession._nNode, 3);
                         int j1 = AnonPollResult.getResult(teasession._nNode, 4);
                         int k1 = AnonPollResult.getResult(teasession._nNode, 5);
                         int l1 = AnonPollResult.getResult(teasession._nNode, 6);
                         int i2 = k + l + i1 + j1 + k1 + l1;
                         int j2 = PollResult.getResult(teasession._nNode, 1);
                         int k2 = PollResult.getResult(teasession._nNode, 2);
                         int l2 = PollResult.getResult(teasession._nNode, 3);
                         int i3 = PollResult.getResult(teasession._nNode, 4);
                         int j3 = PollResult.getResult(teasession._nNode, 5);
                         int k3 = PollResult.getResult(teasession._nNode, 6);
                         int l3 = j2 + k2 + l2 + i3 + j3 + k3;
                         int i4 = k + j2;
                         int j4 = l + k2;
                         int k4 = i1 + l2;
                         int l4 = j1 + i3;
                         int i5 = k1 + j3;
                         int j5 = l1 + k3;
                         int k5 = i2 + l3;
                         PrintWriter printwriter = response.getWriter();
                         printwriter.print(new Break());
                         Poll poll = Poll.find(teasession._nNode);
                         printwriter.print(k5 + " " + super.r.getString(teasession._nLanguage, "InfVoters"));
                         if(k5 != 0)
                         {
                printwriter.print("<APPLET CODEBASE=/tea/applet/ Code=tea.applet.Chart.class ALIGN=LEFT WIDTH=100 HEIGHT=100><PARAM NAME=A VALUE=" + i4 + ">" + "<PARAM NAME=B VALUE=" + j4 + ">" + "<PARAM NAME=C VALUE=" + k4 + ">" + "<PARAM NAME=D VALUE=" + l4 + ">" + "<PARAM NAME=E VALUE=" + i5 + ">" + "<PARAM NAME=F VALUE=" + j5 + ">" + "</APPLET>");
                Table table = new Table();
                String s = poll.getChoiceA(teasession._nLanguage);
                Row row = new Row(new Cell(new Text(s, "RED")));
                row.add(new Cell(new Text((i4 * 100) / k5 + "% " + i4)));
                table.add(row);
                String s1 = poll.getChoiceB(teasession._nLanguage);
                Row row1 = new Row(new Cell(new Text(s1, "ORANGE")));
                row1.add(new Cell(new Text((j4 * 100) / k5 + "% " + j4)));
                table.add(row1);
                String s2 = poll.getChoiceC(teasession._nLanguage);
                if(s2.length() != 0)
                {
                    Row row2 = new Row(new Cell(new Text(s2, "YELLOW")));
                    row2.add(new Cell(new Text((k4 * 100) / k5 + "% " + k4)));
                    table.add(row2);
                }
                String s3 = poll.getChoiceD(teasession._nLanguage);
                if(s3.length() != 0)
                {
                    Row row3 = new Row(new Cell(new Text(s3, "GREEN")));
                    row3.add(new Cell(new Text((l4 * 100) / k5 + "% " + l4)));
                    table.add(row3);
                }
                String s4 = poll.getChoiceE(teasession._nLanguage);
                if(s4.length() != 0)
                {
                    Row row4 = new Row(new Cell(new Text(s4, "BLUE")));
                    row4.add(new Cell(new Text((i5 * 100) / k5 + "% " + i5)));
                    table.add(row4);
                }
                String s5 = poll.getChoiceF(teasession._nLanguage);
                if(s5.length() != 0)
                {
                    Row row5 = new Row(new Cell(new Text(s5, "LIME")));
                    row5.add(new Cell(new Text((j5 * 100) / k5 + "% " + j5)));
                    table.add(row5);
                }
                printwriter.print(table);
                if(l3 != 0)
                {
                    printwriter.print(new Break(2));
                    boolean flag = node.isCreator(teasession._rv);
                    String s6 = request.getParameter("Pos");
                    int l5 = s6 != null ? Integer.parseInt(s6) : 0;
                    Table table1 = new Table();
                    table1.setTitle(super.r.getString(teasession._nLanguage, "MemberId") + "\n" + super.r.getString(teasession._nLanguage, "Time") + "\n" + super.r.getString(teasession._nLanguage, "Choice") + "\n" + super.r.getString(teasession._nLanguage, "Remark") + "\n");
                    Row row6;
                    for(Enumeration enumeration = PollResult.find(teasession._nNode, l5, 25); enumeration.hasMoreElements(); table1.add(row6))
                    {
                        int i6 = ((Integer)enumeration.nextElement()).intValue();
                        PollResult pollresult = PollResult.find(i6);
                        RV rv = pollresult.getMember();
                        row6 = new Row(new Cell(hrefGlance(rv)));
                        row6.add(new Cell(new Text((new SimpleDateFormat("MM.dd HH:mm")).format(pollresult.getTime()))));
                        row6.add(new Cell(new Text("" + (char)((65 + pollresult.getAnswer()) - 1))));
                        row6.add(new Cell(new Text(pollresult.getText(teasession._nLanguage))));
                        if(pollresult.getVoiceFlag())
                            row6.add(new Cell(new Anchor("PollResultVoice?node=" + teasession._nNode + "&PollResult=" + i6, super.r.getCommandImg(teasession._nLanguage, "Play"))));
                        if(flag || rv.equals(teasession._rv))
                            row6.add(new Cell(new Anchor("DeletePollResult?node=" + teasession._nNode + "&PollResult=" + i6, super.r.getCommandImg(teasession._nLanguage, "Delete"), "return(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDelete") + "'));")));
                    }

                    printwriter.print(table1);
                    printwriter.print(new FPNL(teasession._nLanguage, "PollResults?node=" + teasession._nNode + "&Pos=", l5, l3));
                    if(flag)
                        printwriter.print(new Anchor("DeleteAllPollResults?node=" + teasession._nNode, super.r.getCommandImg(teasession._nLanguage, "DeleteAll"), "return(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDeleteAll") + "'));"));
                }
                         }
                         printwriter.print(new Break(2));
                         if((i & 0x8000) != 0)
                printwriter.print(new Anchor("Talkbacks?node=" + teasession._nNode, super.r.getCommandImg(teasession._nLanguage, "Talkbacks")));
                         if((i & 0x10000) != 0)
                printwriter.print(new Anchor("ChatFrameSet?node=" + teasession._nNode, "_blank", super.r.getCommandImg(teasession._nLanguage, "ChatRoom")));
                         printwriter.close();*/
        } catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/node/type/poll/PollResults");
    }
}
