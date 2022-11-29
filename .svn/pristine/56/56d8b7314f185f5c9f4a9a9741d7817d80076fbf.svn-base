package tea.entity.node;

import tea.ui.*;
import tea.db.*;
import tea.entity.*;
import tea.html.Anchor;
import tea.html.Span;
import tea.html.Text;
import java.util.*;
import java.sql.SQLException;

public class GreenManufacture
{
    private static Cache _cache = new Cache(100);
    private String faren;
    private String companyadd;
    private String postalcode;
    private String quality;
    private String ep;
    private String medal;
    private String attestation;
    private String company;
    private String content;
    private String linkman;
    private String phone;
    private String fax;
    private String email;
    private String remark;
    private int node;
    private int language;
    private boolean exists;
    private String brand;

    public static GreenManufacture find(int node,int language) throws SQLException
    {
        GreenManufacture obj = (GreenManufacture) _cache.get(node + ":" + language);
        if(obj == null)
        {
            obj = new GreenManufacture(node,language);
            _cache.put(node + ":" + language,obj);
        }
        return obj;
    }

    public GreenManufacture(int node,int language) throws SQLException
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
            // int j = dbadapter.getInt("GreenManufactureGetLanguage " + node + "," + language);
            int j = this.getLanguage(language);
            dbadapter.executeQuery("SELECT faren      ,companyadd ,postalcode   ,quality    ,ep         ,medal      ,attestation,company    ,content    ,linkman    ,phone      ,fax        ,email      ,remark,brand    FROM GreenManufacture WHERE node= " + node + " AND language=" + j);
            if(dbadapter.next())
            {
                faren = dbadapter.getVarchar(j,language,1);
                companyadd = dbadapter.getVarchar(j,language,2);
                postalcode = dbadapter.getString(3);
                quality = dbadapter.getVarchar(j,language,4);
                ep = dbadapter.getVarchar(j,language,5);
                medal = dbadapter.getVarchar(j,language,6);
                attestation = dbadapter.getVarchar(j,language,7);
                company = dbadapter.getVarchar(j,language,8);
                content = dbadapter.getVarchar(j,language,9);
                linkman = dbadapter.getVarchar(j,language,10);
                phone = dbadapter.getString(11);
                fax = dbadapter.getString(12);
                email = dbadapter.getString(13);
                remark = dbadapter.getVarchar(j,language,14);
                brand = dbadapter.getString(15);
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
            dbadapter.executeQuery("SELECT language FROM GreenManufacture WHERE node=" + node);
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

    public void set(String faren,String companyadd,String postalcode,String quality,String ep,String medal,String attestation,String company,String content,String linkman,String phone,String fax,String email,String remark,String brand) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            // dbadapter.executeUpdate("GreenManufactureEdit " + node + "," + language + "," + DbAdapter.cite(faren)
            // + "," + DbAdapter.cite(companyadd) + "," + DbAdapter.cite(postalcode)
            // + "," + DbAdapter.cite(quality) + "," + DbAdapter.cite(ep)
            // + "," + DbAdapter.cite(medal) + "," + DbAdapter.cite(attestation)
            // + "," + DbAdapter.cite(company) + "," + DbAdapter.cite(content) + "," +
            // DbAdapter.cite(linkman) + "," + DbAdapter.cite(phone) + "," +
            // DbAdapter.cite(fax) + "," + DbAdapter.cite(email) + "," +
            // DbAdapter.cite(remark) + "," + DbAdapter.cite(brand));
            dbadapter.executeQuery("SELECT node FROM GreenManufacture WHERE node=" + node + " AND language=" + language);
            if(dbadapter.next())
            {
                dbadapter.executeUpdate("UPDATE GreenManufacture  SET  faren= " + DbAdapter.cite(faren) + ",companyadd = " + DbAdapter.cite(companyadd) + " 	,postalcode = " + DbAdapter.cite(postalcode) + " ,quality= " + DbAdapter.cite(quality) + ",ep = " + DbAdapter.cite(ep) + " ,medal= " + DbAdapter.cite(medal) + ",attestation= " + DbAdapter.cite(attestation) + ",company= " + DbAdapter.cite(company) + ",content= " + DbAdapter.cite(content) + ",linkman= " + DbAdapter.cite(linkman) + "	,phone= "
                                        + DbAdapter.cite(phone) + "	,fax= " + DbAdapter.cite(fax) + ",email= " + DbAdapter.cite(email) + "	,remark = " + DbAdapter.cite(remark) + " ,brand= " + DbAdapter.cite(brand) + "   WHERE node=" + node + " AND language=" + language);
            } else
            {
                dbadapter.executeUpdate("INSERT INTO GreenManufacture(node,language,faren      ,companyadd ,postalcode   ,quality    ,ep         ,medal      ,attestation,company    ,content    ,linkman    ,phone      ,fax        ,email      ,remark ,brand )VALUES(" + node + "," + language + "," + DbAdapter.cite(faren) + "," + DbAdapter.cite(companyadd) + " ," + DbAdapter.cite(postalcode) + "   ," + DbAdapter.cite(quality) + "    ," + DbAdapter.cite(ep) + "       ," + DbAdapter.cite(medal)
                                        + "      ," + DbAdapter.cite(attestation) + "," + DbAdapter.cite(company) + "   ," + DbAdapter.cite(content) + "    ," + DbAdapter.cite(linkman) + "    ," + DbAdapter.cite(phone) + "     ," + DbAdapter.cite(fax) + " ," + DbAdapter.cite(email) + "      ," + DbAdapter.cite(remark) + " ," + DbAdapter.cite(brand) + " )");
            }
            _cache.remove(node + ":" + language);
        } finally
        {
            dbadapter.close();
        }
    }

    public static String getDetail(Node node,Http h,int listing,String target,tea.resource.Resource r) throws SQLException
    {
        r.add("tea/resource/GreenManufacture");
        Span span = null;
        StringBuilder sb = new StringBuilder();
        GreenManufacture obj = GreenManufacture.find(node._nNode,h.language);
        ListingDetail detail = ListingDetail.find(listing,76,h.language);
        java.util.Iterator e = detail.keys();
        while(e.hasNext())
        {
            String itemname = (String) e.next(),value = null;
            int istype = detail.getIstype(itemname);
            if(istype == 0)
            {
                continue;
            }
            if(itemname.equals("subject"))
            {
                value = (node.getSubject(h.language));
            } else if(itemname.equals("faren"))
            {
                value = (obj.getFaren());
            } else if(itemname.equals("postalcode"))
            {
                value = ((obj.getPostalcode()));
            } else if(itemname.equals("fax"))
            {
                value = (obj.getFax());
            } else if(itemname.equals("phone"))
            {
                value = (obj.getPhone());
            } else if(itemname.equals("companyadd"))
            {
                value = (obj.getCompanyadd());
            } else if(itemname.equals("quality"))
            {
                value = (obj.getQuality());
            } else if(itemname.equals("ep"))
            {
                value = (obj.getEp());
            } else if(itemname.equals("medal"))
            {
                value = (obj.getMedal());
            } else if(itemname.equals("attestation"))
            {
                value = (obj.getAttestation());
            } else if(itemname.equals("company"))
            {
                value = (obj.getCompany());
            } else if(itemname.equals("text"))
            {
                value = (node.getText2(h.language));
            } else if(itemname.equals("content"))
            {
                value = (obj.getContent());
            } else if(itemname.equals("linkman"))
            {
                value = (obj.getLinkman());
            } else if(itemname.equals("email"))
            {
                value = (obj.getEmail());
            } else if(itemname.equals("remark"))
            {
                value = (obj.getRemark());
            } else if(itemname.equals("brand"))
            {
                if(obj.getBrand().length() > 0)
                {
                    value = (new tea.html.Image(obj.getBrand()).toString());
                } else
                {
                    value = ("");
                }
            }
            if(detail.getAnchor(itemname) != 0)
            {
                Anchor anchor = new Anchor("/servlet/GreenManufacture?node=" + node + "&language=" + h.language,value);
                anchor.setTarget(target);
                span = new Span(anchor);
            } else
            {
                span = new Span(value);
            }
            span.setId("GreenManufactureID" + itemname);
            sb.append(detail.getBeforeItem(itemname) + span + detail.getAfterItem(itemname));
        }
        return sb.toString();
    }

    public String getFaren()
    {
        return faren;
    }

    public String getCompanyadd()
    {
        return companyadd;
    }

    public String getPostalcode()
    {
        return postalcode;
    }

    public String getQuality()
    {
        return quality;
    }

    public String getEp()
    {
        return ep;
    }

    public String getMedal()
    {
        return medal;
    }

    public String getAttestation()
    {
        return attestation;
    }

    public String getCompany()
    {
        return company;
    }

    public String getContent()
    {
        return content;
    }

    public String getLinkman()
    {
        return linkman;
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

    public String getRemark()
    {
        return remark;
    }

    public int getNode()
    {
        return node;
    }

    public int getLanguage()
    {
        return language;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getBrand()
    {
        return brand;
    }
}
