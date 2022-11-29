package tea.entity.lms;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

//LMS_APPLY_TAB
public class LmsPlan
{
    protected static Cache _cache = new Cache(50);
    public int lmsplan; //考试计划
    public int lmsorg;
    public String name; //标题名称
    public int member; //创建人
    public int father; //父计划
    public int city; //城市
    public Date starttime; //机考报考开始时间
    public Date endtime; //机考报考结束时间
    public static String[] STATUS_TYPE =
            {"--","待审核","审核通过","审核不通过","已使用"};
    public int status; //计划状态
    public Date pstarttime; //实践环节报考开始时间
    public Date pendtime; //实践环节报考结束时间
    public int emember; //审核人
    public Date etime; //审核时间
    public String remark1;
    public String remark2;
    public String remark3; //计划类型，1：机考，2：实践环节，3：机考+实践环节
    public String remark4;
    public String remark5; //0代表报考学员未生成准考证，1代表报考学员生成准考证
    public boolean deleted; //是否已删除
    public Date time; //创建时间
    //课程安排
    public int cmember; //创建人
    public Date ctime; //创建时间

    public LmsPlan(int lmsplan)
    {
        this.lmsplan = lmsplan;
    }

    public static LmsPlan getInstance() throws SQLException
    {
        ArrayList al = LmsPlan.find(" AND father=0 AND status IN(2,4) ORDER BY time DESC",0,Integer.MAX_VALUE);
        return al.size() < 1 ? new LmsPlan(0) : (LmsPlan) al.get(0);
    }

    public static LmsPlan find(int lmsplan) throws SQLException
    {
        LmsPlan t = (LmsPlan) _cache.get(lmsplan);
        if(t == null)
        {
            ArrayList al = find(" AND lmsplan=" + lmsplan,0,1);
            t = al.size() < 1 ? new LmsPlan(lmsplan) : (LmsPlan) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT lp.lmsplan,lp.lmsorg,lp.name,lp.member,lp.father,lp.city,lp.starttime,lp.endtime,lp.status,lp.pstarttime,lp.pendtime,lp.emember,lp.etime,lp.remark1,lp.remark2,lp.remark3,lp.remark4,lp.remark5,lp.deleted,lp.time,lp.cmember,lp.ctime FROM lmsplan lp" + tab(sql) + " WHERE deleted=0" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                LmsPlan t = new LmsPlan(rs.getInt(i++));
                t.lmsorg = rs.getInt(i++);
                t.name = rs.getString(i++);
                t.member = rs.getInt(i++);
                t.father = rs.getInt(i++);
                t.city = rs.getInt(i++);
                t.starttime = db.getDate(i++);
                t.endtime = db.getDate(i++);
                t.status = rs.getInt(i++);
                t.pstarttime = db.getDate(i++);
                t.pendtime = db.getDate(i++);
                t.emember = rs.getInt(i++);
                t.etime = db.getDate(i++);
                t.remark1 = rs.getString(i++);
                t.remark2 = rs.getString(i++);
                t.remark3 = rs.getString(i++);
                t.remark4 = rs.getString(i++);
                t.remark5 = rs.getString(i++);
                t.deleted = rs.getBoolean(i++);
                t.time = db.getDate(i++);
                //
                t.cmember = rs.getInt(i++);
                t.ctime = db.getDate(i++);
                _cache.put(t.lmsplan,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM lmsplan lp" + tab(sql) + " WHERE 1=1" + sql);
    }

    static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if(sql.contains(" AND cp."))
            sb.append(" INNER JOIN Profile cp ON cp.profile=lp.cmember");
        return sb.toString();
    }

    public void set() throws SQLException
    {
        String sql;
        if(lmsplan < 1)
            sql = "INSERT INTO lmsplan(lmsplan,lmsorg,name,member,father,city,starttime,endtime,status,pstarttime,pendtime,emember,etime,remark1,remark2,remark3,remark4,remark5,deleted,time,cmember,ctime)VALUES(" + (lmsplan = Seq.get()) + "," + lmsorg + "," + DbAdapter.cite(name) + "," + member + "," + father + "," + city + "," + DbAdapter.cite(starttime) + "," + DbAdapter.cite(endtime) + "," + status + "," + DbAdapter.cite(pstarttime) + "," + DbAdapter.cite(pendtime) + "," + emember + "," + DbAdapter.cite(etime) + "," + DbAdapter.cite(remark1) + "," + DbAdapter.cite(remark2) + "," + DbAdapter.cite(remark3) + "," + DbAdapter.cite(remark4) + "," + DbAdapter.cite(remark5) + "," + DbAdapter.cite(deleted) + "," + DbAdapter.cite(time) + "," + cmember + "," + DbAdapter.cite(ctime) + ")";
        else
            sql = "UPDATE lmsplan SET lmsorg=" + lmsorg + ",name=" + DbAdapter.cite(name) + ",member=" + member + ",father=" + father + ",city=" + city + ",starttime=" + DbAdapter.cite(starttime) + ",endtime=" + DbAdapter.cite(endtime) + ",status=" + status + ",pstarttime=" + DbAdapter.cite(pstarttime) + ",pendtime=" + DbAdapter.cite(pendtime) + ",emember=" + emember + ",etime=" + DbAdapter.cite(etime) + ",remark1=" + DbAdapter.cite(remark1) + ",remark2=" + DbAdapter.cite(remark2) + ",remark3=" + DbAdapter.cite(remark3) + ",remark4=" + DbAdapter.cite(remark4) + ",remark5=" + DbAdapter.cite(remark5) + ",deleted=" + DbAdapter.cite(deleted) + ",time=" + DbAdapter.cite(time) + ",cmember=" + cmember + ",ctime=" + DbAdapter.cite(ctime) + " WHERE lmsplan=" + lmsplan;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(lmsplan,sql);
        } finally
        {
            db.close();
        }
        _cache.remove(lmsplan);
    }

    public void delete() throws SQLException
    {
        deleted = true;
        set("deleted","1");
        //DbAdapter.execute("DELETE FROM lmsplan WHERE lmsplan=" + lmsplan);
        _cache.remove(lmsplan);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE lmsplan SET " + f + "=" + DbAdapter.cite(v) + " WHERE lmsplan=" + lmsplan);
        _cache.remove(lmsplan);
    }

    //
    public static String options(String sql,int dv) throws SQLException
    {
        StringBuilder htm = new StringBuilder();
        ArrayList al = find(sql,0,Integer.MAX_VALUE);
        for(int i = 0;i < al.size();i++)
        {
            LmsPlan t = (LmsPlan) al.get(i);
            htm.append("<option value=" + t.lmsplan);
            if(dv == t.lmsplan)
                htm.append(" selected");
            htm.append(">" + t.name);
        }
        return htm.toString();
    }

    public String toString()
    {
        StringBuilder sb = new StringBuilder();
        sb.append("{id:" + lmsplan);
        sb.append(",name:" + Attch.cite(name));
        sb.append("}");
        return sb.toString();
    }

    //
    public static LmsPlan find(int lmsplan,int city) throws SQLException
    {
        ArrayList al = find(" AND(lmsplan=" + lmsplan + " OR(father=" + lmsplan + " AND city=" + city + ")) AND status=2 ORDER BY father DESC",0,1);
        return al.size() < 1 ? new LmsPlan(lmsplan) : (LmsPlan) al.get(0);
    }

}
