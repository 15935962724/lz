package tea.entity.stat;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class SReferer
{
    protected static Cache c = new Cache(50);
    public int sreferer; //来路页面
    public String community; //站点
    public String url; //网页
    public int pv;
    public int uv;
    public int ip;
    public Date time; //时间

    public SReferer(int sreferer)
    {
        this.sreferer = sreferer;
    }

    public static SReferer find(int sreferer) throws SQLException
    {
        SReferer t = (SReferer) c.get(sreferer);
        if(t == null)
        {
            ArrayList al = find(" AND sreferer=" + sreferer,0,1);
            t = al.size() < 1 ? new SReferer(sreferer) : (SReferer) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT sreferer,community,url,pv,uv,ip,time FROM sreferer WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                SReferer t = new SReferer(rs.getInt(i++));
                t.community = rs.getString(i++);
                t.url = rs.getString(i++);
                t.pv = rs.getInt(i++);
                t.uv = rs.getInt(i++);
                t.ip = rs.getInt(i++);
                t.time = db.getDate(i++);
                c.put(t.sreferer,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM sreferer WHERE 1=1" + sql);
    }

    public void set(DbAdapter db) throws SQLException
    {
        if(sreferer < 1)
            db.executeUpdate("INSERT INTO sreferer(community,url,pv,uv,ip,time)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(url) + "," + pv + "," + uv + "," + ip + "," + DbAdapter.cite(time) + ")");
        else
            db.executeUpdate("UPDATE sreferer SET community=" + DbAdapter.cite(community) + ",url=" + DbAdapter.cite(url) + ",pv=" + pv + ",uv=" + uv + ",ip=" + ip + ",time=" + DbAdapter.cite(time) + " WHERE sreferer=" + sreferer);
        c.remove(sreferer);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM sreferer WHERE sreferer=" + sreferer);
        c.remove(sreferer);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE sreferer SET " + f + "=" + DbAdapter.cite(v) + " WHERE sreferer=" + sreferer);
        c.remove(sreferer);
    }
}
