package tea.entity.node;

import java.util.Date;
import java.util.Hashtable;
import tea.db.DbAdapter;
import tea.entity.*;
import tea.ui.TeaSession;
import tea.html.Text;
import tea.html.Anchor;
import tea.html.Span;
import java.util.*;
import java.sql.SQLException;

public class News extends Entity
{
    private static Cache _cache = new Cache(100);
    private int _nNode;
    private Date _issueTime;
    private boolean _blLoaded;
    private Hashtable _htLayer;


    class Layer
    {

        public String _strReporter;
        public String _strPress;
        public String _strLocation;

        Layer()
        {
        }
    }


    public void set(Date date,int i,String s,String s1,String s2) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            // db.executeUpdate("NewsEdit " + _nNode + ", " + DbAdapter.cite(date) + ", " +
            // "" + i + ", " + DbAdapter.cite(s) + ", " + DbAdapter.cite(s1) + ", " + DbAdapter.cite(s2));
            db.executeQuery("SELECT node  FROM News WHERE node=" + _nNode);
            if(db.next())
            {
                db.executeUpdate("UPDATE News  SET issuetime=" + DbAdapter.cite(date) + "	 WHERE node=" + _nNode);
            } else
            {
                db.executeUpdate("INSERT News(node, issuetime)VALUES (" + _nNode + ", " + DbAdapter.cite(date) + ")");
            }
            db.executeQuery("SELECT node 	 FROM NewsLayer  WHERE node=" + _nNode + " AND language=" + i);
            if(db.next())
            {
                db.executeUpdate("UPDATE NewsLayer  SET reporter=" + DbAdapter.cite(s) + ",  press=" + DbAdapter.cite(s1) + ",  location=" + DbAdapter.cite(s2) + "	 WHERE node=" + _nNode + "  AND language=" + i);
            } else
            {
                db.executeUpdate("INSERT INTO NewsLayer (node, language, reporter, press, location)VALUES (" + _nNode + ", " + i + ", " + DbAdapter.cite(s) + ", " + DbAdapter.cite(s1) + ", " + DbAdapter.cite(s2) + ")");
            }
        } finally
        {
            db.close();
        }
        _issueTime = date;
        _htLayer.clear();
    }

    private News(int i)
    {
        _nNode = i;
        _blLoaded = false;
        _htLayer = new Hashtable();
    }

    public boolean isLayerExisted(int i) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node  FROM NewsLayer  WHERE node=" + _nNode + " AND language=" + i);
            flag = db.next();
        } finally
        {
            db.close();
        }
        return flag;
    }

    public String getPress(int i) throws SQLException
    {
        return getLayer(i)._strPress;
    }

    public Date getIssueTime() throws SQLException
    {
        load();
        return _issueTime;
    }

    public String getReporter(int i) throws SQLException
    {
        return getLayer(i)._strReporter;
    }

    private void load() throws SQLException
    {
        if(!_blLoaded)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT issuetime  FROM News   WHERE node=" + _nNode);
                if(db.next())
                {
                    _issueTime = db.getDate(1);
                }
            } finally
            {
                db.close();
            }
            _blLoaded = true;
        }
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
                db.executeQuery("SELECT reporter, press, location  FROM NewsLayer  WHERE node=" + _nNode + " AND language=" + j);
                if(db.next())
                {
                    layer._strReporter = db.getVarchar(j,i,1);
                    layer._strPress = db.getVarchar(j,i,2);
                    layer._strLocation = db.getVarchar(j,i,3);
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
            db.executeQuery("SELECT language FROM NewsLayer WHERE node=" + _nNode);
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

    public void delete(int i) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM NewsLayer  WHERE node=" + _nNode + " AND language=" + i);
        } finally
        {
            db.close();
        }
        _htLayer.remove(new Integer(i));
    }

    public static News find(int i)
    {
        News news = (News) _cache.get(new Integer(i));
        if(news == null)
        {
            news = new News(i);
            _cache.put(new Integer(i),news);
        }
        return news;
    }

    public String getLocation(int i) throws SQLException
    {
        return getLayer(i)._strLocation;
    }

    public static String getDetail(Node node,Http h,int listing,String target,tea.resource.Resource r) throws SQLException // (Node node, int i, int j, String s, String s1) throws SQLException
    {
        Span span = null;
        News obj = News.find(node._nNode);
        StringBuilder htm = new StringBuilder();
        ListingDetail detail = ListingDetail.find(listing,13,h.language);
        java.util.Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = null;
            int istype = detail.getIstype(name);
            if(istype == 0)
            {
                continue;
            }
            if(name.equals("subject"))
            {
                value = (node.getSubject(h.language));
            } else if(name.equals("reporter"))
            {
                value = (obj.getReporter(h.language));
            } else if(name.equals("press"))
            {
                value = (obj.getPress(h.language));
            } else if(name.equals("location"))
            {
                value = (obj.getLocation(h.language));
            } else if(name.equals("issuetime"))
            {
                if(obj.getIssueTime() != null)
                {
                    value = (new java.text.SimpleDateFormat("yyyy-MM-dd").format(obj.getIssueTime()));
                } else
                {
                    value = ("");
                }
            }
            if(detail.getAnchor(name) != 0)
            {
                Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/news/" + node._nNode + "-" + h.language + ".htm",value);
                anchor.setTarget(target);
                span = new Span(anchor);
            } else
            {
                span = new Span(value);
            }
            span.setId("NewsID" + name);
            htm.append(detail.getBeforeItem(name) + span + detail.getAfterItem(name));
        }
        return htm.toString();
    }
}
