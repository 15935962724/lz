package tea.entity.weibo;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import org.json.*;

public class WComment
{
    protected static Cache c = new Cache(50);
    public long commentid; //评论ID
    public String userid; //用户ID
    public long microid; //微博ID
    public long replyid; //被回复的评论
    public String content; //评论内容
    public String source; //评论来源
    public int at; //提到的好友数
    public int deleted; //是否已删除 0:正常 1:暂时删除 2:删除
    public Date time; //评论时间
    public boolean exists;
    public WComment(long commentid)
    {
        this.commentid = commentid;
    }

    public static WComment find(long commentid) throws SQLException
    {
        WComment t = (WComment) c.get(commentid);
        if (t == null)
        {
            ArrayList al = find(" AND commentid=" + commentid, 0, 1);
            t = al.size() < 1 ? new WComment(commentid) : (WComment) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT commentid,userid,microid,replyid,content,source,at,deleted,time FROM wcomment WHERE 1=1" + sql, pos, size);
            while (rs.next())
            {
                int i = 1;
                WComment t = new WComment(rs.getLong(i++));
                t.userid = rs.getString(i++);
                t.microid = rs.getLong(i++);
                t.replyid = rs.getLong(i++);
                t.content = rs.getString(i++);
                t.source = rs.getString(i++);
                t.at = rs.getInt(i++);
                t.deleted = rs.getInt(i++);
                t.time = db.getDate(i++);
                t.exists = true;
                c.put(t.commentid, t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM wcomment WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if (exists)
                db.executeUpdate("UPDATE wcomment SET userid=" + DbAdapter.cite(userid) + ",microid=" + microid + ",replyid=" + replyid + ",content=" + DbAdapter.cite(content) + ",source=" + DbAdapter.cite(source) + ",at=" + at + ",deleted=" + deleted + ",time=" + DbAdapter.cite(time) + " WHERE commentid=" + commentid);
            else
                db.executeUpdate("INSERT INTO wcomment(commentid,userid,microid,replyid,content,source,at,deleted,time)VALUES(" + commentid + "," + DbAdapter.cite(userid) + "," + microid + "," + replyid + "," + DbAdapter.cite(content) + "," + DbAdapter.cite(source) + "," + at + "," + deleted + "," + DbAdapter.cite(time) + ")");
        } finally
        {
            db.close();
        }
        c.remove(commentid);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM wcomment WHERE commentid=" + commentid);
        c.remove(commentid);
    }

    public void set(String f, String v) throws SQLException
    {
        DbAdapter.execute("UPDATE wcomment SET " + f + "=" + DbAdapter.cite(v) + " WHERE commentid=" + commentid);
        c.remove(commentid);
    }

    //
    public String getContent()
    {
        return OAuth.a(OAuth.face(content), null);
    }

    public static long create(JSONObject o) throws JSONException, SQLException
    {
        WComment t = WComment.find(o.getLong("id"));
        //t.microid = microid;
        if (1 == 1)
        {
            t.content = o.getString("text");
            t.source = o.getString("source").replaceAll("<[^>]+>", "");
            t.at = t.content.split("@+").length - 1;
            t.time = new Date(o.getString("created_at"));
            if (!o.isNull("reply_comment"))
            {
                t.replyid = o.getJSONObject("reply_comment").getLong("id");
                t.at--;
            }
            t.microid = o.getJSONObject("status").getLong("id");
            o = o.getJSONObject("user");
            //o.getJSONObject("status")//返回的reposts_count和comments_count不正确，总是0。
        } else
        {
            t.content = o.getString("origtext");
            t.source = o.getString("from");
            t.time = new Date(o.getLong("timestamp") * 1000);
        }
        t.userid = WUser.create(o, false);
        t.set();
        return t.commentid;
    }

    public static void ref_delete(WConfig wc) throws SQLException, JSONException
    {
        long last = 0;
        while (true)
        {
            StringBuilder sb = new StringBuilder();
            Iterator it = WComment.find(" AND commentid>" + last + " ORDER BY commentid", 0, 50).iterator();
            if (!it.hasNext())
                break;
            while (it.hasNext())
            {
                WComment t = (WComment) it.next();
                if (sb.length() > 0)
                    sb.append(",");
                sb.append(last = t.commentid);
            }
            ref_delete(wc, sb.toString());
            try
            {
                Thread.sleep(5000);
            } catch (InterruptedException ex)
            {
            }
        }
    }

    public static void ref_delete(WConfig wc, String ids) throws SQLException, JSONException
    {
        StringBuilder sb = new StringBuilder();
        JSONObject o = new JSONObject(OAuth2.oauth("https://api.weibo.com/2/comments/show_batch.json?cids=" + ids, null, null, wc.sinatoken));
        //账号异常，此处也不返数据！
        JSONArray arr = o.getJSONArray("data");
        for (int i = 0; i < arr.length(); i++)
        {
            sb.append(create(arr.getJSONObject(i))).append(",");
        }
        DbAdapter db = new DbAdapter();
        try
        {
            int i = db.executeUpdate("UPDATE wcomment SET deleted=0 WHERE commentid IN(" + ids + ") AND deleted=2");
            System.out.println("恢复评论：" + i + "条！");
            int j = db.executeUpdate("UPDATE wcomment SET deleted=2 WHERE commentid IN(" + ids + ") AND commentid NOT IN(" + sb.toString() + "0)");
            System.out.println("删除评论：" + j + "条！");
        } finally
        {
            db.close();
        }
    }

}
