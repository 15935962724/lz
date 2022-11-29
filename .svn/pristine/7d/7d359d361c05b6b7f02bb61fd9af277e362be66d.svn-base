package tea.entity.member;

import java.util.Enumeration;
import java.util.Vector;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class ProfileRequest extends Entity
{

    public static int countRequests(String s) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            i = db.getInt("SELECT COUNT(member) " + getRequestsSql(s));
        } finally
        {
            db.close();
        }
        return i;
    }

    public static void grant(String s,RV rv) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            // db.executeUpdate("ProfileRequestGrant " + DbAdapter.cite(s) + ", " +
            // DbAdapter.cite(rv._strR) + ", " + DbAdapter.cite(rv._strV));
            db.executeUpdate("DELETE FROM ProfileRequest WHERE member=" + DbAdapter.cite(s) + "   AND rmember=" + DbAdapter.cite(rv._strR) + "  AND vmember=" + DbAdapter.cite(rv._strV));
            db.executeUpdate("INSERT INTO ProfileGrant (member, rmember, vmember)VALUES (" + DbAdapter.cite(s) + ", " + DbAdapter.cite(rv._strR) + ", " + DbAdapter.cite(rv._strV) + ")");
        } finally
        {
            db.close();
        }
    }

    public static void create(String s,RV rv) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            // db.executeUpdate("ProfileRequestCreate " + DbAdapter.cite(s) + ", " +
            // DbAdapter.cite(rv._strR) + ", " + DbAdapter.cite(rv._strV));
            db.executeQuery("SELECT member  FROM ProfileRequest	WHERE member=" + DbAdapter.cite(s) + "  AND rmember=" + DbAdapter.cite(rv._strR) + "  AND vmember=" + DbAdapter.cite(rv._strV));
            if(db.next())
            {
            } else
            {
                db.executeUpdate("INSERT INTO ProfileRequest (member, rmember, vmember)VALUES (" + DbAdapter.cite(s) + ", " + DbAdapter.cite(rv._strR) + ", " + DbAdapter.cite(rv._strV) + ")");
            }
        } finally
        {
            db.close();
        }
    }

    public ProfileRequest()
    {
    }

    public static Enumeration findRequests(String s,int i,int j) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT rmember, vmember " + getRequestsSql(s),i,j);
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
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT member   FROM ProfileRequest  WHERE member=" + DbAdapter.cite(s) + " AND rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV));
            flag = db.next();
        } finally
        {
            db.close();
        }
        return flag;
    }

    private static String getRequestsSql(String s)
    {
        return " FROM ProfileRequest  WHERE member=" + DbAdapter.cite(s);
    }

    public static void deny(String s,RV rv) throws SQLException
    {
        delete(s,rv);
    }

    public static void delete(String s,RV rv) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM ProfileRequest  WHERE member=" + DbAdapter.cite(s) + " AND rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV));
        } finally
        {
            db.close();
        }
    }
}
