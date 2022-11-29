package tea.entity.util;

import java.io.*;
import java.sql.*;
import tea.db.*;
import tea.entity.*;

public class Keywords implements Serializable
{
    public static Cache _cache = new Cache(100);
    private boolean exists;
    private String keywords;
    private int click = 1;
    private String community;
    private int count;
    private String ip;
    public Keywords(String community,String keywords) throws SQLException
    {
        this.keywords = keywords;
        this.community = community;
        load();
    }

    public static Keywords find(String community,String keywords) throws SQLException
    {
        Keywords obj = (Keywords) _cache.get(community + ":" + keywords);
        if(obj == null)
        {
            obj = new Keywords(community,keywords);
            _cache.put(community + ":" + keywords,obj);
        }
        return obj;
    }

    public void set(int count,String ip) throws SQLException
    {
        if(ip.equals(this.ip))
            return;
        this.count = count;
        ++click;
        if(isExists())
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeUpdate(0,"UPDATE Keywords SET click=" + (click) + ",count=" + count + ",ip=" + DbAdapter.cite(ip) + " WHERE community=" + DbAdapter.cite(community) + " AND keywords=" + DbAdapter.cite(keywords));
            } finally
            {
                db.close();
            }
        } else
        {
            create(community,keywords,count,ip);
            exists = true;
        }
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT click,count,ip FROM Keywords WHERE community=" + DbAdapter.cite(community) + " AND keywords=" + DbAdapter.cite(keywords));
            if(db.next())
            {
                click = db.getInt(1);
                count = db.getInt(2);
                ip = db.getString(3);
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

    public static java.util.Enumeration findByKeywords(String community,String keywords,int pagesize) throws SQLException,SQLException
    {
        StringBuilder contains = new StringBuilder();
        String k[] = keywords.split(" ");
        contains.append("keywords LIKE " + DbAdapter.cite("%" + k[0] + "%"));
        for(int index = 1;index < k.length;index++)
        {
            contains.append(" OR keywords LIKE " + DbAdapter.cite("%" + k[index] + "%"));
        }
        java.util.Vector vector = new java.util.Vector();
        String where;
        if(pagesize == 0)
        {
            where = "";
        } else
        {
            where = " AND keywords<>" + DbAdapter.cite(keywords);
        }
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT keywords FROM Keywords WHERE community=" + DbAdapter.cite(community) + " AND (" + contains.toString() + ")" + where + " ORDER BY click DESC");
            for(int i = 0;(pagesize == 0 || i < pagesize) && db.next();i++)
            {
                vector.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }


    public static String create(String community,String keywords,int count,String ip) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(0,"INSERT INTO Keywords(community,keywords,click,count,ip)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(keywords) + "," + 1 + "," + count + "," + DbAdapter.cite(ip) + ")");
        } finally
        {
            db.close();
        }
        // _cache.remove(community + ":" + keywords);
        return keywords;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(0,"DELETE FROM Keywords WHERE keywords=" + DbAdapter.cite(keywords) + " AND community=" + DbAdapter.cite(community));
        } finally
        {
            db.close();
        }
        _cache.remove(community + ":" + keywords);
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getKeywords()
    {
        return keywords;
    }

    public int getClick()
    {
        return click;
    }

    public String getCommunity()
    {
        return community;
    }

    public int getCount()
    {
        return count;
    }

    public void setClick(int click) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(0,"UPDATE Keywords SET click=" + click + " WHERE keywords=" + DbAdapter.cite(keywords) + " AND community=" + DbAdapter.cite(community));
        } finally
        {
            db.close();
        }
        this.click = click;
    }
}
