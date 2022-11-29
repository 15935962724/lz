package tea.entity.node;

import java.sql.*;
import java.util.*;
import tea.ui.*;
import tea.db.*;
import tea.entity.*;
import tea.html.*;
import java.util.Date;

/**
 * <p>
 * Title: 酒店的Bean对应着Hostel表
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2004
 * </p>
 *
 * @author EC37
 * @version 2004
 * *********************
 * @2008-2-18
 * ZhangJiinShu 修改
 */
public class Hostel extends Entity
{
    private static Cache _cache = new Cache(100);
    private int node;
    private int language = 1;
    private String name; //名称
    private int starClass; //星级
    private String phone; //电话
    private String fax; //传真
    private String contact; //联系人
    private String address; //地址
    private String postalcode; //邮编

//    private String city; //市(县)
//    private String borough; //市区
    private int city;
    private int borough;
    //地理位置:
    private float placeh; //距火车站
    private float placef; //距飞机场
    private float places; //距市中心
    private float placed; //距地铁站

    private String picture; //图片
    private String logo; //Logo 图片

    //特价：
    private String housexing; //房型
    private String price; //价格
    private Date timeyouxiao; //有效期
    private Date timeyouxiao2; //结束

    private String intro; //简介

    //酒店设施:
    private String diningroom; //餐　　厅
    private String commerce; //商务中心
    private String amusement; //娱乐中心
    private String emporium; //商　　场
    private String elses; //其　　他

    //多个酒店图片和多个房型
    private String DuoPicture;
    private String DuoHousexing;

    //付款方式:
    private int payment;
    private String paymenttext;

    public static String PAY_MENT[] =
            {"前台自付","担　　保","预　　付","代　　收","会员积分担保"};
    public static String STAR_CLASS[] =
            {"无要求","☆","☆☆","☆☆☆","☆☆☆☆","☆☆☆☆☆"};

    public String specialintro; //特价简介
    public String clew; //特殊提示

    public String member;

    private String map;
    private boolean _blLoaded;
    private int hostelID;


    private boolean exists;
    private static Cache c = new Cache(100);

    public static Hostel find(int node) throws SQLException
    {
        Hostel obj = (Hostel) c.get(node + "");
        if(obj == null)
        {
            obj = new Hostel(node);
            c.put(node + "",obj);
        }
        return obj;
    }

    //
    public Hostel(int node) throws SQLException
    {
        this.node = node;
        load();
    }

    //
    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT name,starClass,phone,fax,contact,address,postalcode,city,borough,placeh,placef,places,placed,picture,logo,housexing,price,timeyouxiao,intro,diningroom,commerce,amusement,emporium,elses,DuoPicture,DuoHousexing,payment,paymenttext,specialintro,clew,member,timeyouxiao2 FROM Hostel WHERE node=" + node);
            if(db.next())
            {

                name = db.getString(1);
                starClass = db.getInt(2);
                phone = db.getString(3);
                fax = db.getString(4);
                contact = db.getString(5);
                address = db.getString(6);
                postalcode = db.getString(7);
                city = db.getInt(8);
                borough = db.getInt(9);
                placeh = db.getFloat(10);
                placef = db.getFloat(11);
                places = db.getFloat(12);
                placed = db.getFloat(13);
                picture = db.getString(14);
                logo = db.getString(15);
                housexing = db.getString(16);
                price = db.getString(17);
                timeyouxiao = db.getDate(18);
                intro = db.getString(19);
                diningroom = db.getString(20);
                commerce = db.getString(21);
                amusement = db.getString(22);
                emporium = db.getString(23);
                elses = db.getString(24);
                DuoPicture = db.getString(25);
                DuoHousexing = db.getString(26);
                payment = db.getInt(27);
                paymenttext = db.getString(28);
                specialintro = db.getString(29);
                clew = db.getString(30);
                member = db.getString(31);
                timeyouxiao2 = db.getDate(32);
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

//-2008-2-18 zhangjinshu 修改
    public static void create(int node,int language,String name,int starClass,String phone,String fax,String contact,String address,String postalcode,int city,int borough,float placeh,float placef,float places,float placed,String picture,String logo,String housexing,String price,Date timeyouxiao,String intro,String diningroom,String commerce,String amusement,String emporium,String elses,String DuoPicture,String DuoHousexing,int payment,String paymenttext,String map,String specialintro,String clew,String member,Date timeyouxiao2) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Hostel(node,language,name,starClass,phone,fax,contact,address,postalcode,city,borough,placeh,placef,places,placed,picture,logo,housexing,price,timeyouxiao,intro,diningroom,commerce,amusement,emporium,elses,DuoPicture,DuoHousexing,payment,paymenttext,specialintro,clew,member,timeyouxiao2)VALUES(" + node + "," + language + "," + db.cite(name) + "," + starClass + "," + db.cite(phone) + "," + db.cite(fax) + "," + db.cite(contact) + "," + db.cite(address) + "," + db.cite(postalcode) + "," + (city) + "," + (borough) + "," + (placeh) + "," + placef + "," + places + "," + placed + "," + db.cite(picture) + "," + db.cite(logo) + "," + db.cite(housexing) + "," + db.cite(price) + "," + db.cite(timeyouxiao) + "," + db.cite(intro) + "," + db.cite(diningroom) +
                             "," +
                             db.cite(commerce) +
                             "," + db.cite(amusement) + "," + db.cite(emporium) + "," + db.cite(elses) + "," + db.cite(DuoPicture) + "," + db.cite(DuoHousexing) + "," + payment + "," + db.cite(paymenttext) + "," + db.cite(specialintro) + "," + db.cite(clew) + "," + db.cite(member) + "," + db.cite(timeyouxiao2) + "  )");
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }

    public void set(String name,int starClass,String phone,String fax,String contact,String address,String postalcode,int city,int borough,float placeh,float placef,float places,float placed,String picture,String logo,String housexing,String price,Date timeyouxiao,String intro,String diningroom,String commerce,String amusement,String emporium,String elses,String DuoPicture,String DuoHousexing,int payment,String paymenttext,String specialintro,String clew,String member,Date timeyouxiao2) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Hostel SET name=" + db.cite(name) + ",starClass=" + starClass + ",phone=" + db.cite(phone) + ",fax=" + db.cite(fax) + ",contact=" + db.cite(contact) + ",address=" + db.cite(address) + ",postalcode=" + db.cite(postalcode) + ",city=" + (city) + ",borough=" + (borough) + ",placeh=" + placeh + ",placef=" + placef + ",places=" + places + ",placed=" + placed + ",picture=" + db.cite(picture) + ",logo=" + db.cite(logo) + ",housexing=" + db.cite(housexing) + ",price=" + db.cite(price) + ",timeyouxiao=" + db.cite(timeyouxiao) + ",intro=" + db.cite(intro) + ",diningroom=" + db.cite(diningroom) + ",commerce=" + db.cite(commerce) + " ,amusement=" + db.cite(amusement) + ",emporium=" + db.cite(emporium) + ",elses=" + db.cite(elses) + " ,DuoPicture=" +
                             db.cite(DuoPicture) + ",DuoHousexing=" + db.cite(DuoHousexing) + ",payment=" + (payment) + ",paymenttext=" + db.cite(paymenttext) + ", specialintro=" + db.cite(specialintro) + ", clew=" + db.cite(clew) + ",member=" + db.cite(member) + ",timeyouxiao2=" + db.cite(timeyouxiao2) + "   WHERE node=" + node + " AND language=" + language);
        } finally
        {
            db.close();
        }
        this.name = name;
        this.starClass = starClass;
        this.phone = phone;
        this.fax = fax;
        this.contact = contact;
        this.address = address;
        this.postalcode = postalcode;
        this.city = city;
        this.borough = borough;
        this.placeh = placeh;
        this.placef = placef;
        this.places = places;
        this.placed = placed;
        this.picture = picture;
        this.logo = logo;
        this.housexing = housexing;
        this.price = price;
        this.timeyouxiao = timeyouxiao;
        this.intro = intro;
        this.diningroom = diningroom;
        this.commerce = commerce;
        this.amusement = amusement;
        this.emporium = emporium;
        this.elses = elses;
        this.DuoPicture = DuoPicture;
        this.DuoHousexing = DuoHousexing;
        this.payment = payment;
        this.paymenttext = paymenttext;
        this.specialintro = specialintro;
        this.clew = clew;
        this.member = member;
        this.timeyouxiao2 = timeyouxiao2;

    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();

        try
        {
            db.executeUpdate("DELETE FROM Hostel WHERE node=" + node);
        } catch(Exception ex)
        {
            ex.printStackTrace();
        } finally
        {
            db.close();
        }

    }

//@author hy:
    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {

            db.executeQuery("SELECT node FROM Hostel WHERE 1=1 " + sql,pos,size);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Enumeration findH2(String sql,int father,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT n.node FROM Node n,Hostel h WHERE n.node=h.node and n.father=" + father + " and n.hidden<>1" + sql.toString(),pos,size);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }


//@author huangyu
    public static int count(String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT count(*) FROM Hostel where 1=1 " + sql);

            if(db.next())
            {
                j = db.getInt(1);
            }

        } catch(Exception e)
        {
            throw new SQLException(e.toString());
        } finally
        {
            db.close();
        }
        return j;
    }

    public void set(String city,String address,String contact,String phone,String fax,String postalcode,String intro,int starClass,String picture,String map,String logo,String price) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Hostel SET city=" + DbAdapter.cite(city) + ",address=" + DbAdapter.cite(address) + ",name=" + DbAdapter.cite(contact) + ",phone=" + DbAdapter.cite(phone) + ",fax=" + DbAdapter.cite(fax) + ",postalcode=" + DbAdapter.cite(postalcode) + ",intro=" + DbAdapter.cite(intro) + ",starclass=" + (starClass) + ",picture=" + DbAdapter.cite(picture) + ",map=" + DbAdapter.cite(map) + ",logo=" + DbAdapter.cite(logo) + ",price=" + DbAdapter.cite(price) + " WHERE node=" + node
                             + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + this.language);
    }


    public int getNode() throws SQLException
    {
        return node;
    }

    public String getPicture() throws SQLException
    {
        return picture;
    }

    public int getHostelID() throws SQLException
    {
        return hostelID;
    }

    public String getName() throws SQLException
    {
        if(name == null)
        {
            return "";
        } else
        {
            return name;
        }
    }

    public String getAddress() throws SQLException
    {
        if(address == null)
        {
            return "";
        } else
        {
            return address;
        }
    }

    public String getPhone() throws SQLException
    {
        if(phone == null)
        {
            return "";
        } else
        {
            return phone;
        }
    }

    public String getFax() throws SQLException
    {
        if(fax == null)
        {
            return "";
        } else
        {
            return fax;
        }
    }

    public String getPostalcode() throws SQLException
    {
        if(postalcode == null)
        {
            return "";
        } else
        {
            return postalcode;
        }
    }

    public String getIntro() throws SQLException
    {
        if(intro == null)
        {
            return "";
        } else
        {
            return intro;
        }
    }

    public int getCity()
    {
        return city;
    }

    public String getMember()
    {
        if(member == null)
        {
            return "";
        } else
        {
            return member;
        }
    }

    public int getStarClass() throws SQLException
    {
        return starClass;
    }

    public String getStarClassToString() throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        for(int i = getStarClass();i > 0;i--)
        {
            sb.append("☆");
        }
        return sb.toString();
    }


    public Hostel(int node,int language) throws SQLException
    {
        this.node = node;
        this.language = language;
        loadBasic();
    }


    public static Hostel find(int node,int language) throws SQLException
    {
        Hostel obj = (Hostel) _cache.get(node + ":" + language);
        if(obj == null)
        {
            obj = new Hostel(node,language);
            _cache.put(node + ":" + language,obj);
        }
        return obj;
    }

    private void loadBasic() throws SQLException
    {
        if(!_blLoaded)
        {
            int j = this.getLanguage(language);
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT name,starClass,phone,fax,contact,address,postalcode,city,borough,placeh,placef,places,placed,picture,logo,housexing,price,timeyouxiao,intro,diningroom,commerce,amusement,emporium,elses,DuoPicture,DuoHousexing,payment,paymenttext,specialintro,clew,member,timeyouxiao2 FROM Hostel WHERE node=" + node + " AND language=" + j);
                if(db.next())
                {

                    name = db.getString(1);
                    starClass = db.getInt(2);
                    phone = db.getString(3);
                    fax = db.getString(4);
                    contact = db.getString(5);
                    address = db.getString(6);
                    postalcode = db.getString(7);
                    city = db.getInt(8);
                    borough = db.getInt(9);
                    placeh = db.getFloat(10);
                    placef = db.getFloat(11);
                    places = db.getFloat(12);
                    placed = db.getFloat(13);
                    picture = db.getString(14);
                    logo = db.getString(15);
                    housexing = db.getString(16);
                    price = db.getString(17);
                    timeyouxiao = db.getDate(18);
                    intro = db.getString(19);
                    diningroom = db.getString(20);
                    commerce = db.getString(21);
                    amusement = db.getString(22);
                    emporium = db.getString(23);
                    elses = db.getString(24);
                    DuoPicture = db.getString(25);
                    DuoHousexing = db.getString(26);
                    payment = db.getInt(27);
                    paymenttext = db.getString(28);
                    specialintro = db.getString(29);
                    clew = db.getString(30);
                    member = db.getString(31);
                    timeyouxiao2 = db.getDate(32);

                    exists = true;
                } else
                {
                    exists = false;
                }
            } finally
            {
                db.close();
            }
            _blLoaded = true;
        }
    }

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language FROM Hostel WHERE node=" + node);
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

    public String getContact()
    {
        if(contact == null)
        {
            return "";
        } else
        {
            return contact;
        }
    }

    public String getLogo()
    {
        return logo;
    }

    public int getLanguage()
    {
        return language;
    }

    public String getMap()
    {
        return map;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getPrice()
    {
        if(price == null)
        {
            return "";
        } else
        {
            return price;
        }
    }

    public int getBorough()
    {
        if(borough == 0)
        {
            return 0;
        } else
        {
            return borough;
        }

    }

    public float getPlaced()
    {
        if(placed == 0)
        {
            return 0;
        } else
        {
            return placed;
        }
    }

    public float getPlacef()
    {
        return placef;
    }

    public float getPlaceh()
    {
        return placeh;
    }

    public float getPlaces()
    {
        return places;
    }

    public String getAmusement()
    {
        if(amusement == null)
        {
            return "";
        } else
        {
            return amusement;
        }
    }

    public String getCommerce()
    {
        if(commerce == null)
        {
            return "";
        } else
        {
            return commerce;
        }
    }

    public String getDiningroom()
    {
        if(diningroom == null)
        {
            return "";
        } else
        {
            return diningroom;
        }
    }

    public String getElses()
    {
        if(elses == null)
        {
            return "";
        } else
        {
            return elses;
        }

    }

    public String getEmporium()
    {
        if(emporium == null)
        {
            return "";
        } else
        {
            return emporium;
        }
    }

    public String getHousexing()
    {
        if(housexing == null)
        {
            return "";
        } else
        {
            return housexing;
        }
    }

    public int getPayment()
    {
        return payment;
    }

    public String getPaymenttext()
    {
        if(paymenttext == null)
        {
            return "";
        } else
        {
            return paymenttext;
        }
    }

    public Date getTimeyouxiao()
    {

        return timeyouxiao;
    }

    public String getTimeyouxiaoToString()
    {
        if(timeyouxiao == null)
        {
            return "";
        }
        return sdf.format(timeyouxiao);
    }


    public Date getTimeyouxiao2()
    {

        return timeyouxiao2;
    }

    public String getTimeyouxiaoToString2()
    {
        if(timeyouxiao2 == null)
        {
            return "";
        }
        return sdf.format(timeyouxiao2);
    }


    public String getDuoPicture()
    {
        if(DuoPicture == null)
        {
            return "";
        } else
        {
            return DuoPicture;
        }
    }

    public String getDuoHousexing()
    {
        if(DuoHousexing == null)
        {
            return "";
        } else
        {
            return DuoHousexing;
        }
    }

    public String getSpecialintro()
    {
        if(specialintro == null)
        {
            return "";
        } else
        {
            return specialintro;
        }
    }

    public String getClew()
    {
        if(clew == null)
        {
            return "";
        } else
        {
            return clew;
        }
    }


    // this.getServletContext().getRealPath()
    public static String getDetail(Node node,Http h,int listing,String target,tea.resource.Resource r) throws SQLException
    {
        StringBuilder htm = new StringBuilder();
        Hostel hostel = Hostel.find(node._nNode,h.language);

        Class c = hostel.getClass();
        ListingDetail detail = ListingDetail.find(listing,48,h.language);
        java.util.Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = null;
            int istype = detail.getIstype(name);
            if(istype == 0)
            {
                continue;
            }
            if(name.equals("Name")) //名字
            {
                int qu = detail.getQuantity(name);
                if(qu != 0)
                {
                    if(node.getSubject(h.language).length() > qu)
                    {
                        value = node.getSubject(h.language).substring(0,qu) + "..........";
                    } else
                    {
                        value = node.getSubject(h.language);
                    }
                } else
                {
                    value = node.getSubject(h.language);
                }
            } else if(name.equals("getPlaceh")) //距火车站
            {
                value = String.valueOf(hostel.getPlaceh());
            } else if(name.equals("getPlacef")) //距飞机场
            {
                value = String.valueOf(hostel.getPlacef());
            } else if(name.equals("getPlaces")) //距市中心
            {
                value = String.valueOf(hostel.getPlaces());
            } else if(name.equals("getPlaced")) //距地铁
            {
                value = String.valueOf(hostel.getPlaced());
            } else if(name.equals("DuoHousexing")) //多个房型
            {
                value = ("<include src=\"/jsp/type/hostel/ListingRoomPrice.jsp?node=" + node._nNode + "\"/>");
            } else if(name.equals("destine")) //特价房型预定
            {
                value = "<input value=预定 type=\"image\" src=\"/res/jiudian/u/0804/yuding.gif\" onClick=\"window.open('/jsp/type/hostel/EditDestine.jsp?node=" + node._nNode + "&roomprice=0')\" >  ";
            } else if(name.equals("getIntro")) //酒店简介
            {
                if(detail.getQuantity(name) != 0)
                {
                    if(hostel.getIntro().length() > detail.getQuantity(name))
                    {
                        value = hostel.getIntro().substring(0,detail.getQuantity(name)) + "..........";
                    } else
                    {
                        value = hostel.getIntro();
                    }
                } else
                {
                    value = hostel.getIntro();
                }
            } else if(name.equals("getSpecialintro")) //特价简介
            {
                if(detail.getQuantity(name) != 0)
                {
                    if(hostel.getSpecialintro().length() > detail.getQuantity(name))
                    {
                        value = hostel.getSpecialintro().substring(0,detail.getQuantity(name)) + "..........";
                    } else
                    {
                        value = hostel.getSpecialintro();
                    }
                } else
                {
                    value = hostel.getSpecialintro();
                }
            } else if(name.equals("logo"))
            {
                if(hostel.getLogo() != null && hostel.getLogo().length() > 0)
                {
                    value = (new Image(hostel.getLogo()).toString());
                } else
                {
                    value = (null);
                }
            } else if(name.equals("map")) //地图
            {
                // if (hostel.getMap() != null && hostel.getMap().length() > 0)
                // {
                // value=(new tea.html.Button("map", r.getString(language, "CBMap"), "javascript:window.showModalDialog('" + hostel.getMap() + "','','edge:raised;status:0;help:0;resizable:1;dialogWidth:609px;dialogHeight:507px;');").toString()); // +9 +27
                // } else
                // {
                // value=(null);
                // }
                StringBuilder sb = new StringBuilder();
                sb.append("<object classid=clsid:8AD9C840-044E-11D1-B3E9-00805F499D93 codebase=http://java.sun.com/update/1.5.0/jinstall-1_5-windows-i586.cab#Version=5,0,0,7 WIDTH=400 HEIGHT=300 >");
                sb.append("<PARAM NAME=CODE VALUE=ptviewer.class >");
                sb.append("<PARAM NAME=ARCHIVE VALUE=/tea/applet/ptviewer.jar>");
                sb.append("<param name=type value=application/x-java-applet;version=1.5>");
                sb.append("<param name=scriptable value=false>");
                sb.append("<PARAM NAME=file VALUE=/test.jpg>");
                sb.append("<PARAM NAME=cursor VALUE=MOVE>");
                sb.append("<PARAM NAME=pan VALUE=-105>");
                sb.append("<PARAM NAME=showToolbar VALUE=true>");
                sb.append("<PARAM NAME=imgLoadFeedback VALUE=false>");
                sb.append("<PARAM NAME=hotspot0 VALUE=\"X21.3 Y47.7 u'Sample27L2.htm' n'Hotspot description'\">");
                sb.append("<PARAM NAME=wait VALUE=/res/chinaserve/u/0710/071040557.jpg>");
                sb.append("</object>");
                value = (sb.toString());
                // <applet code="ptviewer.class" archive="/tea/applet/ptviewer.jar" width=400 height=300>
                // <param name=file value="/test.jpg">
                // <param name=cursor value="MOVE">
                // <param name=pan value=-105>
                // <param name=showToolbar value="true">
                // <param name=imgLoadFeedback value="false">
                // <param name=hotspot0 value="X21.3 Y47.7 u'Sample27L2.htm' n'Hotspot description'">
                // <PARAM name=wait value="/res/chinaserve/u/0710/071040557.jpg">
                // </applet>
            } else if(name.equals("bp")) // 大图
            {
                if(hostel.getPicture() != null && hostel.getPicture().length() > 0)
                {
                    value = (new Image(hostel.getPicture()).toString());
                } else
                {
                    value = (null);
                }
            } else if(name.equals("getStarClass")) // 星级
            {
                value = (hostel.getStarClassToString());
            } else //
            if(name.equals("getPrice"))
            {
                value = (String.valueOf(hostel.getPrice()));
            } else if(name.equals("getTimeyouxiao"))
            {
                value = hostel.getTimeyouxiaoToString();
            }

            else if(name.equals("text")) // 内容
            {
                if((node.getOptions() & 0x40L) == 0)
                {
                    value = (Text.toHTML(node.getText2(h.language)));
                } else
                {
                    value = (node.getText2(h.language));
                }
            } else if(name.equals("DuoPicture")) //多个图片
            {
                java.util.Enumeration enumer = TypePicture.findByNode(node._nNode);
                while(enumer.hasMoreElements())
                {
                    int id = ((Integer) enumer.nextElement()).intValue();
                    TypePicture tp = TypePicture.findByPrimaryKey(id);
                    String img = new tea.html.Image(tp.getPicture(),tp.getPicname()).toString();
                    Span span;
                    if(detail.getAnchor(name) != 0)
                    {
                        if(tp.getPicture2() != null && tp.getPicture2().length() > 0)
                        {
                            Anchor anchor = new Anchor("javascript:window.showModalDialog('" + tp.getPicture2() + "','self','edge:raised;status:0;help:0;resizable:1;dialogWidth:" + (tp.getWidth() + 9) + "px;dialogHeight:" + (tp.getHeight() + 27) + "px;')",img);
                            span = new Span(anchor);
                            span.setId("HostelIDPicture");
                            htm.append(detail.getBeforeItem(name)).append(span).append(detail.getAfterItem(name));
                        }
                    } else
                    {
                        span = new Span(img);
                        span.setId("HostelIDPicture");
                        htm.append(detail.getBeforeItem(name)).append(span).append(detail.getAfterItem(name));
                    }
                }
            } else if(name.equals("PictureName")) //图片名字
            {
                java.util.Enumeration enumer = TypePicture.findByNode(node._nNode);
                while(enumer.hasMoreElements())
                {
                    int id = ((Integer) enumer.nextElement()).intValue();
                    TypePicture tp = TypePicture.findByPrimaryKey(id);
                    Span span = new Span(tp.getPicname());
                    span.setId("HostelIDPictureName");
                    htm.append(detail.getBeforeItem(name)).append(span).append(detail.getAfterItem(name));
                }
            } else
            {
                try
                {
                    java.lang.reflect.Method m = c.getMethod(name,(java.lang.Class[])null);
                    value = ((String) m.invoke(hostel,(Object[])null));
                } catch(Exception ex)
                {
                    value = (null);
                }
            }
            if(!name.equals("Picture") && !name.equals("PictureName"))
            {
                if(detail.getAnchor(name) != 0)
                {
                    Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/hostel/" + node._nNode + "-" + h.language + ".htm",value);
                    anchor.setTarget(target);
                    value = anchor.toString();
                }
                Span span = new Span(value);
                span.setId("HostelID" + name);
                htm.append(detail.getBeforeItem(name)).append(span).append(detail.getAfterItem(name));
            }
        }
        return htm.toString();
    }

//    public void setBorough(String borough)
//    {
//        this.borough = borough;
//    }
//
//    public void setPlaces(float places)
//    {
//        this.places = places;
//    }
//
//    public void setPlaceh(float placeh)
//    {
//        this.placeh = placeh;
//    }
//
//    public void setPlacef(float placef)
//    {
//        this.placef = placef;
//    }
//
//    public void setPlaced(float placed)
//    {
//        this.placed = placed;
//    }

}
