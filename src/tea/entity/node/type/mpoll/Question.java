package tea.entity.node.type.mpoll;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class Question extends Entity implements Cloneable
{
    public int question; //问题
    public int poll; //所属的投票
    public String[] name = new String[2]; //标题
    public static String[] QUESTION_TYPE =
            {"单选","多选","下接菜单","单行输入","多行输入","5","6","7","8","9","分隔符"};
    public int type; //类型
    public String[] content = new String[2]; //说明
    public boolean required; //必选
    public String value; //默认值
    public int answer; //答案==Choice.choice
    public int width; //宽度
    public int sequence; //顺序

    public Question(int question)
    {
        this.question = question;
    }

    public static Question find(int question) throws SQLException
    {
        Question t = (Question) _cache.get(question);
        if(t == null)
        {
            ArrayList al = find(" AND question=" + question,0,1);
            t = al.size() < 1 ? new Question(question) : (Question) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT question,poll,name0,name1,type,content0,content1,required,value,answer,width,sequence FROM " + Poll.PR + "Question WHERE 1=1" + sql + " ORDER BY sequence",pos,size);
            while(rs.next())
            {
                int i = 1;
                Question t = new Question(rs.getInt(i++));
                t.poll = rs.getInt(i++);
                t.name[0] = rs.getString(i++);
                t.name[1] = rs.getString(i++);
                t.type = rs.getInt(i++);
                t.content[0] = rs.getString(i++);
                t.content[1] = rs.getString(i++);
                t.required = rs.getBoolean(i++);
                t.value = rs.getString(i++);
                t.answer = rs.getInt(i++);
                t.width = rs.getInt(i++);
                t.sequence = rs.getInt(i++);
                _cache.put(t.question,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM " + Poll.PR + "Question WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(question < 1)
            sql = "INSERT INTO " + Poll.PR + "Question(question,poll,name0,name1,type,content0,content1,required,value,answer,width,sequence)VALUES(" + (question = Seq.get()) + "," + poll + "," + DbAdapter.cite(name[0]) + "," + DbAdapter.cite(name[1]) + "," + type + "," + DbAdapter.cite(content[0]) + "," + DbAdapter.cite(content[1]) + "," + DbAdapter.cite(required) + "," + DbAdapter.cite(value) + "," + answer + "," + width + "," + sequence + ")";
        else
            sql = "UPDATE " + Poll.PR + "Question SET name0=" + DbAdapter.cite(name[0]) + ",name1=" + DbAdapter.cite(name[1]) + ",type=" + type + ",content0=" + DbAdapter.cite(content[0]) + ",content1=" + DbAdapter.cite(content[1]) + ",required=" + DbAdapter.cite(required) + ",value=" + DbAdapter.cite(value) + ",answer=" + answer + ",width=" + width + ",sequence=" + sequence + " WHERE question=" + question;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(question,sql);
        } finally
        {
            db.close();
        }
        _cache.remove(question);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(question,"DELETE FROM " + Poll.PR + "Question WHERE question=" + question);
        } finally
        {
            db.close();
        }
        _cache.remove(question);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(question,"UPDATE " + Poll.PR + "Question SET " + f + "=" + DbAdapter.cite(v) + " WHERE question=" + question);
        } finally
        {
            db.close();
        }
        _cache.remove(question);
    }

    //
//    public static ArrayList findByPoll(int poll) throws SQLException
//    {
//        return find(" AND poll=" + poll + " ORDER BY sequence", 0, Integer.MAX_VALUE);
//    }
    public String getName()
    {
        return name[1].replaceAll("[　：]","");
    }

    public Question clone() throws CloneNotSupportedException
    {
        Question t = (Question)super.clone();
        t.question = 0;
        return t;
    }

    public Question clone(int poll) throws SQLException,CloneNotSupportedException
    {
        Question t = clone();
        t.poll = poll;
        t.set();
        Iterator ic = Choice.find(" AND question=" + question,0,Integer.MAX_VALUE).iterator();
        while(ic.hasNext())
        {
            ((Choice) ic.next()).clone(t.question);
        }
        return t;
    }

    public static String options(int poll,int question) throws SQLException
    {
        StringBuilder htm = new StringBuilder();
        ArrayList al = Question.find(" AND poll=" + poll + " AND type=3",0,200);
        for(int i = 0;i < al.size();i++)
        {
            Question q = (Question) al.get(i);
            htm.append("<option value=" + q.question);
            if(q.question == question)
                htm.append(" selected");
            htm.append(">" + q.getName());
        }
        return htm.toString();
    }
}
