package tea.entity.node;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class STemplate
{
    protected static Cache c = new Cache(50);
    public int node; //主题模板
    public String community; //社区
    public String name; //模板名称
    public int sequence; //顺序
    public int hits; //使用次数
    public Date time; //创建时间

    public STemplate(int node)
    {
        this.node=node;
    }

    public static STemplate find(int node) throws SQLException
    {
        STemplate t = (STemplate) c.get(node);
        if(t == null)
        {
            ArrayList al = find(" AND node=" + node,0,1);
            t = al.size() < 1 ? new STemplate(node) : (STemplate) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT node,community,name,sequence,hits,time FROM STemplate WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                STemplate t = new STemplate(rs.getInt(i++));
                t.community = rs.getString(i++);
                t.name = rs.getString(i++);
                t.sequence = rs.getInt(i++);
                t.hits = rs.getInt(i++);
                t.time = db.getDate(i++);
                c.put(t.node,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM STemplate WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int i = db.executeUpdate("INSERT INTO STemplate(node,community,name,sequence,hits,time)VALUES(" + node + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(name) + "," + sequence + "," + hits + "," + DbAdapter.cite(time) + ")");
            if(i < 1)
            {
                db.executeUpdate("UPDATE STemplate SET name=" + DbAdapter.cite(name) + ",sequence=" + sequence + ",hits=" + hits + ",time=" + DbAdapter.cite(time) + " WHERE node=" + node);
            }
        } finally
        {
            db.close();
        }
        c.remove(node);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM STemplate WHERE node=" + node);
        c.remove(node);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE STemplate SET " + f + "=" + DbAdapter.cite(v) + " WHERE node=" + node);
        c.remove(node);
    }
}
