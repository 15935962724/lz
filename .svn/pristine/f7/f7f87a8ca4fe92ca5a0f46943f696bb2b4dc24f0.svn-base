package tea.entity.yl.shop;

import java.util.*;
import java.sql.SQLException;
import tea.db.DbAdapter;
import tea.entity.*;

public class ShopOrigin
{
    protected static Cache c = new Cache(50);
    public int origin; //商品产地
    public String[] name = new String[2];
    public int hits;

    public ShopOrigin(int origin)
    {
        this.origin = origin;
    }

    public static ShopOrigin find(int origin) throws SQLException
    {
        ShopOrigin t = (ShopOrigin) c.get(origin);
        if (t == null)
        {
            ArrayList al = find(" AND origin=" + origin, 0, 1);
            t = al.size() < 1 ? new ShopOrigin(origin) : (ShopOrigin) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT origin,name0,name1,hits FROM shoporigin WHERE 1=1" + sql, pos, size);
            while (rs.next())
            {
                int i = 1;
                ShopOrigin t = new ShopOrigin(rs.getInt(i++));
                t.name[0] = rs.getString(i++);
                t.name[1] = rs.getString(i++);
                t.hits = rs.getInt(i++);
                c.put(t.origin, t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM shoporigin WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if (origin < 1)
            sql = "INSERT INTO shoporigin(origin,name0,name1,hits)VALUES(" + (origin = Seq.get()) + "," + DbAdapter.cite(name[0]) + "," + DbAdapter.cite(name[1]) + "," + hits + ")";
        else
            sql = "UPDATE shoporigin SET name0=" + DbAdapter.cite(name[0]) + ",name1=" + DbAdapter.cite(name[1]) + ",hits=" + hits + " WHERE origin=" + origin;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(origin, sql);
        } finally
        {
            db.close();
        }
        c.remove(origin);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(origin, "DELETE FROM shoporigin WHERE origin=" + origin);
        } finally
        {
            db.close();
        }
        c.remove(origin);
    }

    public void set(String f, String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(origin, "UPDATE shoporigin SET " + f + "=" + DbAdapter.cite(v) + " WHERE origin=" + origin);
        } finally
        {
            db.close();
        }
        c.remove(origin);
    }
    //

}
