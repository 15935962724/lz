package tea.entity.kids;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class KReserve
{
    protected static Cache c = new Cache(50);
    public int reserve;
    public static String[] TYPE_TYPE =
                                       {"垃圾","参观","试听"};
    public int type; //类型
    public String name; //家长姓名
    public String tel; //您的电话
    public String email; //您的邮箱
    public String baby; //宝宝姓名
    public int age; //宝宝年龄
    public String address; //您的住址
    public String course; //您希望试听的课程
    public Date vtime;
    public Date ltime; //试听时间
    public String ip;
    public Date time;

    public KReserve(int reserve)
    {
        this.reserve = reserve;
    }

    public static KReserve find(int reserve) throws SQLException
    {
        KReserve t = (KReserve) c.get(reserve);
        if(t == null)
        {
            ArrayList al = find(" AND reserve=" + reserve,0,1);
            t = al.size() < 1 ? new KReserve(reserve) : (KReserve) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT reserve,type,name,tel,email,baby,age,address,course,vtime,ltime,ip,time FROM KReserve WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                KReserve t = new KReserve(rs.getInt(i++));
                t.type = rs.getInt(i++);
                t.name = rs.getString(i++);
                t.tel = rs.getString(i++);
                t.email = rs.getString(i++);
                t.baby = rs.getString(i++);
                t.age = rs.getInt(i++);
                t.address = rs.getString(i++);
                t.course = rs.getString(i++);
                t.vtime = db.getDate(i++);
                t.ltime = db.getDate(i++);
                t.ip = rs.getString(i++);
                t.time = db.getDate(i++);
                c.put(t.reserve,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM KReserve WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if(reserve < 1)
                db.executeUpdate("INSERT INTO KReserve(type,name,tel,email,baby,age,address,course,vtime,ltime,ip,time)VALUES(" + type + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(tel) + "," + DbAdapter.cite(email) + "," + DbAdapter.cite(baby) + "," + age + "," + DbAdapter.cite(address) + "," + DbAdapter.cite(course) + "," + DbAdapter.cite(vtime) + "," + DbAdapter.cite(ltime) + "," + DbAdapter.cite(ip) + "," + DbAdapter.cite(time) + ")");
            else
                db.executeUpdate("UPDATE KReserve SET name=" + DbAdapter.cite(name) + ",tel=" + DbAdapter.cite(tel) + ",email=" + DbAdapter.cite(email) + ",baby=" + DbAdapter.cite(baby) + ",age=" + age + ",address=" + DbAdapter.cite(address) + ",course=" + DbAdapter.cite(course) + ",vtime=" + DbAdapter.cite(vtime) + ",ltime=" + DbAdapter.cite(ltime) + ",ip=" + DbAdapter.cite(ip) + ",time=" + DbAdapter.cite(time) + " WHERE reserve=" + reserve);
        } finally
        {
            db.close();
        }
        c.remove(reserve);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM KReserve WHERE reserve=" + reserve);
        c.remove(reserve);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE KReserve SET " + f + "=" + DbAdapter.cite(v) + " WHERE reserve=" + reserve);
        c.remove(reserve);
    }
}
