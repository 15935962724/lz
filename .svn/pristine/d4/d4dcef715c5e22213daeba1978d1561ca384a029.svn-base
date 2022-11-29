package tea.entity.node;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.entity.*;
import tea.db.*;

public class NReview
{
    protected static Cache c = new Cache(50);
    public int review;
    public int node; //商品
    public int member; //用户
    public String title; //标题
    public int score = 5; //评分
    public String content; //使用心得
    public String advantages; //优点
    public String shortcomings; //缺点
    public int good; //顶
    public int poor; //踩
    public static String[] STATE_TYPE =
            {"-----","未处理","批准","拒绝"};
    public int state; //状态
    public Date time; //时间

    public NReview(int review)
    {
        this.review = review;
    }

    public static NReview find(int review) throws SQLException
    {
        NReview t = (NReview) c.get(review);
        if(t == null)
        {
            ArrayList al = find(" AND review=" + review,0,1);
            t = al.size() < 1 ? new NReview(review) : (NReview) al.get(0);
        }
        return t;
    }

    public static ArrayList findByProduct(int node,int pos,int size) throws SQLException
    {
        return find(" AND node=" + node + " AND state=1",pos,size);
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT review,node,member,title,score,content,advantages,shortcomings,good,poor,state,time FROM nreview WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                NReview t = new NReview(rs.getInt(i++));
                t.node = rs.getInt(i++);
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
                c.put(t.review,t);
                al.add(t);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }

    public static int countByProduct(int node) throws SQLException
    {
        return count(" AND node=" + node + " AND state=1");
    }

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM nreview WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if(review < 1)
                db.executeUpdate("INSERT INTO nreview(node,member,title,score,content,advantages,shortcomings,good,poor,state,time)VALUES(" + node + "," + member + "," + DbAdapter.cite(title) + "," + score + "," + DbAdapter.cite(content) + "," + DbAdapter.cite(advantages) + "," + DbAdapter.cite(shortcomings) + "," + good + "," + poor + "," + state + "," + DbAdapter.cite(time) + ")");
            else
                db.executeUpdate("UPDATE nreview SET node=" + node + ",member=" + member + ",title=" + DbAdapter.cite(title) + ",score=" + score + ",content=" + DbAdapter.cite(content) + ",advantages=" + DbAdapter.cite(advantages) + ",shortcomings=" + DbAdapter.cite(shortcomings) + ",good=" + good + ",poor=" + poor + ",state=" + state + ",time=" + DbAdapter.cite(time) + " WHERE review=" + review);
        } finally
        {
            db.close();
        }
        c.remove(review);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM nreview WHERE review=" + review);
        c.remove(review);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE nreview SET " + f + "=" + DbAdapter.cite(v) + " WHERE review=" + review);
        c.remove(review);
    }

    //
    public static NReview find(int node,int member) throws SQLException
    {
        Iterator it = NReview.find(" AND node=" + node + " AND member=" + member,0,1).iterator();
        return it.hasNext() ? (NReview) it.next() : new NReview(0);
    }

    public static int[] stat(int node) throws SQLException
    {
        int[] arr = new int[6];
        arr[0] = NReview.countByProduct(node);
        if(arr[0] > 0)
            for(int i = 1;i < 6;i++)
            {
                arr[i] = NReview.count(" AND node=" + node + " AND state=1 AND score=" + i);
            }
        return arr;
    }
}
