package tea.entity.stat;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.entity.*;
import tea.db.*;
import java.math.*;
import java.util.regex.*;

public class TaskMgr
{
    protected static Cache c = new Cache(50);
    public int taskmgr;
    public int pid;
    public String title; //窗口标题
    public String name; //映像名称
    public String command; //命令行
    public String sessionname; //会话名
    public int memusage; //内存使用量，单位为 kb
    public static String[] STATUS_TYPE =
            {"--","正在运行","未响应","未知"};
    public int status; //状态
    public String username; //用户名
    public int cpu; //CPU 使用
    public int cpu0; //CPU 时间 本次
    public int cpu1; //        上次
    public Date stime; //运行时间
    public Date etime; //终止时间
    public long received; //接收
    public long sent; //发送

    public TaskMgr(int taskmgr)
    {
        this.taskmgr = taskmgr;
    }

    public static TaskMgr find(int taskmgr) throws SQLException
    {
        TaskMgr t = (TaskMgr) c.get(taskmgr);
        if(t == null)
        {
            ArrayList al = find(" AND taskmgr=" + taskmgr,0,1);
            t = al.size() < 1 ? new TaskMgr(taskmgr) : (TaskMgr) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT taskmgr,pid,title,name,command,sessionname,memusage,status,username,cpu,cpu0,cpu1,stime,etime,received,sent FROM taskmgr WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                TaskMgr t = new TaskMgr(rs.getInt(i++));
                t.pid = rs.getInt(i++);
                t.title = rs.getString(i++);
                t.name = rs.getString(i++);
                t.command = rs.getString(i++);
                t.sessionname = rs.getString(i++);
                t.memusage = rs.getInt(i++);
                t.status = rs.getInt(i++);
                t.username = rs.getString(i++);
                t.cpu = rs.getInt(i++);
                t.cpu0 = rs.getInt(i++);
                t.cpu1 = rs.getInt(i++);
                t.stime = db.getDate(i++);
                t.etime = db.getDate(i++);
                t.received = rs.getLong(i++);
                t.sent = rs.getLong(i++);
                c.put(t.pid,t);
                al.add(t);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM taskmgr WHERE 1=1" + sql);
    }


    public void set(DbAdapter db) throws SQLException
    {
        if(taskmgr < 1)
        {
            db.executeUpdate("INSERT INTO taskmgr(pid,title,name,command,sessionname,memusage,status,username,cpu,cpu0,cpu1,stime,etime,received,sent)VALUES(" + pid + "," + DbAdapter.cite(title) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(command) + "," + DbAdapter.cite(sessionname) + "," + memusage + "," + status + "," + DbAdapter.cite(username) + "," + cpu + "," + cpu0 + "," + cpu1 + "," + DbAdapter.cite(stime) + "," + DbAdapter.cite(etime) + "," + received + "," + sent + ")");
            db.executeQuery("SELECT MAX(taskmgr) FROM taskmgr WHERE pid=" + pid);
            taskmgr = db.next() ? db.getInt(1) : 0;
        } else
        {
            db.executeUpdate("UPDATE taskmgr SET pid=" + pid + ",title=" + DbAdapter.cite(title) + ",name=" + DbAdapter.cite(name) + ",command=" + DbAdapter.cite(command) + ",sessionname=" + DbAdapter.cite(sessionname) + ",memusage=" + memusage + ",status=" + status + ",username=" + DbAdapter.cite(username) + ",cpu=" + cpu + ",cpu0=" + cpu0 + ",cpu1=" + cpu1 + ",stime=" + DbAdapter.cite(stime) + ",etime=" + DbAdapter.cite(etime) + ",received=" + received + ",sent=" + sent + " WHERE taskmgr=" + taskmgr);
        }
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM taskmgr WHERE taskmgr=" + taskmgr);
        c.remove(pid);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE taskmgr SET " + f + "=" + DbAdapter.cite(v) + " WHERE taskmgr=" + taskmgr);
        c.remove(pid);
    }

    //
    static StringBuilder PID = new StringBuilder();
    public static TaskMgr find(int pid,String command) throws SQLException
    {
        boolean flag = false;
        ArrayList<TaskMgr> al = find(" AND pid=" + pid + " AND command=" + DbAdapter.cite(command),0,1);
        if(al.size() < 1)
        {
            al = find(" AND pid NOT IN(0" + PID.toString() + ") AND command=" + DbAdapter.cite(command),0,1);
            PID.append(",").append(pid);
            flag = true;
        }
        TaskMgr tm = al.size() < 1 ? new TaskMgr(0) : al.get(0);
        tm.pid = pid;
        tm.command = command;
        if(flag)
            tm.sent = tm.received = tm.cpu0 = 0;
        return tm;
    }

    public String kill() throws SQLException,IOException
    {
        String info = TaskMgr.exec(new String[]
                                   {"tskill",String.valueOf(pid)});
        this.set("etime",MT.f(etime = new Date(),1));
        return info;
    }

    public static String exec(String[] arr) throws IOException
    {
        Process p = new ProcessBuilder(arr).start();
        String str = new String(Filex.read(p.getInputStream()));
        p.destroy();
        if(str.length() < 1)
            str = "操作执行成功！";
        return str;
    }

    public static void ref()
    {
        try
        {
            int sum = 0,mem = 0;
            Date time = new Date();
            int minute = (int) (time.getTime() / 60000) * 60;
            if(System.getProperty("os.name").startsWith("Windows "))
            {
                String str = exec(new String[]
                                  {"tasklist","/v","/fo","csv"}); //wmic process get ProcessId,ExecutablePath
                String[] lines = str.split("\r\n");

                int rece = 0,sent = 0;
                TaskMgr[] t = new TaskMgr[lines.length - 2];
                for(int i = 0;i < t.length;i++)
                {
                    String[] arr = lines[i + 1].split("\",\"");
                    t[i] = TaskMgr.find(Integer.parseInt(arr[1]),arr[0].substring(1));
                    t[i].name = t[i].command;
                    t[i].sessionname = arr[2];
                    t[i].memusage = Integer.parseInt(arr[4].substring(0,arr[4].length() - 2).replaceAll(",",""));
                    mem += t[i].memusage;
                    if("Running".equals(arr[5]))
                        t[i].status = 1;
                    else if("Not Responding".equals(arr[5]))
                        t[i].status = 2;
                    else if("Unknown".equals(arr[5]))
                        t[i].status = 3;
                    t[i].username = arr[6].substring(arr[6].indexOf('\\') + 1);
                    //CPU
                    t[i].cpu1 = t[i].cpu0;
                    String[] ts = arr[7].split(":");
                    t[i].cpu0 = Integer.parseInt(ts[0]) * 3600 + Integer.parseInt(ts[1]) * 60 + Integer.parseInt(ts[2]);
                    sum += t[i].cpu0 - t[i].cpu1;
                    //最大长度_255
                    t[i].title = arr[8].substring(0,arr[8].length() - 1);
                    if("暂缺".equals(t[i].title) || "OleMainThreadWndName".equals(t[i].title))
                        t[i].title = null;
                    //流量
                    if(t[i].pid == 0)
                    {
                        str = TaskMgr.exec(new String[]
                                           {"netstat","-e"}); //系统10秒一更新
                        arr = str.split("\r\n")[4].split(" +");
                        long rold = t[i].received,sold = t[i].sent;
                        t[i].received = Long.parseLong(arr[1]);
                        t[i].sent = Long.parseLong(arr[2]);
                        if(rold > 0 || sold > 0)
                        {
                            rece = (int) (t[i].received - rold) / 61440;
                            sent = (int) (t[i].sent - sold) / 61440;
                        }
                    }
                }
                //
                StringBuilder ska = new StringBuilder();
//                Map m = Thread.getAllStackTraces();
//                Iterator it = m.keySet().iterator();
//                while(it.hasNext())
//                {
//                    Thread th = (Thread) it.next();
//                    if(!Thread.State.valueOf("RUNNABLE").equals(th.getState()))
//                        continue;
//                    ska.append("--\n");
//                    StackTraceElement[] ste = (StackTraceElement[]) m.get(th);
//                    for(int i = 0;i < ste.length;i++)
//                    {
//                        ska.append(ste[i].toString()).append("\n");
//                    }
//                }

                BigDecimal bd = new BigDecimal(sum);
                StringBuilder sb = new StringBuilder();
                DbAdapter db = new DbAdapter();
                try
                {
                    db.setAutoCommit(false);
                    for(int i = 0;i < t.length;i++)
                    {
                        //
                        t[i].cpu = new BigDecimal((t[i].cpu0 - t[i].cpu1) * 100L).divide(bd,0,4).intValue();
                        if(t[i].taskmgr < 1)
                            t[i].stime = time;
                        else
                            t[i].etime = null;
                        t[i].set(db);
                        sb.append(t[i].pid).append(",");
                        //
                        TaskTime tp = new TaskTime(t[i].taskmgr,minute);
                        tp.mem = t[i].memusage;
                        tp.cpu = t[i].cpu;
                        //
                        if(i == 0)
                        {
                            tp.mem = mem;
                            tp.received = rece;
                            tp.sent = sent;
                            tp.content = ska.toString();
                        }
                        tp.set(db);
                    }
                    //已终止的进程
                    db.executeUpdate("UPDATE taskmgr SET etime=" + DbAdapter.cite(time) + " WHERE pid NOT IN(" + sb.toString() + "0) AND etime IS NULL");
                    db.executeUpdate("DELETE FROM tasktime WHERE time<" + (minute - 2592000));
                    db.commit();
                } finally
                {
                    db.setAutoCommit(true);
                    db.close();
                }
            } else
            {
                String str = exec(new String[]
                                  {"/bin/ps","-e","-ouser,pid,c,vsz,rss,args"});
                String[] lines = str.split("\n");
                TaskMgr[] t = new TaskMgr[lines.length];
                for(int i = 1;i < lines.length;i++)
                {
                    String[] arr = lines[i].split(" +",6);
                    if(arr[5].charAt(0) == '[')
                        continue;
                    t[i] = TaskMgr.find(Integer.parseInt(arr[1]),arr[5]);
                    t[i].username = arr[0];
                    t[i].cpu = Integer.parseInt(arr[2]);
                    t[i].memusage = Integer.parseInt(arr[4]); // + Integer.parseInt(arr[3]);
                    //
                    if(t[i].taskmgr < 1)
                    {
                        int j = t[i].command.indexOf(' ');
                        if(j == -1)
                            j = t[i].command.length();
                        t[i].name = t[i].command.substring(t[i].command.lastIndexOf('/',j) + 1,j);
                        t[i].stime = time;
                    } else
                        t[i].etime = null;
                    sum += t[i].cpu;
                    mem += t[i].memusage;
                }
                t[0] = TaskMgr.find(0,"System Idle Process");
                t[0].name = t[0].command;
                t[0].cpu = 100 - sum;
                StringBuilder sb = new StringBuilder();
                DbAdapter db = new DbAdapter();
                try
                {
                    db.setAutoCommit(false);
                    for(int i = 0;i < t.length;i++)
                    {
                        //
                        if(t[i] == null)
                            continue;
                        t[i].set(db);
                        sb.append(t[i].pid).append(",");
                        //
                        TaskTime tp = new TaskTime(t[i].taskmgr,minute);
                        tp.mem = t[i].memusage;
                        tp.cpu = t[i].cpu;
                        //
                        if(i == 0)
                        {
                            tp.mem = mem;
                        }
                        tp.set(db);
                    }
                    //已终止的进程
                    db.executeUpdate("UPDATE taskmgr SET etime=" + DbAdapter.cite(time) + " WHERE pid NOT IN(" + sb.toString() + "0) AND etime IS NULL");
                    db.executeUpdate("DELETE FROM tasktime WHERE time<" + (minute - 2592000));
                    db.commit();
                } finally
                {
                    db.setAutoCommit(true);
                    db.close();
                }
            } //ifconfig eth0 | grep bytes
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }
}
