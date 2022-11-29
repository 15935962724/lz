package tea.ui.node.type.subscribe;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.omg.Messaging.SYNC_WITH_TRANSPORT;

import tea.entity.subscribe.PackageOrder;
import tea.entity.subscribe.ReadRight;
import tea.entity.subscribe.Subscribe;
import tea.entity.subscribe.Tactics;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;




public class EditSubscribe extends TeaServlet
{
    // Initialize global variables
    public void init() throws ServletException
    {
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
		if(teasession._rv == null)
		{
			response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
			return;
		}
        String act = teasession.getParameter("act");
        String community = teasession.getParameter("community");
        String nexturl = teasession.getParameter("nexturl");
        int subid = 0;
        if(teasession.getParameter("subid")!=null && teasession.getParameter("subid").length()>0)
        {
           subid  = Integer.parseInt(teasession.getParameter("subid"));
        }

		try {
				   Subscribe sobj = Subscribe.find(subid);
			
	 
	            if("EditSubscribe".equals(act))
	            {
	            
	            	  String subject = teasession.getParameter("subject");//套餐名称 
	            	  
	            	
	            	  

	            	  
	            	  
	            	  
	            	  //人民币价格
	            	  java.math.BigDecimal marketprice = new java.math.BigDecimal("0");
	            	  if(teasession.getParameter("marketprice")!=null && teasession.getParameter("marketprice").length()>0)
	            	  {
	            	    marketprice = new java.math.BigDecimal(teasession.getParameter("marketprice"));
	            	  }
	            	  //美元价格
	            	  java.math.BigDecimal promotionsprice = new java.math.BigDecimal("0");
	            	  if(teasession.getParameter("promotionsprice")!=null && teasession.getParameter("promotionsprice").length()>0)
	            	  {
	            	    promotionsprice = new java.math.BigDecimal(teasession.getParameter("promotionsprice"));
	            	  }
	            	  
	            	  //备注
	            	  String remarks = teasession.getParameter("remarks");
	            	  int publish =1;
	            	  //会员类型
	            	  int membertype = Integer.parseInt(teasession.getParameter("membertype"));
	            	  
	            	  
	            	  if(sobj.isExists())
	            	  {
	            	    sobj.set(subject,marketprice,promotionsprice,teasession._nNode,teasession._strCommunity,teasession._rv.toString(),
	            	    		new Date(),teasession._rv.toString(),new Date(),publish,remarks,membertype);
	            	  }else
	            	  {
	            		  subid =   Subscribe.create(subject,marketprice,promotionsprice,teasession._nNode,teasession._strCommunity,teasession._rv.toString(),
	            	    		 new Date(),teasession._rv.toString(),new Date(),publish,remarks,membertype);
	            	  } 
	            	   

	            	  //添加权限表数据-------------------------------------

	            	  int rnum = 1;
	            	  if(teasession.getParameter("rnum")!=null && teasession.getParameter("rnum").length()>0)
	            	  {
	            		  rnum = Integer.parseInt(teasession.getParameter("rnum"));
	            	  }
	            	  
	            	   

	            	 
	            	  
	            	  int qici_fanwei=1;//期次范围 绝对，相对
	            	  
	            	  Date qc_timec = null;// 开始绝对
	            	  String qc_2_timec=null;//开始相对 
	            	  
	            	  Date qc_timed = null;// 结束绝对
	            	  String qc_2_timed=null;//结束相对 
	            	  
	            	  int yuedu_yxqi =1;//阅读范围
	            	  
	            	  Date yd_timec = null;// 开始绝对
	            	  String yd_2_timec =null;//开始相对

	            	  Date yd_timed = null;// 结束绝对
	            	  String yd_2_timed =null;//结束相对
	            	  
	            	 String rnum2 = teasession.getParameter("rnum2")+"/";
	            	   
	            	    
	            	  for(int i2=1;i2<rnum2.split("/").length;i2++)
	            	  { 

	            		  int i = 0;
	            		
	            		if(rnum2.split("/")[i2]!=null && rnum2.split("/")[i2].length()>0)
	            		  {
	            			 i = Integer.parseInt(rnum2.split("/")[i2]);
	            		  }
	            		  else 
	            		  {
	 
	            			 continue; 
	            		   }

	            		  int suoyou = 1;//所有版面
	            		  String banci = "/";//选中的版次
	            		  if(teasession.getParameter("suoyou_"+i)!=null && teasession.getParameter("suoyou_"+i).length()>0 )
	            		  {
	            			  suoyou = Integer.parseInt(teasession.getParameter("suoyou_"+i));
	            		  }else
	            		  {
	            			  if(teasession.getParameter("banci_"+i)!=null && teasession.getParameter("banci_"+i).length()>0)
	            			  {
		            			  String bcString [] = teasession.getParameterValues("banci_"+i);
		            			  for(int ii=0;ii<bcString.length;ii++)
		            			  {
		            				  banci =banci +bcString[ii]+"/";
		            			  }
	            			  }
	            		  } 
	            		  
	            		  //所有期次
	            		  int qici_suoyou = 0;
	            		  if(teasession.getParameter("qici_suoyou_"+i)!=null && teasession.getParameter("qici_suoyou_"+i).length()>0 )
	            		  {
	            			  qici_suoyou = Integer.parseInt(teasession.getParameter("qici_suoyou_"+i));
	            		  }

		            	  
	            		  //期次范围 绝对，相对
		            	  if(teasession.getParameter("qici_fanwei_"+i)!=null && teasession.getParameter("qici_fanwei_"+i).length()>0 )
	            		  {
		            		  qici_fanwei = Integer.parseInt(teasession.getParameter("qici_fanwei_"+i));
	            		  }
		            	  
		            	// 开始绝对
		            	  if(teasession.getParameter("qc_timec_"+i)!=null && teasession.getParameter("qc_timec_"+i).length()>0 )
	            		  {
		            		  try {
								qc_timec = Subscribe.sdf.parse(teasession.getParameter("qc_timec_"+i));
							} catch (ParseException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
	            		  }
		            	  qc_2_timec=teasession.getParameter("qc_2_timec_"+i);//开始相对 
		            	  
		            	 // 结束绝对
		            	  if(teasession.getParameter("qc_timed_"+i)!=null && teasession.getParameter("qc_timed_"+i).length()>0 )
	            		  {
		            		  try {
								qc_timed = Subscribe.sdf.parse(teasession.getParameter("qc_timed_"+i));
							} catch (ParseException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
	            		  }
		            	  
		            	 //结束相对 
		            	  qc_2_timed=teasession.getParameter("qc_2_timed_"+i);//
		            	  
		            	  
		            	  //设为永久 
		            	  int yd_sheweiyoujiu = 0;
		            	  if(teasession.getParameter("yd_sheweiyoujiu_"+i)!=null && teasession.getParameter("yd_sheweiyoujiu_"+i).length()>0)
		            	  {
		            		  yd_sheweiyoujiu =Integer.parseInt(teasession.getParameter("yd_sheweiyoujiu_"+i));
		            	  }
		            	  
		            	//阅读范围
		            	  if(teasession.getParameter("yuedu_yxqi_"+i)!=null && teasession.getParameter("yuedu_yxqi_"+i).length()>0 )
	            		  {
		            		  yuedu_yxqi = Integer.parseInt(teasession.getParameter("yuedu_yxqi_"+i));
	            		  }
		            	  
		            	 // 开始绝对
		            	  if(teasession.getParameter("yd_timec_"+i)!=null && teasession.getParameter("yd_timec_"+i).length()>0 )
	            		  {
		            		  try {
								yd_timec = Subscribe.sdf.parse(teasession.getParameter("yd_timec_"+i));
							} catch (ParseException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
	            		  }
		            	  //开始相对
		            	  yd_2_timec=teasession.getParameter("yd_2_timec_"+i);//
		            	  
		            	  
		            	// 结束绝对
		            	  if(teasession.getParameter("yd_timed_"+i)!=null && teasession.getParameter("yd_timed_"+i).length()>0 )
	            		  {
		            		  try {
								yd_timed = Subscribe.sdf.parse(teasession.getParameter("yd_timed_"+i));
							} catch (ParseException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
	            		  }
		            	  //结束相对
		            	  yd_2_timed=teasession.getParameter("yd_2_timed_"+i);//
		            	  
		            	  int ri = ReadRight.getRRid(teasession._nNode,subid, "Subscribe",i);
		            	  
		            	  ReadRight rrobj = ReadRight.find(ri);
		            	  if(rrobj.isExists() )
		            	  {
		            		  rrobj.set(suoyou, banci, qici_fanwei, qc_timec, qc_2_timec, yuedu_yxqi, yd_timec, yd_2_timec, qc_timed, qc_2_timed, yd_timed, yd_2_timed,i,
		            				  qici_suoyou,yd_sheweiyoujiu);
		            	  }else 
		            	  { 
		            		  ReadRight.create(suoyou, banci, qici_fanwei, qc_timec, qc_2_timec, yuedu_yxqi, yd_timec, yd_2_timec,teasession._nNode,subid, "Subscribe", 
		            				  qc_timed, qc_2_timed, yd_timed, yd_2_timed,i,qici_suoyou,yd_sheweiyoujiu);
		            	  } 
  
	            	  }
	            	  

	            	  
	            }else if("f_sub".equals(act))
	            {  
	            	String chk_subidString [] =  teasession.getParameterValues("checkbox_subid");
	            	boolean f = false;
	            	String onclick_act = teasession.getParameter("onclick_act");
	            	String next_str="";
	            	if(chk_subidString!=null)
	            	{
	            		for(int i = 0;i<chk_subidString.length;i++)
	            		{
	            			Subscribe sobj_sub = Subscribe.find(Integer.parseInt(chk_subidString[i]));
	            			if("delete".equals(onclick_act))//删除
	            			{
	            				//查询订单里面看有没有用到的套餐，如果有，不能删除
	            				//System.out.println(PackageOrder.isSid(Integer.parseInt(chk_subidString[i])));
	            				 
	            				if(PackageOrder.isSid(Integer.parseInt(chk_subidString[i])))
	            				{
	            					next_str = "您删除的套餐里面有【使用中】的套餐,系统不能执行删除操作!";
	            					f = true;
	            					break;
	            				}
		            			if(sobj_sub.getPublish()==0)//只能删除未公布测
		            			{
		            				sobj_sub.delete();
		            			    ReadRight.delete(Integer.parseInt(chk_subidString[i]));
		            			}else {
		            				next_str ="抱歉!您删除的套餐里面有公布的套餐.\\n系统只能删除未公布的套餐!";
									f = true;
								}
		            			
	            			}else if("publish".equals(onclick_act))//公布策略
	            			{
	            				if(sobj_sub.getPublish()==0)//未公布
		            			{
	            					sobj_sub.setPublish(1);
	            					sobj_sub.setMemberTime(teasession._rv.toString(), new Date());
		            				
		            			   
		            			}else {
		            				next_str ="抱歉!您公布的套餐里面有【公布】的套餐.\\n只能公布【未公布】的套餐!";
									f = true;
								}
		            			
	            			}else if("nopublish".equals(onclick_act))
	            			{//取消公布策略
	            			
	//查询订单里面看有没有用到的套餐，如果有，不能删除 
		            				
		            				if(PackageOrder.isSid(Integer.parseInt(chk_subidString[i])))
		            				{
		            					next_str = "您取消公布的套餐里面有【使用中】的套餐,系统不能执行取消公布操作!";
		            					f = true;
		            					break;
		            				}
	            				
	            				if(sobj_sub.getPublish()==1)//公布 
		            			{
	            					sobj_sub.setPublish(0);
		            			   
		            			}else {
		            				next_str ="抱歉!您取消公布的套餐里面有【未公布】的套餐.\\n系统只能取消【公布】的套餐!";
									f = true;
								}
		            			
							} 
	            			 
	            		}
	            	} 
	            	if(f)//删除策略里面有公布的策略 要提示用户
	            	{
	            		 java.io.PrintWriter out = response.getWriter();
	            		
	            		 out.print("<script  language='javascript'>alert('"+next_str+"');window.location.href='"+nexturl+"';</script> ");
	                     out.close();
	                     return;
	            	}
	            	
	            }
	   
			response.sendRedirect(nexturl);
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
               
    }

    // Clean up resources
    public void destroy()
    {
    }
}
    