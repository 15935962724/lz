package tea.entity.lms;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class LmsPrice
{
    protected static Cache _cache = new Cache(50);
    public int lmsprice; //相关费用
    public int lmsplan; //考试计划
    public int father; //父计划
    public int city; //省
    public int lmsorg; //省助学发展机构
    public int member; //创建人
    static String[] PRICE_TYPE =
            {"--","实践考费","机考费","实践环节重考费","培训费","考试费","项目管理费","省级管理费"};
    public float[] price = new float[8];
    public static String[] STATUS_TYPE =
            {"--","待审核","通过","不通过"};
    public int status; //审批状态
    public int emember; //审核人
    public Date etime; //审核时间
    public boolean deleted; //是否已删除
    public Date time; //创建时间

    public LmsPrice(int lmsprice)
    {
        this.lmsprice = lmsprice;
    }

    LmsPrice(int lmsplan,int city)
    {
        this.lmsplan = lmsplan;
        this.city = city;
    }

    public static LmsPrice find(int lmsprice) throws SQLException
    {
        LmsPrice t = (LmsPrice) _cache.get(lmsprice);
        if(t == null)
        {
            ArrayList al = find(" AND lmsprice=" + lmsprice,0,1);
            t = al.size() < 1 ? new LmsPrice(lmsprice) : (LmsPrice) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT lp.lmsprice,lp.lmsplan,lp.father,lp.city,lp.lmsorg,lp.member,lp.price1,lp.price2,lp.price3,lp.price4,lp.price5,lp.price6,lp.price7,lp.status,lp.emember,lp.etime,lp.deleted,lp.time FROM lmsprice lp WHERE lp.deleted=0" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                LmsPrice t = new LmsPrice(rs.getInt(i++));
                t.lmsplan = rs.getInt(i++);
                t.father = rs.getInt(i++);
                t.city = rs.getInt(i++);
                t.lmsorg = rs.getInt(i++);
                t.member = rs.getInt(i++);
                t.price[1] = rs.getFloat(i++);
                t.price[2] = rs.getFloat(i++);
                t.price[3] = rs.getFloat(i++);
                t.price[4] = rs.getFloat(i++);
                t.price[5] = rs.getFloat(i++);
                t.price[6] = rs.getFloat(i++);
                t.price[7] = rs.getFloat(i++);
                t.status = rs.getInt(i++);
                t.emember = rs.getInt(i++);
                t.etime = db.getDate(i++);
                t.deleted = rs.getBoolean(i++);
                t.time = db.getDate(i++);
                _cache.put(t.lmsprice,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM lmsprice lp WHERE lp.deleted=0" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(lmsprice < 1)
            sql = "INSERT INTO lmsprice(lmsprice,lmsplan,father,city,lmsorg,member,price1,price2,price3,price4,price5,price6,price7,status,emember,etime,deleted,time)VALUES(" + (lmsprice = Seq.get()) + "," + lmsplan + "," + father + "," + city + "," + lmsorg + "," + member + "," + price[1] + "," + price[2] + "," + price[3] + "," + price[4] + "," + price[5] + "," + price[6] + "," + price[7] + "," + status + "," + emember + "," + DbAdapter.cite(etime) + "," + deleted + "," + DbAdapter.cite(time) + ")";
        else
            sql = "UPDATE lmsprice SET lmsplan=" + lmsplan + ",father=" + father + ",city=" + city + ",lmsorg=" + lmsorg + ",member=" + member + ",price1=" + price[1] + ",price2=" + price[2] + ",price3=" + price[3] + ",price4=" + price[4] + ",price5=" + price[5] + ",price6=" + price[6] + ",price7=" + price[7] + ",status=" + status + ",emember=" + emember + ",etime=" + DbAdapter.cite(etime) + ",deleted=" + deleted + ",time=" + DbAdapter.cite(time) + " WHERE lmsprice=" + lmsprice;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sql);
        } finally
        {
            db.close();
        }
        _cache.remove(lmsprice);
    }

    public void delete() throws SQLException
    {
        deleted = true;
        set("deleted","1");
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE lmsprice SET " + f + "=" + DbAdapter.cite(v) + " WHERE lmsprice=" + lmsprice);
        _cache.remove(lmsprice);
    }

    //
    public static LmsPrice find(int lmsplan,int city) throws SQLException
    {
        ArrayList al = find(" AND lmsplan=" + lmsplan + " AND status=2 AND city IN(" + city + ",0) ORDER BY city DESC",0,1);
        return al.size() < 1 ? new LmsPrice(lmsplan,city) : (LmsPrice) al.get(0);
    }

}
