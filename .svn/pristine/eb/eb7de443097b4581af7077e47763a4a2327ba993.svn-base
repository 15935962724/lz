package tea.entity.yl.shop;

import java.io.*;
import java.util.*;
import java.sql.SQLException;

import tea.db.DbAdapter;
import tea.entity.*;

public class ShopCoupon
{
    protected static Cache c = new Cache(50);
    public int coupon; //优惠券
    public int publish; //发行
    public String member; //代理商
    public int activate; //激活者
    public int trade; //订单
    public String password; //密码

    public ShopCoupon(int coupon)
    {
        this.coupon = coupon;
    }

    public static ShopCoupon find(int coupon) throws SQLException
    {
        ShopCoupon t = (ShopCoupon) c.get(coupon);
        if (t == null)
        {
            ArrayList al = find(" AND coupon=" + coupon, 0, 1);
            t = al.size() < 1 ? new ShopCoupon(coupon) : (ShopCoupon) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT coupon,publish,member,activate,trade,password FROM coupon WHERE 1=1" + sql, pos, size);
            while (rs.next())
            {
                int i = 1;
                ShopCoupon t = new ShopCoupon(rs.getInt(i++));
                t.publish = rs.getInt(i++);
                t.member = rs.getString(i++);
                t.activate = rs.getInt(i++);
                t.trade = rs.getInt(i++);
                t.password = rs.getString(i++);
                c.put(t.coupon, t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM coupon WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if (coupon < 1)
            sql = "INSERT INTO coupon(coupon,publish,member,activate,trade,password)VALUES(" + (coupon = Seq.get()) + "," + publish + "," + DbAdapter.cite(member) + "," + activate + "," + trade + "," + DbAdapter.cite(password) + ")";
        else
            sql = "UPDATE coupon SET publish=" + publish + ",member=" + DbAdapter.cite(member) + ",activate=" + activate + ",trade=" + trade + ",password=" + DbAdapter.cite(password) + " WHERE coupon=" + coupon;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(coupon, sql);
        } finally
        {
            db.close();
        }
        c.remove(coupon);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(coupon, "DELETE FROM coupon WHERE coupon=" + coupon);
        } finally
        {
            db.close();
        }
        c.remove(coupon);
    }

    public void set(String f, String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(coupon, "UPDATE coupon SET " + f + "=" + DbAdapter.cite(v) + " WHERE coupon=" + coupon);
        } finally
        {
            db.close();
        }
        c.remove(coupon);
    }

    //
    public static void setMember(int member, int quantity) throws SQLException
    {
        ArrayList al = ShopCoupon.find(" AND member IS NULL ORDER BY coupon", 0, quantity);
        DbAdapter.execute("UPDATE coupon SET member=" + member + " WHERE coupon<=" + ((ShopCoupon) al.get(al.size() - 1)).coupon + " AND member IS NULL");
        c.clear();
    }

}
