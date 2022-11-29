package tea.entity.admin.im;

import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class ImHistory extends Entity implements Serializable
{
    private static Cache _cache = new Cache(100);
    private int imhistory;
    private String fmember;
    private String tmember;
    private String content;
    private Date time;
    private boolean exists;

    public ImHistory(int imhistory) throws SQLException
    {
        this.imhistory = imhistory;
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT fmember,tmember,content,time FROM ImHistory WHERE imhistory=" + imhistory);
            if(db.next())
            {
                fmember = db.getString(1);
                tmember = db.getString(2);
                content = db.getString(3);
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

    public static ImHistory find(int _nImHistory) throws SQLException
    {
        ImHistory obj = (ImHistory) _cache.get(new Integer(_nImHistory));
        if(obj == null)
        {
            obj = new ImHistory(_nImHistory);
            _cache.put(new Integer(_nImHistory),obj);
        }
        return obj;
    }

    public static void create(String fmember,String tmember,String content,Date time) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO ImHistory (fmember,tmember,content,time)VALUES(" + DbAdapter.cite(fmember) + "," + DbAdapter.cite(tmember) + "," + DbAdapter.cite(content) + "," + DbAdapter.cite(time) + ")");
        } finally
        {
            db.close();
        }
    }


    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM ImHistory WHERE imhistory=" + imhistory);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(imhistory));
    }

    public static int count(String sql) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM ImHistory WHERE 1=1" + sql);
            while(db.next())
            {
                i = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return i;
    }

    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT imhistory FROM ImHistory WHERE 1=1" + sql + " ORDER BY time DESC",pos,size);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public int getImHistory()
    {
        return imhistory;
    }

    public String getTMember()
    {
        return tmember;
    }

    public Date getTime()
    {
        return time;
    }

    public String getTimeToString()
    {
        return sdf2.format(time);
    }

    public String getFMember()
    {
        return fmember;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getContent()
    {
        return content;
    }
}
