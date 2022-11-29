package tea.entity.yl.shop;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.entity.*;

public class Keywords
{
    protected static Cache c = new Cache(50);
    public String keywords; //搜索关键字
    public int category; //分类
    public int quantity; //结果数量
    public int hits; //搜索次数
    public int stype; //搜索类型

    public Keywords(String keywords)
    {
        this.keywords = keywords;
    }

    public static Keywords find(String keywords) throws SQLException
    {
        Keywords t = (Keywords) c.get(keywords);
        if (t == null)
        {
            ArrayList al = find(" AND keywords=" + DbAdapter.cite(keywords), 0, 1);
            t = al.size() < 1 ? new Keywords(keywords) : (Keywords) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT keywords,category,quantity,hits,stype FROM keywords WHERE 1=1" + sql, pos, size);
            while (rs.next())
            {
                int i = 1;
                Keywords t = new Keywords(rs.getString(i++));
                t.category = rs.getInt(i++);
                t.quantity = rs.getInt(i++);
                t.hits = rs.getInt(i++);
                t.stype = rs.getInt(i++);
                c.put(t.keywords, t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM keywords WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if (hits == 1)
                db.executeUpdate("INSERT INTO keywords(keywords,category,quantity,hits,stype)VALUES(" + DbAdapter.cite(keywords) + "," + category + "," + quantity + "," + hits + "," + stype + ")");
            else
                db.executeUpdate("UPDATE keywords SET category=" + category + ",quantity=" + quantity + ",hits=" + hits + ",stype=" + stype + " WHERE keywords=" + DbAdapter.cite(keywords));
        } finally
        {
            db.close();
        }
        c.remove(keywords);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(0, "DELETE FROM keywords WHERE keywords=" + DbAdapter.cite(keywords));
        } finally
        {
            db.close();
        }
        c.remove(keywords);
    }

    public void set(String f, String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(0, "UPDATE keywords SET " + f + "=" + DbAdapter.cite(v) + " WHERE keywords=" + DbAdapter.cite(keywords));
        } finally
        {
            db.close();
        }
        c.remove(keywords);
    }
}
