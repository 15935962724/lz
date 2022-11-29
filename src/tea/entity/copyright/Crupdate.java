package tea.entity.copyright;

import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;
import java.util.*;

public class Crupdate extends Entity
{
    public static Cache _cache = new Cache(100);
    private int crupdate;
    private String community;
    private String scrbid;
    private String proving;
    private String applicant;
    private String name;
    private String shortname;
    private String ver;
    private String type;
    private String item;
    private String beforeitem;
    private String afteritem;
    private String time;
    private String path;

    public Crupdate(int crupdate) throws SQLException
    {
        this.crupdate = crupdate;
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,scrbid,proving,applicant,name,shortname,ver,type,item,beforeitem,afteritem,time,path FROM crupdate WHERE crupdate=" + crupdate);
            if(db.next())
            {
                community = db.getString(1);
                scrbid = db.getString(2);
                proving = db.getString(3);
                applicant = db.getString(4);
                name = db.getString(5);
                shortname = db.getString(6);
                ver = db.getString(7);
                type = db.getString(8);
                item = db.getString(9);
                beforeitem = db.getString(10);
                afteritem = db.getString(11);
                time = db.getString(12);
                path = db.getString(13);
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(String community,String scrbid,String proving,String applicant,String name,String shortname,String ver,String type,String item,String beforeitem,String afteritem,String time,String path) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO crupdate(community,scrbid,proving,applicant,name,shortname,ver,type,item,beforeitem,afteritem,time,path)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(scrbid) + "," + DbAdapter.cite(proving) + "," + DbAdapter.cite(applicant) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(shortname) + "," + DbAdapter.cite(ver) + "," + DbAdapter.cite(type) + "," + DbAdapter.cite(item) + "," + DbAdapter.cite(beforeitem) + "," + DbAdapter.cite(afteritem) + "," + DbAdapter.cite(time) + "," + DbAdapter.cite(path) + ")");
        } finally
        {
            db.close();
        }
    }

    public void set(String proving,String applicant,String name,String shortname,String ver,String type,String item,String beforeitem,String afteritem,String time,String path) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE crupdate SET proving=" + DbAdapter.cite(proving) + ",applicant=" + DbAdapter.cite(applicant) + ",name=" + DbAdapter.cite(name) + ",shortname=" + DbAdapter.cite(shortname) + ",ver=" + DbAdapter.cite(ver) + ",type=" + DbAdapter.cite(type) + ",item=" + DbAdapter.cite(item) + ",beforeitem=" + DbAdapter.cite(beforeitem) + ",afteritem=" + DbAdapter.cite(afteritem) + ",time=" + DbAdapter.cite(time) + ",path=" + DbAdapter.cite(path) + " WHERE crupdate=" + crupdate);
        } finally
        {
            db.close();
        }
        this.proving = proving;
        this.applicant = applicant;
        this.name = name;
        this.shortname = shortname;
        this.ver = ver;
        this.type = type;
        this.item = item;
        this.beforeitem = beforeitem;
        this.afteritem = afteritem;
        this.time = time;
        this.path = path;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM crupdate WHERE crupdate=" + crupdate);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(crupdate));
    }

    public int getCrupdate()
    {
        return crupdate;
    }

    public static Crupdate find(int crupdate) throws SQLException
    {
        Crupdate obj = (Crupdate) _cache.get(new Integer(crupdate));
        if(obj == null)
        {
            obj = new Crupdate(crupdate);
            _cache.put(new Integer(crupdate),obj);
        }
        return obj;
    }

    public static int find(String scrbid) throws SQLException
    {
        int crupdate = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT crupdate FROM crupdate WHERE scrbid=" + DbAdapter.cite(scrbid));
            if(db.next())
            {
                crupdate = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return crupdate;
    }

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(crupdate) FROM crupdate WHERE community=" + DbAdapter.cite(community) + sql);
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
            db.executeQuery("SELECT crupdate FROM crupdate WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
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

    public String getAfteritem()
    {
        return afteritem;
    }

    public String getApplicant()
    {
        return applicant;
    }

    public String getBeforeitem()
    {
        return beforeitem;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getItem()
    {
        return item;
    }

    public String getName()
    {
        return name;
    }

    public String getPath()
    {
        return path;
    }

    public String getProving()
    {
        return proving;
    }

    public String getScrbid()
    {
        return scrbid;
    }

    public String getShortname()
    {
        return shortname;
    }

    public String getTime()
    {
        return time;
    }

    public String getType()
    {
        return type;
    }

    public String getVer()
    {
        return ver;
    }
}
