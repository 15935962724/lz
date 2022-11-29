package tea.entity.csvclub;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class Csvdoghousemenu extends Entity
{
    private static Cache _cache = new Cache(100);

    private boolean exists;
    private String community;
    private String subject;
    private int node;
    private int sequence;
    private int doghousemenu;
    public Csvdoghousemenu(int doghousemenu) throws SQLException
    {
        this.doghousemenu = doghousemenu;
        loadBasic();
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT community,node,subject,sequence FROM Csvdoghousemenu WHERE doghousemenu=" + doghousemenu);
            if (dbadapter.next())
            {
                community = dbadapter.getString(1);
                node = dbadapter.getInt(2);
                subject = dbadapter.getString(3);
                sequence = dbadapter.getInt(4);
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            dbadapter.close();
        }
    }

    public void delete() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("DELETE Csvdoghousemenu WHERE doghousemenu=" + doghousemenu);
        } finally
        {
            dbadapter.close();
        }
        _cache.remove(new Integer(node));
    }

    public static void create(String community, int node, String subject) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("INSERT INTO Csvdoghousemenu(community,node,subject,sequence) VALUES(" +
                                    dbadapter.cite(community) + "," + node + "," + dbadapter.cite(subject) + "," + System.currentTimeMillis() / 1000 + ")");
        } finally
        {
            dbadapter.close();
        }
        _cache.remove(new Integer(node));
    }

    public void set(int node, String subject) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("UPDATE Csvdoghousemenu SET node=" + node + ",subject=" + dbadapter.cite(subject) + " WHERE doghousemenu=" + doghousemenu);
        } finally
        {
            dbadapter.close();
        }
        this.node = node;
        this.subject = subject;
    }

    public static java.util.Enumeration findCommunity(String community) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT doghousemenu FROM Csvdoghousemenu WHERE community=" + dbadapter.cite(community) + " ORDER BY sequence");
            while (dbadapter.next())
            {
                vector.addElement(new Integer(dbadapter.getInt(1)));
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    public static Csvdoghousemenu find(int doghousemenu) throws SQLException
    {
        Csvdoghousemenu obj = (Csvdoghousemenu) _cache.get(new Integer(doghousemenu));
        if (obj == null)
        {
            obj = new Csvdoghousemenu(doghousemenu);
            _cache.put(new Integer(doghousemenu), obj);
        }
        return obj;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getCommunity()
    {
        return community;
    }

    public int getDoghousemenu()
    {
        return doghousemenu;
    }

    public String getSubject()
    {
        return subject;
    }

    public int getNode()
    {
        return node;
    }

    public static int count(String community, String sql) throws SQLException
    {
        int j = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT COUNT(community) FROM Csvdoghousemenu WHERE community=" + DbAdapter.cite(community) + sql);
            if (dbadapter.next())
            {
                j = dbadapter.getInt(1);
            }
        } finally
        {
            dbadapter.close();
        }
        return j;
    }

    public void move(boolean isUp) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        DbAdapter db2 = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT doghousemenu FROM Csvdoghousemenu WHERE community=" + dbadapter.cite(community) + " ORDER BY sequence");
            for (int i = 10; dbadapter.next(); i += 10)
            {
                int doghousemenu = dbadapter.getInt(1);
                int sequence = i;
                if (doghousemenu == this.doghousemenu)
                {
                    sequence = isUp ? sequence - 15 : sequence + 15;
                }
                db2.executeUpdate("UPDATE Csvdoghousemenu SET sequence=" + sequence + " WHERE doghousemenu=" + doghousemenu);
            }
        } finally
        {
            dbadapter.close();
            db2.close();
        }
    }
}
