package tea.entity.node.type.mpoll;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class Answer
{
    public int vote; //投票结果
    public int question; //问题
    public String choice = "|"; //选择
    public String content; //答案

    public Answer(int vote,int question)
    {
        this.vote = vote;
        this.question = question;
    }

    public static Answer find(int vote,int question) throws SQLException
    {
        ArrayList al = find(" AND vote=" + vote + " AND question=" + question,0,1);
        return al.size() < 1 ? new Answer(vote,question) : (Answer) al.get(0);
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT vote,question,choice,content FROM " + Poll.PR + "Answer WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                Answer t = new Answer(rs.getInt(i++),rs.getInt(i++));
                t.choice = rs.getString(i++);
                t.content = rs.getString(i++);
                al.add(t);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }

    public static HashMap findByVote(int vote) throws SQLException
    {
        HashMap hm = new HashMap();
        ArrayList al = find(" AND vote=" + vote,0,Integer.MAX_VALUE);
        for(int i = 0;i < al.size();i++)
        {
            Answer t = (Answer) al.get(i);
            hm.put(t.question,t);
        }
        return hm;
    }

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM " + Poll.PR + "Answer WHERE 1=1" + sql);
    }

    public void set(DbAdapter db) throws SQLException
    {
        int i = db.executeUpdate(vote,"INSERT INTO " + Poll.PR + "Answer(vote,question,choice,content)VALUES(" + vote + "," + question + "," + DbAdapter.cite(choice) + "," + DbAdapter.cite(content) + ")");
        if(i < 1)
        {
            db.executeUpdate(vote,"UPDATE " + Poll.PR + "Answer SET choice=" + DbAdapter.cite(choice) + ",content=" + DbAdapter.cite(content) + " WHERE vote=" + vote + " AND question=" + question);
        }
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM " + Poll.PR + "Answer WHERE vote=" + vote + " AND question=" + question);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE " + Poll.PR + "Answer SET " + f + "=" + DbAdapter.cite(v) + " WHERE vote=" + vote + " AND question=" + question);
    }

    //
    public String getContent() throws SQLException
    {
        Question q = Question.find(question);
        if(q.type < 3)
        {
            StringBuffer sb = new StringBuffer();
            String[] arr = choice.split("[|]");
            for(int x = 1;x < arr.length;x++)
            {
                if(x > 1)
                    sb.append("　");
                sb.append(Choice.find(Integer.parseInt(arr[x])).name[1]);
            }
            return sb.toString();
        }
        return content;
    }
}
