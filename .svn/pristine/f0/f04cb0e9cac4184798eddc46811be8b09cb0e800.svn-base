package tea.entity.integral;

import java.sql.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import tea.entity.westrac.Eventregistration;

public class IntegralChange extends Entity
{
    private int id;
   
    private String community;
    private String applymember;//申请的会员名称
    private String present;//用积分兑换的礼品
    private Date applydate;//申请时间
    private int applyintegral;//申请积分的金额
    
    private int statics;//状态  1提出申请，2 发货处理，3 发货成功,4 收货成功
    
    private Date submitdate;//审核时间
    private String member;//批准的管理员
    
    private int subsum;//提交时，商品实际用掉的积分总数
    private String subpresent;//提交时，对应的商品名称
    private String replaceuse;//是谁代理申请 会员的积分申请
    
    //送货方式
    private String phone;//联系方式
	private String address;//收货地址
	private String consignee;//收货人
	private String province;//省市
	
	
	
	private String orderid;//订单号 
	
	//发货
	private Date ftime;//发货时间
	private String fmember;//发货用户
	private Date qtime;//确认时间
	private String qmember;//确认用户
	
	// 是否代理订单
	private int ictype;//订单类型 0,会员前台下单，1, 管理员下单
	private String icmember;//用户下单
	private String zip;//邮编
	
	//用户评价
	private int score;
	
	
	
    
    private boolean isexists; 
    public static final String STATIC[]={"  ","审批中","兑换成功"};
    public static final String STATIC_STRTYPE[]={"兑换用户管理","兑换用户审核","兑换用户发货","收货确认","商品兑换完毕","审核未通过"};
    public static final String MY_STATIC[]={"","已提交","已确认","已发货","已完成","审核未通过"};
    
    public static final String MY_STATIC2[]={"","审核中","审核完成，等待发货","发货完成，等待确认","兑换完毕"};
    
    public static final String ICTYPE_TTYPE[]={"在线兑换","管理员兑换","短信兑换"};
    public IntegralChange(int id) throws SQLException
    {
        this.id = id;
        load();
    }
    public static IntegralChange find(int id) throws SQLException
    {
        return new IntegralChange (id);
    }
    public void load()throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select id,member,community,applymember,present,applydate,submitdate,applyintegral,statics,replaceuse,subsum,subpresent," +
            		" phone,address,consignee,orderid,ftime,fmember,qtime,qmember,ictype,icmember,province,zip,score from IntegralChange where id="+id);
            if(db.next())
            {
            id = db.getInt(1);
            member = db.getString(2);
            community = db.getString(3);
            applymember = db.getString(4);
            present = db.getString(5);
            applydate = db.getDate(6);
            submitdate = db.getDate(7);
            applyintegral = db.getInt(8);
            statics = db.getInt(9);
            replaceuse = db .getString(10);
            subsum = db.getInt(11);
            subpresent = db.getString(12);
            phone=db.getString(13);
            address=db.getString(14);
            consignee=db.getString(15);
            orderid=db.getString(16);
            
            ftime=db.getDate(17);
            fmember=db.getString(18);
            qtime=db.getDate(19);
            qmember=db.getString(20);
            ictype=db.getInt(21);
            icmember=db.getString(22);
            province=db.getString(23);
            zip=db.getString(24);
            score=db.getInt(25);
            
            
            
            isexists = true;
            }
        }
        finally
        {
            db.close();
        }
    }
    public static void create(String member,String community,String applymember,String present,Date applydate,Date submitdate,int applyintegral,int statics,String replaceuse,
    		String phone,String address,String consignee,String orderid,int ictype,String icmember,String province,String zip)throws SQLException
    {
    	
    	 Date time = new Date();
    	 if(orderid==null)
    	 {
    	   java.text.SimpleDateFormat ymd = new java.text.SimpleDateFormat("yyyyMMdd");
    		 orderid  = "WST"+ymd.format(time) + SeqTable.getSeqNo("IntegralChange");
    	 }
    	
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("insert into IntegralChange (member,community,applymember,present,applydate,submitdate,applyintegral,statics,replaceuse," +
            		"phone,address,consignee,orderid,ictype,icmember,province,zip)values("+db.cite(member)+","+db.cite(community)+","+db.cite(applymember)+","+db.cite(present)+","+db.cite(applydate)+"," +
            		" "+db.cite(submitdate)+","+applyintegral+","+statics+","+db.cite(replaceuse)+","+db.cite(phone)+","+db.cite(address)+","+db.cite(consignee)+","+db.cite(orderid)+"," +
            		" "+ictype+","+db.cite(icmember)+","+db.cite(province)+","+db.cite(zip)+" )");

        }
        finally
        {
            db.close();
        }
    }
    public static void set(int id,String member,String community,String applymember,String present,Date applydate,Date submitdate,int applyintegral,int statics,String replaceuse,
    		String phone,String address,String consignee,String orderid,int ictype,String icmember,String province,String zip)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update IntegralChange set member="+db.cite(member)+",community="+db.cite(community)+",applymember="+db.cite(applymember)+",present="+db.cite(present)+"," +
            		"applydate="+db.cite(applydate)+",submitdate="+db.cite(submitdate)+",applyintegral="+applyintegral+",statics="+statics+",replaceuse="+db.cite(replaceuse)+"," +
            		" phone="+db.cite(phone)+",address="+db.cite(address)+",consignee="+db.cite(consignee)+",orderid="+db.cite(orderid)+"," +
            		" ictype="+ictype+",icmember="+db.cite(icmember)+",province="+db.cite(province)+",zip="+db.cite(zip)+" where id ="+id);
        }
        finally
        {
            db.close();
        }
    }
    public  void set(String community,String applymember,String present,Date applydate,int applyintegral,int statics,String replaceuse,
    		String phone,String address,String consignee,String orderid,String province,String zip)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update IntegralChange set community="+db.cite(community)+",applymember="+db.cite(applymember)+",present="+db.cite(present)+"," +
            		"applydate="+db.cite(applydate)+",applyintegral="+applyintegral+",statics="+statics+",replaceuse="+db.cite(replaceuse)+"," +
            		" phone="+db.cite(phone)+",address="+db.cite(address)+",consignee="+db.cite(consignee)+",orderid="+db.cite(orderid)+",province="+db.cite(province)+"," +
            		" zip="+db.cite(zip)+" where id ="+id);
        }
        finally
        {
            db.close();
        }
    }
    public  void set(int statics,String phone,String address,String consignee,String province,String zip)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update IntegralChange set statics="+statics+", phone="+db.cite(phone)+",address="+db.cite(address)+",consignee="+db.cite(consignee)+",orderid="+db.cite(orderid)+",province="+db.cite(province)+"," +
            		" zip="+db.cite(zip)+" where id ="+id);
        }
        finally
        {
            db.close();
        }
    }
    
    public void setScore(int score)throws SQLException
    {
    	DbAdapter db = new DbAdapter();
    	try
    	{
    		db.executeUpdate("update IntegralChange set score="+score+"  where id = "+id);
    	}finally
    	{
    		db.close();
    	}
    }
    
    //显示没有审核的积分
    public static float getIntegral(String member,String community) throws SQLException
    {
    	StringBuffer sql = new StringBuffer();
    	sql.append(" and applymember=").append(DbAdapter.cite(member));
    	sql.append(" and statics = 1 ");
    	float in = 0;
    	java.util.Enumeration enumer = IntegralChange.findByIntegral(community,sql.toString(),0,Integer.MAX_VALUE);

    	for(int index=1;enumer.hasMoreElements();index++)
    	{
    	  int ids =  Integer.parseInt(enumer.nextElement().toString());
    	  IntegralChange icobj = IntegralChange.find(ids);
    	  in =in+icobj.getApplyintegral();
    	}
    	return in;
    }
    
    
    public static void delete(int id)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete IntegralChange where id= "+id);
        }
        finally
        {
            db.close();
        }
    }

    public static java.util.Enumeration findByIntegral(String community, String sql, int pos, int pageSize) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM IntegralChange WHERE community=" + DbAdapter.cite(community) + sql,pos,pageSize);

            while( db.next())
            {
              
                    vector.addElement(db.getInt(1));
   
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }
    public static int count(String community,String sql)throws SQLException
    {
    	int c = 0;
    	DbAdapter db = new DbAdapter();
    	try
    	{
    		db.executeQuery("select count(id) from IntegralChange where community = "+DbAdapter.cite(community)+sql);
    		if(db.next())
    		{
    			c = db.getInt(1);
    		}
    	}finally
    	{
    		db.close();
    	}
    	return c;
    }
    //修改审核状态
    public  void updatestatic(int id ,int statics,String member)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update IntegralChange set member = "+db.cite(member)+ " ,statics ="+statics+" where id="+id);
        }
        finally
        {
            db.close();
        }
    }
    public  void updatestatic(int statics)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update IntegralChange set statics ="+statics+" where id="+id);
        }
        finally
        {
            db.close();
        }
    }
    
    public  void updates(Date submitdate,String member)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update IntegralChange set submitdate = "+db.cite(submitdate)+ " ,member ="+db.cite(member)+" where id="+id);
        }
        finally 
        {
            db.close();
        } 
    }
    //修改发货
    
    public  void updatef(Date ftime,String fmember)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update IntegralChange set ftime = "+db.cite(ftime)+ " ,fmember ="+db.cite(fmember)+" where id="+id);
        }
        finally
        {
            db.close();
        } 
    }
    
    
    
    public  void updateq(Date qtime,String qmember)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update IntegralChange set qtime = "+db.cite(qtime)+ " ,qmember ="+db.cite(qmember)+" where id="+id);
        }
        finally
        {
            db.close();
        }
    }
    
    

    public Date getApplydate()
    {
        return applydate;
    }

    public int getApplyintegral()
    {
        return applyintegral;
    }

    public String getApplymember()
    {
        return applymember;
    }

    public String getCommunity()
    {
        return community;
    }

    public int getId()
    {
        return id;
    }

    public String getMember()
    {
        return member;
    }

    public String getPresent()
    {
        return present;
    }

    public Date getSubmitdate()
    {
        return submitdate;
    }

    public int getStatics()
    {
        return statics;
    }

    public boolean isIsexists()
    {
        return isexists;
    }

    public String getReplaceuse()
    {
        return replaceuse;
    }

    public String getSubpresent()
    {
        return subpresent;
    }

    public int getSubsum()
    {
        return subsum;
    }
	public String getPhone() {
		return phone;
	}
	public String getAddress() {
		return address;
	}
	public String getConsignee() {
		return consignee;
	}
	public String getOrderid() {
		return orderid;
	}
	public int getIctype()
	{
		return ictype;
	}
	public String getIcmember()
	{
		return icmember;
	}
	public String getProvince()
	{
		return province;
	}
	public String getZip()
	{
		return zip;
	}
	public int getScore()
	{
		return score;
	}
    
}
