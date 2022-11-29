package tea.entity.admin.earth;

import java.io.*;
import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;

public class EarthIp implements Serializable
{
    public static Cache _cache = new Cache(100);
    private boolean exists;
    private String ip;
    private String url;
    private String name;
    private int port;
    private int sequence;
    private int ncount;
    private int node;

    public EarthIp(String ip) throws SQLException
    {
        this.ip = ip;
        load();
    }

    public static EarthIp find(String ip) throws SQLException
    {
        EarthIp obj = (EarthIp) _cache.get(ip);
        if(obj == null)
        {
            obj = new EarthIp(ip);
            _cache.put(ip,obj);
        }
        return obj;
    }

    public void set(String name,int port,int node) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE earthip SET name=" + DbAdapter.cite(name) + ",port=" + port + ",node = " + node + " WHERE ip=" + DbAdapter.cite(ip));
        } finally
        {
            db.close();
        }
        this.name = name;
        this.port = port;
        this.node = node;
    }

    public void setSequence(int sequence) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE earthip SET sequence=" + sequence + " WHERE ip=" + DbAdapter.cite(ip));
        } finally
        {
            db.close();
        }
        this.sequence = sequence;
    }

    public void setIp(String newip) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE earthip SET ip=" + DbAdapter.cite(newip) + " WHERE ip=" + DbAdapter.cite(ip));
        } finally
        {
            db.close();
        }
        EarthHost.setIp(ip,newip);
        _cache.remove(ip);
        _cache.put(newip,this);
        this.ip = newip;
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT name,port,sequence,url,ncount,node FROM earthip WHERE ip=" + DbAdapter.cite(ip));
            if(db.next())
            {
                name = db.getString(1);
                port = db.getInt(2);
                sequence = db.getInt(3);
                url = db.getString(4);
                ncount = db.getInt(5);
                node = db.getInt(6);
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

    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT ip FROM earthip WHERE 1=1" + sql + " ORDER BY sequence");
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

    public static void create(String ip,String name,int port,int sequence,int node) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO earthip(ip,name,port,sequence,node)VALUES(" + DbAdapter.cite(ip) + "," + DbAdapter.cite(name) + "," + port + "," + sequence + "," + node + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(ip);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM earthip WHERE ip=" + DbAdapter.cite(ip));
        } finally
        {
            db.close();
        }
        _cache.remove(ip);
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getUrl()
    {
        return url;
    }

    public String getName()
    {
        return name;
    }

    public String getIp()
    {
        return ip;
    }

    public int getPort()
    {
        return port;
    }

    public int getSequence()
    {
        return sequence;
    }

    public int getNcount()
    {
        return ncount;
    }

    public int getNode()
    {
        return node;
    }
}
