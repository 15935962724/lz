package tea.entity.site;

import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;
import java.sql.SQLException;

public class Subscriber extends Entity
{
    public static final String OPTION_TYPE[] =
            {"申请加入","已加入未审核","已审核"};
    public static final int SUBSCRIBERO_EMAILNEWS = 1;
    private String _strCommunity;
    private RV _rv;
    private int _nOptions;
    public Date time;
    private Date term; // 有效期
    private boolean exists;
    private static Cache _cache = new Cache(100);

    public void set(int options) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("UPDATE Subscriber SET options=" + options + " WHERE community=" + DbAdapter.cite(_strCommunity) + " AND rmember=" + DbAdapter.cite(_rv._strR) + " AND vmember=" + DbAdapter.cite(_rv._strV));
        } finally
        {
            db.close();
        }
        _nOptions = options;
    }

    public void setTerm(Date term) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("UPDATE Subscriber SET term=" + DbAdapter.cite(term) + " WHERE community=" + DbAdapter.cite(_strCommunity) + " AND rmember=" + DbAdapter.cite(_rv._strR) + " AND vmember=" + DbAdapter.cite(_rv._strV));
        } finally
        {
            db.close();
        }
        this.term = term;
    }

    public static int countJoined(RV rv) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter(1);
        try
        {
            i = db.getInt("SELECT COUNT(c.community) " + getJoinedSql(rv));
        } finally
        {
            db.close();
        }
        return i;
    }

    private Subscriber(String s,RV rv) throws SQLException
    {
        _strCommunity = s;
        _rv = rv;
        load();
    }

    public static Enumeration findJoined(RV rv) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT c.community " + getJoinedSql(rv));
            while(db.next())
            {
                v.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static void create(String community,RV rv,int options) throws SQLException
    {
        if(community != null && community.length() > 0)
        {
        } else
        {
            community = "Home";
        }

        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("INSERT INTO Subscriber(community,rmember,vmember,options,time)VALUES(" + DbAdapter.cite(community) + ", " + DbAdapter.cite(rv._strR) + ", " + DbAdapter.cite(rv._strV) + "," + options + "," + db.citeCurTime() + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(community + ":" + rv._strR + ":" + rv._strV);
    }

    public int getOptions()
    {
        return _nOptions;
    }

    private static String getJoinedSql(RV rv)
    {
        return " FROM Community c, Subscriber s  WHERE c.community=s.community   AND rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV);
    }

    public static Enumeration findEmails(String s,int i,int j) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT DISTINCT email FROM Subscriber s, ProfileLayer pl  WHERE community=" + DbAdapter.cite(s) + " AND s.vmember=pl.member ",i,j);
            while(db.next())
            {
                v.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static boolean inOrganizer(String s,String s1) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT o.community  FROM Organizer o, Subscriber s  WHERE o.member=" + DbAdapter.cite(s1) + " AND o.community=s.community AND (s.rmember=" + DbAdapter.cite(s) + "   OR s.vmember=" + DbAdapter.cite(s) + ")");
            if(!db.next())
            {
                db.executeQuery("SELECT o.community  FROM Organizer o, Profile  WHERE o.member=" + DbAdapter.cite(s1) + " AND o.community=Profile.community AND Profile.member=" + DbAdapter.cite(s));
                return db.next();
            } else
            {
                return true;
            }
        } finally
        {
            db.close();
        }
    }

    public static void deleteByCommunity(String s) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("DELETE FROM Subscriber  WHERE community=" + DbAdapter.cite(s));
        } finally
        {
            db.close();
        }
        _cache.clear();
    }

    public static boolean isSubscriber(String community,RV rv) throws SQLException
    {
        return find(community,rv).isExists();
    }

    public static int count(String community,String sql) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter(1);
        try
        {
            i = db.getInt("SELECT COUNT(*) FROM Subscriber s WHERE s.community=" + DbAdapter.cite(community) + sql);
        } finally
        {
            db.close();
        }
        return i;
    }

    public static Subscriber find(String community,RV rv) throws SQLException
    {
        Subscriber obj = (Subscriber) _cache.get(community + ":" + rv._strR + ":" + rv._strV);
        if(obj == null)
        {
            obj = new Subscriber(community,rv);
            _cache.put(community + ":" + rv._strR + ":" + rv._strV,obj);
        }
        return obj;
    }

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT rmember, vmember FROM Subscriber s WHERE s.community=" + DbAdapter.cite(community) + sql,pos,size);
            while(db.next())
            {
                v.addElement(new RV(db.getString(1),db.getString(2)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("DELETE FROM Subscriber WHERE community=" + DbAdapter.cite(_strCommunity) + " AND rmember=" + DbAdapter.cite(_rv._strR) + " AND vmember=" + DbAdapter.cite(_rv._strV));
        } finally
        {
            db.close();
        }
        _cache.remove(_strCommunity + ":" + _rv._strR + ":" + _rv._strV);
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT options,term FROM Subscriber WHERE community=" + DbAdapter.cite(_strCommunity) + " AND rmember=" + DbAdapter.cite(_rv._strR) + " AND vmember=" + DbAdapter.cite(_rv._strV));
            if(db.next())
            {
                _nOptions = db.getInt(1);
                term = db.getDate(2);
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

    public boolean isExists()
    {
        return exists;
    }

    public Date getTerm()
    {
        return term;
    }
}
