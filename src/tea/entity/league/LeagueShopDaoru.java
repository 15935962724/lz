package tea.entity.league;


import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;

public class LeagueShopDaoru extends Entity
{
    private int id; //
    private String bumen; //加盟店名称id,bumen,lsname,community,lsbusiness,health,legalperson,buytype,province,city,region,port,number,tel,lsbuyname,lsbuysex,lsbuytel,lsbuyschool,lsbuyjob,lsbuypost,lsbuycsfalg,shopkeepername,sksex,sktel,skschool,skjob,skpost,csarea,lstype,lsstype,regdate,adddate,startdate,bednum,shoparea,spa,shopkeeper,adviser,hairdresser,fixmember,movemember,computernum,network,Stringernettype,systemtype
    private String lsname; //加盟店名称
    private String community; //社区
    private String lsbusiness; //营业执照
    private String health; //卫生登记证书
    private String legalperson; //法人
    private String buytype; //经营性质
    private String province; //省
    private String city; //市
    private String region; //区
    private String port; //港
    private String number; //号
    private String tel; //营业电话号
    private String lsbuyname; //加盟商姓名
    private String lsbuysex; //加盟商性别
    private String lsbuytel; //加盟商手机号
    private String lsbuyschool; //加盟商学历
    private String lsbuyjob; //加盟之前所从事的职业
    private String lsbuypost; //加盟之前所从事行业的职务
    private String lsbuycsfalg; //是否专职经营连锁店
    private String shopkeepername; //店长姓名
    private String sksex; ///店长性别  0 先生 1  女士
    private String sktel; //手机电话
    private String skschool; ///店长最高学历
    private String skjob; ///
    private String skpost; ///
    private String csarea; //chain store连锁商店 区域 华北
    private String lstype; //唯美度
    private String lsstype; //类型
    private String regdate; //添加时间
    private String adddate; //加盟时间
    private String startdate; //开业时间
    private String bednum; //美容床数
    private String shoparea; //经营面积
    private String spa; //SPA
    private String shopkeeper; //店长
    private String adviser; //前台顾问
    private String hairdresser; //美容师
    private String fixmember; //固定
    private String movemember; //流动顾客
    private String computernum; //连锁店是否有电脑
    private String network;
    private String internettype; //上网方式  ADSL,宽带,拔号,本店无法上网
    private String systemtype; //会员系统
    private String lsstatic; //加盟店状态    {"正常","危机处理中","删除","彻底删除"};
    private String updatemember; //加盟店状态的修改人
    private String updatedate; //加盟店状态的修改人
    private String summoney; //总金额

    public static final String LSSTATIC[] =
            {"正常","危机处理中","以删除的加盟店"};

    public static final String FALGS[] =
            {"是","否"};

    public static final String SHOWSEX[] =
            {"先生","女士"};

    public static final String YESNO[] =
            {"有","没有"};

    public static final String INTERNETTYPES[] =
            {"ADSL","宽带","拔号","本店无法上网"};

    public static final String CSAREA[] =
                                          {"------","华东地区","华南地区","华中地区","华北地区","西北地区","西南地区","东北地区","台港澳地区"};


    public static LeagueShopDaoru find(int id) throws SQLException
    {
        return new LeagueShopDaoru(id);
    }


    public LeagueShopDaoru(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select id,加盟店名称,营业执照,卫生登记证书,法人,经营性质,所在区域,省,市,区,港,号,营业电话号,加盟商姓名,加盟商性别,加盟商手机号,加盟商学历,加盟商之前所从事的职业,加盟商之前所从事行业的职务,是否专职经营连锁店,店长姓名,店长性别,手机电话,店长最高学历,店长加盟之前从事的职业,店长加盟之前从事行业的职务,加盟店类型,加盟店级别,添加时间,加盟时间,开业时间,美容床数,经营面积,SPA,店长,前台顾问,美容师,固定,流动顾客,连锁店是否有电脑,是否有网络连接,上网方式,会员系统,加盟店状态,预付款金额 from LeagueShopDaoru where id=" + id);
            if(db.next())
            {
                int j = 1;
                id = db.getInt(j++);
                lsname = db.getString(j++);
                lsbusiness = db.getString(j++);
                health = db.getString(j++);
                legalperson = db.getString(j++);
                buytype = db.getString(j++);
                csarea = db.getString(j++);
                province = db.getString(j++);
                city = db.getString(j++);
                region = db.getString(j++);
                port = db.getString(j++);
                number = db.getString(j++);
                tel = db.getString(j++);
                lsbuyname = db.getString(j++);
                lsbuysex = db.getString(j++);
                lsbuytel = db.getString(j++);
                lsbuyschool = db.getString(j++);
                lsbuyjob = db.getString(j++);
                lsbuypost = db.getString(j++);
                lsbuyjob = db.getString(j++);
                shopkeepername = db.getString(j++);
                lsbuyjob = db.getString(j++);
                sktel = db.getString(j++);
                skschool = db.getString(j++);
                skjob = db.getString(j++);
                skpost = db.getString(j++);
                lstype = db.getString(j++);
                lsstype = db.getString(j++);
                regdate = db.getString(j++);
                adddate = db.getString(j++);
                startdate = db.getString(j++);
                bednum = db.getString(j++);
                shoparea = db.getString(j++);
                spa = db.getString(j++);
                shopkeeper = db.getString(j++);
                adviser = db.getString(j++);
                hairdresser = db.getString(j++);
                fixmember = db.getString(j++);
                movemember = db.getString(j++);
                computernum = db.getString(j++);
                network = db.getString(j++);
                internettype = db.getString(j++);
                systemtype = db.getString(j++);
                lsstatic = db.getString(j++);
                summoney = db.getString(j++);

            }
        } finally
        {
            db.close();
        }
    }


    public static Enumeration findByCommunity(String community,String sql) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM LeagueShopDaoru WHERE 1=1 " + sql);
            while(db.next())
            {
                v.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }


    public String getAdddate()
    {
        return adddate;
    }

    public String getAdddateToString()
    {
        if(adddate == null)
        {
            return "";
        } else
        {
            return LeagueShopDaoru.sdf.format(adddate);
        }
    }

    public String getAdviser()
    {
        return adviser;
    }

    public String getShoparea()
    {
        return shoparea;
    }

    public String getBednum()
    {
        return bednum;
    }

    public String getBumen()
    {
        return bumen;
    }

    public String getBuytype()
    {
        return buytype;
    }

    public String getCity()
    {
        return city;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getComputernum()
    {
        return computernum;
    }

    public String getCsarea()
    {
        return csarea;
    }

    public String getFixmember()
    {
        return fixmember;
    }

    public String getHairdresser()
    {
        return hairdresser;
    }

    public String getHealth()
    {
        return health;
    }

    public int getId()
    {
        return id;
    }

    public String getLsbuytel()
    {
        return lsbuytel;
    }

    public String getLsbuyname()
    {
        return lsbuyname;
    }

    public String getLsbuypost()
    {
        return lsbuypost;
    }

    public String getLsbuyschool()
    {
        return lsbuyschool;
    }

    public String getLsbuysex()
    {
        return lsbuysex;
    }

    public String getLsname()
    {
        return lsname;
    }

    public String getLsstype()
    {
        return lsstype;
    }

    public String getLstype()
    {
        return lstype;
    }

    public String getMovemember()
    {
        return movemember;
    }

    public String getNumber()
    {
        return number;
    }

    public String getPort()
    {
        return port;
    }

    public String getProvince()
    {
        return province;
    }

    public String getRegdate()
    {
        return regdate;
    }

    public String getRegdateToString()
    {
        if(regdate == null)
        {
            return "";
        } else
        {
            return LeagueShopDaoru.sdf.format(regdate);
        }
    }


    public String getRegion()
    {
        return region;
    }

    public String getShopkeeper()
    {
        return shopkeeper;
    }

    public String getShopkeepername()
    {
        return shopkeepername;
    }

    public String getSkjob()
    {
        return skjob;
    }

    public String getSkpost()
    {
        return skpost;
    }

    public String getSkschool()
    {
        return skschool;
    }

    public String getSksex()
    {
        return sksex;
    }

    public String getSktel()
    {
        return sktel;
    }

    public String getSpa()
    {
        return spa;
    }

    public String getStartdate()
    {
        return startdate;
    }

    public String getStartdateToString()
    {
        if(startdate == null)
        {
            return "";
        } else
        {

            return LeagueShopDaoru.sdf.format(startdate);
        }
    }

    public String getSystemtype()
    {
        return systemtype;
    }

    public String getTel()
    {
        return tel;
    }

    public String getLsbuyjob()
    {
        return lsbuyjob;
    }

    public String getLsbusiness()
    {
        return lsbusiness;
    }

    public String getLegalperson()
    {
        return legalperson;
    }

    public String getInternettype()
    {
        return internettype;
    }

    public String getLsbuycsfalg()
    {
        return lsbuycsfalg;
    }

    public String getNetwork()
    {
        return network;
    }

    public String getLsstatic()
    {
        return lsstatic;
    }

    public String getUpdatedate()
    {
        return updatedate;
    }

    public String getUpdatemember()
    {
        return updatemember;
    }

    public String getSummoney()
    {
        return summoney;
    }

}
