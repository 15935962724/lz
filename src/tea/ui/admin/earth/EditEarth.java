package tea.ui.admin.earth;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.net.*;
import tea.ui.*;
import tea.entity.admin.earth.*;
import tea.entity.site.*;
import tea.db.*;
import tea.entity.node.*;
import tea.entity.member.*;
import java.awt.image.*;
import javax.imageio.*;
import java.awt.geom.*;
import java.util.Date;
import tea.entity.Http;
import java.util.regex.*;
import tea.entity.admin.*;

public class EditEarth extends HttpServlet
{
    ServletContext application;

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        Http h = new Http(request);
        String act = h.get("act");
        String nexturl = h.get("nexturl");
        HttpSession session = request.getSession(true);
        try
        {
            if("license".equals(act))
            {
                String sn = request.getParameter("serialnumber");
                String pwd = request.getParameter("password");
                EarthCdn ec = EarthCdn.find(sn);
                String ip = request.getRemoteAddr();
                boolean rs = ec.isPassword(pwd,ip);
                System.out.println("新添加机器: 编号:" + sn + " IP:" + ip + " 结果:" + rs);
                if(rs)
                {
                    Writer out = response.getWriter();
                    out.write(1);
                    out.close();
                }
                return;
            } else if(h.debug && act.startsWith("debug"))
            {
                PrintWriter out = response.getWriter();
                if("debug".equals(act))
                {
                    out.print("<html><body><script src='/tea/mt.js'></script><script>mt.login=function(a){form1.member.value=a;form1.submit();}</script>");
                    out.print("<a href='javascript:;' onclick='mt.tab(this)' name='a_tab'>用户</a> <a href='javascript:;' onclick='mt.tab(this)' name='a_tab'>会话</a> <a href='javascript:;' onclick='mt.tab(this)' name='a_tab'>社区</a>");
                    out.print("<form name='form1' action='?' method='post'><input name='act' type='hidden' value='debuglogin'><input name='member' type='hidden'>");
                    out.print("<table name='tab'><tr><th>用户<th>次数<th>");
                    DbAdapter db = new DbAdapter();
                    try
                    {
                        db.executeQuery("SELECT profile,member,logint FROM Profile ORDER BY logint DESC",0,200);
                        while(db.next())
                        {
                            int mid = db.getInt(1);
                            out.print("<tr onMouseOver=bgColor='#FFFFCA' onMouseOut=bgColor=''>");
                            out.print("<td><a href='###' onclick='mt.login(" + mid + ")'>" + db.getString(2) + "</a><td>" + db.getInt(3) + "");
                        }
                        out.print("</table>");
                    } finally
                    {
                        db.close();
                    }
                    //会话
                    out.print("<table name='tab' style='display:none'>");
                    Enumeration e = session.getAttributeNames();
                    while(e.hasMoreElements())
                    {
                        String n = (String) e.nextElement();
                        out.print("<tr><td>" + n + "<td>" + session.getAttribute(n));
                    }
                    Cookie[] cs = request.getCookies();
                    for(int i = 0;i < cs.length;i++)
                    {
                        String n = cs[i].getName();
                        out.print("<tr><td>[" + cs[i].getDomain() + "]" + n + "<td>[" + cs[i].getMaxAge() + "]" + cs[i].getValue());
                    }
                    out.print("</table>");
                    //社区
                    out.print("<table name='tab' style='display:none'>");
                    String wm = License.getInstance().getWebMaster();
                    try
                    {
                        out.println("<tr><td>" + wm + "<td>" + Profile.find(wm).getPassword());
                    } catch(Exception ex)
                    {}
                    out.println("<tr><td>REAL_PATH<td>" + getServletContext().getRealPath("/"));
                    e = DNS.find("",0,200);
                    while(e.hasMoreElements())
                    {
                        String sn = (String) e.nextElement();
                        DNS d = DNS.find(sn);
                        Community c = Community.find(d.getCommunity());

                        out.println("<tr><td>" + sn + "<td><a href='/html/" + c.community + "/folder/" + c.getNode() + "-1.htm' target='_parent'>" + c.community + "</a><td>" + Node.count(" AND path LIKE " + DbAdapter.cite("/" + d.getNode() + "/%")) + "<td>" + c.getStartTimeToString());
                    }
                    out.print("</table></form>");
                } else if("debuglogin".equals(act) && "POST".equals(request.getMethod()))
                {
                    int member = h.getInt("member");
                    Enumeration e = session.getAttributeNames();
                    while(e.hasMoreElements())
                    {
                        String n = (String) e.nextElement();
                        if("tea.Community".equals(n))
                            continue;
                        session.removeAttribute(n);
                    }
                    //session.setAttribute("tea.RV",new tea.entity.RV(member));
                    session.setAttribute("member",member);
                    out.print("<script>if(top.location==location)location='/';else top.location.reload();</script>");
                } else if("debugopen".equals(act))
                {
                    response.setContentType("text/javascript");
                    String url = h.get("url");
                    if(url == null)
                    {
                        String ref = request.getHeader("referer");
                        if(ref == null)
                            return;
                        out.print("var w=window;if(w._right)w=w._right;else if(w.m)w=w.m;");
                        out.print("var d=document,s=d.createElement('script');s.src='http://" + request.getServerName() + ":" + request.getServerPort() + "/servlet/EditEarth?act=debugopen&url='+encodeURIComponent(w.location);d.getElementsByTagName('head')[0].appendChild(s);");
                        return;
                    }
                    Matcher m = Pattern.compile("/right.jsp[?]([^&]*&)*id=(\\d+)").matcher(url);
                    if(m.find())
                    {
                        AdminFunction af = AdminFunction.find(Integer.parseInt(m.group(2)));
                        url = af.getUrl(1);
                    }
                    m = Pattern.compile("/(\\d+)-[012].htm").matcher(url);
                    if(m.find())
                    {
                        url = Node.find(Integer.parseInt(m.group(1))).getText(h.language);
                        m = Pattern.compile("<include src=\"([^>]+)\"/>").matcher(url);
                        if(!m.find())
                            return;
                        url = m.group(1);
                    }
                    if(url.startsWith("http"))
                        url = url.substring(url.indexOf('/',10));
                    int j = url.indexOf('?');
                    if(j != -1)
                        url = url.substring(0,j);

                    System.out.println(url);
                    File f = new File(Http.REAL_PATH + url);
                    if(!f.isFile())
                    {
                        out.println("document.title='[不存在]'+document.title;");
                        return;
                    }
                    ArrayList al = new ArrayList();
                    al.add("F:/Program Files/JBuilder2006/bin/JBuilderw.exe");
                    al.add("+SPLASH");
                    al.add("+SHELL"); //原窗口打开
                    al.add(f.getPath());
                    new ProcessBuilder(al).start();
                }
                out.close();
                return;
            }
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            application = getServletContext();
            if("editearthip".equals(act))
            {
                String oldip = request.getParameter("oldip");
                String ip = request.getParameter("ip");
                String name = request.getParameter("name");
                int port = Integer.parseInt(request.getParameter("port"));
                // kw 07.9.4
                int node = Integer.parseInt(request.getParameter("nodex"));
                if(Node.find(node).getCreator() == null)
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("无效节点","UTF-8"));
                    return;
                }
                if(!ip.equals(oldip))
                {
                    EarthIp obj = EarthIp.find(ip);
                    if(obj.isExists())
                    {
                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("IP地址已存在","UTF-8"));
                        return;
                    }
                    if(oldip != null)
                    {
                        EarthIp.find(oldip).setIp(ip);
                    }
                }
                EarthIp obj = EarthIp.find(ip);
                if(obj.isExists())
                {
                    obj.set(name,port,node);
                } else
                {
                    EarthIp.create(ip,name,port,0,node);
                }
            } else if("refreshearthip".equals(act))
            {
                String ip = request.getParameter("ip");
                EarthIp ei = EarthIp.find(ip);
                Enumeration e = EarthHost.findByIp(ip);
                while(e.hasMoreElements())
                {
                    String host = (String) e.nextElement();
                    EarthHost obj = EarthHost.find(host);
                    refresh(ei,obj);
                }
            } else if("deleteearthip".equals(act))
            {
                String ip = request.getParameter("ip");
                EarthIp obj = EarthIp.find(ip);
                obj.delete();
            } else if("moveearthip".equals(act))
            {
                String ip = request.getParameter("ip");
                int sequence = Integer.parseInt(request.getParameter("sequence"));
                Enumeration e = EarthIp.find("",0,Integer.MAX_VALUE);
                for(int i = 1;e.hasMoreElements();i = i + 2)
                {
                    String _ip = (String) e.nextElement();
                    EarthIp obj = EarthIp.find(_ip);
                    obj.setSequence(i);
                }
                EarthIp obj = EarthIp.find(ip);
                obj.setSequence(obj.getSequence() + sequence);
            } else
            // /////////////////////////////虚似主机//////////////////////////////////////////////////////////
            if("editearthhost".equals(act))
            {
                String host = request.getParameter("host");
                String ip = request.getParameter("ip");
                EarthHost obj = EarthHost.find(host);
                if(obj.isExists())
                {
                    obj.set(ip,obj.getName(),obj.getContext(),obj.getRealPath());
                } else
                {
                    EarthHost.create(host,ip);
                }
            } else if("refreshearthhost".equals(act))
            {
                String host = request.getParameter("host");
                EarthHost obj = EarthHost.find(host);
                EarthIp ei = EarthIp.find(obj.getIp());
                refresh(ei,obj);
            } else if("deleteearthhost".equals(act))
            {
                String host = request.getParameter("host");
                EarthHost obj = EarthHost.find(host);
                obj.delete();
            } else if("moveearthhost".equals(act))
            {
                String host = request.getParameter("host");
                boolean seq = "true".equals(request.getParameter("sequence"));
                Enumeration e = EarthHost.find("",0,Integer.MAX_VALUE);
                for(int i = 3;e.hasMoreElements();i = i + 2)
                {
                    String _host = (String) e.nextElement();
                    EarthHost obj = EarthHost.find(_host);
                    if(host.equals(_host))
                    {
                        if(seq) //up
                        {
                            obj.setSequence(i - 3);
                        } else
                        {
                            obj.setSequence(i + 3);
                        }
                    } else
                    {
                        obj.setSequence(i);
                    }
                }
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
        response.sendRedirect(nexturl);
    }

    private boolean refresh(EarthIp ei,EarthHost obj)
    {
        String host = obj.getHost();
        try
        {
            HttpURLConnection conn = (HttpURLConnection)new URL("http://" + host + ":" + ei.getPort() + "/servlet/EDNProbe?times=" + obj.getTimesToString()).openConnection();
            ObjectInputStream ois = new ObjectInputStream(conn.getInputStream());
            HashMap m = (HashMap) ois.readObject();
            ois.close();
            // ///////////License///////////////////////////////////
            String name = (String) m.get("license.webname");

            String realpath = (String) m.get("license.realpath");
            String context = (String) m.get("license.context");
            obj.set(obj.getIp(),name,context,realpath);
            obj.setTimes(new Date());

            // ///////////Profile///////////////////////////////////
            ArrayList al = (ArrayList) m.get("profile");
            for(int i = 0;i < al.size();i++)
            {
                HashMap p_m = (HashMap) al.get(i);
                String p_member = (String) p_m.get("profile.member");
                String p_community = (String) p_m.get("profile.community");
                String p_email = (String) p_m.get("profile.email");
                String p_password = (String) p_m.get("profile.password");
                String p_firstname = (String) p_m.get("profile.firstname");
                String p_lastname = (String) p_m.get("profile.lastname");
                Date p_time = (Date) p_m.get("profile.time");
                Profile p_obj = Profile.find(p_member);
                if(p_obj.getTime() == null)
                {
                    p_obj = Profile.create(p_member,p_password,p_community,p_email,host);
                    p_obj.setTime(p_time);
                }
                if(p_community == null)
                {
                    System.out.println(host + ":" + p_member);
                } else if(p_community.equals(p_obj.getCommunity()))
                {
                    p_obj.setPassword(p_password);
                    p_obj.setEmail(p_email);
                    p_obj.setFirstName(p_firstname,1);
                    p_obj.setLastName(p_lastname,1);
                }
            }
            // ///////////Community///////////////////////////////////
            Communityinfo.deleteByHost(host);
            al = (ArrayList) m.get("community");

            obj.set(al.size());

            for(int i = 0;i < al.size();i++)
            {
                HashMap c_m = (HashMap) al.get(i);
                String c_community = (String) c_m.get("community.community");
                String c_name = (String) c_m.get("community.name");
                String c_dns = (String) c_m.get("community.dns");
                String picurl = (String) c_m.get("community.picurl");
                boolean ise = Communityinfo.isCfid(c_community,obj.getIp(),obj.getContext());
                if(ise)
                {
                    System.out.println("社区同名:" + c_community + " / " + c_name);
                } else
                {
                    Communityinfo.create(c_community,host,c_name,obj.getIp(),obj.getContext(),picurl);
                    System.out.println("添加社区:" + c_community + " / " + c_name);
                }
                //截图
                /* if(c_dns != null)
                 {
                  DNS dns = DNS.find(c_dns);
                  dns.set(c_community,0,null,dns.getNode(),false);
                  File f = new File(application.getRealPath("/res/ROOT/snapshots/"));
                  if(!f.exists())
                  {
                   f.mkdirs();
                  }
                  f = new File(f,c_community + ".jpg");
                  boolean flag = Html2Pic.toPic("http://" + c_dns + ":" + ei.getPort(),f);
                  if(flag)
                  {
                   try
                   {
                 BufferedImage bi = ImageIO.read(f);
                 int w = bi.getWidth(),h = bi.getHeight();
                 int s_w = 1024,s_h = 768;
                 if(w < 800)
                 {
                  s_w = 800;
                  s_h = 600;
                 }
                 if(h > s_h)
                 {
                  h = (int) (s_h * ((float) w / s_w));
                  bi = bi.getSubimage(0,0,w,h);
                 }
                 if(w > 80 || h > 60)
                 {
                  ZoomOut zo = new ZoomOut();
                  bi = zo.imageZoomOut(bi,80,60);
                 }
                 ImageIO.write(bi,"JPG",f);
                   } catch(Exception ex)
                   {
                 System.out.println("生成快照错误:" + c_dns + "\t" + ex.getMessage());
                   }
                  }
                 }*/
            }
            //添加刷新时间

        } catch(Exception ex)
        {
            ex.printStackTrace();
            return false;
        }
        return true;
    }
}
