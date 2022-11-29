package tea.entity.bbs;

import java.io.*;
import java.sql.*;
import java.util.*;
import tea.db.*;
import tea.entity.member.*;

public class BBSLevel implements Serializable
{
    private int bbslevel;
    private String community;
    private String name;
    private String picture;
    private int point;
    private boolean exists;
    private BBSLevel()
    {}

    public BBSLevel(int bbslevel,String community,String name,String picture,int point) throws SQLException
    {
        this.bbslevel = bbslevel;
        this.community = community;
        this.name = name;
        this.picture = picture;
        this.point = point;
        this.exists = true;
    }

    public static void create(String community) throws SQLException
    {
        String A[] =
                {"初学弟子","初入江湖","江湖新秀","江湖少侠","江湖大侠","江湖豪侠","一派掌门","一代宗师","武林盟主","独孤求败"};
        Enumeration e = find(" AND community=" + DbAdapter.cite(community),0,Integer.MAX_VALUE);
        for(int i = 0;i < A.length;i++)
        {
            if(e.hasMoreElements())
            {
                int id = ((BBSLevel) e.nextElement()).getBbslevel();
                BBSLevel.set(id,A[i],"/tea/image/bbslevel/" + (i + 1) + ".gif",i * 1000);
            } else
            {
                BBSLevel.create(community,A[i],"/tea/image/bbslevel/" + (i + 1) + ".gif",i * 1000);
            }
        }
        //删除多于项
        while(e.hasMoreElements())
        {
            int id = ((BBSLevel) e.nextElement()).getBbslevel();
            BBSLevel.delete(id);
        }
    }

    public static void set(int bbslevel,String name,String picture,int point) throws SQLException
    {
        StringBuilder h = new StringBuilder();
        h.append("UPDATE BBSLevel SET name=").append(DbAdapter.cite(name));
        if(picture != null)
        {
            h.append(",picture=").append(DbAdapter.cite(picture));
        }
        h.append(",point=").append(point).append(" WHERE bbslevel=").append(bbslevel);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(h.toString());
        } finally
        {
            db.close();
        }
    }

    public static BBSLevel find(int bbslevel) throws SQLException
    {
        Enumeration e = find(" AND bbslevel=" + bbslevel,0,1);
        if(e.hasMoreElements())
        {
            return(BBSLevel) e.nextElement();
        }
        return new BBSLevel();
    }

    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT bbslevel,community,name,picture,point FROM BBSLevel WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                int bbslevel = db.getInt(1);
                String community = db.getString(2);
                String name = db.getString(3);
                String picture = db.getString(4);
                int point = db.getInt(5);
                v.addElement(new BBSLevel(bbslevel,community,name,picture,point));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    //刷新会员的等级
    public static void refresh() throws SQLException
    {
        int j = 0;
        Enumeration e = BBSLevel.find(" ORDER BY point DESC",0,Integer.MAX_VALUE);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Profile SET integral=0 WHERE integral IS NULL");
            while(e.hasMoreElements())
            {
                BBSLevel bl = (BBSLevel) e.nextElement();
                j += db.executeUpdate("UPDATE Profile SET bbslevel=" + bl.bbslevel + " WHERE bbslevel IS NULL AND integral>=" + bl.point);
            }
        } finally
        {
            db.close();
        }
        if(j > 0)
        {
            Profile._cache.clear();
        }
    }

    public static void create(String community,String name,String picture,int point) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO BBSLevel(community,name,picture,point)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(picture) + "," + point + ")");
        } finally
        {
            db.close();
        }
    }

    public static void delete(int bbslevel) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM BBSLevel WHERE bbslevel=" + bbslevel);
            db.executeUpdate("UPDATE Profile SET bbslevel=0 WHERE bbslevel=" + bbslevel);
        } finally
        {
            db.close();
        }
    }

    public boolean isExists()
    {
        return exists;
    }


    public String getName()
    {
        return name;
    }

    public int getPoint()
    {
        return point;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getPicture()
    {
        return picture == null ? "/tea/image/public/blank_png.gif" : picture;
    }

    public int getBbslevel()
    {
        return bbslevel;
    }


}
