package tea.entity.admin.map;

import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class Mapabc extends Entity
{
    public static Cache _cache = new Cache(100);
    private String sid;
    private String community;
    private String member;
    private String name;
    private String addr;
    private String tel;
    private String info;
    private String email;
    private String keyword;
    private boolean hidden;
    // //
    private String pic360; // 全景
    private String pic0; // 东
    private String pic1; // 南
    private String pic2; // 西
    private String pic3; // 北
    private String pic4; // 天
    //
    private Date time;
    private boolean exists;

    public Mapabc(String sid) throws SQLException
    {
        this.sid = sid;
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,member,name,addr,tel,info,email,keyword,hidden,time FROM mapabc WHERE sid=" + DbAdapter.cite(sid));
            if(db.next())
            {
                community = db.getString(1);
                member = db.getString(2);
                name = db.getString(3);
                addr = db.getString(4);
                tel = db.getString(5);
                info = db.getString(6);
                email = db.getString(7);
                keyword = db.getString(8);
                hidden = db.getInt(9) != 0;
                time = db.getDate(10);
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

    public static void create(String sid,String community,String member,String name,String addr,String tel,String info,String email,String keyword) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO mapabc(sid,community,member,name,addr,tel,info,email,keyword,hidden,time)VALUES(" + DbAdapter.cite(sid) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(addr) + "," + DbAdapter.cite(tel) + "," + DbAdapter.cite(info) + "," + DbAdapter.cite(email) + "," + DbAdapter.cite(keyword) + ",1," + db.citeCurTime() + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(sid);
    }

    public void set(String name,String addr,String tel,String info,String email,String keyword) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        DbAdapter db = new DbAdapter();
        sb.append("UPDATE mapabc SET name=" + DbAdapter.cite(name) + ",addr=" + DbAdapter.cite(addr) + ",tel=" + DbAdapter.cite(tel) + ",info=" + DbAdapter.cite(info) + ",email=" + DbAdapter.cite(email) + ",keyword=" + DbAdapter.cite(keyword));
        sb.append(" WHERE sid=" + DbAdapter.cite(sid));
        try
        {
            db.executeUpdate(sb.toString());
        } finally
        {
            db.close();
        }
        this.name = name;
        this.addr = addr;
        this.tel = tel;
        this.info = info;
        this.email = email;
        this.keyword = keyword;
    }

    public void setHidden(boolean hidden) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE mapabc SET hidden=" + DbAdapter.cite(hidden) + " WHERE sid=" + DbAdapter.cite(sid));
        } finally
        {
            db.close();
        }
        this.hidden = hidden;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM mapabc WHERE sid=" + DbAdapter.cite(sid));
        } finally
        {
            db.close();
        }
        _cache.remove(sid);
        exists = false;
    }

    public static Mapabc find(String sid) throws SQLException
    {
        Mapabc obj = (Mapabc) _cache.get(sid);
        if(obj == null)
        {
            obj = new Mapabc(sid);
            _cache.put(sid,obj);
        }
        return obj;
    }

    public static int count(String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM mapabc WHERE 1=1" + sql);
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
            db.executeQuery("SELECT sid FROM mapabc WHERE 1=1" + sql,pos,size);
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

    public static String getSessionid() throws IOException
    {
        String content = (String) open("http://mc.mapabc.com/newedit/pmiservlet?oper=0&uid=ykkj&pwd=123&type=text");
        /*
         * try { javax.xml.parsers.DocumentBuilderFactory dbf = javax.xml.parsers.DocumentBuilderFactory.newInstance(); javax.xml.parsers.DocumentBuilder dbr = dbf.newDocumentBuilder(); java.io.ByteArrayInputStream bais = new java.io.ByteArrayInputStream(content.getBytes("UTF-8")); org.w3c.dom.Document d = dbr.parse(bais); return d.getElementsByTagName("sessionid").item(0).getNodeValue(); }
         */
        return content.split("&")[2].trim();
    }

    public boolean isExists()
    {
        return exists;
    }

    public boolean isHidden()
    {
        return hidden;
    }

    public String getName()
    {
        return name;
    }

    public String getSid()
    {
        return sid;
    }

    public Date getTime()
    {
        return time;
    }

    public String getTimeToString()
    {
        return sdf.format(time);
    }

    public String getAddr()
    {
        return addr;
    }

    public String getEmail()
    {
        return email;
    }

    public String getInfo()
    {
        return info;
    }

    public String getKeyword()
    {
        return keyword;
    }

    public String getTel()
    {
        return tel;
    }

    public String getMember()
    {
        return member;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getPic360()
    {
        return pic360;
    }

    public String getPic0()
    {
        return pic0;
    }

    public String getPic1()
    {
        return pic1;
    }

    public String getPic2()
    {
        return pic2;
    }

    public String getPic3()
    {
        return pic3;
    }

    public String getPic4()
    {
        return pic4;
    }
}
