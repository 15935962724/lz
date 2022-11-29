package tea.entity.lms;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class LmsIncome
{
    protected static Cache _cache = new Cache(50);
    public int lmsincome; //机考费
    public int city; //城市
    public Date starttime; //启用时间
    public Date endtime; //停用时间
    public float price; //收费标准
    public static String[] STATE_TYPE =
            {"--","待审核","通过","不通过"};
    public static String[] INCOME_TYPE =
            {"--","机考费","课程实践环节费","实践环节重考费","培训费","考试费","管理费"};
    public int type; //分类
    public int state; //审批状态
    public int unlimited; //是否长久有效 1：长久有效
    public boolean deleted; //是否已删除
    public Date time; //创建时间

    public LmsIncome(int lmsincome)
    {
        this.lmsincome = lmsincome;
    }

    public static LmsIncome find(int lmsincome) throws SQLException
    {
        LmsIncome t = (LmsIncome) _cache.get(lmsincome);
        if(t == null)
        {
            ArrayList al = find(" AND lmsincome=" + lmsincome,0,1);
            t = al.size() < 1 ? new LmsIncome(lmsincome) : (LmsIncome) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT lmsincome,city,starttime,endtime,price,type,state,unlimited,deleted,time FROM lmsincome WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                LmsIncome t = new LmsIncome(rs.getInt(i++));
                t.city = rs.getInt(i++);
                t.starttime = db.getDate(i++);
                t.endtime = db.getDate(i++);
                t.price = rs.getFloat(i++);
                t.type = rs.getInt(i++);
                t.state = rs.getInt(i++);
                t.unlimited = rs.getInt(i++);
                t.deleted = rs.getBoolean(i++);
                t.time = db.getDate(i++);
                _cache.put(t.lmsincome,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM lmsincome WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(lmsincome < 1)
            sql = "INSERT INTO lmsincome(lmsincome,city,starttime,endtime,price,type,state,unlimited,deleted,time)VALUES(" + (lmsincome = Seq.get()) + "," + city + "," + DbAdapter.cite(starttime) + "," + DbAdapter.cite(endtime) + "," + price + "," + type + "," + state + "," + unlimited + "," + DbAdapter.cite(deleted) + "," + DbAdapter.cite(time) + ")";
        else
            sql = "UPDATE lmsincome SET city=" + city + ",starttime=" + DbAdapter.cite(starttime) + ",endtime=" + DbAdapter.cite(endtime) + ",price=" + price + ",type=" + type + ",state=" + state + ",unlimited=" + unlimited + ",deleted=" + DbAdapter.cite(deleted) + ",time=" + DbAdapter.cite(time) + " WHERE lmsincome=" + lmsincome;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sql);
        } finally
        {
            db.close();
        }
        _cache.remove(lmsincome);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM lmsincome WHERE lmsincome=" + lmsincome);
        _cache.remove(lmsincome);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE lmsincome SET " + f + "=" + DbAdapter.cite(v) + " WHERE lmsincome=" + lmsincome);
        _cache.remove(lmsincome);
    }

    public static LmsIncome find(Date time,int type,int city) throws SQLException
    {
        String sql = " AND deleted=0 AND state=2 AND starttime<" + DbAdapter.cite(time) + " AND endtime>" + DbAdapter.cite(time) + " AND type=" + type + " AND city=";
        ArrayList al = LmsIncome.find(sql + city,0,1);
        if(al.size() < 1)
            al = LmsIncome.find(sql + 0,0,1);
        return al.size() < 1 ? new LmsIncome(0) : (LmsIncome) al.get(0);
    }
}
