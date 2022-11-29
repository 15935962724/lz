package tea.ui.member;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.entity.*;
import tea.entity.node.*;
import tea.entity.member.*;
import tea.entity.site.*;


import tea.ui.TeaServlet;

/*
 集佳专用发邮件
 */
public class Subscibes2 extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        String nexturl = request.getParameter("nexturl");
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        try
        {
            TeaSession teasession = new TeaSession(request);
            String act = request.getParameter("act");
            if(act.equals("edit")) //订阅
            {
                String nodes[] = request.getParameterValues("nodes");
                if(nodes == null)
                {
                    out.print("<script>alert('无效的订阅项.');</script>");
                    return;
                }
                StringBuffer sb = new StringBuffer("/");
                for(int index = 0;index < nodes.length;index++)
                {
                    sb.append(nodes[index] + "/");
                }
                String email = request.getParameter("email");
                String arr[] = email.replaceAll("[ ;，；]",",").split(",");
                for(int i = 0;i < arr.length;i++)
                {
                    Subscibe.create(teasession._strCommunity,arr[i],sb.toString());
                }
                out.print("<script>alert('" + email + " 订阅成功.');");
                if(nexturl != null)
                {
                    out.print("parent.location.replace('" + nexturl + "');");
                }
                out.print("</script>");
                return;
            } else if(act.equals("cancel")) //退订
            {
                String v = request.getParameter("v");
                String email = request.getParameter("email");
                Subscibe obj = Subscibe.find(teasession._strCommunity,email);
                Date time = obj.getTimes();
                if(time != null && Long.parseLong(v) != time.getTime() * email.length())
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=error");
                    return;
                }
                obj.delete();
                response.sendRedirect("/jsp/info/Succeed.jsp?community=" + teasession._strCommunity + "&info=" + java.net.URLEncoder.encode(email + " 退订成功!!!","UTF-8"));
                return;
            }
            if(teasession._rv == null)
            {
//				response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);//////集佳登出问题
//				return;
            }
            if(act.equals("set"))
            {
                StringBuilder sb = new StringBuilder("/");
                String nodes[] = request.getParameterValues("nodes");
                if(nodes != null)
                {
                    for(int i = 0;i < nodes.length;i++)
                    {
                        sb.append(nodes[i]).append("/");
                    }
                }
                String tmp = request.getParameter("day");
                CommunityOption co = CommunityOption.find(teasession._strCommunity);
                Date sublast = co.getDate("sublast");
                if(sublast == null)
                {
                    co.set("sublast",new Date());
                }
                co.set("subday",tmp);
                co.set("subnode",sb.toString());
            } else if(act.equals("email"))
            {
                String email[] = request.getParameterValues("email");
                if(email != null)
                {
                    for(int index = 0;index < email.length;index++)
                    {
                        Subscibe obj = Subscibe.find(teasession._strCommunity,email[index]);
                        obj.delete();
                    }
                }
            } else if(act.equals("send")) //发送邮件
            {
                //int type = Integer.parseInt(request.getParameter("type"));
                int type = 1;
                String fathers[] = request.getParameterValues("fathers");
                String sn = request.getServerName() + ":" + request.getServerPort();
                String url = request.getParameter("url");
                String html = url;
                if(type == 0)
                {
                    if(fathers == null)
                    {
                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("无效选择...","utf-8"));
                        return;
                    }
                } else
                {
                    if(url.charAt(0) == '/')
                    {
                        url = sn + url;
                    }
                    try
                    {
                        html = (String) Entity.open(url);
                    } catch(Exception ex)
                    {
                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("无效URL...","utf-8"));
                        return;
                    }
                }
                out.print("<div id='p'>0</div><script>var p=document.getElementById('p');function f(i,e){p.innerHTML='已发送:'+i+' 正在发送:'+e;}</script>");
                out.flush();

                Community c = Community.find(teasession._strCommunity);

                String sitename = c.getName(teasession._nLanguage);
                String uname = request.getParameter("uname"); //发送人姓名
                String theme = request.getParameter("theme"); //主题内容

                if(theme != null && !theme.equals(""))
                {
                    sitename = theme;
                }
                if(uname != null)
                {
                    c.setSmtpName(uname);
                }

                String contents = request.getParameter("contents");
                if(contents != null && !contents.equals(""))
                {
                    contents = "<br><br><div align='left'>内容：" + contents + "</div>";
                } else
                {
                    contents = "";
                }
                //指定是否发送指定邮件
                int check_email = 0;
                if(teasession.getParameter("check_email") != null && teasession.getParameter("check_email").length() > 0)
                {
                    check_email = Integer.parseInt(teasession.getParameter("check_email"));
                }

//                String arr[] = request.getParameter("email").replaceAll("[ ;，；]",",").split(",");

                /////////////////////更改为3个列表
                String email1 = "";
                String email2 = "";
                String email3 = "";
                String[] arr = new String[3];
                int m = 0;
                email1 = request.getParameter("email1");
                arr[m++] = email1;

                email2 = request.getParameter("email2");
                arr[m++] = email2;

                email3 = request.getParameter("email3");
                arr[m++] = email3;

                Enumeration enumer = Subscibe.findByCommunity(teasession._strCommunity,0,Integer.MAX_VALUE);
                boolean f = false;
                if(check_email == 0)
                {
                    f = true;
                }

                for(int p = 0;p < arr.length || (enumer.hasMoreElements() && f);p++)
                {
                    String email = p < arr.length ? arr[p] : (String) enumer.nextElement();
                    //String email = arr[p];
                    if(email == null)
                    {
                        continue;
                    }
                    if(email.length() < 1)
                    {
                        continue;
                    }

                    out.print("<script>f(" + p + ",'" + email + "');</script>");
                    out.flush();
                    Subscibe obj = Subscibe.find(teasession._strCommunity,email);
                    String str = obj.getNode();
                    StringBuffer sb = new StringBuffer();
                    if(type == 0) //网页列表
                    {
                        sb.append("<base href='http://").append(sn).append("?manual' />");
                        sb.append(email).append("您好，感谢您的关注，你订阅<a target='_blank' href='/'>").append(sitename).append("</a>网站的栏目，有如下更新，请您点击查看。<br>");
                        sb.append("<table>");

                        for(int i = 0;i < fathers.length;i++)
                        {

                            if(str == null || check_email == 1 || check_email == 0 || str.indexOf("/" + fathers[i] + "/") != -1) //附件用户 或 订阅了此栏目
                            {
                                String nodes[] = request.getParameter("f" + fathers[i]).split("/");

                                if(nodes.length > 1)
                                {
                                    int id = Integer.parseInt(fathers[i]);
                                    Node n = Node.find(id);
                                    sb.append("<tr><td>&nbsp;</td></tr>");
                                    sb.append("<tr><th align='left'>").append(n.getSubject(teasession._nLanguage)).append("</th></tr>");
                                    for(int j = 1;j < nodes.length;j++)
                                    {
                                        id = Integer.parseInt(nodes[j]);
                                        n = Node.find(id);
                                        Report r = Report.find(id);
                                        int mid = r.getMedia();
                                        String author = mid > 0 ? Media.find(mid).getName(teasession._nLanguage) : r.getAuthor(teasession._nLanguage);
                                        String content = n.getText(teasession._nLanguage);
                                        content = content.replaceAll("<[^>]+>","");

                                        if(content.length() > 100)
                                        {
                                            content = content.substring(0,100) + "...";
                                        }
                                        sb.append("<tr style='line-height:5px'><td>&nbsp;</td></tr>");
                                        sb.append("<tr><td><a target='_blank' href='/servlet/Node?node=").append(id).append("&language=").append(teasession._nLanguage).append("'>").append(n.getSubject(teasession._nLanguage)).append("</a></td></tr>");
                                        sb.append("<tr><td style='color:#666666'>").append(author).append(" - ").append(r.getIssueTimeToString()).append("</td></tr>");
                                        sb.append("<tr><td>").append(content).append("</td></tr>");
                                        sb.append(contents);
                                    }
                                }
                            }
                        }
                        sb.append("</table>");
                    } else //网页内容
                    {
                        //sb.append("<base href='").append(url).append("' />");
                        html = html.replaceAll("http://" + request.getServerName(),"");
                        html = html.replaceAll(request.getServerName(),"");

                        html = html.replaceAll("href=\"","href=\"http://" + request.getServerName());
                        html = html.replaceAll("src=\"","src=\"http://" + request.getServerName());

                        html = html.replaceAll("href='","href='http://" + request.getServerName());
                        html = html.replaceAll("src='","src='http://" + request.getServerName());

                        //html = html.replaceAll("<html><head>", "<html><head><base href='"+url+"' /> ");

                        sb.append(html);

                        sb.append(contents);
                        //System.out.println(sb.toString());


                    }
                    Date time = obj.getTimes();
                    if(time != null) //此用户存在订阅
                    {
                        //集佳去掉
                        //long v = time.getTime() * email.length();
                        //sb.append("<br><br>如果您以后不想收到此邮件，请点击<a href='/servlet/Subscibes?community=" + teasession._strCommunity + "&email=" + email + "&v=" + v + "&act=cancel'>退订</a>。");
                        //sb.append(" <a href='/jsp/subscibe/EditSubscibe.jsp?community=" + teasession._strCommunity + "&email=" + email + "&v=" + v + "&nexturl=" + java.net.URLEncoder.encode("/jsp/info/Succeed.jsp?nexturl=/","UTF-8") + "'>管理</a>订阅的栏目。");
                        //sb.append(" 如需要更多服务，请访问<a href='/'>").append(sitename).append("</a>网站。");
                    }
                    Email.create(teasession._strCommunity,null,email,"订阅:" + sitename,sb.toString()); //发送
                }
                out.print("<script>location.replace('/jsp/info/Succeed.jsp');</script>");
                return;
            }
            response.sendRedirect("/jsp/info/Succeed.jsp?nexturl=" + java.net.URLEncoder.encode(nexturl,"UTF-8"));
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
        out.close();
    }

}
