package tea.entity.node;

import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;
import java.util.*;

public class ResumeSort
{
    private static Cache _cache = new Cache(100);
    private String member;
    private int resume;
    private int job;
    private int type; //1= 备选简历   2=有价值简历   3=不合格简历
    private boolean exists;

    public ResumeSort(String member, int resume, int job) throws SQLException
    {
        this.member = member;
        this.resume = resume;
        this.job = job;
        load();
    }

    public static ResumeSort find(String member, int resume, int job) throws SQLException
    {
        ResumeSort objResumeSort = (ResumeSort) _cache.get(member + ":" + resume + ":" + job);
        if (objResumeSort == null)
        {
            objResumeSort = new ResumeSort(member, resume, job);
            _cache.put(member + ":" + resume + ":" + job, objResumeSort);
        }
        return objResumeSort;
    }

    public static void create(String member, int resume, int job, int type) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO ResumeSort(member,resume,job,type)VALUES(" + DbAdapter.cite(member) + "," + resume + "," + job + "," + type + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(member + ":" + resume + ":" + job);
    }

    public void set(int type) throws SQLException
    {
        if (this.isExists())
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeUpdate("UPDATE ResumeSort SET type=" + type + " WHERE member=" + DbAdapter.cite(member) + " AND resume=" + resume + " AND job=" + job);
            } finally
            {
                db.close();
            }
            this.type = type;
        } else
        {
            create(member, resume, job, type);
        }
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT type FROM ResumeSort WHERE member=" + DbAdapter.cite(member) + " AND resume=" + resume + " AND job=" + job);
            if (db.next())
            {
                type = db.getInt(1);
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

    public static Enumeration findByMemberType(String member, int type) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT resume FROM ResumeSort WHERE member=" + DbAdapter.cite(member) + " AND type=" + type);
            while (db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static int count(String member, int type) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            return db.getInt("SELECT count(resume) FROM ResumeSort,Node,Resume WHERE Node.node=Resume.node AND Resume.node=ResumeSort.resume AND ResumeSort.member=" + DbAdapter.cite(member) + " AND ResumeSort.type=" + type);
        } finally
        {
            db.close();
        }
    }

    public static int count(String member, int type, int job) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            return db.getInt("SELECT count(resume) FROM ResumeSort,Node,Resume WHERE Node.node=Resume.node AND Resume.node=ResumeSort.resume AND ResumeSort.member=" + DbAdapter.cite(member) + " AND ResumeSort.type=" + type + " AND ResumeSort.job=" + job);
        } finally
        {
            db.close();
        }
    }


    public String getMember()
    {
        return member;
    }

    public int getResume()
    {
        return resume;
    }

    public int getType()
    {
        return type;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getJob()
    {
        return job;
    }
}
