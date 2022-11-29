package tea.entity.copyright;

import tea.db.DbAdapter;
import tea.entity.*;

import java.util.*;
import java.sql.SQLException;

public class Crcourtclose extends Entity
{
    public static Cache _cache = new Cache(100);
    private int crcourtclose;
    private String community;
    private String scrbid;
    private String court;
    private String author;
    private String name;
    private String closetime; // 查封日期
    private String year;
    private String opentime;
    private String canceltime;
    private String path;

    public Crcourtclose(int crcourtclose) throws SQLException
    {
        this.crcourtclose = crcourtclose;
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,scrbid,court,author,name,closetime,year,opentime,canceltime,path FROM crcourtclose WHERE crcourtclose=" + crcourtclose);
            if(db.next())
            {
                community = db.getString(1);
                scrbid = db.getString(2);
                court = db.getString(3);
                author = db.getString(4);
                name = db.getString(5);
                closetime = db.getString(6);
                year = db.getString(7);
                opentime = db.getString(8);
                canceltime = db.getString(9);
                path = db.getString(10);
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(String community,String scrbid,String court,String author,String name,String closetime,String year,String opentime,String canceltime,String path) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO crcourtclose(community,scrbid,court,author,name,closetime,year,opentime,canceltime,path)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(scrbid) + "," + DbAdapter.cite(court) + "," + DbAdapter.cite(author) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(closetime) + "," + DbAdapter.cite(year) + "," + DbAdapter.cite(opentime) + "," + DbAdapter.cite(canceltime) + "," + DbAdapter.cite(path) + ")");
        } finally
        {
            db.close();
        }
    }

    public void set(String court,String author,String name,String closetime,String year,String opentime,String canceltime,String path) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE crcourtclose SET court=" + DbAdapter.cite(court) + ",author=" + DbAdapter.cite(author) + ",name=" + DbAdapter.cite(name) + ",closetime=" + DbAdapter.cite(closetime) + ",year=" + DbAdapter.cite(year) + ",opentime=" + DbAdapter.cite(opentime) + ",canceltime=" + DbAdapter.cite(canceltime) + ",path=" + DbAdapter.cite(path) + " WHERE crcourtclose=" + crcourtclose);
        } finally
        {
            db.close();
        }
        this.court = court;
        this.author = author;
        this.name = name;
        this.closetime = closetime;
        this.year = year;
        this.opentime = opentime;
        this.canceltime = canceltime;
        this.path = path;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM crcourtclose WHERE crcourtclose=" + crcourtclose);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(crcourtclose));
    }

    public int getCrcourtclose()
    {
        return crcourtclose;
    }

    public static Crcourtclose find(int crcourtclose) throws SQLException
    {
        Crcourtclose obj = (Crcourtclose) _cache.get(new Integer(crcourtclose));
        if(obj == null)
        {
            obj = new Crcourtclose(crcourtclose);
            _cache.put(new Integer(crcourtclose),obj);
        }
        return obj;
    }

    public static int find(String scrbid) throws SQLException
    {
        int crcourtclose = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT crcourtclose FROM crcourtclose WHERE scrbid=" + DbAdapter.cite(scrbid));
            if(db.next())
            {
                crcourtclose = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return crcourtclose;
    }

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(crcourtclose) FROM crcourtclose WHERE community=" + DbAdapter.cite(community) + sql);
            if(db.next())
            {
                count = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return count;
    }

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT crcourtclose FROM crcourtclose WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
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

    public String getAuthor()
    {
        return author;
    }

    public String getCanceltime()
    {
        return canceltime;
    }

    public String getClosetime()
    {
        return closetime;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getCourt()
    {
        return court;
    }

    public String getName()
    {
        return name;
    }

    public String getOpentime()
    {
        return opentime;
    }

    public String getPath()
    {
        return path;
    }

    public String getScrbid()
    {
        return scrbid;
    }

    public String getYear()
    {
        return year;
    }

}
