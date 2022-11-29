package tea.entity.node;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class BBSActivity
{
    protected static Cache c = new Cache(50);
    public int bbsactivity; //论坛活动
    public int node; //节点
    public String member; //申请者
    public int payment; //支付方式
    public float cost; //支付元
    public String contact; //联系方式
    public String remark; //留言
    public static String[] STATE_TYPE =
            {"未处理","允许参加"};
    public int state; //状态
    public Date time; //申请时间

    public BBSActivity(int bbsactivity)
    {
        this.bbsactivity = bbsactivity;
    }

    public static BBSActivity find(int bbsactivity) throws SQLException
    {
        BBSActivity t = (BBSActivity) c.get(bbsactivity);
        if(t == null)
        {
            ArrayList al = find(" AND bbsactivity=" + bbsactivity,0,1);
            t = al.size() < 1 ? new BBSActivity(bbsactivity) : (BBSActivity) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT bbsactivity,node,member,payment,cost,contact,remark,state,time FROM BBSActivity WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                BBSActivity t = new BBSActivity(rs.getInt(i++));
                t.node = rs.getInt(i++);
                t.member = rs.getString(i++);
                t.payment = rs.getInt(i++);
                t.cost = rs.getFloat(i++);
                t.contact = rs.getString(i++);
                t.remark = rs.getString(i++);
                t.state = rs.getInt(i++);
                t.time = db.getDate(i++);
                c.put(t.bbsactivity,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM BBSActivity WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if(bbsactivity < 1)
                db.executeUpdate("INSERT INTO BBSActivity(node,member,payment,cost,contact,remark,state,time)VALUES(" + node + "," + DbAdapter.cite(member) + "," + payment + "," + cost + "," + DbAdapter.cite(contact) + "," + DbAdapter.cite(remark) + "," + state + "," + DbAdapter.cite(time) + ")");
            else
                db.executeUpdate("UPDATE BBSActivity SET node=" + node + ",member=" + DbAdapter.cite(member) + ",payment=" + payment + ",cost=" + cost + ",contact=" + DbAdapter.cite(contact) + ",remark=" + DbAdapter.cite(remark) + ",state=" + state + ",time=" + DbAdapter.cite(time) + " WHERE bbsactivity=" + bbsactivity);
        } finally
        {
            db.close();
        }
        c.remove(bbsactivity);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM BBSActivity WHERE bbsactivity=" + bbsactivity);
        c.remove(bbsactivity);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE BBSActivity SET " + f + "=" + DbAdapter.cite(v) + " WHERE bbsactivity=" + bbsactivity);
        c.remove(bbsactivity);
    }
}
