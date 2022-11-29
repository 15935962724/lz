package tea.entity.node;

import java.util.Date;
import java.util.Hashtable;
import tea.db.DbAdapter;
import tea.entity.*;
import java.util.*;
import java.sql.SQLException;

public class ListingCache extends Entity
{
    public int _nListing;
    public int _nNode;
    private boolean _blLoaded;
    private Hashtable _htLayer;
    private static Cache _cache = new Cache(100);

    class Layer
    {
        public int _nDbLang;
        public Date _time;
        public String _strText;

        Layer()
        {
        }
    }


    public void set(int language,String text) throws SQLException
    {
        Date d = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("UPDATE ListingCacheLayer   SET time=" + DbAdapter.cite(d) + ", text=" + DbAdapter.cite(text) + " WHERE listing=" + _nListing + "  AND node=" + _nNode + "  AND language=" + language);
            if(j < 1)
            {
                db.executeUpdate("INSERT ListingCacheLayer(listing, node, language, text)VALUES (" + _nListing + ", " + _nNode + ", " + language + "," + DbAdapter.cite(text) + ")");
            }
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    private ListingCache(int i,int j)
    {
        _nListing = i;
        _nNode = j;
        _blLoaded = false;
        _htLayer = new Hashtable();
    }

    public int getDbLang(int i) throws SQLException
    {
        return getLayer(i)._nDbLang;
    }

    public static void expire(int i) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM ListingCacheLayer  WHERE listing=" + i);
        } finally
        {
            db.close();
        }
        _cache.clear();
    }

    public Date getTime(int i) throws SQLException
    {
        return getLayer(i)._time;
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
                db.executeQuery("SELECT time,text FROM ListingCacheLayer WHERE listing=" + _nListing + " AND node=" + _nNode + " AND language=" + j);
                if(db.next())
                {
                    layer._nDbLang = j;
                    layer._time = db.getDate(1);
                    layer._strText = db.getText(j,i,2);
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
            db.executeQuery("SELECT language FROM ListingCacheLayer WHERE node=" + _nNode + " and listing=" + _nListing);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        if(v.indexOf(new Integer(language)) != -1)
            return language;
        else
        {
            if(language == 1)
            {
                if(v.indexOf(new Integer(2)) != -1)
                    return 2;
            } else if(language == 2)
            {
                if(v.indexOf(new Integer(1)) != -1)
                    return 1;
            }
            if(v.size() < 1)
                return 0;
        }
        return((Integer) v.elementAt(0)).intValue();
    }

    public static ListingCache find(int i,int j)
    {
        ListingCache listingcache = (ListingCache) _cache.get(i + ":" + j);
        if(listingcache == null)
        {
            listingcache = new ListingCache(i,j);
            _cache.put(i + ":" + j,listingcache);
        }
        return listingcache;
    }

    public String getText(int i) throws SQLException
    {
        return getLayer(i)._strText;
    }

}
