package tea.ui.site;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.db.DbAdapter;
import tea.entity.site.*;
import tea.entity.westrac.WestracIntegralLog;
import tea.ui.*;
import java.sql.SQLException;
import java.sql.Date.*;
import tea.entity.integral.*;
import tea.entity.member.Profile;
import tea.entity.member.SMSMessage;
import tea.entity.csvclub.*;

public class EditIntegralManage extends TeaServlet 
{

    public void init() throws ServletException
    {
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        TeaSession teasession = new TeaSession(request);
        java.io.PrintWriter out = response.getWriter();
        if (teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(request.getHeader("referer"), "UTF-8"));
            return;
        }
        try
        {
 
            String act = teasession.getParameter("act");
            String community = teasession._strCommunity;
            String member = teasession._rv.toString(); //
            String nexturl = teasession.getParameter("nexturl");

            Communityintegral commint = Communityintegral.find(teasession._strCommunity);
            boolean falg = commint.isExists();

            if ("manage".equals(act)) //积分管理
            {
                int logintime = 0; //登录次数
                int loginlimit = 0; //登录次数的限制
                int loginintegral = 0; //登录的积分
                int pink_A = 0; //精华
                int pink_B = 0;
                int qu_low = 0; //问答中心，低
                int qu_high = 0;
                int qu_answer = 0;

                String integraltimes = null; //修改时间
                if (teasession.getParameter("logintime") != null && teasession.getParameter("logintime").length() > 0)
                {
                    logintime = Integer.parseInt(teasession.getParameter("logintime"));
                }
                if (teasession.getParameter("loginlimit") != null && teasession.getParameter("loginlimit").length() > 0)
                {
                    loginlimit = Integer.parseInt(teasession.getParameter("loginlimit"));
                }
                if (teasession.getParameter("loginintegral") != null && teasession.getParameter("loginintegral").length() > 0)
                {
                    loginintegral = Integer.parseInt(teasession.getParameter("loginintegral"));
                }
                if (teasession.getParameter("pink_A") != null && teasession.getParameter("pink_A").length() > 0)
                {
                    pink_A = Integer.parseInt(teasession.getParameter("pink_A"));
                }
                if (teasession.getParameter("pink_B") != null && teasession.getParameter("pink_B").length() > 0)
                {
                    pink_B = Integer.parseInt(teasession.getParameter("pink_B"));
                }
                if (teasession.getParameter("qu_low") != null && teasession.getParameter("qu_low").length() > 0)
                {
                    qu_low = Integer.parseInt(teasession.getParameter("qu_low"));
                }
                if (teasession.getParameter("qu_high") != null && teasession.getParameter("qu_high").length() > 0)
                {
                    qu_high = Integer.parseInt(teasession.getParameter("qu_high"));
                }
                if (teasession.getParameter("qu_answer") != null && teasession.getParameter("qu_answer").length() > 0)
                {
                    qu_answer = Integer.parseInt(teasession.getParameter("qu_answer"));
                }

                Date datetime = new Date();

                if (falg)
                {
                    Communityintegral.set(community, member, logintime, loginlimit, loginintegral, pink_A, pink_B, qu_low, qu_high, qu_answer, datetime);
                } else
                {
                    Communityintegral.create(community, member, logintime, loginlimit, loginintegral, pink_A, pink_B, qu_low, qu_high, qu_answer, datetime);
                }

                response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("提交信息成功！", "UTF-8") + "&nexturl=/jsp/integral/IntegralManage.jsp");
                return;
            } else if ("integralchangeadd".equals(act)) //商品兑换审核
            {
            	
            	 int icid = 0;
                 if (teasession.getParameter("icid") != null && teasession.getParameter("icid").length() > 0)
                 {
                 	icid = Integer.parseInt(teasession.getParameter("icid"));
                 }
            	
                String applymember = teasession.getParameter("member");
                String str_applyintegral = teasession.getParameter("applyintegral");
                String present = teasession.getParameter("present");
                
               
                String phone = teasession.getParameter("phone");
                String address = teasession.getParameter("address");
                String consignee = teasession.getParameter("consignee");
                
                	// 审核通过
                String str = "您的订单审核成功";
              if(icid>0)
              {
            	  IntegralChange icobj = IntegralChange.find(icid);
            	 
            	  String goodsname = "";
            	  String gn = "";
            	  for(int i=1;i<icobj.getPresent().split("/").length;i++)
            	  {
            		  IntegralPrize ipobj = IntegralPrize.find(Integer.parseInt(icobj.getPresent().split("/")[i]));
            		  goodsname = goodsname+ipobj.getShopping()+"  ";
            		  gn = gn +"商品："+ipobj.getShopping()+"  所耗积分："+ipobj.getShop_integral()+"  剩余积分："+Profile.find(ipobj.getMember()).getMyintegral();
            	  } 
            	  
            	  int statics = 0;
            	  if(teasession.getParameter("statics")!=null && teasession.getParameter("statics").length()>0)
            	  {
            		  statics = Integer.parseInt(teasession.getParameter("statics"));
            	  }
            	  
            	
            	  
            	  if(statics==1)//要审核状态 修改成发货
            	  { 
            		  statics = 2;
            		  icobj.updates(new Date(), teasession._rv.toString());
            		  //审核以后 就可以 减分
            		  Profile p = Profile.find(applymember);
            		
            		    p.setMyintegral(p.getMyintegral()-(float)icobj.getApplyintegral());
            		    WestracIntegralLog.create(applymember,11,null,0,0,null,new Date(),-(float)icobj.getApplyintegral(),teasession._strCommunity);
            		    //审核通过 发送短信
            		  //发送短信
     					String c = "您的礼品兑换申请已通过，详情（"+gn+"）请等待我们发货"; 
     					SMSMessage.create(teasession._strCommunity,applymember,p.getMobile(),teasession._nLanguage,c);
            		    
            		   
            		  
            	  }else if(icobj.getStatics()==2)
            	  {
            		  statics = 3;
            		  str ="订单发货处理完成";
            		  icobj.updatef(new Date(), teasession._rv.toString());
            		  //发货通过
            		  //发送短信
     					String c = "您的兑换的"+goodsname+"商品，已发货，请查收。";
     					SMSMessage.create(teasession._strCommunity,applymember,Profile.find(applymember).getMobile(),teasession._nLanguage,c);
            	  }else if(icobj.getStatics()==3)
            	  {
            		  statics = 4;
            		  str ="兑换商品收货确认完成";
            		  icobj.updateq(new Date(), teasession._rv.toString());
            		//发送短信
	   					String c = "您的兑换的"+goodsname+"商品，已收货，谢谢使用！";
	   					SMSMessage.create(teasession._strCommunity,applymember,Profile.find(applymember).getMobile(),teasession._nLanguage,c);
            	  }else if(statics==5)
            	  {  
            		  icobj.updates(new Date(), teasession._rv.toString());
            		  //审核不成功
            		  //发送短信
   					String c = "您的商品兑换申请未通过，请修改信息重新提交";
   					SMSMessage.create(teasession._strCommunity,applymember,Profile.find(applymember).getMobile(),teasession._nLanguage,c);
            	  }
            	  if(statics==0)
            	  {
            		  statics = 1;
            		  
            	  }
            	 
            	  String pro = teasession.getParameter("city1");
            	  String zip = teasession.getParameter("zip");
            	  
            	  icobj.set(community, applymember,  present, 
            			  icobj.getApplydate(), icobj.getApplyintegral(), statics, null, phone, address, consignee, icobj.getOrderid(),pro,zip);
             
            	  
            	  
              
              
              } 
             
              out.print("<script  language='javascript'>alert('"+str+"');window.location.href='"+nexturl+"';</script> ");
                    //IntegralChange.set(id, "", community, applymember, shopping.toString(), datetime, datetime, applyintegral, 1, member);
               
                  //  IntegralChange.create("", community, applymember, shopping.toString(), datetime, datetime, applyintegral, 1, member);
              
              
              

            } else if ("integralprize".equals(act)) //添加商品
            {
                int id = 0;
                if (teasession.getParameter("id") != null && teasession.getParameter("id").length() > 0)
                {
                    id = Integer.parseInt(teasession.getParameter("id"));
                }
                String shopping = teasession.getParameter("shopping");
                int shop_integral = 0;
                if (teasession.getParameter("shop_integral") != null && teasession.getParameter("shop_integral").length() > 0)
                {
                    shop_integral = Integer.parseInt(teasession.getParameter("shop_integral"));
                }
                Date datetime = new Date();

                IntegralPrize obj = IntegralPrize.find(id);
                
                 String coding=teasession.getParameter("coding");//商品编码
                 String recomm=teasession.getParameter("recomm");//小编推荐
                 String text=teasession.getParameter("content");//奖品介绍
                 String explain=teasession.getParameter("explain");//使用说明
                 //显示位置
                 StringBuffer sp = new StringBuffer();
                 
                 if(teasession.getParameter("statustype")!=null && teasession.getParameter("statustype").length()>0)
                 {
                	 String value []  = teasession.getParameterValues("statustype");
                	 for(int i=0;i<value.length;i++)
                	 {
                		 sp.append("/").append(value[i]);
                	 }
                	 sp.append("/");
                 }
                 
                 
                
  
                 String spic = teasession.getParameter("spic");
                 if(teasession.getParameter("spiccheck") != null && teasession.getParameter("spiccheck").length() > 0)
                 {
                     spic = "";
                 } else if(spic != null && spic.length() > 0)
                 {} else
                 {
                     spic = obj.getSpic();
                 }
                 
                 String dpic = teasession.getParameter("dpic");
                 if(teasession.getParameter("dpiccheck") != null && teasession.getParameter("dpiccheck").length() > 0)
                 {
                     dpic = "";
                 } else if(dpic != null && dpic.length() > 0)
                 {} else
                 {
                     dpic = obj.getDpic();
                 }
                 
                 String rpic = teasession.getParameter("rpic");
                 if(teasession.getParameter("rpiccheck") != null && teasession.getParameter("rpiccheck").length() > 0)
                 {
                	 rpic = "";
                 } else if(rpic != null && rpic.length() > 0)
                 {} else
                 { 
                	 rpic = obj.getRpic();
                 }
                  
                 
                 
                if (obj.isExists()) //修改  
                {
                	obj.set(id, community, member, datetime, shopping, shop_integral,coding,recomm,text,explain,spic,dpic,rpic);
                	obj.setStatustype(sp.toString());
                    
                } else
                {
                    IntegralPrize.create(community, member, datetime, shopping, shop_integral,coding,recomm,text,explain,spic,
                    		dpic,rpic,sp.toString());
                  
                }
                response.sendRedirect("/jsp/integral/IntegralPrize.jsp");
                return;
            } else if ("integralupdate".equals(act))//手工修改添加 减少积分
            {
                String user = teasession.getParameter("user");
                int add_int = 0; //加
                if (teasession.getParameter("add_int") != null && teasession.getParameter("add_int").length() > 0)
                {
                    add_int = Integer.parseInt(teasession.getParameter("add_int"));
                }
                int minus_int = 0; //减
                if (teasession.getParameter("minus_int") != null && teasession.getParameter("minus_int").length() > 0)
                {
                    minus_int = Integer.parseInt(teasession.getParameter("minus_int"));
                }
                String remarks = null; //内容
                if(teasession.getParameter("remarks")!=null && teasession.getParameter("remarks").length()>0)
                {
                    remarks = teasession.getParameter("remarks");
                }
                Date updatetimes = new Date(); //提交时间
                int id = 0;
                if (teasession.getParameter("id") != null && teasession.getParameter("id").length() > 0)
                {
                    id = Integer.parseInt(teasession.getParameter("id"));
                }
                if (id>0)
                {

                    IntegralUpdate.set(id, member, community, add_int, minus_int, remarks, updatetimes, user,1);
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("修改成功！", "UTF-8") + "&nexturl=/jsp/integral/Integralhandwork.jsp");
                    return;

                } else 
                {
                    IntegralUpdate.create(member, community, add_int, minus_int, remarks, updatetimes, user,1);
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("提交成功！", "UTF-8") + "&nexturl=/jsp/integral/Integralhandwork.jsp");
                    return;
                }

            }
        } catch (SQLException ex)
        {
            ex.printStackTrace();
        }finally
        {
        	 out.close();
        }
    }
    //Clean up resources
    public void destroy()
    {
    }
}
