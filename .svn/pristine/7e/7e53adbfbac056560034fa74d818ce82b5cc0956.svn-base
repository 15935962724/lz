package tea.entity.bbs;

import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import tea.resource.*;

public class BBSAttach extends Entity implements Serializable
{
    private int bbsattach;
    private boolean type; //false:楼主(bbsid是node号), true:回复(bbsid是BBSReply主键)
    private int bbsid;
    private String member;
    private String name;
    private String path;
    private int hits;
    private String dmember; //下载者
    private Date time;
    private boolean exists;
    private BBSAttach()
    {}

    public BBSAttach(int bbsattach,boolean type,int bbsid,String member,String name,String path,int hits,String dmember,Date time) throws SQLException
    {
        this.bbsattach = bbsattach;
        this.type = type;
        this.bbsid = bbsid;
        this.member = member;
        this.name = name;
        this.path = path;
        this.hits = hits;
        this.dmember = dmember;
        this.time = time;
        this.exists = true;
    }

    public static int count(String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM BBSAttach WHERE 1=1" + sql);
            if(db.next())
            {
                j = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return j;
    }

    public static BBSAttach find(int bbsattach) throws SQLException
    {
        Enumeration e = find(" AND bbsattach=" + bbsattach,0,1);
        if(e.hasMoreElements())
        {
            return(BBSAttach) e.nextElement();
        }
        return new BBSAttach();
    }

    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT bbsattach,type,bbsid,member,name,path,hits,dmember,time FROM BBSAttach WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                int bbsattach = db.getInt(1);
                boolean type = db.getInt(2) != 0;
                int bbsid = db.getInt(3);
                String member = db.getString(4);
                String name = db.getString(5);
                String path = db.getString(6);
                int hits = db.getInt(7);
                String dmember = db.getString(8);
                Date time = db.getDate(9);
                v.addElement(new BBSAttach(bbsattach,type,bbsid,member,name,path,hits,dmember,time));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static void create(boolean type,int bbsid,String member,String name,String path) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO BBSAttach(type,bbsid,member,name,path,hits,dmember,time)VALUES(" + DbAdapter.cite(type) + "," + bbsid + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(path) + ",0,'/'," + DbAdapter.cite(new Date()) + ")");
        } finally
        {
            db.close();
        }
    }

    public static int setBbsid(boolean type,String member,int bbsid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            return db.executeUpdate("UPDATE BBSAttach SET bbsid=" + bbsid + " WHERE bbsid=0 AND type=" + DbAdapter.cite(type) + " AND member=" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
    }

    public void set(String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE BBSAttach SET hits=" + ++hits + ",dmember=" + DbAdapter.cite(dmember + member + "/") + " WHERE bbsattach=" + bbsattach);
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
            db.executeUpdate("DELETE FROM BBSAttach WHERE bbsattach=" + bbsattach);
        } finally
        {
            db.close();
        }
        new java.io.File(Common.REAL_PATH + path).delete();
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getBbsattach()
    {
        return bbsattach;
    }

    public int getBbsid()
    {
        return bbsid;
    }

    public int getHits()
    {
        return hits;
    }

    public String getMember()
    {
        return member;
    }

    public String getName()
    {
        return name;
    }

    public String getPath()
    {
        return path;
    }

    public int getLen()
    {
        return(int)new File(Common.REAL_PATH + path).length();
    }

    public boolean isType()
    {
        return type;
    }

    public Date getTime()
    {
        return time;
    }

    public String getDMember()
    {
        return dmember;
    }

    public String getTimeToString()
    {
        return sdf2.format(time);
    }

    public static String toHtml(boolean type,int bbsid) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        Enumeration eba = BBSAttach.find(" AND type=" + DbAdapter.cite(type) + " AND bbsid=" + bbsid,0,200);
        if(eba.hasMoreElements())
        {
            sb.append("<br/><br/>");
            while(eba.hasMoreElements())
            {
                BBSAttach ba = (BBSAttach) eba.nextElement();
                sb.append("<br/><a href='/servlet/BBSAttachs?act=down&bbsattach=" + ba.getBbsattach() + "' target='_ajax'>" + ba.getName() + "</a> 大小:" + df.format(ba.getLen() / 1024F) + " K 已被下载:" + ba.getHits() + "次");
            }
        }
        return sb.toString();
    }
}
