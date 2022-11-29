package tea.entity.copyright;

import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;
import java.util.*;

//转让合同公告信息
public class Crtransfercontract extends Entity
{
    public static Cache _cache = new Cache(100);
    private int crtransfercontract;
    private String community;
    private String code;
    private String scrbid;
    private String name;
    private String font1;
    private String author;
    private String font2;
    private String droit;
    private String assignor;
    private String font3;
    private String alienee;
    private String font4;
    private String time;
    private String path;

    public Crtransfercontract(int crtransfercontract) throws SQLException
    {
        this.crtransfercontract = crtransfercontract;
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,code,scrbid,name,font1,author,font2,droit,assignor,font3,alienee,font4,time,path FROM crtransfercontract WHERE crtransfercontract=" + crtransfercontract);
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
                assignor = db.getString(9);
                font3 = db.getString(10);
                alienee = db.getString(11);
                font4 = db.getString(12);
                time = db.getString(13);
                path = db.getString(14);
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(String community,String code,String scrbid,String name,String font1,String author,String font2,String droit,String assignor,String font3,String alienee,
                              String font4,String time,String path) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO crtransfercontract(community,code,scrbid,name,font1,author,font2,droit,assignor,font3,alienee,font4,time,path)VALUES(" + DbAdapter.cite(community) + ","
                             + DbAdapter.cite(code) + "," + DbAdapter.cite(scrbid) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(font1) + "," + DbAdapter.cite(author) + "," + DbAdapter.cite(font2) + "," + DbAdapter.cite(droit) + ","
                             + DbAdapter.cite(assignor) + "," + DbAdapter.cite(font3) + "," + DbAdapter.cite(alienee) + "," + DbAdapter.cite(font4) + "," + DbAdapter.cite(time) + "," + DbAdapter.cite(path) + ")");
        } finally
        {
            db.close();
        }
    }

    public void set(String code,String name,String font1,String author,String font2,String droit,String assignor,String font3,String alienee,String font4,String time,String path) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE crtransfercontract SET code=" + DbAdapter.cite(code) + ",name=" + DbAdapter.cite(name) + ",font1=" + DbAdapter.cite(font1) + ",author=" + DbAdapter.cite(author) + ",font2=" + DbAdapter.cite(font2)
                             + ",droit=" + DbAdapter.cite(droit) + ",assignor=" + DbAdapter.cite(assignor) + ",font3=" + DbAdapter.cite(font3) + ",alienee=" + DbAdapter.cite(alienee) + ",alienee=" + DbAdapter.cite(alienee) + ",time="
                             + DbAdapter.cite(time) + ",path=" + DbAdapter.cite(path) + " WHERE crtransfercontract=" + crtransfercontract);
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
        this.assignor = assignor;
        this.font3 = font3;
        this.alienee = alienee;
        this.font4 = font4;
        this.time = time;
        this.path = path;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM crtransfercontract WHERE crtransfercontract=" + crtransfercontract);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(crtransfercontract));
    }

    public int getCrtransfercontract()
    {
        return crtransfercontract;
    }

    public static Crtransfercontract find(int crtransfercontract) throws SQLException
    {
        Crtransfercontract obj = (Crtransfercontract) _cache.get(new Integer(crtransfercontract));
        if(obj == null)
        {
            obj = new Crtransfercontract(crtransfercontract);
            _cache.put(new Integer(crtransfercontract),obj);
        }
        return obj;
    }

    public static int find(String scrbid) throws SQLException
    {
        int crtransfercontract = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT crtransfercontract FROM crtransfercontract WHERE scrbid=" + DbAdapter.cite(scrbid));
            if(db.next())
            {
                crtransfercontract = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return crtransfercontract;
    }

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(crtransfercontract) FROM crtransfercontract WHERE community=" + DbAdapter.cite(community) + sql);
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
            db.executeQuery("SELECT crtransfercontract FROM crtransfercontract WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
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

    public String getAlienee()
    {
        return alienee;
    }

    public String getAssignor()
    {
        return assignor;
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

    public String getTime()
    {
        return time;
    }
}
