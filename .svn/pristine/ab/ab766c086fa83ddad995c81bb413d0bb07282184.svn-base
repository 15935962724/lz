package tea.entity.lvyou;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class LvyouWconfig
{
    protected static Cache c = new Cache(50);
    public String community; //微博的相关的配置
    public String sinaid; //新浪账号
    public String sinakey; //App key
    public String sinasecret; //App Secret
    public String qqid; //腾讯账号
    public String qqkey; //App key
    public String qqsecret; //App Secret
    public boolean login; //是否允许登录/注册

    public LvyouWconfig(String community)
    {
        this.community = community;
    }

    public static LvyouWconfig find(String community) throws SQLException
    {
        LvyouWconfig t = (LvyouWconfig) c.get(community);
        if(t == null)
        {
            ArrayList al = find(" AND community=" + DbAdapter.cite(community),0,1);
            t = al.size() < 1 ? new LvyouWconfig(community) : (LvyouWconfig) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT community,sinaid,sinakey,sinasecret,qqid,qqkey,qqsecret,login FROM lvyouwconfig WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                LvyouWconfig t = new LvyouWconfig(rs.getString(i++));
                t.sinaid = rs.getString(i++);
                t.sinakey = rs.getString(i++);
                t.sinasecret = rs.getString(i++);
                t.qqid = rs.getString(i++);
                t.qqkey = rs.getString(i++);
                t.qqsecret = rs.getString(i++);
                t.login = rs.getBoolean(i++);
                c.put(t.community,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM lvyouwconfig WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int i = db.executeUpdate("UPDATE lvyouwconfig SET sinaid=" + DbAdapter.cite(sinaid) + ",sinakey=" + DbAdapter.cite(sinakey) + ",sinasecret=" + DbAdapter.cite(sinasecret) + ",qqid=" + DbAdapter.cite(qqid) + ",qqkey=" + DbAdapter.cite(qqkey) + ",qqsecret=" + DbAdapter.cite(qqsecret) + ",login=" + DbAdapter.cite(login) + " WHERE community=" + DbAdapter.cite(community));
            if(i < 1)
            {
                db.executeUpdate("INSERT INTO lvyouwconfig(community,sinaid,sinakey,sinasecret,qqid,qqkey,qqsecret,login)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(sinaid) + "," + DbAdapter.cite(sinakey) + "," + DbAdapter.cite(sinasecret) + "," + DbAdapter.cite(qqid) + "," + DbAdapter.cite(qqkey) + "," + DbAdapter.cite(qqsecret) + "," + DbAdapter.cite(login) + ")");
            }
        } finally
        {
            db.close();
        }
        c.remove(community);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM lvyouwconfig WHERE community=" + DbAdapter.cite(community));
        c.remove(community);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE lvyouwconfig SET " + f + "=" + DbAdapter.cite(v) + " WHERE community=" + DbAdapter.cite(community));
        c.remove(community);
    }
}
