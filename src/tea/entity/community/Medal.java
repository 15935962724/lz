package tea.entity.community;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class Medal
{
    protected static Cache c = new Cache(50);
    public int medal; //勋章
    public String community; //社区
    public String name; //名称
    public String picture; //图片
    public int sequence; //顺序

    public Medal(int medal)
    {
        this.medal = medal;
    }

    public static Medal find(int medal) throws SQLException
    {
        Medal t = (Medal) c.get(medal);
        if(t == null)
        {
            ArrayList al = find(" AND medal=" + medal,0,1);
            t = al.size() < 1 ? new Medal(medal) : (Medal) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT medal,community,name,picture,sequence FROM medal WHERE 1=1" + sql + " ORDER BY sequence",pos,size);
            while(rs.next())
            {
                int i = 1;
                Medal t = new Medal(rs.getInt(i++));
                t.community = rs.getString(i++);
                t.name = rs.getString(i++);
                t.picture = rs.getString(i++);
                t.sequence = rs.getInt(i++);
                c.put(t.medal,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM medal WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(medal < 1)
            sql = "INSERT INTO medal(community,name,picture,sequence)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(picture) + "," + sequence + ")";
        else
            sql = "UPDATE medal SET name=" + DbAdapter.cite(name) + ",picture=" + DbAdapter.cite(picture) + ",sequence=" + sequence + " WHERE medal=" + medal;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(medal,sql);
        } finally
        {
            db.close();
        }
        c.remove(medal);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(medal,"DELETE FROM medal WHERE medal=" + medal);
        } finally
        {
            db.close();
        }
        c.remove(medal);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(medal,"UPDATE medal SET " + f + "=" + DbAdapter.cite(v) + " WHERE medal=" + medal);
        } finally
        {
            db.close();
        }
        c.remove(medal);
    }
}
