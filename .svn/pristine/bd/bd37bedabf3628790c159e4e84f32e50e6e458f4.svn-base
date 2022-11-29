package tea.entity.lms;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class LmsPay
{
    protected static Cache _cache = new Cache(50);
    public int lmspay; //缴费单
    public int member; //缴费人
    public String code; //单号
    public int quantity; //人数
    public float price; //金额
    public int voucher; //汇款凭证
    public static String[] PAYMENT_TYPE =
            {"--","在线支付","线下汇款"};
    public int payment; //支付方式
    public static String[] STATUS_TYPE =
            {"--","待审","通过","不通过"};
    public int status; //状态
    public int emember; //审核人
    public Date etime; //审核时间
    public String lmsmembercourse;
    public boolean deleted; //是否已删除
    public Date time; //创建时间

    public LmsPay(int lmspay)
    {
        this.lmspay = lmspay;
    }

    public static LmsPay find(int lmspay) throws SQLException
    {
        LmsPay t = (LmsPay) _cache.get(lmspay);
        if(t == null)
        {
            ArrayList al = find(" AND lmspay=" + lmspay,0,1);
            t = al.size() < 1 ? new LmsPay(lmspay) : (LmsPay) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT lp.lmspay,lp.member,lp.code,lp.quantity,lp.price,lp.voucher,lp.payment,lp.status,lp.emember,lp.etime,lp.lmsmembercourse,lp.deleted,lp.time FROM lmspay lp" + tab(sql) + " WHERE lp.deleted=0" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                LmsPay t = new LmsPay(rs.getInt(i++));
                t.member = rs.getInt(i++);
                t.code = rs.getString(i++);
                t.quantity = rs.getInt(i++);
                t.price = rs.getFloat(i++);
                t.voucher = rs.getInt(i++);
                t.payment = rs.getInt(i++);
                t.status = rs.getInt(i++);
                t.emember = rs.getInt(i++);
                t.etime = db.getDate(i++);
                t.lmsmembercourse = rs.getString(i++);
                t.deleted = rs.getBoolean(i++);
                t.time = db.getDate(i++);
                _cache.put(t.lmspay,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM lmspay lp" + tab(sql) + " WHERE lp.deleted=0" + sql);
    }

    static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if(sql.contains(" AND p."))
            sb.append(" INNER JOIN Profile p ON p.profile=lp.member");
        return sb.toString();
    }

    public void set() throws SQLException
    {
        String sql;
        if(lmspay < 1)
            sql = "INSERT INTO lmspay(lmspay,member,code,quantity,price,voucher,payment,status,emember,etime,lmsmembercourse,deleted,time)VALUES(" + (lmspay = Seq.get()) + "," + member + "," + DbAdapter.cite(code) + "," + quantity + "," + price + "," + voucher + "," + payment + "," + status + "," + emember + "," + DbAdapter.cite(etime) + "," + DbAdapter.cite(lmsmembercourse) + "," + DbAdapter.cite(deleted) + "," + DbAdapter.cite(time) + ")";
        else
            sql = "UPDATE lmspay SET member=" + member + ",code=" + DbAdapter.cite(code) + ",quantity=" + quantity + ",price=" + price + ",voucher=" + voucher + ",payment=" + payment + ",status=" + status + ",emember=" + emember + ",etime=" + DbAdapter.cite(etime) + ",lmsmembercourse=" + DbAdapter.cite(lmsmembercourse) + ",deleted=" + DbAdapter.cite(deleted) + ",time=" + DbAdapter.cite(time) + " WHERE lmspay=" + lmspay;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sql);
        } finally
        {
            db.close();
        }
        _cache.remove(lmspay);
    }

    public void delete() throws SQLException
    {
        //DbAdapter.execute("DELETE FROM lmspay WHERE lmspay=" + lmspay);
        set("deleted","1");
        _cache.remove(lmspay);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE lmspay SET " + f + "=" + DbAdapter.cite(v) + " WHERE lmspay=" + lmspay);
        _cache.remove(lmspay);
    }

    //学员报考 和 缴费记录 关链在一起
    public void setMember(boolean flag) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE lmsmembercourse SET lmspay=" + (flag ? lmspay : 0) + " WHERE 1=1" + lmsmembercourse);
        } finally
        {
            db.close();
        }
    }
}
