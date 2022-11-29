package tea.entity.lms;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

//T_STUDENTSCORE_TAB
public class LmsScore
{
    protected static Cache _cache = new Cache(50);
    public int lmsscore; //考试成绩
    public int member; //用户ID
    public int lmsorg; //学习中心
    public int lmsplan; //考试计划
    public int lmscourse; //考试科目
    public String name; //姓名
    public String card; //证件号
    public String ticket; //准考证号
    public float score; //总成绩
    public Date time; //导入时间

    public LmsScore(int lmsscore)
    {
        this.lmsscore = lmsscore;
    }

    LmsScore(int member,int lmsplan,int lmscourse)
    {
        this.member = member;
        this.lmsplan = lmsplan;
        this.lmscourse = lmscourse;
    }

    public static LmsScore find(int lmsscore) throws SQLException
    {
        LmsScore t = (LmsScore) _cache.get(lmsscore);
        if(t == null)
        {
            ArrayList al = find(" AND lmsscore=" + lmsscore,0,1);
            t = al.size() < 1 ? new LmsScore(lmsscore) : (LmsScore) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT ls.lmsscore,ls.member,ls.lmsorg,ls.lmsplan,ls.lmscourse,ls.name,ls.card,ls.ticket,ls.score,ls.time FROM lmsscore ls" + tab(sql) + " WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                LmsScore t = new LmsScore(rs.getInt(i++));
                t.member = rs.getInt(i++);
                t.lmsorg = rs.getInt(i++);
                t.lmsplan = rs.getInt(i++);
                t.lmscourse = rs.getInt(i++);
                t.name = rs.getString(i++);
                t.card = rs.getString(i++);
                t.ticket = rs.getString(i++);
                t.score = rs.getFloat(i++);
                t.time = db.getDate(i++);
                _cache.put(t.lmsscore,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM lmsscore ls" + tab(sql) + " WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(lmsscore < 1)
        {
            String str = Seq.SDF.format(time);
            lmsscore = Integer.parseInt(str + Seq.DF4.format(Seq.get(str)));
            sql = "INSERT INTO lmsscore(lmsscore,member,lmsorg,lmsplan,lmscourse,name,card,ticket,score,time)VALUES(" + (lmsscore) + "," + member + "," + lmsorg + "," + lmsplan + "," + lmscourse + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(card) + "," + DbAdapter.cite(ticket) + "," + score + "," + DbAdapter.cite(time) + ")";
        } else
            sql = "UPDATE lmsscore SET member=" + member + ",lmsorg=" + lmsorg + ",lmsplan=" + lmsplan + ",lmscourse=" + lmscourse + ",name=" + DbAdapter.cite(name) + ",card=" + DbAdapter.cite(card) + ",ticket=" + DbAdapter.cite(ticket) + ",score=" + score + ",time=" + DbAdapter.cite(time) + " WHERE lmsscore=" + lmsscore;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sql);
        } finally
        {
            db.close();
        }
        _cache.remove(lmsscore);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM lmsscore WHERE lmsscore=" + lmsscore);
        _cache.remove(lmsscore);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE lmsscore SET " + f + "=" + DbAdapter.cite(v) + " WHERE lmsscore=" + lmsscore);
        _cache.remove(lmsscore);
    }

    //
    public static LmsScore find(int member,int lmsplan,int lmscourse) throws SQLException
    {
        ArrayList al = find(" AND ls.member=" + member + " AND ls.lmsplan=" + lmsplan + " AND ls.lmscourse=" + lmscourse,0,1);
        return al.size() < 1 ? new LmsScore(member,lmsplan,lmscourse) : (LmsScore) al.get(0);
    }

    public static LmsScore findLast(int member,int lmsplan,int lmscourse) throws SQLException
    {
        ArrayList al = find(" AND ls.member=" + member + " AND ls.lmsplan<" + lmsplan + " AND ls.lmscourse=" + lmscourse + " ORDER BY score DESC",0,1);
        return al.size() < 1 ? new LmsScore(member,lmsplan,lmscourse) : (LmsScore) al.get(0);
    }

    static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if(sql.contains(" AND lo."))
            sb.append(" INNER JOIN lmsorg lo ON lo.lmsorg=ls.lmsorg");
        if(sql.contains(" AND lc."))
            sb.append(" INNER JOIN lmscourse lc ON lc.lmscourse=ls.lmscourse");
        if(sql.contains(" AND lp."))
            sb.append(" INNER JOIN lmsplan lp ON lp.lmsplan=ls.lmsplan");
        if(sql.contains(" AND p."))
            sb.append(" INNER JOIN Profile p ON p.profile=ls.member");
        return sb.toString();
    }
}
