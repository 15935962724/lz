package tea.entity.node;

import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import java.util.*;
import java.sql.SQLException;

/***/
public class Search
{
    private static Cache _cache = new Cache(100);
    private int listing;
    private String searchListing;
    private int type;
    private int searchNode;
    private boolean context;
    private boolean layerLoad;
    private boolean exist;
    private Hashtable _htLayer;

    static class Layer
    {
        private String term;
        private String field;
        private int order;
        private int id;
        private int language;
        /*
         * public Layer(int id, int language) { this.id = id; this.language = language; loadBasic(); }
         */
    }


    public int getLanguage(int id, int langu) throws SQLException
    {
        return getLayer(id, langu).language;
    }

    public Enumeration getId(int langu) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM SearchLayer WHERE listing=" + listing + " AND language=" + langu);
            while (db.next())
            {
                v.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public int getOrder(int id, int langu) throws SQLException
    {
        return getLayer(id, langu).order;
    }

    public String getField(int id, int langu) throws SQLException
    {
        return getLayer(id, langu).field;
    }

    public String getTerm(int id, int langu) throws SQLException
    {
        return getLayer(id, langu).term;
    }

    public int getType()
    {
        return type;
    }

    public void setType(int type)
    {
        this.type = type;
    }

    public void setLayer(String term, String field, int order, int id, int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("UPDATE SearchLayer SET term=" + DbAdapter.cite(term) + ",field=" + DbAdapter.cite(field) + ",sequence=" + order + " WHERE listing=" + listing + " AND id=" + id + " AND language=" + language);
            if (j < 1)
            {
                db.executeUpdate("INSERT INTO SearchLayer (listing, term, field , sequence , id, language)VALUES (" + listing + ", " + DbAdapter.cite(term) + ", " + DbAdapter.cite(field) + " , " + order + " , " + id + ", " + language + ")");
            }
        } finally
        {
            db.close();
        }
        _htLayer.remove(id + ":" + language);
    }

    public static Search find(int listing)throws SQLException
    {
        Search search = (Search) _cache.get(new Integer(listing));
        if (search == null)
        {
            search = new Search(listing);
            _cache.put(new Integer(listing), search);
        }
        return search;
    }

    public static Search find(Integer searchNode)throws SQLException
    {
        Search search; // = (Search) _cache.get(searchNode.int);
        // if (search == null)
        {
            search = new Search(searchNode);
            // _cache.put(new Integer(listing), search);
        }
        return search;
    }

    public Search(int listing)throws SQLException
    {
        this.listing = listing;
        this._htLayer = new Hashtable();
        loadBasic();
    }

    public Search(Integer searchNode)throws SQLException
    {
        this.searchNode = searchNode.intValue();
        this._htLayer = new Hashtable();
        loadBasic2();
    }

    public boolean exists()
    {
        return exist;
    }

    public Search(int searchNode, int searchListing, int type) throws SQLException
    {
        _htLayer = new Hashtable();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT listing,searchListing FROM Search WHERE searchNode=" + searchNode + " AND (type=" + type + " OR type=255) AND (searchListing like '%" + searchListing + "' OR searchListing like '%/" + searchListing + "/%')");
            if (db.next())
            {
                this.listing = db.getInt(1);
                this.searchListing = db.getString(2);
                this.type = type;
                this.searchNode = searchNode;
                this.exist = true;
            } else
            {
                this.exist = false;
            }
        } finally
        {
            db.close();
        }
    }

    public static Search find(int searchNode, int searchListing, int type) throws SQLException
    {
        Search search = (Search) _cache.get(searchNode + ":" + searchListing + ":" + type);
        // if (search == null)
        {
            search = new Search(searchNode, searchListing, type);
            _cache.put(searchNode + ":" + searchListing + ":" + type, search);
        }
        return search;
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT searchNode,searchListing,type,context FROM Search WHERE listing=" + listing);
            if (db.next())
            {
                this.searchNode = db.getInt(1);
                this.searchListing = db.getString(2);
                this.type = db.getInt(3);
                this.context = db.getInt(4) != 0;
                this.exist = true;
            } else
            {
                this.searchListing = "";
                this.exist = false;
            }
        } finally
        {
            db.close();
        }
    }

    private void loadBasic2() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT searchNode,searchListing,type FROM Search  WHERE searchNode=" + this.searchNode);
            if (db.next())
            {
                this.searchNode = db.getInt(1);
                searchListing = db.getString(2);
                type = db.getInt(3);
                exist = true;
            } else
            {
                searchListing = "";
                exist = false;
            }
        } finally
        {
            db.close();
        }
    }

    public String getTerm(int langu) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        int j = this.getLanguage(langu);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT term FROM SearchLayer WHERE listing=" + this.listing + " AND language=" + j + " ORDER BY sequence");
            while (db.next())
            {
                sb.append(db.getText(j, langu, 1));
            }
        } finally
        {
            db.close();
        }
        return sb.toString();
    }

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language FROM SearchLayer WHERE listing=" + listing);
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

    private Layer getLayer(int id, int langu) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(id + ":" + langu);
        if (layer == null)
        {
            layer = new Layer();
            int j = getLanguage(langu);
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT term,  field, sequence FROM SearchLayer WHERE listing=" + listing + " AND language=" + j + " AND id=" + id);
                if (db.next())
                {
                    layer.term = db.getText(j, langu, 1);
                    layer.field = db.getString(2);
                    layer.order = db.getInt(3);
                } else
                {
                    layer.term = "";
                    layer.field = "";
                }
            } finally
            {
                db.close();
            }
            _htLayer.put(id + ":" + langu, layer);
        }
        return layer;
    }

    public Enumeration getSearchListing()
    {
        Vector v = new Vector();
        if (searchListing == null || searchListing.length() <= 0)
        {
            return v.elements(); // ""
        }
        StringTokenizer tk = new StringTokenizer(searchListing, "/");
        while (tk.hasMoreTokens())
        {
            v.addElement(new Integer(tk.nextToken()));
        }
        return v.elements();
    }

    public boolean isSearchListing(int listing)
    {
        StringTokenizer tokenizer = new StringTokenizer(searchListing, "/");
        while (tokenizer.hasMoreTokens())
        {
            if (Integer.parseInt(tokenizer.nextToken()) == listing)
            {
                return true;
            }
        }
        return false;
    }

    public int getSearchNode()
    {
        return searchNode;
    }

    public int getListing()
    {
        return listing;
    }

    public boolean isContext()
    {
        return context;
    }

    public void setSearchListing(String searchListing)
    {
        this.searchListing = searchListing;
    }

    public void setSearchNode(int searchNode)
    {
        this.searchNode = searchNode;
    }

    public void setListing(int listing)
    {
        this.listing = listing;
    }

    public void setContext(boolean context)
    {
        this.context = context;
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT listing FROM Search WHERE listing=" + listing);
            if (db.next())
            {
                db.executeUpdate("UPDATE Search	SET searchListing=" + DbAdapter.cite(searchListing) + ",type=" + type + ",searchNode=" + searchNode + ",context=" + (context ? "1" : "0") + " WHERE listing=" + listing);
            } else
            {
                db.executeUpdate("INSERT INTO Search (listing,searchNode, searchListing, type,context)VALUES (" + listing + "," + searchNode + ", " + DbAdapter.cite(searchListing) + ", " + type + "," + (context ? "1" : "0") + ")");
            }
        } finally
        {
            db.close();
        }
        exist = true;
        _htLayer.clear();
        // _cache.remove(new Integer(listing));
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Search WHERE listing=" + listing);
            db.executeUpdate("DELETE FROM SearchLayer WHERE listing=" + listing);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(listing));
    }
}
