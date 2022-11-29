package tea.entity.cio;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class CioFeedback extends Entity
{
    private static Cache _cache = new Cache(100);
    private int ciofeedback;
    private String community;
    private String member;
    private String content;
    private Date time;
    private boolean exists;
    public CioFeedback(int ciofeedback) throws SQLException
    {
        this.ciofeedback = ciofeedback;
        load();
    }

    public CioFeedback(int ciofeedback,String community,String member,String content,Date time) throws SQLException
    {
        this.ciofeedback = ciofeedback;
        this.community = community;
        this.member = member;
        this.content = content;
        this.time = time;
        this.exists = true;
    }

    public static CioFeedback find(int ciofeedback) throws SQLException
    {
        CioFeedback obj = (CioFeedback) _cache.get(ciofeedback);
        if(obj == null)
        {
            obj = new CioFeedback(ciofeedback);
            _cache.put(ciofeedback,obj);
        }
        return obj;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,member,content,time FROM CioFeedback WHERE ciofeedback=" + ciofeedback);
            if(db.next())
            {
                int j = 1;
                community = db.getString(j++);
                member = db.getString(j++);
                content = db.getString(j++);
                time = db.getDate(j++);
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

    public static void create(String community,String member,String content) throws SQLException
    {
        StringBuilder sql = new StringBuilder();
        sql.append("INSERT INTO CioFeedback(community,member,content,time)VALUES(");
        sql.append(DbAdapter.cite(community));
        sql.append(",").append(DbAdapter.cite(member));
        sql.append(",").append(DbAdapter.cite(content));
        sql.append(",").append(DbAdapter.cite(new Date()));
        sql.append(")");
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sql.toString());
        } finally
        {
            db.close();
        }
    }

    public static int count(String community,String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM CioFeedback WHERE ciofeedback IN ( SELECT ciofeedback FROM CioCompany WHERE community=" + DbAdapter.cite(community) + ")" + sql);
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


    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT ciofeedback,member,content,time FROM CioFeedback WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
            while(db.next())
            {
                int j = 1;
                int ciofeedback = db.getInt(j++);
                String member = db.getString(j++);
                String content = db.getString(j++);
                Date time = db.getDate(j++);
                CioFeedback obj = new CioFeedback(ciofeedback,community,member,content,time);
                _cache.put(ciofeedback,obj);
                v.add(obj);
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Enumeration find(String community,int choose,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        DbAdapter db2 = new DbAdapter();
        try
        {
            db.executeQuery("SELECT choose" + choose + ",COUNT(choose" + choose + ") FROM CioFeedback WHERE community=" + DbAdapter.cite(community) + " GROUP BY choose" + choose + " ORDER BY COUNT(choose" + choose + ") DESC");
            while(db.next())
            {
                String str = db.getString(1);
                int cc = db.getInt(2);
                int cs[] = new int[2];
                db2.executeQuery("SELECT score" + choose + ",COUNT(score" + choose + ") FROM CioFeedback WHERE community=" + DbAdapter.cite(community) + " AND choose" + choose + "=" + DbAdapter.cite(str) + " GROUP BY score" + choose);
                while(db2.next())
                {
                    int s = db2.getInt(1);
                    int c = db2.getInt(2);
                    cs[s] = c;
                }
                v.add(new Object[]
                      {
                      str,cc,cs[0],cs[1]
                });
            }
        } finally
        {
            db.close();
            db2.close();
        }
        return v.elements();
    }

    public void set(String choose[],String score[]) throws SQLException
    {
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE CioFeedback SET community=").append(DbAdapter.cite(community));
        for(int i = 0;i < choose.length;i++)
        {
            sql.append(",choose").append(i).append("=").append(DbAdapter.cite(choose[i]));
        }
        for(int i = 0;i < score.length;i++)
        {
            sql.append(",score").append(i).append("=").append(score[i]);
        }
        sql.append(" WHERE ciofeedback=").append(ciofeedback);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sql.toString());
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
            db.executeUpdate("DELETE FROM CioFeedback WHERE ciofeedback=" + ciofeedback);
        } finally
        {
            db.close();
        }
        _cache.remove(ciofeedback);
    }

    public boolean isExists()
    {
        return exists;
    }

    public Date getTime()
    {
        return time;
    }

    public String getTimeToString()
    {
        return sdf2.format(time);
    }

    public String getMember()
    {
        return member;
    }

    public String getContent()
    {
        return content;
    }

    public int getCioFeedback()
    {
        return ciofeedback;
    }


}
