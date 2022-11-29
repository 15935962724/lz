package tea.entity.copyright;

import tea.db.DbAdapter;
import tea.entity.*;

import java.util.*;
import java.sql.SQLException;

public class Crnotice extends Entity
{
    public static Cache _cache = new Cache(100);
    private int crnotice;
    private String community;
    private String title;
    private String author1;
    private String author2;
    private String pubpaper;
    private String repubpaper;
    private String pubdate;
    private String repubdate;
    private String sfdr;

    public Crnotice(int crnotice) throws SQLException
    {
        this.crnotice = crnotice;
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,title,author1,author2,pubpaper,repubpaper,pubdate,repubdate,sfdr FROM crnotice WHERE crnotice=" + crnotice);
            if(db.next())
            {
                community = db.getString(1);
                title = db.getString(2);
                author1 = db.getString(3);
                author2 = db.getString(4);
                pubpaper = db.getString(5);
                repubpaper = db.getString(6);
                pubdate = db.getString(7);
                repubdate = db.getString(8);
                sfdr = db.getString(9);
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(String community,String title,String author1,String author2,String pubpaper,String repubpaper,String pubdate,String repubdate,String sfdr) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO crnotice(community,title,author1,author2,pubpaper,repubpaper,pubdate,repubdate,sfdr)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(title) + "," + DbAdapter.cite(author1) + "," + DbAdapter.cite(author2) + "," + DbAdapter.cite(pubpaper) + "," + DbAdapter.cite(repubpaper) + "," + DbAdapter.cite(pubdate) + "," + DbAdapter.cite(repubdate) + "," + DbAdapter.cite(sfdr) + ")");
        } finally
        {
            db.close();
        }
    }

    public void set(String title,String author1,String author2,String pubpaper,String repubpaper,String pubdate,String repubdate,String sfdr) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE crnotice SET title=" + DbAdapter.cite(title) + ",author1=" + DbAdapter.cite(author1) + ",author2=" + DbAdapter.cite(author2) + ",pubpaper=" + DbAdapter.cite(pubpaper) + ",repubpaper=" + DbAdapter.cite(repubpaper) + ",pubdate=" + DbAdapter.cite(pubdate) + ",repubdate=" + DbAdapter.cite(repubdate) + ",sfdr=" + DbAdapter.cite(sfdr) + " WHERE crnotice=" + crnotice);
        } finally
        {
            db.close();
        }
        this.title = title;
        this.author1 = author1;
        this.author2 = author2;
        this.pubpaper = pubpaper;
        this.repubpaper = repubpaper;
        this.pubdate = pubdate;
        this.repubdate = repubdate;
        this.sfdr = sfdr;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM crnotice WHERE crnotice=" + crnotice);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(crnotice));
    }

    public String getPubpaper()
    {
        return pubpaper;
    }

    public String getPubdate()
    {
        return pubdate;
    }

    public String getPubdateToString()
    {
        if(pubdate == null)
        {
            return "";
        }
        return pubdate; // sdf.format(pubdate);
    }

    public String getAuthor1()
    {
        return author1;
    }

    public String getAuthor2()
    {
        return author2;
    }

    public String getSfdr()
    {
        return sfdr;
    }

    /*
     * public String getSfdrToString() { if (sfdr == null) { return ""; } return sdf.format(sfdr); }
     */
    public String getTitle()
    {
        return title;
    }

    public String getRepubpaper()
    {
        return repubpaper;
    }

    public String getRepubdate()
    {
        return repubdate;
    }

    public int getCrnotice()
    {
        return crnotice;
    }

    public static Crnotice find(int crnotice) throws SQLException
    {
        Crnotice obj = (Crnotice) _cache.get(new Integer(crnotice));
        if(obj == null)
        {
            obj = new Crnotice(crnotice);
            _cache.put(new Integer(crnotice),obj);
        }
        return obj;
    }

    public static int find(String scrbid) throws SQLException
    {
        int crnotice = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT crnotice FROM crnotice WHERE scrbid=" + DbAdapter.cite(scrbid));
            if(db.next())
            {
                crnotice = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return crnotice;
    }

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(crnotice) FROM crnotice WHERE community=" + DbAdapter.cite(community) + sql);
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
            db.executeQuery("SELECT crnotice FROM crnotice WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
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
