package tea.entity.admin;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class Manoeuvre extends Entity
{
    private int manoeuvre;
    private String manmember;
    private String content;
    private String formerduty;
    private String backduty;
    private Date mantime;
    private String audmamber;

    private String member;
    private String community;
    private Date times;
    private int type;

    private static Cache _cache = new Cache(100);
    private boolean exists;

    public Manoeuvre(int manoeuvre) throws SQLException
    {
        this.manoeuvre = manoeuvre;
        load();
    }

    public static Manoeuvre find(int manoeuvre) throws SQLException
    {
        Manoeuvre obj = (Manoeuvre) _cache.get(new Integer(manoeuvre));
        if(obj == null)
        {
            obj = new Manoeuvre(manoeuvre);
            _cache.put(new Integer(manoeuvre),obj);
        }
        return obj;
    }

    public static void create(String manmember,String content,String formerduty,String backduty,Date mantime,String audmamber,String member,String community) throws SQLException
    {
        Date times = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Manoeuvre (manmember,content,formerduty,backduty,mantime,audmamber,member,community,times)VALUES(" + DbAdapter.cite(manmember) + "," + DbAdapter.cite(content) + "," + DbAdapter.cite(formerduty) + "," + DbAdapter.cite(backduty) + "," + DbAdapter.cite(mantime) + "," + DbAdapter.cite(audmamber) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(times) + " )");
        } finally
        {
            db.close();
        }
    }


    public void set(String manmember,String content,String formerduty,String backduty,Date mantime,String audmamber,String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Manoeuvre SET manmember=" + DbAdapter.cite(manmember) + ",content=" + DbAdapter.cite(content) + ",formerduty=" + DbAdapter.cite(formerduty) + ",backduty=" + DbAdapter.cite(backduty) + ",mantime=" + DbAdapter.cite(mantime) + ",audmamber=" + DbAdapter.cite(audmamber) + ",member=" + DbAdapter.cite(member) + " WHERE manoeuvre=" + manoeuvre);
        } finally
        {
            db.close();
        }
        this.manmember = manmember;
        this.content = content;
        this.formerduty = formerduty;
        this.backduty = backduty;
        this.mantime = mantime;
        this.audmamber = audmamber;
        this.member = member;
    }

    public void set(int type) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Manoeuvre SET type= " + type + " WHERE manoeuvre=" + manoeuvre);
        } finally
        {
            db.close();
        }
        this.type = type;
    }


    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Manoeuvre WHERE manoeuvre=" + manoeuvre);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(manoeuvre));
    }


    public static int count(String community,String sql) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM Manoeuvre WHERE community=" + DbAdapter.cite(community) + sql);
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
            db.executeQuery("SELECT manoeuvre FROM Manoeuvre WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
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
            db.executeQuery("select  manmember, content, formerduty, backduty, mantime, audmamber, member, community,times,type from Manoeuvre WHERE manoeuvre=" + manoeuvre);
            if(db.next())
            {
                manmember = db.getString(1);
                content = db.getString(2);
                formerduty = db.getString(3);
                backduty = db.getString(4);
                mantime = db.getDate(5);
                audmamber = db.getString(6);
                member = db.getString(7);
                community = db.getString(8);
                times = db.getDate(9);
                type = db.getInt(10);
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

    public String getAudmamber()
    {
        return audmamber;
    }

    public String getBackduty()
    {
        return backduty;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getContent()
    {
        return content;
    }

    public String getFormerduty()
    {
        return formerduty;
    }

    public String getManmember()
    {
        return manmember;
    }

    public int getManoeuvre()
    {
        return manoeuvre;
    }

    public Date getMantime()
    {
        return mantime;
    }

    public String getMantimeToString()
    {
        if(mantime == null)
        {
            return "";
        }
        return sdf.format(mantime);
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

    public int getType()
    {
        return type;
    }


}
