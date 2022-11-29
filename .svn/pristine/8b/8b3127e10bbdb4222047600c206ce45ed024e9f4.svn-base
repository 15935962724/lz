package tea.entity.member;

import java.util.Enumeration;
import java.util.Vector;
import tea.db.DbAdapter;
import tea.entity.Entity;
import java.sql.SQLException;

public class MessageFolderContent extends Entity
{

    public static void create(String s, String s1, int i) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT member  FROM MessageFolder 	WHERE member=" + DbAdapter.cite(s) + "  AND messagefolder=" + DbAdapter.cite(s1));
            if (db.next())
            {
            } else
            {
                db.executeUpdate("INSERT INTO MessageFolder (member, messagefolder)VALUES (" + DbAdapter.cite(s) + ", " + DbAdapter.cite(s1) + ")");
            }
            db.executeQuery("SELECT member  FROM MessageFolderContent	WHERE member=" + DbAdapter.cite(s) + " AND messagefolder=" + DbAdapter.cite(s) + "	AND message=" + i);
            if (db.next())
            {
            } else
            {
                db.executeUpdate("INSERT INTO MessageFolderContent (member, messagefolder, message)VALUES (" + DbAdapter.cite(s) + ", " + DbAdapter.cite(s1) + ", " + i + ")");
            }
        } finally
        {
            db.close();
        }
    }

    public MessageFolderContent()
    {
    }

    public static int count(String s, String s1) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            i = db.getInt("SELECT COUNT(member)  FROM MessageFolderContent  WHERE member=" + DbAdapter.cite(s) + " AND messagefolder=" + DbAdapter.cite(s1));
        } finally
        {
            db.close();
        }
        return i;
    }

    public static Enumeration find(String s) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT message FROM MessageFolderContent WHERE messagefolder=" + DbAdapter.cite(s));
            boolean flag = false;
            for (; db.next(); vector.addElement(new Integer(db.getInt(1))))
            {
                ;
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static Enumeration find(String member, String messagefolder, int i, int j) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT message FROM MessageFolderContent WHERE member=" + DbAdapter.cite(member) + " AND messagefolder=" + DbAdapter.cite(messagefolder) + " ORDER BY message DESC");
            for (int k = 0; k < i + j && db.next(); k++)
            {
                if (k >= i)
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

    public static void delete(String s, String s1, int i) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM MessageFolderContent WHERE member=" + DbAdapter.cite(s) + " AND messagefolder=" + DbAdapter.cite(s1) + " AND message=" + i);
        } finally
        {
            db.close();
        }
    }

    public static void deleteAll(int messagefolder) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM MessageFolderContent WHERE messagefolder=" + messagefolder);
        } finally
        {
            db.close();
        }
    }

    public static int findPrev(String s, int i) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.getInt("SELECT message FROM MessageFolderContent WHERE messagefolder=" + DbAdapter.cite(s) + " AND message>" + i + " ORDER BY message ASC ");
        } finally
        {
            db.close();
        }
        return j;
    }

    public static int findNext(String s, int i) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.getInt("SELECT  message FROM MessageFolderContent WHERE messagefolder=" + DbAdapter.cite(s) + " AND message<" + i + " ORDER BY message DESC ");
        } finally
        {
            db.close();
        }
        return j;
    }
}
