package tea.entity.copyright;

import tea.db.DbAdapter;
import tea.entity.*;

import java.util.*;
import java.sql.SQLException;

public class Crbookin extends Entity
{
    public static Cache _cache = new Cache(100);
    private int crbookin;
    private String community;
    private String scrbid;
    private String classno;
    private String swname;
    private String shortname;
    private String version;
    private String author;
    private String nation;
    private String pubarea;
    private Date pubdate;
    private String price;
    private String pricedollar;
    private Date passdate;
    private String remark1;
    private String remark2;

    public Crbookin(int crbookin) throws SQLException
    {
        this.crbookin = crbookin;
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,scrbid,classno,swname,shortname,version,author,nation,pubarea,pubdate,price,pricedollar,passdate,remark1,remark2 FROM crbookin WHERE crbookin=" + crbookin);
            if(db.next())
            {
                community = db.getString(1);
                scrbid = db.getString(2);
                classno = db.getString(3);
                swname = db.getString(4);
                shortname = db.getString(5);
                version = db.getString(6);
                author = db.getString(7);
                nation = db.getString(8);
                pubarea = db.getString(9);
                pubdate = db.getDate(10);
                price = db.getString(11);
                pricedollar = db.getString(12);
                passdate = db.getDate(13);
                remark1 = db.getString(14);
                remark2 = db.getString(15);
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(String community,String scrbid,String classno,String swname,String shortname,String version,String author,String nation,String pubarea,Date pubdate,String price,String pricedollar,Date passdate,String remark1,String remark2) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO crbookin(community,scrbid,classno,swname,shortname,version,author,nation,pubarea,pubdate,price,pricedollar,passdate,remark1,remark2)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(scrbid) + "," + DbAdapter.cite(classno) + "," + DbAdapter.cite(swname) + "," + DbAdapter.cite(shortname) + "," + DbAdapter.cite(version) + "," + DbAdapter.cite(author) + "," + DbAdapter.cite(nation) + "," + DbAdapter.cite(pubarea) + "," + DbAdapter.cite(pubdate) + "," + DbAdapter.cite(price) + "," + DbAdapter.cite(pricedollar) + ","
                             + DbAdapter.cite(passdate) + "," + DbAdapter.cite(remark1) + "," + DbAdapter.cite(remark2) + ")");
        } finally
        {
            db.close();
        }
        // _cache.remove(new Integer(crbookin));
    }

    public void set(String classno,String swname,String shortname,String version,String author,String nation,String pubarea,Date pubdate,String price,String pricedollar,Date passdate,String remark1,String remark2) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE crbookin SET classno=" + DbAdapter.cite(classno) + ",swname=" + DbAdapter.cite(swname) + ",shortname=" + DbAdapter.cite(shortname) + ",version=" + DbAdapter.cite(version) + ",author=" + DbAdapter.cite(author) + ",nation=" + DbAdapter.cite(nation) + ",pubarea=" + DbAdapter.cite(pubarea) + ",pubdate=" + DbAdapter.cite(pubdate) + ",price=" + DbAdapter.cite(price) + ",pricedollar=" + DbAdapter.cite(pricedollar) + ",passdate=" + DbAdapter.cite(passdate) + ",remark1=" + DbAdapter.cite(remark1) + ",remark2=" + DbAdapter.cite(remark2) + " WHERE crbookin="
                             + crbookin);
        } finally
        {
            db.close();
        }
        this.classno = classno;
        this.swname = swname;
        this.shortname = shortname;
        this.version = version;
        this.author = author;
        this.nation = nation;
        this.pubarea = pubarea;
        this.pubdate = pubdate;
        this.price = price;
        this.pricedollar = pricedollar;
        this.passdate = passdate;
        this.remark1 = remark1;
        this.remark2 = remark2;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM crbookin WHERE crbookin=" + crbookin);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(crbookin));
    }

    public String getAuthor()
    {
        return author;
    }

    public String getClassno()
    {
        return classno;
    }

    public int getCrbookin()
    {
        return crbookin;
    }

    public String getNation()
    {
        return nation;
    }

    public Date getPassdate()
    {
        return passdate;
    }

    public String getPassdateToString()
    {
        if(passdate == null)
        {
            return "";
        }
        return sdf.format(passdate);
    }

    public String getPrice()
    {
        return price;
    }

    public String getPricedollar()
    {
        return pricedollar;
    }

    public String getPubarea()
    {
        return pubarea;
    }

    public Date getPubdate()
    {
        return pubdate;
    }

    public String getPubdateToString()
    {
        if(pubdate == null)
        {
            return "";
        }
        return sdf.format(pubdate);
    }

    public String getScrbid()
    {
        return scrbid;
    }

    public String getRemark1()
    {
        return remark1;
    }

    public String getRemark2()
    {
        return remark2;
    }

    public String getShortname()
    {
        return shortname;
    }

    public String getSwname()
    {
        return swname;
    }

    public String getVersion()
    {
        return version;
    }

    public static Crbookin find(int crbookin) throws SQLException
    {
        Crbookin obj = (Crbookin) _cache.get(new Integer(crbookin));
        if(obj == null)
        {
            obj = new Crbookin(crbookin);
            _cache.put(new Integer(crbookin),obj);
        }
        return obj;
    }

    public static int find(String scrbid) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT crbookin FROM crbookin WHERE scrbid=" + DbAdapter.cite(scrbid));
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
            db.executeQuery("SELECT COUNT(crbookin) FROM crbookin WHERE community=" + DbAdapter.cite(community) + sql);
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
            db.executeQuery("SELECT crbookin FROM crbookin WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
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
