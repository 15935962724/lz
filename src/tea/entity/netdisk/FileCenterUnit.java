package tea.entity.netdisk;

import java.io.*;
import java.sql.*;
import java.util.*;
import tea.db.*;
import tea.entity.*;

//文件中心: 编制部门
public class FileCenterUnit extends Entity
{
    public static Cache _cache = new Cache(100);
    private int filecenterunit;
    private String community;
    private String name;
    private boolean exists;

    public FileCenterUnit(int filecenterunit) throws SQLException
    {
        this.filecenterunit = filecenterunit;
        load();
    }

    public static FileCenterUnit find(int filecenterunit) throws SQLException
    {
        FileCenterUnit obj = (FileCenterUnit) _cache.get(new Integer(filecenterunit));
        if(obj == null)
        {
            obj = new FileCenterUnit(filecenterunit);
            _cache.put(new Integer(filecenterunit),obj);
        }
        return obj;
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,name FROM FileCenterUnit WHERE filecenterunit=" + filecenterunit);
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

    public static boolean create(String community,String name) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT * FROM FileCenterUnit WHERE community=" + DbAdapter.cite(community) + " AND name=" + DbAdapter.cite(name));
            if(db.next())
                return false;
            db.executeUpdate("INSERT INTO FileCenterUnit(community,name)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(name) + ")");
        } finally
        {
            db.close();
        }
        return true;
    }

    public static Enumeration findNameByCommunity(String community) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT name FROM FileCenterUnit WHERE community=" + DbAdapter.cite(community));
            while(db.next())
            {
                v.add(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Enumeration findByCommunity(String community,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT filecenterunit FROM FileCenterUnit WHERE community=" + DbAdapter.cite(community));
            while(db.next())
            {
                v.add(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public void set(String name) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE FileCenterUnit SET name=" + DbAdapter.cite(name) + " WHERE filecenterunit=" + filecenterunit);
        } finally
        {
            db.close();
        }
        this.name = name;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM FileCenterUnit WHERE filecenterunit=" + filecenterunit);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(filecenterunit));
    }

    public String getName()
    {
        return name;
    }

    public int getFileCenterUnit()
    {
        return filecenterunit;
    }

    public boolean isExists()
    {
        return exists;
    }
}
