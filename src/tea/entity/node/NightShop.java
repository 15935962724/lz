package tea.entity.node;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Entity;
import tea.entity.Filex;
import tea.entity.Http;
import tea.entity.city.CityList;
import tea.entity.sup.SupQualification;
import tea.html.Anchor;
import tea.html.Button;
import tea.html.Image;
import tea.html.Span;
import tea.html.Text;
import tea.resource.Common;
import tea.ui.TeaSession;

public class NightShop extends Entity
{
    public NightShop()
    {
    }

    private int node;
    private int _iNightShopCode;
    private String _sLogo;
    private String _sType;
    private String _sArea;
    private String _sMusicType;
    private String _sDeilStyle;
    private String _sCircumstance;
    private String _dStartBusinessHours;
    private String _dStopBusinessHours;
    private int _iOptions;
    private String _sSynopsis;
    private String _sCapability;
    private String _sPayment;
    private String _sTrait;
    private String _sDepreciate;
    private Date _dPracticeHours;
    private String _sAddress;
    private byte[] _byPicture;
    private String _sPrincipal;
    private String _sPhone;
    private String _sFax;
    private String _iPostalcode;
    private String _sCooperate;
    private String _sSponsor;

    private String _sConsume;
    private String _sAcreage;
    private String _sAverageConsume;
    private String _sPrice;
    private String _sAmong;
    private String _sOperation;
    private String _sLoo;
    private String _sDestine;
    private String _sBlock;
    private String _sCoverCharge;
    private String _sMember;
    private String _sEmail;

    private int _iPictureLen;

    private boolean _blLoaded;
    private static Cache _cache = new Cache(100);
    private String ticket;
    private int holisticMark;
    private int auraMark;
    private int serveMark;
    private int musicMark;
    private int crowdMark;
    private int drinkMark;
    private int deliMark;
    private int toiletMark;
    private int relaxMark;
    private int lamplightMark;
    private int temperatureMark;
    private int airMark;
    private int safetyMark;
    private int belleMark;
    private int priceMark;
    private int degreeMark;
    private boolean _bLoadMark;
    private String map;
    private int language;

    private int nstype1; // 类型1
    private int nstype2; // 类型2
    private int album; // 关联组图类

    private String location; // 区

    private String provinceid;
    private String cityid;
    private String provincename;
    private String cityname;
    private String commericial;
    private String landmark;
    public String services;
    public String activitys;
    public String serArea;

    public NightShop(int _nNode,int _nLanguage) throws SQLException
    {
        this.node = _nNode;
        this.language = _nLanguage;
        loadBasic("");

    }

    /*public NightShop(int _nNode,int _nLanguage,String provinceid,String cityid) throws SQLException
    {
        this.node = _nNode;
        this.language = _nLanguage;
        loadBasic("",provinceid,cityid);

    }*/

    public NightShop(int iNode,int _nLanguage,String sqlWhere) throws SQLException
    {
        this.node = iNode;
        this.language = _nLanguage;
        loadBasic(sqlWhere);
    }

    public static boolean exists(int iNode) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM NightShop WHERE node=" + iNode);
            return db.next();
        } finally
        {
            db.close();
        }
    }

    public static NightShop find(int _nNode,int _nLanguage) throws SQLException
    {
        NightShop obj = (NightShop) _cache.get(_nNode + ":" + _nLanguage);
        if(obj == null)
        {
            obj = new NightShop(_nNode,_nLanguage);
            _cache.put(_nNode + ":" + _nLanguage,obj);
        }
        return obj;
    }

    /*public static NightShop find(int _nNode,int _nLanguage,String provinceid,String cityid) throws SQLException
    {
        NightShop obj = (NightShop) _cache.get(_nNode + ":" + _nLanguage + ":" + provinceid + ":" + cityid);
        if(obj == null)
        {
            obj = new NightShop(_nNode,_nLanguage,provinceid,cityid);
            _cache.put(_nNode + ":" + _nLanguage + ":" + provinceid + ":" + cityid,obj); //by wanfeng zhou
            //_cache.put(_nNode + ":" + _nLanguage, obj + ":" + provinceid + ":" + cityid);
        }
        return obj;
    }*/

    /**
     * 获得节点和距离的关系
     * @param sql
     * @return
     * @throws SQLException
     * by wanfeng zhou
     */
    public static Map getNodeDisMap(String sql) throws SQLException
    {
        Map returnV = new HashMap();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(sql);
            while(db.next())
            {
                //v.addElement(new Integer(db.getInt(1)));
                returnV.put(db.getString(1),db.getString(2));
            }
        } finally
        {
            db.close();
        }
        return returnV;
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("UPDATE NightShop SET nstype1=" + nstype1 + ",nstype2=" + nstype2 + ", logo=" + DbAdapter.cite(this._sLogo)
                                     + ",type=" + DbAdapter.cite(this._sType) + ",provinceid=" + db.cite(provinceid) + " ,cityid="
                                     + db.cite(cityid) + ",location=" + DbAdapter.cite(this.location) + ",commericial=" + db.cite(commericial)
                                     + ",landmark=" + db.cite(landmark) + ",musictype=" + DbAdapter.cite(this._sMusicType) + ",deilstyle="
                                     + DbAdapter.cite(this._sDeilStyle) + ",circumstance=" + DbAdapter.cite(_sCircumstance) + ",startbusinesshours="
                                     + DbAdapter.cite(_dStartBusinessHours) + ",stopbusinesshours=" + DbAdapter.cite(_dStopBusinessHours) + ",options="
                                     + this._iOptions + ",synopsis=" + DbAdapter.cite(this._sSynopsis) + ",capability=" + DbAdapter.cite(this._sCapability)
                                     + ",payment=" + DbAdapter.cite(this._sPayment) + ",trait=" + DbAdapter.cite(this._sTrait) + ",depreciate="
                                     + DbAdapter.cite(this._sDepreciate) + ",practicehours=" + DbAdapter.cite(_dPracticeHours) + ",address="
                                     + DbAdapter.cite(this._sAddress) + ",principal=" + DbAdapter.cite(this._sPrincipal) + ",phone=" + DbAdapter.cite(this._sPhone)
                                     + ",fax=" + DbAdapter.cite(this._sFax) + ",postalcode=" + DbAdapter.cite(_iPostalcode) + ",cooperate="
                                     + DbAdapter.cite(this._sCooperate) + ",sponsor=" + DbAdapter.cite(this._sSponsor) + ",consume=" + DbAdapter.cite(this._sConsume)
                                     + ",acreage=" + DbAdapter.cite(this._sAcreage) + ",averageconsume=" + DbAdapter.cite(this._sAverageConsume) + ",price="
                                     + DbAdapter.cite(this._sPrice) + ",among=" + DbAdapter.cite(this._sAmong) + ",operation=" + DbAdapter.cite(this._sOperation)
                                     + ",loo=" + DbAdapter.cite(this._sLoo) + ",destine=" + DbAdapter.cite(this._sDestine) + ",block=" + DbAdapter.cite(this._sBlock)
                                     + ",covercharge=" + DbAdapter.cite(this._sCoverCharge) + ",member=" + DbAdapter.cite(this._sMember) + ",email="
                                     + DbAdapter.cite(this._sEmail) + ",ticket=" + DbAdapter.cite(ticket) + ",map=" + DbAdapter.cite(map)+",services="+DbAdapter.cite(services)
                                     +",activitys="+DbAdapter.cite(activitys)+",serArea="+DbAdapter.cite(serArea)+ " WHERE node=" + this.node);
//			+ " AND language=" + this.language);
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO NightShop(node,language,logo,type,provinceid,cityid,location,commericial,landmark,musictype,deilstyle,circumstance,startbusinesshours,stopbusinesshours,options,synopsis,"
                                 + "capability,payment,trait,depreciate,practicehours,address,principal,phone,fax,	postalcode,cooperate,sponsor,acreage,averageconsume,consume,price,among,operation,"
                                 + "loo,destine,block,covercharge,member,email,ticket,map,nstype1,nstype2,services,activitys,serArea)VALUES("
                                 + this.node
                                 + " , "
                                 + this.language
                                 + ","
                                 + DbAdapter.cite(this._sLogo)
                                 + ", "
                                 + DbAdapter.cite(this._sType)
                                 + " , "
                                 + db.cite(provinceid)
                                 + ","
                                 + db.cite(cityid)
                                 + ","
                                 + db.cite(location)
                                 + ","
                                 + db.cite(commericial)
                                 + ","
                                 + db.cite(landmark)
                                 + ","
                                 + DbAdapter.cite(this._sMusicType)
                                 + ","
                                 + DbAdapter.cite(this._sDeilStyle)
                                 + ",      "
                                 + DbAdapter.cite(_sCircumstance)
                                 + ",    "
                                 + DbAdapter.cite(_dStartBusinessHours)
                                 + ", "
                                 + DbAdapter.cite(_dStopBusinessHours)
                                 + ", "
                                 + this._iOptions
                                 + ", "
                                 + DbAdapter.cite(this._sSynopsis)
                                 + ","
                                 + DbAdapter.cite(this._sCapability)
                                 + ",    "
                                 + DbAdapter.cite(this._sPayment)
                                 + ","
                                 + DbAdapter.cite(this._sTrait)
                                 + ",   "
                                 + DbAdapter.cite(this._sDepreciate)
                                 + ",  "
                                 + DbAdapter.cite(_dPracticeHours)
                                 + ",   "
                                 + DbAdapter.cite(this._sAddress)
                                 + ","
                                 + DbAdapter.cite(this._sPrincipal)
                                 + ",    "
                                 + DbAdapter.cite(this._sPhone)
                                 + ",  "
                                 + DbAdapter.cite(this._sFax)
                                 + ",  "
                                 + DbAdapter.cite(_iPostalcode)
                                 + ",  "
                                 + DbAdapter.cite(this._sCooperate)
                                 + ", "
                                 + DbAdapter.cite(this._sSponsor)
                                 + ","
                                 + DbAdapter.cite(this._sAcreage)
                                 + ","
                                 + DbAdapter.cite(this._sAverageConsume)
                                 + ","
                                 + DbAdapter.cite(this._sConsume)
                                 + ","
                                 + DbAdapter.cite(this._sPrice)
                                 + ","
                                 + DbAdapter.cite(this._sAmong)
                                 + ","
                                 + ""
                                 + DbAdapter.cite(this._sOperation)
                                 + ","
                                 + DbAdapter.cite(this._sLoo)
                                 + ","
                                 + DbAdapter.cite(this._sDestine)
                                 + ","
                                 + DbAdapter.cite(this._sBlock)
                                 + ","
                                 + DbAdapter.cite(this._sCoverCharge)
                                 + ","
                                 + DbAdapter.cite(this._sMember)
                                 + ","
                                 + DbAdapter.cite(this._sEmail)
                                 + ","
                                 + DbAdapter.cite(ticket)
                                 + ","
                                 + DbAdapter.cite(map)
                                 + ","
                                 + nstype1
                                 + ","
                                 + nstype2
                                 + ","+DbAdapter.cite(services)
                                 + ","+DbAdapter.cite(activitys)
                                 + ","+DbAdapter.cite(serArea)
                                 +" )");
                
            }
            _cache.remove(node + ":" + language);
        } finally
        {
            db.close();
        }
    }

    /*
     * public void set(String name, String logoPath, String type, String area,
     * String musicType, String deilStyle, String circumstance, String
     * startBusinessHours, String stopBusinessHours, int options, String
     * synopsis, int capability, String payment, String intro, String trait,
     * String depreciate, Date practiceHours, String address, String principal,
     * String phone, String fax, String postalcode, String cooperate, String
     * sponsor) throws SQLException { DbAdapter db = new DbAdapter(); try {
     * db.executeUpdate("NightShopEdit " + node + ",'" + name + "'," +
     * DbAdapter.cite(logoPath) + ",'" + type + "','" + area + "','" + musicType
     * + "','" + deilStyle + "','" + circumstance + "','" + startBusinessHours +
     * "','" + stopBusinessHours + "'," + options + ",'" + synopsis + "'," +
     * capability + ",'" + payment + "','" + intro + "','" + trait + "','" +
     * depreciate + "'," + practiceHours + ",'" + address + "','" + principal +
     * "','" + phone + "','" + fax + "','" + postalcode + "','" + cooperate +
     * "','" + sponsor + "'"); } finally { db.close(); } // _cache.remove(new
     * Integer(_nListing)); }
     */
    public static void delete(int iNode) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM NightShop WHERE node" + iNode);
        } finally
        {
            db.close();
        }
    }

    public int getNstype1() throws SQLException
    {
        return nstype1;
    }

    public int getNstype2() throws SQLException
    {
        return nstype2;
    }

    public void set(int album) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update NightShop set album =" + album + " where node = " + node);
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }

    public int getAlbum() throws SQLException
    {
        return album;
    }

    public int getNightShopCode() throws SQLException
    {
        return _iNightShopCode;
    }

    public String getType() throws SQLException
    {
        return _sType;
    }

    public String getArea() throws SQLException
    {
        return _sArea;
    }

    public String getMusicType() throws SQLException
    {
        return _sMusicType;
    }

    public String getDeilStyle() throws SQLException
    {
        return _sDeilStyle;
    }

    public String getCircumstance() throws SQLException
    {
        return _sCircumstance;
    }

    public String getStartBusinessHours() throws SQLException
    {
        return _dStartBusinessHours;

    }

    public String getStopBusinessHours() throws SQLException
    {
        return _dStopBusinessHours;
    }

    public String getSynopsis() throws SQLException
    {
        return _sSynopsis;
    }

    public String getCapability() throws SQLException
    {
        return _sCapability;
    }

    public String getPayment() throws SQLException
    {
        return _sPayment;
    }

    public String getTrait() throws SQLException
    {
        return _sTrait;
    }

    public String getDepreciate() throws SQLException
    {
        return _sDepreciate;
    }

    public Date getPracticeHours() throws SQLException
    {
        return _dPracticeHours;
    }

    public String getAddress() throws SQLException
    {
        return _sAddress;
    }

    public byte[] getPicture() throws SQLException
    {
        return _byPicture;
    }

    public String getPrincipal() throws SQLException
    {
        return _sPrincipal;
    }

    public String getPhone() throws SQLException
    {
        return _sPhone;
    }

    public String getFax() throws SQLException
    {
        return _sFax;
    }

    public String getPostalcode() throws SQLException
    {
        return _iPostalcode;
    }

    public String getCooperate() throws SQLException
    {
        return _sCooperate;
    }

    public String getSponsor() throws SQLException
    {
        return _sSponsor;
    }

    public int getOptions()
    {
        return _iOptions;
    }

    private void loadBasic(String sqlWhere) throws SQLException
    {
        if(!_blLoaded)
        {
            int j = this.getLanguage(language);
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT language,logo,type,1,musictype,deilstyle,circumstance,startbusinesshours,stopbusinesshours,options,synopsis,capability,payment,"
                                + "0,trait,depreciate,practicehours,address,principal,phone,fax,postalcode,cooperate,sponsor,0,consume,acreage,averageconsume,price,among,operation,"
                                + "loo,destine,block,covercharge,member,email,ticket,map,nstype1,nstype2,album,provinceid, cityid,location,services,activitys,serArea FROM NightShop WHERE node="
                                + node + " AND language=" + j + sqlWhere);
                if(db.next())
                {
                    _sLogo = db.getString(2);
                    _sType = db.getVarchar(j,language,3); //
                    _sArea = db.getVarchar(j,language,4); //
                    _sMusicType = db.getVarchar(j,language,5); // new S
                    _sDeilStyle = db.getVarchar(j,language,6); // new St
                    _sCircumstance = db.getVarchar(j,language,7); // new
                    _dStartBusinessHours = db.getVarchar(j,language,8);
                    _dStopBusinessHours = db.getVarchar(j,language,9);
                    /*
                     * _bDepot;//depot,ticket, dayOpenBusiness,electroTicket
                     * _bTicket; _bDayOpenBusiness; _bElectroTicket;
                     */
                    _iOptions = db.getInt(10);
                    // _bDepot=i;
                    _sSynopsis = db.getText(j,language,11);
                    _sCapability = db.getVarchar(j,language,12);
                    _sPayment = db.getVarchar(j,language,13); //
                    _sTrait = db.getVarchar(j,language,15); // ne
                    _sDepreciate = db.getVarchar(j,language,16);
                    _dPracticeHours = db.getDate(17);
                    _sAddress = db.getVarchar(j,language,18); //
                    _sPrincipal = db.getVarchar(j,language,19);
                    _sPhone = db.getString(20);
                    _sFax = db.getString(21);
                    _iPostalcode = db.getString(22);
                    _sCooperate = db.getVarchar(j,language,23);
                    _sSponsor = db.getVarchar(j,language,24); //
                    _iNightShopCode = db.getInt(25);
                    _sConsume = db.getVarchar(j,language,26); //
                    _sAcreage = db.getVarchar(j,language,27); //
                    _sAverageConsume = db.getVarchar(j,language,28);
                    _sPrice = db.getVarchar(j,language,29); // ne
                    _sAmong = db.getVarchar(j,language,30); // ne
                    _sOperation = db.getVarchar(j,language,31);
                    _sLoo = db.getVarchar(j,language,32); // new
                    _sDestine = db.getVarchar(j,language,33); //
                    _sBlock = db.getVarchar(j,language,34); // n
                    _sCoverCharge = db.getVarchar(j,language,35);
                    _sMember = db.getVarchar(j,language,36);
                    _sEmail = db.getVarchar(j,language,37);
                    ticket = db.getVarchar(j,language,38);
                    map = db.getString(39);
                    nstype1 = db.getInt(40);
                    nstype2 = db.getInt(41);
                    album = db.getInt(42);
                    provinceid = db.getString(43);
                    cityid = db.getString(44);
                    location = db.getString(45);
                    services = db.getString(46);
                    activitys = db.getString(47);
                    serArea = db.getString(48);
                } else
                {
                    _sLogo = _sType = _sArea = _sMusicType = _sDeilStyle = _sCircumstance = _dStartBusinessHours = _dStopBusinessHours = _sSynopsis = _sCapability = _sPayment = _sTrait = _sDepreciate = _sAddress = _sPrincipal = _sPhone = _sFax = _iPostalcode = _sCooperate = _sSponsor = _sConsume = _sAcreage = _sAverageConsume = _sPrice = _sAmong = _sOperation = _sLoo = _sDestine = _sBlock = _sCoverCharge = _sMember = _sEmail = ticket = location = "";
                }
            } catch(Exception ex)
            {
                ex.printStackTrace();
            } finally
            {
                db.close();
            }
            _blLoaded = true;
        }
    }

    /*private void loadBasic(String sqlWhere,String provinceid,String cityid) throws SQLException
    {
        if(!_blLoaded)
        {
           
            int j = this.getLanguage(language);
            DbAdapter db = new DbAdapter();
            StringBuilder sb = new StringBuilder();
            sb.append("SELECT n.language,n.logo,n.type,1,n.musictype,n.deilstyle,n.circumstance,n.startbusinesshours,n.stopbusinesshours,n.options,n.synopsis,"
                      + "n.capability,n.payment,0,n.trait,n.depreciate,n.practicehours,n.address,n.principal,n.phone,n.fax,n.postalcode,n.cooperate,n.sponsor,0,n.consume,"
                      + "n.acreage,n.averageconsume,n.price,n.among,n.operation,n.loo,n.destine,n.block,n.covercharge,n.member,n.email,n.ticket,n.map,n.nstype1,n.nstype2,"
                      + "n.album,n.location ,n.provinceid,n.cityid   ,n.commericial,n.landmark,services  FROM NightShop n "); 

            sb.append("  where  n.node=" + node + " AND n.language=" + j + sqlWhere);
            try
            {
                db.executeQuery(sb.toString());

                if(db.next())
                {
                    _sLogo = db.getString(2);
                    _sType = db.getVarchar(j,language,3); //
                    _sArea = db.getVarchar(j,language,4); //
                    _sMusicType = db.getVarchar(j,language,5); // new S
                    _sDeilStyle = db.getVarchar(j,language,6); // new St
                    _sCircumstance = db.getVarchar(j,language,7); // new
                    _dStartBusinessHours = db.getVarchar(j,language,8);
                    _dStopBusinessHours = db.getVarchar(j,language,9);
                    
                     * _bDepot;//depot,ticket, dayOpenBusiness,electroTicket
                     * _bTicket; _bDayOpenBusiness; _bElectroTicket;
                     
                    _iOptions = db.getInt(10);
                    // _bDepot=i;
                    _sSynopsis = db.getText(j,language,11);
                    _sCapability = db.getVarchar(j,language,12);
                    _sPayment = db.getVarchar(j,language,13); //
                    _sTrait = db.getVarchar(j,language,15); // ne
                    _sDepreciate = db.getVarchar(j,language,16);
                    _dPracticeHours = db.getDate(17);
                    _sAddress = db.getVarchar(j,language,18); //
                    _sPrincipal = db.getVarchar(j,language,19);
                    _sPhone = db.getString(20);
                    _sFax = db.getString(21);
                    _iPostalcode = db.getString(22);
                    _sCooperate = db.getVarchar(j,language,23);
                    _sSponsor = db.getVarchar(j,language,24); //
                    _iNightShopCode = db.getInt(25);
                    _sConsume = db.getVarchar(j,language,26); //
                    _sAcreage = db.getVarchar(j,language,27); //
                    _sAverageConsume = db.getVarchar(j,language,28);
                    _sPrice = db.getVarchar(j,language,29); // ne
                    _sAmong = db.getVarchar(j,language,30); // ne
                    _sOperation = db.getVarchar(j,language,31);
                    _sLoo = db.getVarchar(j,language,32); // new
                    _sDestine = db.getVarchar(j,language,33); //
                    _sBlock = db.getVarchar(j,language,34); // n
                    _sCoverCharge = db.getVarchar(j,language,35);
                    _sMember = db.getVarchar(j,language,36);
                    _sEmail = db.getVarchar(j,language,37);
                    ticket = db.getVarchar(j,language,38);
                    map = db.getString(39);
                    nstype1 = db.getInt(40);
                    nstype2 = db.getInt(41);
                    album = db.getInt(42);
                    location = db.getString(43);
                    int x = 44;
                    this.provinceid = db.getString(x++); // FIXME
                    this.cityid = db.getString(x++); // FIXME
                    commericial = db.getString(x++); // FIXME
                    landmark = db.getString(x++); // FIXME
                    services=db.getString(x++);
                } else
                {
                    _sLogo = _sType = _sArea = _sMusicType = _sDeilStyle = _sCircumstance = _dStartBusinessHours = _dStopBusinessHours = _sSynopsis = _sCapability = _sPayment = _sTrait = _sDepreciate = _sAddress = _sPrincipal = _sPhone = _sFax = _iPostalcode = _sCooperate = _sSponsor = _sConsume = _sAcreage = _sAverageConsume = _sPrice = _sAmong = _sOperation = _sLoo = _sDestine = _sBlock = _sCoverCharge = _sMember = _sEmail = ticket = commericial = provincename = landmark = location = "";
                }
            } catch(Exception ex)
            {
                ex.printStackTrace();
            } finally
            {
                db.close();
            }
            _blLoaded = true;
        }
    }*/

    /*
     * public long getLogoLen() throws SQLException { return
     * length(this._sLogo); }
     */

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language FROM NightShop WHERE node=" + node);
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

    public int getPictureLen() throws SQLException
    {
        return _iPictureLen;
    }

    public String getLogo() throws SQLException
    {
        return _sLogo;
    }

    public void setType(String type)
    {
        this._sType = type;
    }

    public void setTrait(String trait)
    {
        this._sTrait = trait;
    }

    public void setNstype1(int nstype1)
    {
        this.nstype1 = nstype1;
    }

    public void setNstype2(int nstype2)
    {
        this.nstype2 = nstype2;
    }

    public void setAlbum(int album)
    {
        this.album = album;
    }

    public void setSynopsis(String synopsis)
    {
        this._sSynopsis = synopsis;
    }

    public void setStopBusinessHours(String stopBusinessHours)
    {
        this._dStopBusinessHours = stopBusinessHours;
    }

    public void setStartBusinessHours(String startBusinessHours)
    {
        this._dStartBusinessHours = startBusinessHours;
    }

    public void setSponsor(String sponsor)
    {
        this._sSponsor = sponsor;
    }

    public void setPrincipal(String principal)
    {
        this._sPrincipal = principal;
    }

    public void setPracticeHours(Date practiceHours)
    {
        this._dPracticeHours = practiceHours;
    }

    public void setPostalcode(String postalcode)
    {
        this._iPostalcode = postalcode;
    }

    public void setPictureLen(int pictureLen)
    {
        this._iPictureLen = pictureLen;
    }

    /*
     * public void setPicture(byte[] picture) { this._sPicture = picture; }
     */
    public void setPhone(String phone)
    {
        this._sPhone = phone;
    }

    public void setPayment(String payment)
    {
        this._sPayment = payment;
    }

    public void setOptions(int options)
    {
        this._iOptions = options;
    }

    public void setNightShopCode(int nightShopCode)
    {
        this._iNightShopCode = nightShopCode;
    }

    public void setMusicType(String musicType)
    {
        this._sMusicType = musicType;
    }

    public void setLogo(String logo)
    {
        this._sLogo = logo;
    }

    public void setFax(String fax)
    {
        this._sFax = fax;
    }

    public void setDepreciate(String depreciate)
    {
        this._sDepreciate = depreciate;
    }

    public void setDeilStyle(String deilStyle)
    {
        this._sDeilStyle = deilStyle;
    }

    public void setAddress(String address)
    {
        this._sAddress = address;
    }

    public void setArea(String area)
    {
        this._sArea = area;
    }

    public void setCapability(String capability)
    {
        this._sCapability = capability;
    }

    public void setCircumstance(String circumstance)
    {
        this._sCircumstance = circumstance;
    }

    public void setCooperate(String cooperate)
    {
        this._sCooperate = cooperate;
    }

    public String getAcreage()
    {
        return _sAcreage;
    }

    public String getAverageConsume()
    {
        return _sAverageConsume;
    }

    public String getPrice()
    {
        return _sPrice;
    }

    public String getAmong()
    {
        return _sAmong;
    }

    public String getOperation()
    {
        return _sOperation;
    }

    public String getLoo()
    {
        return _sLoo;
    }

    public String getDestine()
    {
        return _sDestine;
    }

    public String getBlock()
    {
        return _sBlock;
    }

    public String getCoverCharge()
    {
        return _sCoverCharge;
    }

    public String getMember()
    {
        return _sMember;
    }

    public String getEmail()
    {
        return _sEmail;
    }

    public void setAcreage(String acreage)
    {
        _sAcreage = acreage;
    }

    public void setAverageConsume(String _sAverageConsume)
    {
        this._sAverageConsume = _sAverageConsume;
    }

    public void setPrice(String _sPrice)
    {
        this._sPrice = _sPrice;
    }

    public void setAmong(String _sAmong)
    {
        this._sAmong = _sAmong;
    }

    public void setOperation(String _sOperation)
    {
        this._sOperation = _sOperation;
    }

    public void setLoo(String _sLoo)
    {
        this._sLoo = _sLoo;
    }

    public void setDestine(String _sDestine)
    {
        this._sDestine = _sDestine;
    }

    public void setBlock(String _sBlock)
    {
        this._sBlock = _sBlock;
    }

    public void setCoverCharge(String _sCoverCharge)
    {
        this._sCoverCharge = _sCoverCharge;
    }

    public void setMember(String _sMember)
    {
        this._sMember = _sMember;
    }

    public void setEmail(String _sEmail)
    {
        this._sEmail = _sEmail;
    }

    public void setConsume(String _sConsume)
    {
        this._sConsume = _sConsume;
    }

    public String getConsume()
    {
        return this._sConsume;
    }

    public void setTicket(String ticket)
    {
        this.ticket = ticket;
    }

    public void setHolisticMark(int holisticMark)
    {
        this.holisticMark = holisticMark;
    }

    public void setAuraMark(int auraMark)
    {
        this.auraMark = auraMark;
    }

    public void setServeMark(int serveMark)
    {
        this.serveMark = serveMark;
    }

    public void setMusicMark(int musicMark)
    {
        this.musicMark = musicMark;
    }

    public void setCrowdMark(int crowdMark)
    {
        this.crowdMark = crowdMark;
    }

    public void setDrinkMark(int drinkMark)
    {
        this.drinkMark = drinkMark;
    }

    public void setDeliMark(int deliMark)
    {
        this.deliMark = deliMark;
    }

    public void setToiletMark(int toiletMark)
    {
        this.toiletMark = toiletMark;
    }

    public void setRelaxMark(int relaxMark)
    {
        this.relaxMark = relaxMark;
    }

    public void setLamplightMark(int lamplightMark)
    {
        this.lamplightMark = lamplightMark;
    }

    public void setTemperatureMark(int temperatureMark)
    {
        this.temperatureMark = temperatureMark;
    }

    public void setAirMark(int airMark)
    {
        this.airMark = airMark;
    }

    public void setSafetyMark(int safetyMark)
    {
        this.safetyMark = safetyMark;
    }

    public void setBelleMark(int belleMark)
    {
        this.belleMark = belleMark;
    }

    public void setPriceMark(int priceMark)
    {
        this.priceMark = priceMark;
    }

    public void setDegreeMark(int degreeMark)
    {

        this.degreeMark = degreeMark;
    }

    public void setMap(String map)
    {
        this.map = map;
    }

    public String getTicket()
    {
        return ticket;
    }

    public int getHolisticMark() throws SQLException
    {
        loadMark();
        return holisticMark;
    }

    public int getAuraMark() throws SQLException
    {
        loadMark();
        return auraMark;
    }

    public int getServeMark() throws SQLException
    {
        loadMark();
        return serveMark;
    }

    public int getMusicMark() throws SQLException
    {
        loadMark();
        return musicMark;
    }

    public int getCrowdMark() throws SQLException
    {
        loadMark();
        return crowdMark;
    }

    public int getDrinkMark() throws SQLException
    {
        loadMark();
        return drinkMark;
    }

    public int getDeliMark() throws SQLException
    {
        loadMark();
        return deliMark;
    }

    public int getToiletMark() throws SQLException
    {
        loadMark();
        return toiletMark;
    }

    public int getRelaxMark() throws SQLException
    {
        loadMark();
        return relaxMark;
    }

    public int getLamplightMark() throws SQLException
    {
        loadMark();
        return lamplightMark;
    }

    public int getTemperatureMark() throws SQLException
    {
        loadMark();
        return temperatureMark;
    }

    public int getAirMark() throws SQLException
    {
        loadMark();
        return airMark;
    }

    public int getSafetyMark() throws SQLException
    {
        loadMark();
        return safetyMark;
    }

    public int getBelleMark() throws SQLException
    {
        loadMark();
        return belleMark;
    }

    public int getPriceMark() throws SQLException
    {
        loadMark();
        return priceMark;
    }

    public int getDegreeMark() throws SQLException
    {
        loadMark();
        return degreeMark;
    }

    public String getMap()
    {
        return map;
    }

    public void setMark() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE NightShop SET holisticmark=holisticmark+" + holisticMark + ",auramark=auramark+" + this.auraMark
                             + ",servemark=servemark+" + this.serveMark + ",musicmark=musicmark+" + this.musicMark + ",crowdmark=crowdmark+" + this.crowdMark
                             + ",drinkmark=drinkmark+" + this.drinkMark + ",delimark=delimark+" + this.deliMark + ",toiletmark=toiletmark+" + toiletMark
                             + ",relaxmark=relaxmark+" + relaxMark + ",lamplightmark=lamplightmark+" + lamplightMark + ",temperaturemark=temperaturemark+"
                             + temperatureMark + ",airmark=airmark+" + this.airMark + ",safetymark=safetymark+" + this.safetyMark + ",bellemark=bellemark+"
                             + this.belleMark + ",pricemark=pricemark+" + this.priceMark + ",degreemark=degreemark+1 WHERE node=" + this.node);
        } finally
        {
            db.close();
        }
        _bLoadMark = false;
    }

    private void loadMark() throws SQLException
    {
        if(!_bLoadMark)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT degreemark,holisticmark,auramark,servemark,musicmark,crowdmark,drinkmark,delimark,toiletmark,relaxmark,lamplightmark,"
                                + "temperaturemark,airmark,safetymark,bellemark,pricemark,degreemark,holisticmark,auramark,servemark,musicmark,crowdmark,drinkmark,"
                                + "delimark,toiletmark,relaxmark,lamplightmark,temperaturemark,airmark,safetymark,bellemark,pricemark FROM NightShop WHERE node="
                                + node);
                if(db.next())
                {
                    degreeMark = db.getInt(1);
                    if(degreeMark > 0)
                    {
                        holisticMark = (db.getInt(2) / degreeMark) * 20;
                        auraMark = (db.getInt(3) / degreeMark) * 20;
                        serveMark = (db.getInt(4) / degreeMark) * 20;
                        musicMark = (db.getInt(5) / degreeMark) * 20;
                        crowdMark = (db.getInt(6) / degreeMark) * 20;
                        drinkMark = (db.getInt(7) / degreeMark) * 20;
                        deliMark = (db.getInt(8) / degreeMark) * 20;
                        toiletMark = (db.getInt(9) / degreeMark) * 20;
                        relaxMark = (db.getInt(10) / degreeMark) * 20;
                        lamplightMark = (db.getInt(11) / degreeMark) * 20;
                        temperatureMark = (db.getInt(12) / degreeMark) * 20;
                        airMark = (db.getInt(13) / degreeMark) * 20;
                        safetyMark = (db.getInt(14) / degreeMark) * 20;
                        belleMark = (db.getInt(15) / degreeMark) * 20;
                        priceMark = (db.getInt(16) / degreeMark) * 20;
                    }
                }
            } finally
            {
                db.close();
            }
            _bLoadMark = true;
        }
    }

    public static String getDetail(Node node,Http http,int listing,String target,tea.resource.Resource r) throws SQLException
    {
        int language = http.language;
        StringBuilder h = new StringBuilder();
        NightShop nightShop = NightShop.find(node._nNode,language);
        boolean bool = false;
        Span span = null;
        ListingDetail detail = ListingDetail.find(listing,45,language);
        Iterator e = detail.keys();
        while(e.hasNext())
        {
            String itemname = (String) e.next();
            int istype = detail.getIstype(itemname);
            if(istype == 0)
            {
                continue;
            }
            Anchor anchor = null;
            String name = "";
            String before = detail.getBeforeItem(itemname);
            String after = detail.getAfterItem(itemname);
            int boolAnchor = detail.getAnchor(itemname);
            System.out.println("itemname = " + itemname);
            if(itemname.equals("Name"))
            {
                name = (node.getSubject(language));
                System.out.println("name = " + name);
            } else if(itemname.equals("NightShopCode"))
            {
                name = (String.valueOf(node._nNode)); // nightShop.getNightShopCode()));
            } else if(itemname.equals("Logo"))
            {
                name = (new Image(nightShop.getLogo()).toString());
            } else if(itemname.equals("Type"))
            {
                name = (nightShop.getType());
            } else if(itemname.equals("provinceid")) // 省
            {
                name = CityList.getProvinceName(Integer.parseInt(nightShop.getProvinceid()), http.language);
            } else if(itemname.equals("cityid")) // 市
            {
                name = CityList.getProvinceName(Integer.parseInt(nightShop.getCityid()), http.language);
            } else if(itemname.equals("location"))
            { // 区
                name = nightShop.getLocation();
            } else if(itemname.equals("commericial"))
            { // 区
                name = nightShop.getCommericial();
            } else if(itemname.equals("landmark"))
            { // 区
                name = nightShop.getLandmark();
            } else if(itemname.equals("MusicType"))
            {
                name = (nightShop.getMusicType());
            }else if(itemname.equals("serArea"))
            {
                name = (nightShop.serArea);
            } else if(itemname.equals("DeilStyle"))
            {
                name = (nightShop.getDeilStyle());
            } else if(itemname.equals("Circumstance"))
            {
                name = (nightShop.getCircumstance());
            } else if(itemname.equals("Synopsis"))
            {
                name = (nightShop.getSynopsis());
            } else if(itemname.equals("Capability"))
            {
                name = (String.valueOf(nightShop.getCapability()));
            } else if(itemname.equals("Payment"))
            {
                name = (nightShop.getPayment());
            } else if(itemname.equals("Intro"))
            {
                if((node.getOptions() & 0x40L) == 0)
                {
                    name = (Text.toHTML(node.getText(language))); // nightShop.getIntro()));
                } else
                {
                    name = (node.getText(language));
                }
            } else if(itemname.equals("Trait"))
            {
                name = (nightShop.getTrait());
            } else if(itemname.equals("Depreciate"))
            {
                name = (nightShop.getDepreciate());
            } else if(itemname.equals("PracticeHours"))
            {
                name = ("\u65F6\u95F4"); // nightShop.getPracticeHours().toString());
            } else if(itemname.equals("Address"))
            {
                name = (nightShop.getAddress());
            } else if("Click".equals(itemname))
            {
                // 点击数
                name = String.valueOf(node.getClick());
            } else if("Talkbackconut".equals(itemname))
            {
                // 评论数
                int count = Talkback.count(" and hidden =1 and node = " + node._nNode);
                name = String.valueOf(count);
            } else if("talkbackper".equals(itemname))
            {
                //name = "<div class='ScorePic'><div class='ScorePicPer' style='width:" + Talkback.getPercent(node._nNode) + "%'></div></div>";
            } else if("Picture2".equals(itemname))
            {
                //TODO 关联组图处理
                System.out.println("关联组图");
                //关联组图
                if(nightShop.getAlbum() > 0)
                {
                    try
                    {
                        name = "<script>var a_node=" + nightShop.getAlbum() + ",a_father=" + Node.find(nightShop.getAlbum()).getFather() + ";</script>" + Filex.read(Common.REAL_PATH + "/jsp/type/album/AlbumModule.htm","utf-8");
                    } catch(IOException e1)
                    {
                        // TODO Auto-generated catch block
                        e1.printStackTrace();
                    }
                }
            } else if("Picturenumber".equals(itemname))
            {
                //组图个数
                int c = AlbumList.count(" and node =" + nightShop.getAlbum());

                if(nightShop.getAlbum() > 0)
                {

                    name = "<a href=\"/html/nightshop/" + nightShop.getAlbum() + "-" + language + ".htm\" target=_blank>" + c + "</a>";

                } else
                {
                    name = String.valueOf(c);
                }
            } else if(itemname.equals("Picture"))
            {
                Iterator it = TypePicture.findByNode(node._nNode,0,detail.getQuantity(itemname)).iterator();
                while(it.hasNext())
                {
                    TypePicture tp = (TypePicture) it.next();
                    String str = "<img src='" + tp.getPicture() + "' alt='" + tp.getPicname() + "'/>";
                    if(boolAnchor == 1)
                        str = "<a href='/html/nightshop/" + node._nNode + "-" + language + ".htm' target='" + target + "'>" + str + "</a>";
                    else if(boolAnchor == 2)
                        str = "<a href='###' onclick=\"mt.img('" + tp.getPicture2() + "')\">" + str + "</a>";
                    h.append(before).append("<span id='NightShopIDPicture'>" + str + "</span>").append(after);
                }
                continue;
            } else if(itemname.equals("Picture2"))
            {
                Iterator it = TypePicture.findByNode(node._nNode,0,detail.getQuantity(itemname)).iterator();
                while(it.hasNext())
                {
                    TypePicture tp = (TypePicture) it.next();
                    String str = "<img src='" + tp.getPicture2() + "' alt='" + tp.getPicname() + "'/>";
                    if(boolAnchor == 1)
                        str = "<a href='/html/nightshop/" + node._nNode + "-" + language + ".htm' target='" + target + "'>" + str + "</a>";
                    h.append(before).append("<span id='NightShopIDPicture2'>" + str + "</span>").append(after);
                }
                continue;
            } else if(itemname.equals("PictureName"))
            {
                Iterator it = TypePicture.findByNode(node._nNode,0,detail.getQuantity(itemname)).iterator();
                while(it.hasNext())
                {
                    TypePicture tp = (TypePicture) it.next();
                    String str = tp.getPicname();
                    if(boolAnchor == 1)
                        str = "<a href='/html/nightshop/" + node._nNode + "-" + language + ".htm' target='" + target + "'>" + str + "</a>";
                    h.append(before).append("<span id='NightShopIDPictureName'>" + str + "</span>").append(after);
                }
                continue;
            }

            /*
             * else if(itemname.equals("Picture")) { java.util.Enumeration
             * enumer = TypePicture.findByNode(node._nNode);
             * if(enumer.hasMoreElements()) { int id = ((Integer)
             * enumer.nextElement()).intValue(); TypePicture tp =
             * TypePicture.findByPrimaryKey(id); name = new
             * tea.html.Image(tp.getPicture(),tp.getPicname()).toString();
             * switch(boolAnchor) { case 2: if(tp.getPicture2() != null &&
             * tp.getPicture2().length() > 0) { anchor = new
             * Anchor("javascript:window.showModalDialog('" + tp.getPicture2() +
             * "','self','edge:raised;help:0;resizable:1;dialogWidth:" +
             * (tp.getWidth() + 9) + "px;dialogHeight:" + (tp.getHeight() + 27 +
             * 20) + "px;')",name); } break; } } } else
             * if(itemname.equals("PictureName")) { StringBuilder sb = new
             * StringBuilder(); java.util.Enumeration enumer =
             * TypePicture.findByNode(node._nNode); if(enumer.hasMoreElements())
             * { int id = ((Integer) enumer.nextElement()).intValue();
             * TypePicture tp = TypePicture.findByPrimaryKey(id); name =
             * tp.getPicname(); } } else if(itemname.equals("Picture2")) {
             * java.util.Enumeration enumer =
             * TypePicture.findByNode(node._nNode); if(enumer.hasMoreElements())
             * { enumer.nextElement(); if(enumer.hasMoreElements()) { int id =
             * ((Integer) enumer.nextElement()).intValue(); TypePicture tp =
             * TypePicture.findByPrimaryKey(id); name = new
             * tea.html.Image(tp.getPicture(),tp.getPicname()).toString();
             * switch(boolAnchor) { case 2: // 连接到大图 if(tp.getPicture2() != null
             * && tp.getPicture2().length() > 0) { // if (tp.getWidth() == 0 ||
             * tp.getHeight() == 0) { java.io.File file = new
             * java.io.File(application.getRealPath(tp.getPicture2()));
             * java.awt.image.BufferedImage bi =
             * javax.imageio.ImageIO.read(file); tp.set(bi.getWidth(),
             * bi.getHeight(), tp.getPicture(), tp.getPicname(),
             * tp.getPicture2()); }
             *
             * anchor = new Anchor("javascript:window.showModalDialog('" +
             * tp.getPicture2() +
             * "','self','edge:raised;help:0;resizable:1;dialogWidth:" +
             * (tp.getWidth() + 9) + "px;dialogHeight:" + (tp.getHeight() + 27 +
             * 20) + "px;')",name); } break; } } } } else
             * if(itemname.equals("PictureName2")) { java.util.Enumeration
             * enumer = TypePicture.findByNode(node._nNode);
             * if(enumer.hasMoreElements()) { enumer.nextElement();
             * if(enumer.hasMoreElements()) { int id = ((Integer)
             * enumer.nextElement()).intValue(); TypePicture tp =
             * TypePicture.findByPrimaryKey(id); name = (tp.getPicname()); } } }
             * else if(itemname.equals("OtherPicture")) { StringBuilder sb = new
             * StringBuilder(); java.util.Enumeration enumer =
             * TypePicture.findByNode(node._nNode); if(enumer.hasMoreElements())
             * { enumer.nextElement(); if(enumer.hasMoreElements()) {
             * enumer.nextElement(); while(enumer.hasMoreElements()) { int id =
             * ((Integer) enumer.nextElement()).intValue(); TypePicture tp =
             * TypePicture.findByPrimaryKey(id); String img = new
             * tea.html.Image(tp.getPicture(),tp.getPicname()).toString();
             * switch(boolAnchor) { case 2: if(tp.getPicture2() != null &&
             * tp.getPicture2().length() > 0) { anchor = new
             * Anchor("javascript:window.showModalDialog('" + tp.getPicture2() +
             * "','self','edge:raised;help:0;resizable:1;dialogWidth:" +
             * (tp.getWidth() + 9) + "px;dialogHeight:" + (tp.getHeight() + 27 +
             * 20) + "px;')",img); span = new Span(anchor); } else { span = new
             * Span(img); } break; case 1: anchor = new
             * Anchor("/servlet/Node?node=" + node._nNode + "&language=" +
             * language,name); anchor.setTarget(target); span = new
             * Span(anchor); break; default: span = new Span(img); }
             * span.setId("NightShopIDOtherPicture"); sb.append(before + span +
             * after); } } } h.append(sb); } else
             * if(itemname.equals("OtherPictureName")) { StringBuilder sb = new
             * StringBuilder(); java.util.Enumeration enumer =
             * TypePicture.findByNode(node._nNode); if(enumer.hasMoreElements())
             * { enumer.nextElement(); if(enumer.hasMoreElements()) {
             * enumer.nextElement(); while(enumer.hasMoreElements()) { int id =
             * ((Integer) enumer.nextElement()).intValue(); TypePicture tp =
             * TypePicture.findByPrimaryKey(id); if(boolAnchor != 0) { anchor =
             * new Anchor("/servlet/Node?node=" + node._nNode + "&language=" +
             * language,tp.getPicname()); anchor.setTarget(target); span = new
             * Span(anchor); } else { span = new Span(tp.getPicname()); }
             * span.setId("NightShopIDOtherPictureName"); sb.append(before +
             * span + after); } } } h.append(sb); }
             */
            else if(itemname.equals("Principal"))
            {
                name = (nightShop.getPrincipal());
            } else if(itemname.equals("Phone"))
            {
                name = (nightShop.getPhone());
            } else if(itemname.equals("Fax"))
            {
                name = (nightShop.getFax());
            } else if(itemname.equals("Postalcode"))
            {
                name = (nightShop.getPostalcode());
            } else if(itemname.equals("Cooperate"))
            {
                name = (nightShop.getCooperate());
            } else if(itemname.equals("Acreage"))
            {
                name = (nightShop.getAcreage());
            } else if(itemname.equals("AverageConsume"))
            {
                name = (nightShop.getAverageConsume());
            } else if(itemname.equals("Consume"))
            {
                name = (nightShop.getConsume());
            } else if(itemname.equals("Price"))
            {
                name = (nightShop.getPrice());
            } else if(itemname.equals("Among"))
            {
                name = (nightShop.getAmong());
            } else if(itemname.equals("Operation"))
            {
                name = (nightShop.getOperation());
            } else if(itemname.equals("Loo"))
            {
                name = (nightShop.getLoo());
            } else if(itemname.equals("Destine"))
            {
                name = (nightShop.getDestine());
            } else if(itemname.equals("Block"))
            {
                name = (nightShop.getBlock());
            } else if(itemname.equals("CoverCharge"))
            {
                name = (nightShop.getCoverCharge());
            } else if(itemname.equals("Member"))
            {
                name = (nightShop.getMember());
            } else if(itemname.equals("Browse"))
            {
                name = String.valueOf(node.getClick());
            } else if(itemname.equals("Email"))
            {
                name = (nightShop.getEmail());
            } else if(itemname.equals("Sponsor"))
            {
                name = (nightShop.getSponsor());
            } else if(itemname.equalsIgnoreCase("BusinessHours"))
            {
                name = (nightShop.getStartBusinessHours()); // + "--" +
                // nightShop.getStopBusinessHours());
            } else if(itemname.equalsIgnoreCase("DayOpenBusiness"))
            {
                bool = (nightShop.getOptions() & 4) != 0;
                name = (bool ? r.getString(language,"Have") : r.getString(language,"Void"));
            } else if(itemname.equalsIgnoreCase("ElectroTicket"))
            {
                bool = (nightShop.getOptions() & 8) != 0;
                name = (bool ? r.getString(language,"Have") : r.getString(language,"Void"));
            } else if(itemname.equalsIgnoreCase("Ticket"))
            {
                name = (nightShop.getTicket());
                // bool = (nightShop.getOptions() & 2) != 0;
                // name = (bool ? r.getString(language, "Have") :
                // r.getString(language, "Void"));
            } else if(itemname.equalsIgnoreCase("Depot"))
            {
                bool = (nightShop.getOptions() & 1) != 0;
                name = (bool ? r.getString(language,"Have") : r.getString(language,"Void"));
            } else if(itemname.equalsIgnoreCase("GradeTarget"))
            {
                name = ("<form name=\"form1\" method=\"post\" action=\"/servlet/EditNightShop\">  <input type=\"hidden\" name=\"nextUrl\" value=\""
                          + "\">  <input type=\"hidden\" name=\"node\" value=\""
                        + node._nNode + "\">    <input type=\"hidden\" name=\"mark\" value=\"ON\">  <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">    <tr>      <td id=\"MarkTarget\">整体印象</td>      <td id=\"MarkValue\"> <input name=\"holisticMark\" type=\"radio\" value=\"5\" checked>       5分       <input type=\"radio\" name=\"holisticMark\" value=\"4\">        4分 <input type=\"radio\" name=\"holisticMark\" value=\"3\">        3分        <input type=\"radio\" name=\"holisticMark\" value=\"2\">        2分        <input type=\"radio\" name=\"holisticMark\" value=\"1\">        1分 </td>    </tr>    <tr>      <td>身心放松度</td>      <td><input name=\"relaxMark\" type=\"radio\" value=\"5\" checked>       5分       <input type=\"radio\" name=\"relaxMark\" value=\"4\">        4分        <input type=\"radio\" name=\"relaxMark\" value=\"3\">        3分        <input type=\"radio\" name=\"relaxMark\" value=\"2\">        2分        <input type=\"radio\" name=\"relaxMark\" value=\"1\">        1分 </td>    </tr>    <tr>      <td>环境气氛</td>      <td><input name=\"auraMark\" type=\"radio\" value=\"5\" checked>       5分       <input type=\"radio\" name=\"auraMark\" value=\"4\">        4分        <input type=\"radio\" name=\"auraMark\" value=\"3\">        3分        <input type=\"radio\" name=\"auraMark\" value=\"2\">        2分        <input type=\"radio\" name=\"auraMark\" value=\"1\">        1分 </td>    </tr>    <tr>      <td>灯光</td>      <td><input name=\"lamplightMark\" type=\"radio\" value=\"5\" checked>       5分       <input type=\"radio\" name=\"lamplightMark\" value=\"4\">        4分        <input type=\"radio\" name=\"lamplightMark\" value=\"3\">        3分        <input type=\"radio\" name=\"lamplightMark\" value=\"2\">        2分        <input type=\"radio\" name=\"lamplightMark\" value=\"1\">        1分 </td>    </tr>    <tr>      <td>服务</td>      <td><input name=\"serveMark\" type=\"radio\" value=\"5\" checked>       5分       <input type=\"radio\" name=\"serveMark\" value=\"4\">        4分        <input type=\"radio\" name=\"serveMark\" value=\"3\">        3分        <input type=\"radio\" name=\"serveMark\" value=\"2\">        2分        <input type=\"radio\" name=\"serveMark\" value=\"1\">        1分 </td>    </tr>    <tr>      <td>温度</td>      <td><input name=\"temperatureMark\" type=\"radio\" value=\"5\" checked>       5分       <input type=\"radio\" name=\"temperatureMark\" value=\"4\">        4分        <input type=\"radio\" name=\"temperatureMark\" value=\"3\">        3分        <input type=\"radio\" name=\"temperatureMark\" value=\"2\">        2分        <input type=\"radio\" name=\"temperatureMark\" value=\"1\">        1分 </td>    </tr>    <tr>      <td>音乐</td>      <td><input name=\"musicMark\" type=\"radio\" value=\"5\" checked>       5分       <input type=\"radio\" name=\"musicMark\" value=\"4\">        4分        <input type=\"radio\" name=\"musicMark\" value=\"3\">        3分        <input type=\"radio\" name=\"musicMark\" value=\"2\">        2分        <input type=\"radio\" name=\"musicMark\" value=\"1\">        1分 </td>    </tr>    <tr>      <td>空气清新度</td>      <td><input name=\"airMark\" type=\"radio\" value=\"5\" checked>       5分       <input type=\"radio\" name=\"airMark\" value=\"4\">        4分        <input type=\"radio\" name=\"airMark\" value=\"3\">        3分        <input type=\"radio\" name=\"airMark\" value=\"2\">        2分        <input type=\"radio\" name=\"airMark\" value=\"1\">        1分 </td>    </tr>    <tr>      <td>人群素质</td>      <td><input name=\"crowdMark\" type=\"radio\" value=\"5\" checked>       5分       <input type=\"radio\" name=\"crowdMark\" value=\"4\">        4分        <input type=\"radio\" name=\"crowdMark\" value=\"3\">        3分        <input type=\"radio\" name=\"crowdMark\" value=\"2\">        2分        <input type=\"radio\" name=\"crowdMark\" value=\"1\">        1分 </td>    </tr>    <tr>      <td>安全系数</td>      <td><input name=\"safetyMark\" type=\"radio\" value=\"5\" checked>       5分       <input type=\"radio\" name=\"safetyMark\" value=\"4\">        4分        <input type=\"radio\" name=\"safetyMark\" value=\"3\">        3分        <input type=\"radio\" name=\"safetyMark\" value=\"2\">        2分        <input type=\"radio\" name=\"safetyMark\" value=\"1\">        1分 </td>    </tr>    <tr>      <td>酒水</td>      <td><input name=\"drinkMark\" type=\"radio\" value=\"5\" checked>       5分       <input type=\"radio\" name=\"drinkMark\" value=\"4\">        4分        <input type=\"radio\" name=\"drinkMark\" value=\"3\">        3分        <input type=\"radio\" name=\"drinkMark\" value=\"2\">        2分        <input type=\"radio\" name=\"drinkMark\" value=\"1\">        1分 </td>    </tr>    <tr>      <td>美女含量</td>      <td><input name=\"belleMark\" type=\"radio\" value=\"5\" checked>       5分       <input type=\"radio\" name=\"belleMark\" value=\"4\">        4分        <input type=\"radio\" name=\"belleMark\" value=\"3\">        3分        <input type=\"radio\" name=\"belleMark\" value=\"2\">        2分        <input type=\"radio\" name=\"belleMark\" value=\"1\">        1分 </td>    </tr>    <tr>      <td>食品</td>      <td><input name=\"deliMark\" type=\"radio\" value=\"5\" checked>       5分       <input type=\"radio\" name=\"deliMark\" value=\"4\">        4分        <input type=\"radio\" name=\"deliMark\" value=\"3\">        3分        <input type=\"radio\" name=\"deliMark\" value=\"2\">        2分        <input type=\"radio\" name=\"deliMark\" value=\"1\">        1分 </td>    </tr>    <tr>      <td>价格</td>      <td><input name=\"priceMark\" type=\"radio\" value=\"5\" checked>       5分       <input type=\"radio\" name=\"priceMark\" value=\"4\">        4分        <input type=\"radio\" name=\"priceMark\" value=\"3\">        3分        <input type=\"radio\" name=\"priceMark\" value=\"2\">        2分        <input type=\"radio\" name=\"priceMark\" value=\"1\">        1分 </td>    </tr>    <tr>      <td>卫生间</td>      <td><input name=\"toiletMark\" type=\"radio\" value=\"5\" checked>       5分       <input type=\"radio\" name=\"toiletMark\" value=\"4\">        4分        <input type=\"radio\" name=\"toiletMark\" value=\"3\">        3分        <input type=\"radio\" name=\"toiletMark\" value=\"2\">        2分        <input type=\"radio\" name=\"toiletMark\" value=\"1\">        1分 </td>    </tr>  </table>  <input name=\"Input\" type=\"submit\" id=\"NightShopIDSubmit\" value=\"提交\"></form>"

                       );
            } else if(itemname.equalsIgnoreCase("Result"))
            {
                name = ("<include src=\"/jsp/type/nightshop/ListingDetail_Result.jsp?node=" + node._nNode + "\"/>");
            } else if(itemname.equalsIgnoreCase("ResultButton"))
            {
                name = (new Button(1,"CB","ResultButton","投票结果","window.open('/jsp/type/nightshop/Mark.jsp?node=" + node._nNode + "');")
                        .toString());
            } else if(itemname.equalsIgnoreCase("GradeButton"))
            {
                name = (new Button(1,"CB","GradeButton","我要打分","window.open('/jsp/type/nightshop/EditMark.jsp?node=" + node._nNode + "');")
                        .toString());
            } else if(itemname.equals("map"))
            {
                String map = nightShop.getMap();
                if(map != null && map.length() > 0)
                {
                    // +9 +27+20
                    if(boolAnchor == 1)
                    {
                        boolAnchor = 0;
                        name = "<input type='button' value='地图' onclick=\"window.showModalDialog('/jsp/admin/map/ViewGMap.jsp?node=" + node._nNode
                               + "&point=" + map + "','','edge:raised;help:0;resizable:1;dialogWidth:609px;dialogHeight:527px;')\">";
                    } else
                    {
                        name = "<iframe id='gmap' src='/jsp/admin/map/ViewGMap.jsp?node=" + node._nNode + "&point=" + map
                               + "' frameborder='0'></iframe>";
                    }
                }
            }

            /*
             * else { db2.executeQuery("SELECT " + itemname +
             * " FROM NightShop WHERE node=" + iNode); if (db2.next()) {
             * text.add(new Text((db.getString(2).getBytes( "ISO-8859-1")) +
             * (db2.getString(1).getBytes("ISO-8859-1")) +
             * (db.getString(3).getBytes("ISO-8859-1")))); } }
             */

            if(boolAnchor == 0)
            {
                span = new Span(name);
            } else if(anchor != null)
            {
                span = new Span(anchor);
            } else
            {
                anchor = new Anchor("/html/nightshop/" + node._nNode + "-" + language + ".htm",name);
                anchor.setTarget(target);
                span = new Span(anchor);
            }
            span.setId("NightShopID" + itemname);
            h.append(before).append(span).append(after);
        }
        return h.toString();
    }

    
    public String getLocation()
    {
        return location;
    }

    public void setLocation(String location)
    {
        this.location = location;
    }


    public String getProvinceid()
    {
        return provinceid;
    }

    public void setProvinceid(String provinceid)
    {
        this.provinceid = provinceid;
    }

    public String getCityid()
    {
        return cityid;
    }

    public void setCityid(String cityid)
    {
        this.cityid = cityid;
    }

    public String getProvincename()
    {
        return provincename;
    }

    public void setProvincename(String provincename)
    {
        this.provincename = provincename;
    }

    public String getCityname()
    {
        return cityname;
    }

    public void setCityname(String cityname)
    {
        this.cityname = cityname;
    }

    public String getCommericial()
    {
        return commericial;
    }

    public void setCommericial(String commericial)
    {
        this.commericial = commericial;
    }

    public String getLandmark()
    {
        return landmark;
    }

    public void setLandmark(String landmark)
    {
        this.landmark = landmark;
    }

}
