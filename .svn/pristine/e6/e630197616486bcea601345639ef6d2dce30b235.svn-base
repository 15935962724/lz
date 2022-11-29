package tea.entity.admin;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class Certificate extends Entity
{
    private int certificate;
    private String names;
    private String cardname;
    private String filename;
    private String fileurl;
    private String content;
    private Date times;
    private int type;
    private String member;
    private String community;

    private static Cache _cache = new Cache(100);
    private boolean exists;

    public Certificate(int certificate) throws SQLException
    {
        this.certificate = certificate;
        load();
    }

    public static Certificate find(int certificate) throws SQLException
    {
        Certificate obj = (Certificate) _cache.get(new Integer(certificate));
        if(obj == null)
        {
            obj = new Certificate(certificate);
            _cache.put(new Integer(certificate),obj);
        }
        return obj;
    }

    public static void create(String names,String cardname,String filename,String fileurl,String content,int type,String member,String community) throws SQLException
    {
        Date times = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Certificate (names,cardname,filename,fileurl,content,times,type,member,community)VALUES(" + DbAdapter.cite(names) + "," + DbAdapter.cite(cardname) + "," + DbAdapter.cite(filename) + "," + DbAdapter.cite(fileurl) + "," + DbAdapter.cite(content) + "," + DbAdapter.cite(times) + "," + type + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + " )");
        } finally
        {
            db.close();
        }
    }

    public void set(String names,String cardname,String filename,String fileurl,String content,int type,String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Certificate SET names=" + DbAdapter.cite(names) + ",cardname=" + DbAdapter.cite(cardname) + ",filename=" + DbAdapter.cite(filename) + ",fileurl=" + DbAdapter.cite(fileurl) + ",content=" + DbAdapter.cite(content) + ",type=" + type + ",member=" + DbAdapter.cite(member) + "  WHERE certificate=" + certificate);
        } finally
        {
            db.close();
        }
        this.names = names;
        this.cardname = cardname;
        this.filename = filename;
        this.fileurl = fileurl;
        this.content = content;
        this.type = type;
        this.member = member;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Certificate WHERE certificate=" + certificate);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(certificate));
    }

    public static int count(String community,String sql) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM Certificate WHERE community=" + DbAdapter.cite(community) + sql);
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
            db.executeQuery("SELECT certificate FROM Certificate WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
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
            db.executeQuery("SELECT names,cardname,filename,fileurl,content,times,type,member,community FROM Certificate WHERE certificate=" + certificate);
            if(db.next())
            {
                names = db.getString(1);
                cardname = db.getString(2);
                filename = db.getString(3);
                fileurl = db.getString(4);
                content = db.getString(5);
                times = db.getDate(6);
                type = db.getInt(7);
                member = db.getString(8);
                community = db.getString(9);
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

    public String getCardname()
    {
        return cardname;
    }

    public int getCertificate()
    {
        return certificate;
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

    public String getNames()
    {
        return names;
    }

    public Date getTimes()
    {
        return times;
    }

    public int getType()
    {
        return type;
    }


}
