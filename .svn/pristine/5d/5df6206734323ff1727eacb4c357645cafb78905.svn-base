package tea.entity.member;

import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;

public class Contact extends Entity
{
    private static Cache _cache = new Cache(100);
    private int cgroup;
    private String member;
    private int sequence;
    private boolean exists;

    public Contact(int cgroup,String member,int sequence) throws SQLException
    {
        this.cgroup = cgroup;
        this.member = member;
        this.sequence = sequence;
    }

    public Contact(int cgroup,String member) throws SQLException
    {
        this.cgroup = cgroup;
        this.member = member;
        load();
    }

    public static Contact find(int cgroup,String member) throws SQLException
    {
        Contact obj = (Contact) _cache.get(cgroup + ":" + member);
        if(obj == null)
        {
            obj = new Contact(cgroup,member);
            _cache.put(cgroup + ":" + member,obj);
        }
        return obj;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT sequence FROM Contact WHERE cgroup=" + cgroup + " AND member=" + DbAdapter.cite(member));
            if(db.next())
            {
                sequence = db.getInt(1);
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(int cgroup,String member) throws SQLException
    {
        long lo = System.currentTimeMillis() / 1000L;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Contact(cgroup, member,sequence)VALUES (" + cgroup + ", " + DbAdapter.cite(member) + "," + lo + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(cgroup + ":" + member);
    }

    public static int count(int cgroup,String sql) throws SQLException
    {
        String str = "SELECT COUNT(member) FROM Contact WHERE";
        if(cgroup > 0)
        {
            str = str + " cgroup=" + cgroup;
        } else
        {
            str = str + " 1=1";
        }
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            i = db.getInt(str + sql);
        } finally
        {
            db.close();
        }
        return i;
    }

    public static Enumeration find(int cgroup,String sql,int pos,int size) throws SQLException
    {
        String str = "SELECT cgroup,member,sequence FROM Contact WHERE";
        if(cgroup > 0)
        {
            str = str + " cgroup=" + cgroup;
        } else
        {
            str = str + " 1=1";
        }
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(str + sql,pos,size);
            while(db.next())
            {
                Contact obj = new Contact(db.getInt(1),db.getString(2),db.getInt(3));
                v.addElement(obj);
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Contact WHERE cgroup=" + cgroup + " AND member=" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
    }

	public static void deleteCG(int cgroup) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM Contact WHERE cgroup=" + cgroup);
		} finally
		{
			db.close();
		}
	}


    public void setSequence(int sequence) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Contact SET sequence=" + sequence + " WHERE cgroup=" + cgroup + " AND member=" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
        this.sequence = sequence;
    }

    public int getCGroup()
    {
        return cgroup;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getMember()
    {
        return member;
    }

    public int getSequence()
    {
        return sequence;
    }
}
