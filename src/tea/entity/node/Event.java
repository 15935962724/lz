package tea.entity.node;

import java.util.*;
import tea.ui.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.admin.map.GMap;
import tea.entity.site.License;

import java.text.SimpleDateFormat;
import tea.html.*;
import tea.resource.Common;

import java.io.IOException;
import java.sql.SQLException;

public class Event extends Entity
{
    private static Cache _cache = new Cache(100);
    private int node;
    private String name;
    private Date timeStart; //活动开始时间
    private Date timeStop; //活动结束时间
    private Date timeHoldStart; //活动的举行时间
    private Date timeHoldStop; //活动额举行结束时间
    private int nightShop;
    private String request;
    private String prescribe; //特殊规定--在威斯特中是 参会资格
    private String synopsis; //
    private String organise; //组织人 -------===负责人
    private String linkman; //组织者联系方式 ---联系电话
    private String corp; //组织者所属公司 ----==组织单位
    private String carfare; //门票价格 -------活动预算
    private String feature; //特殊 -----------======参会个人需缴纳的费用
    private String introPicture; //介绍图片:======小图片 --
    private String flyerData;
    private String localePicture;
    private String localePicture2;
    private String localePicture3;
    private int language;
    private boolean _bLoad;
    private Date time = null;
    private boolean exist;
    private String sort;
    private String bigPicture; //大图
    private int city; //活动所在区域--红丝带中用到的只有北京的地区
    private String regmember; //报名活动的志愿者
    private float integral; //活动所需积分


    private String subtitle; //活动副标题
    private String lead; //导语
    private String province; //省
    private String city2; //市
    private String address; //详细地址
    private int eventtype; //活动类别
    private int catering; //是否安排餐饮 0是，1 否
    private int stay; //是否安排住宿
    private int shuttle; //是否安排接送
    private String map; //地图标点
    public String serShops;
    private int album; //关联组图类


    public static String AUDIT_TYPE[] =
            {"活动筹备中","正在报名","活动报名已结束","正在进行","已举行"};


    public static String PROVINCEP_TYPE[] =
            {"北京市","上海市","天津市","重庆市","河北省","山西省","内蒙古自治区","辽宁省","吉林省","黑龙江省","江苏省","浙江省","安徽省",
            "福建省","江西省","山东省","河南省","湖北省","湖南省","广东省","广西壮族自治区","海南省","四川省","贵州省","云南省","西藏自治区","陕西省",
            "甘肃省","宁夏回族自治区","青海省","新疆维吾尔族自治区","香港特别行政区","澳门特别行政区","台湾省"};

    public static String CITYS[] =
            {"东城","西城","崇文","宣武","朝阳","海淀","丰台","石景山","门头沟","房山","昌平","大兴","顺义","通州","怀柔","密云","平谷","延庆"};

    public static String EVENT_TYPE[] =
            {"-活动类别-","培训","竞赛","会议","考察参观","拜访","其它"};

    public Event(int node,int language) throws SQLException
    {
        this.node = node;
        this.language = language;
        load();
    }


    public Event create() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Event(node,name,timeStart,timeStop,nightShop,sort,request,prescribe,synopsis,organise,linkman,corp,carfare,feature," +
                             "introPicture,flyerData,time,localePicture,localePicture2,localePicture3,language,city,integral," +
                             " subtitle,lead,province,city2,address,eventtype,catering,stay,shuttle,map,timeHoldStart,timeHoldStop) VALUES (" + node + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(timeStart) + "," + DbAdapter.cite(timeStop) + "," + (nightShop) + "," + DbAdapter.cite(sort) + "," + DbAdapter.cite(request) + "," + DbAdapter.cite(prescribe) + "," + DbAdapter.cite(synopsis) + ","
                             + DbAdapter.cite(organise) + "," + DbAdapter.cite(linkman) + "," + DbAdapter.cite(corp) + "," + DbAdapter.cite(carfare) + "," + DbAdapter.cite(feature) + "," +
                             "" + DbAdapter.cite(introPicture) + "," + DbAdapter.cite(flyerData) + "," + DbAdapter.cite(time) + "," + DbAdapter.cite(this.bigPicture) + "," +
                             "" + DbAdapter.cite(localePicture2) + "," + DbAdapter.cite(localePicture3) + "," + language + "," + city + "," + integral + "," +
                             "  " + db.cite(subtitle) + "," + db.cite(lead) + "," + db.cite(province) + "," + db.cite(city2) + "," + db.cite(address) + "," + eventtype + "," + catering + "," + stay + "," + shuttle + "," + db.cite(map) + "," +
                             " " + db.cite(timeHoldStart) + "," + db.cite(timeHoldStop) + " )");
        } finally
        {
            db.close();
        }
        this.exist = true;
        _cache.remove(node + ":" + language);
        return this;
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Event SET name=" + db.cite(name) + ",timeStart=" + db.cite(timeStart) + ",timeStop=" + db.cite(timeStop) + ",nightShop=" + (nightShop) + ",sort=" + db.cite(sort) + ",request=" + DbAdapter.cite(request) + ",prescribe=" + DbAdapter.cite(prescribe) + ",synopsis=" + DbAdapter.cite(synopsis) + ",organise=" + DbAdapter.cite(organise) + ",linkman=" + DbAdapter.cite(linkman) + ",corp=" + DbAdapter.cite(corp) + ",carfare=" + DbAdapter.cite(carfare)
                             + ",feature=" + db.cite(feature) + ",flyerData=" + db.cite(flyerData) + ",introPicture=" + db.cite(introPicture) + "" +
                             ", localePicture=" + db.cite(this.bigPicture) + ",localePicture2=" + db.cite(localePicture2) + ",localePicture3=" + db.cite(localePicture3) + "" +
                             ",time=" + db.cite(time) + ",city=" + city + ",integral=" + integral + "" +
                             ",subtitle=" + db.cite(subtitle) + ",lead=" + db.cite(lead) + ",province=" + db.cite(province) + " ,city2=" + db.cite(city2) + "" +
                             ",address=" + db.cite(address) + ",eventtype=" + eventtype + ",catering=" + catering + ",stay=" + stay + ",shuttle=" + shuttle + " ,map=" + db.cite(map) + " " +
                             ", timeHoldStart=" + db.cite(timeHoldStart) + ",timeHoldStop=" + db.cite(timeHoldStop) + " WHERE node=" + node + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }
    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Event SET " + f + "=" + DbAdapter.cite(v) + " WHERE node=" + node);
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }
    public void setRegmember() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Event SET regmember=" + DbAdapter.cite(regmember) + " WHERE node=" + node + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }

    public void setAlbum(int album) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Event SET album=" + album + " WHERE node=" + node + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }


    public static Event find(int node,int language) throws SQLException
    {
        Event obj = (Event) _cache.get(node + ":" + language);
        if(obj == null)
        {
            obj = new Event(node,language);
            _cache.put(node + ":" + language,obj);
        }
        return obj;
    }

    public static boolean exists(int year,int month,int day,int language) throws SQLException
    {
        String strMonth = String.valueOf(month);
        if(strMonth.length() == 1)
        {
            strMonth = "0" + strMonth;
        }
        String strDay = String.valueOf(day);
        if(strDay.length() == 1)
        {
            strDay = "0" + strDay;
        }
        boolean bool = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM Event WHERE timename(yy,timeStart) ='" + year + "' and timename(mm,timeStart) ='" + strMonth + "' and timename(dd,timeStart) ='" + strDay + "' and language=" + language);
            bool = (db.next());
        } finally
        {
            db.close();
        }
        return bool;
    }


    public void load() throws SQLException
    {
        // if (!_bLoad)
        {
            int j = this.getLanguage(language);
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT name,timeStart,timeStop,nightShop,request,prescribe,synopsis,1,organise,linkman,corp, carfare , " +
                                " feature,introPicture,flyerData ,localePicture,localePicture2,localePicture3,time,sort,city,regmember,integral," +
                                " subtitle, lead, province, city2,address, eventtype,catering, stay,  shuttle,map,timeHoldStart,timeHoldStop,album,serShops FROM Event WHERE node=" + node + " AND language=" + j);
                if(db.next())
                {
                    name = db.getVarchar(j,language,1);
                    timeStart = db.getDate(2);
                    timeStop = db.getDate(3);
                    nightShop = db.getInt(4);
                    request = db.getVarchar(j,language,5);
                    prescribe = db.getVarchar(j,language,6);
                    synopsis = db.getText(j,language,7);
                    organise = db.getVarchar(j,language,9);
                    linkman = db.getVarchar(j,language,10);
                    corp = db.getVarchar(j,language,11);
                    carfare = db.getVarchar(j,language,12);
                    feature = db.getVarchar(j,language,13);
                    introPicture = db.getString(14);
                    flyerData = db.getVarchar(j,language,15);
                    // localePicture = db.getString(16);
                    bigPicture = db.getString(16);
                    localePicture2 = db.getString(17);
                    localePicture3 = db.getString(18);
                    time = db.getDate(19);
                    sort = db.getVarchar(j,language,20);
                    city = db.getInt(21);
                    regmember = db.getString(22);
                    integral = db.getFloat(23);
                    subtitle = db.getString(24);
                    lead = db.getString(25);
                    province = db.getString(26);
                    city2 = db.getString(27);
                    address = db.getString(28);
                    eventtype = db.getInt(29);
                    catering = db.getInt(30);
                    stay = db.getInt(31);
                    shuttle = db.getInt(32);
                    map = db.getString(33);
                    timeHoldStart = db.getDate(34);
                    timeHoldStop = db.getDate(35);
                    album = db.getInt(36);
                    serShops= db.getString(37);
                    exist = true;
                } else
                {
                    exist = false;
                    sort = name = request = regmember = prescribe = synopsis = organise = linkman = corp = carfare = feature = introPicture = flyerData = localePicture = localePicture2 = localePicture3 = "";
                }
            } finally
            {
                db.close();
            }
            _bLoad = true;
        }
    }

    public void delete(int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Event WHERE node=" + node + " AND language=" + language);

        }

        finally
        {
            db.close();
        }
        _cache.clear();
    }

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language FROM Event WHERE node=" + node);
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


    public static String getDetail(Node node,Http h,Listing listing,String target) throws SQLException,IOException
    {
        int iListing = listing.getListing();
        Event event = Event.find(node._nNode,h.language);
        StringBuilder text = new StringBuilder();

        Span span = null;
        ListingDetail detail = ListingDetail.find(iListing,37,h.language);
        java.util.Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = null;
            int istype = detail.getIstype(name);
            if(istype == 0)
            {
                continue;
            }
            if(name.equals("introPicture")) //介绍图片 小图
            {
                if(event.getBigPicture() != null && event.getBigPicture().length() > 0)
                {
                    Image image = new Image(event.getBigPicture());
                    // image.setWidth(65);
                    // image.setHeight(90);
                    value = (image.toString());
                }
            } else if(name.equals("smallPicture")) // 大图
            {

                if(event.getIntroPicture() != null && event.getIntroPicture().length() > 0)
                {
                    value = (new Image(event.getIntroPicture()).toString());
                }
            } else if(name.equals("bigPicture"))
            {
                if(event.getBigPicture() != null && event.getBigPicture().length() > 0)
                {
                    value = (new Image(event.getBigPicture()).toString());
                }
            } else if(name.equals("nightShop"))
            {
                value = (Node.find(event.getNightShop()).getSubject(h.language));
            } else if(name.equals("synopsis"))
            {
                value = (event.getSynopsis());
            } else if(name.equals("issueTime"))
            {
                value = (event.getDateToString());
            } else if(name.equals("TPicture"))
            {
                java.util.Enumeration enumer = TypePicture.findByNode(node._nNode);
                while(enumer.hasMoreElements())
                {
                    int id = ((Integer) enumer.nextElement()).intValue();
                    TypePicture tp = TypePicture.findByPrimaryKey(id);
                    String img = new tea.html.Image(tp.getPicture(),tp.getPicname()).toString();
                    if(detail.getAnchor(name) != 0 && (tp.getPicture2() != null && tp.getPicture2().length() > 0))
                    {
                        Anchor anchor = new Anchor("javascript:window.showModalDialog('" + tp.getPicture2() + "','self','edge:raised;help:0;resizable:1;dialogWidth:" + (tp.getWidth() + 9) + "px;dialogHeight:" + (tp.getHeight() + 27 + 20) + "px;')",img);
                        span = new Span(anchor);
                        span.setId("EventIDPicture");
                    } else
                    {
                        span = new Span(img);
                        span.setId("EventIDPicture");

                    }
                    Span span_name = new Span(tp.getPicname());
                    span_name.setId("EventIDPictureName");
                    text.append(detail.getBeforeItem(name)).append(span).append(span_name).append(detail.getAfterItem(name));
                }
                continue;
            } else if("rstarttime".equals(name)) //报名开始时间
            {
                if(event.getTimeStart() != null)
                {
                    value = Entity.sdf.format(event.getTimeStart());
                }
            } else if("rstoptime".equals(name)) //报名结束时间
            {
                if(event.getTimeStop() != null)
                {
                    value = Entity.sdf.format(event.getTimeStop());
                }
            } else
            /*
             * if (name.equals("PictureName")) { StringBuilder sb = new StringBuilder(); java.util.Enumeration enumer = TypePicture.findByNode(node._nNode); while (enumer.hasMoreElements()) { int id = ((Integer) enumer.nextElement()).intValue(); TypePicture tp = TypePicture.findByPrimaryKey(id); span = new Span(tp.getPicname()); span.setId("EventIDPictureName"); sb.append(detail.getBeforeItem() + span + detail.getAfterItem()); } text.append(sb.toString()); continue; } else
             */
            if(name.equals("time")) //开始时间
            {
                if(event.getTimeStart() != null)
                {
                    SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
                    // if (sdf.format(event.getTimeStart()).equals("00:00") && sdf.format(event.getTimeStart()).equals("00:00"))
                    // {
                    sdf = new SimpleDateFormat("yyyy-MM-dd");
                    value = (new String(sdf.format(event.getTimeStart())));
                    // + " -- " + sdf.format(event.getTimeStop()));
                    // } else
                    // {
                    // sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                    // name = new String(sdf.format(event.getTimeStart()) + " -- " + sdf.format(event.getTimeStop()));
                    // }
                }
                // if (event.getTimeStart().length() > 0 && event.getTimeStop().length() > 0)
                // name = new String(event.getTimeStart() + " -- " + event.getTimeStop());
            } else if("TimeStop".equals(name)) //活动结束时间
            {
                if(event.getTimeStop() != null)
                {
                    value = Entity.sdf.format(event.getTimeStop());
                }
            }else if("hold".equals(name))//活动举行时间
			{
				value = "<span class='start'>"+MT.f(event.timeHoldStart)+"</span><span class='stop'>"+ MT.f(event.timeHoldStop)+"</span>";
			}else if("album".equals(name))
            {
                //关联组图
                if(event.getAlbum() > 0 && node.getAudit() == 4)
                {
                    value = "<script>var a_node=" + event.getAlbum() + ",a_father=" + Node.find(event.getAlbum()).getFather() + ";</script>" + Filex.read(Common.REAL_PATH + "/jsp/type/album/AlbumModule.htm","utf-8");

                }
            } else if("album_subject".equals(name))
            {
                if(event.getAlbum() > 0 && node.getAudit() == 4)
                {
                    value = Node.find(event.getAlbum()).getSubject(h.language);
                }
            } else if("album_text".equals(name))
            {
                if(event.getAlbum() > 0 && node.getAudit() == 4)
                {
                    value = Node.find(event.getAlbum()).getText(h.language);
                }
            } else if("score".equals(name)) //评价
            {
                if(node.getAudit() == 4)
                {
                    value = "<iframe frameborder=0 name=eventalbumid id=eventalbumid  scrolling=no src='/jsp/type/event/WestracEventScoreStat.jsp?node=" + node._nNode + "'></iframe>";
                }

            }

            else if(name.equals("name")) //活动标题
            {

                value = (node.getSubject(h.language));
            } else if(name.equals("subtitle")) //副标题
            {
                value = event.getSubtitle();
            } else if(name.equals("lead")) //导语
            {
                value = event.getLead();
            } else if(name.equals("province")) //省
            {
                value = event.getProvince();
            } else if(name.equals("city2")) //市
            {
                value = event.getCity2();
            } else if(name.equals("address")) //详细地址
            {
                value = event.getAddress();
            } else if(name.equals("eventtype")) //活动类别
            {
                if(event.getEventtype() > 0)
                {
                    value = event.EVENT_TYPE[event.getEventtype()];
                }
            } else if(name.equals("integral")) //活动积分
            {
                value = String.valueOf(event.getIntegral());
            } else if(name.equals("prescribe"))
            {
                value = (event.getPrescribe());
            } else if(name.equals("content")) // 内容简介
            {
                value = node.getText(h.language);
            } else if(name.equals("corp")) //组织者所属公司(组织单位 )
            {
                value = (event.getCorp());
            } else if(name.equals("organise")) //组织人（负责人）
            {
                value = (event.getOrganise());
            } else if(name.equals("linkman")) //组织者联系方式(联系电话)
            {
                value = (event.getLinkman());
            } else if(name.equals("carfare")) // 门票价格(活动预算)
            {
                value = (event.getCarfare());
            } else if(name.equals("feature")) //特色(参会个人需缴纳的费用)
            {
                value = (event.getFeature());
            } else if(name.equals("catering")) //是否安排餐饮
            {
                if(event.getCatering() == 0)
                {
                    value = "是";
                } else
                {
                    value = "否";
                }
            } else if(name.equals("stay")) //是否安排住宿
            {
                if(event.getStay() == 0)
                {
                    value = "是";
                } else
                {
                    value = "否";
                }
            } else if(name.equals("shuttle")) //是否安排接送
            {
                if(event.getShuttle() == 0)
                {
                    value = "是";
                } else
                {
                    value = "否";
                }
            } else if(name.equals("map"))
            {

                String map = event.getMap();

                if(map != null && map.length() > 0)
                {

                    String url = "/jsp/admin/map/ViewGMap.jsp?node=" + node._nNode + "&amp;point=" + map;
                    //  if(boolAnchor == 0)
                    //  {
                    value = "<iframe src=" + url + " frameborder='0' scrolling='no' width='250' height='250'></iframe>";
                    // } else
                    //  {
                    //  v = "<input type='button' value='" + r.getString(h.language,"CBMap") + "' onclick=\"window.open('" + url + "','_blank','width=600,height=500');\" />";
                    // }
                }
                //  boolAnchor = 0;

            } else if(name.equals("auditstatus")) //报名状态
            {
                value = event.AUDIT_TYPE[node.getAudit()];
            } else if(name.equals("audit")) //我要报名
            {
                if(node.getAudit() == 1)
                {

                    value = " <SCRIPT LANGUAGE=JAVASCRIPT SRC=\"/tea/ym/ymPrompt.js\" ></SCRIPT><link href=\"/tea/ym/skin/dmm-green/ymPrompt.css\" rel=\"stylesheet\" type=\"text/css\">";

                    value = value + "<input type=button id=auditbuttonid value=我要报名  onclick=ymPrompt.win({message:'/jsp/type/event/WestracEventRegistration.jsp?show=show&node=" + node._nNode + "',width:700,height:650,title:'活动报名表',handler:function(){},maxBtn:false,minBtn:false,iframe:true});> ";

                    //value=value+"<input type=button id=auditbuttonid value=我要报名  onclick=window.open('/jsp/type/event/WestracEventRegistration.jsp?show=show&node="+node._nNode+"','_blank');> ";
                }
            } else if(name.equals("audit1")) //我要报名无需登陆
            {
                if(node.getAudit() == 1)
                {

                    value = " <SCRIPT LANGUAGE=JAVASCRIPT SRC=\"/tea/ym/ymPrompt.js\" ></SCRIPT><link href=\"/tea/ym/skin/dmm-green/ymPrompt.css\" rel=\"stylesheet\" type=\"text/css\">";

                    value = value + "<input type=button id=auditbuttonid value=我要报名  onclick=ymPrompt.win({message:'/jsp/type/event/WestracEventRegistration1.jsp?show=show&node=" + node._nNode + "',width:700,height:650,title:'活动报名表',handler:function(){},maxBtn:false,minBtn:false,iframe:true});> ";

                    //value=value+"<input type=button id=auditbuttonid value=我要报名  onclick=window.open('/jsp/type/event/WestracEventRegistration.jsp?show=show&node="+node._nNode+"','_blank');> ";
                }
            }

            else if(name.equals("sort"))
            {
                value = (event.getSort());
            } else if(name.equals("request"))
            {
                value = (event.getRequest());
            } else if(name.equals("intro"))
            {
                value = (node.getText2(h.language));
            } else if(name.equals("flyerData"))
            {
                value = (event.getFlyerData());
            } else if(name.equals("localePicture"))
            {
                value = (event.getLocalePicture());
            } else if(name.equals("localePicture2"))
            {
                value = (event.getLocalePicture2());
            } else if(name.equals("localePicture3"))
            {
                value = (event.getLocalePicture3());
            } else
            {
                // System.out.println("活动类:" + name);
                continue;
            }
            int qu = detail.getQuantity(name);
            if(value != null && qu > 0 && value.length() > qu)
            {
                value = value.substring(0,qu) + " ...";
            }
            if(detail.getAnchor(name) != 0)
            {
                Anchor anchor = null;
                switch(detail.getAnchor(name))
                {
                case 1:
                    anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/event/" + node._nNode + "-" + h.language + ".htm",value);
                    anchor.setTarget(target);
                    span = new Span(anchor);
                    break;
                case 2: // IntroPicture
                    String ip = event.getIntroPicture();
                    if(ip != null && ip.length() > 0)
                    {
                        anchor = new Anchor("###",new Text(value),"javascript:window.open('about:blank','','height=300,width=400,top=200,left=300,toolbar=no,menubar=no,scrollbars=no, location=no, status=no').document.write('<img src=" + ip + " onload=window.resizeTo(this.width+30,this.height+50) >');"); // status:0;
                        span = new Span(anchor);
                    } else
                    {
                        span = new Span(value);
                    }
                    break;
                case 3: // bigPictrue
                    String bp = event.getBigPicture();
                    if(bp != null && bp.length() > 0)
                    {
                        anchor = new Anchor("###",new Text(value),"javascript:window.open('about:blank','','height=300,width=400,top=200,left=300,toolbar=no,menubar=no,scrollbars=no, location=no, status=no').document.write('<img src=" + bp + " onload=window.resizeTo(this.width+30,this.height+50) >');"); // status:0;
                        span = new Span(anchor);
                    } else
                    {
                        span = new Span(value);
                    }
                    break;
                case 4:
                    if(value != null)
                    {
                        anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/nightshop/" + event.getNightShop() + "-" + h.language + ".htm",value);
                        anchor.setTarget(target);
                        span = new Span(anchor);
                    } else
                    {
                        span = new Span("");
                    }
                    break;
                }
            } else
            {
                span = new Span(value);
            }
            span.setId("EventID" + name);
            text.append(detail.getBeforeItem(name)).append(span).append(detail.getAfterItem(name));
        }
        return text.toString();
    }


    public static int getCITYS(String cityname)
    {
        int c = -1;
        for(int i = 0;i < CITYS.length;i++)
        {
            if(CITYS[i].equals(cityname))
            {
                c = i;
            }
        }
        return c;
    }

    public static void sync()
    {
        try
        {
            License license = License.getInstance();
            if(license.getListenertype() != null && license.getListenertype().indexOf("/2/") != -1)
            {
            } else
            {
                return;
            }
            Timer timer = new Timer();
            timer.schedule(new TimerTask()
            {
                String last = null;
                public void run()
                {
                    try
                    {
                        System.out.println("==开始扫描活动到期时间===");
                        if(new Date().getHours() == 23) //每天晚上23点更新
                        {

                            Event.UpdateTimes();
                        }

                    } catch(SQLException e)
                    {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                }

                // },0,2* 60 * 1000);//2分钟扫描一次
            },0,1 * 60 * 60 * 1000); //1个小时扫描一次
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }

    }
    public static String f(String str) throws NumberFormatException,SQLException
	{
		StringBuilder qua = new StringBuilder();
		String[] arr = str.split("[|]");
		for(int i = 1;i < arr.length;i++)
		{
			Event q = Event.find(Integer.parseInt(arr[i]),1);
			Node n=Node.find(Integer.parseInt(arr[i]));
			qua.append("<span id='_q" + q.node + "' path=''><input type='hidden' name='EventNode' value='" + q.node + "' />" + n.getSubject(1) + "<img src='/tea/image/d7.gif' onclick='mt.fdel(this)' /></span>");
		}
		return qua.toString();
	}
    //定时计算活动的到期时间
    public static void UpdateTimes() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(" SELECT node FROM Node where type = 37  ");
            while(db.next())
            {
                int node = db.getInt(1);
                Node n = Node.find(node);
                Event eobj = Event.find(node,1);
                int d = Entity.compare_date(Entity.sdf.format(eobj.getTimeStart()),Entity.sdf.format(new Date()));
                if(d == 1)
                {
                    n.set("audits",String.valueOf(n.audits = 0));
                } else if(d == -1 || d == 0)
                {
                    d = Entity.compare_date(Entity.sdf.format(eobj.getTimeStop()),Entity.sdf.format(new Date()));
                    if(d == -1)
                    {
                        n.set("audits",String.valueOf(n.audits = 2));

                        //报名结束，显示是否进行
                        int dc = Entity.compare_date(Entity.sdf.format(eobj.getTimeHoldStart()),Entity.sdf.format(new Date()));
                        //已经开始举行活动
                        if(dc == 0 || dc == -1)
                        {
                            n.set("audits",String.valueOf(n.audits = 3));
                        }

                        int dc2 = Entity.compare_date(Entity.sdf.format(eobj.getTimeHoldStop()),Entity.sdf.format(new Date()));

                        if(dc2 == -1)
                        {
                            //结束
                            n.set("audits",String.valueOf(n.audits = 4));
                        }
                    } else
                    {
                        n.set("audits",String.valueOf(n.audits = 1));
                    }
                }
            }
            System.out.println("==活动时间扫描结束===");
        } finally
        {
            db.close();
        }
    }

    public void setIntegral(float integral)
    {
        this.integral = integral;
    }

    public void setSubtitle(String subtitle)
    {
        this.subtitle = subtitle;
    }

    public void setLead(String lead)
    {
        this.lead = lead;
    }

    public void setProvince(String province)
    {
        this.province = province;
    }

    public void setCity2(String city2)
    {
        this.city2 = city2;
    }

    public void setAddress(String address)
    {
        this.address = address;
    }

    public void setEventtype(int eventtype)
    {
        this.eventtype = eventtype;
    }

    public void setCatering(int catering)
    {
        this.catering = catering;
    }

    public void setStay(int stay)
    {
        this.stay = stay;
    }

    public void setShuttle(int shuttle)
    {
        this.shuttle = shuttle;
    }

    public void setMap(String map)
    {
        this.map = map;
    }

    public void setRegmember(String regmember)
    {
        this.regmember = regmember;
    }

    public void setCity(int city)
    {
        this.city = city;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public void setTimeStart(Date timeStart)
    {
        this.timeStart = timeStart;
    }

    public void setTimeStop(Date timeStop)
    {
        this.timeStop = timeStop;
    }


    public void setTimeHoldStart(Date timeHoldStart)
    {
        this.timeHoldStart = timeHoldStart;
    }

    public void setTimeHoldStop(Date timeHoldStop)
    {
        this.timeHoldStop = timeHoldStop;
    }

    public void setNightShop(int nightShop)
    {
        this.nightShop = nightShop;
    }

    public void setRequest(String request)
    {
        this.request = request;
    }

    public void setPrescribe(String prescribe)
    {
        this.prescribe = prescribe;
    }

    public void setSynopsis(String synopsis)
    {
        this.synopsis = synopsis;
    }

    public void setOrganise(String organise)
    {
        this.organise = organise;
    }

    public void setLinkman(String linkman)
    {
        this.linkman = linkman;
    }

    public void setCorp(String corp)
    {
        this.corp = corp;
    }

    public void setCarfare(String carfare)
    {
        this.carfare = carfare;
    }

    public void setFeature(String feature)
    {
        this.feature = feature;
    }

    public void setIntroPicture(String introPicture)
    {
        this.introPicture = introPicture;
    }

    public void setFlyerData(String flyerData)
    {
        this.flyerData = flyerData;
    }

    public void setNode(int node)
    {
        this.node = node;
    }

    public void setLanguage(int language)
    {
        this.language = language;
    }

    public void setLocalePicture(String localePicture)
    {
        this.localePicture = localePicture;
    }

    public void setLocalePicture2(String localePicture2)
    {
        this.localePicture2 = localePicture2;
    }

    public void setLocalePicture3(String localePicture3)
    {
        this.localePicture3 = localePicture3;
    }

    public void setDate(Date time)
    {
        this.time = time;
    }

    public void setSort(String sort)
    {
        this.sort = sort;
    }

    public void setBigPicture(String bigPicture)
    {
        this.bigPicture = bigPicture;
    }

    public float getIntegral()
    {
        return integral;
    }

    public String getRegmember()
    {
        return regmember;
    }

    public String getName()
    {
        return name;
    }

    public Date getTimeStart()
    {
        return timeStart;
    }

    public Date getTimeStop()
    {
        return timeStop;
    }


    public Date getTimeHoldStart()
    {
        return timeHoldStart;
    }

    public Date getTimeHoldStop()
    {
        return timeHoldStop;
    }

    public int getNightShop()
    {
        return nightShop;
    }

    public String getRequest()
    {
        return request;
    }

    public String getPrescribe()
    {
        return prescribe;
    }

    public String getSynopsis()
    {
        return synopsis;
    }

    public String getOrganise()
    {
        return organise;
    }

    public int getAlbum()
    {
        return album;
    }

    public String getLinkman()
    {
        return linkman;
    }

    public String getCorp()
    {
        return corp;
    }

    public String getCarfare()
    {
        return carfare;
    }

    public String getFeature()
    {
        return feature;
    }

    public String getIntroPicture()
    {
        return introPicture;
    }

    public String getFlyerData()
    {
        return flyerData;
    }

    public int getNode()
    {
        return node;
    }

    public int getLanguage()
    {
        return language;
    }

    public String getLocalePicture()
    {
        return localePicture;
    }

    public String getLocalePicture2()
    {
        return localePicture2;
    }

    public String getLocalePicture3()
    {
        return localePicture3;
    }

    public Date getDate()
    {
        return time;
    }

    public String getDateToString()
    {
        if(time == null)
        {
            return "";
        }
        return sdf.format(time);
    }

    public String getSort()
    {
        return sort;
    }

    public String getBigPicture()
    {
        return bigPicture;
    }

    public boolean exists()
    {
        return exist;
    }

    public int getCity()
    {
        return city;
    }


    public String getLead()
    {
        return lead;
    }

    public String getProvince()
    {
        return province;
    }

    public String getCity2()
    {
        return city2;
    }

    public String getAddress()
    {
        return address;
    }

    public int getEventtype()
    {
        return eventtype;
    }

    public int getCatering()
    {
        return catering;
    }

    public int getStay()
    {
        return stay;
    }

    public int getShuttle()
    {
        return shuttle;
    }

    public String getMap()
    {
        return map;
    }

    public String getSubtitle()
    {
        return subtitle;
    }

}
