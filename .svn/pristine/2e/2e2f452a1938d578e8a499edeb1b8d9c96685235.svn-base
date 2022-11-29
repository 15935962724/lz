package tea.entity.node;

import java.io.IOException;
import java.io.ObjectOutputStream;
import java.io.UnsupportedEncodingException;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import tea.applet.PrintTest;
import tea.db.*;
import tea.entity.*;
import tea.entity.member.Profile;
import tea.ui.TeaSession;
import tea.ui.member.profile.newcaller;

public class PerformOrders extends Entity
{
	private String ordersid;//订单号
	private int psid;//演出场次
	private String member;//用户或是机器session
	private String community;//社区
	private Date times;//下单时间
	private String names;//您的姓名
	private int zjlx;//证件类型
	private String zjhm;//证件号码
	private String yddh;//移动电话
	private String gddh;//固定电话
	private String dzyx;//电子邮箱
	private int sfsp;//是否送票 0 不，1是
	private int sffp;//是否要发票 0 不 1是
	private int spdz1;//送票地址 区域是选择的id
	private String spdz2;//送票地址 填写具体的地址
	private String qtsm;//其他说明

	private int quantity;//订票数量
	private java.math.BigDecimal totalprice;//票价合计
	private int type;//订单状态，判断是否支付的标示 0 没有支付 1 支付成功 2,支付失败,3 货到付款， 4 打印出票
	private int frontreartype;//表示是用户下的单还是票务员下的单 0 是用户前台,在线支付，1 是票务员打印现场支付，2 前台用户 票到付款支付 (支付方式 ),3退票重新打印的,4废票重新打印
	//领票
	private int lingpiao;///领票人的类型 是本人还是其他人
	private String lpname;//领票人 姓名
	private String lpzjhm;//领票人 身份证号
	//票种标示
	private int vote;//票 种 0 为标准票
	//票是那个用户出的
	private String adminmember;
	//订单是否是会员
	private int membertype;//0 非会员 1 会员
	private int fare;//订单运费
	private boolean exist; //

	   public static final String ZJLX_TYPE[]={"","身份证","军官证","文职证","护照"};
	   public static final String SPDZ1_TYPE[]={"","东城区","西城区","宣武区","崇文区","朝阳区","海淀区","丰台区","石景山区","通州区","大兴区","房山区","门头沟区","昌平区","延庆县","怀柔区","顺义区","平谷区","密云县"};



	public PerformOrders(String ordersid) throws SQLException
    {
        this.ordersid = ordersid;
        load();
    }

    public static PerformOrders find(String ordersid) throws SQLException
    {
        return new PerformOrders(ordersid);
    }
    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT  psid,member,community,times,names,zjlx,zjhm,yddh,gddh,dzyx,sfsp,sffp,spdz1,spdz2,qtsm,quantity,totalprice,type,frontreartype,lingpiao,lpname,lpzjhm," +
            		" vote,adminmember,membertype,fare  FROM PerformOrders  WHERE ordersid = " + db.cite(ordersid));
            if(db.next())
            {
                psid=db.getInt(1);
                member=db.getString(2);
                community=db.getString(3);
                times =db.getDate(4);
                names=db.getString(5);
                zjlx=db.getInt(6);
                zjhm=db.getString(7);
                yddh=db.getString(8);
                gddh=db.getString(9);
                dzyx=db.getString(10);
                sfsp=db.getInt(11);
                sffp=db.getInt(12);
                spdz1=db.getInt(13);
                spdz2=db.getString(14);
                qtsm=db.getString(15);
                quantity=db.getInt(16);
                totalprice=db.getBigDecimal(17, 2);
                type = db.getInt(18);
                frontreartype=db.getInt(19);
                lingpiao=db.getInt(20);
                lpname=db.getString(21);
                lpzjhm=db.getString(22);
                vote=db.getInt(23);
                adminmember=db.getString(24);
                membertype=db.getInt(25);
                fare = db.getInt(26);
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
    public static void create(String ordersid,int psid,String member,String community,String names,int zjlx,String zjhm,String yddh,String gddh,String dzyx,int sfsp,int sffp,
    		int spdz1,String spdz2,String qtsm ) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        int type = 0;
        int frontreartype = 0;
        try
        {
            db.executeUpdate("INSERT INTO PerformOrders (ordersid,psid,member,community,times,names,zjlx,zjhm,yddh,gddh,dzyx,sfsp,sffp,spdz1,spdz2,qtsm,type,frontreartype) VALUES ("+db.cite(ordersid)+","+psid+"," +
            		" "+db.cite(member)+","+db.cite(community)+","+db.cite(times)+","+db.cite(names)+","+(zjlx)+","+db.cite(zjhm)+","+db.cite(yddh)+","+db.cite(gddh)+"," +
            		" "+db.cite(dzyx)+","+sfsp+","+sffp+","+spdz1+","+db.cite(spdz2)+","+db.cite(qtsm)+","+type+","+frontreartype+" )");
        } finally
        {
            db.close();
        }
    }
    public  void set(int psid,String member,String community,String names,int zjlx,String zjhm,String yddh,String gddh,String dzyx,int sfsp,int sffp,
    		int spdz1,String spdz2,String qtsm ) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
        	 db.executeUpdate("UPDATE PerformOrders SET  psid="+psid+",member="+db.cite(member)+",community="+db.cite(community)+",names="+db.cite(names)+",zjlx="+(zjlx)+"," +
        	 		"zjhm="+db.cite(zjhm)+",yddh="+db.cite(yddh)+",gddh="+db.cite(gddh)+",dzyx="+db.cite(dzyx)+",sfsp="+sfsp+",sffp="+(sffp)+",spdz1="+spdz1+"," +
        	 				" spdz2="+db.cite(spdz2)+",qtsm="+db.cite(qtsm)+" WHERE ordersid = " +db.cite(ordersid));
        } finally
        {
            db.close();
        }
    }
    public  void set(int quantity,java.math.BigDecimal totalprice) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
        	 db.executeUpdate("UPDATE PerformOrders SET quantity="+quantity+",totalprice="+totalprice+" WHERE ordersid = " +db.cite(ordersid));
        } finally
        {
            db.close();
        }
    }
    public void setType(int type)throws SQLException
    {
    	 DbAdapter db = new DbAdapter();
         try
         {
         	 db.executeUpdate("UPDATE PerformOrders SET type="+type+" WHERE ordersid = " +db.cite(ordersid));
         } finally
         {
             db.close();
         }
    }
    //修改出票用户
    public  void setAdminMember(String adminmember)throws SQLException
    {
    	 DbAdapter db = new DbAdapter();
         try
         {
         	 db.executeUpdate("UPDATE PerformOrders SET adminmember="+db.cite(adminmember)+" WHERE ordersid = " +db.cite(ordersid));
         } finally
         {
             db.close();
         }
    }
    //修改是否是会员标示
    public void setMemberType(int membertype)throws SQLException
    {
    	 DbAdapter db = new DbAdapter();
         try
         {
         	 db.executeUpdate("UPDATE PerformOrders SET membertype="+membertype+" WHERE ordersid = " +db.cite(ordersid));
         } finally
         {
             db.close();
         }
    }
    public void setFrontrearType(int frontreartype )throws SQLException
    {
	   	 DbAdapter db = new DbAdapter();
	     try
	     {
	     	 db.executeUpdate("UPDATE PerformOrders SET frontreartype="+frontreartype+" WHERE ordersid = " +db.cite(ordersid));
	     } finally
	     {
	         db.close();
	     }
    }
    //修改订单运费
    public void setFare(int fare)throws SQLException
    {
	   	 DbAdapter db = new DbAdapter();
	     try
	     {
	     	 db.executeUpdate("UPDATE PerformOrders SET fare="+fare+" WHERE ordersid = " +db.cite(ordersid));
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
            db.executeQuery("SELECT ordersid FROM PerformOrders WHERE community= " + db.cite(community) + sql,pos,size);
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
            db.executeUpdate("DELETE FROM  PerformOrders WHERE ordersid = " + db.cite(ordersid));

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
            db.executeQuery("SELECT COUNT(ordersid) FROM PerformOrders  WHERE community=" + db.cite(community) + sql);
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
  //添加订的票和订单
    public static String getOridsString(int psid,String numbers,String member,String community,int language,int vote)throws SQLException
    {


    	SimpleDateFormat sdf1 = new  SimpleDateFormat("yyyy-MM-dd");
    	SimpleDateFormat sdf = new  SimpleDateFormat("yyyyMMdd");
    	Date timestring = new Date();
    	String ordersid = sdf.format(timestring) + SeqTable.getSeqNo("performOrders");
    	PerformStreak psobj = PerformStreak.find(psid);

    	//演出名称
    	Node nobj1= Node.find(psobj.getNode());
    	//演出场馆
    	Node nobj2 = Node.find(psobj.getVenues());
    	//Seat sobj = Seat.find(psobj.getVenues());
    	PerformOrders.create(ordersid, psid, member, community, null, 0, null, null, null, null, 0, 0, 0, null, null);
    	//修改票种
    	PerformOrders.find(ordersid).setVote(vote);

      	//计算总价格
  	  int quantity =numbers.split("/").length-1;
  	  java.math.BigDecimal totalprice = new java.math.BigDecimal("0");

  	  //如果是会员记录会员
  	  if(member!=null && member.length()>0)
  	  {
  		 PerformOrders.find(ordersid).setMemberType(1);//是会员
  	  }
    	for(int i=1;i<numbers.split("/").length;i++)
    	{
    		   int numbersp= Integer.parseInt(numbers.split("/")[i]);
        		SeatEditor seobj = SeatEditor.find(numbersp,psobj.getVenues());//显示场馆设置好的分布图
       		    PriceDistrict pdobj = PriceDistrict.find(numbersp,psid);//分区价格显示图
       		    PriceSubarea psobj2 = PriceSubarea.find(pdobj.getPricesubareaid());

       		    java.math.BigDecimal bp = psobj2.getPrice();
       		    if(vote>0)//说明有票种
       		    {
       		    	bp = Vote.getVotePrice(vote,pdobj.getPricesubareaid());

       		    }else if(member!=null && member.length()>0 && Profile.isExisted(member))//会员打折
       		    {
       		    	bp = psobj2.getPrice().multiply(new java.math.BigDecimal("0.9")).setScale(2);
       		    }
       		    totalprice = totalprice.add(bp);
        		int odid = OrderDetails.create(numbersp, nobj1.getSubject(language), nobj2.getSubject(language),
        				psobj.getPftimeToString(), seobj.getRegion(), seobj.getLinagenumber(), seobj.getSeatnumber(), psobj2.getPrice(), ordersid,community,psid);

        		OrderDetails odobj = OrderDetails.find(odid);
        		odobj.set(bp,bp); //添加打折价格和原价
    	}
    	//添加票的总价格和数量
    	PerformOrders.find(ordersid).set(quantity, totalprice);
    	return ordersid;
    }
    //15分钟 删除没有订票的信息
    public static void DeleteOrdersid()throws SQLException
    {
    	DbAdapter db = new DbAdapter();
    	 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		 Date times = new Date();//当前时间

    	try{
    		db.executeQuery("SELECT ordersid,times FROM PerformOrders  WHERE type = 0");
    		while(db.next())
    		{
    			String oridString = db.getString(1);
    			Date timedDate = db.getDate(2);
    			//
    			long dqTimes=PerformOrders.fromDateStringToLong(sdf.format(times));//当前时间
    			long ddTimes =PerformOrders.fromDateStringToLong(sdf.format(timedDate));//订单时间

    			//System.out.println("当前时间:"+dqTimes+"----"+sdf.format(times));
    			//System.out.println("订单时间:"+ddTimes+"-----"+sdf.format(timedDate));
    			//System.out.println("(dqTimes-ddTimes):"+(dqTimes-ddTimes)/1000);

    			long ss=(dqTimes-ddTimes)/(1000); //共计秒数
    			int MM = (int)ss/60; //共计分钟数

    			if(MM>15)
    			 {

    				 System.out.println("--------订票计时器启动:时间："+MM+"--删除订单号:"+oridString+"---------");
    			 	PerformOrders porobj = PerformOrders.find(oridString);
    			 	porobj.delete();
    			 	OrderDetails.delete(oridString);
    			 }
    		}
    	}finally
    	{
    		db.close();
    	}
    }

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
						PerformOrders.DeleteOrdersid();
					} catch (SQLException e)
					{
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
                 }
             },0,60 * 1000);
         } catch(Exception ex)
         {
             ex.printStackTrace();
         }

    }



	public static long fromDateStringToLong(String inVal)
	{ // 此方法计算时间毫秒
		Date date = null; // 定义时间类型
		SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-mm-dd HH:mm:ss");
		try
		{
			date =inputFormat.parse(inVal); // 将字符型转换成日期型
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return date.getTime(); // 返回毫秒数
	}

	//预订票出票后修改信息
	public void setLingPiao(int lingpiao,String lpname,String lpzjhm)throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try{

			db.executeUpdate("UPDATE PerformOrders SET lingpiao="+lingpiao+" ,lpname="+db.cite(lpname)+",lpzjhm="+db.cite(lpzjhm)+" WHERE ordersid="+db.cite(ordersid));
		}finally
		{
			db.close();
		}
	}
	//打印订单信息
	public void  PrintOrder(String community,HttpServletRequest request,HttpServletResponse response)throws SQLException
	{
		 ArrayList al = new ArrayList();
		java.util.Enumeration e = OrderDetails.find(community," and orderid ="+DbAdapter.cite(ordersid), 0, 100);
		 HashMap m = new HashMap();
		while(e.hasMoreElements())
		{
			int odid = ((Integer)e.nextElement()).intValue();
			OrderDetails odobj = OrderDetails.find(odid);
			StringBuffer sp = new StringBuffer();
			String performname = odobj.getPerformname();//标题
        	//计算票种
			PerformOrders pobjOrders = PerformOrders.find(odobj.getOrderid());
			Vote vobjVote  = Vote.find(pobjOrders.getVote());
			String votename = vobjVote.getVotename();
			//打印票中的提示
			String prompt ="提示信息:";
			String prompt2 ="敬请演出前20分钟入场";
			//票的编号
			String bianhao ="NO:"+String.valueOf(odid);

			Date tDate =null;
			try {
				tDate = PerformStreak.sdf2.parse(odobj.getPstime());
			} catch (ParseException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			//副券中的时间
			String shijian = PerformStreak.sdf(tDate);
			//副券中的地点
			String didian =  odobj.getPsname();
			//主票面信息
			String pstime ="时间   DATE:   "+PerformStreak.sdf(tDate);
        	String psname ="地点    ADD:   "+odobj.getPsname();
        	String region ="座位   SEAT:   "+odobj.getRegion()+"   "+odobj.getLinage()+"排   "+odobj.getSeat()+"座";
        	String peice  ="票价  PEICE:   "+odobj.getTotalprice()+"元";
        	String piaozhong="";//票种
        	if(pobjOrders.getVote()>0){
        		piaozhong= vobjVote.getVotename();
        	}


	        	String surlString = request.getSession().getServletContext().getRealPath("/");

	        	String content=null;
				try {
					content= String.valueOf(odid)+"-"+String.valueOf(odobj.getNumbers())+"-"+odobj.getSeat()+"-"+java.net.URLEncoder.encode(odobj.getPstime(), "UTF-8");
				} catch (UnsupportedEncodingException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
	        	String url ="/servlet/QRCodeImg?content="+content+"&size=120";//odobj.getQRCodeImgUrl(pstime+psname+region+peice+String.valueOf(odid), odid, community,surlString);//odobj.getQRCodeImgUrl(pstime+psname+region+peice+String.valueOf(odid), odid, request,response, community);//二维码地址

        	  HashMap m2 = new HashMap();
        	  //主票面信息
        	  m2.put("performorders.performname", performname);
              m2.put("performorders.pstime", pstime);
              m2.put("performorders.psname", psname);
              m2.put("performorders.region", region);
              m2.put("performorders.peice", peice);
              //副券信息
              m2.put("performorders.shijian", shijian);
              m2.put("performorders.didian", didian);
              //提示信息
              m2.put("performorders.prompt", prompt);
              m2.put("performorders.prompt2", prompt2);
               //票种
               m2.put("performorders.votename", votename);
               //票编号
               m2.put("performorders.bianhao", bianhao);

              m2.put("performorders.url", "http://zhangjinshu:8080/"+url);//request.getServerName()+":"+request.getServerPort()+
              System.out.println("http://"+request.getServerName()+":"+request.getServerPort()+url);
              al.add(m2);

        	System.out.println(performname);
        	System.out.println(pstime);
        	System.out.println(psname);
        	System.out.println(region);
        	System.out.println(peice);
        	System.out.println("票种:"+piaozhong);
		}
		 m.put("performorders", al);
		 ObjectOutputStream out;
		try {
			out = new ObjectOutputStream(response.getOutputStream());
			out.writeObject(m);
		    out.close();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		System.out.println("服务器端接收了参数,正返回给客户端,请稍后.....");

	}
	//修改票种
	public void setVote(int vote)throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try{
			db.executeUpdate("UPDATE PerformOrders SET vote ="+vote+" WHERE ordersid = "+db.cite(ordersid));
		}finally
		{
			db.close();
		}
	}

	public int getPsid()
	{
		return psid;
	}

	public String getMember()
	{
		return member;
	}

	public String getCommunity()
	{
		return community;
	}

	public Date getTimes()
	{
		return times;
	}

	public String getNames()
	{
		return names;
	}

	public int getZjlx()
	{
		return zjlx;
	}

	public String getZjhm()
	{
		return zjhm;
	}

	public String getYddh()
	{
		return yddh;
	}

	public String getGddh()
	{
		return gddh;
	}

	public String getDzyx()
	{
		return dzyx;
	}

	public int getSfsp()
	{
		return sfsp;
	}

	public int getSffp()
	{
		return sffp;
	}

	public int getSpdz1()
	{
		return spdz1;
	}

	public String getSpdz2()
	{
		return spdz2;
	}

	public String getQtsm()
	{
		return qtsm;
	}

	public boolean isExist()
	{
		return exist;
	}

	public int getQuantity()
	{
		return quantity;
	}

	public java.math.BigDecimal getTotalprice()
	{
		return totalprice;
	}
	public int getType()
	{
		return type;
	}
	public int getFrontreartype()
	{
		return frontreartype;
	}

	public int getLingpiao() {
		return lingpiao;
	}

	public String getLpname() {
		return lpname;
	}

	public String getLpzjhm() {
		return lpzjhm;
	}
	public String getAdminMember()
	{
		return adminmember;
	}
	public int getMemberType()
	{
		return membertype;
	}
    public int getFare()
    {
    	return fare;
    }
    public int getVote()
    {
    	return vote;
    }

}
