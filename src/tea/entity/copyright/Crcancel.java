package tea.entity.copyright;

import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;
import java.util.*;

public class Crcancel extends Entity
{
    public static Cache _cache = new Cache(100);
    private int crcancel;
    private String community;
    private String code;
    private String scrbid;
    private String author;
    private String name;
    private String shortname;
    private String ver;
    private String reason;
    private Date canceldate;
    private String path;

    public Crcancel(int crcancel) throws SQLException
    {
        this.crcancel = crcancel;
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,code,scrbid,author,name,shortname,ver,reason,canceldate,path FROM crcancel WHERE crcancel=" + crcancel);
            if(db.next())
            {
                community = db.getString(1);
                code = db.getString(2);
                scrbid = db.getString(3);
                author = db.getString(4);
                name = db.getString(5);
                shortname = db.getString(6);
                ver = db.getString(7);
                reason = db.getString(8);
                canceldate = db.getDate(9);
                path = db.getString(10);
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(String community,String code,String scrbid,String author,String name,String shortname,String ver,String reason,Date canceldate,String path) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO crcancel(community,code,scrbid,author,name,shortname,ver,reason,canceldate,path)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(code) + "," + DbAdapter.cite(scrbid)
                             + "," + DbAdapter.cite(author) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(shortname) + "," + DbAdapter.cite(ver) + "," + DbAdapter.cite(reason) + "," + DbAdapter.cite(canceldate) + "," + DbAdapter.cite(path) + ")");
        } finally
        {
            db.close();
        }
        // _cache.remove(new Integer(crcancel));
    }

    public void set(String code,String author,String name,String shortname,String ver,String reason,Date canceldate,String path) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE crcancel SET code=" + DbAdapter.cite(code) + ",author=" + DbAdapter.cite(author) + ",name=" + DbAdapter.cite(name) + ",shortname=" + DbAdapter.cite(shortname) + ",ver=" + DbAdapter.cite(ver)
                             + ",reason=" + DbAdapter.cite(reason) + ",canceldate=" + DbAdapter.cite(canceldate) + ",path=" + DbAdapter.cite(path) + " WHERE crcancel=" + crcancel);
        } finally
        {
            db.close();
        }
        this.code = code;
        this.author = author;
        this.name = name;
        this.shortname = shortname;
        this.ver = ver;
        this.reason = reason;
        this.canceldate = canceldate;
        this.path = path;
    }

    public String getAuthor()
    {
        return author;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM crcancel WHERE crcancel=" + crcancel);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(crcancel));
    }

    public String getScrbid()
    {
        return scrbid;
    }

    public Date getCanceldate()
    {
        return canceldate;
    }

    public String getCanceldateToString()
    {
        if(canceldate == null)
        {
            return "";
        }
        return sdf.format(canceldate);
    }

    public String getReason()
    {
        return reason;
    }

    public int getCrcancel()
    {
        return crcancel;
    }

    public String getCode()
    {
        return code;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getName()
    {
        return name;
    }

    public String getPath()
    {
        return path;
    }

    public String getShortname()
    {
        return shortname;
    }

    public String getVer()
    {
        return ver;
    }

    public static Crcancel find(int crcancel) throws SQLException
    {
        Crcancel obj = (Crcancel) _cache.get(new Integer(crcancel));
        if(obj == null)
        {
            obj = new Crcancel(crcancel);
            _cache.put(new Integer(crcancel),obj);
        }
        return obj;
    }

    public static int find(String scrbid) throws SQLException
    {
        int crcancel = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT crcancel FROM crcancel WHERE scrbid=" + DbAdapter.cite(scrbid));
            if(db.next())
            {
                crcancel = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return crcancel;
    }

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(crcancel) FROM crcancel WHERE community=" + DbAdapter.cite(community) + sql);
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
            db.executeQuery("SELECT crcancel FROM crcancel WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
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
}
