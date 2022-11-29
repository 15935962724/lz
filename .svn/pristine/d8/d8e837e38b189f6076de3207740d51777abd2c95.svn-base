package tea.entity.admin;

import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

//来文单位~
public class AdminUnitOrg
{
    protected static Cache c = new Cache(50);
    public int adminunitorg;
    public String community;
    public String name; //公司名称
    public String org;
    public int sequence; //顺序

    public AdminUnitOrg(int adminunitorg)
    {
        this.adminunitorg = adminunitorg;
    }

    public static AdminUnitOrg find(int adminunitorg) throws SQLException
    {
        AdminUnitOrg t = (AdminUnitOrg) c.get(adminunitorg);
        if(t == null)
        {
            ArrayList al = find(" AND adminunitorg=" + adminunitorg,0,1);
            t = al.size() < 1 ? new AdminUnitOrg(adminunitorg) : (AdminUnitOrg) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT adminunitorg,community,name,org,sequence FROM AdminUnitOrg WHERE 1=1" + sql + " ORDER BY sequence",pos,size);
            while(rs.next())
            {
                int i = 1;
                AdminUnitOrg t = new AdminUnitOrg(rs.getInt(i++));
                t.community = rs.getString(i++);
                t.name = rs.getString(i++);
                t.org = rs.getString(i++);
                t.sequence = rs.getInt(i++);
                c.put(t.adminunitorg,t);
                al.add(t);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }

    //seq 0: 总公司 1:分子公司
    public static int find(String community,int seq) throws SQLException
    {
        Iterator it = find(" AND community=" + DbAdapter.cite(community),seq,1).iterator();
        return it.hasNext() ? ((AdminUnitOrg) it.next()).adminunitorg : 0;
    }

    //member 所属的公司
    public static int find(String community,String member) throws SQLException
    {
        return AdminUnit.find(AdminUsrRole.find(community,member).getUnit()).adminunitorg;
    }

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM AdminUnitOrg WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if(adminunitorg < 1)
            {
                db.executeUpdate("INSERT INTO AdminUnitOrg(community,name,org,sequence)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(org) + "," + sequence + ")");
            } else
            {
                db.executeUpdate("UPDATE AdminUnitOrg SET name=" + DbAdapter.cite(name) + ",org=" + DbAdapter.cite(org) + ",sequence=" + sequence + " WHERE adminunitorg=" + adminunitorg);
            }
        } finally
        {
            db.close();
        }
        c.remove(adminunitorg);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM AdminUnitOrg WHERE adminunitorg=" + adminunitorg);
        c.remove(adminunitorg);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE AdminUnitOrg SET " + f + "=" + DbAdapter.cite(v) + " WHERE adminunitorg=" + adminunitorg);
        c.remove(adminunitorg);
    }
}
