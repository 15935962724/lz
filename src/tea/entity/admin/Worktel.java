package tea.entity.admin;

import java.util.*;
import java.sql.SQLException;
import tea.db.DbAdapter;
import tea.entity.*;

public class Worktel extends Entity
{
    public static final java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm E");
    private static Cache _cache = new Cache(100);
    private int worktel;
    private String content;
    private boolean exists;
    private String community;
    private Date ctime;
    private Date utime;
    private int workproject;
    private String worklinkman;
    private boolean teltype;
    private String telephone;
    private String member;
    private String imember; //此内容需要通知的人员(选择公司内部人员,可利用EMAIL发给相关人员)


    public Worktel(int worktel) throws SQLException
    {
        this.worktel = worktel;
        load();
    }

    public static Worktel find(int worktel) throws SQLException
    {
        Worktel obj = (Worktel) _cache.get(new Integer(worktel));
        if(obj == null)
        {
            obj = new Worktel(worktel);
            _cache.put(new Integer(worktel),obj);
        }
        return obj;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,member,workproject,worklinkman,teltype,telephone,content,imember,ctime,utime FROM Worktel WHERE worktel=" + worktel);
            if(db.next())
            {
                community = db.getString(1);
                member = db.getString(2);
                workproject = db.getInt(3);
                worklinkman = db.getString(4);
                teltype = db.getInt(5) != 0;
                telephone = db.getString(6);
                content = db.getString(7);
                imember = db.getString(8);
                ctime = db.getDate(9);
                utime = db.getDate(10);
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

    public static int create(String community,String member,int workproject,String worklinkman,boolean teltype,String telephone,String content,String imember,java.util.Date ctime) throws SQLException
    {
        int worktel = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Worktel(community,member,workproject,worklinkman,teltype,telephone,content,imember,ctime,utime)VALUES(" +
                             DbAdapter.cite(community) + "," + DbAdapter.cite(member) + "," + workproject + "," + DbAdapter.cite(worklinkman) + "," + DbAdapter.cite(teltype) + "," + DbAdapter.cite(telephone) + "," + DbAdapter.cite(content) + "," + DbAdapter.cite(imember) + "," + DbAdapter.cite(ctime) + "," + DbAdapter.cite(ctime) + " )");
            worktel = db.getInt("SELECT MAX(worktel) FROM Worktel");
        } finally
        {
            db.close();
        }
        return worktel;
    }

    public void set(int workproject,String worklinkman,boolean teltype,String telephone,String content,String imember,java.util.Date utime) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Worktel SET workproject=" + workproject + ",worklinkman=" + DbAdapter.cite(worklinkman) + ",teltype=" + DbAdapter.cite(teltype) + ",telephone=" + DbAdapter.cite(telephone) + ",content=" + DbAdapter.cite(content) + ",imember=" + DbAdapter.cite(imember) + ",utime=" + DbAdapter.cite(utime) + " WHERE worktel=" + worktel);
        } finally
        {
            db.close();
        }
        this.workproject = workproject;
        this.worklinkman = worklinkman;
        this.teltype = teltype;
        this.telephone = telephone;
        this.content = content;
        this.imember = imember;
        this.utime = utime;
    }

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            count = db.getInt("SELECT COUNT(worktel) FROM Worktel WHERE community=" + DbAdapter.cite(community) + sql);
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
            db.executeUpdate("DELETE Worktel WHERE worktel=" + worktel);
        } finally
        {
            db.close();
        }
        this.exists = false;
        _cache.remove(new Integer(worktel));
    }

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT worktel FROM Worktel WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
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

    public int getWorktel()
    {
        return worktel;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getCommunity()
    {
        return community;
    }


    public int getWorkproject()
    {
        return workproject;
    }

    public String getWorklinkman()
    {
        return worklinkman;
    }


    public String getMember()
    {
        return member;
    }

    public Date getUtime()
    {
        return utime;
    }

    public String getUtimeToString()
    {
        return sdf2.format(utime);
    }

    public boolean isTeltype()
    {
        return teltype;
    }

    public String getTelephone()
    {
        return telephone;
    }

    public String getImember()
    {
        return imember;
    }

    public Date getCtime()
    {
        return ctime;
    }

    public String getCtimeToString()
    {
        return sdf.format(ctime);
    }

    public String getContent(int language)
    {
        return content;
    }
}
