package tea.entity.site;

import java.util.Enumeration;
import java.util.Vector;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class JoinRequest extends Entity
{

    public static int countRequestCommunities(RV rv) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter(1);
        try
        {
            i = db.getInt("SELECT COUNT(DISTINCT jr.community) " + getRequestCommunitiesSql(rv));
        } finally
        {
            db.close();
        }
        return i;
    }

    public static int countRequests(String s) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter(1);
        try
        {
            i = db.getInt("SELECT COUNT(community) " + getRequestsSql(s));
        } finally
        {
            db.close();
        }
        return i;
    }

    public static void grant(String s,RV rv) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("JoinRequestGrant " + DbAdapter.cite(s) + ", " + DbAdapter.cite(rv._strR) + ", " + DbAdapter.cite(rv._strV));
        } finally
        {
            db.close();
        }
    }

    public static Enumeration findJoining(RV rv) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT c.community " + getJoiningSql(rv));
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

    public static void create(String s,RV rv) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("JoinRequestCreate " + DbAdapter.cite(s) + ", " + DbAdapter.cite(rv._strR) + ", " + DbAdapter.cite(rv._strV));
        } finally
        {
            db.close();
        }
    }

    public JoinRequest()
    {
    }

    public static Enumeration findRequestCommunities(RV rv) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT DISTINCT jr.community " + getRequestCommunitiesSql(rv));
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

    public static Enumeration findRequests(String s,int i,int j) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT rmember,vmember FROM JoinRequest WHERE community=" + DbAdapter.cite(s) + " AND cmember!=" + DbAdapter.cite(s),i,j);
            while(db.next())
            {
                vector.addElement(new RV(db.getString(1),db.getString(2)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static boolean isExisted(String s,RV rv) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT community FROM JoinRequest WHERE community=" + DbAdapter.cite(s) + " AND rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV));
            flag = db.next();
        } finally
        {
            db.close();
        }
        return flag;
    }

    private static String getRequestCommunitiesSql(RV rv)
    {
        return " FROM Organizer o, JoinRequest jr  WHERE o.community=jr.community  AND o.member=" + DbAdapter.cite(rv._strR);
    }

    private static String getRequestsSql(String s)
    {
        return " FROM JoinRequest  WHERE community=" + DbAdapter.cite(s);
    }

    public static boolean isExisted(String s) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT community   FROM JoinRequest  WHERE community=" + DbAdapter.cite(s));
            flag = db.next();
        } finally
        {
            db.close();
        }
        return flag;
    }

    public static void deny(String s,RV rv) throws SQLException
    {
        delete(s,rv);
    }

    public static void delete(String s,RV rv) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("DELETE FROM JoinRequest  WHERE community=" + DbAdapter.cite(s) + " AND rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV));
        } finally
        {
            db.close();
        }
    }

    public static Enumeration find(String s,int i,int j) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT rmember, vmember,cmember FROM JoinRequest  WHERE community=" + DbAdapter.cite(s) + " ORDER BY rmember, vmember ",i,j);
            while(db.next())
            {
                vector.addElement(new RV(db.getString(1),db.getString(2)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    private static String getJoiningSql(RV rv)
    {
        return " FROM Community c, JoinRequest jr  WHERE c.community=jr.community  AND rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV);
    }

    public static int countJoining(RV rv) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter(1);
        try
        {
            i = db.getInt("SELECT COUNT(c.community) " + getJoiningSql(rv));
        } finally
        {
            db.close();
        }
        return i;
    }
}
