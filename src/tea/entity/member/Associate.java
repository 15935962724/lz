package tea.entity.member;

import java.util.Enumeration;
import java.util.Vector;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class Associate extends Entity
{
    public static final int ASSOCIATE_HUMANRESOURCE = 1;
    public static final int ASSOCIATE_SUPPORT = 2;
    public static final int ASSOCIATE_PURCHASER = 4;
    public static final int ASSOCIATE_ACCOUNTANT = 8;
    public static final int ASSOCIATE_ORGANIZER = 16;
    public static final int ASSOCIATE_ADMANAGER = 32;
    public static String ASSOCIATE[] =
            {"HR","Support","Purchaser","Accountant","Organizer","AdManager"};
    private String _strMember;
    private String _strAssociate;
    private int _nPositions;
    private int _nManagers;
    private int _nProviders0;
    private int _nProviders1;
    private String _strStartUrl;
    private boolean _blLoaded;
    private static Cache _cache = new Cache(100);
    private String community;

    public void set(int i,int j,int k,int l,String s) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            // db.executeUpdate("AssociateCreate " + DbAdapter.cite(community) + ", " + DbAdapter.cite(_strMember) + ", " + DbAdapter.cite(_strAssociate) + ", " + i + ", " + j + ", " + k + ", " + l
            // + ", " + DbAdapter.cite(s));

            db.executeQuery("SELECT member FROM Associate WHERE member=" + DbAdapter.cite(community) + " AND associate=" + DbAdapter.cite(_strMember));
            if(db.next())
            {
                db.executeUpdate("UPDATE Associate  SET positions=" + DbAdapter.cite(_strAssociate) + ", managers=" + i + ",providers0=" + j + ",providers1=" + k + ",starturl=" + l + "WHERE member=" + DbAdapter.cite(community) + " AND associate=" + DbAdapter.cite(_strMember) + "");
            } else
            {
                db.executeUpdate("INSERT INTO Associate(member, associate, positions, managers, providers0, providers1, starturl) VALUES (" + DbAdapter.cite(community) + ", " + DbAdapter.cite(_strMember) + ", " + DbAdapter.cite(_strAssociate) + ", " + i + ", " + j + ", " + k + ", " + l + ")");
            }
        } finally
        {
            db.close();
        }
        _nPositions = i;
        _nManagers = j;
        _nProviders0 = k;
        _nProviders1 = l;
        _strStartUrl = s;
    }

    private Associate(String member,String associate)
    {
        _strMember = member;
        _strAssociate = associate;
        _blLoaded = false;
    }

    public static Associate create(String member,String associate,int positions,int managers,int providers0,int providers1,String starturl) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("AssociateCreate " + DbAdapter.cite(member) + ", " + DbAdapter.cite(associate) + ", " + positions + ", " + managers + ", " + providers0 + ", " + providers1 + ", " + DbAdapter.cite(starturl));
            db.executeQuery("SELECT member FROM Associate WHERE member=" + DbAdapter.cite(member) + " AND associate=" + DbAdapter.cite(associate));
            if(db.next())
            {
                db.executeUpdate("UPDATE Associate  SET positions=" + positions + ", managers=" + managers + ",providers0=" + providers0 + ",providers1=" + providers1 + ",starturl=" + DbAdapter.cite(starturl) + "WHERE member=" + DbAdapter.cite(member) + " AND associate=" + DbAdapter.cite(associate) + "");
            } else
            {
                db.executeUpdate("INSERT INTO Associate(member, associate, positions, managers, providers0, providers1, starturl) VALUES (" + DbAdapter.cite(member) + ", " + DbAdapter.cite(associate) + ", " + positions + ", " + managers + ", " + providers0 + ", " + providers1 + ", " + DbAdapter.cite(starturl) + ")");
            }
        } finally
        {
            db.close();
        }
        return find(member,associate);
    }

    public boolean isSupport() throws SQLException
    {
        return(getPositions() & 2) != 0;
    }

    public boolean isPurchaser() throws SQLException
    {
        return(getPositions() & 4) != 0;
    }

    public String getStartUrl() throws SQLException
    {
        load();
        return _strStartUrl;
    }

    public boolean isAccountant() throws SQLException
    {
        return(getPositions() & 8) != 0;
    }

    public static boolean isExisted(RV rv) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT member  FROM Associate  WHERE member=" + DbAdapter.cite(rv._strR) + " AND associate=" + DbAdapter.cite(rv._strV));
            flag = db.next();
        } finally
        {
            db.close();
        }
        return flag;
    }

    private void load() throws SQLException
    {
        if(!_blLoaded)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT positions, managers, providers0, providers1, starturl FROM Associate  WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(_strMember) + " AND associate=" + DbAdapter.cite(_strAssociate));
                if(db.next())
                {
                    _nPositions = db.getInt(1);
                    _nManagers = db.getInt(2);
                    _nProviders0 = db.getInt(3);
                    _nProviders1 = db.getInt(4);
                    _strStartUrl = db.getString(5);
                }
            } finally
            {
                db.close();
            }
        }
    }

    public int getManagers() throws SQLException
    {
        load();
        return _nManagers;
    }

    public boolean isOrganizer() throws SQLException
    {
        return(getPositions() & 0x10) != 0;
    }

    public boolean isProvider(int i) throws SQLException
    {
        if(i < 32)
        {
            return(getProviders0() & 1 << i) != 0;
        }
        return(getProviders1() & 1 << i % 32) != 0;
    }

    public boolean isAdManager() throws SQLException
    {
        return(getPositions() & 0x20) != 0;
    }

    public int getPositions() throws SQLException
    {
        load();
        return _nPositions;
    }

    public int getProviders0() throws SQLException
    {
        load();
        return _nProviders0;
    }

    public static int count(String community,String sql) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            i = db.getInt("SELECT COUNT(member)  FROM Associate  WHERE community=" + DbAdapter.cite(community));
        } finally
        {
            db.close();
        }
        return i;
    }

    /*
     * public static int count(String community) throws SQLException { int i =0; DbAdapter db= new DbAdapter(); try { i = db.getInt("SELECT COUNT(member) FROM Associate WHERE community="+DbAdapter.cite(community)); }catch(Exception exception) { throw new SQLException(exception.toString()); } finally { db.close(); } return i; }
     */
    public static Associate find(String member,String associate)
    {
        Associate obj = (Associate) _cache.get(member + ":" + associate);
        if(obj == null)
        {
            obj = new Associate(member,associate);
            _cache.put(member + ":" + associate,obj);
        }
        return obj;
    }

    public static Enumeration find(String community,String sql,int i,int j) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT associate  FROM Associate  WHERE community=" + DbAdapter.cite(community) + sql,i,j);
            while(db.next())
            {
                vector.addElement(db.getString(1));
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
            db.executeUpdate("DELETE FROM Associate  WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(_strMember) + " AND associate=" + DbAdapter.cite(_strAssociate));
        } finally
        {
            db.close();
        }
        _cache.remove(community + ":" + _strMember + ":" + _strAssociate);
    }

    public boolean isHR() throws SQLException
    {
        return(getPositions() & 1) != 0;
    }

    public int getProviders1() throws SQLException
    {
        load();
        return _nProviders1;
    }

    public String getCommunity()
    {
        return community;
    }

}
