package tea.entity.site;

import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;

public class TypeAlias extends Entity
{
    private static Cache _cache = new Cache(100);
    private Hashtable _htLayer;
    public int typealias; //>65535
    public int type;
    private boolean exists;
    class Layer
    {
        public String _strName;
        public String _strPicture;
        public String _strAlt;
        private boolean _bLayerExisted;

        Layer()
        {
        }
    }


    public static TypeAlias find(int i) throws SQLException
    {
        TypeAlias obj = (TypeAlias) _cache.get(new Integer(i));
        if(obj == null)
        {
            obj = new TypeAlias(i);
            _cache.put(new Integer(i),obj);
        }
        return obj;
    }

    private TypeAlias(int i) throws SQLException
    {
        typealias = i;
        _htLayer = new Hashtable();
        load();
    }

    public void set() throws SQLException
    {
        String sql;
        if(typealias < 1)
            sql = "INSERT INTO TypeAlias(typealias,type)VALUES(" + (typealias = Seq.get()) + "," + type + ")";
        else
            sql = "UPDATE TypeAlias SET type=" + type + " WHERE typealias=" + typealias;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(typealias,sql);
        } finally
        {
            db.close();
        }
    }

    public void setLayer(int _nLanguage,String name,String picture,String alt) throws SQLException
    {
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE TypeAliasLayer SET name=").append(DbAdapter.cite(name));
        sql.append(",alt=").append(DbAdapter.cite(alt));
        if(picture != null)
        {
            sql.append(",picture=").append(DbAdapter.cite(picture));
        }
        sql.append(" WHERE typealias=").append(typealias).append(" AND language=").append(_nLanguage);
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate(typealias,sql.toString());
            if(j < 1)
            {
                db.executeUpdate(typealias,"INSERT INTO TypeAliasLayer(typealias, language, name, picture, alt)VALUES(" + typealias + "," + _nLanguage + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(picture) + "," + DbAdapter.cite(alt) + ")");
            }
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT type  FROM TypeAlias  WHERE typealias=" + typealias);
            if(db.next())
            {
                type = db.getInt(1);
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

    public static Enumeration findByType(int i) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT typealias FROM TypeAlias WHERE type=" + i);
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

    public int getType()
    {
        return type;
    }

    public String getName(int i) throws SQLException
    {
        return getLayer(i)._strName;
    }

    private Layer getLayer(int i) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(new Integer(i));
        if(layer == null)
        {
            layer = new Layer();
            int j = getLanguage(i);
            layer._bLayerExisted = (j == i);
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery(" SELECT name,picture,alt  FROM TypeAliasLayer WHERE typealias=" + typealias + " AND language=" + j);
                if(db.next())
                {
                    layer._strName = db.getVarchar(j,i,1);
                    layer._strPicture = db.getString(2);
                    layer._strAlt = db.getVarchar(j,i,3);
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
            db.executeQuery("SELECT language FROM TypeAliasLayer WHERE typealias=" + typealias);
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
            if(v.size() == 0)
            {
                return 0;
            }
        }
        return((Integer) v.elementAt(0)).intValue();
    }

    public static int count() throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            i = db.getInt("SELECT COUNT(typealias)  FROM TypeAlias ");
        } finally
        {
            db.close();
        }
        return i;
    }


    public static Enumeration find() throws SQLException
    {
        return find(0,Integer.MAX_VALUE);
    }

    public static Enumeration find(int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT typealias FROM TypeAlias",pos,size);
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

    public void delete(int i) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(typealias,"DELETE FROM TypeAliasLayer WHERE typealias=" + typealias + " AND language=" + i);
            db.executeQuery("SELECT typealias  FROM TypeAliasLayer WHERE typealias=" + typealias);
            if(!db.next())
            {
                db.executeUpdate(typealias,"DELETE FROM TypeAlias WHERE typealias=" + typealias);
            }
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(typealias));
    }

    public String getAlt(int i) throws SQLException
    {
        return getLayer(i)._strAlt;
    }

    public boolean isLayerExisted(int i) throws SQLException
    {
        return getLayer(i)._bLayerExisted;
    }

    public String getPicture(int i) throws SQLException
    {
        return getLayer(i)._strPicture;
    }

    public boolean isExists()
    {
        return exists;
    }
}
