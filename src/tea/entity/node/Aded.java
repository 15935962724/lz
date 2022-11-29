package tea.entity.node;

import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import tea.html.Anchor;
import tea.html.Image;
import java.sql.SQLException;

public class Aded extends Entity
{
    public static final String ADED_STATUS[] =
            {"Ungranted","Granted","Finished"};
    public static final int ADEDSTATUS_UNGRANTED = 0;
    public static final int ADEDSTATUS_GRANTED = 1;
    public static final int ADEDSTATUS_FINISHED = 2;
    public static final int ADEDO_NEWWINDOW = 1;
    public static final int ADEDO_PUBLIC = 2;
    private int _nAded;
    public int node;
    private int _nAding;
    private RV _rv;
    private Date _time;
    public int status;
    private int _nOptions;
    private Date _startTime;
    private Date _stopTime;
    private int _nExpectedImpression;
    private boolean _blLoaded;
    private Hashtable _htLayer;
    private static Cache _cache = new Cache(100);

    class AdLayer
    {
        public String _strAlt;
        public String _strClickUrl;
        public String _strPictureUrl;
        public String _abPicture;
    }


    public int getExpectedImpression() throws SQLException
    {
        load();
        return _nExpectedImpression;
    }

    public void grant() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Aded  SET status=" + 1 + " WHERE aded=" + _nAded);
        } finally
        {
            db.close();
        }
        status = 1;
    }

    public int getNode() throws SQLException
    {
        load();
        return node;
    }

    public Date getTime() throws SQLException
    {
        load();
        return _time;
    }


    public static int countRequestNodes(RV rv) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            i = db.getInt("SELECT COUNT(DISTINCT n.node) " + getRequestNodesSql(rv));
        } finally
        {
            db.close();
        }
        return i;
    }

    public static Enumeration findRequests(int i,int j,int k) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT aded " + getRequestsSql(i));
            for(int l = 0;l < j + k && db.next();l++)
            {
                if(l >= j)
                {
                    vector.addElement(new Integer(db.getInt(1)));
                }
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public int getOptions() throws SQLException
    {
        load();
        return _nOptions;
    }

    private void load() throws SQLException
    {
        if(!_blLoaded)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT node,ading,rmember,vmember,time,status,options,starttime,stoptime,expectedimpression FROM Aded  WHERE aded=" + _nAded);
                if(db.next())
                {
                    node = db.getInt(1);
                    _nAding = db.getInt(2);
                    _rv = new RV(db.getString(3),db.getString(4));
                    _time = db.getDate(5);
                    status = db.getInt(6);
                    _nOptions = db.getInt(7);
                    _startTime = db.getDate(8);
                    _stopTime = db.getDate(9);
                    _nExpectedImpression = db.getInt(10);
                }
            } finally
            {
                db.close();
            }
            _blLoaded = true;
        }
    }

    public boolean isCreator(RV rv) throws SQLException
    {
        return getCreator()._strR.equals(rv._strR);
    }

    public int getStatus() throws SQLException
    {
        load();
        return status;
    }

    public Date getStartTime() throws SQLException
    {
        load();
        return _startTime;
    }

    public Date getStopTime() throws SQLException
    {
        load();
        return _stopTime;
    }

    private AdLayer getLayer(int i) throws SQLException
    {
        AdLayer layer = (AdLayer) _htLayer.get(new Integer(i));
        if(layer == null)
        {
            layer = new AdLayer();
            int j = this.getLanguage(i);
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT alt, clickurl, pictureurl, picture  FROM AdedLayer  WHERE aded=" + _nAded + " AND language=" + j);
                if(db.next())
                {
                    layer._strAlt = db.getVarchar(j,i,1);
                    layer._strClickUrl = db.getString(2);
                    layer._strPictureUrl = db.getString(3);
                    layer._abPicture = db.getString(4);
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
            db.executeQuery("SELECT language FROM AdedLayer WHERE aded=" + _nAded);
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

    private static String getRequestNodesSql(RV rv)
    {
        return " FROM Node n, Aded ar WHERE n.node=ar.node AND ar.status=" + 0 + " AND n.rcreator=" + DbAdapter.cite(rv._strR);
    }

    public void finish() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Aded SET status=" + 2 + " WHERE aded=" + _nAded);
        } finally
        {
            db.close();
        }
        status = 2;
    }

    public void set(String field,String value) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(_nAded,"UPDATE Aded SET " + field + "=" + DbAdapter.cite(value) + " WHERE aded=" + _nAded);
        } finally
        {
            db.close();
        }
    }

    public static int countRequests(int i) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.getInt("SELECT COUNT(aded) " + getRequestsSql(i));
        } finally
        {
            db.close();
        }
        return j;
    }

    public void set(int i,Date date,Date date1,int j,String s,String s1,String s2,String picturename) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Aded SET options=" + i + ",starttime=" + DbAdapter.cite(date) + ",stoptime=" + DbAdapter.cite(date1) + " WHERE aded=" + _nAded);
            db.executeQuery("SELECT aded FROM AdedLayer WHERE aded=" + _nAded + " AND language=" + j);
            if(db.next())
            {
                db.executeUpdate("UPDATE AdedLayer SET alt=" + DbAdapter.cite(s) + ",clickurl=" + DbAdapter.cite(s1) + ",pictureurl=" + DbAdapter.cite(s2) + ",picture=" + DbAdapter.cite(picturename) + " WHERE aded=" + _nAded + "  AND language=" + j);
            } else
            {
                db.executeUpdate("INSERT INTO AdedLayer(aded,language,alt,clickurl,pictureurl,picture)VALUES(" + _nAded + ", " + j + ", " + DbAdapter.cite(s) + ", " + DbAdapter.cite(s1) + ", " + DbAdapter.cite(s2) + ", " + DbAdapter.cite(picturename) + ")");
            }
        } finally
        {
            db.close();
        }
        _nOptions = i;
        _startTime = date;
        _stopTime = date1;
        AdLayer layer = getLayer(j);
        // layer._strAlt = s;
        layer._strClickUrl = s1;
        layer._strPictureUrl = s2;
        layer._abPicture = picturename;
        _htLayer.clear();
    }

    /*
     * public int getPictureLen(int i) throws SQLException { byte abyte0[] = getPicture(i); if (abyte0 != null) { return abyte0.length; } else { return 0; } }
     */
    public static int findByAding(int i,int language) throws SQLException
    {
        int k = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            k = db.getInt("SELECT a.aded  FROM Aded a, AdedLayer al, AdedCounter ac WHERE a.ading=" + i + " AND a.status=" + 1 + " AND a.aded=al.aded " + " AND al.language=" + language + " AND a.aded=ac.aded " + " AND (starttime IS NULL OR starttime<" + db.citeCurTime() + ") " + " AND (stoptime IS NULL OR stoptime>" + db.citeCurTime() + ") " + " ORDER BY impression ASC, (expectedimpression-impression) DESC ");
        } finally
        {
            db.close();
        }
        return k;
    }

    private Aded(int i)
    {
        _nAded = i;
        _blLoaded = false;
        _htLayer = new Hashtable();
    }

    public static int create(int i,int j,RV rv,int k,int l,Date date,Date date1,int i1,int j1,String alt,String s1,String s2,String picture) throws SQLException
    {
        int k1 = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Aded (ading, node, rmember, vmember, status, options, starttime, stoptime, expectedimpression)VALUES (" + i + ", " + j + ", " + DbAdapter.cite(rv._strR) + ", " + DbAdapter.cite(rv._strV) + ", " + k + ", " + l + ", " + DbAdapter.cite(date) + ", " + DbAdapter.cite(date1) + ", " + i1 + ")");
            k1 = db.getInt("SELECT MAX(aded) FROM Aded");
            db.executeUpdate("INSERT INTO AdedLayer (aded, language, alt, clickurl, pictureurl, picture)VALUES (" + k1 + ", " + j1 + ", " + DbAdapter.cite(alt) + ", " + DbAdapter.cite(s1) + ", " + DbAdapter.cite(s2) + ", " + DbAdapter.cite(picture) + ")");
            db.executeUpdate("INSERT INTO AdedCounter(aded, click, impression)VALUES (" + k1 + ", 0, 0)");
        } finally
        {
            db.close();
        }
        return k1;
    }

    public boolean isLayerExisted(int i) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT aded  FROM AdedLayer  WHERE aded=" + _nAded + " AND language=" + i);
            flag = db.next();
        } finally
        {
            db.close();
        }
        return flag;
    }

    public int getAding() throws SQLException
    {
        load();
        return _nAding;
    }

    public String getPicture(int i) throws SQLException
    {
        return getLayer(i)._abPicture;
    }

    public String getClickUrl(int i) throws SQLException
    {
        return getLayer(i)._strClickUrl;
    }

    private static String getRequestsSql(int i)
    {
        return " FROM Aded   WHERE node=" + i + " AND status=" + 0;
    }

    public RV getCreator() throws SQLException
    {
        load();
        return _rv;
    }

    public String getAnchor(int language) throws SQLException
    {
        String s = getPictureUrl(language);
        if(s == null || s.length() == 0)
            s = getPicture(language);
        return "<a href='/servlet/Aded?aded=" + _nAded + "' target='_blank'><img src='" + s + "' alt=\"" + getAlt(language) + "\"/></a>";
    }

    public String getPictureUrl(int language) throws SQLException
    {
        return getLayer(language)._strPictureUrl;
    }

    public static Enumeration findRequestNodes(RV rv,int pos,int size) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT DISTINCT n.node " + getRequestNodesSql(rv),pos,size);
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

    public void deny() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Aded  WHERE aded=" + _nAded);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(_nAded));
    }

    public void delete(int i) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM AdedLayer WHERE aded=" + _nAded + " AND language=" + i);
            db.executeQuery("SELECT aded FROM AdedLayer WHERE aded=" + _nAded);
            if(!db.next())
            {
                db.executeUpdate("DELETE FROM Aded WHERE aded=" + _nAded);
            }
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(_nAded));
    }

    public static Aded find(int i)
    {
        Aded aded = (Aded) _cache.get(new Integer(i));
        if(aded == null)
        {
            aded = new Aded(i);
            _cache.put(new Integer(i),aded);
        }
        return aded;
    }

    public static Enumeration find(int i,RV rv) throws SQLException
    {
        Node node = Node.find(i);
        String s = " WHERE node=" + i;

        //up1125 guo 创建的广告所有人可见
//        if(!node.isCreator(rv))
//        {
//            s += " AND (rmember=" + DbAdapter.cite(rv._strR) + "  OR (options&" + 2 + ")<>0) ";
//        }

        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT aded FROM Aded " + s);
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

    public String getAlt(int i) throws SQLException
    {
        return getLayer(i)._strAlt;
    }


}
