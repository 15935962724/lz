package tea.entity.weibo;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

//微博绑定的账号
public class WAccount
{
    protected static Cache c = new Cache(50);
    public int waccount;
    public int member; //会员ID
    public String userid; //微博账号
    public String name; //用户帐户名
    public static String[] WACCOUNT_TYPE =
            {"---","新浪","腾讯"};
    public int type; //类型
    public String nick; //用户昵称
    public String token; //令牌
    public String secret; //密匙
    public String avatar; //头像
    public int following; //关注数
    public int follower; //粉丝数
    public int micro; //微博数
    public int favorite; //收藏数

    public WAccount(int waccount)
    {
        this.waccount = waccount;
    }

    public static WAccount find(int waccount) throws SQLException
    {
        WAccount t = (WAccount) c.get(waccount);
        if(t == null)
        {
            ArrayList al = find(" AND waccount=" + waccount,0,1);
            t = al.size() < 1 ? new WAccount(waccount) : (WAccount) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT waccount,member,userid,name,type,nick,token,secret,avatar,following,follower,micro,favorite FROM waccount WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                WAccount t = new WAccount(rs.getInt(i++));
                t.member = rs.getInt(i++);
                t.userid = rs.getString(i++);
                t.name = rs.getString(i++);
                t.type = rs.getInt(i++);
                t.nick = rs.getString(i++);
                t.token = rs.getString(i++);
                t.secret = rs.getString(i++);
                t.avatar = rs.getString(i++);
                t.following = rs.getInt(i++);
                t.follower = rs.getInt(i++);
                t.micro = rs.getInt(i++);
                t.favorite = rs.getInt(i++);
                c.put(t.waccount,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM waccount WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if(waccount < 1)
            {
                db.executeUpdate("INSERT INTO waccount(member,userid,name,type,nick,token,secret,avatar,following,follower,micro,favorite)VALUES(" + member + "," + DbAdapter.cite(userid) + "," + DbAdapter.cite(name) + "," + type + "," + DbAdapter.cite(nick) + "," + DbAdapter.cite(token) + "," + DbAdapter.cite(secret) + "," + DbAdapter.cite(avatar) + "," + following + "," + follower + "," + micro + "," + favorite + ")");
                db.executeQuery("SELECT MAX(waccount) FROM waccount WHERE member=" + member);
                waccount = db.next() ? db.getInt(1) : 0;
            } else
            {
                db.executeUpdate("UPDATE waccount SET name=" + DbAdapter.cite(name) + ",nick=" + DbAdapter.cite(nick) + ",token=" + DbAdapter.cite(token) + ",secret=" + DbAdapter.cite(secret) + ",avatar=" + DbAdapter.cite(avatar) + ",following=" + following + ",follower=" + follower + ",micro=" + micro + ",favorite=" + favorite + " WHERE userid=" + DbAdapter.cite(userid) + " AND type=" + type);
            }
        } finally
        {
            db.close();
        }
        c.remove(waccount);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM waccount WHERE waccount=" + waccount);
        c.remove(waccount);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE waccount SET " + f + "=" + DbAdapter.cite(v) + " WHERE waccount=" + waccount);
        c.remove(waccount);
    }
}
