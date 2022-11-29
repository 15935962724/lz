package tea.entity.site;

import tea.db.DbAdapter;
import tea.entity.Cache;
import java.sql.SQLException;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */
public class Template3
{
    private static Cache _cache = new Cache(100);
    private String name;
    private boolean exists;
    private int node;

    public Template3(int node) throws SQLException
    {
        this.node = node;
        loadBasic();
    }

    public static Template3 find(int node) throws SQLException
    {
        Template3 obj = (Template3) _cache.get(new Integer(node));
        if(obj == null)
        {
            obj = new Template3(node);
            _cache.put(new Integer(node),obj);
        }
        return obj;
    }

    public void set(String name) throws SQLException
    {
        if(exists)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeUpdate("UPDATE Template3 SET name=" + DbAdapter.cite(name) + " WHERE node=" + node);
            } finally
            {
                db.close();
            }
            _cache.remove(new Integer(node));
        } else
        {
            create(node,name);
        }
    }

    public static int create(int node,String name) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Template3(node,name)VALUES(" + node + "," + DbAdapter.cite(name) + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(node));
        return node;
    }


    public static java.util.Enumeration find() throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT t.node FROM Template3 t,Node n WHERE n.node=t.node");
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


    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE Template3 WHERE node=" + node);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(node));
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT name FROM Template3 WHERE node=" + node);
            if(db.next())
            {
                name = db.getVarchar(1,1,1);
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


    public String getName()
    {
        return name;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getNode()
    {
        return node;
    }
}
