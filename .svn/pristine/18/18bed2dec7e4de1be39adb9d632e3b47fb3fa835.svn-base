package tea.entity.member;

import java.util.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;
import java.util.Date;

public class Point extends Entity
{
    private static Cache _cache = new Cache(100);
    private int point;
    private String member;
    private int changes;//changes 本次积分
    private int balance;//  balance 总积分

    private Date time;
    private String changereason;
    private String sourceorder;

    public static Point find(int point) throws SQLException
    {
        Point obj = (Point) _cache.get(new Integer(point));
        if (obj == null)
        {
            obj = new Point(point);
            _cache.put(new Integer(point), obj);
        }
        return obj;
    }

    private Point(int point) throws SQLException
    {
        this.point = point;
        load();
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT member,changes,balance,time,changereason,sourceorder FROM point WHERE point=" + point);
            if (db.next())
            {
                member = db.getString(1);
                changes = db.getInt(2);
                balance = db.getInt(3);
                time = db.getDate(4);
                changereason=db.getString(5);
                sourceorder=db.getString(6);
            }
        }  finally
        {
            db.close();
        }
    }

    public static void create(String member, int changes) throws SQLException
    {
        int balance = getLastPoint(member) - changes;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO point (member,changes,balance,time)VALUES(" + db.cite(member) + "," + changes + "," + balance + "," +new Date() + ")");
        //System.out.print("INSERT INTO point (member,changes,balance,time)VALUES(" + db.cite(member) + "," + changes + "," + balance + "," + DbAdapter.citeCurTime() + ")");


        }  finally
        {
            db.close();
        }
    }
    public static void create(String member, int changes,String changereason,String sourceorder) throws SQLException
    {
        int balance = getLastPoint(member) + changes;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO point (member,changes,balance,time,changereason,sourceorder)VALUES(" + db.cite(member) + "," + changes + "," + balance + "," + new Date() + ",'"+changereason+"','"+sourceorder+"')");
        //System.out.print("INSERT INTO point (member,changes,balance,time)VALUES(" + db.cite(member) + "," + changes + "," + balance + "," + DbAdapter.citeCurTime() + ")");

        }  finally
        {
            db.close();
        }
    }
    public static int countByMember(String member, String sql) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM point po WHERE po.member=" + db.cite(member) + sql);
            if (db.next())
            {
                i = db.getInt(1);
            }
        }  finally
        {
            db.close();
        }
        return i;
    }

    public static int countMember(String community, String sql) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
           i= db.getInt("SELECT COUNT( DISTINCT po.member ) FROM point po INNER JOIN Profile pr ON po.member=pr.member WHERE pr.community=" + db.cite(community) + sql);
       // System.out.print("SELECT COUNT( DISTINCT po.member ) FROM point po INNER JOIN Profile pr ON po.member=pr.member WHERE pr.community=" + db.cite(community) + sql);
        } finally
        {
            db.close();
        }
        return i;
    }


    public static Enumeration findByMember(String member, String sql, int size, int pos) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT po.point FROM point po WHERE po.member=" + db.cite(member) + sql);
            //System.out.println("SELECT po.point FROM point po WHERE po.member=" + db.cite(member) + sql);
            for (int k = 0; k < size + pos && db.next(); k++)
            {
                if (k >= size)
                {
                    v.addElement(new Integer(db.getInt(1)));
                }
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Enumeration findMember(String community, String sql, int size, int pos) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT DISTINCT po.member FROM point po INNER JOIN Profile pr ON po.member=pr.member WHERE pr.community=" + db.cite(community) + sql);
            for (int k = 0; k < size + pos && db.next(); k++)
            {
                if (k >= size)
                {
                    v.addElement(db.getString(1));
                }
            }
        }  finally
        {
            db.close();
        }
        return v.elements();
    }

//会员的积分
    public static int getLastPoint(String member) throws SQLException
    {
        int balance = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT balance FROM point WHERE member=" + db.cite(member) + " ORDER BY time DESC");
            if (db.next())
            {
                balance = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return balance;
    }

    public Date getTime()
    {
        return time;
    }

    public String getTimeToString()
    {
        return sdf.format(time);
    }

    public int getPoint()
    {
        return point;
    }

    public String getMember()
    {
        return member;
    }
    public String getChangeReason()
    {
        return changereason;
    }
    public String getSourceOrder()
    {
        return sourceorder;
    }
    public int getChanges()
    {
        return changes;
    }

    public int getBalance()
    {
        return balance;
    }
}
