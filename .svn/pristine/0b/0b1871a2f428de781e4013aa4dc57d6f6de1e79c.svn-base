package tea.entity.admin.orthonline;


import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;

public class Provinces extends Entity
{
    private int proid;
    private String provincity;
    private int type;
    private boolean exists;
    public Provinces(int proid) throws SQLException
    {
        this.proid = proid;
        load();
    }

    public static Provinces find(int proid) throws SQLException
    {
        return new Provinces(proid);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT provincity,type FROM Provinces WHERE proid =" + proid);
            if(db.next())
            {
                provincity = db.getString(1);
                type = db.getInt(2);
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

    public static Enumeration find(String sql) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT proid FROM Provinces WHERE 1=1 " + sql);
            while(db.next())
            {
                vector.add(new Integer(db.getInt(1)));
            }
        } catch(Exception exception3)
        {
            System.out.print(exception3);
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

//通过名称找到id
    public static int getProid(String sql) throws SQLException
    {
        int prid = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT proid FROM Provinces WHERE 1=1 " + sql);
            if(db.next())
            {
                prid = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return prid;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getProvincity()
    {
        return provincity;
    }

    public int getType()
    {
        return type;
    }


}
