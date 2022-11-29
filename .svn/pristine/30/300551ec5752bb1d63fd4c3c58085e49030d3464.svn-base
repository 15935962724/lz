package tea.entity.node;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class RSearch
{
    protected static Cache c = new Cache(50);
    public int rsearch; //搜索器
    public String member; //用户
    public String name; //
    public int sex = 1; //性别
    public int age = -1; //年龄
    public String degree; //学历
    public String expectcity; //期望工作地区
    public int experience; //工作经验
    public String expectcareer; //期望工作职业
    public int majorcategory = -1; //专业
    public int hits;
    public Date time; //创建时间

    public RSearch(int rsearch)
    {
        this.rsearch = rsearch;
    }

    public static RSearch find(int rsearch) throws SQLException
    {
        RSearch t = (RSearch) c.get(rsearch);
        if(t == null)
        {
            ArrayList al = find(" AND rsearch=" + rsearch,0,1);
            t = al.size() < 1 ? new RSearch(rsearch) : (RSearch) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT rsearch,member,name,sex,age,degree,expectcity,experience,expectcareer,majorcategory,hits,time FROM RSearch WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                RSearch t = new RSearch(rs.getInt(i++));
                t.member = rs.getString(i++);
                t.name = rs.getString(i++);
                t.sex = rs.getInt(i++);
                t.age = rs.getInt(i++);
                t.degree = rs.getString(i++);
                t.expectcity = rs.getString(i++);
                t.experience = rs.getInt(i++);
                t.expectcareer = rs.getString(i++);
                t.majorcategory = rs.getInt(i++);
                t.hits = rs.getInt(i++);
                t.time = db.getDate(i++);
                c.put(t.rsearch,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM RSearch WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if(rsearch < 1)
                db.executeUpdate("INSERT INTO RSearch(member,name,sex,age,degree,expectcity,experience,expectcareer,majorcategory,hits,time)VALUES(" + DbAdapter.cite(member) + "," +DbAdapter.cite(name) + "," + sex + "," + age + "," + DbAdapter.cite(degree) + "," + DbAdapter.cite(expectcity) + "," + experience + "," + DbAdapter.cite(expectcareer) + "," + majorcategory + "," + hits+ "," + DbAdapter.cite(time) + ")");
            else
                db.executeUpdate("UPDATE RSearch SET name=" + DbAdapter.cite(name) + ",sex=" + sex + ",age=" + age + ",degree=" + DbAdapter.cite(degree) + ",expectcity=" + DbAdapter.cite(expectcity) + ",experience=" + experience + ",expectcareer=" + DbAdapter.cite(expectcareer) + ",majorcategory=" + majorcategory+ ",hits=" + hits + ",time=" + DbAdapter.cite(time) + " WHERE rsearch=" + rsearch);
        } finally
        {
            db.close();
        }
        c.remove(rsearch);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM RSearch WHERE rsearch=" + rsearch);
        c.remove(rsearch);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE RSearch SET " + f + "=" + DbAdapter.cite(v) + " WHERE rsearch=" + rsearch);
        c.remove(rsearch);
    }
    //
}
