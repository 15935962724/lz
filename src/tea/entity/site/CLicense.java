package tea.entity.site;

import java.io.*;
import tea.entity.node.*;
import tea.db.*;
import tea.entity.*;
import tea.resource.*;
import java.sql.SQLException;

public class CLicense extends Entity implements Serializable
{
    private static Cache _cache = new Cache(100);
    public static final int UNDONE_TYPE[] =
            {4,5,6,7,9,10,16,17,18,19,20,22,23,24,25,26,27,33,35,36,38,43,46,47,63,67};
    public static final String DEFAUT_TYPE;
    static
    {
        StringBuilder sb = new StringBuilder("/");
        for(int index = 2;index < Node.NODE_TYPE.length;index++)
        {
            point:
                    {
                for(int i = 0;i < UNDONE_TYPE.length;i++)
                {
                    if(index == UNDONE_TYPE[i])
                    {
                        break point;
                    }
                }
                sb.append(index).append("/");
            }
        }
        DEFAUT_TYPE = sb.toString();
    }

    private String community;
    private boolean exists;
    private String type;

    public CLicense(String community) throws SQLException
    {
        this.community = community;
        load();
    }

    public static CLicense find(String community) throws SQLException
    {
        CLicense obj = (CLicense) _cache.get(community);
        if(obj == null)
        {
            obj = new CLicense(community);
            _cache.put(community,obj);
        }
        return obj;
    }


    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT type FROM CLicense WHERE community=" + DbAdapter.cite(community));
            if(db.next())
            {
                type = db.getString(1);
                exists = true;
            } else
            {
                type = DEFAUT_TYPE;
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(String community,String type) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO CLicense(community,type)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(type) + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(community);
    }

    public void set(String type) throws SQLException
    {
        if(exists)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeUpdate("UPDATE CLicense SET type=" + DbAdapter.cite(type) + " WHERE community=" + DbAdapter.cite(community));
            } finally
            {
                db.close();
            }
            this.type = type;
        } else
        {
            create(community,type);
        }
    }

    public void add(int t) throws SQLException
    {
        set(type + t + "/");
    }

    public static String getName(int type,int lang) throws SQLException
    {
        String tname;
        if(type > 65535)
        {
            tname = TypeAlias.find(type).getName(lang);
        } else if(type > 1023)
        {
            tname = Dynamic.find(type).getName(lang);
        } else
        {
            Resource r = new Resource();
            tname = r.getString(lang,type == 255 ? "AllTypes" : Node.NODE_TYPE[type]);
        }
        return tname;
    }

    public String getCommunity()
    {
        return community;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getType()
    {
        return type;
    }
}
