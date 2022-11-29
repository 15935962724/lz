package tea.entity.node;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class FDown
{
    protected static Cache c = new Cache(50);
    public int down; //文件下载记录
    public int node; //文件
    public int member; //用户
    public String ip; //IP地址
    public Date time; //时间

    public FDown(int down)
    {
        this.down = down;
    }

    public static FDown find(int down) throws SQLException
    {
        FDown t = (FDown) c.get(down);
        if(t == null)
        {
            ArrayList al = find(" AND down=" + down,0,1);
            t = al.size() < 1 ? new FDown(down) : (FDown) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT down,node,member,ip,time FROM fdown WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                FDown t = new FDown(rs.getInt(i++));
                t.node = rs.getInt(i++);
                t.member = rs.getInt(i++);
                t.ip = rs.getString(i++);
                t.time = db.getDate(i++);
                c.put(t.down,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM fdown WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if(down < 1)
                db.executeUpdate("INSERT INTO fdown(node,member,ip,time)VALUES(" + node + "," + member + "," + DbAdapter.cite(ip) + "," + DbAdapter.cite(time) + ")");
            else
                db.executeUpdate("UPDATE fdown SET node=" + node + ",member=" + member + ",ip=" + DbAdapter.cite(ip) + ",time=" + DbAdapter.cite(time) + " WHERE down=" + down);
        } finally
        {
            db.close();
        }
        c.remove(down);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM fdown WHERE down=" + down);
        c.remove(down);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE fdown SET " + f + "=" + DbAdapter.cite(v) + " WHERE down=" + down);
        c.remove(down);
    }
}
