package tea.entity.yl.shop;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.entity.*;

public class AValue
{
    protected static Cache c = new Cache(50);
    public int product; //商品
    public int attrib; //属性
    public String[] value = new String[2];

    public AValue(int product, int attrib)
    {
        this.product = product;
        this.attrib = attrib;
    }

    public static AValue find(int product, int attrib) throws SQLException
    {
        AValue t = (AValue) c.get(product + ":" + attrib);
        if (t == null)
        {
            ArrayList al = find(" AND product=" + product + " AND attrib=" + attrib, 0, 1);
            t = al.size() < 1 ? new AValue(product, attrib) : (AValue) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT product,attrib,value0,value1 FROM avalue WHERE 1=1" + sql, pos, size);
            while (rs.next())
            {
                int i = 1;
                AValue t = new AValue(rs.getInt(i++), rs.getInt(i++));
                t.value[0] = rs.getString(i++);
                t.value[1] = rs.getString(i++);
                c.put(t.product + ":" + t.attrib, t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM avalue WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int i = db.executeUpdate("INSERT INTO avalue(product,attrib,value0,value1)VALUES(" + product + "," + attrib + "," + DbAdapter.cite(value[0]) + "," + DbAdapter.cite(value[1]) + ")");
            if (i < 1)
            {
                db.executeUpdate("UPDATE avalue SET product=" + product + ",attrib=" + attrib + ",value0=" + DbAdapter.cite(value[0]) + ",value1=" + DbAdapter.cite(value[1]) + " WHERE product=" + product);
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
            db.executeUpdate(product, "DELETE FROM avalue WHERE product=" + product);
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
            db.executeUpdate(product, "UPDATE avalue SET " + f + "=" + DbAdapter.cite(v) + " WHERE product=" + product);
        } finally
        {
            db.close();
        }
        c.remove(product);
    }
}
