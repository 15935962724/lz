package tea.entity.yl.shop;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.entity.*;

public class PSize
{
    protected static Cache c = new Cache(50);
    public static final String[] PSIZE_TYPE =
            {"---", "S", "M", "L", "均码", "XXS", "XS", "XL", "XXL", "XXXL", "其它尺码"};
    public int product; //商品
    public int sequence; //顺号
    public String name; //名称

    public PSize(int product, int sequence)
    {
        this.product = product;
        this.sequence = sequence;
    }

    public static PSize find(int product, int sequence) throws SQLException
    {
        PSize t = (PSize) c.get(product + ":" + sequence);
        if (t == null)
        {
            ArrayList al = find(" AND product=" + product + " AND sequence=" + sequence, 0, 1);
            t = al.size() < 1 ? new PSize(product, sequence) : (PSize) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT product,sequence,name FROM psize WHERE 1=1" + sql, pos, size);
            while (rs.next())
            {
                int i = 1;
                PSize t = new PSize(rs.getInt(i++), rs.getInt(i++));
                t.name = rs.getString(i++);
                c.put(t.product, t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM psize WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int i = db.executeUpdate("INSERT INTO psize(product,sequence,name)VALUES(" + product + "," + sequence + "," + DbAdapter.cite(name) + ")");
            if (i < 1)
            {
                db.executeUpdate("UPDATE psize SET product=" + product + ",sequence=" + sequence + ",name=" + DbAdapter.cite(name) + " WHERE product=" + product);
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
            db.executeUpdate(product, "DELETE FROM psize WHERE product=" + product);
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
            db.executeUpdate(product, "UPDATE psize SET " + f + "=" + DbAdapter.cite(v) + " WHERE product=" + product);
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
        return MT.f(name, PSize.PSIZE_TYPE[sequence]);
    }
}
