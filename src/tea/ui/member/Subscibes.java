package tea.ui.member;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.entity.*;
import tea.db.*;
import tea.entity.node.*;
import tea.entity.member.*;
import tea.entity.site.*;

public class Subscibes extends TeaServlet
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
                Subscibe obj = Subscibe.find(teasession._strCommunity,email);
                if(obj.isExists())
                {
                    out.print("<script>alert('这个邮箱已经订阅，不能重复订阅');</script>");
                    return;
                }
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
                outLogin(request,response,new Http(request));
                return;
            }
            if(act.equals("set"))
            {
                StringBuilder sb = new StringBuilder("/");
                String nodes[] = request.getParameterValues("nodes");
                if(nodes != null)
                {
                    for(int i = 0;i < nodes.length;i++)
                    {
                        sb.append(nodes[i] + "/");
                    }
                }
                String tmp = request.getParameter("day");
                String customnode=request.getParameter("customnode");
                StringBuilder cusb=new StringBuilder("/");
                if(customnode!=null&&customnode.trim().length()==0){
                	cusb.append("");
                }else if(customnode.indexOf("/")>=0){
                	String[] cusnode=customnode.split("/");
                	for(int i=0;i<cusnode.length;i++){
                		if(cusnode[i]!=null&&cusnode[i].trim().length()>0){
                			cusb.append(cusnode[i]+"/");
                		}
                	}
                }

                CommunityOption co = CommunityOption.find(teasession._strCommunity);
                Date sublast = co.getDate("sublast");
                if(sublast == null)
                {
                    co.set("sublast",new Date());
                }
                co.set("subday",tmp);
                co.set("subnode",sb.toString());
                co.set("customnode", cusb.toString());
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
            }else if(act.equals("sendEmail"))
            {
            	out.print("<script>var mt=parent.mt;</script>");
            	for(int j = 0;j < 20;j++)
                    out.write("// 显示进度条  \n");

                Community c = Community.find(teasession._strCommunity);
                String sitename = c.getName(teasession._nLanguage);

                String theme = request.getParameter("theme"); //主题内容
                if(theme != null && !theme.equals(""))
                {
                    sitename = theme;
                }
                String contents = request.getParameter("contents");
                if(contents != null && !contents.equals(""))
                {
                    contents = "<br><br><div align='left'>内容：" + contents + "</div>";
                } else
                {
                    contents = "";
                }
                String add = request.getParameter("email").replaceAll("[ ;，；,]","','");
                ArrayList al = new ArrayList();
                String arr[] = add.split("','");
                for(int i = 0;i < arr.length;i++)
                {
                    al.add(arr[i]);
                }
                for(int p = 0;p < al.size();p++)
                {
                    String email = (String) al.get(p);
                    if(email.length() < 1)
                        continue;
                    out.print("<script>mt.progress(" + p + "," + al.size() + ");</script>");
                    out.flush();
                    Subscibe obj = Subscibe.find(teasession._strCommunity,email);
                    String str = obj.getNode();
                    StringBuffer sb = new StringBuffer();
                    
                    if(obj.isExists()) //此用户存在订阅
                    {
                        
                    }
                    Email.create(teasession._strCommunity,null,email,sitename,contents);
                }
                out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
                return;
                
            } else if(act.equals("send"))
            {
                out.print("<script>var mt=parent.mt;</script>");
                int type = Integer.parseInt(request.getParameter("type"));
                String fathers[] = request.getParameterValues("fathers");
                String sn = "http://" + request.getServerName() + ":" + request.getServerPort();
                String url = request.getParameter("url");
                String html = url;
                if(type == 0)
                {
                    if(fathers == null)
                    {
                        out.print("<script>mt.show('无效选择！');</script>");
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
						html = (String) Http.open(url,null);
                        StringBuffer surl=request.getRequestURL();
                        String uri=request.getRequestURI();
                        String rurl=surl.substring(0, surl.length()-uri.length());
                        StringBuffer buf=this.getRealCJS(new StringBuffer(html), "<link","href=\"", rurl,"style");
                        StringBuffer rhtml=this.getRealHtml(new StringBuffer(html), "src=\"", rurl,"\"");
                        buf=this.getRealHtml(buf, "url(", rurl,"\"");
                        rhtml=this.getRealHtml(rhtml, "href=\"", rurl,"\"");
                        rhtml=this.getRealHtml(rhtml, "url(", rurl,"\"");
                        rhtml=this.getRealHtml(new StringBuffer(rhtml), "href='", rurl,"'");
                        String st="<div id=\"Header\">";
                        if(rhtml.indexOf(st)>=0){
                        html=rhtml.replace(rhtml.indexOf(st), rhtml.indexOf(st)+st.length(), st+buf.toString()).toString();
                        }else{
                        	html=rhtml.toString();
                        }
                       // html.replaceAll("position:absolute", "");
                    } catch(Exception ex)
                    {
                        out.print("<script>mt.show('无效URL！');</script>");
                        return;
                    }
                }
                for(int j = 0;j < 20;j++)
                    out.write("// 显示进度条  \n");

                Community c = Community.find(teasession._strCommunity);
                String sitename = c.getName(teasession._nLanguage);

                String theme = request.getParameter("theme"); //主题内容
                if(theme != null && !theme.equals(""))
                {
                    sitename = theme;
                }
                String contents = request.getParameter("contents");
                if(contents != null && !contents.equals(""))
                {
                    contents = "<br><br><div align='left'>内容：" + contents + "</div>";
                } else
                {
                    contents = "";
                }
                String add = request.getParameter("email").replaceAll("[ ;，；,]","','");
                boolean isAtt = teasession.getParameter("check_email") != null;
                ArrayList al = isAtt ? new ArrayList() : Subscibe.find(" AND community=" + DbAdapter.cite(teasession._strCommunity) + " AND email NOT IN('" + add + "') AND node IS NOT NULL AND node!='/'",0,Integer.MAX_VALUE);
                String arr[] = add.split("','");
                for(int i = 0;i < arr.length;i++)
                {
                    al.add(arr[i]);
                }

                for(int p = 0;p < al.size();p++)
                {
                    String email = (String) al.get(p);
                    if(email.length() < 1)
                        continue;
                    out.print("<script>mt.progress(" + p + "," + al.size() + ");</script>");
                    out.flush();

                    isAtt = add.indexOf(email) != -1;
                    Subscibe obj = Subscibe.find(teasession._strCommunity,email);
                    String str = obj.getNode();
                    StringBuffer sb = new StringBuffer();
                    if(type == 0) //网页列表
                    {
                        sb.append("<base href='" + sn + "?manual' />");
                        sb.append(email + "您好，感谢您的关注，你订阅<a target='_blank' href='" + sn + "'>" + sitename + "</a>网站的栏目，有如下更新，请您点击查看。<br>");
                        sb.append("<table>");
                        for(int i = 0;i < fathers.length;i++)
                        {
                            if(!isAtt && str.indexOf("/" + fathers[i] + "/") == -1)
                                continue; //附件用户 或 订阅了此栏目

                            String nodes[] = request.getParameter("f" + fathers[i]).split("/");
                            if(nodes.length > 1)
                            {
                                int id = Integer.parseInt(fathers[i]);
                                Node n = Node.find(id);
                                sb.append("<tr><td>&nbsp;</td></tr>");
                                sb.append("<tr><th align='left'>" + n.getSubject(teasession._nLanguage) + "</th></tr>");
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
                                    sb.append("<tr><td><a target='_blank' href='" + sn + "/html/"+n.getCommunity()+"/report/" + id + "-" + teasession._nLanguage + ".htm'>" + n.getSubject(teasession._nLanguage) + "</a></td></tr>");
                                    sb.append("<tr><td style='color:#666666'>" + author + " - " + r.getIssueTimeToString() + "</td></tr>");
                                    sb.append("<tr><td>" + content + "</td></tr>");
                                }
                            }
                        }
                        sb.append("</table>");
                    } else //网页内容
                    {
                        sb.append("<base href='" + url + "' />");
                        sb.append(html);
                        sb.append(contents);
                    }
                    if(obj.isExists()) //此用户存在订阅
                    {
                        long v = obj.getTimes().getTime() * email.length();
                        sb.append("<br><br>如果您以后不想收到此邮件，请点击<a href='" + sn + "/servlet/Subscibes?community=" + teasession._strCommunity + "&email=" + email + "&v=" + v + "&act=cancel'>退订</a>。");
                        sb.append(" <a href='" + sn + "/jsp/subscibe/EditSubscibe.jsp?community=" + teasession._strCommunity + "&email=" + email + "&v=" + v + "&nexturl=" + java.net.URLEncoder.encode("/jsp/info/Succeed.jsp?nexturl=/","UTF-8") + "'>管理</a>订阅的栏目。");
                        sb.append(" 需要更多服务，请访问<a href='" + sn + "'>" + sitename + "</a>网站。");
                    }
                    Email.create(teasession._strCommunity,null,email,sitename,sb.toString());
                }
                out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
                return;
            }
            response.sendRedirect("/jsp/info/Succeed.jsp?nexturl=" + java.net.URLEncoder.encode(nexturl,"UTF-8"));
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        } finally
        {
            out.close();
        }
    }
    public StringBuffer getRealHtml(StringBuffer content,String value,String url,String yh){
    	int index=content.indexOf(value);
    	int index2=-1;
    	while(index>=0){
    		index2=content.indexOf(yh, index+value.length());
    		if(index2>0){
    			String rtext=content.substring(index+value.length(),index2);
    			if(rtext.toLowerCase().indexOf("http://")==-1){
    				content=content.replace(index+value.length(), index+value.length()+rtext.length(), url+rtext);
    			}
    		}
    		index=content.indexOf(value,index+1);
    		System.out.println(index);
    	}
    	return content;
    }



    public StringBuffer getRealCJS(StringBuffer content,String value,String value1,String url,String name) throws IOException{
    	int index=content.indexOf(value);
    	int index2=-1;
    	int index3=0;
    	int index4=0;
    	StringBuffer sb=new StringBuffer();
    	while(index>=0){
    		index2=content.indexOf(value1, index+value.length());
    		index3=content.indexOf(">", index+value.length());
    		if(index2>0&&index2<index3){
        		index4=content.indexOf("\"", index2+value1.length());
        		if(index4>0&&index4<index3){
    			String rtext=content.substring(index2+value1.length(),index4);
    			//content=content.replace(index2+value1.length(), index4, url+rtext);
    			if(rtext.endsWith(".css")){
    				HttpURLConnection http=(HttpURLConnection)new URL(url+rtext).openConnection();
    				try{
    				byte[] byt=Entity.read(http.getInputStream());
    				String styl=new String(byt,"UTF-8");
    				sb.append(styl);
    				}catch(Exception e){
    					e.printStackTrace();
    				}
    			}
        		}
    		}
    		index=content.indexOf(value,index3+1);
    		System.out.println(index);
    	}
    	content=new StringBuffer().append("<style type=\"text/css\">").append(sb).append("</style>");

    	return content;
    }
}
