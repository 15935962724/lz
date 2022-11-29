package tea.ui.stat;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.stat.*;
import javax.servlet.*;
import javax.servlet.http.*;
import sun.management.*;
import com.sun.management.*;

public class TaskMgrs extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        ServletContext application = this.getServletContext();
        PrintWriter out = response.getWriter();
        try
        {
            if(act.startsWith("chart_"))
            {
                response.setHeader("Cache-Control","private"); //IE6 11.1.102.63 下 gzip 和 no-cache 并存，就报：This is the URL that I tried to open
                if("chart_cpu".equals(act))
                {
                    Calendar c = Calendar.getInstance();
                    c.add(Calendar.HOUR, -2);
                    c.set(Calendar.MINUTE,c.get(Calendar.MINUTE) / 10 * 10);
                    c.set(Calendar.SECOND,0);
                    int minute = (int) (c.getTimeInMillis() / 1000);
                    //
                    HashMap<Integer,StringBuilder> hm = new HashMap();
                    int[] taskmgr = new int[3];
                    taskmgr[0] = TaskMgr.find(0,"System Idle Process").taskmgr;
                    hm.put(taskmgr[0],new StringBuilder());
                    DbAdapter db = new DbAdapter();
                    try
                    {
                        java.sql.ResultSet rs = db.executeQuery("SELECT taskmgr FROM tasktime WHERE taskmgr!=" + taskmgr[0] + " AND time>" + minute + " GROUP BY taskmgr ORDER BY SUM(cpu) DESC",0,2);
                        for(int i = 1;rs.next();i++)
                        {
                            taskmgr[i] = rs.getInt(1);
                            hm.put(taskmgr[i],new StringBuilder());
                        }
                        rs.close();
                    } finally
                    {
                        db.close();
                    }
                    Iterator it = TaskTime.find(" AND taskmgr IN(" + taskmgr[0] + "," + taskmgr[1] + "," + taskmgr[2] + ") AND time>" + minute + " ORDER BY time",0,Integer.MAX_VALUE).iterator();
                    while(it.hasNext())
                    {
                        TaskTime t = (TaskTime) it.next();
                        hm.get(t.taskmgr).append(",{\"x\":" + t.time + ",\"y\":" + (taskmgr[0] == t.taskmgr ? 100 - t.cpu : t.cpu) + "}");
                    }

                    out.print("{");
                    out.print("  \"elements\":");
                    out.print("  [");
                    String[] COLOR =
                            {"FFA333","009149","0058C6"};

                    for(int i = 0;i < taskmgr.length;i++)
                    {
                        TaskMgr tm = TaskMgr.find(taskmgr[i]);
                        if(i > 0)
                            out.print(",");
                        out.print("    {");
                        out.print("      \"type\":\"line\",");
                        out.print("      \"values\":[" + hm.get(tm.taskmgr).substring(1) + "],");
                        out.print("      \"text\":\"" + (tm.pid == 0 ? "总使用" : tm.name) + "\",");
                        out.print("      \"colour\":\"#" + COLOR[i] + "\"");
                        out.print("    }");
                    }
                    out.print("  ],");
                    out.print("  \"x_axis\":");
                    out.print("  {");
                    out.print("    \"steps\": 60,");
                    out.print("    \"min\": " + minute + ",");
                    out.print("    \"max\": " + System.currentTimeMillis() / 1000 + ",");
                    out.print("    \"labels\":");
                    out.print("    {");
                    out.print("      \"rotate\": -45,");
                    out.print("      \"steps\": 300,");
                    out.print("      \"visible-steps\": 1,");
                    out.print("      \"text\": \"#date:H:i#\"");
                    out.print("    },");
                    out.print("    \"colour\":      \"#000000\",");
                    out.print("    \"grid-colour\": \"#E4E4E4\"");
                    out.print("  },");
                    out.print("  \"y_axis\":");
                    out.print("  {");
                    out.print("    \"max\": 100,");
                    out.print("    \"steps\": 10,");
                    out.print("    \"colour\": \"#000000\",");
                    out.print("    \"grid-colour\": \"#E4E4E4\"");
                    out.print("  },");
                    out.print("  \"title\":");
                    out.print("  {");
                    out.print("    \"text\": \"CPU\",");
                    out.print("    \"style\": \"{font-size: 20px; color:#0000ff; font-family: Verdana; text-align: center;}\"");
                    out.print("  },");
                    out.print("  \"bg_colour\": \"#FFFFFF\",");
                    out.print("  \"tooltip\":{\"stroke\":1}");
                    out.print("}");
                } else if("chart_mem".equals(act))
                {
                    OperatingSystemMXBean os = (OperatingSystemMXBean) ManagementFactory.getOperatingSystemMXBean();
                    int max = (int) (os.getTotalPhysicalMemorySize() / 1024);
                    //System.out.println("系统物理内存总计：" + os.getTotalPhysicalMemorySize() / 1024 + "K");
                    //System.out.println("系统物理可用内存总计：" + os.getFreePhysicalMemorySize() / 1024 + "K");

                    Calendar c = Calendar.getInstance();
                    c.add(Calendar.HOUR, -2);
                    c.set(Calendar.MINUTE,c.get(Calendar.MINUTE) / 10 * 10);
                    c.set(Calendar.SECOND,0);
                    int minute = (int) (c.getTimeInMillis() / 1000);
                    //
                    HashMap<Integer,StringBuilder> hm = new HashMap();
                    int[] taskmgr = new int[3];
                    taskmgr[0] = TaskMgr.find(0,"System Idle Process").taskmgr;
                    hm.put(taskmgr[0],new StringBuilder());
                    DbAdapter db = new DbAdapter();
                    try
                    {
                        java.sql.ResultSet rs = db.executeQuery("SELECT taskmgr FROM tasktime WHERE taskmgr!=" + taskmgr[0] + " AND time>" + minute + " GROUP BY taskmgr ORDER BY SUM(mem) DESC",0,2);
                        for(int i = 1;rs.next();i++)
                        {
                            taskmgr[i] = rs.getInt(1);
                            hm.put(taskmgr[i],new StringBuilder());
                        }
                        rs.close();
                    } finally
                    {
                        db.close();
                    }
                    Iterator it = TaskTime.find(" AND taskmgr IN(" + taskmgr[0] + "," + taskmgr[1] + "," + taskmgr[2] + ") AND time>" + minute + " ORDER BY time",0,Integer.MAX_VALUE).iterator();
                    while(it.hasNext())
                    {
                        TaskTime t = (TaskTime) it.next();
                        hm.get(t.taskmgr).append(",{\"x\":" + t.time + ",\"y\":" + t.mem + "}");
                    }

                    out.print("{");
                    out.print("  \"elements\":");
                    out.print("  [");
                    String[] COLOR =
                            {"FFA333","009149","0058C6"};

                    for(int i = 0;i < taskmgr.length;i++)
                    {
                        TaskMgr tm = TaskMgr.find(taskmgr[i]);
                        if(i > 0)
                            out.print(",");
                        out.print("    {");
                        out.print("      \"type\":\"line\",");
                        out.print("      \"values\":[" + hm.get(tm.taskmgr).substring(1) + "],");
                        out.print("      \"text\":\"" + (tm.pid == 0 ? "总使用" : tm.name) + "\",");
                        out.print("      \"colour\":\"#" + COLOR[i] + "\"");
                        out.print("    }");
                    }
                    out.print("  ],");
                    out.print("  \"x_axis\":");
                    out.print("  {");
                    out.print("    \"steps\": 60,");
                    out.print("    \"min\": " + minute + ",");
                    out.print("    \"max\": " + System.currentTimeMillis() / 1000 + ",");
                    out.print("    \"labels\":");
                    out.print("    {");
                    out.print("      \"rotate\": -45,");
                    out.print("      \"steps\": 300,");
                    out.print("      \"visible-steps\": 1,");
                    out.print("      \"text\": \"#date:H:i#\"");
                    out.print("    },");
                    out.print("    \"colour\":      \"#000000\",");
                    out.print("    \"grid-colour\": \"#E4E4E4\"");
                    out.print("  },");
                    out.print("  \"y_axis\":");
                    out.print("  {");
                    out.print("    \"max\": " + max + ",");
                    out.print("    \"steps\": " + max / 10 + ",");
                    out.print("    \"colour\": \"#000000\",");
                    out.print("    \"grid-colour\": \"#E4E4E4\"");
                    out.print("  },");
                    out.print("  \"title\":");
                    out.print("  {");
                    out.print("    \"text\": \"内存\",");
                    out.print("    \"style\": \"{font-size: 20px; color:#0000ff; font-family: Verdana; text-align: center;}\"");
                    out.print("  },");
                    out.print("  \"bg_colour\": \"#FFFFFF\",");
                    out.print("  \"tooltip\":{\"stroke\":1}");
                    out.print("}");
                } else if("chart_net".equals(act))
                {
                    Calendar c = Calendar.getInstance();
                    c.add(Calendar.HOUR, -2);
                    c.set(Calendar.MINUTE,c.get(Calendar.MINUTE) / 10 * 10);
                    c.set(Calendar.SECOND,0);
                    int minute = (int) (c.getTimeInMillis() / 1000);
                    //
                    int max = 10;
                    StringBuilder val0 = new StringBuilder(),val1 = new StringBuilder(),val2 = new StringBuilder();
                    Iterator it = TaskTime.find(" AND taskmgr=" + TaskMgr.find(0,"System Idle Process").taskmgr + " AND time>" + minute + " ORDER BY time",0,Integer.MAX_VALUE).iterator();
                    while(it.hasNext())
                    {
                        TaskTime t = (TaskTime) it.next();

                        val0.append(",{\"x\":" + t.time + ",\"y\":" + (t.received + t.sent) + "}");
                        val1.append(",{\"x\":" + t.time + ",\"y\":" + t.received + "}");
                        val2.append(",{\"x\":" + t.time + ",\"y\":" + t.sent + "}");
                        max = Math.max(max,t.received + t.sent);
                    }

                    out.print("{");
                    out.print("  \"elements\":");
                    out.print("  [");
                    out.print("    {");
                    out.print("      \"type\":\"line\",");
                    out.print("      \"values\":[" + val0.substring(1) + "],");
                    out.print("      \"text\":\"总使用\",");
                    out.print("      \"colour\":\"#FFA333\",");
                    out.print("      \"dot-style\":");
                    out.print("      {");
                    out.print("        \"tip\":\"总计: #val#k\"");
                    out.print("      }");
                    out.print("    },");
                    out.print("    {");
                    out.print("      \"type\":\"line\",");
                    out.print("      \"values\":[" + val1.substring(1) + "],");
                    out.print("      \"text\":\"接收\",");
                    out.print("      \"colour\":\"#009149\",");
                    out.print("      \"dot-style\":");
                    out.print("      {");
                    out.print("        \"tip\":\"接收: #val#k\"");
                    out.print("      }");
                    out.print("    },");
                    out.print("    {");
                    out.print("      \"type\":\"line\",");
                    out.print("      \"values\":[" + val2.substring(1) + "],");
                    out.print("      \"text\":\"发送\",");
                    out.print("      \"colour\":\"#0058C6\",");
                    out.print("      \"dot-style\":");
                    out.print("      {");
                    out.print("        \"tip\":\"发送: #val#k\"");
                    out.print("      }");
                    out.print("    }");
                    out.print("  ],");
                    out.print("  \"x_axis\":");
                    out.print("  {");
                    out.print("    \"steps\": 60,");
                    out.print("    \"min\": " + minute + ",");
                    out.print("    \"max\": " + System.currentTimeMillis() / 1000 + ",");
                    out.print("    \"labels\":");
                    out.print("    {");
                    //out.print("      \"size\":12,");
                    out.print("      \"rotate\": -45,");
                    out.print("      \"steps\": 300,");
                    out.print("      \"visible-steps\": 1,");
                    //Y: 年  y: 两位年
                    //m: 月  M: 英文月
                    //d: 日 jS: 英文日
                    //H: 时
                    //i: 分
                    //l: 英文星期
                    out.print("      \"text\": \"#date:H:i#\"");
                    out.print("    },");
                    out.print("    \"colour\":      \"#000000\",");
                    out.print("    \"grid-colour\": \"#E4E4E4\"");
                    out.print("  },");
                    out.print("  \"y_axis\":");
                    out.print("  {");
                    out.print("    \"max\": " + max + ",");
                    out.print("    \"steps\": " + max / 10 + ",");
                    out.print("    \"colour\": \"#000000\",");
                    out.print("    \"grid-colour\": \"#E4E4E4\"");
                    out.print("  },");
                    out.print("  \"title\":");
                    out.print("  {");
                    out.print("    \"text\": \"网络\",");
                    out.print("    \"style\": \"{font-size: 20px; color:#0000ff; font-family: Verdana; text-align: center;}\"");
                    out.print("  },");
                    out.print("  \"bg_colour\": \"#FFFFFF\",");
                    out.print("  \"tooltip\":{\"stroke\":1}");
                    out.print("}");
                }
                return;
            }
            out.print("<script>var mt=parent.mt;</script>");

            String info = "操作执行成功！";
            int taskmgr = h.getInt("taskmgr");
            String[] arr = taskmgr < 1 ? h.getValues("taskmgrs") : new String[]
                           {String.valueOf(taskmgr)};
            if("kill".equals(act)) //结束进程
            {
                for(int i = 0;i < arr.length;i++)
                {
                    TaskMgr t = TaskMgr.find(Integer.parseInt(arr[i]));
                    info = t.kill();
                }
            } else if("stop".equals(act)) //终止线程
            {
                ThreadGroup tg = Thread.currentThread().getThreadGroup();
                Thread[] ts = new Thread[tg.activeCount()];
                tg.enumerate(ts);

                for(int i = 0;i < arr.length;i++)
                {
                    for(int j = 0;j < ts.length;j++)
                    {
                        if(Integer.parseInt(arr[i]) != ts[j].getId())
                            continue;
                        ts[j].stop();
                    }
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
