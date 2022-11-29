package tea.entity.node;

import java.util.*;
import java.math.*;import tea.ui.*;
import tea.db.*;
import tea.entity.*;
import tea.html.*;
import java.sql.SQLException;
import java.sql.SQLException;

public class Travel extends Entity
{
    private static Cache _cache = new Cache(100);
    public static String ZHOUBIE_TYPE[] =
            {"zb_yazhou","zb_nanmzhou","zb_beimzhou","zb_ouzhou","zb_feizhou","zb_aozhou"};
    private int node;
    private int language;
    private Date stoptime; // 截至时间
    private int leixing; // 类型
    private String zhoubie; // 洲别
    private String tj_guojia; // 途径国家
    private String tj_chengshi; // 途径城市
    private String tj_jingdian; // 途径景点
    private Date leavetime;
    private String leavetext;
    private int counts;
    private java.math.BigDecimal price;
    private String priceexplain;
    private String priceinclude;
    private String pricenone;
    private String routing;
    private String service;
    private String explains;
    private String account;
    private boolean exists;
    private int hostel;
    private int flight;
    private String principal;
    private String picture;
    private String picture1;
    private String Type;
    private String locu;
    private String daycount;
    private String airways;

    public Travel(int node,int language) throws SQLException
    {
        this.node = node;
        this.language = language;
        load();
    }

    public static Travel find(int node,int language) throws SQLException
    {
        Travel obj = (Travel) _cache.get(node + ":" + language);
        if(obj == null)
        {
            obj = new Travel(node,language);
            _cache.put(node + ":" + language,obj);
        }
        return obj;
    }

    public void set(Date leavetime,String leavetext,int counts,float price,String priceexplain,String priceinclude,String pricenone,String routing,String service,String explains,String locu,String daycount,String airways,Date stoptime,String zhoubie,String tj_guojia,String tj_chengshi,String tj_jingdian,int leixing,String account,int hostel,int flight,String principal,String picture,String picture1) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("UPDATE Travel SET leavetime=" + DbAdapter.cite(leavetime) + ",leavetext=" + DbAdapter.cite(leavetext) + ",counts=" + (counts) + ",price=" + (price) + ",priceexplain=" + DbAdapter.cite(priceexplain) + ",priceinclude=" + DbAdapter.cite(priceinclude) + ",pricenone=" + DbAdapter.cite(pricenone) + ",routing=" + DbAdapter.cite(routing) + ",service=" + DbAdapter.cite(service) + ",explains=" + DbAdapter.cite(explains) + ",locu=" + DbAdapter.cite(locu) + ",daycount=" + DbAdapter.cite(daycount) + ",airways=" + DbAdapter.cite(airways)
                                     + ",stoptime=" + DbAdapter.cite(stoptime) + ",zhoubie=" + DbAdapter.cite(zhoubie) + ",tj_guojia=" + DbAdapter.cite(tj_guojia) + ",tj_chengshi=" + DbAdapter.cite(tj_chengshi) + ",tj_jingdian=" + DbAdapter.cite(tj_jingdian) + ",leixing=" + (leixing) + ",account=" + DbAdapter.cite(account) + ",hostel=" + hostel + ",flight=" + flight + ",principal=" + DbAdapter.cite(principal) + ",picture=" + DbAdapter.cite(picture) + ",picture1=" + DbAdapter.cite(picture1) + " WHERE node=" + node + " AND language=" + language);
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO Travel(node,language,leavetime,leavetext,counts,price,priceexplain,priceinclude,pricenone,routing,service,explains,locu,daycount,airways,stoptime,zhoubie,tj_guojia,tj_chengshi,tj_jingdian,leixing,account,hostel,flight,principal,picture,picture1)VALUES(" + node + "," + language + "," + DbAdapter.cite(leavetime) + "," + DbAdapter.cite(leavetext) + "," + (counts) + "," + (price) + "," + DbAdapter.cite(priceexplain) + "," + DbAdapter.cite(priceinclude) + "," + DbAdapter.cite(pricenone)
                                 + "," + DbAdapter.cite(routing) + "," + DbAdapter.cite(service) + "," + DbAdapter.cite(explains) + "," + DbAdapter.cite(locu) + "," + DbAdapter.cite(daycount) + "," + DbAdapter.cite(airways) + "," + DbAdapter.cite(stoptime) + "," + DbAdapter.cite(zhoubie) + "," + DbAdapter.cite(tj_guojia) + "," + DbAdapter.cite(tj_chengshi) + "," + DbAdapter.cite(tj_jingdian) + "," + (leixing) + "," + DbAdapter.cite(account) + "," + hostel + "," + flight + "," + DbAdapter.cite(principal) + "," + DbAdapter.cite(picture) + "," + DbAdapter.cite(picture1) + ")");
            }
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }

    private void load() throws SQLException
    {
        int j = getLanguage(language);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT leavetime,leavetext,counts,price ,priceexplain,priceinclude,pricenone,routing  ,service  ,explain  ,account ,hostel,flight,principal,picture,stoptime ,leixing ,zhoubie,tj_guojia,tj_chengshi,tj_jingdian,locu,daycount,airways,picture1     FROM Travel  WHERE node=" + node + " AND language=" + j);
            if(db.next())
            {
                leavetime = db.getDate(1);
                leavetext = db.getVarchar(j,language,2);
                counts = db.getInt(3);
                price = db.getBigDecimal(4,2);
                priceexplain = db.getVarchar(j,language,5);
                priceinclude = db.getVarchar(j,language,6);
                pricenone = db.getVarchar(j,language,7);
                routing = db.getVarchar(j,language,8);
                service = db.getVarchar(j,language,9);
                explains = db.getVarchar(j,language,10);
                account = db.getVarchar(j,language,11);
                hostel = db.getInt(12);
                flight = db.getInt(13);
                principal = db.getVarchar(j,language,14);
                picture = db.getVarchar(j,language,15);
                stoptime = db.getDate(16);
                leixing = db.getInt(17);
                zhoubie = db.getVarchar(j,language,18);
                tj_guojia = db.getVarchar(j,language,19);
                tj_chengshi = db.getVarchar(j,language,20);
                tj_jingdian = db.getVarchar(j,language,21);
                locu = db.getVarchar(j,language,22);
                daycount = db.getVarchar(j,language,23);
                airways = db.getVarchar(j,language,24);
                picture1 = db.getVarchar(j,language,25);
                // System.out.println(picture1+"图片");
                exists = true;
            } else
            {
                exists = false;
            }
        } catch(Exception exception)
        {
            exception.printStackTrace();
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
            db.executeQuery("SELECT language FROM Travel WHERE node=" + node);
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

    public int getNode()
    {
        return node;
    }

    public int getLanguage()
    {
        return language;
    }

    public Date getLeavetime()
    {
        return leavetime;
    }

    public Date getStoptime()
    {
        return stoptime;
    }

    public int getLeixing()
    {
        return leixing;
    }

    public String getLeixingToString() throws SQLException
    {
        if(leixing != 0)
        {
            TravelType tt = TravelType.find(leixing);
            if(tt.isExists())
            {
                return tt.getName();
            }
        }
        return "";
    }

    public String getZhoubie()
    {
        return zhoubie;
    }

    public String getTj_guojia()
    {
        return tj_guojia;
    }

    public String getTj_chengshi()
    {
        return tj_chengshi;
    }

    public String getTj_jingdian()
    {
        return tj_jingdian;
    }

    public String getLocu()
    {
        return locu;
    }

    public String getDaycount()
    {
        return daycount;
    }

    public String getAirways()
    {
        return airways;
    }

    public String getStoptimeToString()
    {
        return sdf.format(stoptime);
    }

    public String getLeavetimeToString()
    {
        return sdf.format(leavetime);
    }

    public String getLeavetext()
    {
        return leavetext;
    }

    public int getCounts()
    {
        return counts;
    }

    public BigDecimal getPrice()
    {
        if(price == null)
        {
            return new BigDecimal("0.00");
        }
        return price;
    }

    public String getPriceToString()
    {
        return String.valueOf(price);
    }

    public String getPriceexplain()
    {
        return priceexplain;
    }

    public String getPriceinclude()
    {
        return priceinclude;
    }

    public String getPricenone()
    {
        return pricenone;
    }

    public String getRouting()
    {
        return routing;
    }

    public String getService()
    {
        return service;
    }

    public String getExplain()
    {
        return explains;
    }

    public String getAccount()
    {
        return account;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getHostel()
    {
        return hostel;
    }

    public String getHostelToString() throws SQLException
    {
        if(hostel == 0 || !Node.isExisted(hostel))
        {
            return "";
        } else
        {
            return Node.find(hostel).getSubject(language);
        }
    }

    public String getFlightToString() throws SQLException
    {
        if(flight == 0 || !Node.isExisted(flight))
        {
            return "";
        } else
        {
            return Node.find(flight).getSubject(language);
        }
    }

    public int getFlight()
    {
        return flight;
    }

    public String getPrincipal()
    {
        return principal;
    }

    public String getPicture()
    {
        return picture;
    }

    public String getPicture1()
    {
        return picture1;
    }

    public static String getDetail(Node node,Http h,int listing,String target,tea.resource.Resource r) throws SQLException
    {
        StringBuilder text = new StringBuilder();
        Travel obj = Travel.find(node._nNode,h.language);
        Class c = obj.getClass();
        Span span = null;

        String subject = node.getSubject(h.language);
        ListingDetail detail = ListingDetail.find(listing,79,h.language);
        java.util.Iterator listingDetailEnumeration = detail.keys();
        while(listingDetailEnumeration.hasNext())
        {
            String itemname = (String) listingDetailEnumeration.next(),value = null;
            int istype = detail.getIstype(itemname);
            if(istype == 0)
            {
                continue;
            }
            Anchor anchor = null;
            if(itemname.equals("getSubject"))
            {
                value = (subject);
            } else if(itemname.equals("getZhoubie"))
            {
                if(obj.getZhoubie() != null)
                {
                    value = (obj.getZhoubie().toString());
                } else
                {
                    value = ("");
                }
            } else if(itemname.equals("getLeixing"))
            {
                value = (obj.getLeixingToString());
            } else if(itemname.equals("getTj_guojia"))
            {
                if(obj.getTj_guojia() != null)
                {
                    value = (obj.getTj_guojia().toString());
                } else
                {
                    value = ("");
                }
            } else if(itemname.equals("getLocu"))
            {
                if(obj.getLocu() != null)
                {
                    value = (obj.getLocu().toString());
                } else
                {
                    value = ("");
                }
            } else if(itemname.equals("getDaycount"))
            {
                if(obj.getDaycount() != null)
                {
                    value = (obj.getDaycount().toString());
                } else
                {
                    value = ("");
                }
            } else if(itemname.equals("getKeywords"))
            {
                if(node.getKeywords(h.language) != null)
                {
                    value = (node.getKeywords(h.language).toString());
                } else
                {
                    value = ("");
                }
            } else if(itemname.equals("getAirways"))
            {
                if(obj.getAirways() != null)
                {
                    value = (obj.getAirways().toString());
                } else
                {
                    value = ("");
                }
            } else if(itemname.equals("getTj_chengshi"))
            {
                if(obj.getTj_chengshi() != null)
                {
                    value = (obj.getTj_chengshi().toString());
                } else
                {
                    value = ("");
                }
            } else if(itemname.equals("getTj_jingdian"))
            {
                if(obj.getTj_jingdian() != null)
                {
                    value = (obj.getTj_jingdian().toString());
                } else
                {
                    value = ("");
                }
            } else if(itemname.equals("getText"))
            {
                if((node.getOptions() & 0x40L) == 0)
                {
                    value = (tea.html.Text.toHTML(node.getText2(h.language)));
                } else
                {
                    value = (node.getText2(h.language));
                }
            } else if(itemname.equals("getPicture"))
            {
                if(obj.getPicture() != null && obj.getPicture().length() > 0)
                {
                    value = (new tea.html.Image(obj.getPicture()).toString());
                } else
                {
                    value = (null);
                }
            } else if(itemname.equals("getPicture1"))
            {
                if(obj.getPicture1() != null && obj.getPicture1().length() > 0)
                {
                    value = (new tea.html.Image(obj.getPicture1()).toString());
                } else
                {
                    value = (null);
                }
            } else //
            if(itemname.equals("getBuybutton"))
            {
                tea.html.Button b = new tea.html.Button();
                b.setName("getBuybutton");
                b.setValue(r.getString(h.language,"Buy"));
                b.setOnClick("location='/servlet/EditTravelShopping?node=" + node._nNode + "&add=ON';");
                value = (b.toString());
            } else if(itemname.equals("getLeavetext")) // 发团时间
            {
                if(obj.getLeavetime() != null)
                {
                    value = (obj.getLeavetimeToString());
                } else
                {
                    value = (obj.getLeavetext());
                }
            } else if(itemname.equals("getStoptime")) // 截至时间
            {
                if(obj.getStoptime() != null)
                {
                    value = (obj.getStoptimeToString());
                } else
                {
                    value = ("");
                }
            } else
            {
                try
                {
                    java.lang.reflect.Method m = c.getMethod(itemname,(java.lang.Class[])null);
                    Object o = m.invoke(obj,(Object[])null);
                    if(o instanceof String)
                    {
                        value = ((String) m.invoke(obj,(Object[])null));
                    } else if(o instanceof Integer)
                    {
                        value = (((Integer) m.invoke(obj,(Object[])null)).toString());
                    }
                } catch(Exception e)
                {
                }
            }
            if(detail.getAnchor(itemname) != 0)
            {
                if(anchor == null)
                {
                    anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/travel/" + node._nNode + "-" + h.language + ".htm",value);
                }
                anchor.setTarget(target);
                span = new Span(anchor);
            } else
            {
                span = new Span(value);
            }
            span.setId("TravelID" + itemname);
            text.append(detail.getBeforeItem(itemname) + span + detail.getAfterItem(itemname));
        }
        return text.toString();
    }
}
