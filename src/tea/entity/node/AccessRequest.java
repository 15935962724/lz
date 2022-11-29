package tea.entity.node;

import java.util.Enumeration;
import java.util.Vector;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class AccessRequest extends Entity
{
    public static boolean isAccessRequest(int i,RV rv) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node  FROM AccessRequest  WHERE node=" + i + " AND rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV));
            flag = db.next();
        } finally
        {
            db.close();
        }
        return flag;
    }

    /*
     * CREATE PROCEDURE AccessRequestGrant @node int, @rmember nvarchar(20), @vmember nvarchar(20)
     *
     * AS DELETE FROM AccessRequest WHERE node=@node AND rmember=@rmember AND vmember=@vmember
     *
     * IF NOT EXISTS (SELECT node FROM AccessMember WHERE node=@node AND rmember=@rmember AND vmember=@vmember) INSERT INTO AccessMember (node, rmember, vmember) VALUES(@node, @rmember, @vmember)
     *
     */
    public static void grant(int node,RV rv) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM AccessRequest WHERE node=" + node + " AND rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV));
            //if (!AccessMember.isAccessMember(node, rv))
            //{
            //AccessMember.create(node, rv, true);
            //}
        } finally
        {
            db.close();
        }
    }

    public static void create(int node,RV rv) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO AccessRequest(node, rmember, vmember)VALUES(" + node + ", " + DbAdapter.cite(rv._strR) + ", " + DbAdapter.cite(rv._strV) + ")");
        } finally
        {
            db.close();
        }
    }

    public AccessRequest()
    {
    }

    public static int countNodes(RV rv) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            i = db.getInt("SELECT COUNT(n.node) " + getNodesSql(rv));
        } finally
        {
            db.close();
        }
        return i;
    }

    public static boolean isExisted(int i) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node  FROM AccessRequest  WHERE node=" + i);
            flag = db.next();
        } finally
        {
            db.close();
        }
        return flag;
    }

    public static Enumeration findNodes(RV rv,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT DISTINCT n.node " + getNodesSql(rv),pos,size);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static void deny(int i,RV rv) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM AccessRequest WHERE node=" + i + " AND rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV));
        } finally
        {
            db.close();
        }
    }

    public static int count(int node) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.getInt("SELECT COUNT(node)  FROM AccessRequest  WHERE node=" + node);
        } finally
        {
            db.close();
        }
        return j;
    }

    public static Enumeration find(int node,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT rmember, vmember FROM AccessRequest  WHERE node=" + node + " ORDER BY rmember, vmember ",pos,size);
            while(db.next())
            {
                v.addElement(new RV(db.getString(1),db.getString(2)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    private static String getNodesSql(RV rv)
    {
        return " FROM Node n, AccessRequest ar  WHERE n.node=ar.node  AND n.rcreator=" + DbAdapter.cite(rv._strR);
    }

    public static void delete(int i,RV rv) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM AccessRequest  WHERE node=" + i + " AND rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV));
        } finally
        {
            db.close();
        }
    }

    public static void delete(int i) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM AccessRequest  WHERE node=" + i);
        } finally
        {
            db.close();
        }
    }

    public static int getCount(int i) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.getInt("SELECT COUNT(node)  FROM AccessRequest  WHERE node=" + i);
        } finally
        {
            db.close();
        }
        return j;
    }
}
