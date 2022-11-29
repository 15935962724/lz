package tea.entity.subscribe;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.Timer;
import java.util.TimerTask;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.Entity;
import tea.entity.SeqTable;
import tea.entity.admin.PayOrder;
import tea.entity.node.PerformOrders;


public class PackageOrder extends Entity {
	
	private String pkorder;//订单id
	
	private int sid;//套餐id
	private String sname;//套餐名称
	private BigDecimal marketprice; //人民币价格
	private BigDecimal promotionsprice; //美元价格
	private String remarks;//套餐备注说明
	
	private int whethermail;//是否邮寄 0 不邮寄 ，1 邮寄 
	
	private String shoujiaren;//收件人
	private String dizhi;//地址
	private String youbian;//邮编
	private String dianhua;//电话
	private String fapiaotaitou;//发票抬头
	private String fapiaoneirong;//发票内容
	private String beizhushuoming;//备注说明
	
	private String member;//订单用户
	private Date orderstime;//下单时间
	private Date paytime;//支付时间
	
	private int type;//是否支付 0 订单初始，没有支付  1 支付成功,2 支付失败
	private int paymanner;//支付方式  0  默认没有     1  管理员激活，2 在线支付 ，3 邮局汇款，4 银行转账
	private String payname;//支付名称 
	
	
	private String community;//社区
	private boolean exists;
	
	private int issued;//是否开具发票 0,未开具 , 1 已开具
	
	private String paymentmember;//手动付款操作人
	private Date paymenttime;//手动付款操作时间
	private String revocationmember;//撤销手动付款人
	private Date revocationtime;//撤销手动付款时间
	
	private int effect;//是否生效 0 不生效 ，1 生效状态
	private String effectmember;//手动生效操作人
	private Date effecttime;//手动生效时间
	
	//订单套餐使用的 激活时间 
	private Date activatime;//激活时间 --
	
	
	private int subtype;//套餐的阅读权限 默认是 0 ，1 阅读中，2，已经过期
	private Date substarttime;//套餐开始时间
	private Date subendtime;//套餐结束时间
	
	//报纸节点
	private int node; 
	
	
	//是否邮寄发票
	public static final String WHETHERMAIL_TYPE[] ={"否","是"};
	//是否开具发票
	public static final String ISSUED_TYPE[] = {"未开具","已开具"};
	//支付名称
	public static final String PAYNAME_TYPE[] ={"","管理员激活","在线支付","邮局汇款","银行转账"};
	//生效状态
	public static final String EFFECT_TYPE [] ={"未生效","已生效"};
	//订单套餐中的套餐状态
	public static final String SUBTYPE_TYPE []={"","阅读中","已过期"};

	
	
	public PackageOrder(String pkorder)throws SQLException
	{
		this.pkorder = pkorder;
		load();
	}
	public static PackageOrder find(String pkorder) throws SQLException
	{
		return new PackageOrder(pkorder);
	}
	
	public void load() throws SQLException {
		DbAdapter db = new DbAdapter();
		try {
			db
					.executeQuery("SELECT sid,sname, marketprice, promotionsprice, remarks,whethermail,shoujiaren,dizhi,youbian,"
							+ "  dianhua,fapiaotaitou,fapiaoneirong,beizhushuoming,member,orderstime, paytime, type,paymanner,"
							+ "  community,payname,issued,paymentmember,paymenttime,revocationmember,revocationtime,effect,effectmember,effecttime," 
							+ "  subtype,substarttime,subendtime,activatime,node FROM PackageOrder  WHERE   pkorder =  "
							+ db.cite(pkorder));
			if (db.next()) {
				sid = db.getInt(1);// 套餐id
				sname = db.getString(2);// 套餐名称
				marketprice = db.getBigDecimal(3, 2); // 人民币价格
				promotionsprice = db.getBigDecimal(4, 2); // 美元价格
				remarks = db.getString(5);// 套餐备注说明

				whethermail = db.getInt(6);// 是否邮寄 0 不邮寄 ，1 邮寄

				shoujiaren = db.getString(7);// 收件人
				dizhi = db.getString(8);// 地址
				youbian = db.getString(9);// 邮编
				dianhua = db.getString(10);// 电话
				fapiaotaitou = db.getString(11);// 发票抬头
				fapiaoneirong = db.getString(12);// 发票内容
				beizhushuoming = db.getString(13);// 备注说明

				member = db.getString(14);// 订单用户
				orderstime = db.getDate(15);// 下单时间
				paytime = db.getDate(16);// 支付时间

				type = db.getInt(17);// 是否支付 0 订单初始，没有支付
				paymanner = db.getInt(18);// 支付方式 0 在线支付 1 线下支付

				community = db.getString(19);// 社区
				payname=db.getString(20);//支付名称
				issued=db.getInt(21);
				paymentmember=db.getString(22);
				paymenttime=db.getDate(23);
				revocationmember=db.getString(24);
				revocationtime=db.getDate(25);
				effect=db.getInt(26);
				effectmember=db.getString(27);
				effecttime=db.getDate(28);
				subtype=db.getInt(29);
				substarttime=db.getDate(30);
				subendtime=db.getDate(31);
				activatime=db.getDate(32); 
				node=db.getInt(33);
				exists = true;
			} else {
				exists = false;
			}
		} finally {
			db.close();
		}
	}
	
	 public static String create(int sid,String sname,BigDecimal marketprice, BigDecimal promotionsprice, String remarks,	int whethermail,
			 String shoujiaren,String dizhi,String youbian,String dianhua,String fapiaotaitou,String fapiaoneirong,String beizhushuoming,
			 String member,Date orderstime,Date paytime,int type,int paymanner,String community,int node) throws SQLException
	    {
			SimpleDateFormat sdf = new  SimpleDateFormat("yyyyMMdd"); 
	    	Date timestring = new Date();
	    	String pkorder = sdf.format(timestring) + SeqTable.getSeqNo("performOrders");
	        DbAdapter db = new DbAdapter();
	        String i = "";
	        try
	        {
	            db.executeUpdate("INSERT INTO PackageOrder (pkorder,sid, sname, marketprice,  promotionsprice,  remarks,	 whethermail,	 " +
	            		"   shoujiaren, dizhi, youbian, dianhua, fapiaotaitou, fapiaoneirong, beizhushuoming, member, orderstime, paytime,	 type, paymanner, community,node) " +
	                             " VALUES ("+db.cite(pkorder)+" , "+sid+","+db.cite(sname)+","+marketprice+","+promotionsprice+","+db.cite(remarks)+","+whethermail+"," +
	                             " "+db.cite(shoujiaren)+" ,"+db.cite(dizhi)+","+db.cite(youbian)+","+db.cite(dianhua)+","+db.cite(fapiaotaitou)+" ,"+db.cite(fapiaoneirong)+", "+db.cite(beizhushuoming)+"," +
	                             " "+db.cite(member)+","+db.cite(orderstime)+","+db.cite(paytime)+","+type+","+paymanner+" ,"+db.cite(community)+","+node+" )");
	            i = db.getString("SELECT MAX(pkorder) FROM PackageOrder");
	        } finally
	        {
	            db.close();
	        }
	        return i;
	    }
	 
	 public void set(int sid,String sname,BigDecimal marketprice, BigDecimal promotionsprice, String remarks,	int whethermail,
			 String shoujiaren,String dizhi,String youbian,String dianhua,String fapiaotaitou,String fapiaoneirong,String beizhushuoming,
			 String member,Date orderstime,Date paytime,	int type,int paymanner,String community,int node) throws SQLException
	    {
	        DbAdapter db = new DbAdapter();
	        try 
	        {
	            db.executeUpdate("UPDATE PackageOrder SET sid="+sid+",sname="+db.cite(sname)+",marketprice="+marketprice+",promotionsprice="+promotionsprice+",remarks="+db.cite(remarks)+" ," +
	            		" whethermail="+whethermail+",shoujiaren="+db.cite(shoujiaren)+",dizhi="+db.cite(dizhi)+",youbian="+db.cite(youbian)+",dianhua="+db.cite(dianhua)+"," +
	            		" fapiaotaitou="+db.cite(fapiaotaitou)+",fapiaoneirong="+db.cite(fapiaoneirong)+",beizhushuoming="+db.cite(beizhushuoming)+",member="+db.cite(member)+"," +
	            	    " orderstime="+db.cite(orderstime)+",paytime="+db.cite(paytime)+",type="+type+",paymanner="+paymanner+",community="+db.cite(community)+",node="+node+" WHERE pkorder=" + db.cite(pkorder));
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
	            db.executeQuery("SELECT pkorder FROM PackageOrder WHERE community= " + db.cite(community) + sql,pos,size);
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
	 
	public void delete() throws SQLException {
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate("DELETE FROM  PackageOrder WHERE pkorder = "+ db.cite(pkorder));

		} finally {
			db.close();
		}
	}
	    public static int count(String community,String sql) throws SQLException
	    {
	        int count = 0;
	        DbAdapter db = new DbAdapter();
	        try
	        {
	            db.executeQuery("SELECT COUNT(pkorder) FROM PackageOrder  WHERE community=" + db.cite(community) + sql);
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
	    
	    public void set(String zd,int sz)throws SQLException
	    {
	    	DbAdapter db = new DbAdapter();
	    	try
	    	{
	    		db.executeUpdate("UPDATE PackageOrder SET "+zd+" = "+sz+" WHERE pkorder =  "+db.cite(pkorder));
	    	}finally
	    	{
	    		db.close();
	    	}
	    }
	    //修改支付名称的
	    public void setPayname(String payname)throws SQLException
	    {
	    	DbAdapter db = new DbAdapter();
	    	try
	    	{
	    		db.executeUpdate("UPDATE PackageOrder SET payname="+db.cite(payname)+" WHERE pkorder =  "+db.cite(pkorder));
	    	}finally
	    	{
	    		db.close();
	    	}
	    }
	    //修改付款时间
	    public void setPaytime(Date paytime)throws SQLException
	    {
	    	DbAdapter db = new DbAdapter();
	    	try
	    	{
	    		db.executeUpdate("UPDATE PackageOrder SET paytime="+db.cite(paytime)+" WHERE pkorder =  "+db.cite(pkorder));
	    	}finally
	    	{
	    		db.close();
	    	}
	    }
	    //手动付款操作人 手动付款操作时间 private String paymentmember;//手动付款操作人private Date paymenttime;//手动付款操作时间
		
	    public void set(String paymentmember,Date paymenttime)throws SQLException
	    {
	    	DbAdapter db = new DbAdapter();
	    	try
	    	{
	    		db.executeUpdate("UPDATE PackageOrder SET paymentmember="+db.cite(paymentmember)+",paymenttime="+db.cite(paymenttime)+" WHERE pkorder =  "+db.cite(pkorder));
	    	}finally
	    	{ 
	    		db.close();
	    	}
	    }
	    //撤销手动付款revocationtime revocationmember
		
	    public void setRevocation(String revocationmember,Date revocationtime)throws SQLException
	    {
	    	DbAdapter db = new DbAdapter();
	    	try
	    	{
	    		db.executeUpdate("UPDATE PackageOrder SET revocationmember="+db.cite(revocationmember)+",revocationtime="+db.cite(revocationtime)+" WHERE pkorder =  "+db.cite(pkorder));
	    	}finally
	    	{ 
	    		db.close();
	    	}
	    }
	    //手动生效 修改 人和时间  effect
	    
	    public void setEffect(String effectmember,Date effecttime)throws SQLException
	    {
	    	DbAdapter db = new DbAdapter();
	    	try
	    	{
	    		db.executeUpdate("UPDATE PackageOrder SET effectmember="+db.cite(effectmember)+",effecttime="+db.cite(effecttime)+" WHERE pkorder =  "+db.cite(pkorder));
	    	}finally
	    	{ 
	    		db.close();
	    	}
	    }
	    
	    //修改激活时间
	    public void setActivatimet(Date activatime)throws SQLException
	    {
	    	DbAdapter db = new DbAdapter();
	    	try
	    	{
	    		db.executeUpdate("UPDATE PackageOrder SET activatime="+db.cite(activatime)+" WHERE pkorder =  "+db.cite(pkorder));
	    	}finally
	    	{ 
	    		db.close();
	    	}
	    }
	    
	    /***
	     * 计算套餐的开始 结束时间
	     * @param porders 订单号 
	     * @throws SQLException
	     */
	    public void setSubtime(String porders)throws SQLException
	    {
	    	PackageOrder pobj = PackageOrder.find(porders);
	    	Subscribe sobj = Subscribe.find(pobj.getSid());
	    	Date tem_starttime  =null;//临时开始时间
	    	Date tem_endtime  =null;//临时结束时间
	    	
	    	java.util.Enumeration e = ReadRight.find(" and father ="+pobj.getSid(), 0, Integer.MAX_VALUE);
	    	for(int i = 1;e.hasMoreElements();i++)
	    	{
	    		int rrid =((Integer)e.nextElement()).intValue();
	    		ReadRight rrobj = ReadRight.find(rrid);
	    		//判断是否是有效期
	    		Date yd_timec =null;
	    		Date yd_timed =null;
	    		if(rrobj.getYuedu_yxqi()==1)//绝对日期
	    		{
	    			//开始时间
	    			yd_timec = rrobj.getYd_timec();
	    			//结束时间
	    			yd_timed = rrobj.getYd_timed();
	    		}else if(rrobj.getYuedu_yxqi()==2)//相对日期
	    		{
	    			yd_timec = PackageOrder.getTimes(rrobj.getYd_2_timec(),pobj.getActivatime());
	    			yd_timed = PackageOrder.getTimes(rrobj.getYd_2_timed(),pobj.getActivatime());
	    		}
	    	//	System.out.println("yd_timec:"+Entity.sdf2.format(yd_timec));
	    	//	System.out.println("yd_timed:"+Entity.sdf2.format(yd_timed));
	    		//after
	    		if(i==1)
	    		{
	    			tem_starttime = yd_timec;
	    			tem_endtime   = yd_timed;
	    		}else 
	    		{ 
		    		if(yd_timec.compareTo(tem_starttime)<=0   )
		    		{
		    			tem_starttime =yd_timec;
		    		} 
		    		if(yd_timed.compareTo(tem_endtime)>=0  )
		    		{
		    			tem_endtime =yd_timed;
		    		}
	    		}
	    	}
	    	this.set(1, tem_starttime, tem_endtime);
	    }
	    /*** 
	     * 套餐时间的加  减 
	     * @param str-对年月日的操作
	     * @param activatime 在日期基础上
	     * @return t
	     * @throws SQLException
	     */
	    public static Date getTimes(String str,Date activatime)throws SQLException
	    { 
	    	Date t = null;
	    	 str = str.trim();  
	    	//-1Y
	    	if(str.indexOf("-")!=-1&&str.indexOf("Y")!=-1)//说明是 日期 减 年
	    	{
	    		str = str.replaceAll("-", "");
	    		str = str.replaceAll("Y",""); 
	    		t = PackageOrder.getBeforeDate(activatime,Integer.parseInt(str),"Y");
	    	}else if(str.indexOf("+")!=-1&&str.indexOf("Y")!=-1)//说明是 日期 减 年
	    	{
	    		str = str.replaceAll("\\+", "");
	    		str = str.replaceAll("Y",""); 
	    		t = PackageOrder.getAfterDate(activatime,Integer.parseInt(str),"Y");
	    	}else if(str.indexOf("-")!=-1&&str.indexOf("M")!=-1)
	    	{
	    		str = str.replaceAll("-", "");
	    		str = str.replaceAll("M","");
	    		
	    		t = PackageOrder.getBeforeDate(activatime,Integer.parseInt(str),"M");
	    	}else if(str.indexOf("+")!=-1&&str.indexOf("M")!=-1)
	    	{
	    		str = str.replaceAll("\\+", "");
	    		str = str.replaceAll("M",""); 
	    		t = PackageOrder.getAfterDate(activatime,Integer.parseInt(str),"M");
	    	}else if(str.indexOf("-")!=-1&&str.indexOf("D")!=-1)
	    	{
	    		str = str.replaceAll("-", "");
	    		str = str.replaceAll("D",""); 
	    		t = PackageOrder.getBeforeDate(activatime,Integer.parseInt(str),"D");
	    	}else if(str.indexOf("+")!=-1&&str.indexOf("D")!=-1)
	    	{
	    		str = str.replaceAll("\\+", "");
	    		str = str.replaceAll("D",""); 
	    		t = PackageOrder.getAfterDate(activatime,Integer.parseInt(str),"D");
	    	}
	    
	    	return t;
	    	
	    }
	      
	    /****
	     * 计算日期的减法
	     * @param date 在date的日期的基础上
	     * @param days 要减去的 数
	     * @param ymd 对 年 月 日 的操作 
	     * @return
	     */
	    public static Date getBeforeDate(Date date,int days,String ymd)   
	    {   
	        
	        Date d = null;
	        Calendar cal = Calendar.getInstance();  
	        cal.setTime(date);//
	        
	        if("Y".equals(ymd))
	        {
	            cal.add(Calendar.YEAR, -days); 
	        }else if("M".equals(ymd))
	        {
	        	 cal.add(Calendar.MONTH, -days); 
	        }else if("D".equals(ymd))
	        {
	        	 cal.add(Calendar.DATE, -days); 
	        }
	        
	        return cal.getTime();
	        
	    }   
	    /****
	     * 计算日期的加法
	     * @param date 在date的日期的基础上
	     * @param days 要加的 数
	     * @param ymd 对 年 月 日 的操作 
	     * @return
	     */
	    public static Date getAfterDate(Date date,int days,String ymd)   
	    {   
	    	    Date d = null;
		        Calendar cal = Calendar.getInstance();  
		        cal.setTime(date);//
		        
		        if("Y".equals(ymd))
		        {
		            cal.add(Calendar.YEAR, +days); 
		        }else if("M".equals(ymd))
		        {
		        	 cal.add(Calendar.MONTH, +days); 
		        }else if("D".equals(ymd))
		        {
		        	 cal.add(Calendar.DATE, +days); 
		        }
		        
		        return cal.getTime(); 
	    }  
	    /***修改套餐的开始结束时间	
	     * private int subtype;//套餐的阅读权限
		 * private Date substarttime;//套餐开始时间
		 * private Date subendtime;//套餐开始时间
		 * 
		 * @param subtype
		 * @param substarttime
		 * @param subendtime
		 * @throws SQLException
		 */
	    public void set(int subtype,Date substarttime,Date subendtime)throws SQLException
	    {
	    	DbAdapter db = new DbAdapter();
	    	try
	    	{
	    		db.executeUpdate("update PackageOrder set subtype="+subtype+",substarttime="+db.cite(substarttime)+",subendtime="+db.cite(subendtime)+" where pkorder =  "+db.cite(pkorder));
	    		
	    	}finally
	    	{
	    		db.close();
	    	}
	    }
	    /***
	     * 定时器
	     */
	    public static void sync()
	    {
	    	 try
	         {
	    		 Timer timer = new Timer();
	             timer.schedule(new TimerTask()
	             {
	                 String last = null;
	                 public void run()
	                 {
	                	 try
						{  
	                		 PackageOrder.DeleteOrder();
						} catch (SQLException e)
						{
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
	                 }
	             },0,100 * 1000);//5 秒 扫描
	         } catch(Exception ex)
	         {
	             ex.printStackTrace();
	         }

	    }
	    public static void DeleteOrder()throws SQLException
	    {
	    	//System.out.println("------定时器删除订单----------");
	    	
	    	//删除订阅 30天 的订单
	    	DbAdapter db = new DbAdapter();
	    	try
	    	{
	    		Date t = PackageOrder.getAfterDate(new Date(),30,"D"); 
	    		db.executeQuery("select pkorder from PackageOrder where type=0 and orderstime > "+db.cite(t));
	    		//System.out.println("select pkorder from PackageOrder where type=0 and orderstime > "+db.cite(t));
	    		while(db.next()) 
	    		{
	    			PackageOrder.find(db.getString(1)).delete();
	    			//删除支付中转表中套餐订单
	    			PayOrder.delete(PackageOrder.find(db.getString(1)).getCommunity(),db.getString(1)); 
	    			System.out.println("------定时器删除30天的订单："+db.getString(1)+"----------"); 
	    		}
	    		//" and member ="+DbAdapter.cite(teasession._rv._strR)+" and effect =1 and subtype <> 0 "
	    		
	    		db.executeQuery(" select pkorder from PackageOrder where  effect =1 and subtype =1 and subendtime < "+db.cite(new Date()));
	    		while(db.next())
	    		{
	    			PackageOrder.find(db.getString(1)).set("subtype", 2);//修改成过期
	    			System.out.println("------定时器修改过期的订单："+db.getString(1)+"----------"); 
	    		} 
	    		//定期删除手机支付验证码中数据
	    		db.executeQuery(" select mobileorder from MobileOrder where type=1 and  maturitytimes < "+db.cite(new Date()));
	    		//System.out.println(" select mobileorder from MobileOrder where maturitytimes < "+db.cite(new Date()));
	    		while(db.next())
	    		{
	    			String mobileorder = db.getString(1);
	    			MobileOrder mobj = MobileOrder.find(mobileorder);
	    			mobj.setType(3);
	    			System.out.println("------定时器修改手机过期订单："+mobileorder+"----------"); 
	    		}
	    	}finally
	    	{
	    		db.close();
	    	}
	    	
	    	
	    }
	    /**
	     * 验证会员访问的其次是否在套餐有效期内
	     * @return
	     */
	    public static boolean isTaoCan(String qicitimes,int father,String community,String member,int ban)throws SQLException
	    {
	    	boolean f = false;
	    	
	    	
	    	
	    	DbAdapter db = new DbAdapter();
	    	try
	    	{
	    		db.executeQuery("select r.rrid,p.activatime from PackageOrder p,ReadRight r  where p.sid = r.father  " +
	    				"	and p.node ="+father+"  		" +
	    				"	and p.member="+db.cite(member)+" 	" +
	    				"	and p.community="+db.cite(community)+"	" +
	    				" 	and p.effect=1 " +				
	    				"   and ( r.suoyou=0 or r.banci like "+db.cite("%/"+ban+"/%")+") ");

	    		while(db.next())
	    		{
	    			int rrid = db.getInt(1);
	    			ReadRight rrobj = ReadRight.find(rrid);
	    			Date activatime = db.getDate(2);
	    			
	    			boolean ff = false;
	    			boolean fff= false;
	    			
	    			//判断其次范围
	    			
	    			
					try {
						Date t= sdf.parse(qicitimes);
						Date t2= new Date();
					
							//System.out.println(t.compareTo(rrobj.getQc_timec())>0 && t.compareTo(rrobj.getQc_timed())<0);
							if(rrobj.getQici_fanwei()==1)//绝对
			    			{
			    				if(t.compareTo(rrobj.getQc_timec())>0 && t.compareTo(rrobj.getQc_timed())<0)
			    				{
			    					ff = true;
			    				}
			    			}else if(rrobj.getQici_fanwei()==2)//相对
			    			{
			    				Date qc_timec = PackageOrder.getTimes(rrobj.getQc_2_timec(),activatime);
				    			Date qc_timed = PackageOrder.getTimes(rrobj.getQc_2_timed(),activatime);
				    			 
				    			if(t.compareTo(qc_timec)>0 && t.compareTo(qc_timed)<0)
			    				{ 
			    					ff = true;
			    				}
			    			}
							
							if(ff)
							{
								//判断阅读期限
								
								if(rrobj.getYuedu_yxqi()==1)//绝对
								{
									if(t2.compareTo(rrobj.getYd_timec())>0 && t2.compareTo(rrobj.getYd_timed())<0)
				    				{
										fff = true;
				    				}
									
								}else if(rrobj.getYuedu_yxqi()==2)//相对
								{

				    				Date yd_timec = PackageOrder.getTimes(rrobj.getYd_2_timec(),activatime);
					    			Date yd_timed = PackageOrder.getTimes(rrobj.getYd_2_timed(),activatime);
					    			
					    			if(t2.compareTo(yd_timec)>0 && t2.compareTo(yd_timed)<0)
				    				{
					    				fff = true;
				    				}
								} 
								
							}else
							{
								continue;//结束本次循环
							}
		    				
							if(ff && fff )
							{
								f = true;
							}else
							{
								break;
							}

					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
	    			
	    		}
	    		
	    	}finally
	    	{
	    		db.close();
	    	}
	    	
	    	return f;
	    }
	    /**
	     * 判断如果订单中是否有用到的套餐
	     * @return
	     */
	     
	    public static boolean isSid(int sid)throws SQLException
	    {
	    	boolean f = false;
	    	DbAdapter db = new DbAdapter();
	    	try
	    	{   
	    		db.executeQuery("select sid from PackageOrder where ( subtype <>2 or subtype is null  )and sid = "+sid);
	    		
	    		if(db.next())
	    		{
	    			f = true;
	    		}
	    			
	    	}finally
	    	{
	    		db.close();
	    	}
	    	return f;
	    }

	    
		public int getSid() {
			return sid;
		}
		public String getSname() {
			return sname;
		}
		public BigDecimal getMarketprice() {
			return marketprice;
		}
		public BigDecimal getPromotionsprice() {
			return promotionsprice;
		}
		public String getRemarks() {
			return remarks;
		}
		public int getWhethermail() {
			return whethermail;
		}
		public String getShoujiaren() {
			return shoujiaren;
		}
		public String getDizhi() {
			return dizhi;
		}
		public String getYoubian() {
			return youbian;
		}
		public String getDianhua() {
			return dianhua;
		}
		public String getFapiaotaitou() {
			return fapiaotaitou;
		}
		public String getFapiaoneirong() {
			return fapiaoneirong;
		}
		public String getBeizhushuoming() {
			return beizhushuoming;
		}
		public String getMember() {
			return member;
		}
		public Date getOrderstime() {
			return orderstime;
		}
		
		public String getOrderstimeToString()
		{
			if(orderstime ==null)
			{
				return "";
			}
			return sdf2.format(orderstime);
		}
		
		
		
		public Date getPaytime() {
			return paytime;
		}
		public String getPaytimeToString()
		{
			if(paytime ==null)
			{
				return "";
			}
			return sdf2.format(paytime);
		}
		
		public int getType() {
			return type;
		}
		public int getPaymanner() {
			return paymanner;
		}
		public String getCommunity() {
			return community;
		}
		public boolean isExists() {
			return exists;
		}
		public String getPayname()
		{
			return payname;
		}
		public int getIssued()
		{
			return issued;
		}
	    public String getPaymentmember()
	    {
	    	return paymentmember;
	    }
	    public Date getPaymenttime()
	    {
	    	return paymenttime;
	    }
	    public String getPaymenttimeToString()
	    {
	    	if(paymenttime == null)
	    		return "";
	    	return sdf2.format(paymenttime);
	    }
	    
	    public String getRevocationmember()
	    {
	    	return revocationmember;
	    }
	    public Date getRevocationtime()
	    {
	    	return revocationtime;
	    }
	    public String getRevocationtimeToString()
	    {
	    	if(revocationtime == null)
	    		return "";
	    	return sdf2.format(revocationtime);
	    }
	    public int getEffect()
	    {
	    	return effect;
	    }
	    public String getEffectmember()
	    {
	    	return effectmember;
	    }
	    public Date getEffecttime()
	    {
	    	return effecttime;
	    }
	    public String getEffecttimeToString()
	    {
	    	if(effecttime == null)
	    		return "";
	    	return sdf2.format(effecttime);
	    }
	    
	    public int getSubtype()
	    {
	    	return subtype;
	    }
	    public Date getSubstarttime()
	    {
	    	return substarttime;
	    }
	    public String getSubstarttimeToString()
	    {
	    	if(substarttime == null)
	    		return "";
	    	return sdf2.format(substarttime);
	    }
	    public Date getSubendtime()
	    {
	    	return subendtime;
	    }
	    public String getSubendtimeToString()
	    {
	    	if(subendtime == null)
	    		return "";
	    	return sdf2.format(subendtime);
	    }
	    public Date getActivatime()
	    {
	    	return activatime;
	    }
	    
	    public String getActivatimeToString()
	    {
	    	if(activatime == null)
	    		return "";
	    	return sdf2.format(activatime);
	    }
	    public int getNode()
	    {
	    	return node;
	    }
}

