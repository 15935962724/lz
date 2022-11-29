package tea.entity.admin.map;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class MapReal extends Entity
{
    public static Cache _cache = new Cache(100);
    private int node;
    private String sid;
    private int x;
    private int y;
    private String pic0; // 北
    private String pic1; // 南
    private String pic2; // 西
    private String pic3; // 东
    private Date time;
    private boolean exists;

    public MapReal(int node) throws SQLException
    {
        this.node = node;
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT sid,x,y,pic0,pic1,pic2,pic3,time FROM MapReal WHERE node=" + node);
            if(db.next())
            {
                sid = db.getString(1);
                x = db.getInt(2);
                y = db.getInt(3);
                pic0 = db.getString(4);
                pic1 = db.getString(5);
                pic2 = db.getString(6);
                pic3 = db.getString(7);
                time = db.getDate(8);
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

    public static void create(int node,String sid,int x,int y,String pic0,String pic1,String pic2,String pic3) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO MapReal(node,sid,x,y,pic0,pic1,pic2,pic3,time)VALUES(" + node + "," + DbAdapter.cite(sid) + "," + x + "," + y + "," + DbAdapter.cite(pic0) + "," + DbAdapter.cite(pic1) + "," + DbAdapter.cite(pic2) + "," + DbAdapter.cite(pic3) + "," + db.citeCurTime() + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(node));
    }

    public void set(String sid,int x,int y,String pic0,String pic1,String pic2,String pic3) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE MapReal SET sid=" + DbAdapter.cite(sid) + ",x=" + x + ",y=" + y + ",pic0=" + DbAdapter.cite(pic0) + ",pic1=" + DbAdapter.cite(pic1) + ",pic2=" + DbAdapter.cite(pic2) + ",pic3=" + DbAdapter.cite(pic3) + " WHERE node=" + node);
        } finally
        {
            db.close();
        }
        this.sid = sid;
        this.x = x;
        this.y = y;
        this.pic0 = pic0;
        this.pic1 = pic1;
        this.pic2 = pic2;
        this.pic3 = pic3;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM MapReal WHERE node=" + node);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(node));
        exists = false;
    }

    public static MapReal find(int node) throws SQLException
    {
        MapReal obj = (MapReal) _cache.get(new Integer(node));
        if(obj == null)
        {
            obj = new MapReal(node);
            _cache.put(new Integer(node),obj);
        }
        return obj;
    }

    public static int count(String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM MapReal WHERE 1=1" + sql);
            if(db.next())
            {
                count = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return count;
    }

    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM MapReal WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                v.addElement(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getNode()
    {
        return node;
    }

    public String getSid()
    {
        return sid;
    }

    public Date getTime()
    {
        return time;
    }

    public int getY()
    {
        return y;
    }

    public int getX()
    {
        return x;
    }

    public String getPic3()
    {
        return pic3;
    }

    public String getPic2()
    {
        return pic2;
    }

    public String getPic1()
    {
        return pic1;
    }

    public String getPic0()
    {
        return pic0;
    }

    public String getTimeToString()
    {
        return sdf.format(time);
    }

}
