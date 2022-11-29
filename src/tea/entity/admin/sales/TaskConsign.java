package tea.entity.admin.sales;

import java.io.*;
import java.util.*;
import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class TaskConsign extends Entity
{
    private static Cache _cache = new Cache(100);
    private int task;
    private String assigner; // 任务接纳人
    private String consign; // 委托人的代办人
    private Date time; // 创建时间
    private boolean exists;

    public TaskConsign(int task,String assigner) throws SQLException
    {
        this.task = task;
        this.assigner = assigner;
        load();
    }

    public static TaskConsign find(int task,String assigner) throws SQLException
    {
        TaskConsign obj = (TaskConsign) _cache.get(task + ":" + assigner);
        if(obj == null)
        {
            obj = new TaskConsign(task,assigner);
            _cache.put(task + ":" + assigner,obj);
        }
        return obj;
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT consign,time FROM TaskConsign WHERE task=" + task + " AND assigner=" + DbAdapter.cite(assigner));
            if(db.next())
            {
                consign = db.getString(1);
                time = db.getDate(2);
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(int task,String assigner,String consign) throws SQLException
    {
        Date time = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO TaskConsign (task,assigner,consign,time)VALUES (" + task + "," + DbAdapter.cite(assigner) + "," + DbAdapter.cite(consign) + "," + DbAdapter.cite(time) + ")");
        } finally
        {
            db.close();
        }
    }

    public static Enumeration findByCommunity(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT tc.task FROM TaskConsign tc INNER JOIN Task t ON tc.task=t.id WHERE t.community=" + DbAdapter.cite(community) + sql,pos,size);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Enumeration findByCommunity(String community,String sql) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT tc.assigner FROM TaskConsign tc INNER JOIN Task t ON tc.task=t.id WHERE t.community=" + DbAdapter.cite(community) + sql);
            while(db.next())
            {
                v.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            count = db.getInt("SELECT COUNT(*) FROM TaskConsign tc INNER JOIN Task t ON tc.task=t.id WHERE t.community=" + DbAdapter.cite(community) + sql);
        } finally
        {
            db.close();
        }
        return count;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM TaskConsign WHERE task=" + task + " AND assigner=" + DbAdapter.cite(assigner));
        } finally
        {
            db.close();
        }
        _cache.remove(task + ":" + assigner);
        exists = false;
    }

    public String getAssigner()
    {
        return assigner;
    }

    public String getConsign()
    {
        return consign;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getTask()
    {
        return task;
    }

    public Date getTime()
    {
        return time;
    }

    public String getTimeToString()
    {
        return sdf2.format(time);
    }
}
