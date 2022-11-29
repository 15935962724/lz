package tea.entity.node;

import java.util.*;

import tea.db.*;
import tea.entity.*;
import tea.entity.admin.map.*;
import tea.html.Button;
import tea.html.Text;
import tea.html.Anchor;
import tea.html.Span;
import tea.html.Image;
import tea.ui.TeaSession;
import java.sql.SQLException;

//黑 黄 蓝 白 红
public class Golf extends Entity
{
    protected static Cache _cache = new Cache(100);
    private int _nNode;
    private int _nLanguage;
    private int _iCourtCode;
    private String _sLogo = "";
    private String _sType = "";
    private String _sArea = "";
    private String _sMusicType = "";
    private String _sDeilStyle = "";
    private String _sCircumstance = "";
    private String _dStartBusinessHours = "";
    private String _dStopBusinessHours = "";
    private int _iOptions;
    private String _sSynopsis = "";
    private String _sCapability = "";
    private String _sPayment = "";
    private String _sIntro = "";
    private String _sTrait = "";
    private String _sDepreciate = "";
    private Date _dPracticeHours;
    private String _sAddress = "";
    private byte[] _byPicture;
    private String _sPrincipal = "";
    private String _sPhone = "";
    private String _sFax = "";
    private String _iPostalcode = "";
    private String _sCooperate = "";
    private String _sSponsor = "";

    private String _sConsume = "";
    private String _sAcreage = "";
    private String _sAverageConsume = "";
    private String _sPrice = "";
    private String _sAmong = "";
    private String _sOperation = "";
    private String _sLoo = "";
    private String _sDestine = "";
    private String _sBlock = "";
    private String _sCoverCharge = "";
    private String _sMember = "";
    private String _sEmail = "";
    public String url;
    private int _iPictureLen;


    private String ticket = "";
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
    private String stylist;
    private String cavity;
    private String haulm;
    private String pLength;
    private String pGrass;
    private String cGrass;
    private String meGreen9W;
    private String mgGreen9W;
    private String ggGreen9W;
    private String viGreen9W;
    private String meGreen9H;
    private String mgGreen9H;
    private String ggGreen9H;
    private String viGreen9H;
    private String meGreen18W;
    private String mgGreen18W;
    private String ggGreen18W;
    private String viGreen18W;
    private String meGreen18H;
    private String mgGreen18H;
    private String ggGreen18H;
    private String viGreen18H;
    private String meExeunt;
    private String mgExeunt;
    private String ggExeunt;
    private String viExeunt;
    private String meCaddie9;
    private String mgCaddie9;
    private String ggCaddie9;
    private String viCaddie9;
    private String meCaddie9B;
    private String mgCaddie9B;
    private String ggCaddie9B;
    private String viCaddie9B;
    private String meCaddie18;
    private String mgCaddie18;
    private String ggCaddie18;
    private String viCaddie18;
    private String meCaddie18B;
    private String mgCaddie18B;
    private String ggCaddie18B;
    private String viCaddie18B;
    private String meReserved;
    private String mgReserved;
    private String ggReserved;
    private String viReserved;
    private String meBuggy9;
    private String mgBuggy9;
    private String viBuggy9;
    private String ggBuggy9;
    private String meBuggy18;
    private String mgBuggy18;
    private String ggBuggy18;
    private String viBuggy18;
    private String meDriving;
    private String mgDriving;
    private String ggDriving;
    private String viDriving;
    private String meClub;
    private String mgClub;
    private String ggClub;
    private String viClub;
    private String meCommon;
    private String mgCommon;
    private String ggCommon;
    private String viCommon;
    private String mePro;
    private String mgPro;
    private String ggPro;
    private String viPro;
    private String meSpiked;
    private String mgSpiked;
    private String ggSpiked;
    private String viSpiked;
    private String meUmbrella;
    private String mgUmbrella;
    private String ggUmbrella;
    private String viUmbrella;
    private String meFacilities;
    private String mgFacilities;
    private String ggFacilities;
    private String viFacilities;
    private String meNonDesignatedW;
    private String mgNonDesignatedW;
    private String ggNonDesignatedW;
    private String viNonDesignatedW;
    private String meNonDesignatedH;
    private String mgNonDesignatedH;
    private String ggNonDesignatedH;
    private String viNonDesignatedH;
    private float difficulty = 72f; // 球场难度系数
    private float gradient = 113f; // 球场坡度系数
    public float[] difficultys = new float[5],gradients = new float[5]; //同上，5个发球台的!
    public int[] standard = new int[18]; //标准杆
    private String[] hole = new String[18]; // 18洞的图片
    public int[] yardage = new int[18];
    public int hits; //打球次数
    //同步
    public String posid; //设备ID
    public Golf(int iNode,int _nLanguage)
    {
        try
        {
            this._nNode = iNode;
            this._nLanguage = _nLanguage;
            load("");
        } catch(SQLException ee)
        {
            ee.printStackTrace();
        }
    }

    public Golf(int iNode,int _nLanguage,String sqlWhere)
    {
        try
        {
            this._nNode = iNode;
            this._nLanguage = _nLanguage;
            load(sqlWhere);
        } catch(SQLException ee)
        {
            ee.printStackTrace();
        }
    }

    public static boolean exists(int iNode) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM Golf WHERE node=" + iNode);
            return db.next();
        } finally
        {
            db.close();
        }
    }

    public static Golf find(int node,int language)
    {
        Golf obj = (Golf) _cache.get(node + ":" + language);
        if(obj == null)
        {
            obj = new Golf(node,language);
            _cache.put(node + ":" + language,obj);
        }
        return obj;
    }

    public void set() throws SQLException
    {

        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE Golf SET type=").append(DbAdapter.cite(_sType));
        if(_sLogo != null)
        {
            sql.append(",logo=").append(DbAdapter.cite(_sLogo));
        }
        sql.append(",Area=").append(DbAdapter.cite(this._sArea));
        sql.append(",MusicType=").append(DbAdapter.cite(this._sMusicType));
        sql.append(",DeilStyle=").append(DbAdapter.cite(this._sDeilStyle));
        sql.append(",Circumstance=").append(DbAdapter.cite(_sCircumstance));
        sql.append(",StartBusinessHours=").append(DbAdapter.cite(_dStartBusinessHours));
        sql.append(",StopBusinessHours=").append(DbAdapter.cite(_dStopBusinessHours));
        sql.append(",Options=").append(this._iOptions);
        sql.append(",Synopsis=").append(DbAdapter.cite(this._sSynopsis));
        sql.append(",Capability=").append(DbAdapter.cite(this._sCapability));
        sql.append(",Payment=").append(DbAdapter.cite(this._sPayment));
        sql.append(",Intro=").append(DbAdapter.cite(this._sIntro));
        sql.append(",Trait=").append(DbAdapter.cite(this._sTrait));
        sql.append(",Depreciate=").append(DbAdapter.cite(this._sDepreciate));
        sql.append(",PracticeHours=").append(DbAdapter.cite(_dPracticeHours));
        sql.append(",Address=").append(DbAdapter.cite(this._sAddress));
        sql.append(",Principal=").append(DbAdapter.cite(this._sPrincipal));
        sql.append(",Phone=").append(DbAdapter.cite(this._sPhone));
        sql.append(",Fax=").append(DbAdapter.cite(this._sFax));
        sql.append(",Postalcode=").append(DbAdapter.cite(_iPostalcode));
        sql.append(",Cooperate=").append(DbAdapter.cite(this._sCooperate));
        sql.append(",Sponsor=").append(DbAdapter.cite(this._sSponsor));
        sql.append(",Consume=").append(DbAdapter.cite(this._sConsume));
        sql.append(",Acreage=").append(DbAdapter.cite(this._sAcreage));
        sql.append(",AverageConsume=").append(DbAdapter.cite(this._sAverageConsume));
        sql.append(",Price=").append(DbAdapter.cite(this._sPrice));
        sql.append(",Among=").append(DbAdapter.cite(this._sAmong));
        sql.append(",Operation=").append(DbAdapter.cite(this._sOperation));
        sql.append(",Loo=").append(DbAdapter.cite(this._sLoo));
        sql.append(",Destine=").append(DbAdapter.cite(this._sDestine));
        sql.append(",Block=").append(DbAdapter.cite(this._sBlock));
        sql.append(",CoverCharge=").append(DbAdapter.cite(this._sCoverCharge));
        sql.append(",Member=").append(DbAdapter.cite(this._sMember));
        sql.append(",Email=").append(DbAdapter.cite(this._sEmail));
        sql.append(",Ticket=").append(DbAdapter.cite(ticket));
        sql.append(",Map=").append(DbAdapter.cite(map));
        sql.append(",stylist=").append(DbAdapter.cite(stylist));
        sql.append(",cavity=").append(DbAdapter.cite(cavity));
        sql.append(",haulm=").append(DbAdapter.cite(haulm));
        sql.append(",plength=").append(DbAdapter.cite(pLength));
        sql.append(",pgrass=").append(DbAdapter.cite(pGrass));
        sql.append(",cgrass=").append(DbAdapter.cite(cGrass));
        sql.append(",megreen9w=").append(DbAdapter.cite(meGreen9W));
        sql.append(",mggreen9w=").append(DbAdapter.cite(mgGreen9W));
        sql.append(",gggreen9w=").append(DbAdapter.cite(ggGreen9W));
        sql.append(",vigreen9w=").append(DbAdapter.cite(viGreen9W));
        sql.append(",megreen9h=").append(DbAdapter.cite(meGreen9H));
        sql.append(",mggreen9h=").append(DbAdapter.cite(mgGreen9H));
        sql.append(",gggreen9h=").append(DbAdapter.cite(ggGreen9H));
        sql.append(",vigreen9h=").append(DbAdapter.cite(viGreen9H));
        sql.append(",megreen18w=").append(DbAdapter.cite(meGreen18W));
        sql.append(",mggreen18w=").append(DbAdapter.cite(mgGreen18W));
        sql.append(",gggreen18w=").append(DbAdapter.cite(ggGreen18W));
        sql.append(",vigreen18w=").append(DbAdapter.cite(viGreen18W));
        sql.append(",megreen18h=").append(DbAdapter.cite(meGreen18H));
        sql.append(",mggreen18h=").append(DbAdapter.cite(mgGreen18H));
        sql.append(",gggreen18h=").append(DbAdapter.cite(ggGreen18H));
        sql.append(",vigreen18h=").append(DbAdapter.cite(viGreen18H));
        sql.append(",meexeunt=").append(DbAdapter.cite(meExeunt));
        sql.append(",mgexeunt=").append(DbAdapter.cite(mgExeunt));
        sql.append(",ggexeunt=").append(DbAdapter.cite(ggExeunt));
        sql.append(",viexeunt=").append(DbAdapter.cite(viExeunt));
        sql.append(",mecaddie9=").append(DbAdapter.cite(meCaddie9));
        sql.append(",mgcaddie9=").append(DbAdapter.cite(mgCaddie9));
        sql.append(",ggcaddie9=").append(DbAdapter.cite(ggCaddie9));
        sql.append(",vicaddie9=").append(DbAdapter.cite(viCaddie9));
        sql.append(",mecaddie9b=").append(DbAdapter.cite(meCaddie9B));
        sql.append(",mgcaddie9b=").append(DbAdapter.cite(mgCaddie9B));
        sql.append(",ggcaddie9b=").append(DbAdapter.cite(ggCaddie9B));
        sql.append(",vicaddie9b=").append(DbAdapter.cite(viCaddie9B));
        sql.append(",mecaddie18=").append(DbAdapter.cite(meCaddie18));
        sql.append(",mgcaddie18=").append(DbAdapter.cite(mgCaddie18));
        sql.append(",ggcaddie18=").append(DbAdapter.cite(ggCaddie18));
        sql.append(",vicaddie18=").append(DbAdapter.cite(viCaddie18));
        sql.append(",mecaddie18b=").append(DbAdapter.cite(meCaddie18B));
        sql.append(",mgcaddie18b=").append(DbAdapter.cite(mgCaddie18B));
        sql.append(",ggcaddie18b=").append(DbAdapter.cite(ggCaddie18B));
        sql.append(",vicaddie18b=").append(DbAdapter.cite(viCaddie18B));
        sql.append(",mereserved=").append(DbAdapter.cite(meReserved));
        sql.append(",mgreserved=").append(DbAdapter.cite(mgReserved));
        sql.append(",ggreserved=").append(DbAdapter.cite(ggReserved));
        sql.append(",vireserved=").append(DbAdapter.cite(viReserved));
        sql.append(",mebuggy9=").append(DbAdapter.cite(meBuggy9));
        sql.append(",mgbuggy9=").append(DbAdapter.cite(mgBuggy9));
        sql.append(",ggbuggy9=").append(DbAdapter.cite(ggBuggy9));
        sql.append(",vibuggy9=").append(DbAdapter.cite(viBuggy9));
        sql.append(",mebuggy18=").append(DbAdapter.cite(meBuggy18));
        sql.append(",mgbuggy18=").append(DbAdapter.cite(mgBuggy18));
        sql.append(",ggbuggy18=").append(DbAdapter.cite(ggBuggy18));
        sql.append(",vibuggy18=").append(DbAdapter.cite(viBuggy18));
        sql.append(",medriving=").append(DbAdapter.cite(meDriving));
        sql.append(",mgdriving=").append(DbAdapter.cite(mgDriving));
        sql.append(",ggdriving=").append(DbAdapter.cite(ggDriving));
        sql.append(",vidriving=").append(DbAdapter.cite(viDriving));
        sql.append(",meclub=").append(DbAdapter.cite(meClub));
        sql.append(",mgclub=").append(DbAdapter.cite(mgClub));
        sql.append(",ggclub=").append(DbAdapter.cite(ggClub));
        sql.append(",viclub=").append(DbAdapter.cite(viClub));
        sql.append(",mecommon=").append(DbAdapter.cite(meCommon));
        sql.append(",mgcommon=").append(DbAdapter.cite(mgCommon));
        sql.append(",ggcommon=").append(DbAdapter.cite(ggCommon));
        sql.append(",vicommon=").append(DbAdapter.cite(viCommon));
        sql.append(",mepro=").append(DbAdapter.cite(mePro));
        sql.append(",mgpro=").append(DbAdapter.cite(mgPro));
        sql.append(",ggpro=").append(DbAdapter.cite(ggPro));
        sql.append(",vipro=").append(DbAdapter.cite(viPro));
        sql.append(",mespiked=").append(DbAdapter.cite(meSpiked));
        sql.append(",mgspiked=").append(DbAdapter.cite(mgSpiked));
        sql.append(",ggspiked=").append(DbAdapter.cite(ggSpiked));
        sql.append(",vispiked=").append(DbAdapter.cite(viSpiked));
        sql.append(",meumbrella=").append(DbAdapter.cite(meUmbrella));
        sql.append(",mgumbrella=").append(DbAdapter.cite(mgUmbrella));
        sql.append(",ggumbrella=").append(DbAdapter.cite(ggUmbrella));
        sql.append(",viumbrella=").append(DbAdapter.cite(viUmbrella));
        sql.append(",mefacilities=").append(DbAdapter.cite(meFacilities));
        sql.append(",mgfacilities=").append(DbAdapter.cite(mgFacilities));
        sql.append(",ggfacilities=").append(DbAdapter.cite(ggFacilities));
        sql.append(",vifacilities=").append(DbAdapter.cite(viFacilities));
        sql.append(",menondesignatedw=").append(DbAdapter.cite(meNonDesignatedW));
        sql.append(",mgnondesignatedw=").append(DbAdapter.cite(mgNonDesignatedW));
        sql.append(",ggnondesignatedw=").append(DbAdapter.cite(ggNonDesignatedW));
        sql.append(",vinondesignatedw=").append(DbAdapter.cite(viNonDesignatedW));
        sql.append(",menondesignatedh=").append(DbAdapter.cite(meNonDesignatedH));
        sql.append(",mgnondesignatedh=").append(DbAdapter.cite(mgNonDesignatedH));
        sql.append(",ggnondesignatedh=").append(DbAdapter.cite(ggNonDesignatedH));
        sql.append(",vinondesignatedh=").append(DbAdapter.cite(viNonDesignatedH));
        sql.append(",difficulty=").append(difficulty);
        sql.append(",gradient=").append(gradient);
        for(int i = 0;i < hole.length;i++)
        {
            sql.append(",standard").append(i + 1).append("=").append(standard[i]);
            sql.append(",yardage").append(i + 1).append("=").append(yardage[i]);
            if(hole[i] != null)
            {
                sql.append(",hole").append(i + 1).append("=").append(DbAdapter.cite(hole[i]));
            }
        }
        //发球台 难度系数,坡度系数: 默认是difficulty 和 gradient
        for(int i = 0;i < difficultys.length;i++)
        {
            sql.append(",difficulty").append(i + 1).append("=").append(difficulty);
            sql.append(",gradient").append(i + 1).append("=").append(gradient);
        }
        sql.append(",url=").append(DbAdapter.cite(url));
        sql.append(",posid=").append(DbAdapter.cite(posid));
        sql.append(" WHERE node=" + this._nNode + " AND language=" + _nLanguage);

        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate(sql.toString());
            if(j < 1)
            {
                sql = new StringBuilder();
                sql.append("INSERT INTO Golf(node,language,logo,type,area,musictype,deilstyle,circumstance,startbusinesshours,stopbusinesshours,options,synopsis,capability,payment,intro,trait,depreciate,practicehours,address,principal,phone,fax,postalcode,cooperate,sponsor,acreage,averageconsume,consume,price,among,operation,loo,destine,block,covercharge,member,email,ticket,map,stylist,cavity,haulm,plength,pgrass,cgrass,megreen9w,mggreen9w,gggreen9w,vigreen9w,megreen9h,mggreen9h,gggreen9h,vigreen9h,megreen18w,mggreen18w,gggreen18w,vigreen18w,megreen18h,mggreen18h,gggreen18h,vigreen18h,meexeunt,mgexeunt,ggexeunt,viexeunt,mecaddie9,mgcaddie9,ggcaddie9,vicaddie9,mecaddie9b,mgcaddie9b,ggcaddie9b,vicaddie9b,mecaddie18,mgcaddie18,ggcaddie18,vicaddie18,mecaddie18b,mgcaddie18b,ggcaddie18b,vicaddie18b,mereserved,mgreserved,ggreserved,vireserved,mebuggy9,mgbuggy9,ggbuggy9,vibuggy9,mebuggy18,mgbuggy18,ggbuggy18,vibuggy18,medriving,mgdriving,ggdriving,vidriving,meclub,mgclub,ggclub,viclub,mecommon,mgcommon,ggcommon,vicommon,mepro,mgpro,ggpro,vipro,mespiked,mgspiked,ggspiked,vispiked,meumbrella,mgumbrella,ggumbrella,viumbrella,mefacilities,mgfacilities,ggfacilities,vifacilities,menondesignatedw,mgnondesignatedw,ggnondesignatedw,vinondesignatedw,menondesignatedh,mgnondesignatedh,ggnondesignatedh,vinondesignatedh,difficulty,gradient,difficulty1,difficulty2,difficulty3,difficulty4,difficulty5,gradient1,gradient2,gradient3,gradient4,gradient5,standard1,standard2,standard3,standard4,standard5,standard6,standard7,standard8,standard9,standard10,standard11,standard12,standard13,standard14,standard15,standard16,standard17,standard18,hole1,hole2,hole3,hole4,hole5,hole6,hole7,hole8,hole9,hole10,hole11,hole12,hole13,hole14,hole15,hole16,hole17,hole18,yardage1,yardage2,yardage3,yardage4,yardage5,yardage6,yardage7,yardage8,yardage9,yardage10,yardage11,yardage12,yardage13,yardage14,yardage15,yardage16,yardage17,yardage18,url,posid)VALUES("
                           + this._nNode
                           + "," + _nLanguage
                           + "," + DbAdapter.cite(this._sLogo)
                           + "," + DbAdapter.cite(this._sType)
                           + "," + DbAdapter.cite(this._sArea)
                           + "," + DbAdapter.cite(this._sMusicType)
                           + "," + DbAdapter.cite(this._sDeilStyle)
                           + "," + DbAdapter.cite(_sCircumstance)
                           + "," + DbAdapter.cite(_dStartBusinessHours)
                           + "," + DbAdapter.cite(_dStopBusinessHours)
                           + "," + this._iOptions
                           + "," + DbAdapter.cite(this._sSynopsis)
                           + "," + DbAdapter.cite(this._sCapability)
                           + "," + DbAdapter.cite(this._sPayment)
                           + "," + DbAdapter.cite(this._sIntro)
                           + "," + DbAdapter.cite(this._sTrait)
                           + "," + DbAdapter.cite(this._sDepreciate)
                           + "," + DbAdapter.cite(_dPracticeHours)
                           + "," + DbAdapter.cite(this._sAddress)
                           + "," + DbAdapter.cite(this._sPrincipal)
                           + "," + DbAdapter.cite(this._sPhone)
                           + "," + DbAdapter.cite(this._sFax)
                           + "," + DbAdapter.cite(_iPostalcode)
                           + "," + DbAdapter.cite(this._sCooperate)
                           + "," + DbAdapter.cite(this._sSponsor)
                           + "," + DbAdapter.cite(this._sConsume)
                           + "," + DbAdapter.cite(this._sAcreage)
                           + "," + DbAdapter.cite(this._sAverageConsume)
                           + "," + DbAdapter.cite(this._sPrice)
                           + "," + DbAdapter.cite(this._sAmong)
                           + "," + DbAdapter.cite(this._sOperation)
                           + "," + DbAdapter.cite(this._sLoo)
                           + "," + DbAdapter.cite(this._sDestine)
                           + "," + DbAdapter.cite(this._sBlock)
                           + "," + DbAdapter.cite(this._sCoverCharge)
                           + "," + DbAdapter.cite(this._sMember)
                           + "," + DbAdapter.cite(this._sEmail)
                           + "," + DbAdapter.cite(ticket)
                           + "," + DbAdapter.cite(map)
                           + "," + DbAdapter.cite(stylist)
                           + "," + DbAdapter.cite(cavity)
                           + "," + DbAdapter.cite(haulm)
                           + "," + DbAdapter.cite(pLength)
                           + "," + DbAdapter.cite(pGrass)
                           + "," + DbAdapter.cite(cGrass)
                           + "," + DbAdapter.cite(meGreen9W)
                           + "," + DbAdapter.cite(mgGreen9W)
                           + "," + DbAdapter.cite(ggGreen9W)
                           + "," + DbAdapter.cite(viGreen9W)
                           + "," + DbAdapter.cite(meGreen9H)
                           + "," + DbAdapter.cite(mgGreen9H)
                           + "," + DbAdapter.cite(ggGreen9H)
                           + "," + DbAdapter.cite(viGreen9H)
                           + "," + DbAdapter.cite(meGreen18W)
                           + "," + DbAdapter.cite(mgGreen18W)
                           + "," + DbAdapter.cite(ggGreen18W)
                           + "," + DbAdapter.cite(viGreen18W)
                           + "," + DbAdapter.cite(meGreen18H)
                           + "," + DbAdapter.cite(mgGreen18H)
                           + "," + DbAdapter.cite(ggGreen18H)
                           + "," + DbAdapter.cite(viGreen18H)
                           + "," + DbAdapter.cite(meExeunt)
                           + "," + DbAdapter.cite(mgExeunt)
                           + "," + DbAdapter.cite(ggExeunt)
                           + "," + DbAdapter.cite(viExeunt)
                           + "," + DbAdapter.cite(meCaddie9)
                           + "," + DbAdapter.cite(mgCaddie9)
                           + "," + DbAdapter.cite(ggCaddie9)
                           + "," + DbAdapter.cite(viCaddie9)
                           + "," + DbAdapter.cite(meCaddie9B)
                           + "," + DbAdapter.cite(mgCaddie9B)
                           + "," + DbAdapter.cite(ggCaddie9B)
                           + "," + DbAdapter.cite(viCaddie9B)
                           + "," + DbAdapter.cite(meCaddie18)
                           + "," + DbAdapter.cite(mgCaddie18)
                           + "," + DbAdapter.cite(ggCaddie18)
                           + "," + DbAdapter.cite(viCaddie18)
                           + "," + DbAdapter.cite(meCaddie18B)
                           + "," + DbAdapter.cite(mgCaddie18B)
                           + "," + DbAdapter.cite(ggCaddie18B)
                           + "," + DbAdapter.cite(viCaddie18B)
                           + "," + DbAdapter.cite(meReserved)
                           + "," + DbAdapter.cite(mgReserved)
                           + "," + DbAdapter.cite(ggReserved)
                           + "," + DbAdapter.cite(viReserved)
                           + "," + DbAdapter.cite(meBuggy9)
                           + "," + DbAdapter.cite(mgBuggy9)
                           + "," + DbAdapter.cite(ggBuggy9)
                           + "," + DbAdapter.cite(viBuggy9)
                           + "," + DbAdapter.cite(meBuggy18)
                           + "," + DbAdapter.cite(mgBuggy18)
                           + "," + DbAdapter.cite(ggBuggy18)
                           + "," + DbAdapter.cite(viBuggy18)
                           + "," + DbAdapter.cite(meDriving)
                           + "," + DbAdapter.cite(mgDriving)
                           + "," + DbAdapter.cite(ggDriving)
                           + "," + DbAdapter.cite(viDriving)
                           + "," + DbAdapter.cite(meClub)
                           + "," + DbAdapter.cite(mgClub)
                           + "," + DbAdapter.cite(ggClub)
                           + "," + DbAdapter.cite(viClub)
                           + "," + DbAdapter.cite(meCommon)
                           + "," + DbAdapter.cite(mgCommon)
                           + "," + DbAdapter.cite(ggCommon)
                           + "," + DbAdapter.cite(viCommon)
                           + "," + DbAdapter.cite(mePro)
                           + "," + DbAdapter.cite(mgPro)
                           + "," + DbAdapter.cite(ggPro)
                           + "," + DbAdapter.cite(viPro)
                           + "," + DbAdapter.cite(meSpiked)
                           + "," + DbAdapter.cite(mgSpiked)
                           + "," + DbAdapter.cite(ggSpiked)
                           + "," + DbAdapter.cite(viSpiked)
                           + "," + DbAdapter.cite(meUmbrella)
                           + "," + DbAdapter.cite(mgUmbrella)
                           + "," + DbAdapter.cite(ggUmbrella)
                           + "," + DbAdapter.cite(viUmbrella)
                           + "," + DbAdapter.cite(meFacilities)
                           + "," + DbAdapter.cite(mgFacilities)
                           + "," + DbAdapter.cite(ggFacilities)
                           + "," + DbAdapter.cite(viFacilities)
                           + "," + DbAdapter.cite(meNonDesignatedW)
                           + "," + DbAdapter.cite(mgNonDesignatedW)
                           + "," + DbAdapter.cite(ggNonDesignatedW)
                           + "," + DbAdapter.cite(viNonDesignatedW)
                           + "," + DbAdapter.cite(meNonDesignatedH)
                           + "," + DbAdapter.cite(mgNonDesignatedH)
                           + "," + DbAdapter.cite(ggNonDesignatedH)
                           + "," + DbAdapter.cite(viNonDesignatedH)
                           + "," + difficulty
                           + "," + gradient
                           //发球台的5个
                           + "," + difficulty
                           + "," + difficulty
                           + "," + difficulty
                           + "," + difficulty
                           + "," + difficulty
                           + "," + gradient
                           + "," + gradient
                           + "," + gradient
                           + "," + gradient
                           + "," + gradient);
                for(int i = 0;i < 18;i++)
                {
                    sql.append("," + standard[i]);
                }
                for(int i = 0;i < 18;i++)
                {
                    sql.append("," + DbAdapter.cite(hole[i]));
                }
                for(int i = 0;i < 18;i++)
                {
                    sql.append("," + yardage[i]);
                }
                sql.append("," + DbAdapter.cite(url) + "," + DbAdapter.cite(posid) + ")");
                db.executeUpdate(sql.toString());
            }
        } finally
        {
            db.close();
        }
        _cache.remove(_nNode + ":" + _nLanguage);
    }

    public void setTee(float[] difficultys,float[] gradients) throws SQLException
    {
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE Golf SET ");
        for(int i = 0;i < 5;i++)
        {
            if(i > 0)
            {
                sql.append(",");
            }
            sql.append("difficulty").append(i + 1).append("=").append(difficultys[i]);
            sql.append(",gradient").append(i + 1).append("=").append(gradients[i]);
        }
        sql.append(" WHERE node=" + this._nNode);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sql.toString());
        } finally
        {
            db.close();
        }
        this.difficultys = difficultys;
        this.gradients = gradients;
    }

    public static void delete(int iNode) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Golf WHERE node=" + iNode);
        } finally
        {
            db.close();
        }
        // _cache.remove(new Integer(_nListing));
    }

    public int getCourtCode() throws SQLException
    {
        return _iCourtCode;
    }

    public String getType() throws SQLException
    {
        if(_sType == null)
        {
            return "";
        } else
        {
            return _sType;
        }
    }

    public String getArea() throws SQLException
    {
        if(_sArea == null)
        {
            return "";
        } else
        {
            return _sArea;
        }

    }

    public String getMusicType() throws SQLException
    {
        if(_sMusicType == null)
        {
            return "";
        } else
        {
            return _sMusicType;
        }

    }

    public String getDeilStyle() throws SQLException
    {
        if(_sDeilStyle == null)
        {
            return "";
        } else
        {
            return _sDeilStyle;
        }

    }

    public String getCircumstance() throws SQLException
    {
        if(_sCircumstance == null)
        {
            return "";
        } else
        {
            return _sCircumstance;
        }
    }

    public String getStartBusinessHours() throws SQLException
    {
        if(_dStartBusinessHours == null)
        {
            return "";
        } else
        {
            return _dStartBusinessHours;
        }
    }

    public String getStopBusinessHours() throws SQLException
    {
        if(_dStopBusinessHours == null)
        {
            return "";
        } else
        {
            return _dStopBusinessHours;
        }
    }

    public String getSynopsis() throws SQLException
    {
        if(_sSynopsis == null)
        {
            return "";
        } else
        {
            return _sSynopsis;
        }
    }

    public String getCapability() throws SQLException
    {
        return _sCapability;
    }

    public String getPayment() throws SQLException
    {
        if(_sPayment == null)
        {
            return "";
        } else
        {
            return _sPayment;
        }
    }

    public String getIntro() throws SQLException
    {
        if(_sIntro == null)
        {
            return "";
        } else
        {
            return _sIntro;
        }
    }

    public String getTrait() throws SQLException
    {
        if(_sTrait == null)
        {
            return "";
        } else
        {

            return _sTrait;
        }
    }

    public String getDepreciate() throws SQLException
    {
        if(_sDepreciate == null)
        {
            return "";
        } else
        {

            return _sDepreciate;
        }
    }

    public Date getPracticeHours() throws SQLException
    {
        return _dPracticeHours;
    }

    public String getPracticeHoursToString() throws SQLException
    {
        if(_dPracticeHours == null)
        {
            return "";
        }
        return sdf.format(_dPracticeHours);
    }

    public String getAddress() throws SQLException
    {
        if(_sAddress == null)
        {
            return "";
        } else
        {

            return _sAddress;
        }
    }

    public byte[] getPicture() throws SQLException
    {
        return _byPicture;
    }

    public String getPrincipal() throws SQLException
    {
        if(_sPrincipal == null)
        {
            return "";
        } else
        {

            return _sPrincipal;
        }
    }

    public String getPhone() throws SQLException
    {
        if(_sPhone == null)
        {
            return "";
        } else
        {

            return _sPhone;
        }
    }

    public String getFax() throws SQLException
    {
        if(_sFax == null)
        {
            return "";
        } else
        {

            return _sFax;
        }
    }

    public String getPostalcode() throws SQLException
    {
        if(_iPostalcode == null)
        {
            return "";
        } else
        {
            return _iPostalcode;
        }
    }

    public String getCooperate() throws SQLException
    {
        if(_sCooperate == null)
        {
            return "";
        } else
        {

            return _sCooperate;
        }
    }

    public String getSponsor() throws SQLException
    {
        if(_sSponsor == null)
        {
            return "";
        } else
        {
            return _sSponsor;
        }
    }

    public int getOptions()
    {
        return _iOptions;
    }

    private void load(String sqlWhere) throws SQLException
    {
        int j = Node.getLanguage(_nNode,_nLanguage);
        DbAdapter db = new DbAdapter();
        try
        {
            db
                    .executeQuery("SELECT 1,logo,type, area, musictype,deilstyle,circumstance,startbusinesshours,stopbusinesshours,options,synopsis,capability,payment,intro,trait,depreciate,practicehours, address,principal,phone,fax,postalcode,cooperate,sponsor ,0,consume,acreage,averageconsume,price,among,operation,loo,destine,block,covercharge,member,email,ticket,map,stylist,cavity,haulm,plength,pgrass,cgrass,megreen9w,mggreen9w,gggreen9w,vigreen9w,megreen9h,mggreen9h,gggreen9h,vigreen9h,megreen18w,mggreen18w,gggreen18w,vigreen18w,megreen18h,mggreen18h,gggreen18h, vigreen18h, meexeunt, mgexeunt, ggexeunt, viexeunt, mecaddie9, mgcaddie9, ggcaddie9, vicaddie9, mecaddie9b, mgcaddie9b, ggcaddie9b, vicaddie9b, mecaddie18, mgcaddie18, ggcaddie18, vicaddie18, mecaddie18b, mgcaddie18b, ggcaddie18b, vicaddie18b, mereserved, mgreserved, ggreserved, vireserved, mebuggy9, mgbuggy9, ggbuggy9, vibuggy9, mebuggy18, mgbuggy18, ggbuggy18, vibuggy18, medriving, mgdriving, ggdriving, vidriving, meclub, mgclub, ggclub, viclub, mecommon, mgcommon, ggcommon, vicommon, mepro, mgpro, ggpro, vipro, mespiked, mgspiked, ggspiked, vispiked, meumbrella, mgumbrella, ggumbrella, viumbrella, mefacilities, mgfacilities, ggfacilities, vifacilities, menondesignatedw, mgnondesignatedw, ggnondesignatedw, vinondesignatedw, menondesignatedh, mgnondesignatedh, ggnondesignatedh, vinondesignatedh,difficulty,gradient,	standard1    ,	standard2    ,	standard3    ,	standard4    ,	standard5    ,	standard6    ,	standard7    ,	standard8    ,	standard9    ,	standard10 ,	standard11 ,	standard12 ,	standard13 ,	standard14 ,	standard15 ,	standard16 ,	standard17 ,	standard18 , hole1, hole2, hole3, hole4, hole5, hole6, hole7, hole8, hole9, hole10, hole11, hole12, hole13, hole14, hole15, hole16, hole17, hole18,difficulty1,difficulty2,difficulty3,difficulty4,difficulty5,gradient1,gradient2,gradient3,gradient4,gradient5,yardage1,yardage2,yardage3,yardage4,yardage5,yardage6,yardage7,yardage8,yardage9,yardage10,yardage11,yardage12,yardage13,yardage14,yardage15,yardage16,yardage17,yardage18,hits,url,posid FROM Golf WHERE node="
                                  + _nNode + " AND language=" + j + sqlWhere);
            if(db.next())
            {
                int x = 0;
                _sLogo = db.getString(2);
                _sType = db.getVarchar(j,_nLanguage,3);
                _sArea = db.getVarchar(j,_nLanguage,4);
                _sMusicType = db.getVarchar(j,_nLanguage,5);
                _sDeilStyle = db.getVarchar(j,_nLanguage,6);
                _sCircumstance = db.getVarchar(j,_nLanguage,7);
                _dStartBusinessHours = db.getVarchar(j,_nLanguage,8);
                _dStopBusinessHours = db.getVarchar(j,_nLanguage,9);
                /*
                 * _bDepot;//depot,ticket, dayOpenBusiness,electroTicket _bTicket; _bDayOpenBusiness; _bElectroTicket;
                 */
                _iOptions = db.getInt(10);
                // _bDepot=i;
                _sSynopsis = db.getText(j,_nLanguage,11);
                _sCapability = db.getVarchar(j,_nLanguage,12);
                _sPayment = db.getVarchar(j,_nLanguage,13);
                _sIntro = db.getVarchar(j,_nLanguage,14);
                _sTrait = db.getVarchar(j,_nLanguage,15);
                _sDepreciate = db.getVarchar(j,_nLanguage,16);
                _dPracticeHours = db.getDate(17);
                _sAddress = db.getVarchar(j,_nLanguage,18);
                _sPrincipal = db.getVarchar(j,_nLanguage,19);
                _sPhone = db.getString(20);
                _sFax = db.getString(21);
                _iPostalcode = db.getString(22);
                _sCooperate = db.getVarchar(j,_nLanguage,23);
                _sSponsor = db.getVarchar(j,_nLanguage,24);
                _iCourtCode = db.getInt(25);
                _sConsume = db.getVarchar(j,_nLanguage,26);
                _sAcreage = db.getVarchar(j,_nLanguage,27);
                _sAverageConsume = db.getVarchar(j,_nLanguage,28);
                _sPrice = db.getVarchar(j,_nLanguage,29);
                _sAmong = db.getVarchar(j,_nLanguage,30);
                _sOperation = db.getVarchar(j,_nLanguage,31);
                _sLoo = db.getVarchar(j,_nLanguage,32);
                _sDestine = db.getVarchar(j,_nLanguage,33);
                _sBlock = db.getVarchar(j,_nLanguage,34);
                _sCoverCharge = db.getVarchar(j,_nLanguage,35);
                _sMember = db.getVarchar(j,_nLanguage,36);
                _sEmail = db.getVarchar(j,_nLanguage,37);
                ticket = db.getVarchar(j,_nLanguage,38);
                map = db.getString(39);
                stylist = db.getVarchar(j,_nLanguage,40);
                cavity = db.getVarchar(j,_nLanguage,41);
                haulm = db.getVarchar(j,_nLanguage,42);
                pLength = db.getVarchar(j,_nLanguage,43);
                pGrass = db.getVarchar(j,_nLanguage,44);
                cGrass = db.getVarchar(j,_nLanguage,45);
                meGreen9W = db.getVarchar(j,_nLanguage,46);
                mgGreen9W = db.getVarchar(j,_nLanguage,47);
                ggGreen9W = db.getVarchar(j,_nLanguage,48);
                viGreen9W = db.getVarchar(j,_nLanguage,49);
                meGreen9H = db.getVarchar(j,_nLanguage,50);
                mgGreen9H = db.getVarchar(j,_nLanguage,51);
                ggGreen9H = db.getVarchar(j,_nLanguage,52);
                viGreen9H = db.getVarchar(j,_nLanguage,53);
                meGreen18W = db.getVarchar(j,_nLanguage,54);
                mgGreen18W = db.getVarchar(j,_nLanguage,55);
                ggGreen18W = db.getVarchar(j,_nLanguage,56);
                viGreen18W = db.getVarchar(j,_nLanguage,57);
                meGreen18H = db.getVarchar(j,_nLanguage,58);
                mgGreen18H = db.getVarchar(j,_nLanguage,59);
                ggGreen18H = db.getVarchar(j,_nLanguage,60);
                viGreen18H = db.getVarchar(j,_nLanguage,61);
                meExeunt = db.getVarchar(j,_nLanguage,62);
                mgExeunt = db.getVarchar(j,_nLanguage,63);
                ggExeunt = db.getVarchar(j,_nLanguage,64);
                viExeunt = db.getVarchar(j,_nLanguage,65);
                meCaddie9 = db.getVarchar(j,_nLanguage,66);
                mgCaddie9 = db.getVarchar(j,_nLanguage,67);
                ggCaddie9 = db.getVarchar(j,_nLanguage,68);
                viCaddie9 = db.getVarchar(j,_nLanguage,69);
                meCaddie9B = db.getVarchar(j,_nLanguage,70);
                mgCaddie9B = db.getVarchar(j,_nLanguage,71);
                ggCaddie9B = db.getVarchar(j,_nLanguage,72);
                viCaddie9B = db.getVarchar(j,_nLanguage,73);
                meCaddie18 = db.getVarchar(j,_nLanguage,74);
                mgCaddie18 = db.getVarchar(j,_nLanguage,75);
                ggCaddie18 = db.getVarchar(j,_nLanguage,76);
                viCaddie18 = db.getVarchar(j,_nLanguage,77);
                meCaddie18B = db.getVarchar(j,_nLanguage,78);
                mgCaddie18B = db.getVarchar(j,_nLanguage,79);
                ggCaddie18B = db.getVarchar(j,_nLanguage,80);
                viCaddie18B = db.getVarchar(j,_nLanguage,81);
                meReserved = db.getVarchar(j,_nLanguage,82);
                mgReserved = db.getVarchar(j,_nLanguage,83);
                ggReserved = db.getVarchar(j,_nLanguage,84);
                viReserved = db.getVarchar(j,_nLanguage,85);
                meBuggy9 = db.getVarchar(j,_nLanguage,86);
                mgBuggy9 = db.getVarchar(j,_nLanguage,87);
                ggBuggy9 = db.getVarchar(j,_nLanguage,88);
                viBuggy9 = db.getVarchar(j,_nLanguage,89);
                meBuggy18 = db.getVarchar(j,_nLanguage,90);
                mgBuggy18 = db.getVarchar(j,_nLanguage,91);
                ggBuggy18 = db.getVarchar(j,_nLanguage,92);
                viBuggy18 = db.getVarchar(j,_nLanguage,93);
                meDriving = db.getVarchar(j,_nLanguage,94);
                mgDriving = db.getVarchar(j,_nLanguage,95);
                ggDriving = db.getVarchar(j,_nLanguage,96);
                viDriving = db.getVarchar(j,_nLanguage,97);
                meClub = db.getVarchar(j,_nLanguage,98);
                mgClub = db.getVarchar(j,_nLanguage,99);
                ggClub = db.getVarchar(j,_nLanguage,100);
                viClub = db.getVarchar(j,_nLanguage,101);
                meCommon = db.getVarchar(j,_nLanguage,102);
                mgCommon = db.getVarchar(j,_nLanguage,103);
                ggCommon = db.getVarchar(j,_nLanguage,104);
                viCommon = db.getVarchar(j,_nLanguage,105);
                mePro = db.getVarchar(j,_nLanguage,106);
                mgPro = db.getVarchar(j,_nLanguage,107);
                ggPro = db.getVarchar(j,_nLanguage,108);
                viPro = db.getVarchar(j,_nLanguage,109);
                meSpiked = db.getVarchar(j,_nLanguage,110);
                mgSpiked = db.getVarchar(j,_nLanguage,111);
                ggSpiked = db.getVarchar(j,_nLanguage,112);
                viSpiked = db.getVarchar(j,_nLanguage,113);
                meUmbrella = db.getVarchar(j,_nLanguage,114);
                mgUmbrella = db.getVarchar(j,_nLanguage,115);
                ggUmbrella = db.getVarchar(j,_nLanguage,116);
                viUmbrella = db.getVarchar(j,_nLanguage,117);
                meFacilities = db.getVarchar(j,_nLanguage,118);
                mgFacilities = db.getVarchar(j,_nLanguage,119);
                ggFacilities = db.getVarchar(j,_nLanguage,120);
                viFacilities = db.getVarchar(j,_nLanguage,121);
                meNonDesignatedW = db.getVarchar(j,_nLanguage,122);
                mgNonDesignatedW = db.getVarchar(j,_nLanguage,123);
                ggNonDesignatedW = db.getVarchar(j,_nLanguage,124);
                viNonDesignatedW = db.getVarchar(j,_nLanguage,125);
                meNonDesignatedH = db.getVarchar(j,_nLanguage,126);
                mgNonDesignatedH = db.getVarchar(j,_nLanguage,127);
                ggNonDesignatedH = db.getVarchar(j,_nLanguage,128);
                viNonDesignatedH = db.getVarchar(j,_nLanguage,129);
                difficulty = db.getFloat(130);
                gradient = db.getFloat(131);
                x = 132;
                for(int index = 0;index < 18;index++)
                {
                    standard[index] = db.getInt(x++);
                }
                for(int index = 0;index < 18;index++)
                {
                    hole[index] = db.getString(x++);
                }
                for(int index = 0;index < 5;index++)
                {
                    difficultys[index] = db.getFloat(x++);
                }
                for(int index = 0;index < 5;index++)
                {
                    gradients[index] = db.getFloat(x++);
                }
                for(int i = 0;i < 18;i++)
                {
                    yardage[i] = db.getInt(x++);
                }
                hits = db.getInt(x++);
                url = db.getString(x++);
                posid = db.getString(x++);
            } else
            {
                Arrays.fill(standard,4);
            }
        } finally
        {
            db.close();
        }
        url = MT.f(url);

        if(posid == null || posid.length() < 1)
        {
            posid = "-A";
        }
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

    public void setCourtCode(int courtCode)
    {
        this._iCourtCode = courtCode;
    }

    public void setMusicType(String musicType)
    {
        this._sMusicType = musicType;
    }

    public void setLogo(String logo)
    {
        this._sLogo = logo;
    }

    public void setIntro(String intro)
    {
        this._sIntro = intro;
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

    public static void setHits(int node,int hits) throws SQLException
    {
        DbAdapter.execute("UPDATE Golf SET hits=" + (hits != -1 ? hits : "hits+1") + " WHERE node=" + node);
        _cache.remove(node);
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

    public void setStylist(String stylist)
    {
        this.stylist = stylist;
    }

    public void setCavity(String cavity)
    {
        this.cavity = cavity;
    }

    public void setHaulm(String haulm)
    {
        this.haulm = haulm;
    }

    public void setPLength(String pLength)
    {

        this.pLength = pLength;
    }

    public void setPGrass(String pGrass)
    {

        this.pGrass = pGrass;
    }

    public void setCGrass(String cGrass)
    {

        this.cGrass = cGrass;
    }

    public void setMeGreen9W(String meGreen9W)
    {
        this.meGreen9W = meGreen9W;
    }

    public void setMgGreen9W(String mgGreen9W)
    {
        this.mgGreen9W = mgGreen9W;
    }

    public void setGgGreen9W(String ggGreen9W)
    {
        this.ggGreen9W = ggGreen9W;
    }

    public void setViGreen9W(String viGreen9W)
    {
        this.viGreen9W = viGreen9W;
    }

    public void setMeGreen9H(String meGreen9H)
    {
        this.meGreen9H = meGreen9H;
    }

    public void setMgGreen9H(String mgGreen9H)
    {
        this.mgGreen9H = mgGreen9H;
    }

    public void setGgGreen9H(String ggGreen9H)
    {
        this.ggGreen9H = ggGreen9H;
    }

    public void setViGreen9H(String viGreen9H)
    {
        this.viGreen9H = viGreen9H;
    }

    public void setMeGreen18W(String meGreen18W)
    {
        this.meGreen18W = meGreen18W;
    }

    public void setMgGreen18W(String mgGreen18W)
    {
        this.mgGreen18W = mgGreen18W;
    }

    public void setGgGreen18W(String ggGreen18W)
    {
        this.ggGreen18W = ggGreen18W;
    }

    public void setViGreen18W(String viGreen18W)
    {
        this.viGreen18W = viGreen18W;
    }

    public void setMeGreen18H(String meGreen18H)
    {
        this.meGreen18H = meGreen18H;
    }

    public void setMgGreen18H(String mgGreen18H)
    {
        this.mgGreen18H = mgGreen18H;
    }

    public void setGgGreen18H(String ggGreen18H)
    {
        this.ggGreen18H = ggGreen18H;
    }

    public void setViGreen18H(String viGreen18H)
    {
        this.viGreen18H = viGreen18H;
    }

    public void setMeExeunt(String meExeunt)
    {
        this.meExeunt = meExeunt;
    }

    public void setMgExeunt(String mgExeunt)
    {
        this.mgExeunt = mgExeunt;
    }

    public void setGgExeunt(String ggExeunt)
    {
        this.ggExeunt = ggExeunt;
    }

    public void setViExeunt(String viExeunt)
    {
        this.viExeunt = viExeunt;
    }

    public void setMeCaddie9(String meCaddie9)
    {
        this.meCaddie9 = meCaddie9;
    }

    public void setMgCaddie9(String mgCaddie9)
    {
        this.mgCaddie9 = mgCaddie9;
    }

    public void setGgCaddie9(String ggCaddie9)
    {
        this.ggCaddie9 = ggCaddie9;
    }

    public void setViCaddie9(String viCaddie9)
    {
        this.viCaddie9 = viCaddie9;
    }

    public void setMeCaddie9B(String meCaddie9B)
    {
        this.meCaddie9B = meCaddie9B;
    }

    public void setMgCaddie9B(String mgCaddie9B)
    {
        this.mgCaddie9B = mgCaddie9B;
    }

    public void setGgCaddie9B(String ggCaddie9B)
    {
        this.ggCaddie9B = ggCaddie9B;
    }

    public void setViCaddie9B(String viCaddie9B)
    {
        this.viCaddie9B = viCaddie9B;
    }

    public void setMeCaddie18(String meCaddie18)
    {
        this.meCaddie18 = meCaddie18;
    }

    public void setMgCaddie18(String mgCaddie18)
    {
        this.mgCaddie18 = mgCaddie18;
    }

    public void setGgCaddie18(String ggCaddie18)
    {
        this.ggCaddie18 = ggCaddie18;
    }

    public void setViCaddie18(String viCaddie18)
    {
        this.viCaddie18 = viCaddie18;
    }

    public void setMeCaddie18B(String meCaddie18B)
    {
        this.meCaddie18B = meCaddie18B;
    }

    public void setMgCaddie18B(String mgCaddie18B)
    {
        this.mgCaddie18B = mgCaddie18B;
    }

    public void setGgCaddie18B(String ggCaddie18B)
    {
        this.ggCaddie18B = ggCaddie18B;
    }

    public void setViCaddie18B(String viCaddie18B)
    {
        this.viCaddie18B = viCaddie18B;
    }

    public void setMeReserved(String meReserved)
    {
        this.meReserved = meReserved;
    }

    public void setMgReserved(String mgReserved)
    {
        this.mgReserved = mgReserved;
    }

    public void setGgReserved(String ggReserved)
    {
        this.ggReserved = ggReserved;
    }

    public void setViReserved(String viReserved)
    {
        this.viReserved = viReserved;
    }

    public void setMeBuggy9(String meBuggy9)
    {
        this.meBuggy9 = meBuggy9;
    }

    public void setMgBuggy9(String mgBuggy9)
    {
        this.mgBuggy9 = mgBuggy9;
    }

    public void setViBuggy9(String viBuggy9)
    {
        this.viBuggy9 = viBuggy9;
    }

    public void setGgBuggy9(String ggBuggy9)
    {
        this.ggBuggy9 = ggBuggy9;
    }

    public void setMeBuggy18(String meBuggy18)
    {
        this.meBuggy18 = meBuggy18;
    }

    public void setMgBuggy18(String mgBuggy18)
    {
        this.mgBuggy18 = mgBuggy18;
    }

    public void setGgBuggy18(String ggBuggy18)
    {
        this.ggBuggy18 = ggBuggy18;
    }

    public void setViBuggy18(String viBuggy18)
    {
        this.viBuggy18 = viBuggy18;
    }

    public void setMeDriving(String meDriving)
    {
        this.meDriving = meDriving;
    }

    public void setMgDriving(String mgDriving)
    {
        this.mgDriving = mgDriving;
    }

    public void setGgDriving(String ggDriving)
    {
        this.ggDriving = ggDriving;
    }

    public void setViDriving(String viDriving)
    {
        this.viDriving = viDriving;
    }

    public void setMeClub(String meClub)
    {
        this.meClub = meClub;
    }

    public void setMgClub(String mgClub)
    {
        this.mgClub = mgClub;
    }

    public void setGgClub(String ggClub)
    {
        this.ggClub = ggClub;
    }

    public void setViClub(String viClub)
    {
        this.viClub = viClub;
    }

    public void setMeCommon(String meCommon)
    {
        this.meCommon = meCommon;
    }

    public void setMgCommon(String mgCommon)
    {
        this.mgCommon = mgCommon;
    }

    public void setGgCommon(String ggCommon)
    {
        this.ggCommon = ggCommon;
    }

    public void setViCommon(String viCommon)
    {
        this.viCommon = viCommon;
    }

    public void setMePro(String mePro)
    {
        this.mePro = mePro;
    }

    public void setMgPro(String mgPro)
    {
        this.mgPro = mgPro;
    }

    public void setGgPro(String ggPro)
    {
        this.ggPro = ggPro;
    }

    public void setViPro(String viPro)
    {
        this.viPro = viPro;
    }

    public void setMeSpiked(String meSpiked)
    {
        this.meSpiked = meSpiked;
    }

    public void setMgSpiked(String mgSpiked)
    {
        this.mgSpiked = mgSpiked;
    }

    public void setGgSpiked(String ggSpiked)
    {
        this.ggSpiked = ggSpiked;
    }

    public void setViSpiked(String viSpiked)
    {
        this.viSpiked = viSpiked;
    }

    public void setMeUmbrella(String meUmbrella)
    {
        this.meUmbrella = meUmbrella;
    }

    public void setMgUmbrella(String mgUmbrella)
    {
        this.mgUmbrella = mgUmbrella;
    }

    public void setGgUmbrella(String ggUmbrella)
    {
        this.ggUmbrella = ggUmbrella;
    }

    public void setViUmbrella(String viUmbrella)
    {
        this.viUmbrella = viUmbrella;
    }

    public void setMeFacilities(String meFacilities)
    {
        this.meFacilities = meFacilities;
    }

    public void setMgFacilities(String mgFacilities)
    {
        this.mgFacilities = mgFacilities;
    }

    public void setGgFacilities(String ggFacilities)
    {
        this.ggFacilities = ggFacilities;
    }

    public void setViFacilities(String viFacilities)
    {
        this.viFacilities = viFacilities;
    }

    public void setMeNonDesignatedW(String meNonDesignatedW)
    {
        this.meNonDesignatedW = meNonDesignatedW;
    }

    public void setMgNonDesignatedW(String mgNonDesignatedW)
    {
        this.mgNonDesignatedW = mgNonDesignatedW;
    }

    public void setGgNonDesignatedW(String ggNonDesignatedW)
    {
        this.ggNonDesignatedW = ggNonDesignatedW;
    }

    public void setViNonDesignatedW(String viNonDesignatedW)
    {
        this.viNonDesignatedW = viNonDesignatedW;
    }

    public void setMeNonDesignatedH(String meNonDesignatedH)
    {
        this.meNonDesignatedH = meNonDesignatedH;
    }

    public void setMgNonDesignatedH(String mgNonDesignatedH)
    {
        this.mgNonDesignatedH = mgNonDesignatedH;
    }

    public void setGgNonDesignatedH(String ggNonDesignatedH)
    {
        this.ggNonDesignatedH = ggNonDesignatedH;
    }

    public void setViNonDesignatedH(String viNonDesignatedH)
    {
        this.viNonDesignatedH = viNonDesignatedH;
    }

    public void setDifficulty(float difficulty)
    {
        this.difficulty = difficulty;
    }

    public void setGradient(float gradient)
    {
        this.gradient = gradient;
    }

    public void setStandard(int[] standard)
    {
        this.standard = standard;
    }

    public void setHole(String[] hole)
    {
        this.hole = hole;
    }

    public String getTicket()
    {
        return ticket;
    }

    public int getHolisticMark()
    {
        loadMark();
        return holisticMark;
    }

    public int getAuraMark()
    {
        loadMark();
        return auraMark;
    }

    public int getServeMark()
    {
        loadMark();
        return serveMark;
    }

    public int getMusicMark()
    {
        loadMark();
        return musicMark;
    }

    public int getCrowdMark()
    {
        loadMark();
        return crowdMark;
    }

    public int getDrinkMark()
    {
        loadMark();
        return drinkMark;
    }

    public int getDeliMark()
    {
        loadMark();
        return deliMark;
    }

    public int getToiletMark()
    {
        loadMark();
        return toiletMark;
    }

    public int getRelaxMark()
    {
        loadMark();
        return relaxMark;
    }

    public int getLamplightMark()
    {
        loadMark();
        return lamplightMark;
    }

    public int getTemperatureMark()
    {
        loadMark();
        return temperatureMark;
    }

    public int getAirMark()
    {
        loadMark();
        return airMark;
    }

    public int getSafetyMark()
    {
        loadMark();
        return safetyMark;
    }

    public int getBelleMark()
    {
        loadMark();
        return belleMark;
    }

    public int getPriceMark()
    {
        loadMark();
        return priceMark;
    }

    public int getDegreeMark()
    {
        loadMark();
        return degreeMark;
    }

    public String getMap()
    {
        return map;
    }

    public String getStylist()
    {
        return stylist;
    }

    public String getCavity()
    {
        return cavity;
    }

    public String getHaulm()
    {
        return haulm;
    }

    public String getPLength()
    {

        return pLength;
    }

    public String getPGrass()
    {

        return pGrass;
    }

    public String getCGrass()
    {

        return cGrass;
    }

    public String getMeGreen9W()
    {
        return meGreen9W;
    }

    public String getMgGreen9W()
    {
        return mgGreen9W;
    }

    public String getGgGreen9W()
    {
        return ggGreen9W;
    }

    public String getViGreen9W()
    {
        return viGreen9W;
    }

    public String getMeGreen9H()
    {
        return meGreen9H;
    }

    public String getMgGreen9H()
    {
        return mgGreen9H;
    }

    public String getGgGreen9H()
    {
        return ggGreen9H;
    }

    public String getViGreen9H()
    {
        return viGreen9H;
    }

    public String getMeGreen18W()
    {
        return meGreen18W;
    }

    public String getMgGreen18W()
    {
        return mgGreen18W;
    }

    public String getGgGreen18W()
    {
        return ggGreen18W;
    }

    public String getViGreen18W()
    {
        return viGreen18W;
    }

    public String getMeGreen18H()
    {
        return meGreen18H;
    }

    public String getMgGreen18H()
    {
        return mgGreen18H;
    }

    public String getGgGreen18H()
    {
        return ggGreen18H;
    }

    public String getViGreen18H()
    {
        return viGreen18H;
    }

    public String getMeExeunt()
    {
        return meExeunt;
    }

    public String getMgExeunt()
    {
        return mgExeunt;
    }

    public String getGgExeunt()
    {
        return ggExeunt;
    }

    public String getViExeunt()
    {
        return viExeunt;
    }

    public String getMeCaddie9()
    {
        return meCaddie9;
    }

    public String getMgCaddie9()
    {
        return mgCaddie9;
    }

    public String getGgCaddie9()
    {
        return ggCaddie9;
    }

    public String getViCaddie9()
    {
        return viCaddie9;
    }

    public String getMeCaddie9B()
    {
        return meCaddie9B;
    }

    public String getMgCaddie9B()
    {
        return mgCaddie9B;
    }

    public String getGgCaddie9B()
    {
        return ggCaddie9B;
    }

    public String getViCaddie9B()
    {
        return viCaddie9B;
    }

    public String getMeCaddie18()
    {
        return meCaddie18;
    }

    public String getMgCaddie18()
    {
        return mgCaddie18;
    }

    public String getGgCaddie18()
    {
        return ggCaddie18;
    }

    public String getViCaddie18()
    {
        return viCaddie18;
    }

    public String getMeCaddie18B()
    {
        return meCaddie18B;
    }

    public String getMgCaddie18B()
    {
        return mgCaddie18B;
    }

    public String getGgCaddie18B()
    {
        return ggCaddie18B;
    }

    public String getViCaddie18B()
    {
        return viCaddie18B;
    }

    public String getMeReserved()
    {
        return meReserved;
    }

    public String getMgReserved()
    {
        return mgReserved;
    }

    public String getGgReserved()
    {
        return ggReserved;
    }

    public String getViReserved()
    {
        return viReserved;
    }

    public String getMeBuggy9()
    {
        return meBuggy9;
    }

    public String getMgBuggy9()
    {
        return mgBuggy9;
    }

    public String getViBuggy9()
    {
        return viBuggy9;
    }

    public String getGgBuggy9()
    {
        return ggBuggy9;
    }

    public String getMeBuggy18()
    {
        return meBuggy18;
    }

    public String getMgBuggy18()
    {
        return mgBuggy18;
    }

    public String getGgBuggy18()
    {
        return ggBuggy18;
    }

    public String getViBuggy18()
    {
        return viBuggy18;
    }

    public String getMeDriving()
    {
        return meDriving;
    }

    public String getMgDriving()
    {
        return mgDriving;
    }

    public String getGgDriving()
    {
        return ggDriving;
    }

    public String getViDriving()
    {
        return viDriving;
    }

    public String getMeClub()
    {
        return meClub;
    }

    public String getMgClub()
    {
        return mgClub;
    }

    public String getGgClub()
    {
        return ggClub;
    }

    public String getViClub()
    {
        return viClub;
    }

    public String getMeCommon()
    {
        return meCommon;
    }

    public String getMgCommon()
    {
        return mgCommon;
    }

    public String getGgCommon()
    {
        return ggCommon;
    }

    public String getViCommon()
    {
        return viCommon;
    }

    public String getMePro()
    {
        return mePro;
    }

    public String getMgPro()
    {
        return mgPro;
    }

    public String getGgPro()
    {
        return ggPro;
    }

    public String getViPro()
    {
        return viPro;
    }

    public String getMeSpiked()
    {
        return meSpiked;
    }

    public String getMgSpiked()
    {
        return mgSpiked;
    }

    public String getGgSpiked()
    {
        return ggSpiked;
    }

    public String getViSpiked()
    {
        return viSpiked;
    }

    public String getMeUmbrella()
    {
        return meUmbrella;
    }

    public String getMgUmbrella()
    {
        return mgUmbrella;
    }

    public String getGgUmbrella()
    {
        return ggUmbrella;
    }

    public String getViUmbrella()
    {
        return viUmbrella;
    }

    public String getMeFacilities()
    {
        return meFacilities;
    }

    public String getMgFacilities()
    {
        return mgFacilities;
    }

    public String getGgFacilities()
    {
        return ggFacilities;
    }

    public String getViFacilities()
    {
        return viFacilities;
    }

    public String getMeNonDesignatedW()
    {
        return meNonDesignatedW;
    }

    public String getMgNonDesignatedW()
    {
        return mgNonDesignatedW;
    }

    public String getGgNonDesignatedW()
    {
        return ggNonDesignatedW;
    }

    public String getViNonDesignatedW()
    {
        return viNonDesignatedW;
    }

    public String getMeNonDesignatedH()
    {
        return meNonDesignatedH;
    }

    public String getMgNonDesignatedH()
    {
        return mgNonDesignatedH;
    }

    public String getGgNonDesignatedH()
    {
        return ggNonDesignatedH;
    }

    public String getViNonDesignatedH()
    {
        return viNonDesignatedH;
    }

    public float getDifficulty()
    {
        return difficulty;
    }

    public float getGradient()
    {
        return gradient;
    }

    public int[] getStandard()
    {
        return standard;
    }

    public String[] getHole()
    {
        return hole;
    }

    public void setMark(int holisticMark,int relaxMark,int auraMark,int lamplightMark,int serveMark,int temperatureMark,int musicMark,int airMark,int crowdMark,int safetyMark,int drinkMark,int belleMark,int deliMark,int priceMark) throws SQLException
    {
        DbAdapter.execute("UPDATE Golf SET HolisticMark=HolisticMark+" + holisticMark + ",AuraMark=AuraMark+" + auraMark + ",ServeMark=ServeMark+" + serveMark + ",MusicMark=MusicMark+" + musicMark + ",CrowdMark=CrowdMark+" + crowdMark + ",DrinkMark=DrinkMark+" + drinkMark
                          + ",DeliMark=DeliMark+" + deliMark + ",ToiletMark=ToiletMark+" + 0 + ",RelaxMark=RelaxMark+" + relaxMark + ",LamplightMark=LamplightMark+" + lamplightMark + ",TemperatureMark=TemperatureMark+" + temperatureMark + ",AirMark=AirMark+" + airMark + ",SafetyMark=SafetyMark+" + safetyMark + ",BelleMark=BelleMark+" + belleMark +
                          ",PriceMark=PriceMark+" + priceMark + ",DegreeMark=DegreeMark+1 WHERE node=" + this._nNode);
        _bLoadMark = false;
    }

    private void loadMark()
    {
        if(!_bLoadMark)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT DegreeMark,HolisticMark,AuraMark,ServeMark,MusicMark,CrowdMark,DrinkMark,DeliMark,ToiletMark,RelaxMark,LamplightMark,TemperatureMark,AirMark,SafetyMark,BelleMark,PriceMark FROM Golf WHERE  node =" + this._nNode);
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
            } catch(Exception ex)
            {
                ex.printStackTrace();
            } finally
            {
                db.close();
            }
            _bLoadMark = true;
        }
    }

    public static String getDetail(Node node,Http h,Listing listing,String target,tea.resource.Resource r) throws SQLException
    {
        int language = h.language;
        StringBuilder htm = new StringBuilder();
        Golf obj = Golf.find(node._nNode,language);
        boolean bool = false;
        Span span = null;
        String subject = node.getSubject(language);
        ListingDetail detail = ListingDetail.find(listing.getListing(),62,language);
        Iterator e = detail.keys();
        while(e.hasNext())
        {
            String item = (String) e.next();
            int istype = detail.getIstype(item);
            if(istype == 0)
            {
                continue;
            }
            String v = "";
            Anchor anchor = null;
            String before = detail.getBeforeItem(item);
            String after = detail.getAfterItem(item);
            int boolAnchor = detail.getAnchor(item);
            if(item.equals("Name"))
            {
                v = subject;
            } else if(item.equals("stylist")) // 设计师
            {
                v = obj.getStylist();
            } else if(item.equals("cavity")) // 总洞数
            {
                v = obj.getCavity();
            } else if(item.equals("haulm")) // 标准杆
            {
                v = obj.getHaulm();
            } else if(item.equals("plength")) // 球道长度
            {
                v = obj.getPLength();
            } else if(item.equals("pgrass")) // 球道草种
            {
                v = obj.getPGrass();
            } else if(item.equals("cgrass")) // 球洞区草种
            {
                v = obj.getCGrass();
            } else if(item.equals("standard")) // 标准杆细节
            {
                int standard[] = obj.getStandard();
                StringBuilder sb = new StringBuilder((before.length() + after.length() + 1) * standard.length);
                for(int index = 0;index < standard.length;index++)
                {
                    sb.append(before + standard[index] + after);
                }
                v = sb.toString();
                before = after = "";
            } else if(item.equals("hole")) // 球洞图
            {
                String hole[] = obj.getHole();
                StringBuilder sb = new StringBuilder((before.length() + after.length() + 127) * hole.length);
                for(int index = 0;index < hole.length;index++)
                {
                    sb.append(before);
                    if(hole[index] != null && hole[index].length() > 0)
                    {
                        tea.html.Image img = new tea.html.Image(hole[index]);
                        img.setHeight(20);
                        img.setWidth(20);
                        tea.html.Anchor a = new Anchor(hole[index],img);
                        a.setTarget("_blank");
                        sb.append(a);
                    }
                    sb.append(after);
                }
                v = sb.toString();
                before = after = "";
            } else if(item.equals("pricelist")) // 价格表
            {
                v = "<include src=\"/jsp/type/golf/GolfPriceList.jsp?node=" + node._nNode + "&language=" + language + "\"/>";
            } else if(item.equals("NightShopCode"))
            {
                v = String.valueOf(obj.getCourtCode());
            } else if(item.equals("Logo"))
            {
                v = new Image(obj.getLogo()).toString();
            } else if(item.equals("Type"))
            {
                v = obj.getType();
                try
                {
                    v = Table.find(Table.GTYPE,Integer.parseInt(v)).name;
                } catch(Exception ex)
                {}
            } else if(item.equals("Area"))
            {
                v = obj.getArea();
            } else if(item.equals("MusicType"))
            {
                v = obj.getMusicType();
            } else if(item.equals("DeilStyle"))
            {
                v = obj.getDeilStyle();
            } else if(item.equals("Circumstance"))
            {
                v = obj.getCircumstance();
            } else if(item.equals("Synopsis"))
            {
                v = obj.getSynopsis();
            } else if(item.equals("Capability"))
            {
                v = String.valueOf(obj.getCapability());
            } else if(item.equals("Payment"))
            {
                v = obj.getPayment();
            } else if(item.equals("Intro"))
            {
                if((node.getOptions() & 0x40L) == 0)
                { // synopsis
                    v = Text.toHTML(node.getText2(language));
                } else
                {
                    v = node.getText2(language);
                }
                // v=  obj.getIntro();//////////////////
            } else if(item.equals("Trait"))
            {
                v = obj.getTrait();
            } else if(item.equals("Depreciate"))
            {
                v = obj.getDepreciate();
            } else if(item.equals("PracticeHours"))
            {
                v = obj.getPracticeHoursToString();
            } else if(item.equals("Address"))
            {
                v = obj.getAddress();
            } else if(item.equals("Picture"))
            {
                java.util.Iterator it = TypePicture.findByNode(node._nNode,0,1).iterator();
                if(it.hasNext())
                {
                    TypePicture tp = (TypePicture) it.next();
                    v = new tea.html.Image(tp.getPicture(),tp.getPicname()).toString();
                    switch(boolAnchor)
                    {
                    case 2:
                        if(tp.getPicture2() != null && tp.getPicture2().length() > 0)
                        {
                            anchor = new Anchor("javascript:window.showModalDialog('" + tp.getPicture2() + "','self','edge:raised;help:0;resizable:1;dialogWidth:" + (tp.getWidth() + 9) + "px;dialogHeight:" + (tp.getHeight() + 27 + 20) + "px;')",v);
                        }
                        break;
                    }
                }
            } else if(item.equals("PictureName"))
            {
                java.util.Iterator it = TypePicture.findByNode(node._nNode,0,1).iterator();
                if(it.hasNext())
                {
                    TypePicture tp = (TypePicture) it.next();
                    v = tp.getPicname();
                }
            } else if(item.equals("Picture2"))
            {
                java.util.Iterator it = TypePicture.findByNode(node._nNode,1,1).iterator();
                if(it.hasNext())
                {
                    TypePicture tp = (TypePicture) it.next();
                    v = new tea.html.Image(tp.getPicture(),tp.getPicname()).toString();
                    switch(boolAnchor)
                    {
                    case 2: // 连接到大图
                        if(tp.getPicture2() != null && tp.getPicture2().length() > 0)
                        {
                            anchor = new Anchor("javascript:window.showModalDialog('" + tp.getPicture2() + "','self','edge:raised;help:0;resizable:1;dialogWidth:" + (tp.getWidth() + 9) + "px;dialogHeight:" + (tp.getHeight() + 27 + 20) + "px;')",v);
                        }
                        break;
                    }
                }
            } else if(item.equals("PictureName2"))
            {
                java.util.Iterator it = TypePicture.findByNode(node._nNode,1,1).iterator();
                if(it.hasNext())
                {
                    TypePicture tp = (TypePicture) it.next();
                    v = tp.getPicname();
                }
            } else if(item.equals("OtherPicture"))
            {
                java.util.Iterator it = TypePicture.findByNode(node._nNode,2,200).iterator();
                while(it.hasNext())
                {
                    TypePicture tp = (TypePicture) it.next();
                    String img = new tea.html.Image(tp.getPicture(),tp.getPicname()).toString();
                    switch(boolAnchor)
                    {
                    case 2:
                        if(tp.getPicture2() != null && tp.getPicture2().length() > 0)
                        {
                            anchor = new Anchor("javascript:window.showModalDialog('" + tp.getPicture2() + "','self','edge:raised;help:0;resizable:1;dialogWidth:" + (tp.getWidth() + 9) + "px;dialogHeight:" + (tp.getHeight() + 27 + 20) + "px;')",img);
                            span = new Span(anchor);
                        } else
                        {
                            span = new Span(img);
                        }
                        break;
                    case 1:
                        anchor = new Anchor("/servlet/Golf?node=" + node._nNode + "&language=" + language,v);
                        anchor.setTarget(target);
                        span = new Span(anchor);
                        break;
                    default:
                        span = new Span(img);
                    }
                    span.setId("CourtIDOtherPicture");
                    htm.append(before).append(span).append(after);
                }
                continue;
            } else if(item.equals("OtherPictureName"))
            {
                java.util.Iterator it = TypePicture.findByNode(node._nNode,2,200).iterator();
                while(it.hasNext())
                {
                    TypePicture tp = (TypePicture) it.next();
                    String img = tp.getPicname();
                    switch(boolAnchor)
                    {
                    case 2:
                        if(tp.getPicture2() != null && tp.getPicture2().length() > 0)
                        {
                            anchor = new Anchor("javascript:window.showModalDialog('" + tp.getPicture2() + "','self','edge:raised;help:0;resizable:1;dialogWidth:" + (tp.getWidth() + 9) + "px;dialogHeight:" + (tp.getHeight() + 27 + 20) + "px;')",img);
                            span = new Span(anchor);
                        } else
                        {
                            span = new Span(img);
                        }
                        break;
                    case 1:
                        anchor = new Anchor("/servlet/Golf?node=" + node._nNode + "&language=" + language,v);
                        anchor.setTarget(target);
                        span = new Span(anchor);
                        break;
                    default:
                        span = new Span(img);
                    }
                    span.setId("CourtIDOtherPictureName");
                    htm.append(before).append(span).append(after);
                }
                continue;
            } else if(item.equals("Principal"))
            {
                v = obj.getPrincipal();
            } else if(item.equals("Phone"))
            {
                v = obj.getPhone();
            } else if(item.equals("Fax"))
            {
                v = obj.getFax();
            } else if(item.equals("Postalcode"))
            {
                v = obj.getPostalcode();
            } else if(item.equals("Cooperate"))
            {
                v = obj.getCooperate();
            } else if(item.equals("Acreage"))
            {
                v = obj.getAcreage();
            } else if(item.equals("AverageConsume"))
            {
                v = obj.getAverageConsume();
            } else if(item.equals("Consume"))
            {
                v = obj.getConsume();
            } else if(item.equals("Price"))
            {
                v = obj.getPrice();
            } else if(item.equals("Among"))
            {
                v = obj.getAmong();
            } else if(item.equals("Operation"))
            {
                v = obj.getOperation();
            } else if(item.equals("Loo"))
            {
                v = obj.getLoo();
            } else if(item.equals("Destine"))
            {
                v = obj.getDestine();
            } else if(item.equals("Block"))
            {
                v = obj.getBlock();
            } else if(item.equals("CoverCharge"))
            {
                v = obj.getCoverCharge();
            } else if(item.equals("Member"))
            {
                v = obj.getMember();
            } else if(item.equals("Browse"))
            {
                v = String.valueOf(node.getClick());
                //item = "NodeIDClick\" label=\"" + node._nNode;
            } else if(item.equals("Email"))
            {
                v = obj.getEmail();
            } else if(item.equals("Sponsor"))
            {
                v = obj.getSponsor();
            } else if(item.equalsIgnoreCase("BusinessHours"))
            {
                v = obj.getStartBusinessHours(); // + "--" + obj.getStopBusinessHours();
            } else if(item.equalsIgnoreCase("DayOpenBusiness"))
            {
                bool = (obj.getOptions() & 4) != 0;
                v = bool ? r.getString(language,"Have") : r.getString(language,"Void");
            } else if(item.equalsIgnoreCase("ElectroTicket"))
            {
                bool = (obj.getOptions() & 8) != 0;
                v = bool ? r.getString(language,"Have") : r.getString(language,"Void");
            } else if(item.equalsIgnoreCase("Ticket"))
            {
                v = obj.getTicket();
                // bool = obj.getOptions() & 2) != 0;
                // v=  bool ? r.getString(language, "Have") : r.getString(language, "Void");
            } else if(item.equalsIgnoreCase("Depot"))
            {
                bool = (obj.getOptions() & 1) != 0;
                v = bool ? r.getString(language,"Have") : r.getString(language,"Void");
            } else if(item.equalsIgnoreCase("GradeTarget"))
            {
                v = "<include src=\"/jsp/type/golf/EditGolfMark.jsp?node=" + node._nNode + "&nexturl=/servlet/Node%3Fnode%3D" + node._nNode + "\"/>"; // v=  "<form name=\"form1\" method=\"post\" action=\"EditNightShop\"> <input type=\"hidden\" name=\"nextUrl\" value=\"" + teasession.getRequestURI() + "?" + teasession.getQueryString() + "\"> <input type=\"hidden\" name=\"node\" value=\"" + node._nNode + "\">
            } else if(item.equalsIgnoreCase("Result"))
            {
                v = "<include src=\"/jsp/type/golf/GolfMark.jsp?node=" + node._nNode + "&language=" + h.language + "\"/>";
            } else if(item.equalsIgnoreCase("ResultButton"))
            {
                v = new Button(1,"CB","ResultButton","投票结果","window.open('/jsp/type/golf/GolfMark.jsp?node=" + node._nNode + "');").toString();
            } else if(item.equalsIgnoreCase("GradeButton"))
            {
                v = new Button(1,"CB","GradeButton","我要打分","window.showModalDialog('/jsp/type/golf/EditGolfMark.jsp?community=" + node.getCommunity() + "&node=" + node._nNode + "',self,'resizable:1;dialogWidth:500px;dialogHeight:400px;');").toString();
            } else if(item.equals("map"))
            {
                String map = obj.getMap();
                if(map != null && map.startsWith("http://")) //旧版
                {
                    v = new tea.html.Button("map",r.getString(language,"CBMap"),"javascript:window.showModalDialog('" + map + "','','edge:raised;help:0;resizable:1;dialogWidth:609px;dialogHeight:527px;');").toString(); // +9 +27+20
                }
                GMap gm = GMap.find(node._nNode);
                if(gm != null && !gm.isHidden())
                {
                    String url = "/jsp/admin/map/ViewGMap.jsp?node=" + node._nNode + "&amp;point=" + gm.getLat() + "," + gm.getLng() + "," + gm.getZoom();
                    if(boolAnchor == 0)
                    {
                        v = "<iframe src=" + url + " frameborder='0' scrolling='no' width='600' height='500'></iframe>";
                    } else
                    {
                        v = "<input type='button' value='" + r.getString(language,"CBMap") + "' onclick=\"window.open('" + url + "','_blank','width=600,height=500');\" />";
                    }
                }
                boolAnchor = 0;
            } else if(item.equals("difficulty"))
            {
                v = String.valueOf(obj.getDifficulty());
            } else if(item.equals("gradient"))
            {
                v = String.valueOf(obj.getGradient());
            }
            //限制字数
            v = detail.getOptionsToHtml(item,node,v);
            if(boolAnchor == 0)
            {
                span = new Span(v);
            } else if(anchor != null)
            {
                span = new Span(anchor);
            } else
            {
                anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/golf/" + node._nNode + "-" + language + ".htm",v);
                anchor.setTarget(target);
                span = new Span(anchor);
            }
            span.setId("CourtID" + item);
            htm.append(before).append(span).append(after);
        }
        return htm.toString();
    }

}
