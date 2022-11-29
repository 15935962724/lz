package tea.entity.lms;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

//lms_certificate_tab
public class LmsCert
{
    protected static Cache _cache = new Cache(50);
    public int lmscert; //证书类型
    public String code; //证书编号
    public String name; //证书名称
    public String content; //描述
    public static String[] LMSCERT_TYPE =
            {"--","方向证书","阶段证书"};
    public int type; //证书类型
    public static String[] RANK_TYPE =
            {"--","一级","二级"};
    public int rank; //证书等级
    public int status;
    public float price; //申请费用
    public int orgid;
    public int aspid;
    public int member; //创建者
    public Date utime; //更新时间
    public Date time; //创建时间

    public LmsCert(int lmscert)
    {
        this.lmscert = lmscert;
    }

    public static LmsCert find(int lmscert) throws SQLException
    {
        LmsCert t = (LmsCert) _cache.get(lmscert);
        if(t == null)
        {
            ArrayList al = find(" AND lmscert=" + lmscert,0,1);
            t = al.size() < 1 ? new LmsCert(lmscert) : (LmsCert) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT lmscert,code,name,content,type,rank,status,price,orgid,aspid,member,utime,time FROM lmscert WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                LmsCert t = new LmsCert(rs.getInt(i++));
                t.code = rs.getString(i++);
                t.name = rs.getString(i++);
                t.content = rs.getString(i++);
                t.type = rs.getInt(i++);
                t.rank = rs.getInt(i++);
                t.status = rs.getInt(i++);
                t.price = rs.getFloat(i++);
                t.orgid = rs.getInt(i++);
                t.aspid = rs.getInt(i++);
                t.member = rs.getInt(i++);
                t.utime = db.getDate(i++);
                t.time = db.getDate(i++);
                _cache.put(t.lmscert,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM lmscert WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(lmscert < 1)
            sql = "INSERT INTO lmscert(lmscert,code,name,content,type,rank,status,price,orgid,aspid,member,utime,time)VALUES(" + (lmscert = Seq.get()) + "," + DbAdapter.cite(code) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(content) + "," + type + "," + rank + "," + status + "," + price + "," + orgid + "," + aspid + "," + member + "," + DbAdapter.cite(utime) + "," + DbAdapter.cite(time) + ")";
        else
            sql = "UPDATE lmscert SET code=" + DbAdapter.cite(code) + ",name=" + DbAdapter.cite(name) + ",content=" + DbAdapter.cite(content) + ",type=" + type + ",rank=" + rank + ",status=" + status + ",price=" + price + ",orgid=" + orgid + ",aspid=" + aspid + ",member=" + member + ",utime=" + DbAdapter.cite(utime) + ",time=" + DbAdapter.cite(time) + " WHERE lmscert=" + lmscert;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sql);
        } finally
        {
            db.close();
        }
        _cache.remove(lmscert);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM lmscert WHERE lmscert=" + lmscert);
        _cache.remove(lmscert);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE lmscert SET " + f + "=" + DbAdapter.cite(v) + " WHERE lmscert=" + lmscert);
        _cache.remove(lmscert);
    }

    //
    public static String options(String sql,int dv) throws SQLException
    {
        StringBuilder htm = new StringBuilder();
        ArrayList al = find(sql,0,Integer.MAX_VALUE);
        for(int i = 0;i < al.size();i++)
        {
            LmsCert t = (LmsCert) al.get(i);
            htm.append("<option value=" + t.lmscert);
            if(dv == t.lmscert)
                htm.append(" selected");
            htm.append(">" + t.name);
        }
        return htm.toString();
    }

    public static String f(int lmscert) throws SQLException
    {
        return LmsCert.find(lmscert).name;
    }

    public String toString()
    {
        StringBuilder sb = new StringBuilder();
        sb.append("{id:" + lmscert);
        sb.append(",name:" + Attch.cite(name));
        sb.append("}");
        return sb.toString();
    }

}
