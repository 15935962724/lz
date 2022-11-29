package tea.ui.member;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.member.*;
import tea.entity.member.Message;
import javax.mail.internet.*;
import javax.mail.*;
import javax.activation.*;
import javax.mail.util.*;
import java.util.regex.*;
import tea.entity.site.*;

public class Messages extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request);

        String act = h.get("act");

        int folder = h.getInt("folder");
        String nexturl = h.get("nexturl","/jsp/message/Messages.jsp?folder=" + folder);
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            TeaSession ts = new TeaSession(request);
            if(ts._rv == null)
            {
                out.println("<script>mt.show('您还没有登录或登录已超时！请重新登录',2,'/');</script>");
                return;
            }

            if("upload".equals(act))
            {
                String tmp = h.get("file");
                if(tmp != null)
                    out.print(tmp);
                return;
            }

            Profile m = Profile.find(h.member);
            String info = Res.get(h.language,"操作执行成功！");
            if(act.equals("url"))
            {
                String url = h.get("url");
                String htm = (String) Http.open(url,null);
                int j = htm.indexOf("<head>");
                if(j != -1)
                {
                    htm = htm.substring(0,j) + "<base href='" + url + "' />" + htm.substring(j);
                }
                //转为绝对链接
                String host = url.substring(0,url.indexOf('/',10));
                url = url.substring(0,url.lastIndexOf('/') + 1);

                int end = 0;
                StringBuilder sb = new StringBuilder();
                Matcher mp = Pattern.compile("(href|src)=[\"']([^\"']+)[\"']").matcher(htm);
                while(mp.find())
                {
                    String tmp = mp.group(2);
                    if(tmp.indexOf("://") == -1)
                    {
                        tmp = (tmp.charAt(0) == '/' ? host : url) + tmp;
                    }
                    //System.out.println(tmp);
                    sb.append(htm.substring(end,mp.start(2))).append(tmp);
                    end = mp.end(2);
                }
                sb.append(htm.substring(end));

                out.print(sb.toString());
                return;
            } else if(act.startsWith("del"))
            {
                boolean del2 = "del2".equals(act);
                String[] arr = h.getValues("message");
                for(int i = 0;i < arr.length;i++)
                {
                    int fid = del2 ? 3 : MessageFolder.find(Integer.parseInt(arr[i]),m.getProfile()).folder;
                    MessageFolder.create(Integer.parseInt(arr[i]),m.getProfile(),fid == 3 ? 9 : 3);
                }
            } else if(act.equals("move"))
            {
                int move = h.getInt("move");
                String[] arr = h.getValues("message");
                for(int i = 0;i < arr.length;i++)
                {
                    MessageFolder.create(Integer.parseInt(arr[i]),m.getProfile(),move);
                }
                out.print("<script>window.open('" + nexturl + "','_parent');</script>");
                return;
            } else if(act.equals("edit"))
            {
                int message = h.getInt("message");
                Message t = Message.find(message);
                t.community = h.community;
                t.content = h.get("content");
                if(t.content.length() < 1)
                {
                    out.print("<script>mt.show('" + Res.get(h.language,"“{0}”不能为空！","内容") + "');</script>");
                    return;
                }
                t.tzone = h.get("zones","|");

                t.tinvite = h.get("invites","|");
                t.tmember = h.get("members","|");
                t.tmeeting = h.get("meetings","|");
                t.subject = h.get("subject");
                t.attch = h.get("attach"); //附件
                //站内信
                if(h.getBool("msg"))
                {
                    t.member = m.getProfile();
                    t.tdept = h.get("tdept","|");
                    t.tname[0] = t.getToName(0);
                    t.tname[1] = t.getToName(1);
                    t.url = h.get("url");
                    t.receipt = h.getBool("receipt");
                    if(t.time == null)
                    {
                        t.time = new Date();
                    }
                    t.set();
                    MessageFolder.create(t.message,m.getProfile(),h.getBool("save") ? 1 : 9); //保存在发件箱
                }
                //外部邮箱
                if(h.getBool("email"))
                {
                    for(int i = 0;i < 20;i++)
                    {
                        out.print("// 显示进度条  \n");
                    }
                    out.print("<script>parent.$('dialog_content').innerHTML='正在连接SMTP服务器...';</script>");
                    out.flush();

                    ArrayList al = new ArrayList();
                    Enumeration e = Profile.find(" AND profile IN('" + t.tmember.substring(1).replaceAll("[|]","','") + "') AND email!=''",0,Integer.MAX_VALUE);
                    while(e.hasMoreElements())
                    {
                        String tmp = Profile.find((String) e.nextElement()).getEmail();
                        if(al.contains(tmp))
                            continue;
                        al.add(tmp);
                    }
                    //System.out.println(sql.toString());
                    //
                    final Community c = Community.find(h.community);
                    Properties p = System.getProperties();
                    p.put("mail.smtp.host",c.getSmtp());
                    p.put("mail.smtp.auth","true");
                    p.put("mail.smtp.timeout","20000");
                    MimeMessage mm = new MimeMessage(Session.getInstance(p,new Authenticator()
                    {
                        public PasswordAuthentication getPasswordAuthentication()
                        {
                            return new PasswordAuthentication(c.getSmtpUser(),c.getSmtpPassword());
                        }
                    }));
                    mm.setSentDate(new Date());
                    mm.setFrom(new InternetAddress(c.getSmtpUser(),c.getSmtpName(),"UTF-8"));
                    mm.setSubject(t.subject,"UTF-8");
                    //
                    MimeMultipart mp = new MimeMultipart();
                    MimeBodyPart bp = new MimeBodyPart();
                    //Foxmail 6.5：字符集可以用双引号或不写,不能用单引号,会删除第二个单引号
                    bp.setContent("﻿<html><head><meta http-equiv='Content-Type' content=\"text/html;charset=UTF-8\" /></head><body>" + t.content,"text/html;charset=UTF-8");
                    mp.addBodyPart(bp);
                    //附件
                    String[] arr = t.attch.split("[|]");
                    for(int i = 1;i < arr.length;i++)
                    {
                        bp = new MimeBodyPart();
                        //不知为何，老是报错
                        //ByteArrayDataSource bads = new ByteArrayDataSource(by, name);
                        //mp.setDataHandler(new DataHandler(bads));
                        FileDataSource ba = new FileDataSource(getServletContext().getRealPath(arr[i]));
                        bp.setDataHandler(new DataHandler(ba));
                        bp.setFileName(MimeUtility.encodeText(ba.getName(),"UTF-8","B"));
                        mp.addBodyPart(bp);
                    }
                    mm.setContent(mp);
                    //发送
                    int err = 0,ok = 0;
                    for(int i = 0;i < al.size();i++)
                    {
                        String tmp = (String) al.get(i);
                        try
                        {
                            mm.setRecipients(javax.mail.Message.RecipientType.TO,tmp);
                            Transport.send(mm);
                            ok++;
                        } catch(Exception ex) //Messaging
                        {
                            err++;
                            System.out.println(ex.toString() + "==:==" + ex.getMessage());
                        }
                        //进度
                        out.print("<script>mt.progress(" + i + "," + al.size() + ",'正在发送（" + i + "/" + al.size() + "）：" + tmp + "');</script>");
                        out.flush();
                    }
                    info = "发送完成！<br/><br/>成功：" + ok + "<br/>失败：" + err;
                }
            } else if(act.equals("invite"))
            {
                for(int i = 0;i < 20;i++)
                {
                    out.print("// 显示进度条  \n");
                }
                info = "";

                String tmember = h.get("members","|");
                if(h.getBool("mail"))
                {
                    out.print("<script>parent.$('dialog_header').innerHTML='正在发送邮件...';parent.$('dialog_content').innerHTML='正在连接SMTP服务器...';</script>");
                    out.flush();
                    //
                    String content = "中国水电" + h.get("dept") + h.get("item") + "项目" + h.get("project") + "工程，邀请您参加招标，可否、请及时回复。<br/>招标联系人：" + h.get("name") + "<br/>电话：" + h.get("tel") + "<br/>邮件：" + h.get("email");
                    ArrayList al = new ArrayList();
                    Enumeration e = Profile.find(" AND profile IN('" + tmember.substring(1).replaceAll("[|]","','") + "') AND email!=''",0,Integer.MAX_VALUE);
                    while(e.hasMoreElements())
                    {
                        String tmp = Profile.find((String) e.nextElement()).getEmail();
                        if(al.contains(tmp))
                            continue;
                        al.add(tmp);
                    }
                    //
                    final Community c = Community.find(h.community);
                    Properties p = System.getProperties();
                    p.put("mail.smtp.host",c.getSmtp());
                    p.put("mail.smtp.auth","true");
                    p.put("mail.smtp.timeout","20000");
                    MimeMessage mm = new MimeMessage(Session.getInstance(p,new Authenticator()
                    {
                        public PasswordAuthentication getPasswordAuthentication()
                        {
                            return new PasswordAuthentication(c.getSmtpUser(),c.getSmtpPassword());
                        }
                    }));
                    mm.setSentDate(new Date());
                    mm.setFrom(new InternetAddress(c.getSmtpUser(),c.getSmtpName(),"UTF-8"));
                    mm.setSubject("中国水利水电承包商网：招标邀请","UTF-8");
                    //
                    MimeMultipart mp = new MimeMultipart();
                    MimeBodyPart bp = new MimeBodyPart();
                    bp.setContent("﻿<html><head><meta http-equiv='Content-Type' content=\"text/html;charset=UTF-8\" /></head><body>" + content,"text/html;charset=UTF-8");
                    mp.addBodyPart(bp);
                    mm.setContent(mp);
                    //发送
                    int err = 0,ok = 0;
                    for(int i = 0;i < al.size();i++)
                    {
                        String tmp = (String) al.get(i);
                        try
                        {
                            mm.setRecipients(javax.mail.Message.RecipientType.TO,tmp);
                            Transport.send(mm);
                            ok++;
                        } catch(Exception ex) //Messaging
                        {
                            err++;
                            System.out.println(ex.toString() + "==:==" + ex.getMessage());
                        }
                        //进度
                        out.print("<script>mt.progress(" + i + "," + al.size() + ",'正在发送（" + i + "/" + al.size() + "）：" + tmp + "');</script>");
                        out.flush();
                    }
                    info = "邮件：发送完成！　　成功：" + ok + "　失败：" + err;
                }
                if(h.getBool("sms")) //编辑
                {
                    info += "<br/><br/>短信：";
                    out.print("<script>parent.$('dialog_header').innerHTML='正在发送短信...';</script>");
                    //
                    String content = "中国水电" + h.get("dept") + h.get("item") + "项目" + h.get("project") + "工程，邀请您参加招标，可否、请及时回复。\r\n招标联系人：" + h.get("name") + "\r\n电话：" + h.get("tel") + "\r\n邮件：" + h.get("email");
                    int[] rs = SMessage.send(Profile.find(h.member).getProfile(),tmember,"|",content,out);
                    if(rs == null)
                        info += "通道已被“禁用”，不可发送短信！";
                    else
                        info += "发送完成！　　成功：" + rs[0] + "　失败：" + rs[1];
                }
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
