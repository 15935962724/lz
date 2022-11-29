package tea.entity.admin;

import tea.db.*;
import java.sql.SQLException;
import tea.html.Anchor;
import tea.html.Text;
import java.sql.SQLException;
import tea.entity.*;

public class Area
{
    private static Cache _cache = new Cache(100);
    private int id;
    private int father;
    private int sequence;
    private String community;
    private boolean exists;
    private String name;


    public Area(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static Area find(int id) throws SQLException
    {
        Area obj = (Area) _cache.get(new Integer(id));
        if (obj == null)
        {
            obj = new Area(id);
            if (obj.exists)
            {
                _cache.put(new Integer(id), obj);
            }
        }
        return obj;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from Area where id=" + (id));
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
    }

    public void set(int father, int sequence, String name, String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if (exists)
            {
                db.executeUpdate("UPDATE Area SET father =" + (father) + ", sequence=" + (sequence) + ",name=" + DbAdapter.cite(name) + ",community=" + DbAdapter.cite(community) + " WHERE id=" + (id));
                _cache.remove(new Integer(id));
            } else
            {
                create(father, sequence, name, community);
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(int father, int sequence, String name, String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("insert into Area(father,sequence,name,community) values (" + (father) + "," + (sequence) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(community) + ")");
        } finally
        {
            db.close();
        }
    }

    public static void clone(int aimId, int sourceId, String community, boolean son) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int newId = 0;
        try
        {
            db.executeUpdate("INSERT INTO Area(father   ,sequence ,community,name)SELECT " + aimId + "   ,sequence ," + DbAdapter.cite(community) + ",name FROM Area WHERE id=" + sourceId);
            newId = db.getInt("SELECT MAX(id) FROM Area");
        } finally
        {
            db.close();
        }
        if (son)
        {
            java.util.Enumeration enumer = Area.findByFather(sourceId);
            while (enumer.hasMoreElements())
            {
                clone(newId, ((Integer) enumer.nextElement()).intValue(), community, true);
            }
        }
    }

    public static int getRootId(String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            return db.getInt("SELECT id FROM Area WHERE community=" + DbAdapter.cite(community) + " AND father=0");
        } finally
        {
            db.close();
        }
    }

    public String getAncestor() throws SQLException, SQLException
    {
        if (id == Area.getRootId(this.getCommunity()))
        {
            return "";
        } else
        {
            return find(getFather()).getAncestor() + ">" + getName();
        }
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT father,sequence,community,name FROM Area WHERE id=" + (id));
            if (db.next())
            {
                father = db.getInt(1);
                sequence = db.getInt(2);
                community = db.getString(3);
                name = db.getVarchar(1, 1, 4);
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public static java.util.Enumeration findByCommunity(String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        java.util.Vector vector = new java.util.Vector();
        try
        {
            db.executeQuery("SELECT id FROM Area WHERE community=" + DbAdapter.cite(community));
            while (db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static java.util.Enumeration findByFather(int father) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        java.util.Vector vector = new java.util.Vector();
        try
        {
            db.executeQuery("SELECT id FROM Area WHERE father=" + father + " ORDER BY sequence");
            while (db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public int getId()
    {
        return id;
    }

    public int getFather()
    {
        return father;
    }

    public int getSequence()
    {
        return sequence;
    }

    public String getCommunity()
    {
        return community;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getName()
    {
        return name;
    }
}
