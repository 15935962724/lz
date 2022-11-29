package tea.entity.weibo;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import org.json.*;

public class WMicro
{
    protected static Cache c = new Cache(50);
    public long microid; //微博ID
    public String userid; //微博的用户ID
    public String content; //内容
    public String pic; //图片
    public Date time; //时间
    public String source; //来源
    public long quoteid; //转发的微博ID
    public int reposts; //转发数
    public int comments; //评论数
    public int at; //提到的好友数
    public boolean favorited; //是否收藏
    public boolean mention; //提到我的
    public int deleted; //是否已删除 0:正常 1:暂时删除 2:删除
    public boolean exists;
    public WMicro(long microid)
    {
        this.microid = microid;
    }

    public static WMicro find(long microid) throws SQLException
    {
        WMicro t = (WMicro) c.get(microid);
        if (t == null)
        {
            ArrayList al = find(" AND microid=" + microid, 0, 1);
            t = al.size() < 1 ? new WMicro(microid) : (WMicro) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT microid,userid,content,pic,time,source,quoteid,reposts,comments,at,favorited,mention,deleted FROM wmicro WHERE 1=1" + sql, pos, size);
            while (rs.next())
            {
                int i = 1;
                WMicro t = new WMicro(rs.getLong(i++));
                t.userid = rs.getString(i++);
                t.content = rs.getString(i++);
                t.pic = rs.getString(i++);
                t.time = db.getDate(i++);
                t.source = rs.getString(i++);
                t.quoteid = rs.getLong(i++);
                t.reposts = rs.getInt(i++);
                t.comments = rs.getInt(i++);
                t.at = rs.getInt(i++);
                t.favorited = rs.getBoolean(i++);
                t.mention = rs.getBoolean(i++);
                t.deleted = rs.getInt(i++);
                t.exists = true;
                c.put(t.microid, t);
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
        System.out.println("SELECT COUNT(*) FROM wmicro WHERE 1=1" + sql);
        return DbAdapter.execute("SELECT COUNT(*) FROM wmicro WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if (exists)
                db.executeUpdate("UPDATE wmicro SET userid=" + DbAdapter.cite(userid) + ",content=" + DbAdapter.cite(content) + ",pic=" + DbAdapter.cite(pic) + ",time=" + DbAdapter.cite(time) + ",source=" + DbAdapter.cite(source) + ",quoteid=" + quoteid + ",reposts=" + reposts + ",comments=" + comments + ",at=" + at + ",favorited=" + DbAdapter.cite(favorited) + ",mention=" + DbAdapter.cite(mention) + ",deleted=" + deleted + " WHERE microid=" + microid);
            else
                db.executeUpdate("INSERT INTO wmicro(microid,userid,content,pic,time,source,quoteid,reposts,comments,at,favorited,mention,deleted)VALUES(" + microid + "," + DbAdapter.cite(userid) + "," + DbAdapter.cite(content) + "," + DbAdapter.cite(pic) + "," + DbAdapter.cite(time) + "," + DbAdapter.cite(source) + "," + quoteid + "," + reposts + "," + comments + "," + at + "," + DbAdapter.cite(favorited) + "," + DbAdapter.cite(mention) + "," + deleted + ")");
        } finally
        {
            db.close();
        }
        c.remove(microid);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM wmicro WHERE microid=" + microid);
        c.remove(microid);
    }

    public void set(String f, String v) throws SQLException
    {
        DbAdapter.execute("UPDATE wmicro SET " + f + "=" + DbAdapter.cite(v) + " WHERE microid=" + microid);
        c.remove(microid);
    }

    //
    public String getContent()
    {
        return OAuth.a(OAuth.face(content), null);
    }

    // mention:只有"@提到我的"，才为true
    public static WMicro create(JSONObject o, boolean mention) throws JSONException, SQLException
    {
        WMicro t = WMicro.find(o.getLong("id"));
        if (mention)
            t.mention = mention;

        if (1 == 1)
        {
            if (!o.isNull("favorited")) //我的收藏,微博处于删除状态下，也存在此数据.
                t.favorited = o.getBoolean("favorited");
            if (o.isNull("deleted"))
            {
                t.content = o.getString("text");
                t.source = o.getString("source").replaceAll("<[^>]+>", "");
                t.time = new Date(o.getString("created_at"));
                if (!o.isNull("thumbnail_pic"))
                    t.pic = o.getString("thumbnail_pic");
                t.reposts = o.getInt("reposts_count");
                t.comments = o.getInt("comments_count");
                t.at = t.content.split("@+").length - 1;
                // 用户
                t.userid = WUser.create(o.getJSONObject("user"), false);
                // 转发
                if (!o.isNull("retweeted_status"))
                    t.quoteid = WMicro.create(o.getJSONObject("retweeted_status"), false).microid;
                t.deleted = 0;
            } else
            {
                //抱歉，您当前访问的帐号异常，暂时无法访问。 会导致此人的所有微博"暂时"被删除！
                t.deleted = 1;
            }
        } else if (1 == 2)
        {
            t.content = o.getString("origtext").replaceAll("&amp;", "&");
            t.source = o.getString("from");
            t.time = new Date(o.getLong("timestamp") * 1000);
            if (!o.isNull("image"))
                t.pic = o.getJSONArray("image").getString(0) + "/160";
            // 用户
            t.userid = WUser.create(o, false);
            //
            t.reposts = o.getInt("count");
            t.comments = o.getInt("mcount");
            // 转发
            if (!o.isNull("source"))
            {
                o = o.getJSONObject("source");
//                t.quserid = WUser.create(o, false);
//                t.qcontent = o.getString("origtext");
//                if (!o.isNull("image"))
//                    t.qpic = o.getJSONArray("image").getString(0) + "/160";
            }
        }
        t.set();
        return t;
    }


    public void ref_reposts(WConfig wc) throws SQLException, JSONException
    {
        long next = 0L;
        do
        {
            JSONObject o = new JSONObject(OAuth2.oauth("https://api.weibo.com/2/statuses/repost_timeline.json?count=50&id=" + microid + "&max_id=" + next, null, null, wc.sinatoken));
            JSONArray arr;
            if (o.isNull("data"))
                arr = new JSONArray();
            else
            {
                o = o.getJSONObject("data");
                //total = o.getInt("total_number");
                next = o.getLong("next_cursor");
                arr = o.getJSONArray(1 == 1 ? "reposts" : "info");
            }
            System.out.println(microid + "　转发条数：" + arr.length());
            for (int i = 0; i < arr.length(); i++)
            {
                WMicro.create(arr.getJSONObject(i), false);
            }
        } while (next > 0 && !WMicro.find(next).exists);
    }

    public void ref_comments(WConfig wc) throws SQLException, JSONException
    {
        long next = 0L;
        do
        {
            JSONObject o = new JSONObject(OAuth2.oauth("https://api.weibo.com/2/comments/show.json?count=50&id=" + microid + "&max_id=" + next, null, null, wc.sinatoken));
            JSONArray arr;
            if (o.isNull("data"))
                arr = new JSONArray();
            else
            {
                o = o.getJSONObject("data");
                //total = o.getInt("total_number");
                next = o.getLong("next_cursor");
                arr = o.getJSONArray(1 == 1 ? "comments" : "info");
            }
            System.out.println(microid + "　评论条数：" + arr.length());
            for (int i = 0; i < arr.length(); i++)
            {
                WComment.create(arr.getJSONObject(i));
            }
        } while (next > 0 && !WComment.find(next).exists);
    }

    public void ref_delete(WConfig wc) throws SQLException, JSONException
    {
        JSONObject o = new JSONObject(OAuth2.oauth("https://api.weibo.com/2/statuses/show.json?id=" + microid, null, null, wc.sinatoken));
        if (o.getInt("error_code") == 20101)
        {
            set("deleted", String.valueOf(deleted = 2));
        } else
        {
            create(o.getJSONObject("data"), false);
        }
    }
}
