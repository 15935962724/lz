package tea.ui.node.type.subscribe;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.entity.subscribe.ReadRight;
import tea.entity.subscribe.Subscribe;
import tea.entity.subscribe.Tactics;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.ui.member.profile.newcaller;




public class EditTactics extends TeaServlet
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
        int tid = 0;
        if(teasession.getParameter("tid")!=null && teasession.getParameter("tid").length()>0)
        {
        	tid  = Integer.parseInt(teasession.getParameter("tid"));
        }

		try {
			     Tactics tobj = Tactics.find(tid);
			
	 
	            if("EditTactics".equals(act))
	            {
	            
	            	  String tacname = teasession.getParameter("tacname");//策略名称 
	            	  

	      
	            	  int condition = Integer.parseInt(teasession.getParameter("condition"));//生效条件
	            	  int check_ip =0;//是否ip限制
	            	  if(teasession.getParameter("check_ip")!=null && teasession.getParameter("check_ip").length()>0)
	            	  {
	            		  check_ip = Integer.parseInt(teasession.getParameter("check_ip"));
	            	  }
	            	  String ip = teasession.getParameter("sx_ip");//限制的ip
	            	 
	            	  
	            	  String remarks = teasession.getParameter("remarks");//备注说明
	            	  
	            	  int publish = 1;//公布状态 默认是公布
	            	  //
	            	  
	            	  //会员类型
	            	  
	            	  int membertype =0;
	            	  if(condition==1)//说明是会员登录
	            	  {
	            		  membertype = Integer.parseInt(teasession.getParameter("membertype"));
	            	  }
	            	              	  
	            	  if(tobj.isExists())
	            	  {
	            		  tobj.set(tacname, condition, check_ip, ip, remarks, publish,membertype);
	            	  }else
	            	  {
	            		  tid =  Tactics.create(tacname, condition, check_ip, ip, remarks, teasession._rv.toString(), new Date(), publish, teasession._strCommunity, teasession._nNode,membertype);
		            	   
		            	   Tactics to = Tactics.find(tid);
		            	   to.set(teasession._rv.toString(), new Date());
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
								qc_timec = Tactics.sdf.parse(teasession.getParameter("qc_timec_"+i));
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
								qc_timed = Tactics.sdf.parse(teasession.getParameter("qc_timed_"+i));
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
								yd_timec = Tactics.sdf.parse(teasession.getParameter("yd_timec_"+i));
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
								yd_timed = Tactics.sdf.parse(teasession.getParameter("yd_timed_"+i));
							} catch (ParseException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
	            		  }
		            	  //结束相对
		            	  yd_2_timed=teasession.getParameter("yd_2_timed_"+i);//
		            	  
		            	  int ri = ReadRight.getRRid(teasession._nNode,tid, "Tactics",i);
		            	  
		            	  ReadRight rrobj = ReadRight.find(ri);
		            	  if(rrobj.isExists() )
		            	  {
		            		  rrobj.set(suoyou, banci, qici_fanwei, qc_timec, qc_2_timec, yuedu_yxqi, yd_timec, yd_2_timec, qc_timed, qc_2_timed, yd_timed, yd_2_timed,i,qici_suoyou,yd_sheweiyoujiu);
		            	  }else 
		            	  { 
		            		  ReadRight.create(suoyou, banci, qici_fanwei, qc_timec, qc_2_timec, yuedu_yxqi, yd_timec, yd_2_timec,teasession._nNode,tid, "Tactics", 
		            				  qc_timed, qc_2_timed, yd_timed, yd_2_timed,i,qici_suoyou,yd_sheweiyoujiu);
		            	  } 
  
	            	  }
	            	  
	            	     
	            	  
	            }else if("f_sub".equals(act))
	            {
	            	
	            	String chk_subidString [] = teasession.getParameterValues("checkbox_subid");
	            	boolean f = false;
	            	String onclick_act = teasession.getParameter("onclick_act");
	            	String next_str="";
	            	if(chk_subidString!=null)
	            	{
	            		for(int i = 0;i<chk_subidString.length;i++)
	            		{
	            			Tactics tobj_sub = Tactics.find(Integer.parseInt(chk_subidString[i]));
	            			if("delete".equals(onclick_act))//删除
	            			{
		            			if(tobj_sub.getPublish()==0)//只能删除未公布测
		            			{
		            				tobj_sub.delete();
		            			 ReadRight.delete(Integer.parseInt(chk_subidString[i]));
		            			}else {
		            				next_str ="抱歉!您删除的策略里面有公布的策略,\\n系统只能删除未公布的策略!";
									f = true;
								}
		            			
	            			}else if("publish".equals(onclick_act))//公布策略
	            			{
	            				if(tobj_sub.getPublish()==0)//未公布
		            			{
		            				tobj_sub.setPublish(1);
		            				tobj_sub.setMemberTime(teasession._rv.toString(), new Date());
		            				
		            			   
		            			}else {
		            				next_str ="抱歉!您公布的策略里面有【公布】的策略,\\n系统只能公布【未公布】的策略!";
									f = true;
								}
		            			
	            			}else if("nopublish".equals(onclick_act))
	            			{//取消公布策略
	            			
	            				if(tobj_sub.getPublish()==1)//公布 
		            			{
		            				tobj_sub.setPublish(0);
		            			   
		            			}else {
		            				next_str ="抱歉!您取消公布的策略里面有【未公布】的策略,\\n系统只能取消【公布】的策略!";
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
			response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("您添加的数据有问题，请确认后提交"));
		}
               
    }

    // Clean up resources
    public void destroy()
    {
    }
}
    