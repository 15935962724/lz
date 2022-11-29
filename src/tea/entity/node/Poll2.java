package tea.entity.node;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class Poll2
{
    protected static Cache c = new Cache(50);
    public int node; //投票节点
    public String member="|"; //|投票范围:会员
    public String unit="|"; //|投票范围:部门
    public String role="|"; //|投票范围:角色

    public Poll2(int node)
    {
        this.node=node;
    }

    public static Poll2 find(int node) throws SQLException
    {
        Poll2 t = (Poll2) c.get(node);
        if(t == null)
        {
            ArrayList al = find(" AND node=" + node,0,1);
            t = al.size() < 1 ? new Poll2(node) : (Poll2) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT node,member,unit,role FROM Poll WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                Poll2 t = new Poll2(rs.getInt(i++));
                t.member = rs.getString(i++);
                t.unit = rs.getString(i++);
                t.role = rs.getString(i++);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM Poll WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int i = db.executeUpdate("INSERT INTO Poll(node,member,unit,role)VALUES(" + node + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(unit) + "," + DbAdapter.cite(role) + ")");
            if(i < 1)
            {
                db.executeUpdate("UPDATE Poll SET member=" + DbAdapter.cite(member) + ",unit=" + DbAdapter.cite(unit) + ",role=" + DbAdapter.cite(role) + " WHERE node=" + node);
            }
        } finally
        {
            db.close();
        }
        c.remove(node);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM Poll WHERE node=" + node);
        c.remove(node);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE Poll SET " + f + "=" + DbAdapter.cite(v) + " WHERE node=" + node);
        c.remove(node);
    }
}
