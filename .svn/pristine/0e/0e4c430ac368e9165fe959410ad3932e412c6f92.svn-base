package tea.entity.admin;

import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class IfNotRead
{
    protected static Cache c = new Cache(50);
    public int newid;
    public String member;
    public int ynread;
    public Date ndate;

    public IfNotRead(int newid)
    {
        this.newid = newid;
    }

    public static IfNotRead find(int newid) throws SQLException
    {
        IfNotRead t = (IfNotRead) c.get(newid);
        if(t == null)
        {
            ArrayList al = find(" AND newid=" + newid,0,1);
            t = al.size() < 1 ? new IfNotRead(newid) : (IfNotRead) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT newid,member,ynread,ndate FROM ifnotread WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                IfNotRead t = new IfNotRead(rs.getInt(i++));
                t.member = rs.getString(i++);
                t.ynread = rs.getInt(i++);
                t.ndate = db.getDate(i++);
                c.put(t.newid,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM ifnotread WHERE 1=1" + sql);
    }

    public static void create(int newid,String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO ifnotread(newid,member,ynread,ndate)VALUES(" + newid + "," + DbAdapter.cite(member) + "," + 1 + "," + DbAdapter.cite(new Date()) + ")");
        } finally
        {
            db.close();
        }
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int i = db.executeUpdate("INSERT INTO ifnotread(newid,member,ynread,ndate)VALUES(" + newid + "," + DbAdapter.cite(member) + "," + ynread + "," + DbAdapter.cite(ndate) + ")");
            if(i < 1)
            {
                db.executeUpdate("UPDATE ifnotread SET newid=" + newid + ",member=" + DbAdapter.cite(member) + ",ynread=" + ynread + ",ndate=" + DbAdapter.cite(ndate) + " WHERE newid=" + newid);
            }
        } finally
        {
            db.close();
        }
        c.remove(newid);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM ifnotread WHERE newid=" + newid);
        c.remove(newid);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE ifnotread SET " + f + "=" + DbAdapter.cite(v) + " WHERE newid=" + newid);
        c.remove(newid);
    }
}
