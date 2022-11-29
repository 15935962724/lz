package tea.entity.weixin;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class WxGroup
{
    protected static Cache c = new Cache(50);
    public String community; //社区
    public int wxgroup; //组ID
    public String name; //名称
    public int cnt; //成员数量
    public boolean deleted; //是否已删除
    public Date time; //时间

    public WxGroup(String community,int wxgroup)
    {
        this.community = community;
        this.wxgroup = wxgroup;
    }

    public static WxGroup find(String community,int wxgroup) throws SQLException
    {
        WxGroup t = (WxGroup) c.get(community + ":" + wxgroup);
        if(t == null)
        {
            ArrayList al = find(" AND community=" + DbAdapter.cite(community) + " AND wxgroup=" + wxgroup,0,1);
            t = al.size() < 1 ? new WxGroup(community,wxgroup) : (WxGroup) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT community,wxgroup,name,cnt,deleted,time FROM WxGroup WHERE " + (size == 1 ? "1=1" : "deleted=0") + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                WxGroup t = new WxGroup(rs.getString(i++),rs.getInt(i++));
                t.name = rs.getString(i++);
                t.cnt = rs.getInt(i++);
                t.deleted = rs.getBoolean(i++);
                t.time = db.getDate(i++);
                c.put(t.community + ":" + t.wxgroup,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM WxGroup WHERE deleted=0" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(time == null)
        {
            time = new Date();
            sql = "INSERT INTO WxGroup(community,wxgroup,name,cnt,deleted,time)VALUES(" + DbAdapter.cite(community) + "," + wxgroup + "," + DbAdapter.cite(name) + "," + cnt + "," + DbAdapter.cite(deleted) + "," + DbAdapter.cite(time) + ")";
        } else
        {
            sql = "UPDATE WxGroup SET name=" + DbAdapter.cite(name) + ",cnt=" + cnt + ",deleted=" + DbAdapter.cite(deleted) + ",time=" + DbAdapter.cite(time) + " WHERE community=" + DbAdapter.cite(community) + " AND wxgroup=" + wxgroup;
        }
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(0,sql);
        } finally
        {
            db.close();
        }
        c.remove(community + ":" + wxgroup);
    }

    public void delete() throws SQLException
    {
        deleted = true;
        set("deleted","1");
        //DbAdapter.execute("DELETE FROM WxGroup WHERE community=" + DbAdapter.cite(community) + " AND wxgroup=" + wxgroup);
        //c.remove(community+":"+wxgroup);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(0,"UPDATE WxGroup SET " + f + "=" + DbAdapter.cite(v) + " WHERE community=" + DbAdapter.cite(community) + " AND wxgroup=" + wxgroup);
        } finally
        {
            db.close();
        }
        c.remove(community + ":" + wxgroup);
    }

    //
    public static String options(String sql,int defaultValue) throws SQLException
    {
        StringBuilder htm = new StringBuilder();
        ArrayList al = find(sql,0,200);
        for(int i = 0;i < al.size();i++)
        {
            WxGroup wg = (WxGroup) al.get(i);
            htm.append("<option value=" + wg.wxgroup);
            if(wg.wxgroup == defaultValue)
                htm.append(" selected");
            htm.append(">" + wg.name);
            if(wg.cnt > 0)
                htm.append(" (" + wg.cnt + ")");
        }
        return htm.toString();
    }
}
