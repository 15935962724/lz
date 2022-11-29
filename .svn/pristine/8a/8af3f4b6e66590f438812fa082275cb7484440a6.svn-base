package tea.entity.lms;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

//C_MASTER_TAB
public class LmsCourse
{
    protected static Cache _cache = new Cache(50);
    public int lmscourse; //课程信息
    public String code; //课程代码
    public static String[] COURSE_TYPE =
            {"--","证书基础课","证书方向课"};
    public int type; //类型
    public String name; //名称
    public String address; //课件地址
    public String content; //描述
    public int lmscert; //证书分类
    public int aspid;
    public int member; //创建者
    public String planning; //课件地址
    public int problem; //习题
    public int catalogid;
    public int objectid;
    public float period; //课时
    public float credit; //学分
    public static String[] STATUS_TYPE =
            {"--","可用","不可用"};
    public int status; //状态
    public String operator; //主编
    public Date utime; //修改时间
    public boolean deleted; //是否已删除
    public Date time; //创建时间

    public LmsCourse(int lmscourse)
    {
        this.lmscourse = lmscourse;
    }

    public static LmsCourse find(int lmscourse) throws SQLException
    {
        LmsCourse t = (LmsCourse) _cache.get(lmscourse);
        if(t == null)
        {
            ArrayList al = find(" AND lmscourse=" + lmscourse,0,1);
            t = al.size() < 1 ? new LmsCourse(lmscourse) : (LmsCourse) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT lmscourse,code,type,name,address,content,lmscert,aspid,member,planning,problem,catalogid,objectid,period,credit,status,operator,utime,deleted,time FROM lmscourse WHERE deleted=0" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                LmsCourse t = new LmsCourse(rs.getInt(i++));
                t.code = rs.getString(i++);
                t.type = rs.getInt(i++);
                t.name = rs.getString(i++);
                t.address = rs.getString(i++);
                t.content = rs.getString(i++);
                t.lmscert = rs.getInt(i++);
                t.aspid = rs.getInt(i++);
                t.member = rs.getInt(i++);
                t.planning = rs.getString(i++);
                t.problem = rs.getInt(i++);
                t.catalogid = rs.getInt(i++);
                t.objectid = rs.getInt(i++);
                t.period = rs.getFloat(i++);
                t.credit = rs.getFloat(i++);
                t.status = rs.getInt(i++);
                t.operator = rs.getString(i++);
                t.utime = db.getDate(i++);
                t.deleted = rs.getBoolean(i++);
                t.time = db.getDate(i++);
                _cache.put(t.lmscourse,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM lmscourse WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(lmscourse < 1)
            sql = "INSERT INTO lmscourse(lmscourse,code,type,name,address,content,lmscert,aspid,member,planning,problem,catalogid,objectid,period,credit,status,operator,utime,deleted,time)VALUES(" + (lmscourse = Seq.get()) + "," + DbAdapter.cite(code) + "," + type + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(address) + "," + DbAdapter.cite(content) + "," + lmscert + "," + aspid + "," + member + "," + DbAdapter.cite(planning) + "," + problem + "," + catalogid + "," + objectid + "," + period + "," + credit + "," + status + "," + DbAdapter.cite(operator) + "," + DbAdapter.cite(utime) + "," + DbAdapter.cite(deleted) + "," + DbAdapter.cite(time) + ")";
        else
            sql = "UPDATE lmscourse SET code=" + DbAdapter.cite(code) + ",type=" + type + ",name=" + DbAdapter.cite(name) + ",address=" + DbAdapter.cite(address) + ",content=" + DbAdapter.cite(content) + ",lmscert=" + lmscert + ",aspid=" + aspid + ",member=" + member + ",planning=" + DbAdapter.cite(planning) + ",catalogid=" + catalogid + ",problem=" + problem + ",objectid=" + objectid + ",period=" + period + ",credit=" + credit + ",status=" + status + ",operator=" + DbAdapter.cite(operator) + ",utime=" + DbAdapter.cite(utime) + ",deleted=" + DbAdapter.cite(deleted) + ",time=" + DbAdapter.cite(time) + " WHERE lmscourse=" + lmscourse;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sql);
        } finally
        {
            db.close();
        }
        _cache.remove(lmscourse);
    }

    public void delete() throws SQLException
    {
        deleted = true;
        set("deleted","1");
        //DbAdapter.execute("DELETE FROM lmscourse WHERE lmscourse=" + lmscourse);
        _cache.remove(lmscourse);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE lmscourse SET " + f + "=" + DbAdapter.cite(v) + " WHERE lmscourse=" + lmscourse);
        _cache.remove(lmscourse);
    }

    //
    public String getName()
    {
        return(status == 2 ? "<s>" : "") + MT.f(name) + "</s>";
    }

    public static String options(String sql,int dv) throws SQLException
    {
        StringBuilder htm = new StringBuilder();
        ArrayList al = find(sql,0,Integer.MAX_VALUE);
        for(int i = 0;i < al.size();i++)
        {
            LmsCourse t = (LmsCourse) al.get(i);
            htm.append("<option value=" + t.lmscourse);
            if(dv == t.lmscourse)
                htm.append(" selected");
            htm.append(">" + t.name);
        }
        return htm.toString();
    }

    public String toString()
    {
        StringBuilder sb = new StringBuilder();
        sb.append("{id:" + lmscourse);
        sb.append(",name:" + Attch.cite(name));
        sb.append(",lmscert:" + lmscert);
        sb.append(",status:" + status);
        sb.append("}");
        return sb.toString();
    }
}
