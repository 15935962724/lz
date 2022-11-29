package tea.entity.copyright;

import tea.db.DbAdapter;
import tea.entity.*;

import java.util.*;
import java.sql.SQLException;

//质押公告信息
public class Crimpawn extends Entity
{
    public static Cache _cache = new Cache(100);
    private int crimpawn;
    private String community;
    private String code;
    private String scrbid;
    private String name;
    private String shortname;
    private String mortgagor; // 出质人
    private String pawnee; // 质权人
    private String ver;
    private String time;
    private String cancel;
    private String states;
    private String path;

    public Crimpawn(int crimpawn) throws SQLException
    {
        this.crimpawn = crimpawn;
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,code,scrbid,name,shortname,mortgagor,pawnee,ver,time,cancel,states,path FROM crimpawn WHERE crimpawn=" + crimpawn);
            if(db.next())
            {
                community = db.getString(1);
                code = db.getString(2);
                scrbid = db.getString(3);
                name = db.getString(4);
                shortname = db.getString(5);
                mortgagor = db.getString(6);
                pawnee = db.getString(7);
                ver = db.getString(8);
                time = db.getString(9);
                cancel = db.getString(10);
                states = db.getString(11);
                path = db.getString(12);
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(String community,String code,String scrbid,String name,String shortname,String mortgagor,String pawnee,String ver,String time,String cancel,String states,String path) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO crimpawn(community,code,scrbid,name,shortname,mortgagor,pawnee,ver,time,cancel,states,path)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(code) + "," + DbAdapter.cite(scrbid) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(shortname) + "," + DbAdapter.cite(mortgagor) + "," + DbAdapter.cite(pawnee) + "," + DbAdapter.cite(ver) + "," + DbAdapter.cite(time) + "," + DbAdapter.cite(cancel) + "," + DbAdapter.cite(states) + "," + DbAdapter.cite(path) + ")");
        } finally
        {
            db.close();
        }
    }

    public void set(String code,String name,String shortname,String mortgagor,String pawnee,String ver,String time,String cancel,String states,String path) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE crimpawn SET code=" + DbAdapter.cite(code) + ",scrbid=" + DbAdapter.cite(scrbid) + ",name=" + DbAdapter.cite(name) + ",shortname=" + DbAdapter.cite(shortname) + ",mortgagor=" + DbAdapter.cite(mortgagor) + ",pawnee=" + DbAdapter.cite(pawnee) + ",ver=" + DbAdapter.cite(ver) + ",time=" + DbAdapter.cite(time) + ",cancel=" + DbAdapter.cite(cancel) + ",states=" + DbAdapter.cite(states) + ",path=" + DbAdapter.cite(path) + " WHERE crimpawn=" + crimpawn);
        } finally
        {
            db.close();
        }
        this.code = code;
        this.name = name;
        this.shortname = shortname;
        this.mortgagor = mortgagor;
        this.pawnee = pawnee;
        this.ver = ver;
        this.time = time;
        this.cancel = cancel;
        this.states = states;
        this.path = path;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM crimpawn WHERE crimpawn=" + crimpawn);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(crimpawn));
    }

    public int getCrimpawn()
    {
        return crimpawn;
    }

    public static Crimpawn find(int crimpawn) throws SQLException
    {
        Crimpawn obj = (Crimpawn) _cache.get(new Integer(crimpawn));
        if(obj == null)
        {
            obj = new Crimpawn(crimpawn);
            _cache.put(new Integer(crimpawn),obj);
        }
        return obj;
    }

    public static int find(String scrbid) throws SQLException
    {
        int crimpawn = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT crimpawn FROM crimpawn WHERE scrbid=" + DbAdapter.cite(scrbid));
            if(db.next())
            {
                crimpawn = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return crimpawn;
    }

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(crimpawn) FROM crimpawn WHERE community=" + DbAdapter.cite(community) + sql);
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
            db.executeQuery("SELECT crimpawn FROM crimpawn WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
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

    public String getCancel()
    {
        return cancel;
    }

    public String getCode()
    {
        return code;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getMortgagor()
    {
        return mortgagor;
    }

    public String getName()
    {
        return name;
    }

    public String getPath()
    {
        return path;
    }

    public String getPawnee()
    {
        return pawnee;
    }

    public String getScrbid()
    {
        return scrbid;
    }

    public String getShortname()
    {
        return shortname;
    }

    public String getStates()
    {
        return states;
    }

    public String getTime()
    {
        return time;
    }

    public String getVer()
    {
        return ver;
    }
}
