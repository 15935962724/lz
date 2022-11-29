package tea.ui.node.type.poll;

import java.io.IOException;
import tea.entity.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import tea.entity.node.*;
import tea.entity.site.*;
import tea.entity.admin.*;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.db.*;
import java.io.*;
import java.util.*;
import jxl.write.*;
import jxl.format.Alignment;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import tea.entity.member.*;
import tea.entity.util.Card;

public class PollVotes extends HttpServlet
{

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act");
        if("exp".equals(act))
        {
            try
            {
                String tmp = h.get("lang");
                if(tmp != null)
                    h.language = Integer.parseInt(tmp);

                Node n = Node.find(h.node);
                response.setHeader("Cache-Control","private");
                response.setContentType("application/octet-stream");
                response.setHeader("Content-Disposition","attachment; filename=" + new String("导出.xls".getBytes("GBK"),"ISO-8859-1"));
                //
                WritableWorkbook wwb = jxl.Workbook.createWorkbook(response.getOutputStream());
                WritableSheet ws = wwb.createSheet("工作表",0);
                for(int i = 0;i < 10;i++)
                    ws.setColumnView(i,20);
                ws.setRowView(0,500);
                ws.mergeCells(0,0,8,0);

                WritableCellFormat cf = new WritableCellFormat(new WritableFont(WritableFont.ARIAL,20,WritableFont.BOLD));
                cf.setAlignment(Alignment.CENTRE);
                ws.addCell(new Label(0,0,Community.find(h.community).getName(h.language) + "——" + n.getSubject(h.language),cf));
                int j = 0;
                cf = new WritableCellFormat();
                cf.setBorder(jxl.format.Border.ALL,BorderLineStyle.THIN);
                cf.setBackground(Colour.LIGHT_TURQUOISE2);
                ws.addCell(new Label(j++,1,"客户区域",cf));
                ws.addCell(new Label(j++,1,"参与者ID",cf));
                Enumeration ep = Poll.find(" AND node=" + h.node + " AND language=" + h.language);
                while(ep.hasMoreElements())
                {
                    int pid = ((Integer) ep.nextElement()).intValue();
                    Poll p = Poll.find(pid);
                    ws.addCell(new Label(j++,1,p.getQuestion(),cf));
                }
                ws.addCell(new Label(j++,1,"参与调查日期",cf));
                ws.getSettings().setVerticalFreeze(2);
                Iterator it = PollVote.find(MT.f(h.key," AND node=" + h.node),0,Integer.MAX_VALUE).iterator();
                for(int i = 2;it.hasNext();i++)
                {
                    PollVote t = (PollVote) it.next();
                    j = 0;
                    ws.addCell(new Label(j++,i,t.member == null ? "--" : Card.find(Profile.find(t.member).getProvince(h.language)).toString()));
                    ws.addCell(new Label(j++,i,MT.f(t.member,"游客")));

                    ep = Poll.find(" AND node=" + h.node + " AND language=" + h.language);
                    while(ep.hasMoreElements())
                    {
                        int pid = ((Integer) ep.nextElement()).intValue();
                        Poll p = Poll.find(pid);
                        PollVoteList pvl = PollVoteList.find(t.pollvote,pid);
                        StringBuffer sb = new StringBuffer();
                        if(pvl.answer != null)
                        {
                            if(p.getType() < 2)
                            {
                                String[] arr = pvl.answer.split("[|]");
                                for(int x = 1;x < arr.length;x++)
                                {
                                    sb.append(PollChoice.find(Integer.parseInt(arr[x])).getTitle() + "　");
                                }
                            } else
                                sb.append(pvl.answer);
                        }
                        ws.addCell(new Label(j++,i,sb.toString()));
                    }
                    ws.addCell(new Label(j++,i,MT.f(t.time,1)));
                }
                wwb.write();
                wwb.close();
            } catch(Exception ex)
            {}
            return;
        }
        PrintWriter out = response.getWriter();
        try
        {
            TeaSession teasession = new TeaSession(request);
            out.write("<script>var mt=parent.mt;</script>");
            if("add".equals(act))
            {
                String polls[] = h.getValues("poll");
                if(polls == null)
                    return;

                String nexturl = h.get("nexturl");
                nexturl = nexturl == null ? "/html/poll/" + h.node + "-" + h.language + ".htm" : nexturl.replace('<',' ');

                int pollpos = h.getInt("pollpos");

                HttpSession session = request.getSession();
                Node node = Node.find(h.node);

                Date stop = node.getStopTime();
                if(stop != null && stop.getTime() < System.currentTimeMillis())
                {
                    out.print("<script>mt.show('抱歉，已过截止日期，您无法投票。');</script>");
                    return;
                }
                int j = node.getOptions1();

                if((j & 0x10000000) != 0) //记名投票
                {

                    if(teasession._rv == null) //会员没有登陆
                    {
                        out.print("<script>mt.show('对不起，您还未登录，无法进行此操作。',2,'/servlet/StartLogin?node=" + h.node + "');</script>");
                        return;
                    } else
                    if((j & 0x8000000) == 0 && PollVote.count(" AND node=" + h.node + " AND member=" + DbAdapter.cite(teasession._rv._strR)) > 0) //不准许会员多次投票 && 这不是会员第一次投票
                    {
                        out.print("<script>mt.show('你已经投票了，不准许会员多次投票。');</script>");
                        return;
                    }

                    Poll2 p2 = Poll2.find(h.node);
                    if(p2.role.length() > 1 || p2.member.length() > 1 || p2.unit.length() > 1)
                    {
                        AdminUsrRole aur = AdminUsrRole.find(h.community,teasession._rv._strR);
                        StringBuilder sql = new StringBuilder();
                        sql.append(" AND node=" + h.node + " AND(");
                        sql.append("    member LIKE " + DbAdapter.cite("%|" + teasession._rv._strR + "|%"));
                        String tmp = aur.getRole();
                        if(tmp.length() > 2)
                            sql.append(" OR role   LIKE '%|" + tmp.substring(1,tmp.length() - 1).replaceAll("/","|%' OR role LIKE '%|") + "|%'");
                        sql.append(" OR unit   LIKE '%|" + aur.getUnit() + "|%')");
                        if(Poll2.count(sql.toString()) < 1)
                        {
                            out.print("<script>mt.show('您没有权限参与本投票。');</script>");
                            return;
                        }
                    }
                }

                if(!"www.beijingforum.org".equals(request.getServerName()) && !"www.mzb.com.cn".equals(request.getServerName()) && !"127.0.0.1".equals(request.getServerName()))
                {
                    String sepoll = (String) session.getAttribute("tea.Poll");
                    if(sepoll == null)
                        sepoll = "/";
                    if(sepoll.indexOf("/" + h.node + "." + pollpos + "/") != -1)
                    {
                        out.print("<script>mt.show('你已经投票了，不能连续投票。');</script>");
                        return;
                    }
                    session.setAttribute("tea.Poll",sepoll + h.node + "." + pollpos + "/");
                }

                PollVote pv = new PollVote(0);
                pv.node = h.node;
                pv.language = h.language;
                pv.member = teasession._rv == null ? null : teasession._rv._strR;
                pv.ip = request.getRemoteAddr();
                pv.time = new Date();
                pv.set();
                int point = 0;
                for(int i = 0;i < polls.length;i++)
                {
                    String answers[] = h.getValues("answer" + polls[i]);
                    if(answers == null)
                        continue;
                    int poll = Integer.parseInt(polls[i]);
                    Poll poll_obj = Poll.find(poll);
                    //
                    PollVoteList pvl = new PollVoteList(pv.pollvote,poll);
                    pvl.answer = h.get("answer" + polls[i],poll_obj.getType() < 2 ? "|" : "");
                    pvl.set();

                    boolean f = true;
                    for(int x = 0;x < answers.length;x++)
                    {
                        if(poll_obj.getType() > 1)
                            continue;

                        int answer = Integer.parseInt(answers[x]);

                        //给选项表添加排序字段
                        PollChoice pcobj = PollChoice.find(answer);
                        int si = pcobj.getSorting() + 1;
                        pcobj.setSorting(si);

                        //判断是否多选
                        if(poll_obj.getType() == 0) //单选
                        {
                            if(poll_obj.getCorrect() != answer)
                            {
                                f = false;
                            }
                        } else if(poll_obj.getType() == 1) //多选
                        {
                            if(poll_obj.getCorrect_ch() == null || poll_obj.getCorrect_ch().indexOf("/" + answer + "/") == -1)
                            {
                                f = false;
                            }
                        }
                    }
                    if(f)
                        point += poll_obj.getPoint();

                }
                TeaServlet.delete(node);
                String Pollvtype = h.get("polltype");
                if((j & 0x20000000) != 0) //记分投票
                {
                    PollPoint.create(h.node,teasession._rv,point);
                    out.print("<script>mt.show('您的投票已成功提交，本次得分是：" + point + "',1,'" + nexturl + "');</script>");
                } else
                {
                    if(Pollvtype == null)
                    {
                        Pollvtype = "您的投票已成功提交.";
                    }
                    out.print("<script>mt.show('" + Pollvtype + "',1,'" + nexturl + "');</script>"); //您的投票已成功提交，谢谢您的参与！
                }
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        } finally
        {
            out.close();
        }
    }

}
