package tea.ui.node.type.mpoll;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import jxl.write.*;
import jxl.format.*;
import jxl.write.Number;
import java.math.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.site.*;
import tea.entity.member.*;
import tea.entity.node.type.mpoll.*;
import net.mietian.convert.*;
import tea.entity.util.*;

public class Votes extends HttpServlet
{

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        response.setHeader("Content-Encoding","nogzip");
        Http h = new Http(request,response);
        String act = h.get("act","");
        if(act.startsWith("exp"))
        {
            try
            {
                String title = h.get("title","导出");
                Poll p = Poll.find(h.getInt("poll"));
                response.setHeader("Cache-Control","private");
                response.setContentType("application/octet-stream");
                response.setHeader("Content-Disposition","attachment; filename=" + new String((title + ".xls").getBytes("GBK"),"ISO-8859-1"));
                //
                WritableCellFormat CF_H = new WritableCellFormat(new WritableFont(WritableFont.ARIAL,20,WritableFont.BOLD));
                CF_H.setAlignment(Alignment.CENTRE);
                //
                WritableCellFormat TH = new WritableCellFormat();
                TH.setBorder(jxl.format.Border.ALL,BorderLineStyle.THIN);
                TH.setBackground(Colour.LIGHT_TURQUOISE2);
                if("expquestion".equals(act))
                {
                    WritableWorkbook wwb = jxl.Workbook.createWorkbook(response.getOutputStream());
                    WritableSheet ws = wwb.createSheet("导出",0);
                    for(int i = 0;i < 10;i++)
                        ws.setColumnView(i,20);
                    ws.setRowView(0,500);
                    ws.mergeCells(0,0,8,0);

                    ws.addCell(new Label(0,0,Community.find(h.community).getName(h.language) + "——" + title,CF_H));
                    int c = 0,r = 0;
                    ws.addCell(new Label(c++,1,"用户",TH));
                    //问题
                    ArrayList qs = Question.find(" AND poll=" + p.poll + " AND question IN(" + h.get("question").substring(1).replace('|',',') + "0)",0,Integer.MAX_VALUE);
                    for(int j = 0;j < qs.size();j++)
                    {
                        Question q = (Question) qs.get(j);
                        ws.addCell(new Label(c++,1,q.name[1].replaceAll("[：:]$",""),TH));
                    }
                    ws.addCell(new Label(c++,1,"得分",TH));
                    ws.addCell(new Label(c++,1,"参与调查日期",TH));
                    ws.addCell(new Label(c++,1,"IP地址",TH));
                    r = 2;
                    ws.getSettings().setVerticalFreeze(r);
                    //
                    String votes = h.get("votes");
                    String[] arr = votes.split("[|]");
                    for(int i = 1;i < arr.length;i++,r++)
                    {
                        Vote v = Vote.find(Integer.parseInt(arr[i]));
                        c = 0;
                        ws.addCell(new Label(c++,r,v.member < 1 ? "游客" : Profile.find(v.member).getMember()));
                        HashMap hm = Answer.findByVote(v.vote);
                        for(int j = 0;j < qs.size();j++)
                        {
                            Question q = (Question) qs.get(j);
                            Answer a = (Answer) hm.get(q.question);
                            ws.addCell(new Label(c++,r,a == null ? null : a.getContent()));
                        }
                        ws.addCell(new Number(c++,r,v.total));
                        ws.addCell(new Label(c++,r,MT.f(v.time,1)));
                        ws.addCell(new Label(c++,r,v.ip));
                    }
                    wwb.write();
                    wwb.close();
                    //
                    DbAdapter.execute("UPDATE " + Poll.PR + "Vote SET winning=1 WHERE vote IN(" + votes.substring(1).replace('|',',') + "0)");
                    Vote.c.clear();
                } else if("expxls".equals(act))
                {
                    WritableWorkbook wwb = jxl.Workbook.createWorkbook(response.getOutputStream());
                    WritableSheet ws = wwb.createSheet("比例",0);

                    ws.setColumnView(2,50);
                    ws.mergeCells(0,0,8,0);

                    ws.addCell(new Label(0,0,Community.find(h.community).getName(h.language) + "——" + p.name[1],CF_H));

                    WritableCellFormat PERC = new WritableCellFormat(new NumberFormat("0%"));

                    //WritableCellFormat cf = new WritableCellFormat();
                    //cf.setBackground(Colour.GRAY_25);
                    byte[] by = Filex.read(getServletContext().getRealPath("/tea/image/poll/vote.gif"));
                    Iterator it = Question.find(" AND poll=" + p.poll + " AND type<3",0,200).iterator();
                    for(int j = 1;it.hasNext();j++)
                    {
                        Question q = (Question) it.next();
                        ws.mergeCells(0,j,4,j);
                        ws.addCell(new Label(0,j++,q.name[1],TH));
                        if(q.type < 3)
                        {
                            int sum = DbAdapter.execute("SELECT SUM(hits) FROM " + Poll.PR + "Choice WHERE question=" + q.question);
                            BigDecimal SUM = new BigDecimal(Math.max(sum,1));

                            Iterator ic = Choice.find(" AND question=" + q.question,0,200).iterator();
                            while(ic.hasNext())
                            {
                                Choice c = (Choice) ic.next();
                                double perc = new BigDecimal(c.hits).divide(SUM,4,4).doubleValue();
                                ws.addCell(new Label(1,j,c.name[1]));
                                ws.addImage(new WritableImage(2,j,perc,1,by));
                                ws.addCell(new Number(3,j,c.hits));
                                ws.addCell(new Number(4,j,perc,PERC));
                                j++;
                            }
                        } else
                        {
                            Iterator ia = Answer.find(" AND question=" + q.question + " ORDER BY vote",0,2000).iterator();
                            while(ia.hasNext())
                            {
                                Answer a = (Answer) ia.next();
                                //Invite t = Vote.find(a.vote).getMember();
                                //ws.addCell(new Label(1,j,t == null ? "游客" : t.getName2(1)));
                                ws.addCell(new Label(2,j,a.content));
                                j++;
                            }
                        }
                    }

                    /*
                                         ws = wwb.createSheet("细节",1);
                                         for(int i = 0;i < 10;i++)
                        ws.setColumnView(i,20);
                                         ws.setRowView(0,500);
                                         ws.mergeCells(0,0,8,0);

                                         ws.addCell(new Label(0,0,Community.find(h.community).getName(h.language) + "——" + p.name[1],CF_H));
                                         int c = 0,r = 1;
                                         ws.addCell(new Label(c++,r,"用户",TH));
                                         //问题
                                         ArrayList qs = Question.find(" AND poll=" + p.poll + " AND type!=10",0,Integer.MAX_VALUE);
                                         for(int j = 0;j < qs.size();j++)
                                         {
                        Question q = (Question) qs.get(j);
                        ws.addCell(new Label(c++,r,q.name[1].replaceAll("[：:]$",""),TH));
                                         }
                                         ws.addCell(new Label(c++,r,"得分",TH));
                                         ws.addCell(new Label(c++,r,"参与调查日期",TH));
                                         ws.addCell(new Label(c++,r,"IP地址",TH));
                                         ws.getSettings().setVerticalFreeze(++r);
                                         //
                                         int last = 0;
                                         ArrayList vs;
                                         do
                                         {
                        System.out.println(r + "：" + last);
                        vs = Vote.find(MT.f(h.key," AND poll=" + p.poll) + " AND vote>" + last + " ORDER BY vote",0,1000);
                        for(int i = 0;i < vs.size();i++)
                        {
                            Vote v = (Vote) vs.get(i);
                            last = v.vote;
                            c = 0;
                            ws.addCell(new Label(c++,r,v.member < 1 ? "游客" : Profile.find(v.member).getMember()));
                            HashMap hm = Answer.findByVote(v.vote);
                            for(int j = 0;j < qs.size();j++)
                            {
                                Question q = (Question) qs.get(j);
                                Answer a = (Answer) hm.get(q.question);
                                ws.addCell(new Label(c++,r,a == null ? null : a.getContent()));
                            }
                            ws.addCell(new Number(c++,r,v.total));
                            ws.addCell(new Label(c++,r,MT.f(v.time,1)));
                            ws.addCell(new Label(c++,r,v.ip));
                            r++;
                        }
                        wwb.write();
                                         } while(vs.size() > 0);
                     */
                    wwb.write();
                    wwb.close();
                }
            } catch(Throwable ex)
            {
                ex.printStackTrace();
            }
            return;
        }
        String nexturl = h.get("nexturl",""),format = h.get("format");
        PrintWriter out = response.getWriter();
        try
        {
            if("xml".equals(act))
            {
                int poll = h.getInt("poll");
                out.println("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
                out.println("<answer>");
                out.println("<returnUrl url=\"http://" + request.getServerName() + ":" + request.getServerPort() + "/MVotes.do?act=add&amp;poll=" + poll + "&amp;format=xml\" />");
                ArrayList al = Question.find(" AND poll=" + poll,0,Integer.MAX_VALUE);
                for(int i = 0;i < al.size();i++)
                {
                    Question t = (Question) al.get(i);
                    if(t.type == 10)
                        continue;
                    out.println("<question id=\"" + t.question + "\" name=\"" + Lucene.t(t.name[h.language]).replace('"','\'') + "\" result=\"" + t.answer + "\" type=\"" + t.type + "\" required=\"" + t.required + "\">");
                    if(t.type < 3)
                    {
                        ArrayList ac = Choice.findByQuestion(t.question);
                        for(int j = 0;j < ac.size();j++)
                        {
                            Choice c = (Choice) ac.get(j);
                            out.println("<option id=\"" + c.choice + "\">" + c.name[h.language] + "</option>");
                        }
                    }
                    out.println("</question>");
                }
                out.println("</answer>");
                return;
            }
            out.println("xml".equals(format) ? "<?xml version=\"1.0\" encoding=\"utf-8\"?>" : "<script>var mt=parent.mt;</script>");
            if("add".equals(act))
            {
                String ref = request.getHeader("Referer");
                //if(ref == null) //刷票
                //    return;

                String[] qs = h.getValues("question");
                if(qs == null)
                    return;

                Poll p = Poll.find(h.getInt("poll"));
                if((p.etime != null && p.etime.getTime() < System.currentTimeMillis()) || (p.elimit > 0 && p.elimit < p.hits))
                {
                    String err = Res.get(h.language,"抱歉，已过截止日期，您无法投票。");
                    out.print("xml".equals(format) ? "<root><code>0</code><msg>" + err + "</msg></root>" : "<script>mt.show('" + err + "');</script>");
                    return;
                }

                //过滤机制
                String answer = h.get("q" + p.question);
                String err = "您已经提交过了，不能多次" + (p.score > 0 ? "答题" : "投票") + "。";
                String info = h.get("info","您的" + (p.score > 0 ? "答题" : "投票") + "已成功提交，谢谢您的参与！");
                if(p.filter == 1)
                {
                    HttpSession session = request.getSession();
                    String sevote = (String) session.getAttribute("vote");
                    if(sevote == null)
                        sevote = "|";
                    else if(sevote.indexOf("|" + p.poll + "|") != -1)
                    {
                        out.print("xml".equals(format) ? "<root><code>0</code><msg>" + err + "</msg></root>" : "<script>mt.show('" + err + "');</script>");
                        return;
                    }
                    session.setAttribute("vote",sevote + p.poll + "|");
                } else if(p.filter == 8)
                {
                    if(answer == null || Vote.count(" AND poll=" + p.poll + " AND answer=" + DbAdapter.cite(answer)) > 0)
                    {
                        out.print("xml".equals(format) ? "<root><code>0</code><msg>" + err + "</msg></root>" : "<script>mt.show('" + err + "');</script>");
                        return;
                    }
                } else if(p.filter > 1)
                {
                    StringBuilder sql = new StringBuilder();
                    sql.append(" AND poll=" + p.poll);
                    if(p.filter == 2)
                        sql.append(" AND ip=" + DbAdapter.cite(request.getRemoteAddr()));
                    else if(p.filter == 3)
                        sql.append(" AND member=" + h.member);
                    if(Vote.count(sql.toString()) > 0)
                    {
                        out.print("xml".equals(format) ? "<root><code>0</code><msg>" + err + "</msg></root>" : "<script>mt.show('" + err + "');</script>");
                        return;
                    }
                }
//                    if (teasession._rv == null) //会员没有登陆
//                    {
//                        out.print("<script>mt.show('对不起，您还未登录，无法进行此操作。',2,'/servlet/StartLogin?node=" + h.node + "');</script>");
//                        return;
//                    }

//                Poll2 p2 = Poll2.find(h.node);
//                if (p2.role.length() > 1 || p2.member.length() > 1 || p2.unit.length() > 1)
//                {
//                    AdminUsrRole aur = AdminUsrRole.find(h.community, teasession._rv._strR);
//                    StringBuilder sql = new StringBuilder();
//                    sql.append(" AND node=" + h.node + " AND(");
//                    sql.append("    member LIKE " + DbAdapter.cite("%|" + teasession._rv._strR + "|%"));
//                    String tmp = aur.getRole();
//                    if (tmp.length() > 2)
//                        sql.append(" OR role   LIKE '%|" + tmp.substring(1, tmp.length() - 1).replaceAll("/", "|%' OR role LIKE '%|") + "|%'");
//                    sql.append(" OR unit   LIKE '%|" + aur.getUnit() + "|%')");
//                    if (Poll2.count(sql.toString()) < 1)
//                    {
//                        out.print("<script>mt.show('您没有权限参与本投票。');</script>");
//                        return;
//                    }
//                }

                Vote v = Vote.find(h.getInt("vote"));
                v.poll = p.poll;
                v.language = h.language;
                v.member = h.member;
                v.answer = answer;
                v.ip = request.getRemoteAddr();
                v.useragent = request.getHeader("User-Agent");
                if(v.useragent.length() > 600)
                    v.useragent = v.useragent.substring(0,600) + "...";
                v.time = new Date();

                DbAdapter db = new DbAdapter();
                try
                {
                    db.setAutoCommit(false);
                    v.set(db);
                    v.total = 0;
                    StringBuilder sb = new StringBuilder();
                    for(int i = 0;i < qs.length;i++)
                    {
                        Question q = Question.find(Integer.parseInt(qs[i]));
                        Answer a = new Answer(v.vote,q.question);
                        if(q.type < 3)
                        {
                            a.choice = h.get("q" + qs[i],"|");
                            if(a.choice.startsWith("||")) //遇到：|1|2|4| 有此问题
                                a.choice = h.get("q" + qs[i]);
                            sb.append(a.choice.substring(1));
                        } else
                            a.content = h.get("q" + qs[i]);
                        a.set(db);
                        //
                        if(q.answer > 0 && a.choice.contains("|" + q.answer + "|"))
                        {
                            v.total++;
                        }
                    }
                    //选项做+1操作,方便统计
                    db.executeUpdate(v.vote,"UPDATE " + Poll.PR + "Vote SET total=" + v.total + " WHERE vote=" + v.vote);
                    db.executeUpdate(p.poll,"UPDATE " + Poll.PR + "Poll SET hits=" + (++p.hits) + " WHERE poll=" + p.poll);
                    if(sb.length() > 0)
                    {
                        sb.setCharAt(sb.length() - 1,')');
                        Iterator it = Choice.find(" AND choice IN(" + sb.toString().replace('|',','),0,Integer.MAX_VALUE).iterator();
                        while(it.hasNext())
                        {
                            Choice c = (Choice) it.next();
                            db.executeUpdate(c.choice,"UPDATE " + Poll.PR + "Choice SET hits=" + (++c.hits) + " WHERE choice=" + c.choice);
                        }
                    }
                } finally
                {
                    db.setAutoCommit(true);
                    db.close();
                }
                //nexturl = "/jsp/type/mpoll/VoteView.jsp";
                info += (p.score > 0 ? "<br/>得分：" + v.total : "");
                out.print("xml".equals(format) ? "<root><code>1</code><msg>" + info + "</msg></root>" : "<script>mt.show('" + info + "',1,'" + nexturl + "?vote=" + v.vote + "');</script>");
                return;
            } else if("clear".equals(act)) //清空结果
            {
                int poll = h.getInt("poll");
                Poll p = Poll.find(poll);
                p.set("hits",String.valueOf(p.hits = 0));
                DbAdapter db = new DbAdapter();
                try
                {
                    db.executeUpdate(p.poll,"DELETE FROM " + Poll.PR + "Answer WHERE vote IN(SELECT vote FROM " + Poll.PR + "Vote WHERE poll=" + p.poll + ")");
                    db.executeUpdate(p.poll,"UPDATE " + Poll.PR + "Vote SET deleted=1 WHERE poll=" + p.poll);
                    db.executeUpdate(p.poll,"UPDATE " + Poll.PR + "Choice SET hits=0 WHERE question IN(SELECT question FROM " + Poll.PR + "Question WHERE poll=" + p.poll + ")");
                } finally
                {
                    db.close();
                }
            } else if("random".equals(act))
            {
                int poll = h.getInt("poll");
            } else if("csv".equals(act))
            {
                for(int j = 0;j < 20;j++)
                    out.write("// 显示进度条  \n");
                int cur = (int) (System.currentTimeMillis() / 1000);
                String path = "/res/" + h.community + "/vote_" + cur + ".csv";
                File f = new File(Http.REAL_PATH + path);
                FileWriter fw = new FileWriter(f);
                fw.write("﻿用户"); //2003下不识别BOM
                //问题
                Poll p = Poll.find(h.getInt("poll"));
                ArrayList qs = Question.find(" AND poll=" + p.poll + " AND type!=10",0,Integer.MAX_VALUE);
                for(int j = 0;j < qs.size();j++)
                {
                    Question q = (Question) qs.get(j);
                    fw.write("," + cite(q.name[1].replaceAll("[：:]$","")));
                }
                if(p.score > 0)
                    fw.write(",得分");
                fw.write(",参与调查日期");
                fw.write(",IP地址");
                //
                int last = 0,seq = 0,sum = Vote.count(h.key);
                ArrayList vs;
                do
                {
                    out.print("<script>mt.progress(" + seq + "," + sum + ",'大小：" + MT.f(f.length() / 1024F,2) + " K<br/>数量：" + MT.f(seq) + " 条<br/>耗时：" + MT.ss((int) (System.currentTimeMillis() / 1000) - cur) + "');</script>");
                    out.flush();
                    //
                    vs = Vote.find(h.key + " AND vote>" + last + " ORDER BY vote",0,1000);
                    for(int i = 0;i < vs.size();i++)
                    {
                        Vote v = (Vote) vs.get(i);
                        last = v.vote;
                        fw.write("\n" + cite(v.member < 1 ? "游客" : Profile.find(v.member).getMember()));
                        HashMap hm = Answer.findByVote(v.vote);
                        for(int j = 0;j < qs.size();j++)
                        {
                            Question q = (Question) qs.get(j);
                            Answer a = (Answer) hm.get(q.question);
                            fw.write("," + cite(a == null ? null : a.getContent()));
                        }
                        if(p.score > 0)
                            fw.write("," + v.total);
                        fw.write("," + MT.f(v.time,1));
                        fw.write("," + v.ip);
                    }
                    seq += vs.size();
                } while(vs.size() > 0);
                fw.close();
                //
                out.print("<script>mt.show('压缩中...',0);</script>");
                out.flush();
                path += ".zip";
                File f2 = new File(Http.REAL_PATH + path);
                Zip z = new Zip(f2);
                z.zip(new File[]
                      {f});
                out.print("<script>mt.show('导出完成！<br/>原大小：" + MT.f(f.length() / 1024F,2) + " K<br/>压缩后：" + MT.f(f2.length() / 1024F,2) + " K<br/>耗　时：" + MT.ss((int) (System.currentTimeMillis() / 1000) - cur) + "',2,'" + path + "');parent.$$('dl_ok').value=' 下 载';</script>");
                f.delete();
                return;
            }
            out.print("<script>mt.show('" + Res.get(h.language,"操作执行成功！") + "',1,'" + nexturl + "');</script>");
        } catch(Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }

    static String cite(String str)
    {
        return str == null ? "" : str.replace('"','_').replace(',','，');
    }

}
