package tea.entity.yl.shop;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.entity.*;

public class ShopReview
{
    protected static Cache c = new Cache(50);
    public int review;
    public int product; //商品
    public int member; //用户
    public String title; //标题
    public int score = 5; //评分
    public String content; //使用心得
    public String advantages; //优点
    public String shortcomings; //缺点
    public int good; //顶
    public int poor; //踩
    public static String[] STATE_TYPE =
            {"未处理", "批准", "拒绝"};
    public int state; //状态
    public Date time; //时间

    public ShopReview(int review)
    {
        this.review = review;
    }

    public static ShopReview find(int review) throws SQLException
    {
        ShopReview t = (ShopReview) c.get(review);
        if (t == null)
        {
            ArrayList al = find(" AND review=" + review, 0, 1);
            t = al.size() < 1 ? new ShopReview(review) : (ShopReview) al.get(0);
        }
        return t;
    }

    public static ArrayList findByProduct(int product, int pos, int size) throws SQLException
    {
        return find(" AND product=" + product + " AND state=1", pos, size);
    }

    public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT re.review,re.product,re.member,re.title,re.score,re.content,re.advantages,re.shortcomings,re.good,re.poor,re.state,re.time FROM review re" + tab(sql) + " WHERE 1=1" + sql, pos, size);
            while (rs.next())
            {
                int i = 1;
                ShopReview t = new ShopReview(rs.getInt(i++));
                t.product = rs.getInt(i++);
                t.member = rs.getInt(i++);
                t.title = rs.getString(i++);
                t.score = rs.getInt(i++);
                t.content = rs.getString(i++);
                t.advantages = rs.getString(i++);
                t.shortcomings = rs.getString(i++);
                t.good = rs.getInt(i++);
                t.poor = rs.getInt(i++);
                t.state = rs.getInt(i++);
                t.time = db.getDate(i++);
                c.put(t.review, t);
                al.add(t);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }

    public static int countByProduct(int product) throws SQLException
    {
        return count(" AND re.product=" + product + " AND re.state=1");
    }

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM review re" + tab(sql) + " WHERE 1=1" + sql);
    }

    private static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if (sql.contains(" AND m."))
            sb.append(" INNER JOIN Member m ON m.member=re.member");
        return sb.toString();
    }

    public void set() throws SQLException
    {
        String sql;
        if (review < 1)
            sql = "INSERT INTO review(review,product,member,title,score,content,advantages,shortcomings,good,poor,state,time)VALUES(" + (review = Seq.get()) + "," + product + "," + member + "," + DbAdapter.cite(title) + "," + score + "," + DbAdapter.cite(content) + "," + DbAdapter.cite(advantages) + "," + DbAdapter.cite(shortcomings) + "," + good + "," + poor + "," + state + "," + DbAdapter.cite(time) + ")";
        else
            sql = "UPDATE review SET product=" + product + ",member=" + member + ",title=" + DbAdapter.cite(title) + ",score=" + score + ",content=" + DbAdapter.cite(content) + ",advantages=" + DbAdapter.cite(advantages) + ",shortcomings=" + DbAdapter.cite(shortcomings) + ",good=" + good + ",poor=" + poor + ",state=" + state + ",time=" + DbAdapter.cite(time) + " WHERE review=" + review;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(review, sql);
        } finally
        {
            db.close();
        }
        c.remove(review);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(review,"DELETE FROM review WHERE review=" + review);
        } finally
        {
            db.close();
        }
        c.remove(review);
    }

    public void set(String f, String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(review, "UPDATE review SET " + f + "=" + DbAdapter.cite(v) + " WHERE review=" + review);
        } finally
        {
            db.close();
        }
        c.remove(review);
    }

    //
    public static ShopReview find(int product, int member) throws SQLException
    {
        Iterator it = ShopReview.find(" AND product=" + product + " AND member=" + member, 0, 1).iterator();
        return it.hasNext() ? (ShopReview) it.next() : new ShopReview(0);
    }

    public static int[] stat(int product) throws SQLException
    {
        int[] arr = new int[6];
        arr[0] = ShopReview.countByProduct(product);
        if (arr[0] > 0)
            for (int i = 1; i < 6; i++)
            {
                arr[i] = ShopReview.count(" AND product=" + product + " AND state=1 AND score=" + i);
            }
        return arr;
    }
}
