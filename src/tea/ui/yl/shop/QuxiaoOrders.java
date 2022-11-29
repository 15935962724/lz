package tea.ui.yl.shop;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import tea.SeqShop;
import tea.db.DbAdapter;
import tea.entity.Database;
import tea.entity.Filex;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.member.Profile;
import tea.entity.member.SMSMessage;
import tea.entity.weixin.WxUser;
import tea.entity.yl.shop.*;
import tea.entity.yl.shopnew.BackInvoice;
import tea.entity.yl.shopnew.Invoice;
import tea.entity.yl.shopnew.InvoiceData;
import tea.entity.yl.shopnew.ReplyMoney;
import tea.entity.yl.shopnew.UrgedRecord;
import util.CommonUtils;

/**
 * 商品订单
 * */
public class QuxiaoOrders extends HttpServlet{

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request, response);
        String act = h.get("act"), nexturl = h.get("nexturl", "");
        CommonUtils utils = new CommonUtils();
        
        PrintWriter out = response.getWriter();
        if("checkprice".equals(act)){
        	try {
        		//根据用户id查询用户地址信息
	    		ShopOrderAddress soa = ShopOrderAddress.getObjByMember(h.member);
	    		int hospitalId=soa.getHospitalId();
	    		//获得购物车
        		String cartCookie = h.getCook("cart", "|");
    			String[] ps=cartCookie.split("[|]");
    			if(ps.length>0){
    				for(int i=1;i<ps.length;i++){
    					String cartP = ps[i];
    		    		String[] arr=cartP.split("&");
    		    		
    		    		int checkFlag = Integer.parseInt(arr[2]);
    		    		if(checkFlag==0)continue;
    		    		
    		    		//cartCookie=cartCookie.replace("|"+cartP+"|", "|");
    		    		
    		    		//判断product_id是否商品的id，如果不是则为套装id
    		    	    int product_id=Integer.parseInt(arr[0]);
    		    	    //获取每个商品的代理商开票价格
    		    	    
    		    	  
    		        	ShopProduct p=ShopProduct.find(product_id);
    		        	float price = 0.0f;
    		        	float agent_price_s = 0.0f; //代理商显示价
    		    		float agent_price = 0.0f;	//代理商开票价
    		        	Profile pf = Profile.find(h.member);
    		        	if(pf.membertype==2){//代理商价格
    				    	ShopPriceSet sps1 = ShopPriceSet.find(1,p.product,0);			//代理商显示价
    				    	agent_price_s = sps1.price;
    						ShopPriceSet sps = ShopPriceSet.find(hospitalId,p.product,0);	//代理商医院开票价
    						if(sps.price>0){
    							price=sps.price; //医院的开票价
    						}
    						if(sps.agentPrice >0){
    							agent_price = sps.agentPrice; //代理商开票价
    						}
    				    }
    		        	if(agent_price==0){
    		        		out.print(p.name[1]+" "+p.yucode);
    		        		return;
    		        	}
    		    	    
    				}
    				
    			}
    			ShopHospital hospital=ShopHospital.find(hospitalId);
	        	if(hospital.getIssign()==1){
	        		//判断有无未签收订单
	    			String sql=" and datediff(day,createdate,getdate())>20 and createdate > "+Database.cite(h.get("limitdate"))+" and status=3 and order_id in(select order_id from shoporderdispatch where a_hospital_id="+hospitalId+")";
	        		List<ShopOrder> lstorder=ShopOrder.find(sql, 0, Integer.MAX_VALUE);
	        		
	        		if(lstorder.size()>0){
	        			
	        			out.print("对不起！"+hospital.getName()+"，该医院20天前的订单还有未签收的，因此不能提交订单！如有疑问，请与管理员联系！");
	        			return;
	        		}
	        	}
	        	if(hospital.getIsstoporder()==1){
	        		out.print("对不起！"+hospital.getName()+"，该医院已被停止订货，因此不能提交订单！如有疑问，请与管理员联系！");
	        		return;
	        	}
    			
    			out.print("0");
				return;
			} catch (Exception e) {
				// TODO: handle exception
			}
			
			//h.setCook("cart",cartCookie,-1);
		
        	
        	
        }else if("checkpricewx".equals(act)){
        	try {
        		//根据用户id查询用户地址信息
	    		ShopOrderAddress soa = ShopOrderAddress.getObjByMember(h.member);
	    		int hospitalId=soa.getHospitalId();
	    		
	    		int product_id = h.getInt("product_id",0);
						
	    	    //获取每个商品的代理商开票价格
	    	    ShopProduct p=ShopProduct.find(product_id);
	        	float price = 0.0f;
	        	float agent_price_s = 0.0f; //代理商显示价
	    		float agent_price = 0.0f;	//代理商开票价
	        	Profile pf = Profile.find(h.member);
	        	if(pf.membertype==2){//代理商价格
			    	ShopPriceSet sps1 = ShopPriceSet.find(1,p.product,0);			//代理商显示价
			    	agent_price_s = sps1.price;
					ShopPriceSet sps = ShopPriceSet.find(hospitalId,p.product,0);	//代理商医院开票价
					if(sps.price>0){
						price=sps.price; //医院的开票价
					}
					if(sps.agentPrice >0){
						agent_price = sps.agentPrice; //代理商开票价
					}
			    }
	        	if(agent_price==0){
	        		out.print(p.name[1]+" "+p.yucode);
	        		return;
	        	}
	        	ShopHospital hospital=ShopHospital.find(hospitalId);
	        	if(hospital.getIssign()==1){
	        		//判断有无未签收订单
	    			String sql=" and datediff(day,createdate,getdate())>20 and createdate > "+Database.cite(h.get("limitdate"))+" and status=3 and order_id in(select order_id from shoporderdispatch where a_hospital_id="+hospitalId+")";
	        		List<ShopOrder> lstorder=ShopOrder.find(sql, 0, Integer.MAX_VALUE);
	        		
	        		if(lstorder.size()>0){
	        			
	        			
	        			out.print("对不起！"+hospital.getName()+"，该医院20天前的订单还有未签收的，因此不能提交订单！如有疑问，请与管理员联系！");
	        			return;
	        		}
	        	}
	        	
	        		out.print("0");
					return;
	        	
    		    
			} catch (Exception e) {
				// TODO: handle exception
			}
        }else if("checkorderissign".equals(act)){
        	ShopOrderAddress soa = ShopOrderAddress.getObjByMember(h.member);
    		int hospitalId=soa.getHospitalId();
    		String sql=" and datediff(day,createdate,getdate())>20 and createdate > "+Database.cite("2017-9-1")+" and status=3 and order_id in(select order_id from shoporderdispatch where a_hospital_id="+hospitalId+")";
    		List<ShopOrder> lstorder=ShopOrder.find(sql, 0, Integer.MAX_VALUE);
    		String orderidarr="";
    		if(lstorder.size()>0){
    			for(int i=0;i<lstorder.size();i++){
        			ShopOrder order=lstorder.get(i);
        			String orderid=order.getOrderId();
        			if(i==lstorder.size()-1){
        				orderidarr+=orderid;
        			}else{
        				orderidarr+=orderid+",";
        			}
        		}
    			ShopHospital hospital=ShopHospital.find(hospitalId);
    			out.print("对不起！"+hospital.getName()+"，该医院20天前的订单还有未签收的，因此不能提交订单！未签收订单号包括："+orderidarr+"。如有疑问，请与管理员联系！");
    		}else{
    			out.print("0");
    		}
    		return;
        }
        try {
	        out.println("<script>var mt=parent.mt;</script>");
	        String orderId = h.get("orderId");
	        if("quxiaoorder".equals(act)){
	        	//2017.12.25新加的取消订单
	        	Quxiaoorder order=Quxiaoorder.find(0);
	        	order.setOrderid(orderId);

	        	ShopOrder so = ShopOrder.findByOrderId(orderId);

	        	order.setStatus(0);
	        	order.setMember(h.member);
	        	order.setCreatedate(new Date());
	        	order.set();
	        	//给订单管理员发送短信
	        	ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+so.getPuid(),0,1);
        		if(list.size() > 0){
	    			ShopSMSSetting sms = list.get(0);
	    			List<String> mobiles = ShopSMSSetting.getUserMobile(sms.qxckdd);
	    			if(!"".equals(MT.f(mobiles.toString())))
	    				SMSMessage.create("Home", Profile.find(h.member).getMember(), mobiles.toString(), h.language, "上海出库管理员申请“"+orderId+"”取消订单，请审核。");
        		}
	        	
	        }else if("yesqx".equals(act)){
	        	//订单管理员确认取消订单
	        	Quxiaoorder qxorder=Quxiaoorder.findByOrderId(orderId);
	        	qxorder.set("status", "1");
	        	ShopOrder order=ShopOrder.findByOrderId(orderId);
	        	String date=MT.f(order.getCreateDate());
	        	order.set("status", "5");
				StockOperation.setStill(order.getId());//清楚占用库存
				List<ShopOrderDatasBatches> sblist = ShopOrderDatasBatches.find(" AND ordercode="+DbAdapter.cite(orderId),0,Integer.MAX_VALUE);
				for(int i=0;i<sblist.size();i++) {
					ShopOrderDatasBatches sod = sblist.get(i);
					StockOperation.setStillBat(sod.getSoid());//清楚占用库存
				}

	        	//给收货人和服务商发送短信
	        	ShopOrderDispatch dispatch=ShopOrderDispatch.findByOrderId(orderId);
	        	String hospitalm=dispatch.getA_mobile();//收货人电话
	        	String ahospital=dispatch.getA_hospital();//医院
	        	ShopOrderData data=ShopOrderData.find(" and order_id="+Database.cite(orderId), 0, 1).get(0);
	        	int num=data.getQuantity();//数量
	        	SMSMessage.create("Home", Profile.find(h.member).member, hospitalm, h.language, date+"的"+ahospital+"的"+num+"粒订单“"+orderId+"”已取消。");
	        	String mobile=Profile.find(order.getMember()).getMobile();
	        	SMSMessage.create("Home", Profile.find(h.member).member, mobile, h.language, date+"的"+ahospital+"的"+num+"粒订单“"+orderId+"”已取消。");
	        	
	        }else if("noqx".equals(act)){
	        	//拒绝取消订单
	        	String reason=h.get("reason");
	        	Quxiaoorder qxorder=Quxiaoorder.findByOrderId(orderId);
	        	qxorder.set("status", "2");
	        	qxorder.set("reason",reason);
	        	
	        }
	        out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
        } catch (Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
        
	}
	
	
}
