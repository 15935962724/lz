package tea.entity.site;

import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.*;
import tea.entity.admin.*;

public class Help extends Entity
{
    private static Cache _cache = new Cache(100);
    public static final String HELP_TYPE[] =
            {"动态桌面"};
    private Hashtable _htLayer;
    public int help;
    public String community;
    public int type;
    public int id; // 菜单id
    public int hits;

    class Layer
    {
        Layer()
        {
        }

        public String subject;
        public String keywords;
        public String content;
    }


    public Help(int help) throws SQLException
    {
        this.help = help;
        _htLayer = new Hashtable();
        load();
    }

    public static Help find(int help) throws SQLException
    {
        Help obj = (Help) _cache.get(new Integer(help));
        if(obj == null)
        {
            obj = new Help(help);
            _cache.put(new Integer(help),obj);
        }
        return obj;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(help,"DELETE FROM Help WHERE help=" + help);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(help));
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,type,id,hits FROM Help WHERE help=" + help);
            if(db.next())
            {
                community = db.getString(1);
                type = db.getInt(2);
                id = db.getInt(3);
                hits = db.getInt(4);
            }
        } finally
        {
            db.close();
        }
    }

    public static Enumeration findByCommunity(String community,String sql,int pos,int size) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT help FROM Help WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
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

    public static int countByCommunity(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM Help WHERE community=" + DbAdapter.cite(community) + sql);
            if(db.next())
            {
                count = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return count;
    }

    public void set(int type,int id,int language,String subject,String keywords,String content) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(help,"UPDATE Help SET type=" + type + ",id=" + id + " WHERE help=" + help);
            db.executeQuery("SELECT help FROM HelpLayer WHERE help=" + help + " AND language=" + language);
            if(db.next())
            {
                db.executeUpdate(help,"UPDATE HelpLayer SET subject=" + DbAdapter.cite(subject) + ",keywords=" + DbAdapter.cite(keywords) + ",content=" + DbAdapter.cite(content) + " WHERE help=" + help + " AND language=" + language);
            } else
            {
                db.executeUpdate(help,"INSERT INTO HelpLayer(help,language,subject,keywords,content)VALUES(" + help + "," + language + "," + DbAdapter.cite(subject) + "," + DbAdapter.cite(keywords) + "," + DbAdapter.cite(content) + ")");
            }
        } finally
        {
            db.close();
        }
        this.type = type;
        this.id = id;
        _htLayer.clear();
    }

    public static int create(String community,int type,int id,int language,String subject,String keywords,String content) throws SQLException
    {
        int help;
        String sql = "INSERT INTO Help(help,community,type,id,hits)VALUES(" + (help = Seq.get()) + "," + DbAdapter.cite(community) + "," + type + "," + id + ",0)";
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(help,sql);
            db.executeUpdate(help,"INSERT INTO HelpLayer(help,language,subject,keywords,content)VALUES(" + help + "," + language + "," + DbAdapter.cite(subject) + "," + DbAdapter.cite(keywords) + "," + DbAdapter.cite(content) + ")");
        } finally
        {
            db.close();
        }
        return help;
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(help,"UPDATE Help SET " + f + "=" + DbAdapter.cite(v) + " WHERE help=" + help);
        } finally
        {
            db.close();
        }
        _cache.remove(help);
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
                db.executeQuery("SELECT subject,keywords,content FROM HelpLayer WHERE help=" + help + " AND language=" + j);
                if(db.next())
                {
                    layer.subject = db.getVarchar(j,i,1);
                    layer.keywords = db.getVarchar(j,i,2);
                    layer.content = db.getVarchar(j,i,3);
                } else if(help == 0)
                {
                    layer.subject = "暂无帮助";
                    layer.content = "没到找到相关的帮助...";
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
            db.executeQuery("SELECT language FROM HelpLayer WHERE help=" + help);
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

    public int clone(int function,String community) throws SQLException
    {
        int newid = 0;
        String sql = "INSERT INTO Help(help,community,type,id,hits)VALUES(" + (newid = Seq.get()) + "," + DbAdapter.cite(community) + "," + type + "," + function + "," + hits + ")";
        DbAdapter db = new DbAdapter();
        DbAdapter db2 = new DbAdapter();
        try
        {
            db.executeUpdate(newid,sql);
            db.executeQuery("SELECT language FROM HelpLayer WHERE help=" + help);
            while(db.next())
            {
                int language = db.getInt(1);
                db2.executeUpdate(newid,"INSERT INTO HelpLayer(help,language,subject,keywords,content)VALUES(" + newid + "," + language + "," + DbAdapter.cite(getSubject(language)) + "," + DbAdapter.cite(getKeywords(language)) + "," + DbAdapter.cite(getContent(language)) + ")");
            }
        } finally
        {
            db.close();
            db2.close();
        }
        return newid;
    }

    public String getCommunity()
    {
        return community;
    }

    public int getHelp()
    {
        return help;
    }

    public int getHits()
    {
        return hits;
    }

    public int getId()
    {
        return id;
    }

    public int getType()
    {
        return type;
    }

    public String getSubject(int language) throws SQLException
    {
        return getLayer(language).subject;
    }

    public String getKeywords(int language) throws SQLException
    {
        return getLayer(language).keywords;
    }

    public String getContent(int language) throws SQLException
    {
        return getLayer(language).content;
    }
}
