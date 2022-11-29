package tea.entity.node;

import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class PollPoint extends Entity
{
    private static Cache _cache = new Cache(100);
    private int point;
    private int pollpoint;
    private Date time;
    private int node;
    private String member;


    public static void create(int node,RV rv,int point)
    {
        String member = (rv != null ? rv.toString() : null);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO PollPoint(node,member,point,time)VALUES(" + node + "," + DbAdapter.cite(member) + ", " + point + ", " + DbAdapter.cite(new Date()) + " )");
        } catch(Exception exception)
        {
            exception.printStackTrace();
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(point));

    }

    private PollPoint(int pollpoint) throws SQLException
    {
        this.pollpoint = pollpoint;
        loadBasic();
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node,member,point,time  FROM PollPoint WHERE pollpoint=" + pollpoint);
            if(db.next())
            {
                node = db.getInt(1);
                member = db.getString(2);
                point = db.getInt(3);
                time = db.getDate(4);
            }
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
            db.executeUpdate("DELETE FROM PollPoint WHERE pollpoint=" + pollpoint);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(pollpoint));
    }

    public static PollPoint find(int id) throws SQLException
    {
        PollPoint poll = (PollPoint) _cache.get(new Integer(id));
        if(poll == null)
        {
            poll = new PollPoint(id);
            _cache.put(new Integer(id),poll);
        }
        return poll;
    }

    public static PollPoint find(int _nNode,String member) throws SQLException
    {
        int pollpoint = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT pollpoint FROM PollPoint WHERE node=" + _nNode + " AND member=" + DbAdapter.cite(member));
            if(db.next())
            {
                pollpoint = db.getInt(1);
            }
        } catch(Exception exception)
        {
            exception.printStackTrace();
        } finally
        {
            db.close();
        }
        return find(pollpoint);
    }

    public int getPoint()
    {
        return point;
    }

    public Date getTime()
    {
        return time;
    }

    public int getNode()
    {
        return node;
    }

    public int getPollpoint()
    {
        return pollpoint;
    }

    public String getMember()
    {
        return member;
    }


}
