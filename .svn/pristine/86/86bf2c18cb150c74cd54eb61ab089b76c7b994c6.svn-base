package tea.entity.league;


import java.math.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class LeagueShop extends Entity
{
    private int id; //
    private int bumen; //加盟店名称id,bumen,lsname,community,lsbusiness,health,legalperson,buytype,province,city,region,port,number,tel,lsbuyname,lsbuysex,lsbuytel,lsbuyschool,lsbuyjob,lsbuypost,lsbuycsfalg,shopkeepername,sksex,sktel,skschool,skjob,skpost,csarea,lstype,lsstype,regdate,adddate,startdate,bednum,shoparea,spa,shopkeeper,adviser,hairdresser,fixmember,movemember,computernum,network,internettype,systemtype
    private String lsname; //加盟店名称
    private String community; //社区
    private String lsbusiness; //营业执照
    private String health; //卫生登记证书
    private String legalperson; //法人
    private String buytype; //经营性质
    private int province; //省
    private int city; //市
    private String region; //区
    private String port; //港
    private String numbers; //号
    private String tel; //营业电话号
    private String lsbuyname; //加盟商姓名
    private int lsbuysex; //加盟商性别
    private String lsbuytel; //加盟商手机号
    private String lsbuyschool; //加盟商学历
    private String lsbuyjob; //加盟之前所从事的职业
    private String lsbuypost; //加盟之前所从事行业的职务
    private int lsbuycsfalg; //是否专职经营连锁店
    private String shopkeepername; //店长姓名
    private int sksex; ///店长性别  0 先生 1  女士
    private String sktel; //手机电话
    private String skschool; ///店长最高学历
    private String skjob; ///
    private String skpost; ///
    private int csarea; //chain store连锁商店 区域 华北
    private int lstype; //唯美度   ( LeagueShopType 表 主键)
    private int lsstype; //类型--级别
    private Date regdate; //添加时间
    private Date adddate; //加盟时间
    private Date startdate; //开业时间
    private String bednum; //美容床数
    private String shoparea; //经营面积
    private int spa; //SPA
    private String shopkeeper; //店长
    private String adviser; //前台顾问
    private String hairdresser; //美容师
    private String fixmember; //固定
    private String movemember; //流动顾客
    private int computernum; //连锁店是否有电脑
    private int network;
    private int internettype; //上网方式  ADSL,宽带,拔号,本店无法上网
    private int systemtype; //会员系统
    private int lsstatic; //加盟店状态    {"正常","危机处理中","删除","彻底删除"};
    private String updatemember; //加盟店状态的修改人
    private Date updatedate; //加盟店状态的修改人
    private BigDecimal summoney; //应付金额
    private BigDecimal costmoney; //实付金额summoneycostmoney,returnmoney,dispatchmoney,faremoney,block
    private BigDecimal returnmoney; //返还金额
    private BigDecimal dispatchmoney; //配送金额
    private BigDecimal faremoney; //运费金额
    private BigDecimal block; //冻结款
    private String ip; //客户端的IP地址
    private int lsstatic2; //全款打齐-a、全款打齐-b、全款打齐-c、全款打齐-d、全款打齐-N、已付订金、危机处理中
    private String brands; //关联品牌
    private boolean exists; // 是否存在
	private int totalquantity;//商品库存总数量
	private int installnumber;//安装次数

    public static final String LSSTATIC2[] =
            {"全款打齐-a","全款打齐-b","全款打齐-c","全款打齐-d","全款打齐-N","已付订金","危机处理中"};


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


    public static LeagueShop find(int id) throws SQLException
    {
        return new LeagueShop(id);
    }

    public LeagueShop(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select id,bumen,lsname,community,lsbusiness,health,legalperson,buytype,province,city,region,port,numbers,tel," +
            		"lsbuyname,lsbuysex,lsbuytel,lsbuyschool,lsbuyjob,lsbuypost,lsbuycsfalg,shopkeepername,sksex,sktel,skschool,skjob,skpost," +
            		"csarea,lstype,lsstype,regdate,adddate,startdate,bednum,shoparea,spa,shopkeeper,adviser,hairdresser,fixmember,movemember," +
            		"computernum,network,internettype,systemtype,lsstatic,updatemember,updatedate,summoney,ip,lsstatic2,costmoney,returnmoney," +
            		"dispatchmoney,faremoney,block,brands,totalquantity,installnumber from LeagueShop where id=" + id);
            if(db.next())
            {
                int j = 1;
                id = db.getInt(j++);
                bumen = db.getInt(j++);
                lsname = db.getString(j++);
                community = db.getString(j++);
                lsbusiness = db.getString(j++);
                health = db.getString(j++);
                legalperson = db.getString(j++);
                buytype = db.getString(j++);
                province = db.getInt(j++);
                city = db.getInt(j++);
                region = db.getString(j++);
                port = db.getString(j++);
                numbers = db.getString(j++);
                tel = db.getString(j++);
                lsbuyname = db.getString(j++);
                lsbuysex = db.getInt(j++);
                lsbuytel = db.getString(j++);
                lsbuyschool = db.getString(j++);
                lsbuyjob = db.getString(j++);
                lsbuypost = db.getString(j++);
                lsbuycsfalg = db.getInt(j++);
                shopkeepername = db.getString(j++);
                sksex = db.getInt(j++);
                sktel = db.getString(j++);
                skschool = db.getString(j++);
                skjob = db.getString(j++);
                skpost = db.getString(j++);
                csarea = db.getInt(j++);
                lstype = db.getInt(j++);
                lsstype = db.getInt(j++);
                regdate = db.getDate(j++);
                adddate = db.getDate(j++);
                startdate = db.getDate(j++);
                bednum = db.getString(j++);
                shoparea = db.getString(j++);
                spa = db.getInt(j++);
                shopkeeper = db.getString(j++);
                adviser = db.getString(j++);
                hairdresser = db.getString(j++);
                fixmember = db.getString(j++);
                movemember = db.getString(j++);
                computernum = db.getInt(j++);
                network = db.getInt(j++);
                internettype = db.getInt(j++);
                systemtype = db.getInt(j++);
                lsstatic = db.getInt(j++);
                updatemember = db.getString(j++);
                updatedate = db.getDate(j++);
                summoney = db.getBigDecimal(j++,2);
                ip = db.getString(j++);
                lsstatic2 = db.getInt(j++);
                costmoney = db.getBigDecimal(j++,2);
                returnmoney = db.getBigDecimal(j++,2);
                dispatchmoney = db.getBigDecimal(j++,2);
                faremoney = db.getBigDecimal(j++,2);
                block = db.getBigDecimal(j++,2);
                brands = db.getString(j++);
				totalquantity=db.getInt(j++);
				installnumber=db.getInt(j++);
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

    public static void set(int id,int bumen,String lsname,String community,String lsbusiness,String health,String legalperson,String buytype,int province,int city,String region,String port,String numbers,String tel,String lsbuyname,int lsbuysex,String lsbuytel,String lsbuyschool,String lsbuyjob,String lsbuypost,int lsbuycsfalg,String shopkeepername,int sksex,String sktel,String skschool,String skjob,String skpost,int csarea,int lstype,int lsstype,Date regdate,Date adddate,Date startdate,String bednum,String shoparea,int spa,String shopkeeper,String adviser,String hairdresser,String fixmember,String movemember,int computernum,int network,int internettype,int systemtype,String brands) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date date = new Date();
        int lsstatic = 0;
        try
        {
            db.executeQuery("Select id from LeagueShop where id=" + id);
            if(db.next())
            {
                db.executeUpdate("Update LeagueShop set bumen=" + bumen + ",lsname=" + db.cite(lsname) + ",community=" + db.cite(community) + ",lsbusiness=" + db.cite(lsbusiness) + ",health=" + db.cite(health) + ",legalperson=" + db.cite(legalperson) + ",buytype=" + db.cite(buytype) + ",province=" + province + ",city=" + city + ",region=" + db.cite(region) + ",port=" + db.cite(port) + ",numbers=" + db.cite(numbers) + ",tel=" + db.cite(tel) + ",lsbuyname=" + db.cite(lsbuyname) + ",lsbuysex=" + lsbuysex + ",lsbuytel=" + db.cite(lsbuytel) + ",lsbuyschool=" + db.cite(lsbuyschool) + ",lsbuyjob=" + db.cite(lsbuyjob) + ",lsbuypost=" + db.cite(lsbuypost) + ",lsbuycsfalg=" + lsbuycsfalg + ",shopkeepername=" + db.cite(shopkeepername) + ",sksex=" + sksex + ",sktel=" + db.cite(sktel) + ",skschool=" +
                                 db.cite(skschool) + ",skjob=" + db.cite(skjob) + ",skpost=" + db.cite(skpost) + ",csarea=" + csarea + ",lstype=" + lstype + ",lsstype=" + lsstype + ",regdate=" + db.cite(regdate) + ",adddate=" + db.cite(adddate) + ",startdate=" + db.cite(startdate) + ",bednum=" + db.cite(bednum) + ",shoparea=" + db.cite(shoparea) + ",spa=" + spa + ",shopkeeper=" + db.cite(shopkeeper) + ",adviser="
                                 + db.cite(adviser) + ",hairdresser=" + db.cite(hairdresser) + ",fixmember=" + db.cite(fixmember) + ",movemember=" + db.cite(movemember) + ",computernum=" + computernum + ",network=" + network + ",internettype=" + internettype + ",systemtype=" + systemtype + ",brands=" + db.cite(brands) + " where id=" + id);
            } else
            {
                db.executeUpdate("Insert into LeagueShop(bumen,lsname,community,lsbusiness,health,legalperson,buytype,province,city,region,port,numbers,tel,lsbuyname,lsbuysex,lsbuytel,lsbuyschool,lsbuyjob,lsbuypost,lsbuycsfalg,shopkeepername,sksex,sktel,skschool,skjob,skpost,csarea,lstype,lsstype,regdate,adddate,startdate,bednum,shoparea,spa,shopkeeper,adviser,hairdresser,fixmember,movemember,computernum,network,internettype,systemtype,lsstatic,summoney,brands)values(" + bumen + "," + db.cite(lsname) + "," + db.cite(community) + "," + db.cite(lsbusiness) + "," + db.cite(health) + "," + db.cite(legalperson) + "," + db.cite(buytype) + "," + province + "," + city + "," + db.cite(region) + "," + db.cite(port) + "," + db.cite(numbers) + "," + db.cite(tel) + "," + db.cite(lsbuyname) + "," +
                                 lsbuysex +
                                 "," +
                                 db.cite(lsbuytel) + "," + db.cite(lsbuyschool) + "," + db.cite(lsbuyjob) + "," + db.cite(lsbuypost) + "," + lsbuycsfalg + "," + db.cite(shopkeepername) + "," + sksex + "," + db.cite(sktel) + "," + db.cite(skschool) + "," + db.cite(skjob) + "," + db.cite(skpost) + "," + csarea + "," + lstype + "," + lsstype + "," + db.cite(date) + "," + db.cite(adddate) + "," + db
                                 .cite(startdate) + "," + db.cite(bednum) + "," + db.cite(shoparea) + "," + spa + "," + db.cite(shopkeeper) + "," + db.cite(adviser) + "," + db.cite(hairdresser) + "," + db.cite(fixmember) + "," + db.cite(movemember) + "," + computernum + "," + network + "," + internettype + "," + systemtype + "," + lsstatic + "," + 0 + "," + db.cite(brands) + ")");
            }
        } finally
        {
            db.close();
        }
    }

    public void setIp(String ip) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE LeagueShop SET ip=" + db.cite(ip) + " WHERE id=" + id);
        } finally
        {
            db.close();
        }
    }

//修改加盟店库存总数量
	public void setTotalQuantity(int totalquantity)throws SQLException
	{
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE LeagueShop SET totalquantity=" + totalquantity + " WHERE id=" + id);
        } finally
        {
            db.close();
        }
		this.totalquantity = totalquantity;
	}
    public static Enumeration findByCommunity(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM LeagueShop WHERE community=" + db.cite(community) + sql,pos,size);
            while(db.next())
            {
                v.addElement(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT (ls.id) FROM LeagueShop ls,ICSales ic WHERE ls.id=ic.leagueshop AND community=" + db.cite(community) + sql,pos,size);
            while(db.next())
            {
                v.addElement(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }


    public static int count(String community,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int num = 0;
        try
        {
            db.executeQuery("Select count(id) from LeagueShop where 1=1 " + sql);
            if(db.next())
            {

                num = db.getInt(1);
                return num;
            } else
            {
                return num;
            }
        } finally
        {
            db.close();
        }
    }

    //zhangjinshu
    public static int count2(String community,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int num = 0;
        try
        {
            db.executeQuery("SELECT count(distinct(ls.id)) FROM LeagueShop ls,ICSales ic WHERE ls.id=ic.leagueshop AND community =" + db.cite(community) + sql);
            if(db.next())
            {
                num = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return num;
    }

//合计
    public static int getMemberTotal(String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int mt = 0;
        try
        {
            db.executeQuery("select count(distinct(ic.icard)) from ICSales i,ICSalesList ic,LeagueShop ls where ls.id=i.leagueshop and  i.icsales=ic.icsales " + sql);
            if(db.next())
            {
                mt = mt + db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return mt;
    }

    public static int getSQLB(String str1,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int mt = 0;
        try
        {
            db.executeQuery("select " + str1 + " from ICSales ic,ICSalesList ics,LeagueShop ls  where ls.id=ic.leagueshop and    ic.icsales=ics.icsales " + sql);
            if(db.next())
            {
                mt = mt + db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return mt;

    }

//    public static java.math.BigDecimal getJiE(String str1,String sql) throws SQLException
//    {
//        BigDecimal mt = null;
//        DbAdapter db = new DbAdapter();
//        try
//        {
//            db.executeQuery("select " + str1 + " from ICSales ic,ICSalesList ics where ic.icsales=ics.icsales " + sql);
//            if(db.next())
//            {
//                mt = db.getBigDecimal(1,2);
//            }
//        } finally
//        {
//            db.close();
//        }
//        return mt;
//    }
    //求会员消费金额和非会员消费金额
    public static java.math.BigDecimal getJiE(String str1,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        java.math.BigDecimal mt = new java.math.BigDecimal("0");
        try
        {
            db.executeQuery("select ics.price, ics.quantity from ICSales ic,ICSalesList ics,LeagueShop ls  where  ls.id=ic.leagueshop and  ic.icsales=ics.icsales " + sql);
            while(db.next())
            {
                mt = mt.add(db.getBigDecimal(1,2).multiply(new java.math.BigDecimal(db.getInt(2))));
            }
        } finally
        {
            db.close();
        }
        return mt;
    }

//    public static void delete(int id) throws SQLException
//    {
//        DbAdapter db = new DbAdapter();
//
//        try
//        {
//            db.executeUpdate("Delete  LeagueShop where id= " + id);
//
//        } finally
//        {
//            db.close();
//        }
//    }

    public static void setcs(int id,int bumen,String lsname,int lstype,int lsstype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select id from LeagueShop where id =" + id);
            if(db.next())
            {
                db.executeUpdate("Update LeagueShop set bumen=" + bumen + ",lsname=" + db.cite(lsname) + "lstype=" + lstype + ",lsstype=" + lsstype + "  where id=" + id);
            } else
            {
                db.executeUpdate("Insert into LeagueShop (bumen,lsname,lstype,lsstype)value(" + bumen + "," + db.cite(lsname) + "," + lstype + "," + lsstype + ")");
            }
        } finally
        {
            db.close();
        }
    }

    public static int findid(int unitid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int id = 0;
        try
        {
            db.executeQuery("select id from LeagueShop where bumen =" + unitid);
            if(db.next())
            {
                id = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return id;
    }

    //输出下拉菜单
    public static String toHtml(String community,int dv) throws SQLException
    {
        StringBuilder h = new StringBuilder();
        h.append("<select name='leagueshop'><option value=''>--------------");
        Enumeration e = findByCommunity(community,"",0,Integer.MAX_VALUE);
        while(e.hasMoreElements())
        {
            int id = ((Integer) e.nextElement()).intValue();
            h.append("<option value='").append(id).append("'");
            if(dv == id)
            {
                h.append(" selected='true'");
            }
            h.append(">").append(LeagueShop.find(id).getLsname());
        }
        h.append("</select>");
        return h.toString();
    }

    //修改加盟店的状态
    public static void updatestatic(int id,int lsstatic,String updatemember) throws SQLException
    {
        // {"正常","危机处理中","删除","彻底删除"};
        DbAdapter db = new DbAdapter();
        Date updatedate = new Date();
        try
        {
            db.executeUpdate("Update LeagueShop set lsstatic=" + lsstatic + ",updatemember=" + db.cite(updatemember) + ",updatedate=" + db.cite(updatedate) + " where id=" + id);
        } finally
        {
            db.close();
        }
    }

    //2009年6月15日11:28:50  添加加盟店状态
    public void setLsstatic2(int lsstatic2,String updatemember) throws SQLException
    {
        //{"全款打齐-a","全款打齐-b","全款打齐-c","全款打齐-d","全款打齐-N","已付订金","危机处理中"};6
        DbAdapter db = new DbAdapter();
        Date date = new Date();
        int lsstatic = 0;

        if(lsstatic2 == 6)
        {
            lsstatic = 1;
        }
        try
        {
            db.executeUpdate("UPDATE LeagueShop SET lsstatic2=" + lsstatic2 + ",updatemember=" + db.cite(updatemember) + ",updatedate=" + db.cite(date) + ",lsstatic=" + lsstatic + " WHERE id=" + id);
        } finally
        {
            db.close();
        }
    }

    //判断加盟店部门不能重复添加
    public static boolean lsbumenfalg(int bumen) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select id from LeagueShop where bumen=" + bumen);
            if(db.next())
            {
                return true;
            } else
            {
                return false;
            }
        } finally
        {
            db.close();
        }

    }

    //判断是否可以删除类型
    public static int pdServer(int lsstype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select id from LeagueShop where lsstatic<2 and lsstype=" + lsstype);
            if(db.next())
            {
                return 0;
            } else
            {
                return 1;
            }
        } finally
        {
            db.close();
        }
    }

    //判断是否可以删除加盟店,要判断的 订单 预付款 ，
    public static int pdLsshop(int lsstype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select id from LeagueShop where lsstype=" + lsstype);
            if(db.next())
            {
                return 0;
            } else
            {
                return 1;
            }
        } finally
        {
            db.close();
        }
    }

    //加盟店预付款金额计算
    public static void setUpdatemoney(int lsid,BigDecimal bb,int type) throws SQLException
    {
        //type 0 加 1减
        DbAdapter db = new DbAdapter();
        BigDecimal bbnew = new BigDecimal("0");
        try
        {
            db.executeQuery("Select summoney from LeagueShop where id=" + lsid);
            if(db.next())
            {
                BigDecimal old = db.getBigDecimal(1,2);

                if(type == 0)
                {
                    bbnew = old.add(bb);
                } else if(type == 1)
                {
                    bbnew = old.subtract(bb);
                }
                db.executeUpdate("Update LeagueShop set summoney=" + bbnew + " where id=" + lsid);
            }
        } finally
        {
            db.close();
        }
    }

    public static void setmoney(int lsid,BigDecimal bb,int type,String str) throws SQLException
    {
        //type 0 加 1减
        DbAdapter db = new DbAdapter();
        BigDecimal bbnew = new BigDecimal("0");
        try
        {
            db.executeQuery("Select " + str + " from LeagueShop where id=" + lsid);
            if(db.next())
            {
                BigDecimal old = db.getBigDecimal(1,2);

                if(type == 0)
                {
                    bbnew = old.add(bb);
                } else if(type == 1)
                {
                    bbnew = old.subtract(bb);
                }
                db.executeUpdate("Update LeagueShop set " + str + "=" + bbnew + " where id=" + lsid);
            }
        } finally
        {
            db.close();
        }
    }
    //修改安装次数
    public int getInsnumber(int installnumber)throws SQLException
    {
    	int in = 0;
    	 DbAdapter db = new DbAdapter();
    	 try{
    		db.executeUpdate("UPDATE LeagueShop SET installnumber = "+installnumber+" WHERE  id="+id);
    	 }finally
    	 {
    		 db.close();
    	 }
    	 this.installnumber=installnumber;
    	 return in;
    }
	public static boolean getLsame (String lsname,int id)throws SQLException
	{
		 DbAdapter db = new DbAdapter();
		 boolean decide = false;
		 try
		 {
			 db.executeQuery("Select * from LeagueShop where lsname ="+db.cite(lsname));
			 if(db.next())
			 {
				 if(id==0)
				 {
					 decide=false;
				 }
				 else
				 {
					 db.executeQuery("Select * from LeagueShop where lsname ="+db.cite(lsname)+"  and id="+id);
					 if(db.next())
					 {
						 decide=true;
					 }
					 else
					 {
						 decide=false;
					 }
				}
			 }
			 else
			 {
				 decide=true;
			 }
		 }
		 finally
		 {
			 db.close();
		 }
		 return decide;
	}

    public Date getAdddate()
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
            return LeagueShop.sdf.format(adddate);
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

    public int getBumen()
    {
        return bumen;
    }

    public String getBuytype()
    {
        return buytype;
    }

    public int getCity()
    {
        return city;
    }

    public String getCommunity()
    {
        return community;
    }

    public int getComputernum()
    {
        return computernum;
    }

    public int getCsarea()
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

    public int getLsbuysex()
    {
        return lsbuysex;
    }

    public String getLsname()
    {
        return lsname;
    }

    public int getLsstype()
    {
        return lsstype;
    }

    public int getLstype()
    {
        return lstype;
    }

    public String getMovemember()
    {
        return movemember;
    }

    public String getNumber()
    {
        return numbers;
    }

    public String getPort()
    {
        return port;
    }

    public int getProvince()
    {
        return province;
    }

    public Date getRegdate()
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
            return LeagueShop.sdf.format(regdate);
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

    public int getSksex()
    {
        return sksex;
    }

    public String getSktel()
    {
        return sktel;
    }

    public int getSpa()
    {
        return spa;
    }

    public Date getStartdate()
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

            return LeagueShop.sdf.format(startdate);
        }
    }

    public int getSystemtype()
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

    public int getInternettype()
    {
        return internettype;
    }

    public int getLsbuycsfalg()
    {
        return lsbuycsfalg;
    }

    public int getNetwork()
    {
        return network;
    }

    public int getLsstatic()
    {
        return lsstatic;
    }

    public Date getUpdatedate()
    {
        return updatedate;
    }

    public String getUpdatemember()
    {
        return updatemember;
    }

    public boolean isExists()
    {
        return exists;
    }

    public BigDecimal getSummoney()
    {
        return summoney;
    }

    public String getIp()
    {
        return ip;
    }

    public int getLsstatic2()
    {
        return lsstatic2;
    }

    public BigDecimal getBlock()
    {
        return block;
    }

    public BigDecimal getCostmoney()
    {
        return costmoney;
    }

    public BigDecimal getDispatchmoney()
    {
        return dispatchmoney;
    }

    public BigDecimal getFaremoney()
    {
        return faremoney;
    }

    public BigDecimal getReturnmoney()
    {
        return returnmoney;
    }

    public String getBrands()
    {
        return brands;
    }
	public int getTotalquantity()
	{
		return totalquantity;
	}

	public int getInstallnumber()
	{
		return installnumber;
	}

}
