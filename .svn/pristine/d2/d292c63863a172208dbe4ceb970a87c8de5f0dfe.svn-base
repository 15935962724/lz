package tea.entity.node.type.mpoll;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class Choice implements Cloneable
{
    protected static Cache _cache = new Cache(1000);
    public int choice; //选择
    public int question; //所属的问题
    public String[] name = new String[2]; //名称
    public boolean checked; //是否选中
    public int sequence;
    public int hits;
    public Choice(int choice)
    {
        this.choice = choice;
    }

    public static Choice find(int choice) throws SQLException
    {
        Choice t = (Choice) _cache.get(choice);
        if(t == null)
        {
            ArrayList al = find(" AND choice=" + choice,0,1);
            t = al.size() < 1 ? new Choice(choice) : (Choice) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT choice,question,name0,name1,checked,sequence,hits FROM " + Poll.PR + "Choice WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                Choice t = new Choice(rs.getInt(i++));
                t.question = rs.getInt(i++);
                t.name[0] = rs.getString(i++);
                t.name[1] = rs.getString(i++);
                t.checked = rs.getBoolean(i++);
                t.sequence = rs.getInt(i++);
                t.hits = rs.getInt(i++);
                _cache.put(t.choice,t);
                al.add(t);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }

    public static ArrayList findByQuestion(int question) throws SQLException
    {
        ArrayList al = (ArrayList) _cache.get(question);
        if(al == null)
        {
            al = find(" AND question=" + question,0,Integer.MAX_VALUE);
            _cache.put(question,al);
        }
        return al;
    }

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM " + Poll.PR + "Choice WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(choice < 1)
            sql = "INSERT INTO " + Poll.PR + "Choice(choice,question,name0,name1,checked,sequence,hits)VALUES(" + (choice = Seq.get()) + "," + question + "," + DbAdapter.cite(name[0]) + "," + DbAdapter.cite(name[1]) + "," + DbAdapter.cite(checked) + "," + sequence + "," + hits + ")";
        else
            sql = "UPDATE " + Poll.PR + "Choice SET question=" + question + ",name0=" + DbAdapter.cite(name[0]) + ",name1=" + DbAdapter.cite(name[1]) + ",checked=" + DbAdapter.cite(checked) + ",sequence=" + sequence + ",hits=" + hits + " WHERE choice=" + choice;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sql);
        } finally
        {
            db.close();
        }
        _cache.remove(question);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM " + Poll.PR + "Choice WHERE choice=" + choice);
        _cache.remove(question);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE " + Poll.PR + "Choice SET " + f + "=" + DbAdapter.cite(v) + " WHERE choice=" + choice);
        _cache.remove(question);
    }

    //
    public Choice clone() throws CloneNotSupportedException
    {
        Choice t = (Choice)super.clone();
        t.choice = 0;
        return t;
    }

    public Choice clone(int question) throws SQLException,CloneNotSupportedException
    {
        Choice t = clone();
        t.question = question;
        t.set();
        return t;
    }
}
