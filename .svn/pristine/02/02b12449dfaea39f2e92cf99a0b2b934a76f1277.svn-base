package tea.entity.admin;

import java.io.*;
import java.util.*;

import tea.db.DbAdapter;
import java.sql.SQLException;
import tea.entity.*;
import java.text.*;

public class Outs extends Entity
{
    private int outid; // 主键ID
    private int unitid; // 用户的上机部门ID
    private String name; // 用户的Name
    private String cause; // 请假的原因
    private String time_w; // 外出的时间
    private String time_h; // 回来的时间
    private int type; // 操作的标示
    private int bumen; // 用户的部门
    private Date days;
    private String member;
    private boolean exists;
    private int un;
    private int cl;
    private static Cache _cache = new Cache(100);

    public Outs(int outid) throws SQLException
    {
        this.outid = outid;
        load();
    }

    public static Outs find(int outid) throws SQLException
    {
        return new Outs(outid);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select unitid,name,cause,time_w,time_h,type ,bumen,days,member,un,cl  from Outs where outid =" + outid);
            if(db.next())
            {
                unitid = db.getInt(1);
                name = db.getVarchar(1,1,2);
                cause = db.getVarchar(1,1,3);
                time_w = db.getVarchar(1,1,4);
                time_h = db.getVarchar(1,1,5);
                type = db.getInt(6);
                bumen = db.getInt(7);
                days = db.getDate(8);
                member = db.getVarchar(1,1,9);
                un = db.getInt(10);
                cl = db.getInt(11);

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

    public static int create(int unitid,String name,String cause,String time_w,String time_h,int bumen,String community,RV _rv,int un,int cl) throws SQLException
    {
        int id = 0;
        String dd = DutyClass.GetNowDate();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Outs(unitid,name,cause,time_w,time_h,bumen,days,community,member,un,cl) VALUES(" + unitid + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(cause) + "," + DbAdapter.cite(time_w) + "," + DbAdapter.cite(time_h) + "," + bumen + "," + DbAdapter.cite(dd) + "," + DbAdapter.cite(community) + ",'" + _rv + "'," + un + "," + cl + ")");
            id = db.getInt("SELECT MAX(outid) FROM Outs");
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
        return id;
    }

    public static Outs findByMember(String community,String member) throws SQLException
    {
        Calendar c = Calendar.getInstance();
        c.setTimeInMillis(System.currentTimeMillis());
        c.set(11,0);
        c.set(12,0);
        c.set(13,0);
        c.set(14,0);
        int outid = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT outid FROM Outs WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member) + " AND days=" + DbAdapter.cite(c.getTime()));
            if(db.next())
            {
                outid = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return find(outid);
    }

    public boolean isExists()
    {
        return exists;
    }

    public static Enumeration findByCommunity(String community,String sql) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT outid FROM Outs WHERE community=" + DbAdapter.cite(community) + sql);
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

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Outs WHERE member=" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
    }

    public static void deleteAll() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Outs");
        } finally
        {
            db.close();
        }
    }

    public void settype(int type) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Outs set type=" + type + " where outid = " + outid);
        } finally
        {
            db.close();
        }
    }

    public int getUnitid()
    {
        return unitid;
    }

    public String getName()
    {
        return name;
    }

    public String getCause()
    {
        return cause;
    }

    public String getTime_w()
    {
        return time_w;
    }

    public String getTime_h()
    {
        return time_h;
    }

    public int getType()
    {
        return type;
    }

    public int getBumen()
    {
        return bumen;
    }

    public Date getDays()
    {
        return days;
    }

    public String getMember()
    {
        return member;
    }

    public int getUn()
    {
        return un;
    }

    public int getCl()
    {
        return cl;
    }
}
