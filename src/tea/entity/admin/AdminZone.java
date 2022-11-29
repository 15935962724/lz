package tea.entity.admin;

import java.sql.SQLException;
import tea.db.*;
import java.sql.SQLException;

public class AdminZone
{
    private static tea.entity.Cache _cache = new tea.entity.Cache(100);
    private int id;
    private int father;
    private int sequence;
    private String community;
    private boolean exists;
    private String name;
    private String area;

    public AdminZone()
    {
    }

    public AdminZone(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static AdminZone find(int id) throws SQLException
    {
        AdminZone obj = (AdminZone) _cache.get(new Integer(id));
        if(obj == null)
        {
            obj = new AdminZone(id);
            if(obj.exists)
            {
                _cache.put(new Integer(id),obj);
            }
        }
        return obj;
    }

    public void delete() throws SQLException
    {
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        try
        {
            db.executeUpdate("delete from AdminZone where id=" + (id));
            _cache.remove(new Integer(id));
        } finally
        {
            db.close();
        }
    }

    public void set(int father,int sequence,String name,String community,String area) throws SQLException
    {
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        try
        {
            if(exists)
            {
                db.executeUpdate("UPDATE AdminZone SET " +
                                 "father   =" + (father) + "," +
                                 "sequence   =" + (sequence) + "," +
                                 "name   =" + DbAdapter.cite(name) + "," +
                                 "area   =" + DbAdapter.cite(area) + "," +
                                 "community   =" + DbAdapter.cite(community) +
                                 " WHERE id=" + (id)
                        );
                _cache.remove(new Integer(id));
            } else
            {
                create(father,sequence,name,community,area);
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(int father,int sequence,String name,String community,String area) throws SQLException
    {
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        try
        {
            db.executeUpdate("insert into AdminZone(father,sequence,name,community,area) values (" +
                             (father) + "," +
                             (sequence) + "," +
                             DbAdapter.cite(name) + "," +
                             DbAdapter.cite(community) + "," +
                             DbAdapter.cite(area) +
                             ")");
        } finally
        {
            db.close();
        }
    }

    public static int getRootId(String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            return db.getInt("SELECT id FROM AdminZone WHERE community=" + DbAdapter.cite(community) + " AND father=0");
        } finally
        {
            db.close();
        }
    }

    private void load() throws SQLException
    {
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        try
        {
            db.executeQuery("SELECT father,sequence,community,name,area FROM AdminZone WHERE id=" + (id));
            if(db.next())
            {
                father = db.getInt(1);
                sequence = db.getInt(2);
                community = db.getString(3);
                name = db.getVarchar(1,1,4);
                area = db.getString(5);
                this.exists = true;
            } else
            {
                this.exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public static java.util.Enumeration findByCommunity(String community) throws SQLException
    {
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        java.util.Vector vector = new java.util.Vector();
        try
        {
            db.executeQuery("SELECT id FROM AdminZone WHERE community=" + DbAdapter.cite(community));
            while(db.next())
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
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        java.util.Vector vector = new java.util.Vector();
        try
        {
            db.executeQuery("SELECT id FROM AdminZone WHERE father=" + father);
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static java.util.Enumeration findByArea(int area) throws SQLException
    {
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        java.util.Vector vector = new java.util.Vector();
        try
        {
            db.executeQuery("SELECT id FROM AdminZone WHERE area like '%/" + area + "/%'");
            while(db.next())
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

    public String getArea()
    {
        return area;
    }
}
