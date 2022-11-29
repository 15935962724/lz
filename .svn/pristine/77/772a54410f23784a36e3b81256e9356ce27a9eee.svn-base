package tea.entity.node;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class CoursePlan
{
    protected static Cache c = new Cache(50);
    public int courseplan;
    public int node; //课程
    public int member; //用户
    public float price; //付款金额
    public static String[] PAYMENT_TYPE =
            {"---","到付","汇款"};
    public int payment; //支付方式
    public static String[] ISPAY_TYPE =
            {"---","待付款","已付款"};
    public int ispay; //付款状态
    public String paynote; //付款备注
    public int paymember; //付款状态操作者
    public Date paytime; //付款时间
    public static String[] STATE_TYPE =
            {"---","待审","通过","未通过"};
    public int state; //状态
    public boolean deleted;
    public Date time; //报名时间

    public CoursePlan(int courseplan)
    {
        this.courseplan = courseplan;
    }

    public static CoursePlan find(int courseplan) throws SQLException
    {
        CoursePlan t = (CoursePlan) c.get(courseplan);
        if(t == null)
        {
            ArrayList al = find(" AND courseplan=" + courseplan,0,1);
            t = al.size() < 1 ? new CoursePlan(courseplan) : (CoursePlan) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT courseplan,node,member,price,payment,ispay,paynote,paymember,paytime,state,deleted,time FROM courseplan WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                CoursePlan t = new CoursePlan(rs.getInt(i++));
                t.node = rs.getInt(i++);
                t.member = rs.getInt(i++);
                t.price = rs.getFloat(i++);
                t.payment = rs.getInt(i++);
                t.ispay = rs.getInt(i++);
                t.paynote = rs.getString(i++);
                t.paymember = rs.getInt(i++);
                t.paytime = db.getDate(i++);
                t.state = rs.getInt(i++);
                t.deleted = rs.getBoolean(i++);
                t.time = db.getDate(i++);
                c.put(t.courseplan,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM courseplan WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if(courseplan < 1)
                db.executeUpdate("INSERT INTO courseplan(node,member,price,payment,ispay,paynote,paymember,paytime,state,deleted,time)VALUES(" + node + "," + member + "," + price + "," + payment + "," + ispay + "," + DbAdapter.cite(paynote) + "," + paymember + "," + DbAdapter.cite(paytime) + "," + state + "," + DbAdapter.cite(deleted) + "," + DbAdapter.cite(time) + ")");
            else
                db.executeUpdate("UPDATE courseplan SET member=" + member + ",price=" + price + ",payment=" + payment + ",ispay=" + ispay + ",paynote=" + DbAdapter.cite(paynote) + ",paymember=" + paymember + ",paytime=" + DbAdapter.cite(paytime) + ",state=" + state + ",deleted=" + DbAdapter.cite(deleted) + ",time=" + DbAdapter.cite(time) + " WHERE courseplan=" + courseplan);
        } finally
        {
            db.close();
        }
        c.remove(courseplan);
    }

    public void delete() throws SQLException
    {
        //DbAdapter.execute("DELETE FROM courseplan WHERE courseplan=" + courseplan);
        deleted = true;
        set("deleted","1");
        c.remove(courseplan);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE courseplan SET " + f + "=" + DbAdapter.cite(v) + " WHERE courseplan=" + courseplan);
        c.remove(courseplan);
    }
}
