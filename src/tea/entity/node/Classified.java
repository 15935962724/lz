package tea.entity.node;

import java.util.Enumeration;
import java.util.Hashtable;

import tea.db.DbAdapter;
import tea.entity.*;
import tea.db.*;
import tea.html.Text;
import tea.html.Button;
import java.util.*;
import java.sql.SQLException;

public class Classified extends Entity
{
    class Layer
    {
        String _strContact;
        String _strEmail;
        String _strOrganization;
        String _strAddress;
        String _strCity;
        String _strState;
        String _strZip;
        String _strCountry;
        String _strTelephone;
        String _strFax;
        String _strWebPage;
        int _nWebLanguage;

        Layer()
        {
        }
    }


    public String getOrganization(int i) throws SQLException
    {
        return getLayer(i)._strOrganization;
    }

    public String getAddress(int i) throws SQLException
    {
        return getLayer(i)._strAddress;
    }

    public String getZip(int i) throws SQLException
    {
        return getLayer(i)._strZip;
    }

    public void set(int i,String s,String s1,String s2,String s3,String s4,String s5,String s6,String s7,String s8,String s9,String s10,int j) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            // dbadapter.executeUpdate("ClassifiedEdit " + _nNode + ", " + i + ", " + DbAdapter.cite(s) + "," +
            // " " + DbAdapter.cite(s1) + ", " + DbAdapter.cite(s2) + ", " + DbAdapter.cite(s3) + ", "
            // + DbAdapter.cite(s4) + ", " + DbAdapter.cite(s5) + ", " + DbAdapter.cite(s6) + ", " +
            // "" + DbAdapter.cite(s7) + ", " + DbAdapter.cite(s8) + ", " + DbAdapter.cite(s9) + "," +
            // " " + DbAdapter.cite(s10) + ", " + j);
            dbadapter.executeQuery("SELECT node  FROM ClassifiedLayer  WHERE node=" + _nNode + " AND language=" + i);
            if(dbadapter.next())
            {
                dbadapter.executeUpdate("UPDATE ClassifiedLayer SET contact=" + DbAdapter.cite(s) + ",email=" + DbAdapter.cite(s1) + ",organization=" + DbAdapter.cite(s2) + ",address=" + DbAdapter.cite(s3) + ",city=" + DbAdapter.cite(s4) + ",state=" + DbAdapter.cite(s5) + ",zip=" + DbAdapter.cite(s6) + ",country=" + DbAdapter.cite(s7) + ",telephone=" + DbAdapter.cite(s8) + ",fax=" + DbAdapter.cite(s9) + ",webpage=" + DbAdapter.cite(s10) + ",  weblanguage=" + j + " WHERE node=" + _nNode
                                        + "  AND language=" + i);
            } else
            {
                dbadapter.executeUpdate("INSERT INTO ClassifiedLayer (node, language, contact, email, organization, address, city, state, zip, country, telephone, fax, webpage, weblanguage)VALUES (" + _nNode + ", " + i + ", " + DbAdapter.cite(s) + ", " + DbAdapter.cite(s1) + ", " + DbAdapter.cite(s2) + ", " + DbAdapter.cite(s3) + ", " + DbAdapter.cite(s4) + ", " + DbAdapter.cite(s5) + ", " + DbAdapter.cite(s6) + ", " + DbAdapter.cite(s7) + ", " + DbAdapter.cite(s8) + ", " + DbAdapter.cite(s9)
                                        + ", " + DbAdapter.cite(s10) + ", " + j + ")");
            }
        } finally
        {
            dbadapter.close();
        }
        _htLayer.clear();
    }

    public String getState(int i) throws SQLException
    {
        return getLayer(i)._strState;
    }

    private Classified(int i)
    {
        _nNode = i;
        _htLayer = new Hashtable();
    }

    public boolean isLayerExisted(int i) throws SQLException
    {
        boolean flag = false;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT node  FROM ClassifiedLayer  WHERE node=" + _nNode + " AND language=" + i);
            flag = dbadapter.next();
        } finally
        {
            dbadapter.close();
        }
        return flag;
    }

    public String getTelephone(int i) throws SQLException
    {
        return getLayer(i)._strTelephone;
    }

    public String getFax(int i) throws SQLException
    {
        return getLayer(i)._strFax;
    }

    public String getWebPage(int i) throws SQLException
    {
        return getLayer(i)._strWebPage;
    }

    public int getWebLanguage(int i) throws SQLException
    {
        return getLayer(i)._nWebLanguage;
    }

    private Layer getLayer(int i) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(new Integer(i));
        if(layer == null)
        {
            layer = new Layer();
            DbAdapter dbadapter = new DbAdapter();
            try
            {
                // int j = dbadapter.getInt("ClassifiedGetLanguage " + _nNode + ", " + i);
                int j = this.getLanguage(i);

                dbadapter.executeQuery(" SELECT contact, email, organization, address, city, state, zip, country, telephone, fax, webpage, weblanguage  FROM ClassifiedLayer  WHERE node=" + _nNode + " AND language=" + j);
                if(dbadapter.next())
                {
                    layer._strContact = dbadapter.getVarchar(j,i,1);
                    layer._strEmail = dbadapter.getString(2);
                    layer._strOrganization = dbadapter.getVarchar(j,i,3);
                    layer._strAddress = dbadapter.getVarchar(j,i,4);
                    layer._strCity = dbadapter.getVarchar(j,i,5);
                    layer._strState = dbadapter.getVarchar(j,i,6);
                    layer._strZip = dbadapter.getString(7);
                    layer._strCountry = dbadapter.getVarchar(j,i,8);
                    layer._strTelephone = dbadapter.getString(9);
                    layer._strFax = dbadapter.getString(10);
                    layer._strWebPage = dbadapter.getString(11);
                    layer._nWebLanguage = dbadapter.getInt(12);
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
            dbadapter.executeQuery("SELECT language FROM ClassifiedLayer WHERE node=" + _nNode);
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
            dbadapter.executeUpdate("DELETE FROM ClassifiedLayer  WHERE node=" + _nNode + " AND language=" + i);
        } finally
        {
            dbadapter.close();
        }
        _htLayer.remove(new Integer(i));
    }

    public static Classified find(int i)
    {
        Classified classified = (Classified) _cache.get(new Integer(i));
        if(classified == null)
        {
            classified = new Classified(i);
            _cache.put(new Integer(i),classified);
        }
        return classified;
    }

    public String getCity(int i) throws SQLException
    {
        return getLayer(i)._strCity;
    }

    public String getCountry(int i) throws SQLException
    {
        return getLayer(i)._strCountry;
    }

    public String getEmail(int i) throws SQLException
    {
        return getLayer(i)._strEmail;
    }

    public String getContact(int i) throws SQLException
    {
        return getLayer(i)._strContact;
    }

    public static Enumeration getDetail(Node node,int listing,tea.ui.TeaSession teasession) throws SQLException
    {
        int language = teasession._nLanguage;
        java.util.Vector vector = new java.util.Vector();

        tea.resource.Resource r = new tea.resource.Resource("/tea/ui/node/type/classified/EditClassified");
        Classified classified = Classified.find(node._nNode);
        ListingDetail detail = ListingDetail.find(listing,21,language);
        Iterator e = detail.keys();
        while(e.hasNext())
        {
            String itemname = (String) e.next(),value = null;
            int istype = detail.getIstype(itemname);
            if(istype == 0)
            {
                continue;
            }
            if(itemname.equals("Name"))
            {
                value = (node.getSubject(language));
            } else if(itemname.equals("Intro"))
            {
                if((node.getOptions() & 0x40L) == 0) // TEXT
                {
                    value = (Text.toHTML(node.getText(language)));
                } else
                {
                    // HTML
                    value = (node.getText(language));
                }
            } else if(itemname.equals("CorpJob"))
            {
                java.util.Enumeration enumeration = Job.findByOrg(node._nNode);
                int nodecode;
                StringBuilder sb = new StringBuilder();
                while(enumeration.hasMoreElements())
                {
                    nodecode = ((Integer) enumeration.nextElement()).intValue();
                    Job job = Job.find(nodecode,language);
                    node = Node.find(nodecode);
                    tea.html.Div div = new tea.html.Div("<A ID=JobIDName HREF=\"/servlet/Job?node=" + nodecode + "\">" + job.getName() + "</A><SPAN ID=JobIDSltLocId>" + job.getLocIdToHtml() + "</SPAN><SPAN ID=JobIDValidity>" + job.getValidityDateToString() + "</SPAN><SPAN ID=JobIDTxtHeadCount>" + job.getHeadCount() + "</SPAN>");
                    div.setId("CompanyIDCorpJobSub");
                    sb.append(div.toString()); // (new java.text.SimpleDateFormat("yyyy-MM-dd")).format(node.getTime()) + " <A HREF=\"/servlet/Job?node=" + nodecode + "\">" + job.getName() + "</A>&nbsp;" + job.getSltLocId("&nbsp;"));
                }
                value = (sb.toString());
            } else if(itemname.equals("Contact"))
            {
                value = (classified.getContact(language));
            } else if(itemname.equals("CorpJobButton"))
            {
                value = ("<INPUT TYPE=BUTTON VALUE=" + r.getString(language,"CorpJob") + " onClick=\"window.open('/servlet/Node?node=" + node._nNode + "')\"/>");
            } else if(itemname.equals("EditButton"))
            {
                String param = teasession.getQueryString();
                if(param == null)
                {
                    param = "";
                }
                value = ("<INPUT TYPE=BUTTON VALUE=" + r.getString(language,"Edit") + " onClick=\"window.open('/servlet/EditNode?node=" + node._nNode + "&nexturl=" + teasession.getRequestURI() + "?" + param + "', '_self')\"/>");
            } else if(itemname.equals("DeleteButton"))
            {
                String param = teasession.getQueryString();
                if(param == null)
                {
                    param = "";
                }
                value = ("<INPUT TYPE=\"BUTTON\" VALUE=" + r.getString(language,"CBDeleteNode") + " onClick=\"if(confirm('" + r.getString(language,"ConfirmDeleteTree") + "')){window.open('/servlet/DeleteNode?node=" + node._nNode + "&nexturl=" + teasession.getRequestURI() + "?" + param + "', '_self');}\"/>");
            } else if(itemname.equals("EmailAddress"))
            {
                value = (classified.getEmail(language));
            } else if(itemname.equals("Organization"))
            {
                value = (classified.getOrganization(language));
            } else if(itemname.equals("Address"))
            {
                value = (classified.getAddress(language));
            } else if(itemname.equals("City"))
            {
                value = (classified.getCity(language));
            } else if(itemname.equals("State"))
            {
                value = (classified.getState(language));
            } else if(itemname.equals("Zip"))
            {
                value = (classified.getZip(language));
            } else if(itemname.equals("Country"))
            {
                value = (classified.getCountry(language));
            } else if(itemname.equals("Telephone"))
            {
                value = (classified.getTelephone(language));
            } else if(itemname.equals("Fax"))
            {
                value = (classified.getFax(language));
            } else if(itemname.equals("WebPage"))
            {
                value = (classified.getWebPage(language));
            } else if(itemname.equals("WebLanguage"))
            {
                value = String.valueOf(classified.getWebLanguage(language));
            }
            if(value != null)
            {
                vector.addElement(detail);
            }
        }
        return vector.elements();
    }

    private int _nNode;
    private Hashtable _htLayer;
    private static Cache _cache = new Cache(100);

}
