package tea.entity.yl.shop;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.entity.*;

//商品清单
public class Item
{
    protected static Cache c = new Cache(50);
    public int item;
    public int trade; //订单
    public int product; //商品
    public int pcolor; //颜色
    public int psize; //尺码
    public float price; //价格
    public int quantity; //数量

    public Item(int item)
    {
        this.item = item;
    }

    public static Item find(int item) throws SQLException
    {
        Item t = (Item) c.get(item);
        if (t == null)
        {
            ArrayList al = find(" AND item=" + item, 0, 1);
            t = al.size() < 1 ? new Item(item) : (Item) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT item,trade,product,pcolor,psize,price,quantity FROM item WHERE 1=1" + sql, pos, size);
            while (rs.next())
            {
                int i = 1;
                Item t = new Item(rs.getInt(i++));
                t.trade = rs.getInt(i++);
                t.product = rs.getInt(i++);
                t.pcolor = rs.getInt(i++);
                t.psize = rs.getInt(i++);
                t.price = rs.getFloat(i++);
                t.quantity = rs.getInt(i++);
                c.put(t.item, t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM item WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if (item < 1)
            sql = "INSERT INTO item(item,trade,product,pcolor,psize,price,quantity)VALUES(" + (item = Seq.get()) + "," + trade + "," + product + "," + pcolor + "," + psize + "," + price + "," + quantity + ")";
        else
            sql = "UPDATE item SET trade=" + trade + ",product=" + product + ",pcolor=" + pcolor + ",psize=" + psize + ",price=" + price + ",quantity=" + quantity + " WHERE item=" + item;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(item, sql);
        } finally
        {
            db.close();
        }
        c.remove(item);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(item, "DELETE FROM item WHERE item=" + item);
        } finally
        {
            db.close();
        }
        c.remove(item);
    }

    public void set(String f, String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(item, "UPDATE item SET " + f + "=" + DbAdapter.cite(v) + " WHERE item=" + item);
        } finally
        {
            db.close();
        }
        c.remove(item);
    }

    //
    public static ArrayList findByTrade(int trade) throws SQLException
    {
        return find(" AND trade=" + trade, 0, 800);
    }

}
