package tea.entity.admin;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class FileEndorse extends Entity
{
    private int fileendorse;
    private String member;
    private String community;
    private String filename;
    private String fileurl;
    private String acceptmember;
    private Date times;
    private String caption;
    private String content;
    private int type;
    private String member2;
    private String content2;
    private Date times2;
    private static Cache _cache = new Cache(100);
    private boolean exists;

    public FileEndorse(int fileendorse) throws SQLException
    {
        this.fileendorse = fileendorse;
        load();
    }

    public static FileEndorse find(int fileendorse) throws SQLException
    {
        FileEndorse obj = (FileEndorse) _cache.get(new Integer(fileendorse));
        if(obj == null)
        {
            obj = new FileEndorse(fileendorse);
            _cache.put(new Integer(fileendorse),obj);
        }
        return obj;
    }

    public FileEndorse(int fileendorse,String member) throws SQLException
    {
        this.fileendorse = fileendorse;
        this.member2 = member;
        loadmember();
    }

    public static FileEndorse find(int fileendorse,String member) throws SQLException
    {
        //FileEndorse obj = (FileEndorse)_cache.get.get(new Integer(fileendorse));
        //  if(obj == null)
        //// {
        FileEndorse obj = new FileEndorse(fileendorse,member);
        // _cache.put(new Integer(fileendorse),obj);
        // }
        return obj;
    }


    public static void create(String member,String community,String filename,String fileurl,String acceptmember,String caption,String content) throws SQLException
    {
        Date times = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO FileEndorse (member,community,filename,fileurl,acceptmember,times,caption,content)VALUES(" + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(filename) + "," + DbAdapter.cite(fileurl) + "," + DbAdapter.cite(acceptmember) + "," + DbAdapter.cite(times) + "," + DbAdapter.cite(caption) + "," + DbAdapter.cite(content) + " )");
        } finally
        {
            db.close();
        }
    }

    public void set(String member,String filename,String fileurl,String acceptmember,String caption,String content) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE FileEndorse SET member=" + DbAdapter.cite(member) + ",filename=" + DbAdapter.cite(filename) + ",fileurl=" + DbAdapter.cite(fileurl) + ",acceptmember=" + DbAdapter.cite(acceptmember) + ",caption=" + DbAdapter.cite(caption) + ",content=" + DbAdapter.cite(content) + " WHERE fileendorse=" + fileendorse);
        } finally
        {
            db.close();
        }
        this.member = member;
        this.filename = filename;
        this.fileurl = fileurl;
        this.acceptmember = acceptmember;
        this.caption = caption;
        this.content = content;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM FileEndorse WHERE fileendorse=" + fileendorse);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(fileendorse));
    }

    public void deletemember() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM ExamineMember WHERE fileendorse=" + fileendorse);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(fileendorse));
    }

    public static int count(String community,String sql) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM FileEndorse WHERE community=" + DbAdapter.cite(community) + sql);
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
            db.executeQuery("SELECT fileendorse FROM FileEndorse WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
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
            db.executeQuery("SELECT member,community,filename,fileurl,acceptmember,times,caption,content FROM FileEndorse WHERE fileendorse=" + fileendorse);
            if(db.next())
            {
                member = db.getString(1);
                community = db.getString(2);
                filename = db.getString(3);
                fileurl = db.getString(4);
                acceptmember = db.getString(5);
                times = db.getDate(6);
                caption = db.getString(7);
                content = db.getString(8);
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

    private void loadmember() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT member,type,content,times FROM ExamineMember WHERE fileendorse=" + fileendorse + " and member=" + DbAdapter.cite(member2));
            if(db.next())
            {
                member2 = db.getString(1);
                type = db.getInt(2);
                content2 = db.getString(3);
                times2 = db.getDate(4);
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

    //不批准添加原因
    public static void create(int fileendorse,String member,int type,String content) throws SQLException
    {
        Date times = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO ExamineMember (fileendorse,member,type,content,times)VALUES(" + fileendorse + "," + DbAdapter.cite(member) + "," + type + "," + DbAdapter.cite(content) + "," + DbAdapter.cite(times) + " )");
        } finally
        {
            db.close();
        }
    }

    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT fileendorse FROM FileEndorse WHERE 1=1 " + sql,pos,size);
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

    public String getAcceptmember()
    {
        return acceptmember;
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

    public int getFileendorse()
    {
        return fileendorse;
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

    public Date getTimes()
    {
        return times;
    }

    public String getMember2()
    {
        return member2;
    }

    public int getType()
    {
        return type;
    }

    public String getContent2()
    {
        return content2;
    }

    public Date getTimes2()
    {
        return times2;
    }
}
