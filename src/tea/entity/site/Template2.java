package tea.entity.site;

import tea.db.DbAdapter;
import tea.entity.Cache;
import java.sql.SQLException;
import java.sql.SQLException;

/**
 * <p>
 * Title:
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2005
 * </p>
 * <p>
 * Company:
 * </p>
 *
 * @author not attributable
 * @version 1.0
 */
public class Template2
{
    private static Cache _cache = new Cache(100);
    private int id;
    private String community;
    private String name;
    private String picture;
    private boolean exists;
    private int node;
    private int css;

    public Template2(int id) throws SQLException
    {
        this.id = id;
        loadBasic();
    }

    public static Template2 find(int id) throws SQLException
    {
        Template2 obj = (Template2) _cache.get(new Integer(id));
        if(obj == null)
        {
            obj = new Template2(id);
            _cache.put(new Integer(id),obj);
        }
        return obj;
    }

    public void set(String community,int node,String name,int css,String picture) throws SQLException
    {
        if(this.isExists())
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeUpdate("UPDATE Template2 SET community=" + DbAdapter.cite(community) + ",node=" + (node) + ",name=" + DbAdapter.cite(name) + ",css=" + (css) + ",picture=" + DbAdapter.cite(picture) + " WHERE id=" + id);
            } finally
            {
                db.close();
            }
            _cache.remove(new Integer(id));
        } else
        {
            create(community,node,name,css,picture);
        }
    }

    public int create(String community,int node,String name,int css,String picture) throws SQLException
    {
        int id = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Template2(community,node,	name,css,	picture)VALUES( " + DbAdapter.cite(community) + "," + node + "," + DbAdapter.cite(name) + "," + css + "," + DbAdapter.cite(picture) + ")");
            id = db.getInt("SELECT MAX(id) FROM Template2");
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
        return id;
    }

    public static Template2 find(String community,int node) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            return find(db.getInt("SELECT id FROM  Template2 WHERE community=" + DbAdapter.cite(community) + " AND node=" + node));
        } finally
        {
            db.close();
        }
    }

    public static java.util.Enumeration find() throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM Template2 t,Node n WHERE n.node=t.node");
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

    public static java.util.Enumeration findByCommunity(String community) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM Template2 WHERE community=" + DbAdapter.cite(community));
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
            db.executeUpdate("DELETE Template2 WHERE id=" + id);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,node,name,css,picture FROM Template2 WHERE id= " + id);
            if(db.next())
            {
                community = db.getString(1);
                node = db.getInt(2);
                name = db.getVarchar(1,1,3);
                css = db.getInt(4);
                picture = db.getString(5);
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

    public int getId()
    {
        return id;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getName()
    {
        return name;
    }

    public String getPicture()
    {
        return picture;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getNode()
    {
        return node;
    }

    public int getCss()
    {
        return css;
    }
}
