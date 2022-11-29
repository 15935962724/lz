package tea.entity.node.type.mpoll;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class Vote
{
    public static Cache c = new Cache(50);
    public int vote; //投票结果
    public int poll; //投票
    public int language; //语言
    public int member; //参与者
    public String answer; //回答
    public int total; //总得分
    public String ip; //IP地址
    public String useragent; //客户端信息
    public int winning; //中奖名次
    public double random; //随机数
    public boolean deleted; //是否已删除
    public Date time; //参与时间

    public Vote(int vote)
    {
        this.vote = vote;
    }

    public static Vote find(int vote) throws SQLException
    {
        Vote t = (Vote) c.get(vote);
        if(t == null)
        {
            ArrayList al = find(" AND vote=" + vote,0,1);
            t = al.size() < 1 ? new Vote(vote) : (Vote) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT v.vote,v.poll,v.language,v.member,v.answer,v.total,v.ip,v.useragent,v.winning,v.random,v.deleted,v.time FROM " + Poll.PR + "Vote v" + tab(sql) + " WHERE v.deleted=0" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                Vote t = new Vote(rs.getInt(i++));
                t.poll = rs.getInt(i++);
                t.language = rs.getInt(i++);
                t.member = rs.getInt(i++);
                t.answer = rs.getString(i++);
                t.total = rs.getInt(i++);
                t.ip = rs.getString(i++);
                t.useragent = rs.getString(i++);
                t.winning = rs.getInt(i++);
                t.random = rs.getDouble(i++);
                t.deleted = rs.getBoolean(i++);
                t.time = db.getDate(i++);
                c.put(t.vote,t);
                al.add(t);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }

    private static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if(sql.contains(" AND a."))
            sb.append(" LEFT JOIN " + Poll.PR + "Answer a ON a.vote=v.vote");
        return sb.toString();
    }

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM " + Poll.PR + "Vote v" + tab(sql) + " WHERE v.deleted=0" + sql);
    }

    public void set(DbAdapter db) throws SQLException
    {
        String sql;
        if(vote < 1)
            sql = "INSERT INTO " + Poll.PR + "Vote(vote,poll,language,member,answer,total,ip,useragent,winning,random,deleted,time)VALUES(" + (vote = Seq.get()) + "," + poll + "," + language + "," + member + "," + DbAdapter.cite(answer) + "," + total + "," + DbAdapter.cite(ip) + "," + DbAdapter.cite(useragent) + "," + winning + "," + (random = Math.random()) + "," + DbAdapter.cite(deleted) + "," + DbAdapter.cite(time) + ")";
        else
            sql = "UPDATE " + Poll.PR + "Vote SET poll=" + poll + ",language=" + language + ",member=" + member + ",answer=" + DbAdapter.cite(answer) + ",total=" + total + ",ip=" + DbAdapter.cite(ip) + ",useragent=" + DbAdapter.cite(useragent) + ",winning=" + winning + ",random=" + random + ",deleted=" + DbAdapter.cite(deleted) + ",time=" + DbAdapter.cite(time) + " WHERE vote=" + vote;
        db.executeUpdate(vote,sql);
        c.remove(vote);
    }

    public void delete() throws SQLException
    {
        deleted = true;
        set("deleted","1");
        //DbAdapter.execute("DELETE FROM " + Poll.PR + "Vote WHERE vote=" + vote);
        c.remove(vote);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE " + Poll.PR + "Vote SET " + f + "=" + DbAdapter.cite(v) + " WHERE vote=" + vote);
        c.remove(vote);
    }

    //
    public String toString(String qs) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        sb.append("{vote:" + vote);
        sb.append(",poll:" + poll);
        HashMap hm = Answer.findByVote(vote);
        String[] arr = qs.split("[|]");
        for(int i = 1;i < arr.length;i++)
        {
            Answer a = (Answer) hm.get(new Integer(arr[i]));
            sb.append(",q" + arr[i] + ":" + Attch.cite(a.getContent()));
        }
        sb.append(",answer:" + Attch.cite(answer));
        sb.append("}");
        return sb.toString();
    }

    public String toString(int lang) throws SQLException
    {
        HashMap hm = Answer.findByVote(vote);
        StringBuilder sb = new StringBuilder();
        Iterator it = Question.find(" AND poll=" + poll,0,Integer.MAX_VALUE).iterator();
        for(int i = 1;it.hasNext();i++)
        {
            Question t = (Question) it.next();
            if(t.type == 10)
                sb.append(t.content[lang]);
            else
            {
                Answer a = (Answer) hm.get(t.question);
                if(a == null)
                    a = new Answer(vote,t.question);
                sb.append("<div class='question'>" + t.name[lang] + "</div>");
                if(MT.f(t.content[lang]).length() > 0)
                    sb.append("<div class='subtitle'>" + t.content[lang] + "</div>");
                sb.append("<div class='choice'>");
                if(t.type == 3)
                {
                    sb.append("<input name='q" + t.question + "' value=" + MT.f(a.content));
                    if(t.width > 0)
                        sb.append(" style='width:" + t.width + "px'");
                    sb.append(">");
                } else if(t.type == 4)
                {
                    sb.append("<textarea name='q" + t.question + "' cols='40' rows='3'");
                    if(t.width > 0)
                        sb.append(" style='width:" + t.width + "px'");
                    sb.append(">" + MT.f(a.content) + "</textarea>");
                } else if(t.type == 2)
                {
                    String alt = null;
                    if(t.answer < 1)
                        alt = "";
                    else if(a.choice.contains("|" + t.answer + "|"))
                        alt = "ok";
                    else
                        alt = "err";
                    sb.append("<select name='q" + t.question + "' class='" + alt + "'><option value='0'>--");
                    ArrayList ac = Choice.findByQuestion(t.question);
                    for(int j = 0;j < ac.size();j++)
                    {
                        Choice c = (Choice) ac.get(j);
                        sb.append("<option value='" + c.choice + "'" + (a.choice.contains("|" + c.choice + "|") ? " selected" : "") + ">" + c.name[lang]);
                    }
                    sb.append("</select>");
                } else
                {
                    ArrayList ac = Choice.findByQuestion(t.question);
                    for(int j = 0;j < ac.size();j++)
                    {
                        Choice c = (Choice) ac.get(j);
                        boolean sel = a.choice.contains("|" + c.choice + "|");
                        String alt = null;
                        if(t.answer < 1)
                            alt = "";
                        else if(t.answer == c.choice)
                            alt = "ok";
                        else if(sel)
                            alt = "err";
                        sb.append("<input type='" + (t.type == 0 ? "radio" : "checkbox") + "' name='q" + t.question + "' value='" + c.choice + "'" + (sel ? " checked" : "") + " id='C" + c.choice + "' /><label for='C" + c.choice + "' class='" + alt + "'>" + MT.f(c.name[lang]) + "</label>　");
                    }
                }
                sb.append("</div>");
            }
        }
        return sb.toString();
    }

}
