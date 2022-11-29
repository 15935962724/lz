package tea.entity.node;

import java.sql.SQLException;
import tea.db.DbAdapter;
import tea.entity.*;

import tea.html.Anchor;
import tea.html.Span;
import tea.html.Text;
import tea.ui.*;

import java.util.*;

public class EarthKavass
{
    private static Cache _cache = new Cache(100);
    private int node;
    private int language;
    private String name;
    private String address;
    private String zip;
    private String phone;
    private String fax;
    private String email;
    private boolean exists;

    public static EarthKavass find(int node,int language) throws SQLException
    {
        EarthKavass obj = (EarthKavass) _cache.get(node + ":" + language);
        if(obj == null)
        {
            obj = new EarthKavass(node,language);
            _cache.put(node + ":" + language,obj);
        }
        return obj;
    }

    public EarthKavass(int node,int language) throws SQLException
    {
        this.node = node;
        this.language = language;
        loadBasic();
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            // int j=dbadapter.getInt("EarthKavassGetLanguage "+node+","+language);
            int j = this.getLanguage(language);
            dbadapter.executeQuery("SELECT name   ,address,zip    ,phone  ,fax    ,email   FROM EarthKavass WHERE node= " + node + " AND language=" + j);
            if(dbadapter.next())
            {
                name = dbadapter.getVarchar(j,language,1);
                address = dbadapter.getVarchar(j,language,2);
                zip = dbadapter.getString(3);
                phone = dbadapter.getString(4);
                fax = dbadapter.getString(5);
                email = dbadapter.getString(6);
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            dbadapter.close();
        }
    }

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT language FROM EarthKavass WHERE node=" + node);
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

    public void set(String name,String address,String zip,String phone,String fax,String email) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            // dbadapter.executeUpdate("EarthKavassEdit " + node + "," + language + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(address) + "," + DbAdapter.cite(zip) + "," + DbAdapter.cite(phone) + "," + DbAdapter.cite(fax) + "," + DbAdapter.cite(email));
            dbadapter.executeQuery("SELECT node FROM EarthKavass WHERE node=" + node + " AND language=" + language);
            if(dbadapter.next())
            {
                dbadapter.executeUpdate("UPDATE EarthKavass SET name    =" + DbAdapter.cite(name) + "    ,address =" + DbAdapter.cite(address) + " ,zip     =" + DbAdapter.cite(zip) + "     ,phone   =" + DbAdapter.cite(phone) + "   ,fax     =" + DbAdapter.cite(fax) + "     ,email   =" + DbAdapter.cite(email) + "   WHERE node=" + node + " AND language=" + language);
            } else
            {
                dbadapter.executeUpdate("INSERT INTO EarthKavass(node,language,name   ,address,zip    ,phone  ,fax    ,email  )VALUES(" + node + "," + language + "," + DbAdapter.cite(name) + "   ," + DbAdapter.cite(address) + "," + DbAdapter.cite(zip) + "    ," + DbAdapter.cite(phone) + "  ," + DbAdapter.cite(fax) + "    ," + DbAdapter.cite(email) + "   )");
            }

            _cache.remove(node + ":" + language);
        } finally
        {
            dbadapter.close();
        }
    }

    public static String getDetail(Node node,Http h,int listing,String target,tea.resource.Resource r) throws SQLException
    {
        // r.add("tea/resource/EarthKavass");
        Span span = null;
        StringBuilder sb = new StringBuilder();
        EarthKavass obj = EarthKavass.find(node._nNode,h.language);
        ListingDetail detail = ListingDetail.find(listing,77,h.language);
        java.util.Iterator enumeration = detail.keys();
        while(enumeration.hasNext())
        {
            String itemname = (String) enumeration.next(),value = null;
            int istype = detail.getIstype(itemname);
            if(istype == 0)
            {
                continue;
            }
            if(itemname.equals("subject"))
            {
                value = (node.getSubject(h.language));
            } else if(itemname.equals("text"))
            {
                value = (node.getText2(h.language));
            } else if(itemname.equals("name"))
            {
                value = (obj.getName());
            } else

            if(itemname.equals("address"))
            {
                value = ((obj.getAddress()));
            } else if(itemname.equals("zip"))
            {
                value = (obj.getFax());
            } else if(itemname.equals("phone"))
            {
                value = (obj.getPhone());
            } else if(itemname.equals("fax"))
            {
                value = (obj.getFax());
            } else if(itemname.equals("email"))
            {
                value = (obj.getEmail());
            }
            if(detail.getAnchor(itemname) != 0)
            {
                Anchor anchor = new Anchor("/servlet/EarthKavass?node=" + node + "&language=" + h.language,value);
                anchor.setTarget(target);
                span = new Span(anchor);
            } else
            {
                span = new Span(value);
            }
            span.setId("EarthKavassID" + itemname);
            sb.append(detail.getBeforeItem(itemname) + span + detail.getAfterItem(itemname));
        }
        return sb.toString();
    }

    public int getNode()
    {
        return node;
    }

    public int getLanguage()
    {
        return language;
    }

    public String getName()
    {
        return name;
    }

    public String getAddress()
    {
        return address;
    }

    public String getZip()
    {
        return zip;
    }

    public String getPhone()
    {
        return phone;
    }

    public String getFax()
    {
        return fax;
    }

    public String getEmail()
    {
        return email;
    }

    public boolean isExists()
    {
        return exists;
    }
}
