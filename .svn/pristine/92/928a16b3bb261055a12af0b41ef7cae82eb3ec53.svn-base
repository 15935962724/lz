package tea.entity.node;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class NMark
{
    protected static Cache c = new Cache(50);
    public int node;
    public int good; //顶
    public int poor; //踩
    public String  ip;

    public NMark(int node)
    {
        this.node=node;
    }

    public static NMark find(int node) throws SQLException
    {
        NMark t = (NMark) c.get(node);
        if(t == null)
        {
            ArrayList al = find(" AND node=" + node,0,1);
            t = al.size() < 1 ? new NMark(node) : (NMark) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT node,good,poor,ip FROM NMark WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                NMark t = new NMark(rs.getInt(i++));
                t.good = rs.getInt(i++);
                t.poor = rs.getInt(i++);
                t.ip = rs.getString (i++);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM NMark WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int i = db.executeUpdate("INSERT INTO NMark(node,good,poor,ip)VALUES(" + node + "," + good + "," + poor + "," + DbAdapter.cite(ip) + ")");
            if(i < 1)
            {
                db.executeUpdate("UPDATE NMark SET good=" + good + ",poor=" + poor + ",ip=" + DbAdapter.cite(ip) + " WHERE node=" + node);
            }
        } finally
        {
            db.close();
        }
        c.remove(node);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM NMark WHERE node=" + node);
        c.remove(node);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE NMark SET " + f + "=" + DbAdapter.cite(v) + " WHERE node=" + node);
        c.remove(node);
    }
}
