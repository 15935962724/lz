package tea.entity.member;

import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class MessageFolder extends Entity
{
    private static Cache _cache = new Cache(100);
    public static final int MESSAGEFOLDERT_PRIVATE = 0;
    public static final int MESSAGEFOLDERT_PROTECTEDI = 1;
    public static final int MESSAGEFOLDERT_PROTECTEDII = 2;
    public static final int MESSAGEFOLDERT_PUBLIC = 3;
    public static final int O_OPENSUBSCRIBERLIST = 1;
    private int messagefolder;
    private String member;
    private int type;
    private int options;
    private Hashtable _htLayer;

    class Layer
    {
        public String _strName;
        public boolean existed;

        Layer()
        {
        }
    }


    private MessageFolder(int messagefolder) throws SQLException
    {
        this.messagefolder = messagefolder;
        _htLayer = new Hashtable();
        load();
    }

    public static void create(String member, int type, int options, int language, String name) throws SQLException
    {
        int id = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO MessageFolder(member, type,options)VALUES (" + DbAdapter.cite(member) + ", " + type + "," + options + ")");
            id = db.getInt("SELECT MAX(messagefolder) FROM MessageFolder");
            db.executeUpdate("INSERT INTO MessageFolderLayer(messagefolder,language, name) VALUES (" + id + "," + language + ", " + DbAdapter.cite(name) + ")");
        } finally
        {
            db.close();
        }
    }

    public boolean isLayerExisted(int i) throws SQLException
    {
        return getLayer(i).existed;
    }

    public String getName(int i) throws SQLException
    {
        return getLayer(i)._strName;
    }

    private Layer getLayer(int i) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(new Integer(i));
        if (layer == null)
        {
            layer = new Layer();
            int j = this.getLanguage(i);
            layer.existed = j == i;
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT name FROM MessageFolderLayer WHERE messagefolder=" + messagefolder + " AND language=" + j);
                if (db.next())
                {
                    layer._strName = db.getVarchar(j, i, 1);
                }
            } finally
            {
                db.close();
            }
            _htLayer.put(new Integer(i), layer);
        }
        return layer;
    }

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language FROM MessageFolderLayer WHERE messagefolder=" + messagefolder);
            while (db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        if (v.indexOf(new Integer(language)) != -1)
        {
            return language;
        } else
        {
            if (language == 1)
            {
                if (v.indexOf(new Integer(2)) != -1)
                {
                    return 2;
                }
            } else if (language == 2)
            {
                if (v.indexOf(new Integer(1)) != -1)
                {
                    return 1;
                }
            }
            if (v.size() < 1)
            {
                return 0;
            }
        }
        return ((Integer) v.elementAt(0)).intValue();
    }

    public void delete(int i) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM MessageFolderLayer WHERE messagefolder=" + messagefolder);
            db.executeQuery("SELECT messagefolder FROM MessageFolderLayer WHERE messagefolder=" + messagefolder);
            if (!db.next())
            {
                db.executeUpdate("DELETE FROM MessageFolder WHERE messagefolder=" + messagefolder);
            }
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(messagefolder));
    }

    public static MessageFolder find(int messagefolder) throws SQLException
    {
        MessageFolder obj = (MessageFolder) _cache.get(new Integer(messagefolder));
        if (obj == null)
        {
            obj = new MessageFolder(messagefolder);
            _cache.put(new Integer(messagefolder), obj);
        }
        return obj;
    }

    public static Enumeration find(String member) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT messagefolder FROM MessageFolder WHERE member=" + Profile.find(DbAdapter.cite(member)).getProfile());
            while (db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Enumeration findName(String s) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT name FROM MessageFolderLayer WHERE member=" + DbAdapter.cite(s));
            for (; db.next(); vector.addElement(db.getString(1)))
            {
                ;
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT member,type,options FROM MessageFolder WHERE messagefolder=" + messagefolder);
            if (db.next())
            {
                member = db.getString(1);
                type = db.getInt(2);
                options = db.getInt(3);
            }
        } finally
        {
            db.close();
        }
    }

    public String getMember()
    {
        return member;
    }

    public void set(int type, int options, int language, String name) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE MessageFolder SET type=" + type + ", options=" + options + " WHERE messagefolder=" + messagefolder);
            int j = db.executeUpdate("UPDATE MessageFolderLayer SET name=" + DbAdapter.cite(name) + " WHERE messagefolder=" + messagefolder + "   AND language=" + language);
            if (j < 0)
            {
                db.executeUpdate("INSERT INTO MessageFolderLayer(messagefolder, language, name)  VALUES (" + messagefolder + ", " + language + ", " + DbAdapter.cite(name) + ")");
            }
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public int getType()
    {
        return type;
    }

    public int getOptions()
    {
        return options;
    }

    public static boolean isUseAsMyOwnMessageFolder(String s, String s1) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT member FROM MessageFolderLayerx WHERE messagefolder=" + DbAdapter.cite(s1) + " AND " + " member=" + DbAdapter.cite(s));
            if (db.next())
            {
                flag = true;
            }
        } catch (Exception exception)
        {
        } finally
        {
            db.close();
        }
        return flag;
    }

    public static void setUseAsMyOwnMessageFolder(String s, String s1) throws SQLException
    {
        if (!isUseAsMyOwnMessageFolder(s, s1))
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeUpdate("INSERT MessageFolderLayerx (member, messagefolder) VALUES (" + DbAdapter.cite(s) + ", " + DbAdapter.cite(s1) + ")");
            } catch (Exception exception)
            {
            } finally
            {
                db.close();
            }
        }
    }

    public static void deleteUseAsMyOwnMessageFolder(String s, String s1) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE MessageFolderLayerx WHERE member=" + DbAdapter.cite(s) + " AND messagefolder=" + DbAdapter.cite(s1));
        } catch (Exception exception)
        {
        } finally
        {
            db.close();
        }
    }

    public static void deleteMessageFolderLayerx(int messagefolder) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE MessageFolderLayerx WHERE messagefolder=" + messagefolder);
        } finally
        {
            db.close();
        }
    }

    public static Enumeration findMessageFolderLayerx(String s) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT messagefolder FROM MessageFolderLayerx  WHERE member=" + DbAdapter.cite(s));
            for (; db.next(); vector.addElement(db.getString(1)))
            {
                ;
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static int count(String s) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            i = db.getInt("SELECT COUNT(messagefolder) FROM MessageFolderLayerx  WHERE messagefolder=" + DbAdapter.cite(s));
        } finally
        {
            db.close();
        }
        return i;
    }

    public static Enumeration findSubscribers(String s, int i, int j) throws SQLException
    {
        Vector vector = new Vector();
        String s1 = "";
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT member FROM MessageFolderLayerx  WHERE messagefolder=" + DbAdapter.cite(s) + " ORDER BY member ");
            for (int k = 0; k < i + j && db.next(); k++)
            {
                if (k >= i)
                {
                    String s2 = db.getString(1);
                    vector.addElement(new RV(s2, s2));
                }
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static void deleteSubscriber(String s, String s1) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM MessageFolderLayerx  WHERE messagefolder=" + DbAdapter.cite(s) + " AND member=" + DbAdapter.cite(s1));
        } finally
        {
            db.close();
        }
    }

}
