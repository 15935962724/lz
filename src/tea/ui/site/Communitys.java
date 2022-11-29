package tea.ui.site;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.util.zip.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.site.*;
import tea.entity.node.*;

public class Communitys extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            if(h.member < 1)
            {
                out.print("<script>top.location.replace('/servlet/StartLogin?community=" + h.community + "');</script>");
                return;
            }
            String act = h.get("act"),nexturl = h.get("nexturl","");
            Community c = Community.find(h.community);
            if("sms".equals(act))
            {
                c.smsserver = h.getInt("smsserver");
                c.smsuser = h.get("smsuser");
                c.smspassword = h.get("smspassword");
                c.smsremind = h.getBool("smsremind");
                c.smssignature = h.get("smssignature");
                c.set();
            } else if("tjbaidu".equals(act))
            {
                c.set("tjbaidu",c.tjbaidu = "|" + h.get("tjuser") + "|" + h.get("tjpwd") + "|" + h.get("tjtoken") + "|" + h.getInt("tjid") + "|");
            } else if("htm".equals(act))
            {
                for(int j = 0;j < 20;j++)
                    out.write("// 显示进度条  \n");

                String path = "/res/html_" + System.currentTimeMillis() + ".zip";
                File f = new File(Http.REAL_PATH + path);
                ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(f));
                //首页
                zos.putNextEntry(new ZipEntry("index.htm"));
                zos.write(("<script>location.replace('/html/" + h.community + "/folder/" + c.getNode() + "-" + h.language + ".htm');</script>").getBytes());
                //
                HashMap<Integer,StringBuilder> hm = new HashMap();
                int count = 0,sum = Node.count(" AND community=" + DbAdapter.cite(h.community));
                Enumeration e = Node.find(" AND community=" + DbAdapter.cite(h.community),0,Integer.MAX_VALUE);
                while(e.hasMoreElements())
                {
                    int id = (Integer) e.nextElement();
                    Node n = Node.find(id);
                    //进度
                    if(count++ % 10 == 0)
                    {
                        out.print("<script>mt.progress(" + count + "," + sum + ",'节点号：" + id + "　名称：" + n.getSubject(h.language) + "');</script>");
                        out.flush();
                    }
                    int type = n.getType();
                    zos.putNextEntry(new ZipEntry("html/" + h.community + "/" + Node.NODE_TYPE[type].toLowerCase() + "/" + id + "-" + h.language + ".htm"));
                    String htm = h.read("/servlet/Node?node=" + id + "&language=" + h.language + "&session=false");
                    zos.write(htm.getBytes("UTF-8"));
                    //
                    StringBuilder js = hm.get(type);
                    if(js == null)
                        hm.put(type,js = new StringBuilder("\r\nNODE[" + type + "]=["));
                    js.append(id).append(",");
                    //
                    //zos.putNextEntry(new ZipEntry("html/" + h.community + "/node/" + id + "-" + h.language + ".htm"));
                    //zos.write(("<script>location.replace('/404.htm');</script>").getBytes());
                }
                //404页面
                zos.putNextEntry(new ZipEntry("404.htm"));
                StringBuilder js = new StringBuilder();
                js.append("﻿<script>");
                js.append("\r\nvar pt=Array.prototype;");
                js.append("\r\npt.indexOf=function(s){for(var i=0;i<this.length;i++)if(this[i]==s)return i;return -1;};");
                js.append("\r\nvar TYPE=[");
                for(int i = 0;i < Node.NODE_TYPE.length;i++)
                    js.append("'" + Node.NODE_TYPE[i].toLowerCase() + "',");
                js.append("];");
                js.append("\r\nvar NODE=[];");
                Iterator it = hm.keySet().iterator();
                while(it.hasNext())
                    js.append(hm.get(it.next()).append("];"));
                js.append("\r\nvar url=location.pathname;");
                js.append("\r\nvar arr=url.substring(url.lastIndexOf('/')+1,url.length-4)+'-" + h.language + "';");
                js.append("\r\narr=arr.split('-');");
                js.append("\r\nfor(var i=0;i<NODE.length;i++)");
                js.append("\r\n{");
                js.append("\r\n  if(NODE[i].indexOf(arr[0])!=-1)");
                js.append("\r\n  {");
                js.append("\r\n    var ok='/html/" + h.community + "/'+TYPE[i]+'/'+arr[0]+'-'+arr[1]+'.htm';");
                js.append("\r\n    if(url!=ok)location.replace(ok);");
                js.append("\r\n    break;");
                js.append("\r\n  }");
                js.append("\r\n}");
                js.append("\r\n</script>");
                js.append("抱歉，该页不存在！<a href='/'>回首页</a>");
                zos.write(js.toString().getBytes("UTF-8"));
                //

                zos.close();
                out.print("<script>mt.show('操作执行成功！<br/>节点：" + sum + "个<br/>大小：" + MT.f(f.length() / 1024F) + "k',2,'" + path + "');parent.$('dl_ok').value=' 下 载 ';</script>");
                return;
            }
            out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
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
