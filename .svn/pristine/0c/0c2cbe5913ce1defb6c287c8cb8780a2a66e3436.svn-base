package tea.entity.admin;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class SupAgent
{
    protected static Cache c = new Cache(50);
    public int agent; //经办人
    public int supplier;
    public String name; //姓名
    public String tel; //电话
    public String mobile; //手机
    public String email; //E-Mail
    public String idcard; //身份证号
    public int copy; //身份证复印件
    public int auth; //授权证明
    public boolean deleted;
    public Date time;

    public SupAgent(int agent)
    {
        this.agent = agent;
    }

    public static SupAgent find(int agent) throws SQLException
    {
        SupAgent t = (SupAgent) c.get(agent);
        if(t == null)
        {
            ArrayList al = find(" AND agent=" + agent,0,1);
            t = al.size() < 1 ? new SupAgent(agent) : (SupAgent) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT agent,supplier,name,tel,mobile,email,idcard,copy,auth,deleted,time FROM supagent WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                SupAgent t = new SupAgent(rs.getInt(i++));
                t.supplier = rs.getInt(i++);
                t.name = rs.getString(i++);
                t.tel = rs.getString(i++);
                t.mobile = rs.getString(i++);
                t.email = rs.getString(i++);
                t.idcard = rs.getString(i++);
                t.copy = rs.getInt(i++);
                t.auth = rs.getInt(i++);
                t.deleted = rs.getBoolean(i++);
                t.time = db.getDate(i++);
                c.put(t.agent,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM supagent WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(agent < 1)
            sql = "INSERT INTO supagent(agent,supplier,name,tel,mobile,email,idcard,copy,auth,deleted,time)VALUES(" + (agent = Seq.get()) + "," + supplier + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(tel) + "," + DbAdapter.cite(mobile) + "," + DbAdapter.cite(email) + "," + DbAdapter.cite(idcard) + "," + copy + "," + auth + "," + DbAdapter.cite(deleted) + "," + DbAdapter.cite(time) + ")";
        else
            sql = "UPDATE supagent SET supplier=" + supplier + ",name=" + DbAdapter.cite(name) + ",tel=" + DbAdapter.cite(tel) + ",mobile=" + DbAdapter.cite(mobile) + ",email=" + DbAdapter.cite(email) + ",idcard=" + DbAdapter.cite(idcard) + ",copy=" + copy + ",auth=" + auth + ",deleted=" + DbAdapter.cite(deleted) + ",time=" + DbAdapter.cite(time) + " WHERE agent=" + agent;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(agent,sql);
        } finally
        {
            db.close();
        }
        c.remove(agent);
    }

    public void delete() throws SQLException
    {
        deleted = true;
        set("deleted","1");
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(agent,"UPDATE supagent SET " + f + "=" + DbAdapter.cite(v) + " WHERE agent=" + agent);
        } finally
        {
            db.close();
        }
        c.remove(agent);
    }

    //
    public static ArrayList findBySupplier(int supplier) throws SQLException
    {
        ArrayList al = find(" AND supplier=" + supplier,0,200);
        for(int i = 3 - al.size();i > 0;i--)
        {
            SupAgent t = new SupAgent(0);
            t.supplier = supplier;
            t.mobile = t.name = "";
            t.set();
            al.add(t);
        }
        return al;
    }

}
