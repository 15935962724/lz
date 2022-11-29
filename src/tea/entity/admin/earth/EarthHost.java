package tea.entity.admin.earth;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class EarthHost implements Serializable
{
    public static Cache _cache = new Cache(100);
    private String host;
    private String ip;
    private int sequence;
    private String name;
    private String context;
    private String realpath;
	private int counts;
	private Date times;//刷新时间
    private boolean exists;

    public EarthHost(String host) throws SQLException
    {
        this.host = host;
        load();
    }

    public static EarthHost find(String host) throws SQLException
    {
        EarthHost obj = (EarthHost) _cache.get(host);
        if(obj == null)
        {
            obj = new EarthHost(host);
            _cache.put(host,obj);
        }
        return obj;
    }

    public void set(String ip,String name,String context,String realpath) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE earthhost SET ip=" + DbAdapter.cite(ip) + ",name=" + DbAdapter.cite(name) + ",context=" + DbAdapter.cite(context) + ",realpath=" + DbAdapter.cite(realpath) + " WHERE host=" + DbAdapter.cite(host));
        } finally
        {
            db.close();
        }
        this.ip = ip;
        this.name = name;
        this.context = context;
        this.realpath = realpath;
    }
	public void setTimes(Date times)throws SQLException
	{
		DbAdapter db = new DbAdapter();
	   try
	   {
		   db.executeUpdate("UPDATE earthhost SET times = "+db.cite(times)+" WHERE host=" + DbAdapter.cite(host));
	   } finally
	   {
		   db.close();
	   }
	   this.times = times;
	}
	public void set(int counts)throws SQLException
	{
		DbAdapter db = new DbAdapter();
	   try
	   {
		   db.executeUpdate("UPDATE earthhost SET counts="+counts+" WHERE host=" + DbAdapter.cite(host));
	   } finally
	   {
		   db.close();
	   }
	   this.counts=counts;
	}

    public void setSequence(int sequence) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE earthhost SET sequence=" + sequence + " WHERE host=" + DbAdapter.cite(host));
        } finally
        {
            db.close();
        }
        this.sequence = sequence;
    }

    public static void setIp(String oldip,String newip) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE earthhost SET ip=" + DbAdapter.cite(newip) + " WHERE ip=" + DbAdapter.cite(oldip));
        } finally
        {
            db.close();
        }
        _cache.clear();
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT ip,sequence,context,realpath,name,counts,times FROM earthhost WHERE host=" + DbAdapter.cite(host));
            if(db.next())
            {
                ip = db.getString(1);
                sequence = db.getInt(2);
                context = db.getString(3);
                realpath = db.getString(4);
                name = db.getString(5);
				counts=db.getInt(6);
				times=db.getDate(7);
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
            db.executeQuery("SELECT host FROM earthhost WHERE 1=1" + sql + " ORDER BY sequence");
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

    public static Enumeration findByIp(String ip) throws SQLException
    {
        return find(" AND ip=" + DbAdapter.cite(ip),0,Integer.MAX_VALUE);
    }

    public static void create(String host,String ip) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO earthhost(host,ip)VALUES(" + DbAdapter.cite(host) + "," + DbAdapter.cite(ip) + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(host);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM earthhost WHERE host=" + DbAdapter.cite(host));
        } finally
        {
            db.close();
        }
        _cache.remove(host);
    }

    private static void deleteByIp(String ip) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM EarthHost WHERE ip=" + DbAdapter.cite(ip));
        } finally
        {
            db.close();
        }
    }


    public boolean isExists()
    {
        return exists;
    }


    public String getName()
    {
        return name;
    }

    public String getIp()
    {
        return ip;
    }


    public int getSequence()
    {
        return sequence;
    }

    public String getRealPath()
    {
        return realpath;
    }

    public String getHost()
    {
        return host;
    }

    public String getContext()
    {
        return context;
    }
	public int getCounts()
	{
	    return counts;
	}
	public Date getTimes()
	{
		return times;
	}
	public String getTimesToString()
	{
		if(times == null)
			return "";
		return 	tea.entity.Entity.sdf.format(times);
	}
}
