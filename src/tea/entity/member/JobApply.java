package tea.entity.member;

import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class JobApply extends Entity
{
    private static Cache _cache = new Cache(100);
    private int resume;
    private int job;
    private Date time;
    private boolean exists;
    private int applytable;

    public static JobApply find(int resume, int job) throws SQLException
    {
        JobApply obj = (JobApply) _cache.get(resume + ":" + job);
        if (obj == null)
        {
            obj = new JobApply(resume, job);
            _cache.put(resume + ":" + job, obj);
        }
        return obj;
    }

    public JobApply(int resume, int job) throws SQLException
    {
        this.resume = resume;
        this.job = job;
        load();
    }

    public JobApply(int job, int resume, int applytable, Date time) throws SQLException
    {
        this.job = job;
        this.resume = resume;
        this.applytable = applytable;
        this.time = time;
    }

    public static void create(int resume, int job, int applytable) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO JobApply (resume,job,applytable,time) VALUES (" + resume + "," + job + "," + applytable + "," + db.cite(new Date()) + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(resume + ":" + job);
    }

    public boolean isExists()
    {
        return exists;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM JobApply WHERE resume=" + resume + " AND job=" + job);
        } finally
        {
            db.close();
        }
        _cache.remove(resume + ":" + job);
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT applytable,time FROM JobApply WHERE resume=" + resume + " AND job=" + job);
            if (db.next())
            {
                applytable = db.getInt(1);
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

    public static Enumeration findByResume(int resume) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT job FROM JobApply WHERE resume=" + resume);
            while (db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Enumeration findByJob(int job) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Vector vector = new Vector();
        try
        {
            db.executeQuery("SELECT resume FROM JobApply WHERE job=" + job);
            while (db.next())
            {
                vector.addElement(new Integer(db.getString(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static int countByMember(String member) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(node) FROM JobApply WHERE member=" + DbAdapter.cite(member));
            db.next();
            j = db.getInt(1);
        } finally
        {
            db.close();
        }
        return j;
    }

    public static int countByResume(int resume) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.getInt("SELECT COUNT(job) FROM JobApply WHERE resume=" + resume);
        } finally
        {
            db.close();
        }
        return j;
    }

    public static int countByJob(int job) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.getInt("SELECT COUNT(DISTINCT ja.resume) FROM Node n,Resume r,JobApply ja WHERE n.finished=1 AND n.node=r.node AND r.node=ja.resume AND ja.job=" + job);
        } finally
        {
            db.close();
        }
        return j;
    }

    public int getResume()
    {
        return resume;
    }

    public int getJob()
    {
        return job;
    }

    public int getApplyTable()
    {
        return applytable;
    }

    public String getTimeToString()
    {
        if (time == null)
        {
            return "";
        }
        return sdf2.format(time);
    }

    public Date getTime()
    {
        return time;
    }
}
