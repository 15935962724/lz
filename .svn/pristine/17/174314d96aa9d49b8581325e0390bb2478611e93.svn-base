package tea.entity.admin.card9000;

import java.util.*;
import java.text.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class Haikey9000 extends Entity
{
    public static final java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm E");
    private static Cache _cache = new Cache(100);
    private String code;
    private String community;
    private String password;
    private boolean states;
    private Date time;
    private boolean exists;

    public Haikey9000(String code) throws SQLException
    {
        this.code = code;
        load();
    }

    public static Haikey9000 find(String code) throws SQLException
    {
        Haikey9000 obj = (Haikey9000) _cache.get(code);
        if(obj == null)
        {
            obj = new Haikey9000(code);
            _cache.put(code,obj);
        }
        return obj;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,password,states,time FROM haikey9000 WHERE code=" + DbAdapter.cite(code));
            if(db.next())
            {
                community = db.getString(1);
                password = db.getString(2);
                states = db.getInt(3) != 0;
                time = db.getDate(4);
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

    public static int create(String community,String code,String password,Date time) throws SQLException
    {
        int worktel = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO haikey9000(code,community,password,states,time)VALUES(" + DbAdapter.cite(code) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(password) + ",0," + DbAdapter.cite(time) + " )");
            worktel = db.getInt("SELECT @@IDENTITY");
        } finally
        {
            db.close();
        }
        return worktel;
    }

    public void setStates(boolean states) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE haikey9000 SET states=" + DbAdapter.cite(states) + " WHERE code=" + DbAdapter.cite(code));
        } finally
        {
            db.close();
        }
        this.states = states;
    }

    public static java.util.Enumeration findTime(String community) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT DISTINCT time FROM haikey9000 WHERE community=" + DbAdapter.cite(community));
            while(db.next())
            {
                v.addElement(db.getDate(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            count = db.getInt("SELECT COUNT(*) FROM haikey9000 WHERE community=" + DbAdapter.cite(community) + sql);
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
            db.executeUpdate("DELETE FROM haikey9000 WHERE code=" + DbAdapter.cite(code));
        } finally
        {
            db.close();
        }
        this.exists = false;
        _cache.remove(code);
    }

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT code FROM haikey9000 WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
            while(db.next())
            {
                v.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static String findMaxCode() throws SQLException
    {
        String code = null;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT MAX(code) FROM haikey9000");
            if(db.next())
            {
                code = db.getString(1);
            }
        } finally
        {
            db.close();
        }
        if(code == null || code.length() < 1)
        {
            code = "6688000000000000";
        }
        return code;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getCommunity()
    {
        return community;
    }

    public Date getTime()
    {
        return time;
    }

    public String getPassword()
    {
        return password;
    }

    public String getCode()
    {
        return code;
    }

    public String getCodeToFormat()
    {
        DecimalFormat df = new DecimalFormat("#,###0");
        return df.format(Long.parseLong(code)).replace(',',' ');
    }

    public boolean isStates()
    {
        return states;
    }
}
