package tea.entity.league;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class LeagueShopMsg extends Entity
{
    public static String STATE_TYPE[] =
            {"卡前台","卡后台","已隐藏","已删除"};
    private int leagueshopmsg;
    private int leagueshoptype;
    private String subject;
    private String content;
    private int state;
    private Date time;

    private LeagueShopMsg(int leagueshopmsg,int leagueshoptype,String subject,String content,int state,Date time)
    {
        this.leagueshopmsg = leagueshopmsg;
        this.leagueshoptype = leagueshoptype;
        this.subject = subject;
        this.content = content;
        this.state = state;
        this.time = time;
    }

    public static void create(int leagueshoptype,String subject,String content,int state) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO LeagueShopMsg(leagueshoptype,subject,content,state,time)VALUES(" + leagueshoptype + "," + db.cite(subject) + "," + db.cite(content) + "," + state + "," + db.cite(new Date()) + ")");
        } finally
        {
            db.close();
        }
    }

    public static LeagueShopMsg find(int leagueshopmsg) throws SQLException
    {
        Enumeration e = find(" AND leagueshopmsg=" + leagueshopmsg,0,1);
        if(e.hasMoreElements())
        {
            return(LeagueShopMsg) e.nextElement();
        }
        return null;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE LeagueShopMsg SET state=3,time=" + db.cite(time) + " WHERE leagueshopmsg=" + leagueshopmsg);
        } finally
        {
            db.close();
        }
    }


    public void set(String subject,String content,int state) throws SQLException
    {
        time = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE LeagueShopMsg SET subject=" + db.cite(subject) + ",content=" + db.cite(content) + ",state=" + state + ",time=" + db.cite(time) + " WHERE leagueshopmsg=" + leagueshopmsg);
        } finally
        {
            db.close();
        }
        this.subject = subject;
        this.content = content;
        this.state = state;
    }

    public static Enumeration find(int leagueshoptype,String sql,int pos,int size) throws SQLException
    {
        if(leagueshoptype > 0)
        {
            sql = " AND leagueshoptype=" + leagueshoptype + sql;
        }
        return find(sql,pos,size);
    }

    public static int count(String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM LeagueShopMsg WHERE 1=1" + sql);
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

    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT leagueshopmsg,leagueshoptype,subject,content,state,time FROM LeagueShopMsg WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                int leagueshopmsg = db.getInt(1);
                int leagueshoptype = db.getInt(2);
                String subject = db.getString(3);
                String content = db.getString(4);
                int state = db.getInt(5);
                Date time = db.getDate(6);
                v.add(new LeagueShopMsg(leagueshopmsg,leagueshoptype,subject,content,state,time));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public Date getTime()
    {
        return time;
    }

    public String getTimeToString()
    {
        return sdf2.format(time);
    }

    public String getSubject()
    {
        return subject;
    }

    public int getLeagueshopType()
    {
        return leagueshoptype;
    }

    public int getLeagueshopMsg()
    {
        return leagueshopmsg;
    }

    public String getContent()
    {
        return content;
    }

    public int getState()
    {
        return state;
    }

}
