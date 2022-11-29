package tea.ui.type.perform;


import javax.imageio.ImageIO;
import javax.servlet.*;
import javax.servlet.http.*;

import javax.servlet.http.HttpSession;


import com.swetake.util.Qrcode;



import java.awt.Color;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.URLEncoder;
import java.util.*;
import java.text.*;

import tea.ui.*;
import tea.entity.*;
import tea.entity.member.*;
import tea.entity.admin.*;
import tea.entity.admin.erp.GoodsDetails;
import tea.entity.admin.erp.Paidinfull;
import tea.entity.admin.erp.Purchase;
import tea.entity.node.*;
import tea.entity.league.*;
import tea.applet.PrintTest;
import tea.db.*;


public class EditPerformOrders extends TeaServlet
{
	 public void init() throws ServletException
	    {
	    }

	    // Process the HTTP Get request
	    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	    {
	        response.setContentType("text/html;charset=UTF-8");
	        request.setCharacterEncoding("UTF-8");
	        TeaSession teasession = new TeaSession(request);
	       // if(teasession._rv == null)
	      //  {
	          //  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
	           // return;
	       // }
	        HttpSession session = request.getSession();
	        String act = teasession.getParameter("act");
	        String nexturl = teasession.getParameter("nexturl");
	        int psid = 0;
	        if(teasession.getParameter("psid")!=null&& teasession.getParameter("psid").length()>0)
	        {
	        	psid = Integer.parseInt(teasession.getParameter("psid"));
	        }


	        try
	        {
	        	 PerformStreak psobj = PerformStreak.find(psid);

			      //演出名称
			      Node nobj1= Node.find(psobj.getNode());
			      //演出场馆
			      Node nobj2 = Node.find(psobj.getVenues());
			      if("OnlineReservations".equals(act))//前台用户选择好座位时候 生成订单的判断
			      {
			    		
			    	  String member = teasession.getParameter("member");
			    	  if(member!=null && member.length()>0){}
			    	  else
			    	  {
			    	  	member = session.getId();
			    	  }
			    	  String numbers = teasession.getParameter("numbers");//选择的座位编号
			    	//添加订单
			    	  String ordersid = PerformOrders.getOridsString(psid,numbers,member,teasession._strCommunity,teasession._nLanguage,0);
			    	  PerformOrders  orobj = PerformOrders.find(ordersid);
			    	  orobj.setMemberType(0);//默认都不是会员
			    	  //记录时间 不能超过15分钟
			    	    int m=15;

			    	    SimpleDateFormat myFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			    	    Date mydate= new Date();
			    	    Calendar cal=Calendar.getInstance();
			    	    cal.setTime(mydate);
			    	    cal.add(Calendar.MINUTE, m); //加分钟数
			    	    String timeString =myFormatter.format(cal.getTime());
			    	    session.setAttribute(session.getId(), timeString);
			    	    
			    	    nexturl ="/jsp/type/perform/PerformOrders1.jsp?ordersid="+ordersid;
			    	    

			      }
			      else if("PerformOrders2".equals(act))//前台用户添加好信息 订单确认判断
	            {
			    	  String ordersid = teasession.getParameter("ordersid");//订单号
			    	  PerformOrders pfoobj = PerformOrders.find(ordersid);

			    	  String odidstring = teasession.getParameter("odidstring");//订单细节的id

			    	  //订票总数
			    	  int odcount = Integer.parseInt(teasession.getParameter("odcount"));
			    	  //订票总金额
			    	  java.math.BigDecimal totalprice = new java.math.BigDecimal(teasession.getParameter("totalprice"));

	            	String names = teasession.getParameter("names");
	            	int zjlx = Integer.parseInt(teasession.getParameter("zjlx"));

	            	String zjhm = teasession.getParameter("zjhm");
	            	String yddh = teasession.getParameter("yddh");
	            	String gddh = teasession.getParameter("gddh");
	            	String dzyx = teasession.getParameter("dzyx");
	            	int sfsp = Integer.parseInt(teasession.getParameter("sfsp"));
	            	int sffp = Integer.parseInt(teasession.getParameter("sffp"));
	            	int spdz1 =0;//Integer.parseInt(teasession.getParameter("spdz1"));
	            	if(teasession.getParameter("spdz1")!=null && teasession.getParameter("spdz1").length()>0)
	            	{
	            		spdz1 = Integer.parseInt(teasession.getParameter("spdz1"));
	            	}

	            	String spdz2 = teasession.getParameter("spdz2");
	            	String qtsm = teasession.getParameter("qtsm");
	            	String memberString = pfoobj.getMember();
	            	if(teasession.getParameter("member")!=null && teasession.getParameter("member").length()>0)
	            	{
	            		memberString=teasession.getParameter("member");
	            		//是会员
	            		pfoobj.setMemberType(1);//是会员
	            	}
	            	//运费
	            	int fare = Integer.parseInt(teasession.getParameter("fare"));

	            	pfoobj.set(pfoobj.getPsid(), memberString, pfoobj.getCommunity(), names, zjlx, zjhm, yddh, gddh, dzyx, sfsp, sffp, spdz1, spdz2, qtsm);
	            	pfoobj.set(odcount, totalprice);//添加座位订单的数量和总金额
	            	pfoobj.setFare(fare);//添加运费
	            
	            	//会员卡号
	            	String member = teasession.getParameter("member");
 
	            	java.util.Enumeration e = OrderDetails.find(teasession._strCommunity," AND orderid ="+DbAdapter.cite(ordersid),0,200);
	        		for(int i = 1;e.hasMoreElements();i++)
	        		{
	        		//座位
	        		    int odid = ((Integer)e.nextElement()).intValue();
	            		OrderDetails odobj = OrderDetails.find(odid);
	            		SeatEditor seobj = SeatEditor.find(odobj.getNumbers(),psobj.getVenues());//显示场馆设置好的分布图
	           		    PriceDistrict pdobj = PriceDistrict.find(odobj.getNumbers(),psid);//分区价格显示图
	           		    PriceSubarea psobj2 = PriceSubarea.find(pdobj.getPricesubareaid());
	           		    odobj.set(odobj.getNumbers(), nobj1.getSubject(teasession._nLanguage), nobj2.getSubject(teasession._nLanguage),psobj.getPftimeToString(), seobj.getRegion(), seobj.getLinagenumber(), seobj.getSeatnumber(), psobj2.getPrice(), ordersid);

	           		//判断member是否有折扣
	         		   java.math.BigDecimal price2 = new java.math.BigDecimal("0");//折扣价格
	         		   boolean f = false;
	         		   if(Profile.isExisted(member))//如果有会员 有9折扣
	         		   {
	         		   		price2 = psobj2.getPrice().multiply(new java.math.BigDecimal("0.9")).setScale(2);
	         		   		f = true;
	         		   }
	         		   else
	         		   {
	         			  price2 = psobj2.getPrice();
	         		   }
	         		   odobj.set(price2, price2.setScale(2));

	            	}
	            	nexturl = "/jsp/type/perform/PerformOrders3.jsp?ordersid="+ordersid+"&community="+teasession._strCommunity;
	            } else if("delete".equals(act))
	            {

	            } else if("AdminOnlineReservations".equals(act))//后台管理员用户选择好座位以后 出票
	            {
	            	  String member = teasession.getParameter("member");
	            	  int membertype = 0;
			    	  if(member!=null && member.length()>0){
			    		  membertype = 1;
			    	  }
			    	  else
			    	  {
			    	  	member = session.getId();
			    	  }
			    	  String numbers = teasession.getParameter("numbers");//选择的座位编号
	            	//票种
			    	  String voteString = teasession.getParameter("vote");
			    	  int vote=0;  
			    	  if(voteString!=null && voteString.length()>0)
			    	  {
			    		  vote = Integer.parseInt(voteString.split(",")[1]);
			    	  }
			    	  //生产订单
	            	String ordersid = PerformOrders.getOridsString(psid,numbers,member,teasession._strCommunity,teasession._nLanguage,vote);
	            	PerformOrders porobj =  PerformOrders.find(ordersid);
	            	//添加是否是会员
	            	porobj.setMemberType(membertype);
	            	porobj.setType(4);//下了订单 付钱的 并打印出票的 
	            	porobj.setFrontrearType(1);//说明是台管理员订单
	            	porobj.setAdminMember(teasession._rv.toString());//添加出票管理员用户
	            	
	            	  System.out.println("调用-现场出票-程序");
	            	//打印订单
	                porobj.PrintOrder(teasession._strCommunity, request, response);
	               // System.out.println("管理员出票完成");  
	            	return; 
	            	  
	            }else if("AdminDrawabill".equals(act))//预订票页面的 确认出票
	            {
	            	
	            	String dingdan = teasession.getParameter("dingdan");//订单
	            	int lingpiao = 0;//领票人的类型 是本人还是其他人 
	            	if(teasession.getParameter("lingpiao"+dingdan)!=null && teasession.getParameter("lingpiao"+dingdan).length()>0)
	            	{
	            		lingpiao=Integer.parseInt(teasession.getParameter("lingpiao"+dingdan));
	            	}
	            	String lpname = teasession.getParameter("lpname"+dingdan);//姓名
	            	String lpzjhm = teasession.getParameter("lpzjhm"+dingdan);//身份证号
	            	PerformOrders poobj = PerformOrders.find(dingdan);
	            	 
	            	poobj.setType(4);//下了订单 付钱的 并打印出票的 
	            	poobj.setAdminMember(teasession._rv.toString());//添加出票管理员用户
	            	//修改领票信息
	            	poobj.setLingPiao(lingpiao, lpname, lpzjhm);
	            	 System.out.println("调用-预订票管理-程序");
	            	//打印订单
	            	poobj.PrintOrder(teasession._strCommunity, request, response);
	            	return;
	            }else if("BouncePiao_f_submit_cx".equals(act))//退票--重新打印
	            { 
	            	int pjnumber = Integer.parseInt(teasession.getParameter("pjnumber"));//票的座位id
	            	BouncePiao bpobj_2 = BouncePiao.find(pjnumber);//退票 表 
	            	 
	            	String member = session.getId(); 
	            	String orders_id = PerformOrders.getOridsString(bpobj_2.getPsid(),"/"+bpobj_2.getSeatnumber()+"/",member,teasession._strCommunity,teasession._nLanguage,0);
	            	
	            	PerformOrders porobj =  PerformOrders.find(orders_id);
	            	//修改这个订单数量和金额 
	            	porobj.set(1, bpobj_2.getPrice());
	            	porobj.setType(4);//下了订单 付钱的 并打印出票的 
	            	int type = 0;
	            	if(teasession.getParameter("type")!=null && teasession.getParameter("type").length()>0)
	            	{
	            		type = Integer.parseInt(teasession.getParameter("type"));
	            	}
	            	if(type==0)//退票
	            	{
	            	  porobj.setFrontrearType(3);//说明是退票重新打印
	            	}else if(type==1)
	            	{
	            		porobj.setFrontrearType(4);//说明是废票重新打印
	            	}
	            	 System.out.print("psid:"+bpobj_2.getPsid()+"odpjobj.getNumbers():"+bpobj_2.getSeatnumber());
	         
	            	//打印订单
	            	 porobj.PrintOrder(teasession._strCommunity, request, response); 	
	            	 System.out.println("调用-type:"+type+"-退-废票管理-程序");
	            	return;
	            }
	            response.sendRedirect(nexturl);
	            return;
	        } catch(Exception ex)
	        {
	            ex.printStackTrace();
	        }
	    }
	
	    // Clean up resources
	    public void destroy()
	    {
	    }
	}
