package tea.entity.site;

import java.sql.*;
import java.util.*;
import tea.db.*;
import tea.entity.*;

public class DNSCity extends Entity
{
    private static Cache _cache = new Cache(100);
    private int dnscity;
    private String domainname;
    private int city;
    private String url;
    private boolean exists;
    public DNSCity(int dnscity,String domainname,int city,String url) throws SQLException
    {
        this.dnscity = dnscity;
        this.domainname = domainname;
        this.city = city;
        this.url = url;
        this.exists = true;
    }

    public DNSCity(int dnscity) throws SQLException
    {
        this.dnscity = dnscity;
        load();
    }

    public static DNSCity find(int dnscity) throws SQLException
    {
        DNSCity obj = (DNSCity) _cache.get(new Integer(dnscity));
        if(obj == null)
        {
            obj = new DNSCity(dnscity);
            _cache.put(new Integer(dnscity),obj);
        }
        return obj;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("DELETE FROM DNSCity WHERE dnscity=" + dnscity);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(dnscity));
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT domainname,city,url FROM DNSCity WHERE dnscity=" + dnscity);
            if(db.next())
            {
                domainname = db.getString(1);
                city = db.getInt(2);
                url = db.getString(3);
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

    public static int count(String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM DNSCity WHERE 1=1" + sql);
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

    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT dnscity,domainname,city,url FROM DNSCity WHERE 1=1" + sql);
            while(db.next())
            {
                int dnscity = db.getInt(1);
                String domainname = db.getString(2);
                int city = db.getInt(3);
                String url = db.getString(4);
                v.addElement(new DNSCity(dnscity,domainname,city,url));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Enumeration findByDomainname(String domainname) throws SQLException
    {
        return find(" AND domainname=" + DbAdapter.cite(domainname),0,200);
    }

    public void set(String domainname,int city,String url) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            int j = db.executeUpdate("UPDATE DNSCity SET domainname=" + DbAdapter.cite(domainname) + ",city=" + city + ",url=" + DbAdapter.cite(url) + " WHERE dnscity=" + dnscity);
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO DNSCity(domainname,city,url)VALUES(" + DbAdapter.cite(domainname) + "," + city + "," + DbAdapter.cite(url) + ")");
            }
        } finally
        {
            db.close();
        }
        this.domainname = domainname;
        this.city = city;
        this.url = url;
        this.exists = true;
        DNS.find(domainname).cityExists = true;
    }

    public String getDomainname()
    {
        return domainname;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getUrl()
    {
        return url;
    }

    public int getCity()
    {
        return city;
    }

    public int getDNSCity()
    {
        return dnscity;
    }

}
