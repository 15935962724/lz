package tea.entity.lms;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class LmsLeave
{
    protected static Cache _cache = new Cache(50);
    public int lmsleave; //退学申请
    public int member; //学员
    public int attch; //退学申请表
    public int omember; //操作人
    public static String[] STATE_TYPE =
            {"--","待审","通过","不通过"};
    public int state; //状态
    public int amember; //审核人
    public Date atime; //审核时间
    public Date time; //申请时间

    public LmsLeave(int lmsleave)
    {
        this.lmsleave = lmsleave;
    }

    public static LmsLeave find(int lmsleave) throws SQLException
    {
        LmsLeave t = (LmsLeave) _cache.get(lmsleave);
        if(t == null)
        {
            ArrayList al = find(" AND lmsleave=" + lmsleave,0,1);
            t = al.size() < 1 ? new LmsLeave(lmsleave) : (LmsLeave) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT ll.lmsleave,ll.member,ll.attch,ll.omember,ll.state,ll.amember,ll.atime,ll.time FROM lmsleave ll" + tab(sql) + " WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                LmsLeave t = new LmsLeave(rs.getInt(i++));
                t.member = rs.getInt(i++);
                t.attch = rs.getInt(i++);
                t.omember = rs.getInt(i++);
                t.state = rs.getInt(i++);
                t.amember = rs.getInt(i++);
                t.atime = db.getDate(i++);
                t.time = db.getDate(i++);
                _cache.put(t.lmsleave,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM lmsleave ll" + tab(sql) + " WHERE 1=1" + sql);
    }

    static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if(sql.contains(" AND p."))
            sb.append(" INNER JOIN Profile p ON p.profile=ll.member");
        if(sql.contains(" AND pl.") || sql.contains(" ORDER BY pl."))
            sb.append(" INNER JOIN ProfileLayer pl ON pl.member=p.member");
        if(sql.contains(" AND lo.") || sql.contains(" ORDER BY lo."))
            sb.append(" INNER JOIN lmsorg lo ON lo.lmsorg=p.agent");
        if(sql.contains(" AND pa.") || sql.contains(" ORDER BY pa."))
            sb.append(" LEFT JOIN Profile pa ON pa.profile=ll.amember");
        return sb.toString();
    }

    public void set() throws SQLException
    {
        String sql;
        if(lmsleave < 1)
            sql = "INSERT INTO lmsleave(lmsleave,member,attch,omember,state,amember,atime,time)VALUES(" + (lmsleave = Seq.get()) + "," + member + "," + attch + "," + omember + "," + state + "," + amember + "," + DbAdapter.cite(atime) + "," + DbAdapter.cite(time) + ")";
        else
            sql = "UPDATE lmsleave SET member=" + member + ",attch=" + attch + ",omember=" + omember + ",state=" + state + ",amember=" + amember + ",atime=" + DbAdapter.cite(atime) + ",time=" + DbAdapter.cite(time) + " WHERE lmsleave=" + lmsleave;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sql);
        } finally
        {
            db.close();
        }
        _cache.remove(lmsleave);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM lmsleave WHERE lmsleave=" + lmsleave);
        _cache.remove(lmsleave);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE lmsleave SET " + f + "=" + DbAdapter.cite(v) + " WHERE lmsleave=" + lmsleave);
        _cache.remove(lmsleave);
    }
}
