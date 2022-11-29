package tea.entity.lms;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class LmsPlanCourse
{
    protected static Cache _cache = new Cache(50);
    public int lmsplancourse; //课程安排
    public int lmsplan; //考试计划
    public int member; //创建人
    public static String[] HOUR_TYPE =
            {"00:00","00:30","01:00","01:30","02:00","02:30","03:00","03:30","04:00","04:30","05:00","05:30","06:00","06:30","07:00","07:30","08:00","08:30","09:00","09:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00","13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00","17:30","18:00","18:30","19:00","19:30","20:00","20:30","21:00","21:30","22:00","22:30","23:00","23:30"};
    public Date starttime; //开始时间
    public Date endtime; //结束时间
    public int lmscert; //证书方向
    public int lmscourse; //考试科目
    public Date time; //创建时间

    public LmsPlanCourse(int lmsplancourse)
    {
        this.lmsplancourse = lmsplancourse;
    }

    public static LmsPlanCourse find(int lmsplancourse) throws SQLException
    {
        LmsPlanCourse t = (LmsPlanCourse) _cache.get(lmsplancourse);
        if(t == null)
        {
            ArrayList al = find(" AND lmsplancourse=" + lmsplancourse,0,1);
            t = al.size() < 1 ? new LmsPlanCourse(lmsplancourse) : (LmsPlanCourse) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT lmsplancourse,lmsplan,member,starttime,endtime,lmscert,lmscourse,time FROM lmsplancourse WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                LmsPlanCourse t = new LmsPlanCourse(rs.getInt(i++));
                t.lmsplan = rs.getInt(i++);
                t.member = rs.getInt(i++);
                t.starttime = db.getDate(i++);
                t.endtime = db.getDate(i++);
                t.lmscert = rs.getInt(i++);
                t.lmscourse = rs.getInt(i++);
                t.time = db.getDate(i++);
                _cache.put(t.lmsplancourse,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM lmsplancourse WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(lmsplancourse < 1)
            sql = "INSERT INTO lmsplancourse(lmsplancourse,lmsplan,member,starttime,endtime,lmscert,lmscourse,time)VALUES(" + (lmsplancourse = Seq.get()) + "," + lmsplan + "," + member + "," + DbAdapter.cite(starttime) + "," + DbAdapter.cite(endtime) + "," + lmscert + "," + lmscourse + "," + DbAdapter.cite(time) + ")";
        else
            sql = "UPDATE lmsplancourse SET lmsplan=" + lmsplan + ",member=" + member + ",starttime=" + DbAdapter.cite(starttime) + ",endtime=" + DbAdapter.cite(endtime) + ",lmscert=" + lmscert + ",lmscourse=" + lmscourse + ",time=" + DbAdapter.cite(time) + " WHERE lmsplancourse=" + lmsplancourse;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sql);
        } finally
        {
            db.close();
        }
        _cache.remove(lmsplancourse);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM lmsplancourse WHERE lmsplancourse=" + lmsplancourse);
        _cache.remove(lmsplancourse);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE lmsplancourse SET " + f + "=" + DbAdapter.cite(v) + " WHERE lmsplancourse=" + lmsplancourse);
        _cache.remove(lmsplancourse);
    }

    //
    public static LmsPlanCourse find(int lmsplan,int lmscourse) throws SQLException
    {
        ArrayList al = find(" AND lmsplan=" + lmsplan + " AND lmscourse=" + lmscourse,0,1);
        return al.size() < 1 ? new LmsPlanCourse(0) : (LmsPlanCourse) al.get(0);
    }

}
