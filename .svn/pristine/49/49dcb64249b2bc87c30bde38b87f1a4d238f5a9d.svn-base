package tea.entity.women;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.Date;
import java.util.Enumeration;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.Entity;
import tea.entity.node.PerformOrders;

public class Contributions extends Entity
{
	private boolean exist; //
	private String cid;
	private String name;//姓名
	private String mobile;// 手机号
	private String invoice;//发票抬头 
	private String address;// 捐款地址
	private String zip;//邮编
	private Date times;//订单时间
	private String community;//社区
	
	private int isinvoice;// 是否要发票 1 否，2 是
	private String recipientname;// 收件人地址
	
	private BigDecimal paymoney;//捐款钱数
	private int paytype;//是否 支付 0 没有，1 有
	private Date paytimes;// 到账时间 -- 汇款登记时间
	
	private String adminmember;//处理订单用户名
	private Date admintimes;// 处理时间
	private int cidtype;//1 个人，2 企业 
	
	
	private Date financetime;//财务登记日期
	private int donationmethods;//捐赠方式
	private String dmname;//其他捐赠方式
	private int currency;//币种
	private String currencyname;//其他币种
	private String donation_requested;//捐赠要求
	private String designated_place;//指定地点
	private String naming_requirements;//冠名要求
	private String receiptno;// 收据编号
	private Date receipttime;// 收据开具日期 
	private int whetherthe_mail;//是否邮寄
	private int bounce;//是否退信
	
	//落实情况
	private Date implementationtimes;//落实日期
	private String imp_ddress_city;// 落实地点省
	private String imp_ddress_village;// 落实地点村
	private String feedback;// 回馈情况
	private String imgname;//图片名称
	private String imgpath;//图片路径
	//备注
	private String remarks;
	
	 
	public static final String CID_TYPE [] = {"----","个人","企业/集体"};
	public static final String DONATION_METHODS[]={"在线支付","邮寄汇款","银行汇款","上门捐赠","其他"};
	public static final String CURRENCY_TYPE[]={"人民币","其他"};
	public static final String WHETHERTHEMAIL_TYPE[]={"是","否"};
	
	
	 
	
	public Contributions(String cid) throws SQLException
    {
        this.cid = cid;
        load();
    }

    public static Contributions find(String cid) throws SQLException
    {
        return new Contributions(cid);
    }
    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter(); 
        try
        {
            db.executeQuery("SELECT name,mobile,invoice,address,zip,times,community,paymoney,paytype,paytimes,adminmember,admintimes," +
            		" cidtype,receiptno,financetime,donationmethods,dmname,currency,currencyname,donation_requested,designated_place," +
            		" naming_requirements,receipttime,whetherthe_mail,bounce,implementationtimes,imp_ddress_city,imp_ddress_village," +
            		" feedback ,imgname,imgpath,remarks,isinvoice,recipientname FROM Contributions  WHERE cid = " + db.cite(cid));
            if(db.next())
            {
            	name=db.getString(1);
            	mobile=db.getString(2);
            	invoice=db.getString(3);
            	address=db.getString(4);
            	zip=db.getString(5);
            	times=db.getDate(6);
            	community=db.getString(7);
            	paymoney=db.getBigDecimal(8,2);
            	paytype=db.getInt(9);
            	paytimes=db.getDate(10);
            	adminmember=db.getString(11);
            	admintimes=db.getDate(12);
            	cidtype=db.getInt(13);
            	receiptno=db.getString(14);
            	financetime=db.getDate(15);
            	donationmethods=db.getInt(16);
            	dmname=db.getString(17);
            	currency=db.getInt(18);
            	currencyname=db.getString(19);
            	donation_requested=db.getString(20);
            	designated_place=db.getString(21);
            	naming_requirements=db.getString(22);
            	receipttime=db.getDate(23);
            	whetherthe_mail=db.getInt(24);
            	bounce=db.getInt(25);
            	implementationtimes=db.getDate(26);
            	imp_ddress_city=db.getString(27);
            	imp_ddress_village=db.getString(28);
            	feedback=db.getString(29);
            	imgname=db.getString(30);
            	imgpath=db.getString(31);
            	remarks=db.getString(32);
            	isinvoice=db.getInt(33);
            	recipientname=db.getString(34);
            	
            	
                exist = true;
            } else
            {
                exist = false;
            }
        } finally
        {
            db.close();
        }
    }
    
    public static void create(String cid,String name,String mobile,String invoice,String address,String zip,String community,
    		java.math.BigDecimal paymoney,int paytype,int donationmethods,int isinvoice,String recipientname) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        int type = 0;
        int frontreartype = 0;
        try
        {
            db.executeUpdate("INSERT INTO Contributions (cid,name,mobile,invoice,address,zip,times,community,paymoney,paytype,donationmethods,isinvoice,recipientname)" +
            		" VALUES ("+db.cite(cid)+","+db.cite(name)+","+db.cite(mobile)+","+db.cite(invoice)+","+db.cite(address)+"," +
            				" "+db.cite(zip)+","+db.cite(times)+","+db.cite(community)+","+paymoney+","+paytype+","+donationmethods+","+isinvoice+","+db.cite(recipientname)+" )");
            
            System.out.println("INSERT INTO Contributions (cid,name,mobile,invoice,address,zip,times,community,paymoney,paytype,donationmethods,isinvoice,recipientname)" +
            		" VALUES ("+db.cite(cid)+","+db.cite(name)+","+db.cite(mobile)+","+db.cite(invoice)+","+db.cite(address)+"," +
    				" "+db.cite(zip)+","+db.cite(times)+","+db.cite(community)+","+paymoney+","+paytype+","+donationmethods+","+isinvoice+","+db.cite(recipientname)+" )");
    
            
        } finally
        {
            db.close();
        }
    }
    
    public  void setPaytype(int paytype,Date paytimes) throws SQLException
    {
        DbAdapter db = new DbAdapter();

        try
        {
        	 db.executeUpdate("UPDATE Contributions SET  paytype="+paytype+",paytimes="+db.cite(paytimes)+" WHERE cid = " +db.cite(cid));
        } finally
        {
            db.close();
        }
    }
   
    //获取id
    public static String getCid(String name,String bh,int type)throws SQLException
    {
    	String c =  null;  
    	DbAdapter db = new DbAdapter();
         try
         {
         	 db.executeQuery("SELECT cid FROM  Contributions WHERE  receiptno="+db.cite(bh)+" and cidtype=  "+type);
         	 //name="+db.cite(name)+" and
         	 if(db.next()){
         		 c = db.getString(1);
         	 }
         } finally
         {
             db.close();
         }
         return c; 
    }
    //获取id
    public static String getCid(String name,String bh)throws SQLException
    {
    	String c =  null;  
    	DbAdapter db = new DbAdapter();
         try
         {
         	 db.executeQuery("SELECT cid FROM  Contributions WHERE  receiptno="+db.cite(bh));//name="+db.cite(name)+" and
         	 if(db.next()){
         		 c = db.getString(1);
         	 }
         } finally
         {
             db.close();
         }
         return c;
    }
    public  void setAdminmember(String adminmember,Date admintimes) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
        	 db.executeUpdate("UPDATE Contributions SET  adminmember="+db.cite(adminmember)+",admintimes="+db.cite(admintimes)+" WHERE cid = " +db.cite(cid));
        } finally
        {
            db.close();
        }
    }
    public void setCidtype(int cidtype,String receiptno)throws SQLException
    {
    	DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
        	 db.executeUpdate("UPDATE Contributions SET  cidtype="+cidtype+",receiptno="+db.cite(receiptno)+" WHERE cid = " +db.cite(cid));
        } finally
        {
            db.close();
        }
    }
    public void set(Date paytimes,Date financetime,int donationmethods,String dmname,int currency,String currencyname,String donation_requested,
    		String designated_place,Date receipttime,int whetherthe_mail,int bounce,Date implementationtimes,String imp_ddress_city,String imp_ddress_village,
    		String feedback,String imgname,String imgpath,String remarks,String naming_requirements,int isinvoice,String recipientname)throws SQLException
    {
    	StringBuffer sp = new StringBuffer(" UPDATE Contributions SET  ");
    	sp.append(" paytimes = ").append(DbAdapter.cite(paytimes));
    	sp.append(", financetime = ").append(DbAdapter.cite(financetime));
    	sp.append(", donationmethods = ").append(donationmethods);
    	sp.append(", dmname = ").append(DbAdapter.cite(dmname));
    	sp.append(", currency = ").append(currency);
    	sp.append(", currencyname = ").append(DbAdapter.cite(currencyname));
    	sp.append(", donation_requested = ").append(DbAdapter.cite(donation_requested));
    	sp.append(", designated_place = ").append(DbAdapter.cite(designated_place));
    	sp.append(",receipttime=").append(DbAdapter.cite(receipttime));
    	sp.append(", whetherthe_mail = ").append(whetherthe_mail);
    	sp.append(", bounce = ").append(bounce);
    	sp.append(", implementationtimes = ").append(DbAdapter.cite(implementationtimes));
    	sp.append(", imp_ddress_city = ").append(DbAdapter.cite(imp_ddress_city));
    	sp.append(", imp_ddress_village = ").append(DbAdapter.cite(imp_ddress_village));
    	sp.append(", feedback = ").append(DbAdapter.cite(feedback));
    	sp.append(", naming_requirements=").append(DbAdapter.cite(naming_requirements));
    	if(imgname!=null){
    		sp.append(", imgname = ").append(DbAdapter.cite(imgname));
    	}
    	if(imgpath!=null){
    		sp.append(", imgpath = ").append(DbAdapter.cite(imgpath));
    	}
    	sp.append(", remarks = ").append(DbAdapter.cite(remarks));
    	sp.append(", isinvoice = ").append(isinvoice);
    	sp.append(", recipientname = ").append(DbAdapter.cite(recipientname));
    	sp.append(" WHERE  cid =").append(DbAdapter.cite(cid));
    	
    	
    	
    	DbAdapter db = new DbAdapter();
        try
        {
        	 db.executeUpdate(sp.toString());
        } finally
        {
            db.close();
        }
    }
    
    public void set(String name,String mobile,String invoice,String address,String zip)throws SQLException
    {
    	StringBuffer sp = new StringBuffer(" UPDATE Contributions SET  ");
    	sp.append(" name = ").append(DbAdapter.cite(name));
    	sp.append(", mobile = ").append(DbAdapter.cite(mobile));
    	sp.append(", invoice = ").append(DbAdapter.cite(invoice));
    	sp.append(", address = ").append(DbAdapter.cite(address));
    	sp.append(", zip = ").append(DbAdapter.cite(zip));
    	
    	
    	sp.append(" WHERE  cid =").append(DbAdapter.cite(cid));
    	
    	 
    	
    	DbAdapter db = new DbAdapter();
        try
        {
        	 db.executeUpdate(sp.toString());
        } finally
        {
            db.close();
        }
    }
 
	
    public void set(Date implementationtimes,String imp_ddress_city,String imp_ddress_village,String feedback,String remarks)throws SQLException
    {
    	StringBuffer sp = new StringBuffer(" UPDATE Contributions SET  ");
    	sp.append(" implementationtimes = ").append(DbAdapter.cite(implementationtimes));
    	sp.append(", imp_ddress_city = ").append(DbAdapter.cite(imp_ddress_city));
    	sp.append(", imp_ddress_village = ").append(DbAdapter.cite(imp_ddress_village));
    	sp.append(", feedback = ").append(DbAdapter.cite(feedback));
    	sp.append(", remarks = ").append(DbAdapter.cite(remarks));
    	
    	
    	sp.append(" WHERE  cid =").append(DbAdapter.cite(cid));
    	
   
    	
    	DbAdapter db = new DbAdapter();
        try
        {
        	 db.executeUpdate(sp.toString());
        } finally
        {
            db.close();
        }
    }
    
     
    public static Enumeration find(String community,String sql,int pos,int size)
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT cid FROM Contributions WHERE community= " + db.cite(community) + sql,pos,size);
            while(db.next())
            {
                vector.add(db.getString(1));
            }
        } catch(Exception exception3)
        {
            System.out.print(exception3);
        } finally
        {
            db.close();
        }
        return vector.elements();
    }


    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM  Contributions WHERE cid = " + db.cite(cid));

        } finally
        {
            db.close();
        }
    }
    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(cid) FROM Contributions  WHERE community=" + db.cite(community) + sql);
            if(db.next())
            {
                count = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return count;
    }

	public boolean isExist()
	{
		return exist;
	}

	public String getName()
	{
		return name;
	}

	public String getMobile()
	{
		return mobile;
	}

	public String getInvoice()
	{
		return invoice;
	}

	public String getAddress()
	{
		return address;
	}

	public String getZip()
	{
		return zip;
	}

	public Date getTimes()
	{
		return times;
	}

	public String getCommunity()
	{
		return community;
	}

	public BigDecimal getPaymoney()
	{
		return paymoney;
	}

	public int getPaytype()
	{
		return paytype;
	}

	public Date getPaytimes()
	{
		return paytimes;
	}

	public String getAdminmember()
	{
		return adminmember;
	}

	public Date getAdmintimes()
	{
		return admintimes;
	}

	public int getCidtype()
	{
		return cidtype;
	}

	public String getReceiptno()
	{
		return receiptno;
	}

	public Date getFinancetime()
	{
		return financetime;
	}

	public int getDonationmethods()
	{
		return donationmethods;
	}

	public String getDmname()
	{
		return dmname;
	}

	public int getCurrency()
	{
		return currency;
	}

	public String getCurrencyname()
	{
		return currencyname;
	}

	public String getDonation_requested()
	{
		return donation_requested;
	}

	public String getDesignated_place()
	{
		return designated_place;
	}

	public String getNaming_requirements()
	{
		return naming_requirements;
	}

	public Date getReceipttime()
	{
		return receipttime;
	}

	public int getWhetherthe_mail()
	{
		return whetherthe_mail;
	}

	public int getBounce()
	{
		return bounce;
	}

	public Date getImplementationtimes()
	{
		return implementationtimes;
	}

	public String getImp_ddress_city()
	{
		return imp_ddress_city;
	}

	public String getImp_ddress_village()
	{
		return imp_ddress_village;
	}

	public String getFeedback()
	{
		return feedback;
	}

	public String getImgname()
	{
		return imgname;
	}

	public String getImgpath()
	{
		return imgpath;
	}

	public String getRemarks()
	{
		return remarks;
	}

	public int getIsinvoice()
	{
		return isinvoice;
	}

	public String getRecipientname()
	{
		return recipientname;
	}
    
 
	
}
