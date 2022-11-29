package tea.entity.node;

import java.text.SimpleDateFormat;
import java.util.Date;

import tea.db.DbAdapter;
import tea.entity.util.*;
import tea.entity.*;
import tea.html.*;
import tea.ui.*;
import java.util.*;
import java.sql.SQLException;

public class District extends Entity
{
    private static Cache _cache = new Cache(100);
    private int node;
    public int language;
    public int street;

    public District(int node,int language) throws SQLException
    {
        this.node = node;
        this.language = language;
        load();
    }

    public static void create(int node,int language,int street) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO District(node,language,street)VALUES(" + node + ", " + language + ", " + street + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }

    public void set(int street) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.executeUpdate("UPDATE District SET street=" + street + " WHERE node=" + node + " AND language=" + language);
        } finally
        {
            db.close();
        }
        if(j < 1)
        {
            create(node,language,street);
        }
        this.street = street;
    }

    private void load() throws SQLException
    {
        int j = this.getLanguage(language);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT street FROM District WHERE node=" + node + " AND language=" + j);
            if(db.next())
            {
                street = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
    }

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language FROM District WHERE node=" + node);
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

    public void delete()
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM District WHERE node=" + node + " AND language=" + language);
        } catch(Exception exception)
        {
            exception.printStackTrace();
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }

    public static District find(int node,int language) throws SQLException
    {
        District obj = (District) _cache.get(node + ":" + language);
        if(obj == null)
        {
            obj = new District(node,language);
            _cache.put(node + ":" + language,obj);
        }
        return obj;
    }

    public static String getDetail(Node node,Http h,int listing,String target) throws SQLException
    {
        StringBuilder text = new StringBuilder();
        int _nNode = node._nNode;
        District obj = new District(_nNode,h.language);
        Span span = null;
        ListingDetail detail = ListingDetail.find(listing,83,h.language);
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
                value = node.getSubject(h.language);
            } else if("street".equals(name))
            {
                int street = obj.getStreet();
                if(street > 0)
                {
                    value = Street.find(street).getName();
                }
            } else if("content".equals(name))
            {
                value = node.getText(h.language);
            }
            int qu = detail.getQuantity(name);
            if(value != null && qu > 0 && value.length() > qu)
            {
                value = value.substring(0,qu) + " ...";
            }
            if(detail.getAnchor(name) != 0)
            {
                Anchor anchor = new Anchor("/servlet/District?node=" + _nNode + "&language=" + h.language,value);
                anchor.setTarget(target);
                span = new Span(anchor);
            } else
            {
                span = new Span(value);
            }
            span.setId("DistrictID" + name);
            text.append(detail.getBeforeItem(name)).append(span).append(detail.getAfterItem(name));
        }
        return text.toString();
    }

    public int getStreet()
    {
        return street;
    }

}
