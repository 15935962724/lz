package tea.entity.yl.shop;

import java.util.*;
import java.sql.SQLException;
import tea.db.DbAdapter;
import tea.entity.*;

public class ShopBrand
{
    protected static Cache c = new Cache(50);
    public int brand; //品牌
    public String[] name = new String[2]; //名称
    public String logo;
    public String[] content = new String[2]; //内容
    public int sequence; //顺序
    public Date time; //时间
    public String sync;

    public ShopBrand(int brand)
    {
        this.brand = brand;
    }

    public static ShopBrand find(int brand) throws SQLException
    {
        ShopBrand t = (ShopBrand) c.get(brand);
        if (t == null)
        {
            ArrayList al = find(" AND brand=" + brand, 0, 1);
            t = al.size() < 1 ? new ShopBrand(brand) : (ShopBrand) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT brand,name0,name1,logo,content0,content1,sequence,time FROM shopbrand WHERE 1=1" + sql, pos, size);
            while (rs.next())
            {
                int i = 1;
                ShopBrand t = new ShopBrand(rs.getInt(i++));
                t.name[0] = rs.getString(i++);
                t.name[1] = rs.getString(i++);
                t.logo = rs.getString(i++);
                t.content[0] = rs.getString(i++);
                t.content[1] = rs.getString(i++);
                t.sequence = rs.getInt(i++);
                t.time = db.getDate(i++);
                c.put(t.brand, t);
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
    	return DbAdapter.execute("SELECT COUNT(*) FROM shopbrand WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if (brand < 1)
            sql = "INSERT INTO shopbrand(brand,name0,name1,logo,content0,content1,sequence,time,sync)VALUES(" + (brand = Seq.get()) + "," + DbAdapter.cite(name[0]) + "," + DbAdapter.cite(name[1]) + "," + DbAdapter.cite(logo) + "," + DbAdapter.cite(content[0]) + "," + DbAdapter.cite(content[1]) + "," + sequence + "," + DbAdapter.cite(time) + "," + DbAdapter.cite(sync) + ")";
        else
            sql = "UPDATE shopbrand SET name0=" + DbAdapter.cite(name[0]) + ",name1=" + DbAdapter.cite(name[1]) + ",logo=" + DbAdapter.cite(logo) + ",content0=" + DbAdapter.cite(content[0]) + ",content1=" + DbAdapter.cite(content[1]) + ",sequence=" + sequence + ",time=" + DbAdapter.cite(time) + " WHERE brand=" + brand;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(brand, sql);
        } finally
        {
            db.close();
        }
        c.remove(brand);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(brand, "DELETE FROM shopbrand WHERE brand=" + brand);
        } finally
        {
            db.close();
        }
        c.remove(brand);
    }

    public void set(String f, String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(brand, "UPDATE shopbrand SET " + f + "=" + DbAdapter.cite(v) + " WHERE brand=" + brand);
        } finally
        {
            db.close();
        }
        c.remove(brand);
    }

    //
    public String getAnchor(int lang)
    {
        return "<a href='/shopbrand.jsp?brand=" + brand + "'>" + Res.f(lang, name) + "</a>";
    }

    public String getAncestor(int lang) throws SQLException
    {
        return "<a href='/'>首页</a>" + " >> " + getAnchor(lang);
    }
}
