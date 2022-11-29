package tea.entity.member;

import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;
import tea.entity.integral.*;
import tea.entity.site.*;

public class Logs extends Entity
{
    public static final String LOGIN_TYPE[] =
            {"LogSignUp","LogLogin","编辑节点","删除节点","编辑列举","删除列举","编辑段落","删除段落","编辑CJ","删除CJ","后台管理"};
    public static final int LOGTYPE_NEW = 0;
    public static final int LOGTYPE_LOGIN = 1;
    private String community;
    private String v;
    private Date time;
    private static Date _lastTime;
    private int type;
    private int opid;
    private String log;

    private Logs(String community,String vmember,Date time,int type,int opid,String log)
    {
        this.community = community;
        this.v = vmember;
        this.time = time;
        this.type = type;
        this.opid = opid;
        this.log = log;
    }

    static String last;
    public static void create(String community,RV rv,int type,int opid,String log) throws SQLException
    {
        Date time = new Date();
        //防止点击过快，重复插入
        String s = rv._strR + ":" + (time.getTime() / 1000L);
        if(s.equals(last))
            return;
        last = s;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(0,"INSERT INTO Logs(community,rmember,vmember,time,type,opid,log)VALUES(" + DbAdapter.cite("Home") + "," + DbAdapter.cite(rv._strR) + "," + DbAdapter.cite(rv._strV) + "," + db.cite(time) + "," + type + "," + opid + "," + DbAdapter.cite(log) + ")");
        } finally
        {
            db.close();
        }
        //Communityintegral comm = Communityintegral.find(community);
        //IntegralCycle.create(rv.toString(),comm.getLoginintegral(),time,1,community);
    }

    public static int count(String member,int type) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(rmember)  FROM Logs WHERE rmember=" + db.cite(member) + " AND type=" + type);
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

    public static boolean isLogs(String sql,String member,int type) throws SQLException
    {
        boolean i = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT rmember  FROM Logs WHERE rmember=" + db.cite(member) + " AND type=" + type + sql);
            if(db.next())
            {
                i = true;
            }
        } finally
        {
            db.close();
        }
        return i;
    }

    //判断登录次数
    public static int countlogs(String member,String sql) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(rmember)  FROM Logs WHERE rmember=" + db.cite(member) + sql);
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

    public static Date getLastLogin(String member) throws SQLException
    {
        Date date = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT time FROM Logs WHERE rmember=" + db.cite(member) + " AND type=1 ORDER BY time DESC",0,2);
            db.next(); //跳过本次
            if(db.next())
            {
                date = db.getDate(1);
            }
        } finally
        {
            db.close();
        }
        return date;
    }

    public String getLog()
    {
        return log;
    }

    public Date getTime()
    {
        return time;
    }

    public String getTimeToString()
    {
        return sdf2.format(time);
    }

    public String getVMember()
    {
        return v;
    }

    public int getType()
    {
        return type;
    }

    public static int count(Date date,Date date1) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            i = db.getInt("SELECT COUNT(rmember) FROM Logs WHERE time>=" + DbAdapter.cite(date) + " AND time<=" + DbAdapter.cite(date1) + " AND type=" + 1);
        } finally
        {
            db.close();
        }
        return i;
    }

    public static Enumeration findByDate(Date date,Date date1) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT rmember FROM Logs WHERE time>=" + DbAdapter.cite(date) + " AND time<=" + DbAdapter.cite(date1) + " AND type=" + 1);
            while(db.next())
            {
                v.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static int countByDate() throws SQLException
    {
        Calendar c = Calendar.getInstance();
        c.setTimeInMillis(System.currentTimeMillis());
        c.set(11,0);
        c.set(12,0);
        c.set(13,0);
        c.set(14,0);
        DbAdapter db = new DbAdapter();
        try
        {
            return db.getInt("SELECT COUNT(rmember) FROM Logs WHERE time>" + DbAdapter.cite(c.getTime()) + " AND type=" + 1);
        } finally
        {
            db.close();
        }
    }

    public static int count(String community,String sql) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            i = db.getInt("SELECT COUNT(rmember)  FROM Logs  WHERE community=" + DbAdapter.cite(community) + sql);
        } finally
        {
            db.close();
        }
        return i;
    }

    public static int countByRV(RV rv) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            i = db.getInt("SELECT COUNT(rmember) FROM Logs WHERE rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV));
        } finally
        {
            db.close();
        }
        return i;
    }

    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,vmember,time,type,opid,log FROM Logs WHERE 1=1" + sql + " ORDER BY time DESC",pos,size);
            while(db.next())
            {
                vector.addElement(new Logs(db.getString(1),db.getString(2),db.getDate(3),db.getInt(4),db.getInt(5),db.getString(6)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();

    }

    public static int coutmember(String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(DISTINCT vmember)  FROM Logs WHERE 1=1" + sql);
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

    public static Date getLastLoginClient(String member) throws SQLException
    {
        Date date = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT time FROM Logs WHERE rmember=" + db.cite(member) + " AND type=99 ORDER BY time DESC",0,2);

            if(db.next())
            {
                date = db.getDate(1);
            }
        } finally
        {
            db.close();
        }
        return date;
    }

    public static int readcount(String sql) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            i = db.getInt("SELECT COUNT(opid)  FROM Logs  WHERE 1=1" + sql);
        } finally
        {
            db.close();
        }
        return i;
    }

    public static Enumeration read(String sql) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {

            db.executeQuery("SELECT distinct top 30 opid  FROM Logs WHERE 1=1" + sql);
            System.out.println("SELECT distinct top 30 opid  FROM Logs WHERE 1=1" + sql);
            while(db.next())
            {
                vector.addElement(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static void delete(RV rv) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Logs WHERE rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV) + " AND type=" + 1);
        } finally
        {
            db.close();
        }
    }

    public static Date getLastTime(RV rv) throws SQLException
    {
        Date time;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT time FROM Logs WHERE rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV) + " ORDER BY time DESC");
            if(db.next())
            {
                time = db.getDate(1);
                if(db.next())
                {
                    time = db.getDate(1);
                }
            } else
            {
                time = new Date();
            }
        } finally
        {
            db.close();
        }
        return time;
    }

    public static Date getLastTimeByR(RV rv) throws SQLException
    {
        Date time;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT time FROM Logs WHERE rmember=" + DbAdapter.cite(rv._strR) + " ORDER BY time DESC");
            if(db.next())
            {
                time = db.getDate(1);
                if(db.next())
                {
                    time = db.getDate(1);
                }
            } else
            {
                time = new Date();
            }
        } finally
        {
            db.close();
        }
        return time;
    }

    public String getCommunity()
    {
        return community;
    }

    public int getOpid()
    {
        return opid;
    }
}
