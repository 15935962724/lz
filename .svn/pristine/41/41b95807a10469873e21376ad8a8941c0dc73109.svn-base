package tea.entity.yl.shop;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.entity.*;

public class PColor
{
    protected static Cache c = new Cache(50);
    public static final String[] PCOLOR_TYPE =
            {"---", "军绿色", "天蓝色", "巧克力色", "桔色", "浅灰色", "浅绿色", "浅黄色", "深卡其布色", "深灰色", "深紫色", "深蓝色", "白色", "粉红色", "紫罗兰", "紫色", "红色", "绿色", "花色", "蓝色", "褐色", "透明", "酒红色", "黄色", "黑色"};
    public static final String[] PCOLOR_VALUE =
            {"---", "#5d762a", "#1eddff", "#d2691e", "#ffa500", "#e4e4e4", "#98fb98", "#ffffb1", "#bdb76b", "#666666", "#4b0082", "#041690", "#ffffff", "#ffb6c1", "#dda0dd", "#800080", "#ff0000", "#008000", "url(/tea/image/color-bg.gif)", "#0000ff", "#855b00", "url(/tea/image/color-bg.gif);background-position:0 -20px;", "#990000", "#ffff00", "#000000"};
    public int product;
    public int sequence;
    public String name;
    public String picture;

    public PColor(int product, int sequence)
    {
        this.product = product;
        this.sequence = sequence;
    }

    public static PColor find(int product, int sequence) throws SQLException
    {
        PColor t = (PColor) c.get(product + ":" + sequence);
        if (t == null)
        {
            ArrayList al = find(" AND product=" + product + " AND sequence=" + sequence, 0, 1);
            t = al.size() < 1 ? new PColor(product, sequence) : (PColor) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT product,sequence,name,picture FROM pcolor WHERE 1=1" + sql, pos, size);
            while (rs.next())
            {
                int i = 1;
                PColor t = new PColor(rs.getInt(i++), rs.getInt(i++));
                t.name = rs.getString(i++);
                t.picture = rs.getString(i++);
                c.put(t.product + ":" + t.sequence, t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM pcolor WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int i = db.executeUpdate("INSERT INTO pcolor(product,sequence,name,picture)VALUES(" + product + "," + sequence + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(picture) + ")");
            if (i < 1)
            {
                db.executeUpdate("UPDATE pcolor SET name=" + DbAdapter.cite(name) + ",picture=" + DbAdapter.cite(picture) + " WHERE product=" + product + " AND sequence=" + sequence);
            }
        } finally
        {
            db.close();
        }
        c.remove(product);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(product, "DELETE FROM pcolor WHERE product=" + product);
        } finally
        {
            db.close();
        }
        c.remove(product);
    }

    public void set(String f, String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(product, "UPDATE pcolor SET " + f + "=" + DbAdapter.cite(v) + " WHERE product=" + product);
        } finally
        {
            db.close();
        }
        c.remove(product);
    }

    //
    public static ArrayList findByProduct(int product) throws SQLException
    {
        return find(" AND product=" + product, 0, 200);
    }

    public String getName(int lang)
    {
        return MT.f(name, PColor.PCOLOR_TYPE[sequence]);
    }
}
