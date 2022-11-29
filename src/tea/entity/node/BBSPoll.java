package tea.entity.node;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class BBSPoll
{
    protected static Cache c = new Cache(50);
    public int bbspoll; //投票
    public int node; //节点
    public String question; //选项
    public String member = "|"; //|用户
    public int hits; //投票数

    public BBSPoll(int bbspoll)
    {
        this.bbspoll = bbspoll;
    }

    public static BBSPoll find(int bbspoll) throws SQLException
    {
        BBSPoll t = (BBSPoll) c.get(bbspoll);
        if(t == null)
        {
            ArrayList al = find(" AND bbspoll=" + bbspoll,0,1);
            t = al.size() < 1 ? new BBSPoll(bbspoll) : (BBSPoll) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT bbspoll,node,question,member,hits FROM BBSPoll WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                BBSPoll t = new BBSPoll(rs.getInt(i++));
                t.node = rs.getInt(i++);
                t.question = rs.getString(i++);
                t.member = rs.getString(i++);
                t.hits = rs.getInt(i++);
                c.put(t.bbspoll,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM BBSPoll WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if(bbspoll < 1)
                db.executeUpdate("INSERT INTO BBSPoll(node,question,member,hits)VALUES(" + node + "," + DbAdapter.cite(question) + "," + DbAdapter.cite(member) + "," + hits + ")");
            else
                db.executeUpdate("UPDATE BBSPoll SET question=" + DbAdapter.cite(question) + ",member=" + DbAdapter.cite(member) + ",hits=" + hits + " WHERE bbspoll=" + bbspoll);
        } finally
        {
            db.close();
        }
        c.remove(bbspoll);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM BBSPoll WHERE bbspoll=" + bbspoll);
        c.remove(bbspoll);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE BBSPoll SET " + f + "=" + DbAdapter.cite(v) + " WHERE bbspoll=" + bbspoll);
        c.remove(bbspoll);
    }
}
