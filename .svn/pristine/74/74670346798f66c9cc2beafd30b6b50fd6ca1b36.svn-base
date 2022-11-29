package tea.entity.node;

import java.math.*;
import java.util.*;

import tea.entity.*;
import tea.html.Anchor;
import tea.html.Span;
import tea.db.DbAdapter;
import tea.html.Text;
import java.sql.SQLException;
import tea.ui.TeaSession;

public class Contribute
{
    private static Cache _cache = new Cache(100);
    private int node;
    private int language;
    private String project;
    private boolean classes;
    private int belong;
    private BigDecimal moneycount;
    private Date time;
    private String photo;
    private String linkman;
    private String linkman2;
    private String phone;
    private String phone2;
    private String address;
    private String address2;
    private String postalcode;
    private String postalcode2;
    private String email;
    private String email2;
    private boolean exists;

    public static Contribute find(int node,int language) throws SQLException
    {
        Contribute obj = (Contribute) _cache.get(node + ":" + language);
        if(obj == null)
        {
            obj = new Contribute(node,language);
            _cache.put(node + ":" + language,obj);
        }
        return obj;
    }

    public Contribute(int node,int language) throws SQLException
    {
        this.node = node;
        this.language = language;
        loadBasic();
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            // int j = db.getInt("ContributeGetLanguage " + node + "," + language);
            int j = this.getLanguage(language);
            db.executeQuery("SELECT project    ,classes    ,belong     ,moneycount ,time       ,photo      ,linkman    ,linkman2   ,phone      ,phone2     ,address    ,address2   ,postalcode ,postalcode2,email      ,email2       FROM Contribute WHERE node= " + node + " AND language=" + j);
            if(db.next())
            {
                project = db.getVarchar(j,language,1);
                classes = db.getInt(2) != 0;
                belong = db.getInt(3);
                moneycount = db.getBigDecimal(4,2);
                time = db.getDate(5);
                photo = db.getString(6);
                linkman = db.getVarchar(j,language,7);
                linkman2 = db.getVarchar(j,language,8);
                phone = db.getString(9);
                phone2 = db.getString(10);
                address = db.getVarchar(j,language,11);
                address2 = db.getVarchar(j,language,12);
                postalcode = db.getString(13);
                postalcode2 = db.getString(14);
                email = db.getString(15);
                email2 = db.getString(16);
                exists = true;
            } else
            {
                exists = false;
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
            db.executeQuery("SELECT language FROM Contribute WHERE node=" + node);
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

    public void set(String project,boolean classes,int belong,java.math.BigDecimal moneycount,java.util.Date time,String photo,String linkman,String linkman2,String phone,String phone2,String address,String address2,String postalcode,String postalcode2,String email,String email2) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("UPDATE Contribute SET project =" + DbAdapter.cite(project) + ",classes  =" + (classes ? "1" : "0") + ",belong =" + (belong) + "     ,moneycount =" + (moneycount) + " ,time  =" + DbAdapter.cite(time) + ",photo=" + DbAdapter.cite(photo) + " ,linkman =" + DbAdapter.cite(linkman) + " ,linkman2 =" + DbAdapter.cite(linkman2) + "   ,phone  =" + DbAdapter.cite(phone) + "  ,phone2 =" + DbAdapter.cite(phone2) + " ,address  =" + DbAdapter.cite(address) + "    ,address2 ="
                                     + DbAdapter.cite(address2) + "   ,postalcode =" + DbAdapter.cite(postalcode) + " ,postalcode2=" + DbAdapter.cite(postalcode2) + ",email  =" + DbAdapter.cite(email) + " ,email2=" + DbAdapter.cite(email2) + "     WHERE node=" + node + " AND language=" + language);
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO Contribute(node,language,project    ,classes    ,belong     ,moneycount ,time       ,photo      ,linkman    ,linkman2   ,phone      ,phone2     ,address    ,address2   ,postalcode ,postalcode2,email      ,email2     )VALUES (" + node + "," + language + "," + DbAdapter.cite(project) + "    ," + (classes ? "1" : "0") + "    ," + (belong) + "     ," + (moneycount) + " ," + DbAdapter.cite(time) + "," + DbAdapter.cite(photo) + " ," + DbAdapter.cite(linkman)
                                 + "    ," + DbAdapter.cite(linkman2) + "   ," + DbAdapter.cite(phone) + "  ," + DbAdapter.cite(phone2) + "     ," + DbAdapter.cite(address) + "    ," + DbAdapter.cite(address2) + "   ," + DbAdapter.cite(postalcode) + " ," + DbAdapter.cite(postalcode2) + "," + DbAdapter.cite(email) + "," + DbAdapter.cite(email2) + "  )");
            }
            _cache.remove(node + ":" + language);
        } finally
        {
            db.close();
        }
    }

    public static String getDetail(Node node,Http h,int listing,String target,tea.resource.Resource r) throws SQLException
    {
        r.add("/tea/resource/Contribute");
        Span span = null;
        StringBuilder sb = new StringBuilder();
        Contribute obj = Contribute.find(node._nNode,h.language);
        ListingDetail detail = ListingDetail.find(listing,74,h.language);;
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
            } else if(itemname.equals("project"))
            {
                value = (obj.getProject());
            } else if(itemname.equals("classes"))
            {
                value = ((obj.isClasses() ? r.getString(h.language,"Unit") : r.getString(h.language,"Individual")));
            } else if(itemname.equals("belong"))
            {
                value = String.valueOf(obj.getBelong());
            } else if(itemname.equals("moneycount"))
            {
                value = (obj.getMoneycount().toString());
            } else if(itemname.equals("time"))
            {
                value = (obj.getTime("yyyy-MM-dd"));
            } else if(itemname.equals("photo"))
            {
                if(obj.getPhoto().length() > 0)
                {
                    value = (new tea.html.Image(obj.getPhoto()).toString());
                } else
                {
                    value = ("");
                }
            } else if(itemname.equals("linkman"))
            {
                value = (obj.getLinkman());
            } else if(itemname.equals("linkman2"))
            {
                value = (obj.getLinkman2());
            } else if(itemname.equals("phone"))
            {
                value = (obj.getPhone());
            } else if(itemname.equals("phone2"))
            {
                value = (obj.getPhone2());
            } else if(itemname.equals("address"))
            {
                value = (obj.getAddress());
            } else if(itemname.equals("address2"))
            {
                value = (obj.getAddress2());
            } else if(itemname.equals("postalcode"))
            {
                value = (obj.getPostalcode());
            } else if(itemname.equals("postalcode2"))
            {
                value = (obj.getPostalcode2());
            } else if(itemname.equals("email"))
            {
                value = (obj.getEmail());
            } else if(itemname.equals("email2"))
            {
                value = (obj.getEmail2());
            }
            if(detail.getAnchor(itemname) != 0)
            {
                Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/contribute/" + node._nNode + "-" + h.language + ".htm",value);
                anchor.setTarget(target);
                span = new Span(anchor);
            } else
            {
                span = new Span(value);
            }
            span.setId("ContributeID" + itemname);
            sb.append(detail.getBeforeItem(itemname)).append(span).append(detail.getAfterItem(itemname));
        }
        return sb.toString();
    }

    public String getProject()
    {
        return project;
    }

    public boolean isClasses()
    {
        return classes;
    }

    public int getBelong()
    {
        return belong;
    }

    public BigDecimal getMoneycount()
    {
        return moneycount;
    }

    public Date getTime()
    {
        return time;
    }

    public String getTime(String pattern)
    {
        if(time == null)
        {
            return "";
        }
        return new java.text.SimpleDateFormat(pattern).format(time);
    }

    public String getPhoto()
    {
        return photo;
    }

    public String getLinkman()
    {
        return linkman;
    }

    public String getLinkman2()
    {
        return linkman2;
    }

    public String getPhone()
    {
        return phone;
    }

    public String getPhone2()
    {
        return phone2;
    }

    public String getAddress()
    {
        return address;
    }

    public String getAddress2()
    {
        return address2;
    }

    public String getPostalcode()
    {
        return postalcode;
    }

    public String getPostalcode2()
    {
        return postalcode2;
    }

    public String getEmail()
    {
        return email;
    }

    public String getEmail2()
    {
        return email2;
    }

    public boolean isExists()
    {
        return exists;
    }

}
