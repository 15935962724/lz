package tea.entity.site;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class JobType
{
    protected static Cache c = new Cache(50);
    public int jobtype; //职位类别
    public String community; //社区
    public String name; //名称
    public static String[] STATE_TYPE =
            {"默认","隐藏","删除"};
    public int state; //状态
    public int sequence; //顺序
    public Date time; //时间

    public JobType(int jobtype)
    {
        this.jobtype = jobtype;
    }

    public static JobType find(int jobtype) throws SQLException
    {
        JobType t = (JobType) c.get(jobtype);
        if(t == null)
        {
            ArrayList al = find(" AND jobtype=" + jobtype,0,1);
            t = al.size() < 1 ? new JobType(jobtype) : (JobType) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT jobtype,community,name,state,sequence,time FROM jobtype WHERE 1=1" + sql + " ORDER BY sequence",pos,size);
            while(rs.next())
            {
                int i = 1;
                JobType t = new JobType(rs.getInt(i++));
                t.community = rs.getString(i++);
                t.name = rs.getString(i++);
                t.state = rs.getInt(i++);
                t.sequence = rs.getInt(i++);
                t.time = db.getDate(i++);
                c.put(t.jobtype,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM jobtype WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(jobtype < 1)
            sql = "INSERT INTO jobtype(community,name,state,sequence,time)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(name) + "," + state + "," + sequence + "," + DbAdapter.cite(time) + ")";
        else
            sql = "UPDATE jobtype SET community=" + DbAdapter.cite(community) + ",name=" + DbAdapter.cite(name) + ",state=" + state + ",sequence=" + sequence + ",time=" + DbAdapter.cite(time) + " WHERE jobtype=" + jobtype;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(jobtype,sql);
        } finally
        {
            db.close();
        }
        c.remove(jobtype);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(jobtype,"DELETE FROM jobtype WHERE jobtype=" + jobtype);
        } finally
        {
            db.close();
        }
        c.remove(jobtype);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(jobtype,"UPDATE jobtype SET " + f + "=" + DbAdapter.cite(v) + " WHERE jobtype=" + jobtype);
        } finally
        {
            db.close();
        }
        c.remove(jobtype);
    }

    public static String options(String community,int dv) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        Iterator it = find(" AND community=" + DbAdapter.cite(community) + " AND state=0",0,200).iterator();
        while(it.hasNext())
        {
            JobType t = (JobType) it.next();
            sb.append("<option value=" + t.jobtype);
            if(t.jobtype == dv)
                sb.append(" selected");
            sb.append(">" + t.name);
        }
        return sb.toString();
    }
}
