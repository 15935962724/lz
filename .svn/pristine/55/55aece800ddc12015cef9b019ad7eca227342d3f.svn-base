package tea.entity.member;

import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;
import tea.entity.site.*;

public class OnlineList extends Entity
{
    private static Cache _cache = new Cache(100);
    private String community;
    private String member;
    private Date time;
    private String ip;
    private String sessionid;
    public int state; //状态: 1:被踢
    private boolean _blLoaded;

    
    public void set(String community,String ip) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter(1);
        try
        {
            j = db.executeUpdate("UPDATE OnlineList SET community=" + DbAdapter.cite(community) + ",ip=" + DbAdapter.cite(ip) + " WHERE sessionid=" + DbAdapter.cite(sessionid));
        } finally
        {
            db.close();
        }
        this.community = community;
        this.ip = ip;
    }

    /*
     * public void set(TeaSession teasession) throws SQLException { javax.servlet.http.HttpServletRequest request = teasession.getRequest(); String _strIp = request.getRemoteAddr(); String member = null; if (teasession._rv != null) member = teasession._rv._strV; int count = 0; DbAdapter db = new DbAdapter(1); try { count = db.executeUpdate("UPDATE OnlineList SET community=" + DbAdapter.cite(teasession.community) + ",member=" + DbAdapter.cite(member) + ",ip=" +
     * DbAdapter.cite(_strIp) + " WHERE sessionid=" + DbAdapter.cite(sessionid)); } finally { db.close(); } if (count > 0) { this.community = teasession.community; this.ip = ip; this.member=member; } else { } }
     */
    public void setMember(String member) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("UPDATE OnlineList SET member=" + DbAdapter.cite(member) + " WHERE sessionid=" + DbAdapter.cite(sessionid));
        } finally
        {
            db.close();
        }
        this.member = member;
    }

    public static void create(String sessionid,String community,String member,String ip) throws SQLException
    {
        boolean del = member != null && Community.find(community).isLUnique();
        DbAdapter db = new DbAdapter(1);
        try
        {
            int j = db.executeUpdate("UPDATE OnlineList SET community=" + DbAdapter.cite(community) + ",member=" + DbAdapter.cite(member) + ",ip=" + DbAdapter.cite(ip) + " WHERE sessionid=" + DbAdapter.cite(sessionid));
            if(j < 1)
                db.executeUpdate("INSERT INTO OnlineList(sessionid,community,member,time,ip,state)VALUES(" + DbAdapter.cite(sessionid) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(member) + "," + db.citeCurTime() + "," + DbAdapter.cite(ip) + ",0)");
            if(del)
            {
                db.executeQuery("SELECT sessionid FROM OnlineList WHERE sessionid!=" + DbAdapter.cite(sessionid) + " AND member=" + DbAdapter.cite(member));
                while(db.next())
                {
                    OnlineList.find(db.getString(1)).setState(1);
                }
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
        } finally
        {
            db.close();
        }
        _cache.remove(sessionid);
    }


    private OnlineList(String sessionid)
    {
        this.sessionid = sessionid;
    }

    public boolean isOnline() throws SQLException
    {
        Date date = getTime();
        if(date == null)
        {
            return false;
        } else
        {
            return date.after(new Date(System.currentTimeMillis() - 0x927c0L));
        }
    }

    public static Enumeration findOnline(String community) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT ol.member FROM OnlineList ol INNER JOIN AdminUsrRole aur ON ol.member=aur.member AND ol.community=" + db.cite(community) + " AND aur.community=" + db.cite(community) + " ORDER BY aur.unit DESC,aur.sequence");
            while(db.next())
            {
                String str = db.getString(1);
                if(vector.indexOf(str) == -1)
                {
                    vector.addElement(str);
                }
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static Enumeration findOnlineNew(String community) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {
            //db.executeQuery("SELECT ol.member FROM OnlineList ol INNER JOIN AdminUsrRole aur ON ol.member=aur.member AND ol.community=" + db.cite(community) + " AND aur.community=" + db.cite(community) + " ORDER BY aur.unit DESC,aur.sequence");
            db.executeQuery("SELECT ol.member FROM OnlineList ol INNER JOIN Profile p ON p.member=ol.member INNER JOIN AdminUsrRole aur ON p.profile=aur.member  AND ol.community=" + db.cite(community) + " AND aur.community=" + db.cite(community) + " ORDER BY aur.unit DESC,aur.sequence");
            while(db.next())
            {
                String str = db.getString(1);
                if(vector.indexOf(str) == -1)
                {
                    vector.addElement(str);
                }
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }
    
    public Date getTime() throws SQLException
    {
        load();
        return time;
    }

    public String getTimeToString() throws SQLException
    {
        load();
        return sdf2.format(time);
    }

    public String getTimeToSeconds() throws SQLException
    {
        load();
        int sec = (int) (System.currentTimeMillis() - time.getTime()) / 1000;
        StringBuilder sb = new StringBuilder();
        int i = sec / 60;
        int j = sec % 60;
        if(i < 10)
        {
            sb.append("0");
        }
        sb.append(i).append(":");
        if(j < 10)
        {
            sb.append("0");
        }
        sb.append(j);
        return sb.toString();
    }

    private void load() throws SQLException
    {
        if(!_blLoaded)
        {
            DbAdapter db = new DbAdapter(1);
            try
            {
                db.executeQuery("SELECT community,member,time,ip,state FROM OnlineList WHERE sessionid=" + DbAdapter.cite(sessionid));
                if(db.next())
                {
                    community = db.getString(1);
                    member = db.getString(2);
                    time = db.getDate(3);
                    ip = db.getString(4);
                    state = db.getInt(5);
                }
            } finally
            {
                db.close();
            }
            _blLoaded = true;
        }
    }

    public String getIP() throws SQLException
    {
        load();
        return ip;
    }

    public static OnlineList find(String sessionid)
    {
        OnlineList online = (OnlineList) _cache.get(sessionid);
        if(online == null)
        {
            online = new OnlineList(sessionid);
            _cache.put(sessionid,online);
        }
        return online;
    }

    public static int countByCommunity(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT COUNT(sessionid) FROM OnlineList WHERE community=" + DbAdapter.cite(community) + sql);
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

    public static Enumeration findByCommunity(String community,String sql) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT sessionid FROM OnlineList WHERE community=" + DbAdapter.cite(community) + sql);
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

    public String getSessionid()
    {
        return sessionid;
    }

    public String getMember() throws SQLException
    {
        load();
        return member;
    }

    public void setState(int state) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("UPDATE OnlineList SET state=" + state + " WHERE sessionid=" + DbAdapter.cite(sessionid));
        } finally
        {
            db.close();
        }
        this.state = state;
    }

    public String getCommunity() throws SQLException
    {
        load();
        return community;
    }

    public void delete() throws SQLException
    {
        Calendar c = Calendar.getInstance();
        c.setTimeInMillis(System.currentTimeMillis());
        c.set(c.HOUR_OF_DAY,c.get(c.HOUR_OF_DAY) - 2);
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("DELETE FROM OnlineList WHERE sessionid=" + DbAdapter.cite(sessionid));
            db.executeQuery("SELECT sessionid FROM OnlineList WHERE time<" + DbAdapter.cite(c.getTime()));
            while(db.next())
            {
                _cache.remove(db.getString(1));
            }
            db.executeUpdate("DELETE FROM OnlineList WHERE time<" + DbAdapter.cite(c.getTime()));
        } finally
        {
            db.close();
        }
        _cache.remove(sessionid);
    }
}
