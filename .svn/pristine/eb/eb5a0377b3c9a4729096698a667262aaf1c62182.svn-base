package tea.entity.member;

import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

//会员操作订单的流程图
public class TradeMember
{
    private static Cache _cache = new Cache(100);
    private int id;
    private String trade;
    private int status;
    private int paystate;
    private String member;
    private Date time;
    private boolean exists;

    public TradeMember(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static TradeMember find(int id) throws SQLException
    {
        TradeMember trade = (TradeMember) _cache.get(new Integer(id));
        if(trade == null)
        {
            trade = new TradeMember(id);
            _cache.put(new Integer(id),trade);
        }
        return trade;
    }

    public static java.util.Enumeration findByTrade(String trade) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM trademember WHERE trade=" + DbAdapter.cite(trade) + " ORDER BY time");
            while(db.next())
            {
                v.add(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static int countLastByMember(String member,String sql) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(DISTINCT trade) FROM trademember WHERE member=" + DbAdapter.cite(member) + " AND time>" + DbAdapter.cite(new Date(System.currentTimeMillis() - 1000L * 60 * 60 * 24)) + sql);
            if(db.next())
            {
                i = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return i;
    }

    public static java.util.Enumeration findLastByMember(String member,String sql,int pos,int size) throws SQLException
    {
        String o = "";
        int j = sql.lastIndexOf("ORDER");
        if(j != -1)
        {
            o = sql.substring(j);
            sql = sql.substring(0,j);
        }
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT trade FROM trademember WHERE member=" + DbAdapter.cite(member) + " AND time>" + DbAdapter.cite(new Date(System.currentTimeMillis() - 1000L * 60 * 60 * 24)) + sql + " GROUP BY trade "+o,pos,size);
            while(db.next())
            {
                v.add(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static void create(String trade,int status,int paystate,String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO trademember(trade,status,paystate,member,time)VALUES(" + DbAdapter.cite(trade) + "," + status + "," + paystate + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(new java.util.Date()) + ")");
        } finally
        {
            db.close();
        }
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT  trade,status,paystate,member,time FROM trademember WHERE id= " + id);
            if(db.next())
            {
                trade = db.getString(1);
                status = db.getInt(2);
                paystate = db.getInt(3);
                member = db.getString(4);
                time = db.getDate(5);
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

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM trademember WHERE id=" + id);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
    }

    public static int getLast(String trade) throws SQLException
    {
        int id = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM trademember WHERE trade=" + DbAdapter.cite(trade) + " ORDER BY time DESC");
            if(db.next())
            {
                id = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return id;
    }

    public int getId()
    {
        return id;
    }

    public String getTrade()
    {
        return trade;
    }

    public int getStatus()
    {
        return status;
    }

    public String getMember()
    {
        return member;
    }

    public Date getTime()
    {
        return time;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getPaystate()
    {
        return paystate;
    }
}
