package tea.entity.yl.shop;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.entity.*;

public class Refund
{
    protected static Cache c = new Cache(50);
    public int refund; //退款申请
    public int member;
    public int trade; //订单
    public static String[] REFUND_TYPE =
            {"退款至账户余额", "退款至银行卡", "原路返回"};
    public int type; //退款方式
    public static String[] BANK_TYPE =
            {"--", "广东发展银行", "交通银行", "农村商业银行", "农村信用社", "上海浦东发展银行", "深圳发展银行", "兴业银行", "招商银行", "中国工商银行", "中国光大银行", "中国建设银行", "中国民生银行", "中国农业银行"};
    public int bank; //银行
    public int bcity;
    public String baddress;
    public String bname; //开户人姓名
    public String baccount; //开户银行账号
    public String content; //申请原因
    public float money; //退款金额
    public static String[] STATE_TYPE =
            {"未处理", "已批", "未批", "取消"};
    public int state; //状态
    public Date time;

    public Refund(int refund)
    {
        this.refund = refund;
    }

    public static Refund find(int refund) throws SQLException
    {
        Refund t = (Refund) c.get(refund);
        if (t == null)
        {
            ArrayList al = find(" AND refund=" + refund, 0, 1);
            t = al.size() < 1 ? new Refund(refund) : (Refund) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT refund,member,trade,type,bank,bcity,baddress,bname,baccount,content,money,state,time FROM refund WHERE 1=1" + sql + "ORDER BY refund DESC", pos, size);
            while (rs.next())
            {
                int i = 1;
                Refund t = new Refund(rs.getInt(i++));
                t.member = rs.getInt(i++);
                t.trade = rs.getInt(i++);
                t.type = rs.getInt(i++);
                t.bank = rs.getInt(i++);
                t.bcity = rs.getInt(i++);
                t.baddress = rs.getString(i++);
                t.bname = rs.getString(i++);
                t.baccount = rs.getString(i++);
                t.content = rs.getString(i++);
                t.money = rs.getFloat(i++);
                t.state = rs.getInt(i++);
                t.time = db.getDate(i++);
                c.put(t.refund, t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM refund WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if (refund < 1)
            sql = "INSERT INTO refund(refund,member,trade,type,bank,bcity,baddress,bname,baccount,content,money,state,time)VALUES(" + (refund = Seq.get()) + "," + member + "," + trade + "," + type + "," + bank + "," + bcity + "," + DbAdapter.cite(baddress) + "," + DbAdapter.cite(bname) + "," + DbAdapter.cite(baccount) + "," + DbAdapter.cite(content) + "," + money + "," + state + "," + DbAdapter.cite(time) + ")";
        else
            sql = "UPDATE refund SET trade=" + trade + ",type=" + type + ",bank=" + bank + ",bcity=" + bcity + ",baddress=" + DbAdapter.cite(baddress) + ",bname=" + DbAdapter.cite(bname) + ",baccount=" + DbAdapter.cite(baccount) + ",content=" + DbAdapter.cite(content) + ",money=" + money + ",state=" + state + ",time=" + DbAdapter.cite(time) + " WHERE refund=" + refund;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(refund, sql);
        } finally
        {
            db.close();
        }
        c.remove(refund);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(refund, "DELETE FROM refund WHERE refund=" + refund);
        } finally
        {
            db.close();
        }
        c.remove(refund);
    }

    public void set(String f, String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(refund, "UPDATE refund SET " + f + "=" + DbAdapter.cite(v) + " WHERE refund=" + refund);
        } finally
        {
            db.close();
        }
        c.remove(refund);
    }
}
