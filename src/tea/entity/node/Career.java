package tea.entity.node;

import java.util.*;

import tea.db.*;
import tea.entity.*;
import tea.html.*;
import tea.ui.*;
import java.sql.SQLException;

public class Career extends Entity
{
    class Layer
    {

        public String _strSalary;
        public String _strLocation;
        public String _strSkill;
        public String _strTarget;

        Layer()
        {
        }
    }


    public void set(int timeType,int j,String s,String s1,String s2,String s3) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            // dbadapter.executeUpdate("CareerEdit " + _nNode + ", " + timeType + ", " + j + ", " + DbAdapter.cite(s) + ", " + DbAdapter.cite(s1) + ", " + DbAdapter.cite(s2) + ", " + DbAdapter.cite(s3));
            dbadapter.executeQuery("SELECT node FROM Career WHERE node=" + _nNode);
            if(dbadapter.next())
            {
                dbadapter.executeUpdate("UPDATE Career    SET timetype=" + timeType + " WHERE node=" + _nNode);
            } else
            {
                dbadapter.executeUpdate("INSERT INTO Career (node, timetype) VALUES (" + _nNode + ", " + timeType + ")");
            }
            dbadapter.executeQuery("SELECT node  FROM CareerLayer  WHERE node=" + _nNode + " AND language=" + j);
            if(dbadapter.next())
            {
                dbadapter.executeUpdate("UPDATE CareerLayer  SET salary=" + DbAdapter.cite(s) + ",  location=" + DbAdapter.cite(s1) + ",  skill=" + DbAdapter.cite(s2) + ",  target=" + DbAdapter.cite(s3) + " WHERE node=" + _nNode);
            } else
            {
                dbadapter.executeUpdate("INSERT INTO CareerLayer (node, language, salary, location, skill, target)VALUES (" + _nNode + ", " + j + ", " + DbAdapter.cite(s) + ", " + DbAdapter.cite(s1) + ", " + DbAdapter.cite(s2) + ", " + DbAdapter.cite(s3) + ")");
            }
        } finally
        {
            dbadapter.close();
        }
        this._nTimeType = timeType;
        _htLayer.clear();
    }

    public String getTarget(int i) throws SQLException
    {
        return getLayer(i)._strTarget;
    }

    private Career(int i)
    {
        _nNode = i;
        _blLoaded = false;
        _htLayer = new Hashtable();
    }

    public boolean isLayerExisted(int i) throws SQLException
    {
        boolean flag;
        flag = false;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT node  FROM CareerLayer  WHERE node=" + _nNode + " AND language=" + i);
            flag = dbadapter.next();
        } finally
        {
            dbadapter.close();
        }
        return flag;
    }

    public String getSkill(int i) throws SQLException
    {
        return getLayer(i)._strSkill;
    }

    public int getTimeType() throws SQLException
    {
        load();
        return _nTimeType;
    }

    private void load() throws SQLException
    {
        if(!_blLoaded)
        {
            DbAdapter dbadapter = new DbAdapter();
            try
            {
                dbadapter.executeQuery("SELECT timetype  FROM Career  WHERE node=" + _nNode);
                if(dbadapter.next())
                {
                    _nTimeType = dbadapter.getInt(1);
                }
            } finally
            {
                dbadapter.close();
            }
            _blLoaded = true;
        }
    }

    private Layer getLayer(int i) throws SQLException
    {
        Layer layer;
        layer = (Layer) _htLayer.get(new Integer(i));
        if(layer == null)
        {
            layer = new Layer();
            DbAdapter dbadapter = new DbAdapter();
            try
            {
                // int j = dbadapter.getInt("CareerGetLanguage " + _nNode + ", " + i);
                int j = this.getLanguage(i);
                dbadapter.executeQuery("SELECT salary, location, skill, target  FROM CareerLayer  WHERE node=" + _nNode + " AND language=" + j);
                if(dbadapter.next())
                {
                    layer._strSalary = dbadapter.getVarchar(j,i,1);
                    layer._strLocation = dbadapter.getVarchar(j,i,2);
                    layer._strSkill = dbadapter.getVarchar(j,i,3);
                    layer._strTarget = dbadapter.getVarchar(j,i,4);
                }
            } finally
            {
                dbadapter.close();
            }
            _htLayer.put(new Integer(i),layer);
        }
        return layer;
    }

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT language FROM CareerLayer WHERE node=" + _nNode);
            while(dbadapter.next())
            {
                v.addElement(new Integer(dbadapter.getInt(1)));
            }
        } finally
        {
            dbadapter.close();
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
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("DELETE FROM CareerLayer  WHERE node=" + _nNode + " AND language=" + i);
        } finally
        {
            dbadapter.close();
        }
    }

    public static Career find(int i)
    {
        Career career = (Career) _cache.get(new Integer(i));
        if(career == null)
        {
            career = new Career(i);
            _cache.put(new Integer(i),career);
        }
        return career;
    }

    public String getSalary(int i) throws SQLException
    {
        return getLayer(i)._strSalary;
    }

    public String getLocation(int i) throws SQLException
    {
        return getLayer(i)._strLocation;
    }

    public static final String CAREER_TIMETYPE[] =
            {"FullTime","PartTime"};
    private int _nNode;
    private int _nTimeType;
    private boolean _blLoaded;
    private Hashtable _htLayer;
    private static Cache _cache = new Cache(100);

    public static String getDetail(Node node,Http h,int listing,String target,tea.resource.Resource r) throws SQLException
    {
        Career obj = Career.find(node._nNode);
        StringBuilder sb = new StringBuilder();
        Span span;
        ListingDetail detail = ListingDetail.find(listing,29,h.language);
        java.util.Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = null;
            int istype = detail.getIstype(name);
            if(istype == 0)
            {
                continue;
            }
            if("subject".equals(name))
            {
                value = (node.getSubject(h.language));
            } else if("timetype".equals(name))
            {
                value = (r.getString(h.language,Career.CAREER_TIMETYPE[obj.getTimeType()]));
            } else if("salary".equals(name))
            {
                value = (obj.getSalary(h.language));
            } else if("location".equals(name))
            {
                value = (obj.getLocation(h.language));
            } else if("skill".equals(name))
            {
                value = (obj.getSkill(h.language));
            } else if("target".equals(name))
            {
                value = (obj.getTarget(h.language));
            }
            if(detail.getAnchor(name) != 0)
            {
                Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/career/" + node._nNode + "-" + h.language + ".htm",value);
                anchor.setTarget(target);
                span = new Span(anchor);
            } else
            {
                span = new Span(value);
            }
            span.setId("CareerID" + name);
            sb.append(detail.getBeforeItem(name)).append(span).append(detail.getAfterItem(name));
        }
        return sb.toString();
    }
}
