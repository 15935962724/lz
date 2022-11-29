package tea.entity.yl.shop;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.entity.*;

public class Repay
{
    protected static Cache c = new Cache(50);
    public int repay; //评论的回复
    public int review; //评论
    public int member; //用户
    public String content; //内容
    public static String[] STATE_TYPE =
            {"默认", "批准", "拒绝"};
    public int state; //状态
    public Date time; //时间

    public Repay(int repay)
    {
        this.repay = repay;
    }

    public static Repay find(int repay) throws SQLException
    {
        Repay t = (Repay) c.get(repay);
        if (t == null)
        {
            ArrayList al = find(" AND repay=" + repay, 0, 1);
            t = al.size() < 1 ? new Repay(repay) : (Repay) al.get(0);
        }
        return t;
    }

    public static Iterator findByReview(int review) throws SQLException
    {
        return find(" AND review=" + review, 0, 100).iterator();
    }

    public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT repay,review,member,content,state,time FROM repay WHERE 1=1" + sql, pos, size);
            while (rs.next())
            {
                int i = 1;
                Repay t = new Repay(rs.getInt(i++));
                t.review = rs.getInt(i++);
                t.member = rs.getInt(i++);
                t.content = rs.getString(i++);
                t.state = rs.getInt(i++);
                t.time = db.getDate(i++);
                c.put(t.repay, t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM repay WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if (repay < 1)
            sql = "INSERT INTO repay(repay,review,member,content,state,time)VALUES(" + (repay = Seq.get()) + "," + review + "," + member + "," + DbAdapter.cite(content) + "," + state + "," + DbAdapter.cite(time) + ")";
        else
            sql = "UPDATE repay SET content=" + DbAdapter.cite(content) + ",state=" + state + ",time=" + DbAdapter.cite(time) + " WHERE repay=" + repay;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(repay, sql);
        } finally
        {
            db.close();
        }
        c.remove(repay);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(repay, "DELETE FROM repay WHERE repay=" + repay);
        } finally
        {
            db.close();
        }
        c.remove(repay);
    }

    public void set(String f, String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(repay,"UPDATE repay SET " + f + "=" + DbAdapter.cite(v) + " WHERE repay=" + repay);
        } finally
        {
            db.close();
        }
        c.remove(repay);
    }
}
