package tea.entity.admin;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class Archives extends Entity
{
    private int archives;
    private String member;
    private String community;
    private String adminunit;
    private String role;
    private String caption;
    private String content;
    private String filename;
    private String fileurl;
    private Date times;
    private static Cache _cache = new Cache(100);
    private boolean exists;

    public Archives(int archives) throws SQLException
    {
        this.archives = archives;
        load();
    }

    public static Archives find(int archives) throws SQLException
    {
        Archives obj = (Archives) _cache.get(new Integer(archives));
        if(obj == null)
        {
            obj = new Archives(archives);
            _cache.put(new Integer(archives),obj);
        }
        return obj;
    }

    public static void create(String member,String community,String adminunit,String role,String caption,String content,String filename,String fileurl) throws SQLException
    {
        Date times = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Archives (member,community,adminunit,role,caption,content,filename,fileurl,times)VALUES(" + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(adminunit) + "," + DbAdapter.cite(role) + "," + DbAdapter.cite(caption) + "," + DbAdapter.cite(content) + "," + DbAdapter.cite(filename) + "," + DbAdapter.cite(fileurl) + "," + DbAdapter.cite(times) + " )");
        } finally
        {
            db.close();
        }
    }

    public void set(String member,String adminunit,String role,String caption,String content,String filename,String fileurl) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Archives SET member=" + DbAdapter.cite(member) + ",adminunit=" + DbAdapter.cite(adminunit) + ",role=" + DbAdapter.cite(role) + ",caption=" + DbAdapter.cite(caption) + ",content=" + DbAdapter.cite(content) + ",filename=" + DbAdapter.cite(filename) + ",fileurl=" + DbAdapter.cite(fileurl) + " WHERE archives=" + archives);
        } finally
        {
            db.close();
        }
        this.member = member;
        this.adminunit = adminunit;
        this.role = role;
        this.caption = caption;
        this.content = content;
        this.filename = filename;
        this.fileurl = fileurl;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Archives WHERE archives=" + archives);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(archives));
    }

    public static int count(String community,String sql) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM Archives WHERE community=" + DbAdapter.cite(community) + sql);
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

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT archives FROM Archives WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
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

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT member,community,adminunit,role,caption,content,filename,fileurl,times From Archives WHERE archives=" + archives);
            if(db.next())
            {
                member = db.getString(1);
                community = db.getString(2);
                adminunit = db.getString(3);
                role = db.getString(4);
                caption = db.getString(5);
                content = db.getString(6);
                filename = db.getString(7);
                fileurl = db.getString(8);
                times = db.getDate(9);

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

    public String getAdminunit()
    {
        return adminunit;
    }

    public int getArchives()
    {
        return archives;
    }

    public String getCaption()
    {
        return caption;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getContent()
    {
        return content;
    }

    public String getFilename()
    {
        return filename;
    }

    public String getFileurl()
    {
        return fileurl;
    }

    public String getMember()
    {
        return member;
    }

    public String getRole()
    {
        return role;
    }

    public Date getTimes()
    {
        return times;
    }


}
