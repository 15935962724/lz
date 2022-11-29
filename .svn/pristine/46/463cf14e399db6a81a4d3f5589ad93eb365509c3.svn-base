package tea.entity.eon;

import java.math.*;
import java.sql.SQLException;
import java.util.*;
import tea.db.*;
import tea.entity.*;

public class EonConsume extends Entity
{
    private static Cache _cache = new Cache(100);
    private int consume;
    private String member;
    private BigDecimal money;
    private Date time;
    private boolean exists;
    public EonConsume(int consume) throws SQLException
    {
        this.consume = consume;
        load();
    }

    public static EonConsume find(int consume) throws SQLException
    {
        EonConsume obj = (EonConsume) _cache.get(new Integer(consume));
        if(obj == null)
        {
            obj = new EonConsume(consume);
            _cache.put(new Integer(consume),obj);
        }
        return obj;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT member,money,time FROM EonConsume WHERE consume=" + consume);
            if(db.next())
            {
                member = db.getString(1);
                money = db.getBigDecimal(2,2);
                time = db.getDate(3);
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

    public static void create(String member,BigDecimal money) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO EonConsume(member, money, time) VALUES (" + DbAdapter.cite(member) + ", " + money + "," + db.cite(new Date()) + ")");
        } finally
        {
            db.close();
        }
    }

    public static int count(String member,String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(consume) FROM EonConsume WHERE member=" + DbAdapter.cite(member) + sql);
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

    public static Enumeration find(String member,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT consume FROM EonConsume WHERE member=" + DbAdapter.cite(member) + sql,pos,size);
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


    public String getMember()
    {
        return member;
    }

    public boolean isExists()
    {
        return exists;
    }

    public BigDecimal getMoney()
    {
        return money;
    }

    public String getMoneyToString()
    {
        return df.format(money);
    }

    public Date getTime()
    {
        return time;
    }

    public String getTimeToString()
    {
        return sdf2.format(time);
    }

}
