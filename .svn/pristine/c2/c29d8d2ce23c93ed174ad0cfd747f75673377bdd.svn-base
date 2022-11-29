package tea.entity.admin;

import java.util.*;
import java.sql.SQLException;
import tea.db.DbAdapter;
import tea.entity.*;

public class Worktype extends Entity
{
    private static Cache _cache = new Cache(100);
    private int worktype;
    private String name;
    private boolean exists;
    private String community;

    public Worktype(int worktype) throws SQLException
    {
        this.worktype = worktype;
        load();
    }

    public static Worktype find(int worktype) throws SQLException
    {
        Worktype obj = (Worktype) _cache.get(new Integer(worktype));
        if(obj == null)
        {
            obj = new Worktype(worktype);
            _cache.put(new Integer(worktype),obj);
        }
        return obj;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,name FROM Worktype WHERE worktype=" + worktype);
            if(db.next())
            {
                community = db.getString(1);
                name = db.getString(2);
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

    public static void create(String community,String name) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Worktype(community,name)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(name) + " )");
        } finally
        {
            db.close();
        }
    }

    public void set(String name) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Worktype SET name=" + DbAdapter.cite(name) + " WHERE worktype=" + worktype);
        } finally
        {
            db.close();
        }
        this.name = name;
    }

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            count = db.getInt("SELECT COUNT(worktype) FROM Worktype WHERE community=" + DbAdapter.cite(community) + sql);
        } finally
        {
            db.close();
        }
        return count;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Worktype WHERE worktype=" + worktype);
        } finally
        {
            db.close();
        }
        this.exists = false;
        _cache.remove(new Integer(worktype));
    }

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT worktype FROM Worktype WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    /*****10月15号*******/
    public static Enumeration findcommunity(String community,String sql,int pos,int size) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT worktype FROM Worktype WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public int getWorktype()
    {
        return worktype;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getName(int language)
    {
        return name;
    }
}
