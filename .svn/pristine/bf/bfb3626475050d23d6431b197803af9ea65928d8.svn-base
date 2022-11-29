package tea.entity.yl.shop;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.entity.*;
import java.text.*;

public class Publish
{
    public static final DecimalFormat DF8 = new DecimalFormat("00000000");
    protected static Cache c = new Cache(50);
    public int publish; //发行
    public static String[] TYPE_NAME =
            {"---", "优惠券", "礼品卡"};
    public int type; //类型
    public int member; //发行者
    public int quantity; //数量
    public int scode; //开始编号
    public int ecode; //结束编号
    public Date vtime; //有效期
    public Date time; //日期

    public Publish(int publish)
    {
        this.publish = publish;
    }

    public static Publish find(int publish) throws SQLException
    {
        Publish t = (Publish) c.get(publish);
        if (t == null)
        {
            ArrayList al = find(" AND publish=" + publish, 0, 1);
            t = al.size() < 1 ? new Publish(publish) : (Publish) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT publish,type,member,quantity,scode,ecode,vtime,time FROM publish WHERE 1=1" + sql, pos, size);
            while (rs.next())
            {
                int i = 1;
                Publish t = new Publish(rs.getInt(i++));
                t.type = rs.getInt(i++);
                t.member = rs.getInt(i++);
                t.quantity = rs.getInt(i++);
                t.scode = rs.getInt(i++);
                t.ecode = rs.getInt(i++);
                t.vtime = db.getDate(i++);
                t.time = db.getDate(i++);
                c.put(t.publish, t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM publish WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if (publish < 1)
            sql = "INSERT INTO publish(publish,type,member,quantity,scode,ecode,vtime,time)VALUES(" + (publish = Seq.get()) + "," + type + "," + member + "," + quantity + "," + scode + "," + ecode + "," + DbAdapter.cite(vtime) + "," + DbAdapter.cite(time) + ")";
        else
            sql = "UPDATE publish SET type=" + type + ",member=" + member + ",quantity=" + quantity + ",scode=" + scode + ",ecode=" + ecode + ",vtime=" + DbAdapter.cite(vtime) + ",time=" + DbAdapter.cite(time) + " WHERE publish=" + publish;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(publish, sql);
        } finally
        {
            db.close();
        }
        c.remove(publish);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(publish, "DELETE FROM publish WHERE publish=" + publish);
        } finally
        {
            db.close();
        }
        c.remove(publish);
    }

    public void set(String f, String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(publish, "UPDATE publish SET " + f + "=" + DbAdapter.cite(v) + " WHERE publish=" + publish);
        } finally
        {
            db.close();
        }
        c.remove(publish);
    }
}
