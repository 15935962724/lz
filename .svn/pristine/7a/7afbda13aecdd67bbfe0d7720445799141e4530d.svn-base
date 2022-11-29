package tea.entity.weibo;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import org.json.*;

public class WUser
{
    protected static Cache c = new Cache(50);
    public String userid; //用户ID
    public String name; //姓名
    public int type; //类型
    public String nick; //用户昵称
    public int sex; //性别
    public String avatar; //头像
    public Date birth; //生日
    public int country; //国家id
    public int province; //地区id
    public int city; //城市id
    public String location; //位置
    public String description; //介绍
    public long microid; //微博
    public String content; //内容
    public Date time; //时间
    public int following; //关注数
    public int follower; //粉丝数
    public int talk; //微博数
    public int favorite; //收藏数
    public int verified; //加V标示     200:初级达人 220:中高达人
    public boolean isfollowing; //关注
    public boolean isfollower; //听众
    public boolean exists;
    public WUser(String userid)
    {
        this.userid = userid;
    }

    public static WUser find(String userid) throws SQLException
    {
        WUser t = (WUser) c.get(userid);
        if (t == null)
        {
            ArrayList al = find(" AND userid=" + DbAdapter.cite(userid), 0, 1);
            t = al.size() < 1 ? new WUser(userid) : (WUser) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT userid,name,type,nick,sex,avatar,birth,country,province,city,location,description,microid,content,time,following,follower,talk,favorite,verified,isfollowing,isfollower FROM wuser WHERE 1=1" + sql, pos, size);
            while (rs.next())
            {
                int i = 1;
                WUser t = new WUser(rs.getString(i++));
                t.name = rs.getString(i++);
                t.type = rs.getInt(i++);
                t.nick = rs.getString(i++);
                t.sex = rs.getInt(i++);
                t.avatar = rs.getString(i++);
                t.birth = db.getDate(i++);
                t.country = rs.getInt(i++);
                t.province = rs.getInt(i++);
                t.city = rs.getInt(i++);
                t.location = rs.getString(i++);
                t.description = rs.getString(i++);
                t.microid = rs.getInt(i++);
                t.content = rs.getString(i++);
                t.time = db.getDate(i++);
                t.following = rs.getInt(i++);
                t.follower = rs.getInt(i++);
                t.talk = rs.getInt(i++);
                t.favorite = rs.getInt(i++);
                t.verified = rs.getInt(i++);
                t.isfollowing = rs.getBoolean(i++);
                t.isfollower = rs.getBoolean(i++);
                t.exists = true;
                c.put(t.userid, t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM wuser WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if (exists)
                db.executeUpdate("UPDATE wuser SET userid=" + DbAdapter.cite(userid) + ",name=" + DbAdapter.cite(name) + ",type=" + type + ",nick=" + DbAdapter.cite(nick) + ",sex=" + sex + ",avatar=" + DbAdapter.cite(avatar) + ",birth=" + DbAdapter.cite(birth) + ",country=" + country + ",province=" + province + ",city=" + city + ",location=" + DbAdapter.cite(location) + ",description=" + DbAdapter.cite(description) + ",microid=" + microid + ",content=" + DbAdapter.cite(content) + ",time=" + DbAdapter.cite(time) + ",following=" + following + ",follower=" + follower + ",talk=" + talk + ",favorite=" + favorite + ",verified=" + verified + ",isfollowing=" + DbAdapter.cite(isfollowing) + ",isfollower=" + DbAdapter.cite(isfollower) + " WHERE userid=" + DbAdapter.cite(userid));
            else
                db.executeUpdate("INSERT INTO wuser(userid,name,type,nick,sex,avatar,birth,country,province,city,location,description,microid,content,time,following,follower,talk,favorite,verified,isfollowing,isfollower)VALUES(" + DbAdapter.cite(userid) + "," + DbAdapter.cite(name) + "," + type + "," + DbAdapter.cite(nick) + "," + sex + "," + DbAdapter.cite(avatar) + "," + DbAdapter.cite(birth) + "," + country + "," + province + "," + city + "," + DbAdapter.cite(location) + "," + DbAdapter.cite(description) + "," + microid + "," + DbAdapter.cite(content) + "," + DbAdapter.cite(time) + "," + following + "," + follower + "," + talk + "," + favorite + "," + verified + "," + DbAdapter.cite(isfollowing) + "," + DbAdapter.cite(isfollower) + ")");
        } finally
        {
            db.close();
        }
        c.remove(userid);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM wuser WHERE userid=" + DbAdapter.cite(userid));
        c.remove(userid);
    }

    public void set(String f, String v) throws SQLException
    {
        DbAdapter.execute("UPDATE wuser SET " + f + "=" + DbAdapter.cite(v) + " WHERE userid=" + DbAdapter.cite(userid));
        c.remove(userid);
    }

    //
    public String getName()
    {
        String str = "<a href='http://weibo.com/" + userid + "'>" + nick + "</a>";
        if (",0,2,10,220,".contains("," + verified + ","))
            str += "<img src='/tea/image/weibo/v" + verified + ".png' />";
        return str;
    }

    public static int f(String sex)
    {
        if ("n".equals(sex))
            return 0;
        else if ("f".equals(sex))
            return 2;
        else
            return 1;
    }

    //
    public static String create(JSONObject o, boolean detail) throws JSONException, SQLException
    {
        WUser f;
        if (1 == 1)
        {
            f = WUser.find(String.valueOf(o.getLong("id")));
            f.sex = f(o.getString("gender"));
            f.name = o.getString("domain");
            f.nick = o.getString("name");
            f.avatar = o.getString("profile_image_url");
            //if (avatar.charAt(avatar.length() - 4) == '/')
            //    avatar = null;
            f.location = o.getString("location");
            f.description = o.getString("description");
            f.following = o.getInt("friends_count");
            f.follower = o.getInt("followers_count");
            f.talk = o.getInt("statuses_count");
            f.favorite = o.getInt("favourites_count");
            f.verified = o.getInt("verified_type");
            f.province = o.getInt("province");
            f.city = o.getInt("city");
            f.isfollowing = o.getBoolean("following");
            f.isfollower = o.getBoolean("follow_me");
            if (!o.isNull("status"))
            {
                o = o.getJSONObject("status");
                f.microid = o.getLong("id");
                f.content = o.getString("text");
                f.time = new Date(o.getString("created_at"));
            } else if (!o.isNull("status_id")) //最后一次发表的微博ID
            {
                f.microid = o.getLong("status_id");
            }
            //			if (detail && !a.userid.equals(f.userid))
            //			{
            //				JSONObject fr = new JSONObject(Common.oauth("http://api.t.sina.com.cn/friendships/show.json?target_id=" + f.userid, false, null));
            //				fr = fr.getJSONObject("data");
            //				fr = fr.getJSONObject("source");
            //				f.isfollowing = fr.getBoolean("following");
            //				f.isfollower = fr.getBoolean("followed_by");
            //			}
        } else
        {
            f = WUser.find(o.getString("name"));
            f.name = f.userid;
            f.nick = o.getString("nick");
            f.avatar = o.getString("head"); // "http://mat1.gtimg.com/www/mb/images/head_50.jpg"
            if (f.avatar.length() > 0)
                f.avatar += "/50";
            f.location = o.getString("location");
            f.verified = o.getInt("isvip");
            //
            if (!o.isNull("isidol"))
            {
                f.following = o.getInt("idolnum");
                f.follower = o.getInt("fansnum");
                f.isfollowing = o.getBoolean("isidol");
            } else if (!o.isNull("sex"))
            {
                f.sex = o.getInt("sex");
                Calendar c = Calendar.getInstance();
                c.set(Calendar.YEAR, o.getInt("birth_year"));
                c.set(Calendar.MONTH, o.getInt("birth_month") - 1);
                c.set(Calendar.DAY_OF_MONTH, o.getInt("birth_day"));
                f.birth = c.getTime();
                // f.birth = new Date(o.getInt("birth_year"), o.getInt("birth_month"), o.getInt("birth_day")).getTime();
                // System.out.println(f.name + "：" + f.birth + " : " + Common.f(new Date(o.getInt("birth_year"), o.getInt("birth_month"), o.getInt("birth_day")), 0));
                f.description = o.getString("introduction");
                if ("".equals(f.description))
                    f.description = null;
                f.following = o.getInt("idolnum");
                f.follower = o.getInt("fansnum");
                f.talk = o.getInt("tweetnum");
                //
                f.isfollowing = o.getInt("ismyidol") != 0;
                f.isfollower = o.getInt("ismyfans") != 0;
                // ismyblack 黑名单
            }
            // 最新微博
            if (!o.isNull("tweet"))
            {
                o = o.getJSONArray("tweet").getJSONObject(0);
                f.microid = o.getLong("id");
                f.content = o.getString("text");
                f.time = new Date(o.getLong("timestamp") * 1000);
            } else if (detail)
            {
//                String aa = OAuth.oauth("http://open.t.qq.com/api/statuses/user_timeline?format=json&name=" + f.userid + "&type=3&reqnum=1", false, null);
//                o = new JSONObject(aa);
//                if (!o.isNull("data")) // 没有发布过微博,此处是null
//                {
//                    o = o.getJSONObject("data").getJSONArray("info").getJSONObject(0);
//                    f.microid = o.getLong("id");
//                    f.content = o.getString("origtext");
//                    f.time = o.getLong("timestamp") * 1000;
//                    Micro.create(o, false);
//                }
            }
        }
        f.set();
        return f.userid;
    }


}
