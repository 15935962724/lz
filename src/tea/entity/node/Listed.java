package tea.entity.node;

import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class Listed extends Entity
{
    private static Cache _cache = new Cache(100);
    private int _nListed;
    private int _nNode;
    private int _nListing;
    private Date _stopTime;
    private boolean _blLoaded;
    private Listed(int _nListed,int _nNode,int _nListing,Date _stopTime)
    {
        this._nListed = _nListed;
        this._nNode = _nNode;
        this._nListing = _nListing;
        this._stopTime = _stopTime;
        this._blLoaded = true;
    }

    public void set(Date date) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Listed SET stoptime=" + DbAdapter.cite(date) + " WHERE listed=" + _nListed);
        } finally
        {
            db.close();
        }
        _stopTime = date;
    }

    private static String getBriefcaseItemsSql(int i)
    {
        return " FROM Listed WHERE listing=" + i;
    }

    public static boolean isExistedByListing(int i) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT listed FROM Listed WHERE listing=" + i);
            flag = db.next();
        } finally
        {
            db.close();
        }
        return flag;
    }

    private Listed(int i)
    {
        _nListed = i;
        _blLoaded = false;
    }

    public static void create(int node,int listing,Date time) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT listed FROM Listed WHERE node=" + node + " AND listing=" + listing);
            int listed = db.next() ? db.getInt(1) : 0;
            String sql;
            if(listed < 1)
                sql = "INSERT INTO Listed(listed,node,listing,stoptime)VALUES(" + (listed = Seq.get()) + "," + node + "," + listing + "," + DbAdapter.cite(time) + ")";
            else
                sql = "UPDATE Listed SET stoptime=" + DbAdapter.cite(time) + " WHERE listed=" + listed;
            db.executeUpdate(listed,sql);
        } finally
        {
            db.close();
        }
    }

//    public static Listed create(int node,int listing,Date time) throws SQLException
//    {
//        int j,k = 0;
//        DbAdapter db = new DbAdapter();
//        try
//        {
//            db.executeQuery("SELECT listed FROM Listed WHERE node=" + node + " AND listing =" + listing);
//            if(db.next())
//            {
//                j = db.getInt(1);
//            } else
//            {
//                j = db.executeUpdate("INSERT INTO Listed(node, listing, stoptime)VALUES (" + node + ", " + listing + ", " + DbAdapter.cite(time) + ")");
//            }
//            k = db.getInt(j < 1 ? "SELECT listed FROM Listed WHERE node=" + node + " AND listing=" + listing : "SELECT MAX(listed) FROM Listed");
//        } finally
//        {
//            db.close();
//        }
//        Listed obj = find(k);
//        if(j < 1)
//        {
//            obj.set(time);
//        }
//        return obj;
//    }

    public int getNode() throws SQLException
    {
        load();
        return _nNode;
    }

    public int getListed()
    {
        return _nListed;
    }

    public static Enumeration findBriefcaseItems(int i) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT listed " + getBriefcaseItemsSql(i));
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

    //分页显示的 ;

    public static Enumeration findBriefcaseItems(int listingid,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT listed FROM Listed WHERE listing=" + listingid + sql,pos,size);
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

    public static int countBriefcaseItems(int listingid,String sql) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            i = db.getInt("SELECT count(listed) FROM Listed WHERE listing=" + listingid + sql);
        } finally
        {
            db.close();
        }
        return i;
    }


    public int getListing() throws SQLException
    {
        load();
        return _nListing;
    }

    public static int countNodes(RV rv) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            i = db.getInt("SELECT COUNT(DISTINCT l.node) " + getNodesSql(rv));
        } finally
        {
            db.close();
        }
        return i;
    }

    private void load() throws SQLException
    {
        if(!_blLoaded)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT node, listing, stoptime FROM Listed  WHERE listed=" + _nListed);
                if(db.next())
                {
                    _nNode = db.getInt(1);
                    _nListing = db.getInt(2);
                    _stopTime = db.getDate(3);
                }
            } finally
            {
                db.close();
            }
            _blLoaded = true;
        }
    }

    public static Enumeration findNodes(RV rv,int pos,int size) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT DISTINCT l.node " + getNodesSql(rv),pos,size);
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

    public Date getStopTime() throws SQLException
    {
        load();
        return _stopTime;
    }

    public String getStopTimeToString() throws SQLException
    {
        load();
        if(_stopTime == null)
        {
            return "";
        }
        return sdf2.format(_stopTime);
    }

    public static int countListeds(int i) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.getInt("SELECT listed FROM Listed WHERE node=" + i);
        } finally
        {
            db.close();
        }
        return j;
    }

    public static Enumeration findListeds(int i) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT listed FROM Listed WHERE node=" + i);
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

    public static int count(String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.getInt("SELECT COUNT(*) FROM Listed WHERE 1=1" + sql);
        } finally
        {
            db.close();
        }
        return j;
    }

    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT listed,node,listing,stoptime FROM Listed WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                v.addElement(new Listed(db.getInt(1),db.getInt(2),db.getInt(3),db.getDate(4)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }


    public static Enumeration findListing(int node) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT listing FROM Listed WHERE node=" + node + " AND (stoptime IS NULL OR stoptime>" + db.citeCurTime() + ") GROUP BY listing");
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
            db.executeUpdate("DELETE FROM Listed WHERE listed=" + _nListed);
        } finally
        {
            db.close();
        }
    }

    public static void delete(int node,int listing) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Listed WHERE node=" + node + " and listing = " + listing);
        } finally
        {
            db.close();
        }
    }

    public static Listed find(int i)
    {
        Listed listed = (Listed) _cache.get(new Integer(i));
        if(listed == null)
        {
            listed = new Listed(i);
            _cache.put(new Integer(i),listed);
        }
        return listed;
    }

    private static String getNodesSql(RV rv)
    {
        return " FROM Listed l, Node n  WHERE l.node=n.node  AND n.rcreator=" + DbAdapter.cite(rv._strR);
    }

    public static int countBriefcaseItems(int i) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.getInt("SELECT COUNT(listed) " + getBriefcaseItemsSql(i));
        } finally
        {
            db.close();
        }
        return j;
    }
}
