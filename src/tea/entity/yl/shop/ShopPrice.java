package tea.entity.yl.shop;

import java.sql.SQLException;
import java.util.ArrayList;
import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Seq;

//价格
public class ShopPrice
{
    protected static Cache c = new Cache(50);
    public int price;
    public String area = "|"; //区域
    public int maxi;
    public ShopPrice(int price)
    {
        this.price = price;
    }

    public static ShopPrice find(int price) throws SQLException
    {
        ShopPrice t = (ShopPrice) c.get(price);
        if (t == null)
        {
            ArrayList al = find(" AND price=" + price, 0, 1);
            t = al.size() < 1 ? new ShopPrice(price) : (ShopPrice) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT price,area,maxi FROM shopprice WHERE 1=1" + sql, pos, size);
            while (rs.next())
            {
                int i = 1;
                ShopPrice t = new ShopPrice(rs.getInt(i++));
                t.area = rs.getString(i++);
                t.maxi = rs.getInt(i++);
                c.put(t.price, t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM shopprice WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if (price < 1)
            sql = "INSERT INTO shopprice(price,area,maxi)VALUES(" + (price = Seq.get()) + "," + DbAdapter.cite(area) + "," + maxi + ")";
        else
            sql = "UPDATE shopprice SET area=" + DbAdapter.cite(area) + ",maxi=" + maxi + " WHERE price=" + price;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(price, sql);
        } finally
        {
            db.close();
        }
        c.remove(price);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(price, "DELETE FROM shopprice WHERE price=" + price);
        } finally
        {
            db.close();
        }
        c.remove(price);
    }

    public void set(String f, String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(price, "UPDATE shopprice SET " + f + "=" + DbAdapter.cite(v) + " WHERE price=" + price);
        } finally
        {
            db.close();
        }
        c.remove(price);
    }

    //
    public String getArea()
    {
        StringBuilder sb = new StringBuilder();
        String[] arr = area.split("[|]");
        for (int i = 1; i < arr.length; i++)
        {
            sb.append(Integer.parseInt(arr[i]));
            if (arr.length == i + 1)
            {
                sb.append("以上");
                break;
            }
            sb.append("-" + (Integer.parseInt(arr[i + 1]) - 1) + " ");
        }
        return sb.toString();
    }

    public String getAnchor(int lang, String url)
    {
        StringBuilder sb = new StringBuilder();
        String[] arr = area.split("[|]");
        for (int i = 1; i < arr.length; i++)
        {
            sb.append("<a href=" + url + ">");
            sb.append(Integer.parseInt(arr[i]));
            sb.append((arr.length == i + 1 ? "以上" : "-" + (Integer.parseInt(arr[i + 1]) - 1)) + "</a> ");
        }
        return sb.toString();
    }
}
