package tea.entity.member;

import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;

public class CGroup extends Entity
{
    private static Cache _cache = new Cache(100);
    public static final int CGROUPT_PRIVATE = 0; //私人信箱
    public static final int CGROUPT_PROTECTEDI = 1; //保护级I(订阅者仅可阅读信箱中信件)
    public static final int CGROUPT_PROTECTEDII = 2; //保护级II(订阅者可以往信箱中发表信件)
    public static final int CGROUPT_PUBLIC = 3; //公开级(订阅者可以在信箱中发表及删除信件)
    private int cgroup;
    private String member;
    private int type;
    private int sequence;
    private boolean exists;
    private Hashtable _htLayer;
    class Layer
    {
        public String name;
    }


    public void setSequence(int sequence) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE CGroup SET sequence=" + sequence + " WHERE cgroup=" + cgroup);
        } finally
        {
            db.close();
        }
        this.sequence = sequence;
    }

    public void set(int language,String name) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE CGroupLayer SET name=" + DbAdapter.cite(name) + " WHERE cgroup=" + cgroup + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    private CGroup(int cgroup) throws SQLException
    {
        this.cgroup = cgroup;
        _htLayer = new Hashtable();
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT member,type,sequence FROM CGroup WHERE cgroup=" + cgroup);
            if(db.next())
            {
                member = db.getString(1);
                type = db.getInt(2);
                sequence = db.getInt(3);
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

    public static int create(String member,int language,String name) throws SQLException
    {
        int id = 0;
        long lo = System.currentTimeMillis() / 1000L;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO CGroup(member,sequence)VALUES(" + DbAdapter.cite(member) + "," + lo + ")");
            id = db.getInt("SELECT MAX(cgroup) FROM CGroup");
            db.executeUpdate("INSERT INTO CGroupLayer(cgroup,language,name)VALUES(" + id + "," + language + "," + DbAdapter.cite(name) + ")");
        } finally
        {
            db.close();
        }
        return id;
    }

    public String getName(int i) throws SQLException
    {
        return getLayer(i).name;
    }

    private Layer getLayer(int i) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(new Integer(i));
        if(layer == null)
        {
            layer = new Layer();
            int j = this.getLanguage(i);
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT name FROM CGroupLayer WHERE cgroup=" + cgroup + " AND language=" + j);
                if(db.next())
                {
                    layer.name = db.getVarchar(j,i,1);
                }
            } finally
            {
                db.close();
            }
            _htLayer.put(new Integer(i),layer);
        }
        return layer;
    }

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language FROM CGroupLayer WHERE cgroup= " + cgroup);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        if(v.indexOf(new Integer(language)) != -1)
        {
            return language;
        } else
        {
            if(language == 1)
            {
                if(v.indexOf(new Integer(2)) != -1)
                {
                    return 2;
                }
            } else if(language == 2)
            {
                if(v.indexOf(new Integer(1)) != -1)
                {
                    return 1;
                }
            }
            if(v.size() < 1)
            {
                return 0;
            }
        }
        return((Integer) v.elementAt(0)).intValue();
    }

    public void delete(int i) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM CGroupLayer WHERE cgroup=" + cgroup + "  AND language=" + i);
            db.executeQuery("SELECT cgroup FROM CGroupLayer WHERE cgroup=" + cgroup);
            if(!db.next())
            {
                db.executeUpdate("DELETE FROM CGroup WHERE cgroup=" + cgroup);
                db.executeUpdate("DELETE FROM Contact WHERE cgroup=" + cgroup);
            }
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(cgroup));
    }

    public static CGroup find(int cgroup) throws SQLException
    {
        CGroup obj = (CGroup) _cache.get(new Integer(cgroup));
        if(obj == null)
        {
            obj = new CGroup(cgroup);
            _cache.put(new Integer(cgroup),obj);
        }
        return obj;
    }

    public static int count(String member,String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(cgroup) FROM CGroup WHERE member=" + DbAdapter.cite(member) + sql);
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

    public static Enumeration find(String member,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT cgroup FROM CGroup WHERE member=" + DbAdapter.cite(member) + sql + " ORDER BY sequence",pos,size);
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

    public int getType()
    {
        return type;
    }

    public int getSequence()
    {
        return sequence;
    }

    public String getMember()
    {
        return member;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getCgroup()
    {
        return cgroup;
    }

    public static boolean isUseAsMyOwnCGroup(int cgroup,String member) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT member FROM CGroupLayerx WHERE cgroup=" + cgroup + " AND member=" + DbAdapter.cite(member));
            if(db.next())
            {
                flag = true;
            }
        } finally
        {
            db.close();
        }
        return flag;
    }

    public static void setUseAsMyOwnCGroup(int cgroup,String member) throws SQLException
    {
        if(!isUseAsMyOwnCGroup(cgroup,member))
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeUpdate("INSERT CGroupLayerx(cgroup,member) VALUES (" + cgroup + ",  " + DbAdapter.cite(member) + ")");
            } finally
            {
                db.close();
            }
        }
    }

    public static void deleteUseAsMyOwnCGroup(int cgroup,String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM CGroupLayerx WHERE cgroup=" + cgroup + " AND member=" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
    }

    public static void deleteCGroupLayerx(int cgroup) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM CGroupLayerx WHERE cgroup=" + cgroup);
        } finally
        {
            db.close();
        }
    }

    public static Enumeration findCGroupLayerx(String member) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT cgroup FROM CGroupLayerx WHERE member=" + DbAdapter.cite(member));
            while(db.next())
            {
                int id = db.getInt(1);
                CGroup cg = CGroup.find(id);
                if(cg.getType() != 0)
                {
                    v.addElement(new Integer(id));
                }
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Enumeration findCGroupLayerxII(String member) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT cgroup FROM CGroupLayerx WHERE member=" + DbAdapter.cite(member));
            while(db.next())
            {
                int id = db.getInt(1);
                CGroup cg = CGroup.find(id);
                int i = cg.getType();
                if(i != 0 && i != 1)
                {
                    v.addElement(new Integer(id));
                }
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }
}
