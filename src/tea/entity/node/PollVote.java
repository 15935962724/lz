package tea.entity.node;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class PollVote
{
    protected static Cache c = new Cache(50);
    public int pollvote; //投票结果
    public int node; //节点
    public int language; //语言
    public String member; //参与者
    public String ip; //IP地址
    public Date time; //参与时间

    public PollVote(int pollvote)
    {
        this.pollvote = pollvote;
    }

    public static PollVote find(int pollvote) throws SQLException
    {
        PollVote t = (PollVote) c.get(pollvote);
        if(t == null)
        {
            ArrayList al = find(" AND pollvote=" + pollvote,0,1);
            t = al.size() < 1 ? new PollVote(pollvote) : (PollVote) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT pollvote,node,language,member,ip,time FROM PollVote WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                PollVote t = new PollVote(rs.getInt(i++));
                t.node = rs.getInt(i++);
                t.language = rs.getInt(i++);
                t.member = rs.getString(i++);
                t.ip = rs.getString(i++);
                t.time = db.getDate(i++);
                c.put(t.pollvote,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM PollVote WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if(pollvote < 1)
            {
                db.executeUpdate("INSERT INTO PollVote(node,language,member,ip,time)VALUES(" + node + "," + language + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(ip) + "," + DbAdapter.cite(time) + ")");
                db.executeQuery("SELECT MAX(pollvote) FROM PollVote WHERE node=" + node + " AND ip=" + DbAdapter.cite(ip));
                if(db.next())
                    pollvote = db.getInt(1);
            } else
            {
                db.executeUpdate("UPDATE PollVote SET node=" + node + ",language=" + language + ",member=" + DbAdapter.cite(member) + ",time=" + DbAdapter.cite(time) + " WHERE pollvote=" + pollvote);
            }
        } finally
        {
            db.close();
        }
        c.remove(pollvote);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM PollVote WHERE pollvote=" + pollvote);
        c.remove(pollvote);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE PollVote SET " + f + "=" + DbAdapter.cite(v) + " WHERE pollvote=" + pollvote);
        c.remove(pollvote);
    }
}
