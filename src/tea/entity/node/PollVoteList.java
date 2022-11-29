package tea.entity.node;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.entity.*;
import tea.db.*;

public class PollVoteList
{
    protected static Cache c = new Cache(50);
    public int pollvote; //投票结果
    public int poll; //问题
    public String answer; //答案

    public PollVoteList(int pollvote,int poll)
    {
        this.pollvote = pollvote;
        this.poll = poll;
    }

    public static PollVoteList find(int pollvote,int poll) throws SQLException
    {
        PollVoteList t = (PollVoteList) c.get(pollvote + ":" + poll);
        if(t == null)
        {
            ArrayList al = find(" AND pollvote=" + pollvote + " AND poll=" + poll,0,1);
            t = al.size() < 1 ? new PollVoteList(pollvote,poll) : (PollVoteList) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT pollvote,poll,answer FROM PollVoteList WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                PollVoteList t = new PollVoteList(rs.getInt(i++),rs.getInt(i++));
                t.answer = rs.getString(i++);
                c.put(t.pollvote + ":" + t.poll,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM PollVoteList WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int i = db.executeUpdate("INSERT INTO PollVoteList(pollvote,poll,answer)VALUES(" + pollvote + "," + poll + "," + DbAdapter.cite(answer) + ")");
            if(i < 1)
            {
                db.executeUpdate("UPDATE PollVoteList SET answer=" + DbAdapter.cite(answer) + " WHERE pollvote=" + pollvote + " AND poll=" + poll);
            }
        } finally
        {
            db.close();
        }
        c.remove(pollvote);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM PollVoteList WHERE pollvote=" + pollvote + " AND poll=" + poll);
        c.remove(pollvote);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE PollVoteList SET " + f + "=" + DbAdapter.cite(v) + " WHERE pollvote=" + pollvote + " AND poll=" + poll);
        c.remove(pollvote);
    }
    //
}
