package tea.entity.copyright;

import tea.db.DbAdapter;
import tea.entity.*;
import java.util.*;
import java.sql.SQLException;

public class Crallow extends Entity
{
    public static Cache _cache = new Cache(100);
    private int crallow;
    private String community;
    private String code;
    private String scrbid;
    private String name;
    private String font1;
    private String author;
    private String font2;
    private String droit;
    private String area;
    private String font3;
    private String starttime;
    private String endtime;
    private String host;
    private String font4;
    private String username;
    private String font5;
    private String time;
    private String path;

    public Crallow(int crallow) throws SQLException
    {
        this.crallow = crallow;
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,code,scrbid,name,font1,author,font2,droit,area,font3,starttime,endtime,host,font4,username,font5,time,path FROM crallow WHERE crallow=" + crallow);
            if(db.next())
            {
                community = db.getString(1);
                code = db.getString(2);
                scrbid = db.getString(3);
                name = db.getString(4);
                font1 = db.getString(5);
                author = db.getString(6);
                font2 = db.getString(7);
                droit = db.getString(8);
                area = db.getString(9);
                font3 = db.getString(10);
                starttime = db.getString(11);
                endtime = db.getString(12);
                host = db.getString(13);
                font4 = db.getString(14);
                username = db.getString(15);
                font5 = db.getString(16);
                time = db.getString(17);
                path = db.getString(18);
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(String community,String code,String scrbid,String name,String font1,String author,String font2,String droit,String area,String font3,String starttime,
                              String endtime,String host,String font4,String username,String font5,String time,String path) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO crallow(community,code,scrbid,name,font1,author,font2,droit,area,font3,starttime,endtime,host,font4,username,font5,time,path)VALUES(" + DbAdapter.cite(community)
                             + "," + DbAdapter.cite(code) + "," + DbAdapter.cite(scrbid) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(font1) + "," + DbAdapter.cite(author) + "," + DbAdapter.cite(font2) + "," + DbAdapter.cite(droit) + ","
                             + DbAdapter.cite(area) + "," + DbAdapter.cite(font3) + "," + DbAdapter.cite(starttime) + "," + DbAdapter.cite(endtime) + "," + DbAdapter.cite(host) + "," + DbAdapter.cite(font4) + "," + DbAdapter.cite(username) + ","
                             + DbAdapter.cite(font5) + "," + DbAdapter.cite(time) + "," + DbAdapter.cite(path) + ")");
        } finally
        {
            db.close();
        }
    }

    public void set(String code,String name,String font1,String author,String font2,String droit,String area,String font3,String starttime,String endtime,String host,String font4,
                    String username,String font5,String time,String path) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE crallow SET code=" + DbAdapter.cite(code) + ",name=" + DbAdapter.cite(name) + ",font1=" + DbAdapter.cite(font1) + ",author=" + DbAdapter.cite(author) + ",font2=" + DbAdapter.cite(font2) + ",droit="
                             + DbAdapter.cite(droit) + ",area=" + DbAdapter.cite(area) + ",font3=" + DbAdapter.cite(font3) + ",starttime=" + DbAdapter.cite(starttime) + ",endtime=" + DbAdapter.cite(endtime) + ",host=" + DbAdapter.cite(host)
                             + ",font4=" + DbAdapter.cite(font4) + ",username=" + DbAdapter.cite(username) + ",font5=" + DbAdapter.cite(font5) + ",time=" + DbAdapter.cite(time) + ",path=" + DbAdapter.cite(path) + " WHERE crallow=" + crallow);
        } finally
        {
            db.close();
        }
        this.code = code;
        this.name = name;
        this.font1 = font1;
        this.author = author;
        this.font2 = font2;
        this.droit = droit;
        this.area = area;
        this.font3 = font3;
        this.starttime = starttime;
        this.endtime = endtime;
        this.host = host;
        this.font4 = font4;
        this.username = username;
        this.font5 = font5;
        this.time = time;
        this.path = path;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM crallow WHERE crallow=" + crallow);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(crallow));
    }

    public int getCrallow()
    {
        return crallow;
    }

    public static Crallow find(int crallow) throws SQLException
    {
        Crallow obj = (Crallow) _cache.get(new Integer(crallow));
        if(obj == null)
        {
            obj = new Crallow(crallow);
            _cache.put(new Integer(crallow),obj);
        }
        return obj;
    }

    public static int find(String scrbid) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT crallow FROM crallow WHERE scrbid=" + DbAdapter.cite(scrbid));
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

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(crallow) FROM crallow WHERE community=" + DbAdapter.cite(community) + sql);
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
            db.executeQuery("SELECT crallow FROM crallow WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
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

    public String getArea()
    {
        return area;
    }

    public String getAuthor()
    {
        return author;
    }

    public String getCode()
    {
        return code;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getDroit()
    {
        return droit;
    }

    public String getEndtime()
    {
        return endtime;
    }

    public String getFont1()
    {
        return font1;
    }

    public String getFont2()
    {
        return font2;
    }

    public String getFont3()
    {
        return font3;
    }

    public String getFont4()
    {
        return font4;
    }

    public String getFont5()
    {
        return font5;
    }

    public String getHost()
    {
        return host;
    }

    public String getName()
    {
        return name;
    }

    public String getPath()
    {
        return path;
    }

    public String getScrbid()
    {
        return scrbid;
    }

    public String getStarttime()
    {
        return starttime;
    }

    public String getTime()
    {
        return time;
    }

    public String getUsername()
    {
        return username;
    }
}
