package tea.entity.admin;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class Telephonist extends Entity
{
    private int id;
    private String member;
    private String community;
    private Date times;

    private static Cache _cache = new Cache(100);
    private boolean exists;

    public Telephonist(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static Telephonist find(int id) throws SQLException
    {
        Telephonist obj = (Telephonist) _cache.get(new Integer(id));
        if(obj == null)
        {
            obj = new Telephonist(id);
            _cache.put(new Integer(id),obj);
        }
        return obj;
    }

    public static void create(int id,String member,String community) throws SQLException
    {
        Date times = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Telephonist (id,member,community,times)VALUES( " + id + "," + db.cite(member) + "," + db.cite(community) + "," + db.cite(times) + " )");
        } finally
        {
            db.close();
        }
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Telephonist WHERE id=" + id);
        } finally
        {
            db.close();
        }
    }

    public static int count(String community,String sql) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM Telephonist WHERE community=" + db.cite(community) + sql);
            while(db.next())
            {
                i = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return i;
    }

    public static int countBy(String community,String sql) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM Telephonist t,Destine d WHERE t.id = d.destine and t.community=" + db.cite(community) + sql);
            while(db.next())
            {
                i = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return i;
    }


    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM Telephonist WHERE community=" + db.cite(community) + sql,pos,size);
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

    public static Enumeration findBy(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT t.id FROM Telephonist t,Destine d WHERE t.id=d.destine and t.community=" + db.cite(community) + sql,pos,size);
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


    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT member,community,times FROM Telephonist WHERE id=" + id);
            if(db.next())
            {
                member = db.getString(1);
                community = db.getString(2);
                times = db.getDate(3);
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

    public String getCommunity()
    {
        return community;
    }

    public int getId()
    {
        return id;
    }

    public String getMember()
    {
        return member;
    }

    public Date getTimes()
    {
        return times;
    }

    public String getTimesToString()
    {
        if(times == null)
        {
            return "";
        }
        return sdf.format(times);
    }

}
