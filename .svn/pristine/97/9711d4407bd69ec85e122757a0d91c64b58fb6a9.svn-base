package tea.entity.node;

import java.util.*;
import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class Classes extends Entity
{
    private static Cache _cache = new Cache(100);
    private int class_id;
    private String community;
    private int language;
    private String name;
	private int type;
    private boolean exists;

    public void setCommunity(String community)
    {
        this.community = community;
    }

    public void setLanguage(int language)
    {
        this.language = language;
    }
    public boolean exists()
    {
        return exists;
    }

    public void set(String community,int language,String name,int type) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("UPDATE Class SET name=" + DbAdapter.cite(name) + ",language=" + language + ",type="+type+" WHERE class_id=" + class_id);
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO Class(language,name,community,type) VALUES (" + language + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(community) + ","+type+")");
            }
        } finally
        {
            db.close();
        }
        _cache.remove(class_id);
        _cache.remove(community + ":" + language);
    }

    public Classes(int class_id) throws SQLException
    {
        this.class_id = class_id;
        load();
    }

    public String getName() throws SQLException
    {
        return this.name;
    }

    public String getCommunity()
    {
        return community;
    }

    public int getLanguage()
    {
        return language;
    }

    public int getId()
    {
        return class_id;
    }
	public int getType()
	{
		return type;
	}

    public static Classes find(int class_id) throws SQLException
    {
        Classes obj = (Classes) _cache.get(class_id);
        if(obj == null)
        {
            obj = new Classes(class_id);
            _cache.put(class_id,obj);
        }
        return obj;
    }

    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT class_id FROM Class WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                v.add(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static int count(String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM Class WHERE 1=1" + sql);
            if(db.next())
            {
                j = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return j;
    }

    public static Enumeration findByCommunity(String community,int language) throws SQLException
    {
        Vector v = (Vector) _cache.get(community + ":" + language);
        if(v == null)
        {
            v = new Vector();
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT class_id FROM Class WHERE community=" + db.cite(community) + " AND language=" + language + " ORDER BY name");
                while(db.next())
                {
                    v.addElement(db.getInt(1));
                }
            } finally
            {
                db.close();
            }
            _cache.put(community + ":" + language,v);
        }
        return v.elements();
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Class WHERE class_id=" + class_id);
            db.executeUpdate("DELETE FROM ClassesChild WHERE class_id=" + class_id);
        } finally
        {
            db.close();
        }
        _cache.remove(class_id);
        _cache.remove(community + ":" + language);
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language,name,community,type FROM Class WHERE class_id=" + class_id);
            if(db.next())
            {
                language = db.getInt(1);
                name = db.getVarchar(language,language,2);
                community = db.getVarchar(language,language,3);
				type=db.getInt(4);
                exists = true;
            } else
            {
                exists = false;
                community = name = "";
            }
        } finally
        {
            db.close();
        }
    }
}
