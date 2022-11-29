package tea.entity.admin;

import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class AdminUnitType
{
    protected static Cache c = new Cache(50);
    public int adminunittype;
    public String community; //社区
    public String name; //名称
    public int sequence; //顺序

    public AdminUnitType(int adminunittype)
    {
        this.adminunittype = adminunittype;
    }

    public static AdminUnitType find(int adminunittype) throws SQLException
    {
        AdminUnitType t = (AdminUnitType) c.get(adminunittype);
        if(t == null)
        {
            ArrayList al = find(" AND adminunittype=" + adminunittype,0,1);
            t = al.size() < 1 ? new AdminUnitType(adminunittype) : (AdminUnitType) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT adminunittype,community,name,sequence FROM AdminUnitType WHERE 1=1" + sql+" ORDER BY sequence",pos,size);
            while(rs.next())
            {
                int i = 1;
                AdminUnitType t = new AdminUnitType(rs.getInt(i++));
                t.community = rs.getString(i++);
                t.name = rs.getString(i++);
                t.sequence = rs.getInt(i++);
                c.put(t.adminunittype,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM AdminUnitType WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if(adminunittype < 1)
            {
                db.executeUpdate("INSERT INTO AdminUnitType(community,name,sequence)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(name) + "," + sequence + ")");
            } else
            {
                db.executeUpdate("UPDATE AdminUnitType SET name=" + DbAdapter.cite(name) + ",sequence=" + sequence + " WHERE adminunittype=" + adminunittype);
            }
        } finally
        {
            db.close();
        }
        c.remove(adminunittype);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM AdminUnitType WHERE adminunittype=" + adminunittype);
        c.remove(adminunittype);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE AdminUnitType SET " + f + "=" + DbAdapter.cite(v) + " WHERE adminunittype=" + adminunittype);
        c.remove(adminunittype);
    }
}
