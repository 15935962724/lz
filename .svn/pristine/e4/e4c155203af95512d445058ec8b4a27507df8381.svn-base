package tea.ui.node.type.historical;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.node.*;
import tea.entity.member.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.ui.TeaSession;
import tea.ui.TeaServlet;
import net.mietian.convert.*;
import tea.entity.weibo.*;
import java.net.*;
import jxl.write.WritableWorkbook;
import jxl.write.WritableSheet;
import jxl.write.WritableCellFormat;
import jxl.write.Label;
import jxl.format.Alignment;
import jxl.write.Number;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.format.Border;
import jxl.format.VerticalAlignment;
import jxl.write.WritableFont;
import jxl.write.NumberFormats;
import jxl.write.WritableHyperlink;
import jxl.write.DateTime;
import tea.entity.site.*;
import java.util.regex.*;
import jxl.write.Formula;

public class Historicals extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        ServletContext application = this.getServletContext();
        HttpSession session = request.getSession(true);
        if(act.startsWith("exp"))
        {
            response.setHeader("Cache-Control","private");
            response.setContentType("application/octet-stream");
            String name = request.getPathInfo().substring(1);
            response.setHeader("Content-Disposition","attachment"); //; filename=" + new String("最美心愿奖.xls".getBytes("GBK"), "ISO-8859-1"));
            try
            {
                WritableCellFormat DF = new WritableCellFormat(new jxl.write.DateFormat("yyyy-MM-dd HH:mm"));

                //页眉
                WritableCellFormat HE = new WritableCellFormat(new WritableFont(WritableFont.ARIAL,20,WritableFont.BOLD));
                HE.setAlignment(Alignment.CENTRE);
                //标题
                WritableCellFormat TH = new WritableCellFormat();
                TH = new WritableCellFormat();
                TH.setBorder(Border.ALL,BorderLineStyle.THIN);
                TH.setBackground(Colour.LIGHT_TURQUOISE2);
                TH.setAlignment(Alignment.CENTRE);
                TH.setVerticalAlignment(VerticalAlignment.CENTRE);
                TH.setWrap(true);

                WritableCellFormat WR = new WritableCellFormat();
                WR.setWrap(true);

                WritableCellFormat NF = new WritableCellFormat(NumberFormats.TEXT);

                WritableWorkbook wwb = jxl.Workbook.createWorkbook(response.getOutputStream());
                WritableSheet ws = wwb.createSheet("工作表",0);
                if("exp_key".equals(act))
                {
                    for(int i = 0;i < 11;i++)
                    {
                        if(i == 7 || i == 8 || i == 9)
                            continue;
                        ws.setColumnView(i,18);
                    }
                    ws.setColumnView(2,60);

                    ws.setRowView(0,500);
                    ws.mergeCells(0,0,10,0);
                    ws.addCell(new Label(0,0,Community.find(h.community).getName(h.language) + "——" + name.substring(0,name.length() - 4),HE));
                    int i = 1,j = 0;
                    ws.addCell(new Label(j++,i,"标题",TH));
                    ws.addCell(new Label(j++,i,"发生时间",TH));
                    ws.addCell(new Label(j++,i,"内容",TH));
                    ws.addCell(new Label(j++,i,"上传人",TH));
                    ws.addCell(new Label(j++,i,"上传时间",TH));
                    ws.addCell(new Label(j++,i,"分享人",TH));
                    ws.addCell(new Label(j++,i,"分享时间",TH));
                    ws.addCell(new Label(j++,i,"转发数",TH));
                    ws.addCell(new Label(j++,i,"评论数",TH));
                    ws.addCell(new Label(j++,i,"关注度",TH));
                    ws.addCell(new Label(j++,i,"微博ID",TH));
                    ws.getSettings().setVerticalFreeze(++i);

                    Iterator it = Historical.find(h.key,0,Integer.MAX_VALUE).iterator();
                    while(it.hasNext())
                    {
                        Historical t = (Historical) it.next();
                        Node n = Node.find(t.node);

                        j = 0;
                        ws.addCell(new Label(j++,i,n.getSubject(h.language)));
                        ws.addCell(new Label(j++,i,t.getOTime()));
                        ws.addCell(new Label(j++,i,n.getText(h.language)));
                        ws.addCell(new Label(j++,i,n.getCreator()._strR));
                        ws.addCell(new DateTime(j++,i,t.time,DF));
                        if(t.microid > 0)
                        {
                            ws.addCell(new Label(j++,i,Profile.find(t.smember).getMember()));
                            ws.addCell(new DateTime(j++,i,t.stime,DF));
                            ws.addCell(new Number(j++,i,t.reposts));
                            ws.addCell(new Number(j++,i,t.comments));
                            ws.addCell(new Number(j++,i,t.reposts + t.comments));
                            WMicro wm = WMicro.find(t.microid);
                            String url = "http://weibo.com/" + wm.userid + "/" + OAuth.mid(t.microid);
                            ws.addHyperlink(new WritableHyperlink(j++,i,j,i,new URL(url),String.valueOf(t.microid)));
                        }
                        i++;
                    }
                    if(i > 3)
                    {
                        j = 6;
                        ws.addCell(new Label(j++,i,"合计"));
                        ws.addCell(new Formula(j++,i,"SUM(H3:H" + i + ")"));
                        ws.addCell(new Formula(j++,i,"SUM(I3:I" + i + ")"));
                        ws.addCell(new Formula(j++,i,"SUM(J3:J" + i + ")"));
                    }
                } else if("exp_ran".equals(act))
                {
                    for(int i = 0;i < 6;i++)
                        ws.setColumnView(i,18);
                    ws.setColumnView(4,60);

                    ws.setRowView(0,500);
                    ws.mergeCells(0,0,5,0);
                    ws.addCell(new Label(0,0,Community.find(h.community).getName(h.language) + "——" + name.substring(0,name.length() - 4),HE));
                    int i = 1,j = 0;
                    ws.addCell(new Label(j++,i,"用户ID",TH));
                    ws.addCell(new Label(j++,i,"用户昵称",TH));
                    ws.addCell(new Label(j++,i,"转发ID",TH));
                    ws.addCell(new Label(j++,i,"评论ID",TH));
                    ws.addCell(new Label(j++,i,"内容",TH));
                    ws.addCell(new Label(j++,i,"时间",TH));
                    ws.getSettings().setVerticalFreeze(++i);

                    Matcher m = Pattern.compile("(\\d+),(\\d+)\\|").matcher(h.get("ids"));
                    while(m.find())
                    {
                        WMicro wm = WMicro.find(Long.parseLong(m.group(1)));
                        WComment wc = WComment.find(Long.parseLong(m.group(2)));
                        WUser wu = WUser.find(wm.microid > 0 ? wm.userid : wc.userid);
                        j = 0;
                        ws.addCell(new Label(j++,i,wu.userid));
                        ws.addCell(new Label(j++,i,wu.nick));
                        ws.addCell(new Label(j++,i,String.valueOf(wm.microid))); //Excel的数据只能是15位内
                        ws.addCell(new Label(j++,i,String.valueOf(wc.commentid)));
                        ws.addCell(new Label(j++,i,wm.microid > 0 ? wm.content : wc.content,WR));
                        //ws.addHyperlink(new WritableHyperlink(j++, i, new URL(t.url)));
                        ws.addCell(new DateTime(j++,i,wm.microid > 0 ? wm.time : wc.time,DF));
                        i++;
                    }
                }

                wwb.write();
                wwb.close();
            } catch(Exception ex)
            {
                ex.printStackTrace();
            }
            return;
        }
        PrintWriter out = response.getWriter();
        try
        {
            if(h.member < 1)
            {
                out.print("<script>parent.location.replace('/servlet/StartLogin?community=" + h.community + "')</script>");
                return;
            }

            if("upload".equals(act))
            {
                out.print(h.get("file"));
                return;
            }
            //相关事件
            if("oday".equals(act))
            {
                StringBuilder sql = new StringBuilder();
                sql.append(" AND node!=" + h.node);
                int year = h.getInt("year");
                if(year > 0)
                    sql.append(" AND year=" + year);
                int month = h.getInt("month");
                if(month > 0)
                    sql.append(" AND month=" + month);
                int day = h.getInt("day");
                if(day > 0)
                    sql.append(" AND day=" + day);

                int sum = Historical.count(sql.toString());
                if(sum < 1)
                    out.print("暂无数据！");
                else
                {
                    Iterator it = Historical.find(sql.toString(),0,10).iterator();
                    for(int i = 1;it.hasNext();i++)
                    {
                        Historical t = (Historical) it.next();
                        if(i > 1)
                            out.print("<br/>");
                        out.print(i + "、[ " + t.getOTime() + "] " + Node.find(t.node).getSubject(h.language));
                    }
                    if(sum > 10)
                        out.print("<br/>共有“" + sum + "”条！");
                }
                return;
            }

            String info = "操作执行成功！";
            int state = -1;
            out.println("<script>var mt=parent.mt;</script>");
            if("edit".equals(act)) //编辑
            {
                int year = h.getInt("year");
                int month = h.getInt("month");
                int day = h.getInt("day");
                Date otime = null;
                if(year > 0 && month > 0 && day > 0)
                {
                    String tmp = year + "-" + (month < 10 ? "0" : "") + month + "-" + (day < 10 ? "0" : "") + day;
                    otime = MT.SDF[0].parse(tmp);
                    if(!MT.f(otime).equals(tmp))
                    {
                        out.print("<script>mt.show('日期选择错误，“" + tmp + "”不存在！');</script>");
                        return;
                    }
                }

                String video = h.get("video");
                if(h.getBool("clearv") || video.length() < 1)
                    video = null;
                else if(!video.endsWith(".flv")) //格式转换
                {
                    String path = application.getRealPath(video);
                    Video v = new Video(path);

                    for(int j = 0;j < 20;j++)
                        out.write("// 显示进度条  \n");
                    out.print("<script>parent.$('dialog_header').innerHTML='正在转换中...';function f(v){mt.progress(v.progress,100,'总：" + v.getDuration() + "　已转：'+v.time+'　大小：'+v.size+'K');}</script>");

                    if(v.start(path + ".flv",out))
                        video += ".flv";
                    else
                    {
                        info = "视频转换失败！";
                        System.out.println(video + "\r\n" + info + "：" + v.error);
                    }
                }
                //
                String subject = h.get("subject");
                String keywords = h.get("keywords");
                String content = h.get("content");
                String picture = h.get("picture");
                String alt = h.get("pictureName");
                if(picture != null)
                {
                    Img img = new Img(application.getRealPath(picture));
                    img.width = img.height = 800;
                    if(picture.endsWith(".bmp"))
                        picture += ".jpg";
                    img.start(application.getRealPath(picture = picture.replaceFirst("/large/","/bmiddle/")));
                }
                if(h.getBool("srccopy"))
                    content = TeaServlet.copy(h.community,content);

                Node n = Node.find(h.node);
                if(n.getType() == 1)
                {
                    int sequence = Node.getMaxSequence(h.node) + 10;
                    long options = n.getOptions();
                    int options1 = n.getOptions1();
                    Category cat = Category.find(h.node); // 11
                    h.node = Node.create(h.node,sequence,n.getCommunity(),new RV(Profile.find(h.member).getMember()),cat.getCategory(),(options1 & 2) != 0,options,options1,h.language,null,null,new Date(),n.getStyle(),n.getRoot(),n.getKstyle(),n.getKroot(),"",h.language,subject,keywords,"",content,picture,alt,0,video,"","","","",null,null);
                    //n = Node.find(h.node);
                    n.finished(h.node);
                } else
                {
                    n.set(h.language,subject,content);
                    if(picture != null || h.getBool("clear"))
                    {
                        n.setPicture(picture,h.language);
                        n.setAlt(alt,h.language);
                    }
					n.set("voice",h.language,video);
                }
                Historical t = Historical.find(h.node,h.language);
                t.otime = otime;
                t.year = year;
                t.month = month;
                t.day = day;
                t.type = 1;
                t.source = h.get("source");
                t.sourcedesc = h.get("sourcedesc");
                t.set();
                if(nexturl.length() < 1)
                    nexturl = "/html/historical/" + h.node + "-" + h.language + ".htm";

                //操作记录
                state = n.getType() == 1 ? 1 : 2;
            } else if("share".equals(act))
            {
                Node n = Node.find(h.node);
                Historical t = Historical.find(h.node,h.language);

                String voice = n.getVoice(h.language);
                info = voice == null ? t.share() : t.share(out);
                if(info == null)
                {
                    t.smember = h.member;
                    t.stime = new Date();
                    t.set();

                    state = 3;
                    info = voice != null ? "视频微博已经提交，请等待视频审核！" : "微博分享成功！";
                }
            } else if("timing".equals(act))
            {
                Historical t = Historical.find(h.node,h.language);
                t.stime = h.getDate("timing");
                if(t.stime == null)
                {
                    t.smember = 0;
                    state = 4;
                } else
                {
                    t.smember = h.member;
                    state = 6;
                }
                t.set();
            } else if("cancel".equals(act))
            {
                Historical t = Historical.find(h.node,h.language);
                info = new OAuth2(WConfig.find(h.community).sinatoken).delete(t.microid);
                if(info == null)
                {
                    info = "取消分享成功！";
                    state = 4;

                    t.microid = 0;

                    t.smember = 0;
                    t.stime = null;
                    t.set();
                }
            } else if("del".equals(act))
            {
                String[] arr = h.node < 1 ? h.getValues("nodes") : new String[]
                               {String.valueOf(h.node)};
                for(int i = 0;i < arr.length;i++)
                {
                    Node n = new Node(Integer.parseInt(arr[i]));
                    n.delete(h.language);
                    //操作记录
                    NodeFlow nf = new NodeFlow(0);
                    nf.node = n._nNode;
                    nf.member = h.member;
                    nf.state = 5;
                    nf.set();
                }
            }
            //操作记录
            if(state != -1)
            {
                NodeFlow nf = new NodeFlow(0);
                nf.node = h.node;
                nf.member = h.member;
                nf.state = state;
                nf.set();
            }
            if("错误：授权已过期！".equals(info) || "错误：授权已失效！".equals(info))
            {
                out.print("<script>mt.show('" + info + "',2);parent.$('dl_ok').value='重新授权';mt.ok=function(){location='/WConfigs.do?act=auth';};</script>");
                return;
            }
            out.print("<script>mt.show('" + info + "',1,'" + nexturl + "');</script>");
        } catch(Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
