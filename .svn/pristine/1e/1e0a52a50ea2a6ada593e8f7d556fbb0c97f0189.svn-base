package tea.entity.yl.shop;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.entity.*;

public class Discount
{
    protected static Cache c = new Cache(50);
    public int discount; //打折
    public static String[] TYPE_NAME =
            {"---", "优惠券"};
    public int type = 1; //类型
    public boolean cust; //全部/自定义
    public String brand = "|"; //品牌
    public int category; //类别
    public String product = "|"; //商品
    public int value; //折扣
    public static String[] STATE_TYPE =
            {"启用", "暂停"};
    public int state; //状态
    public int member; //操作人
    public Date time; //创建时间

    public Discount(int discount)
    {
        this.discount = discount;
    }

    public static Discount find(int discount) throws SQLException
    {
        Discount t = (Discount) c.get(discount);
        if (t == null)
        {
            ArrayList al = find(" AND discount=" + discount, 0, 1);
            t = al.size() < 1 ? new Discount(discount) : (Discount) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT discount,type,cust,brand,category,product,value,state,member,time FROM discount WHERE 1=1" + sql, pos, size);
            while (rs.next())
            {
                int i = 1;
                Discount t = new Discount(rs.getInt(i++));
                t.type = rs.getInt(i++);
                t.cust = rs.getBoolean(i++);
                t.brand = rs.getString(i++);
                t.category = rs.getInt(i++);
                t.product = rs.getString(i++);
                t.value = rs.getInt(i++);
                t.state = rs.getInt(i++);
                t.member = rs.getInt(i++);
                t.time = db.getDate(i++);
                c.put(t.discount, t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM discount WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if (discount < 1)
            sql = "INSERT INTO discount(discount,type,cust,brand,category,product,value,state,member,time)VALUES(" + (discount = Seq.get()) + "," + type + "," + DbAdapter.cite(cust) + "," + DbAdapter.cite(brand) + "," + category + "," + DbAdapter.cite(product) + "," + value + "," + state + "," + member + "," + DbAdapter.cite(time) + ")";
        else
            sql = "UPDATE discount SET type=" + type + ",cust=" + DbAdapter.cite(cust) + ",brand=" + DbAdapter.cite(brand) + ",category=" + category + ",product=" + DbAdapter.cite(product) + ",value=" + value + ",state=" + state + ",member=" + member + ",time=" + DbAdapter.cite(time) + " WHERE discount=" + discount;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(discount, sql);
        } finally
        {
            db.close();
        }
        c.remove(discount);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(discount, "DELETE FROM discount WHERE discount=" + discount);
        } finally
        {
            db.close();
        }
        c.remove(discount);
    }

    public void set(String f, String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(discount, "UPDATE discount SET " + f + "=" + DbAdapter.cite(v) + " WHERE discount=" + discount);
        } finally
        {
            db.close();
        }
        c.remove(discount);
    }


}
