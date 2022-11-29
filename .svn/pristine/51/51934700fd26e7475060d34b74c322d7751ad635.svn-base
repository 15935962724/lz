package tea.entity.stat;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class TaskTime
{
    protected static Cache c = new Cache(50);
    public int taskmgr;
    public int time;
    public int cpu;
    public int mem;
    public int received; //接收
    public int sent; //发送
    public String content;

    public TaskTime(int taskmgr,int time)
    {
        this.taskmgr = taskmgr;
        this.time = time;
    }

    public static TaskTime find(int taskmgr,int time) throws SQLException
    {
        TaskTime t = (TaskTime) c.get(taskmgr + ":" + time);
        if(t == null)
        {
            ArrayList al = find(" AND taskmgr=" + taskmgr + " AND time=" + time,0,1);
            t = al.size() < 1 ? new TaskTime(taskmgr,time) : (TaskTime) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT taskmgr,time,cpu,mem,received,sent,content FROM tasktime WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                TaskTime t = new TaskTime(rs.getInt(i++),db.getInt(i++));
                t.cpu = rs.getInt(i++);
                t.mem = rs.getInt(i++);
                t.received = rs.getInt(i++);
                t.sent = rs.getInt(i++);
                t.content = rs.getString(i++);
                c.put(t.taskmgr + ":" + t.time,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM tasktime WHERE 1=1" + sql);
    }

    public void set(DbAdapter db) throws SQLException
    {
        db.executeUpdate("INSERT INTO tasktime(taskmgr,time,cpu,mem,received,sent,content)VALUES(" + taskmgr + "," + time + "," + cpu + "," + mem + "," + received + "," + sent + "," + DbAdapter.cite(content) + ")");
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM tasktime WHERE taskmgr=" + taskmgr);
        c.remove(taskmgr);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE tasktime SET " + f + "=" + DbAdapter.cite(v) + " WHERE taskmgr=" + taskmgr);
        c.remove(taskmgr);
    }

    //
    public static TaskTime find(int taskmgr) throws SQLException
    {
        ArrayList al = find(" AND taskmgr=" + taskmgr + " ORDER BY time DESC",0,1);
        return al.size() < 1 ? new TaskTime(taskmgr,0) : (TaskTime) al.get(0);
    }

}
