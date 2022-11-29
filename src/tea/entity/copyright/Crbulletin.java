package tea.entity.copyright;

import tea.db.DbAdapter;
import tea.entity.*;

import java.util.*;
import java.sql.SQLException;

//各类作品著作权登记公告
public class Crbulletin extends Entity
{
    public static Cache _cache = new Cache(100);
    private int crbulletin;
    private String community;
    private String scrbid;
    private String ainame;
    private String writingname;
    private String writingtype;
    private Date createdate;
    private Date pubdate;

    public Crbulletin(int crbulletin) throws SQLException
    {
        this.crbulletin = crbulletin;
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,scrbid,ainame,writingname,writingtype,createdate,pubdate FROM crbulletin WHERE crbulletin=" + crbulletin);
            if(db.next())
            {
                community = db.getString(1);
                scrbid = db.getString(2);
                ainame = db.getString(3);
                writingname = db.getString(4);
                writingtype = db.getString(5);
                createdate = db.getDate(6);
                pubdate = db.getDate(7);
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(String community,String scrbid,String ainame,String writingname,String writingtype,Date createdate,Date pubdate) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO crbulletin(community,scrbid,ainame,writingname,writingtype,createdate,pubdate)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(scrbid) + "," + DbAdapter.cite(ainame)
                             + "," + DbAdapter.cite(writingname) + "," + DbAdapter.cite(writingtype) + "," + DbAdapter.cite(createdate) + "," + DbAdapter.cite(pubdate) + ")");
        } finally
        {
            db.close();
        }
        // _cache.remove(new Integer(crbulletin));
    }

    public void set(String scrbid,String ainame,String writingname,String writingtype,Date createdate,Date pubdate) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE crbulletin SET scrbid=" + DbAdapter.cite(scrbid) + ",ainame=" + DbAdapter.cite(ainame) + ",writingname=" + DbAdapter.cite(writingname) + ",writingtype=" + DbAdapter.cite(writingtype)
                             + ",createdate=" + DbAdapter.cite(createdate) + ",pubdate=" + DbAdapter.cite(pubdate) + " WHERE crbulletin=" + crbulletin);
        } finally
        {
            db.close();
        }
        this.scrbid = scrbid;
        this.ainame = ainame;
        this.writingname = writingname;
        this.writingtype = writingtype;
        this.createdate = createdate;
        this.pubdate = pubdate;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM crbulletin WHERE crbulletin=" + crbulletin);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(crbulletin));
    }

    public String getScrbid()
    {
        return scrbid;
    }

    public int getCrbulletin()
    {
        return crbulletin;
    }

    public static Crbulletin find(int crbulletin) throws SQLException
    {
        Crbulletin obj = (Crbulletin) _cache.get(new Integer(crbulletin));
        if(obj == null)
        {
            obj = new Crbulletin(crbulletin);
            _cache.put(new Integer(crbulletin),obj);
        }
        return obj;
    }

    public static int find(String scrbid) throws SQLException
    {
        int crbulletin = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT crbulletin FROM crbulletin WHERE scrbid=" + DbAdapter.cite(scrbid));
            if(db.next())
            {
                crbulletin = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return crbulletin;
    }

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(crbulletin) FROM crbulletin WHERE community=" + DbAdapter.cite(community) + sql);
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

    public String getAiname()
    {
        return ainame;
    }

    public String getCommunity()
    {
        return community;
    }

    public Date getCreatedate()
    {
        return createdate;
    }

    public Date getPubdate()
    {
        return pubdate;
    }

    public String getCreatedateToString()
    {
        if(createdate == null)
        {
            return "";
        }
        return sdf.format(createdate);
    }

    public String getPubdateToString()
    {
        if(pubdate == null)
        {
            return "";
        }
        return sdf.format(pubdate);
    }

    public String getWritingname()
    {
        return writingname;
    }

    public String getWritingtype()
    {
        return writingtype;
    }

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT crbulletin FROM crbulletin WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
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
