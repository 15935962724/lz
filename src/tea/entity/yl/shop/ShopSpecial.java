package tea.entity.yl.shop;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.entity.*;

public class Special
{
    protected static Cache c = new Cache(50);
    public int special;
    public static String[] SPECIAL_TYPE =
            {"特价商品", "疯狂抢购"};
    public int type; //类型
    public int product; // 特价商品
    public int sequence; //顺序

    public Special(int special)
    {
        this.special = special;
    }

    public static Special find(int special) throws SQLException
    {
        Special t = (Special) c.get(special);
        if (t == null)
        {
            ArrayList al = find(" AND special=" + special, 0, 1);
            t = al.size() < 1 ? new Special(special) : (Special) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT special,type,product,sequence FROM special WHERE 1=1" + sql + " ORDER BY sequence", pos, size);
            while (rs.next())
            {
                int i = 1;
                Special t = new Special(rs.getInt(i++));
                t.type = rs.getInt(i++);
                t.product = rs.getInt(i++);
                t.sequence = rs.getInt(i++);
                c.put(t.special, t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM special WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if (special < 1)
            sql = "INSERT INTO special(special,type,product,sequence)VALUES(" + (special = Seq.get()) + "," + type + "," + product + "," + sequence + ")";
        else
            sql = "UPDATE special SET type=" + type + ",product=" + product + ",sequence=" + sequence + " WHERE special=" + special;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(special, sql);
        } finally
        {
            db.close();
        }
        c.remove(special);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(special, "DELETE FROM special WHERE special=" + special);
        } finally
        {
            db.close();
        }
        c.remove(special);
    }

    public void set(String f, String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(special, "UPDATE special SET " + f + "=" + DbAdapter.cite(v) + " WHERE special=" + special);
        } finally
        {
            db.close();
        }
        c.remove(special);
    }
    //

}
