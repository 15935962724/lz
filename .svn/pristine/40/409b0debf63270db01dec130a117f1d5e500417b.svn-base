package tea.entity.member;

import tea.entity.*;
import tea.db.DbAdapter;
import java.util.*;
import java.sql.SQLException;

public class ProfileJob extends Entity
{
    public static Cache _cache = new Cache(100);
    private String member;
    private String community;
    private boolean auditing;
    private boolean exists;

    public ProfileJob(String member,String community) throws SQLException
    {
        this.member = member;
        this.community = community;
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT pj.auditing FROM ProfileJob pj WHERE pj.member=" + DbAdapter.cite(member) + " AND pj.community=" + DbAdapter.cite(community));
            if(db.next())
            {
                auditing = db.getInt(1) != 0;
                exists = true;
            } else
            {
                exists = false;
            }
        } catch(Exception exception1)
        {
            throw new SQLException(exception1.toString());
        } finally
        {
            db.close();
        }
    }

    public static ProfileJob find(String member,String community) throws SQLException
    {
        ProfileJob obj = (ProfileJob) _cache.get(member + ":" + community);
        if(obj == null)
        {
            obj = new ProfileJob(member,community);
            _cache.put(member + ":" + community,obj);
        }
        return obj;
    }

    public static void create(String member,String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO ProfileJob(member,community,auditing)VALUES(" + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + ",0)");
        } catch(Exception exception1)
        {
            throw new SQLException(exception1.toString());
        } finally
        {
            db.close();
        }
    }

    public static java.util.Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT pj.member FROM ProfileJob pj INNER JOIN Profile p ON pj.member=p.member AND pj.community=p.community WHERE pj.community=" + DbAdapter.cite(community) + sql,pos,size);
            while(db.next())
            {
                vector.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static int count(String community,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            return db.getInt("SELECT COUNT(pj.member) FROM ProfileJob pj INNER JOIN Profile p ON pj.member=p.member AND pj.community=p.community WHERE pj.community=" + DbAdapter.cite(community) + sql);
        } catch(Exception exception1)
        {
            throw new SQLException(exception1.toString());
        } finally
        {
            db.close();
        }
    }

    public void set(boolean auditing) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE ProfileJob SET auditing=" + DbAdapter.cite(auditing) + " WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
        } catch(Exception exception1)
        {
            throw new SQLException(exception1.toString());
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
            db.executeUpdate("DELETE ProfileJob WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
        } catch(Exception exception1)
        {
            throw new SQLException(exception1.toString());
        } finally
        {
            db.close();
        }
    }

    public String getMember()
    {
        return member;
    }

    public String getCommunity()
    {
        return community;
    }

    public boolean isAuditing()
    {
        return auditing;
    }

    public boolean isExists()
    {
        return exists;
    }
}
