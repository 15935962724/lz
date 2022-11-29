package tea.entity.site;

import java.sql.*;
import java.util.*;
import tea.db.*;
import tea.entity.*;

public class Example extends Entity
{
    private static Cache _cache = new Cache(100);
    private int example;
    private String exid;
    private String subject;
    private String picture;
    private boolean exists;
    public Example(int example,String exid,String subject,String picture) throws SQLException
    {
        this.example = example;
        this.exid = exid;
        this.subject = subject;
        this.picture = picture;
        this.exists = true;
    }

    public Example(int example)
    {
        this.example = example;
    }

    public static Example find(int example) throws SQLException
    {
        Example t = (Example) _cache.get(example);
        if(t == null)
        {
            ArrayList al = find(" AND example=" + example,0,1);
            t = al.size() < 1 ? new Example(example) : (Example) al.get(0);
        }
        return t;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("DELETE FROM Example WHERE example=" + example);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(example));
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT exid,subject,picture FROM Example WHERE example=" + example);
            if(db.next())
            {
                exid = db.getString(1);
                subject = db.getString(2);
                picture = db.getString(3);
                exists = true;
            } else
            {
                exid = "/";
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public static int count(String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM Example WHERE 1=1" + sql);
            if(db.next())
            {
                j = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return j;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT example,exid,subject,picture FROM Example WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                Example t = new Example(db.getInt(1));
                t.exid = db.getString(2);
                t.subject = db.getString(3);
                t.picture = db.getString(4);
                al.add(t);
            }
        } finally
        {
            db.close();
        }
        return al;
    }

    public static void create(String exid,String subject,String picture) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("INSERT INTO Example(exid,subject,picture)VALUES(" + DbAdapter.cite(exid) + "," + DbAdapter.cite(subject) + "," + DbAdapter.cite(picture) + ")");
        } finally
        {
            db.close();
        }
    }

    public void set(String subject,String picture) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        sb.append("UPDATE Example SET subject=").append(DbAdapter.cite(subject));
        if(picture != null)
        {
            sb.append(",picture=").append(DbAdapter.cite(picture));
            this.picture = picture;
        }
        sb.append(" WHERE example=").append(example);
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate(sb.toString());
        } finally
        {
            db.close();
        }
        this.subject = subject;
    }

    public void setExid(String exid) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("UPDATE Example SET exid=" + DbAdapter.cite(exid) + " WHERE example=" + example);
        } finally
        {
            db.close();
        }
        this.exid = exid;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getSubject()
    {
        return subject;
    }

    public String getPicture()
    {
        return picture;
    }

    public String getExid()
    {
        return exid;
    }

    public int getExample()
    {
        return example;
    }
}
