package tea.entity.finance;

import java.math.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class KindsMoney extends Entity
{
    private int id;
    private String member;
    private int kid;
    private BigDecimal money;
    private Date date;
    private int sandz;
    private String ps;


    public KindsMoney(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static KindsMoney find(int id) throws SQLException
    {
        return new KindsMoney(id);
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select id,member,kid,money,date,sandz,ps from kindmoney where id=" + id);
            if(db.next())
            {
                int j = 1;
                id = db.getInt(j++);
                member = db.getString(j++);
                kid = db.getInt(j++);
                money = db.getBigDecimal(j++,2);
                date = db.getDate(j++);
                sandz = db.getInt(j++);
                ps = db.getString(j++);
            }
        } finally
        {
            db.close();
        }
    }

    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT  id FROM kindmoney WHERE 1=1" + sql,pos,size);
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

    public static BigDecimal sum(String sql,int pos,int size) throws SQLException
    {
        BigDecimal money = null;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT  sum(money) FROM kindmoney WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                money = db.getBigDecimal(1,2);
            }
        } finally
        {
            db.close();
        }
        return money;
    }


    public static void create(String member,int kid,String money,Date date,int sandz,String ps) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("insert into kindmoney(member,kid,money,date,sandz,ps) values(" + db.cite(member) + ", " + kid + ", " + db.cite(money) + ", " + db.cite(date) + ", " + sandz + "," + db.cite(ps) + ")");
        } finally
        {
            db.close();
        }
    }

    public int getId()
    {
        return id;
    }

    public static void update(int id,int kid,String money,Date date,int sandz,String ps) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update kindmoney set kid=" + kid + ", money=" + db.cite(money) + ", date=" + db.cite(date) + ", sandz=" + sandz + ", ps=" + db.cite(ps) + " where id=" + id);
        } finally
        {
            db.close();
        }
    }

    public static void del(int id) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from kindmoney where id=" + id);
        } finally
        {
            db.close();
        }
    }


    public Date getDate()
    {
        return date;
    }

    public String getDateToString()
    {
        String dates = KindsMoney.sdf.format(date);
        return dates;
    }


    public int getKid()
    {
        return kid;
    }

    public String getMember()
    {
        return member;
    }

    public int getSandz()
    {
        return sandz;
    }

    public String getPs()
    {
        return ps;
    }

    public BigDecimal getMoney()
    {
        return money;
    }


}
