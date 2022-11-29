package tea.entity.admin;

import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class Flowreading
{
    protected static Cache c = new Cache(50);
    public int flowreading;
    public String member;
    public int flowbusiness;
    public int flowview;
    public String name;
    public String code;
    public Date time;

    public Flowreading(int flowreading)
    {
        this.flowreading = flowreading;
    }

    public static Flowreading find(int flowreading) throws SQLException
    {
        Flowreading t = (Flowreading) c.get(flowreading);
        if(t == null)
        {
            ArrayList al = find(" AND flowreading=" + flowreading,0,1);
            t = al.size() < 1 ? new Flowreading(flowreading) : (Flowreading) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT flowreading,member,flowbusiness,flowview,name,code,time FROM Flowreading fr WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                Flowreading t = new Flowreading(rs.getInt(i++));
                t.member = rs.getString(i++);
                t.flowbusiness = rs.getInt(i++);
                t.flowview = rs.getInt(i++);
                t.name = rs.getString(i++);
                t.code = rs.getString(i++);
                t.time = db.getDate(i++);
                c.put(t.flowreading,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM Flowreading fr WHERE 1=1" + sql);
    }

    public static void create(String member,int flowbusiness,int flowview,String name,String code) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Flowreading(member,flowbusiness,flowview,name,code,time)VALUES(" + DbAdapter.cite(member) + "," + flowbusiness + "," + flowview + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(code) + "," + DbAdapter.cite(new Date()) + ")");
        } finally
        {
            db.close();
        }
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM Flowreading WHERE flowreading=" + flowreading);
        c.remove(flowreading);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE Flowreading SET " + f + "=" + DbAdapter.cite(v) + " WHERE flowreading=" + flowreading);
        c.remove(flowreading);
    }
}
