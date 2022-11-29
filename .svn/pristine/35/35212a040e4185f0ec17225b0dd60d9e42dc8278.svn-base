package tea.entity.yl.shop;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.entity.*;
import tea.entity.member.*;

//财务记录
public class Money
{
    protected static Cache c = new Cache(50);
    public int money;
    public int member; //用户
    public float value; //支入、支出
    public float balance; //余额
    public String content; //说明
    public int omember; //操作人
    public Date time; //时间

    public Money(int money)
    {
        this.money = money;
    }

    public static Money find(int money) throws SQLException
    {
        Money t = (Money) c.get(money);
        if (t == null)
        {
            ArrayList al = find(" AND mo.money=" + money, 0, 1);
            t = al.size() < 1 ? new Money(money) : (Money) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT mo.money,mo.member,mo.value,mo.balance,mo.content,mo.omember,mo.time FROM money mo WHERE 1=1" + sql + " ORDER BY mo.money DESC", pos, size);
            while (rs.next())
            {
                int i = 1;
                Money t = new Money(rs.getInt(i++));
                t.member = rs.getInt(i++);
                t.value = rs.getFloat(i++);
                t.balance = rs.getFloat(i++);
                t.content = rs.getString(i++);
                t.omember = rs.getInt(i++);
                t.time = db.getDate(i++);
                c.put(t.money, t);
                al.add(t);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM money mo" + tab(sql) + " WHERE 1=1" + sql);
    }

    private static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if (sql.contains(" AND m."))
            sb.append(" INNER JOIN Member m ON m.member=mo.member");
        return sb.toString();
    }

    public void set() throws SQLException
    {
        String sql;
        if (money < 1)
            sql = "INSERT INTO money(money,member,value,balance,content,omember,time)VALUES(" + (money = Seq.get()) + "," + member + "," + value + "," + balance + "," + DbAdapter.cite(content) + "," + omember + "," + DbAdapter.cite(time) + ")";
        else
            sql = "UPDATE money SET member=" + member + ",value=" + value + ",balance=" + balance + ",content=" + DbAdapter.cite(content) + ",omember=" + omember + ",time=" + DbAdapter.cite(time) + " WHERE money=" + money;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(money, sql);
        } finally
        {
            db.close();
        }
        c.remove(money);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(money, "DELETE FROM money WHERE money=" + money);
        } finally
        {
            db.close();
        }
        c.remove(money);
    }

    public void set(String f, String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(money, "UPDATE money SET " + f + "=" + DbAdapter.cite(v) + " WHERE money=" + money);
        } finally
        {
            db.close();
        }
        c.remove(money);
    }

    //
    public static void create(int member, float value, int omember, String content) throws SQLException
    {
        Member m = Member.find(member);
        Money t = new Money(0);
        t.member = member;
        t.value = value;
        m.balance += t.value;
        t.balance = m.balance;
        t.omember = omember;
        t.content = content;
        t.time = new Date();
        m.set("balance", String.valueOf(m.balance));
        t.set();
    }
}
