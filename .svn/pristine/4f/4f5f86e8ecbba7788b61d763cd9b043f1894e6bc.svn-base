package tea.ui.yl.shop;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import tea.db.DbAdapter;
import tea.entity.Filex;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.member.ModifyRecord;
import tea.entity.member.Profile;
import tea.entity.weixin.WxUser;
import tea.entity.yl.shop.ShopOrder;
import tea.entity.yl.shop.ShopOrderData;
import tea.entity.yl.shop.ShopOrderDispatch;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 扫码签收
 * 
 * @author Guodh
 * 
 * */
public class ScanQRCode extends HttpServlet{

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		response.setContentType("text/html; charset=UTF-8");
		Http h = new Http(request, response);
		PrintWriter out = response.getWriter();
		//获取地址
		String sn = "http://" + request.getServerName();
		//请求参数
		String param = request.getQueryString();
		Filex.logs("yt_qianshou.txt", "param:==============="+param);
		//获取微信openid
		String openid = h.getCook("openid","");
		//测试19.9.2
		//String openid = h.getCook("openid","olZbajheiH6PNqRjutTJMVKN0B6Q1");
		//Filex.logs("yt_qianshou.txt", "OPENID======="+openid);
		if("".equals(openid)){
			response.sendRedirect("/mobjsp/yl/user/login_mobile.html?nexturl="+Http.enc("/ScanQRCode?"+param));
			return;
		}
		try {
			if(!"".equals(param) && null != param){
				String json = MT.dec(param);
				JSONObject obj = JSON.parseObject(json);
				String act = obj.getString("act");
				String orderid = obj.getString("orderid");
				//微信发送消息
				WxUser wu = WxUser.find(openid);
				String info = "无效命令";
				if("lzsign".equals(act)){
					info = this.lzsing(openid,orderid,sn);
				}else if("invoice".equals(act)){
					info = this.invoice(openid, orderid, sn);
				}
				Filex.logs("yt_qianshou.txt", "info:==============="+info);
				wu.send("text", info);
			}else{
				out.print("ERROR");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		//关闭 浏览器窗口
    	out.print("<script>document.addEventListener('WeixinJSBridgeReady',function(){WeixinJSBridge.call('closeWindow')});</script>");
    	return;
	}

	
	/**
	 * 粒子扫码签收
	 * @param openid  微信ID
	 * @param orderid 订单ID
	 * @param sn 地址
	 * @return info
	 * @throws SQLException 
	 * */
	private String lzsing(String openid,String orderid,String sn) throws SQLException{
		Filex.logs("yt_qianshou.txt", "openid:===================="+openid);
		Filex.logs("yt_qianshou.txt", "orderid:===================="+orderid);
		Filex.logs("yt_qianshou.txt", "sn:===================="+sn);
		String info = "";
		boolean flag = Profile.flagopenid(openid);
		if(flag){
			//判断签收人
			//根据openid 查找其所在的医院 -粒子签收
			//int hospital = Profile.getHospitalByOpenId(openid,0);
			String hospital = Profile.getHospitalByOpenId2(openid,0);//多个医院同一个签收人19.9.2
			Filex.logs("yt_qianshou.txt", "hospitalid="+hospital);
			//19.9.2修改
			if(hospital.length()>0){
				//查找订单所属医院
				ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(orderid);
				Filex.logs("yt_qianshou.txt", "hospitalid2="+sod.getA_hospital_id());
				//判断签收人和订单所属的医院是否相同
				if(hospital.indexOf(sod.getA_hospital_id()+"") >-1){
					//签收成功
					//2018.1.2小屈通知改为只能当前收货人签收自己的订单，即使同一个医院的也无法签收他人的订单。
					//2018.1.2开始
					String pmember=Profile.getMemberByOpenId(openid);
					Filex.logs("yt_qianshou.txt", "pmember:===================("+pmember);
					Filex.logs("yt_qianshou.txt", "pmember222:("+sod.getA_consignees());
					Filex.logs("yt_qianshou.txt", "isok?:===================("+pmember.equals(sod.getA_consignees()));
					pmember = pmember.replaceAll(" ", "");//去空格
					String sod_ac = sod.getA_consignees().replaceAll(" ", "");//去空格
					if(pmember.equals(sod_ac)){
						//2018.1.2结束
						ShopOrder soObj = ShopOrder.findByOrderId(orderid);
						Filex.logs("yt_qianshou.txt", "pmember:===================="+pmember+",consignees:"+sod.getA_consignees());
						Filex.logs("yt_qianshou.txt", "orderid2:===================="+orderid);
						Filex.logs("yt_qianshou.txt", "status:===================="+soObj.getStatus());
						if(soObj.getStatus() == 3){
							soObj.setStatus(4); 	//已完成（已签收）
							soObj.setReceiptTime(new Date());	//签收时间
							soObj.setSign_user_openid(openid);	//签收人openid
							soObj.set();
							ArrayList arrayList = Profile.find1(" AND  openid=" + DbAdapter.cite(openid), 0, 1);
							Profile p = (Profile)arrayList.get(0);
							ModifyRecord.creatModifyRecord(soObj.getOrderId(),"签收",p.profile,"订单已签收");
							info += "<a href='"+sn+"/jsp/yl/shop/ShopOrderDatasInfo.jsp?orderId="+orderid+"'>签收成功，点击查看详情！</a>";
						}else{
							info += "该订单已签收过，谢谢！";
						}
					}else{
						info += "签收人不匹配，请与管理员联系-010-68533123";	//签收人不匹配
					}

				}else{
					info += "签收人不匹配，请与管理员联系-010-68533123";	//签收人不匹配
				}
			}else{
				info += "您尚未成为签收人，请与管理员联系-010-68533123";
			}
		}else{
			info += "<a href='"+sn+"/mobjsp/yl/user/login_mobile.html?nexturl="+Http.enc("/ShopOrders.do?act=lzsign&orderid="+orderid)+"'>点击绑定用户</a>";
		}
			//19.9.2修改结束
			/*if(hospital > 0){
		    	//查找订单所属医院
		    	ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(orderid);
		    	Filex.logs("yt_qianshou.txt", "hospitalid2="+sod.getA_hospital_id());
		    	//判断签收人和订单所属的医院是否相同
		    	if(hospital == sod.getA_hospital_id()){
		    		//签收成功
		    		//2018.1.2小屈通知改为只能当前收货人签收自己的订单，即使同一个医院的也无法签收他人的订单。
		    		//2018.1.2开始
		    		String pmember=Profile.getMemberByOpenId(openid);
		    		if(pmember.equals(sod.getA_consignees())){
		    			//2018.1.2结束
			    		ShopOrder soObj = ShopOrder.findByOrderId(orderid);
			    		Filex.logs("yt_qianshou.txt", "pmember:===================="+pmember+",consignees:"+sod.getA_consignees());
			    		Filex.logs("yt_qianshou.txt", "orderid2:===================="+orderid);
			    		Filex.logs("yt_qianshou.txt", "status:===================="+soObj.getStatus());
			    		if(soObj.getStatus() == 3){
			        		soObj.setStatus(4); 	//已完成（已签收）
			        		soObj.setReceiptTime(new Date());	//签收时间
			        		soObj.setSign_user_openid(openid);	//签收人openid
			        		soObj.set();
			        		info += "<a href='"+sn+"/jsp/yl/shop/ShopOrderDatasInfo.jsp?orderId="+orderid+"'>签收成功，点击查看详情！</a>";
			    		}else{
			    			info += "该订单已签收过，谢谢！";
			    		}
		    		}else{
		    			info += "签收人不匹配，请与管理员联系-010-68533123";	//签收人不匹配
		    		}
		    		
		    	}else{
		    		info += "签收人不匹配，请与管理员联系-010-68533123";	//签收人不匹配
		    	}
			}else{
				info += "您尚未成为签收人，请与管理员联系-010-68533123";
			}
		}else{
			info += "<a href='"+sn+"/mobjsp/yl/user/login_wx.jsp?nexturl="+Http.enc("/ShopOrders.do?act=lzsign&orderid="+orderid)+"'>点击绑定用户</a>";
		}*/
		
	    return info;
	}
	
	/**
	 * 发票扫码签收
	 * @param openid  微信ID
	 * @param orderid 订单ID
	 * @param sn 地址
	 * @return info
	 * @throws SQLException 
	 * */
	public String invoice(String openid,String orderid,String sn) throws SQLException{
		String info = "";
		boolean flag = Profile.flagopenid(openid);
		if(flag){
			//判断签收人
			//根据openid 查找其所在的医院 -发票签收
			String hospital = Profile.getHospitalByOpenId2(openid,1);
			if(hospital.length() > 0){
				//查找订单所属医院
				ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(orderid);
				//判断签收人和订单所属的医院是否相同
				if(hospital.indexOf(sod.getA_hospital_id())>-1){
					//签收成功
					if(sod.getStatus() == 1){
						info += "该发票单已签收过，谢谢！";
					}else{
						sod.setStatus(1);					//签收
						sod.setSign_user_openid(openid);	//签收人
						sod.setSing_date(new Date());		//签收时间
						sod.set();
						//根据订单id查询订单详情信息
						StringBuffer sql=new StringBuffer();
						sql.append(" AND order_id="+DbAdapter.cite(orderid));
						List<ShopOrderData> sodList = ShopOrderData.find(sql.toString(),0,Integer.MAX_VALUE);
						ShopOrderData orderData = sodList.get(0);
						info += "订单号："+orderid+"\n发票号："+sod.getN_invoiceNo()+"\n金额："+orderData.getAmount();
						info += "\n您的发票签收成功，如有疑问，请与管理员联系-010-68533123";
					}
				}else{
					info += "发票签收人不匹配，请与管理员联系-010-68533123";	//签收人不匹配
				}
			}else{
				info += "您尚未成为签收人，请与管理员联系-010-68533123";
			}
		}else{
			info += "<a href='"+sn+"/mobjsp/yl/user/login_mobile.html?nexturl="+Http.enc("/ShopOrders.do?act=fpsign&orderid="+orderid)+"'>点击绑定用户</a>";
		}
			/*if(hospital > 0){
		    	//查找订单所属医院
		    	ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(orderid);
		    	//判断签收人和订单所属的医院是否相同
		    	if(hospital == sod.getA_hospital_id()){
		    		//签收成功
		    		if(sod.getStatus() == 1){
		    			info += "该发票单已签收过，谢谢！";
		    		}else{
		    			sod.setStatus(1);					//签收
		    			sod.setSign_user_openid(openid);	//签收人
		    			sod.setSing_date(new Date());		//签收时间
		    			sod.set();
		    			//根据订单id查询订单详情信息
		    			StringBuffer sql=new StringBuffer();
		    			sql.append(" AND order_id="+DbAdapter.cite(orderid));
		    			List<ShopOrderData> sodList = ShopOrderData.find(sql.toString(),0,Integer.MAX_VALUE);
		    			ShopOrderData orderData = sodList.get(0);
		    			info += "订单号："+orderid+"\n发票号："+sod.getN_invoiceNo()+"\n金额："+orderData.getAmount();
		    			info += "\n您的发票签收成功，如有疑问，请与管理员联系-010-68533123";
		    		}
		    	}else{
		    		info += "发票签收人不匹配，请与管理员联系-010-68533123";	//签收人不匹配
		    	}
			}else{
				info += "您尚未成为签收人，请与管理员联系-010-68533123";
			}
		}else{
			info += "<a href='"+sn+"/mobjsp/yl/user/login_wx.jsp?nexturl="+Http.enc("/ShopOrders.do?act=fpsign&orderid="+orderid)+"'>点击绑定用户</a>";
		}*/
			
	    return info;
	}
}
