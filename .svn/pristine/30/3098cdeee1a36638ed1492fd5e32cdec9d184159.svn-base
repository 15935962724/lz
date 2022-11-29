package tea.entity.node.type.mpoll;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

//http://www.askform.cn/
public class Poll extends Entity implements Cloneable
{
    public static final String PR = "M";
    public int poll; //投票
    public String community; //社区
    public String[] name = new String[2]; //标题
    public String[] content = new String[2]; //说明
    public static String[] FILTER_TYPE =
            {"不做任何限制","不允许连续提交","不允许同一IP多次提交","不允许同一会员多次提交","","","","","自定义："};
    public int filter; //过滤机制
    public int question; //过滤问题
    public boolean captcha; //验证码
    public Date etime; //结束时间
    public int elimit; //允许收集多少个后关闭
    public int hits; //投票次数
    public int score; //分数线
    public Date time;

    public Poll(int poll)
    {
        this.poll = poll;
    }

    public static Poll find(int poll) throws SQLException
    {
        Poll t = (Poll) _cache.get(poll);
        if(t == null)
        {
            ArrayList al = find(" AND poll=" + poll,0,1);
            t = al.size() < 1 ? new Poll(poll) : (Poll) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT poll,community,name0,name1,content0,content1,filter,question,captcha,etime,elimit,hits,score,time FROM " + Poll.PR + "Poll WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                Poll t = new Poll(rs.getInt(i++));
                t.community = rs.getString(i++);
                t.name[0] = rs.getString(i++);
                t.name[1] = rs.getString(i++);
                t.content[0] = rs.getString(i++);
                t.content[1] = rs.getString(i++);
                t.filter = rs.getInt(i++);
                t.question = rs.getInt(i++);
                t.captcha = rs.getBoolean(i++);
                t.etime = db.getDate(i++);
                t.elimit = rs.getInt(i++);
                t.hits = rs.getInt(i++);
                t.score = rs.getInt(i++);
                t.time = db.getDate(i++);
                _cache.put(t.poll,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM " + Poll.PR + "Poll WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(poll < 1)
            sql = "INSERT INTO " + Poll.PR + "Poll(poll,community,name0,name1,content0,content1,filter,question,captcha,etime,elimit,hits,score,time)VALUES(" + (poll = Seq.get()) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(name[0]) + "," + DbAdapter.cite(name[1]) + "," + DbAdapter.cite(content[0]) + "," + DbAdapter.cite(content[1]) + "," + filter + "," + question + "," + DbAdapter.cite(captcha) + "," + DbAdapter.cite(etime) + "," + elimit + "," + hits + "," + score + "," + DbAdapter.cite(time) + ")";
        else
            sql = "UPDATE " + Poll.PR + "Poll SET community=" + DbAdapter.cite(community) + ",name0=" + DbAdapter.cite(name[0]) + ",name1=" + DbAdapter.cite(name[1]) + ",content0=" + DbAdapter.cite(content[0]) + ",content1=" + DbAdapter.cite(content[1]) + ",filter=" + filter + ",question=" + question + ",captcha=" + DbAdapter.cite(captcha) + ",etime=" + DbAdapter.cite(etime) + ",elimit=" + elimit + ",hits=" + hits + ",score=" + score + ",time=" + DbAdapter.cite(time) + " WHERE poll=" + poll;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(poll,sql);
        } finally
        {
            db.close();
        }
        _cache.remove(poll);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(poll,"DELETE FROM " + Poll.PR + "Poll WHERE poll=" + poll);
        } finally
        {
            db.close();
        }
        _cache.remove(poll);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(poll,"UPDATE " + Poll.PR + "Poll SET " + f + "=" + DbAdapter.cite(v) + " WHERE poll=" + poll);
        } finally
        {
            db.close();
        }
        _cache.remove(poll);
    }

    //
    public String toString(int lang) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        Iterator it = Question.find(" AND poll=" + poll,0,Integer.MAX_VALUE).iterator();
        for(int i = 1;it.hasNext();i++)
        {
            Question t = (Question) it.next();
            if(t.type == 10)
                sb.append(t.content[lang]);
            else
            {
                sb.append("<input type='hidden' name='question' value='" + t.question + "' />");
                sb.append("<div class='question'>" + t.name[lang] + "</div>");
                if(MT.f(t.content[lang]).length() > 0)
                    sb.append("<div class='subtitle'>" + t.content[lang] + "</div>");
                sb.append("<div class='choice'>");
                if(t.type == 3)
                {
                    sb.append("<input name='q" + t.question + "'");
                    if(t.required)
                        sb.append(" alt='" + t.name[lang] + "'");
                    if(t.width > 0)
                        sb.append(" style='width:" + t.width + "px'");
                    sb.append(">");
                } else if(t.type == 4)
                {
                    sb.append("<textarea name='q" + t.question + "' cols='40' rows='3'");
                    if(t.required)
                        sb.append(" alt='" + t.name[lang] + "'");
                    if(t.width > 0)
                        sb.append(" style='width:" + t.width + "px'");
                    sb.append("></textarea>");
                } else if(t.type == 2)
                {
                    sb.append("<select name='q" + t.question + "'>");
                    if(t.required)
                        sb.append(" alt='" + t.name[lang] + "'");
                    sb.append("<option value='0'>--");
                    ArrayList ac = Choice.findByQuestion(t.question);
                    for(int j = 0;j < ac.size();j++)
                    {
                        Choice c = (Choice) ac.get(j);
                        sb.append("<option value='" + c.choice + "'>" + c.name[lang]);
                    }
                    sb.append("</select>");
                } else
                {
                    ArrayList ac = Choice.findByQuestion(t.question);
                    for(int j = 0;j < ac.size();j++)
                    {
                        Choice c = (Choice) ac.get(j);
                        sb.append("<input type='" + (t.type == 0 ? "radio" : "checkbox") + "' name='q" + t.question + "' value='" + c.choice + "' id='C" + c.choice + "'");
                        if(t.required)
                            sb.append(" alt='" + t.name[lang] + "'");
                        sb.append(" /><label for='C" + c.choice + "'>" + MT.f(c.name[lang]) + "</label>　");
                    }
                }
                sb.append("</div>");
            }
        }
        return sb.toString();
    }

    public Poll clone() throws CloneNotSupportedException
    {
        Poll t = (Poll)super.clone();
        t.poll = 0;
        return t;
    }

    public Poll clone(int aa) throws SQLException,CloneNotSupportedException
    {
        Poll t = clone();
        t.name[1] = "复制 " + name[1];
        t.hits = 0;
        t.set();
        Iterator ic = Question.find(" AND poll=" + poll,0,Integer.MAX_VALUE).iterator();
        while(ic.hasNext())
        {
            ((Question) ic.next()).clone(t.poll);
        }
        return t;
    }

    public static void imp(String path) throws Exception
    {
        Question t = new Question(0);
        t.poll = 13102919;
        String[] str = Filex.read("D:/poll.txt","UTF-8").split("\r\n");
        for(int i = 0;i < str.length;i++)
        {
            if(str[i].startsWith("  ")) //选择项
            {
                Choice c = new Choice(0);
                c.question = t.question;
                c.name[1] = str[i].substring(2);
                c.set();
                if(c.name[1].startsWith("√"))
                {
                    c.set("name1",c.name[1] = c.name[1].substring(1));
                    t.set("answer",String.valueOf(t.answer = c.choice));
                }
            } else
            {
                t.question = 0;
                t.name[1] = str[i];
                t.required = true;
                t.sequence = i * 10;
                t.set();
            }
        }
    }

}
