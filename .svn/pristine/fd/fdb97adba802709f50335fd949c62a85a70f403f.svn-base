package tea.entity.lms;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import java.util.regex.*;

public class LmsChapter
{
    protected static Cache _cache = new Cache(50);
    public int lmschapter; //章节
    public int lmscourse; //课程
    public String name; //标题
    public String content; //描述
    public String vurl; //在线观看
    public String durl; //网络下载
    public int sequence; //顺序
    public int hits; //点击数

    public LmsChapter(int lmschapter)
    {
        this.lmschapter = lmschapter;
    }

    public static LmsChapter find(int lmschapter) throws SQLException
    {
        LmsChapter t = (LmsChapter) _cache.get(lmschapter);
        if(t == null)
        {
            ArrayList al = find(" AND lmschapter=" + lmschapter,0,1);
            t = al.size() < 1 ? new LmsChapter(lmschapter) : (LmsChapter) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT lmschapter,lmscourse,name,content,vurl,durl,sequence,hits FROM lmschapter WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                LmsChapter t = new LmsChapter(rs.getInt(i++));
                t.lmscourse = rs.getInt(i++);
                t.name = rs.getString(i++);
                t.content = rs.getString(i++);
                t.vurl = rs.getString(i++);
                t.durl = rs.getString(i++);
                t.sequence = rs.getInt(i++);
                t.hits = rs.getInt(i++);
                _cache.put(t.lmschapter,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM lmschapter WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(lmschapter < 1)
            sql = "INSERT INTO lmschapter(lmschapter,lmscourse,name,content,vurl,durl,sequence,hits)VALUES(" + (lmschapter = Seq.get()) + "," + lmscourse + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(content) + "," + DbAdapter.cite(vurl) + "," + DbAdapter.cite(durl) + "," + sequence + "," + hits + ")";
        else
            sql = "UPDATE lmschapter SET lmscourse=" + lmscourse + ",name=" + DbAdapter.cite(name) + ",content=" + DbAdapter.cite(content) + ",vurl=" + DbAdapter.cite(vurl) + ",durl=" + DbAdapter.cite(durl) + ",sequence=" + sequence + ",hits=" + hits + " WHERE lmschapter=" + lmschapter;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sql);
        } finally
        {
            db.close();
        }
        _cache.remove(lmschapter);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM lmschapter WHERE lmschapter=" + lmschapter);
        _cache.remove(lmschapter);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE lmschapter SET " + f + "=" + DbAdapter.cite(v) + " WHERE lmschapter=" + lmschapter);
        _cache.remove(lmschapter);
    }

    public static String f(String url)
    {
        Matcher m = Pattern.compile("http://v.youku.com/v_show/id_(\\w+).html").matcher(url);
        if(m.find())
        {
            url = m.group(1);
        }
        return url;
    }
}
