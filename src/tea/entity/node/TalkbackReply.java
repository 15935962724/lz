package tea.entity.node;

import java.util.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class TalkbackReply extends Entity
{
    public static Cache _cache = new Cache(100);
    private int talkbackreply;
    private int talkback;
    private String member;
    private String text;
    private Date time;
    private boolean exists;

    private int hidden; //0 未审核，1，已审核，2, 已拒绝
    private String ip;

    private String auditmember; //审核人员
    private Date audittime; //审核时间

    //回复时候的姓名和地区
    private String name;
    private String country; //地区

    public static final String HIDDEN_TYPE[] =
            {"未审核","已审核","已拒绝"};

    public static TalkbackReply find(int talkbackreply) throws SQLException
    {
        TalkbackReply obj = (TalkbackReply) _cache.get(new Integer(talkbackreply));
        if(obj == null)
        {
            obj = new TalkbackReply(talkbackreply);
            _cache.put(new Integer(talkbackreply),obj);
        }
        return obj;
    }

    public TalkbackReply(int talkbackreply) throws SQLException
    {
        this.talkbackreply = talkbackreply;
        load();
    }

    public static void create(int talkback,String member,String text,int hidden,String ip,String name,String country) throws SQLException
    {
        int talkbackreply;
        String sql = "INSERT INTO TalkbackReply(talkbackreply,talkback,member,text,time,name,country)VALUES(" + (talkbackreply = Seq.get()) + "," + (talkback) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(text) + "," + DbAdapter.cite(new Date()) + " ," + DbAdapter.cite(name) + "," + DbAdapter.cite(country) + ")";
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(talkbackreply,sql);
        } finally
        {
            db.close();
        }
        //_cache.remove(new Integer(talkbackreply));
    }

    public void set(String auditmember,Date audittime) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(talkbackreply,"UPDATE TalkbackReply SET auditmember=" + DbAdapter.cite(auditmember) + " , audittime=" + DbAdapter.cite(audittime) + " WHERE talkbackreply=" + talkbackreply);
        } finally
        {
            db.close();
        }
        this.auditmember = auditmember;
        this.audittime = audittime;
    }

    public void setNameCountry(String name,String country) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(talkbackreply,"UPDATE TalkbackReply SET name=" + DbAdapter.cite(name) + " , country=" + DbAdapter.cite(country) + " WHERE talkbackreply= " + talkbackreply);
        } finally
        {
            db.close();
        }
        this.name = name;
        this.country = country;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT talkback, member ,text,time,hidden,ip,auditmember,audittime,name,country	FROM TalkbackReply WHERE talkbackreply=" + talkbackreply);
            if(db.next())
            {
                talkback = db.getInt(1);
                member = db.getVarchar(1,1,2);
                text = db.getText(1,1,3);
                time = db.getDate(4);
                hidden = db.getInt(5);
                ip = db.getString(6);
                auditmember = db.getString(7);
                audittime = db.getDate(8);
                name = db.getString(9);
                country = db.getString(10);
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

    public static Enumeration findByTalkback(int talkback) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Vector vector = new Vector();
        try
        {
            db.executeQuery("SELECT   talkbackreply	FROM TalkbackReply WHERE talkback= " + talkback);
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Vector vector = new Vector();
        try
        {
            db.executeQuery("SELECT   talkbackreply	FROM TalkbackReply WHERE 1=1 " + sql,pos,size);
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static int countByTalkback(int talkback) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            return db.getInt("SELECT  COUNT( talkbackreply)	FROM TalkbackReply WHERE talkback= " + talkback);
        } finally
        {
            db.close();
        }
    }

    public void setHidden(int hidden) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(talkbackreply,"UPDATE TalkbackReply SET hidden=" + hidden + " WHERE talkbackreply=" + talkbackreply);
        } finally
        {
            db.close();
        }
        this.hidden = hidden;
    }

    public static int count(String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            return db.getInt("SELECT  COUNT( talkbackreply)	FROM TalkbackReply WHERE 1=1 " + sql);
        } finally
        {
            db.close();
        }
    }

    public static int countByMember(String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            return db.getInt("SELECT  COUNT( talkbackreply)	FROM TalkbackReply WHERE member=" + DbAdapter.cite(member));
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
            db.executeUpdate(talkbackreply,"DELETE FROM TalkbackReply WHERE talkbackreply=" + talkbackreply);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(talkbackreply));
    }

    public void set(String text) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(talkbackreply,"UPDATE TalkbackReply SET text=" + DbAdapter.cite(text) + " WHERE talkbackreply=" + talkbackreply);
        } finally
        {
            db.close();
        }
        this.text = text;
    }

    public int getTalkback()
    {
        return talkback;
    }

    public String getMember()
    {
        return member;
    }

    public String getText()
    {
        return text;
    }

    public Date getTime()
    {
        return time;
    }

    public String getTimeToString()
    {
        return Entity.sdf.format(time);
    }

    public int getTalkbackReply()
    {
        return talkbackreply;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getHidden()
    {
        return hidden;
    }

    public String getIp()
    {
        return ip;
    }

    public String getAuditmember()
    {
        return auditmember;
    }

    public Date getAudittime()
    {
        return audittime;
    }

    public String getName()
    {
        return name;
    }

    public String getCountry()
    {
        return country;
    }

}
