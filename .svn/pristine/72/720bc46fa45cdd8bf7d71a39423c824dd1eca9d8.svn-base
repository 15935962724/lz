package tea.entity.admin;

import java.sql.*;
import java.util.*;

import tea.db.*;

//发文代号,综|财|投|人|市|工会|临党
public class FlowIssuecode
{
    public String community;
    public String name;
    public int no;
    public int sequence;
    public FlowIssuecode(String community,String name)
    {
        this.community = community;
        this.name = name;
    }

    public static FlowIssuecode find(String community,String name)throws SQLException
    {
        Enumeration e = find(" AND community=" + DbAdapter.cite(community) + " AND name=" + DbAdapter.cite(name),0,1);
        return e.hasMoreElements() ? (FlowIssuecode) e.nextElement() : new FlowIssuecode(community,name);
    }

    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,name,no FROM FlowIssuecode WHERE 1=1" + sql + " ORDER BY sequence",pos,size);
            while(db.next())
            {
                FlowIssuecode t = new FlowIssuecode(db.getString(1),db.getString(2));
                t.no = db.getInt(3);
                v.addElement(t);
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static void create(String community,String name,int sequence) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO FlowIssuecode(community,name,no,sequence)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(name) + ",0," + sequence + ")");
        } finally
        {
            db.close();
        }
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE FlowIssuecode SET " + f + "=" + DbAdapter.cite(v) + " WHERE community=" + DbAdapter.cite(community) + " AND name=" + DbAdapter.cite(name));
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM FlowIssuecode WHERE community=" + DbAdapter.cite(community) + " AND name=" + DbAdapter.cite(name));
        } finally
        {
            db.close();
        }
    }

    public String getName()
    {
        return name;
    }

    public String getCommunity()
    {
        return community;
    }

}
