package tea.ui.yl.shop;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import sun.misc.BASE64Decoder;
import tea.SeqShop;
import tea.db.DbAdapter;
import tea.entity.Attch;
import tea.entity.Database;
import tea.entity.Filex;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.Seq;
import tea.entity.member.ModifyRecord;
import tea.entity.member.Profile;
import tea.entity.member.SMSMessage;
import tea.entity.weixin.WxUser;
import tea.entity.yl.shop.Quxiaoorder;
import tea.entity.yl.shop.ShopCategory;
import tea.entity.yl.shop.ShopExchanged;
import tea.entity.yl.shop.ShopHospital;
import tea.entity.yl.shop.ShopMyPoints;
import tea.entity.yl.shop.ShopOrder;
import tea.entity.yl.shop.ShopOrderAddress;
import tea.entity.yl.shop.ShopOrderData;
import tea.entity.yl.shop.ShopOrderDispatch;
import tea.entity.yl.shop.ShopOrderExpress;
import tea.entity.yl.shop.ShopPackage;
import tea.entity.yl.shop.ShopPriceSet;
import tea.entity.yl.shop.ShopProduct;
import tea.entity.yl.shop.ShopQualification;
import tea.entity.yl.shop.ShopSMSSetting;
import tea.entity.yl.shopnew.BackInvoice;
import tea.entity.yl.shopnew.ChangeLiziData;
import tea.entity.yl.shopnew.Invoice;
import tea.entity.yl.shopnew.InvoiceData;
import tea.entity.yl.shopnew.ReplyMoney;
import tea.entity.yl.shopnew.UrgedRecord;
import util.CommonUtils;
import util.Config;

/**
 * 商品订单
 * */
public class ShenheChuku extends HttpServlet{

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request, response);
        String act = h.get("act"), nexturl = h.get("nexturl", "");
        CommonUtils utils = new CommonUtils();
        
        PrintWriter out = response.getWriter();
        try {
        	if("chuku".equals(act)){
	        	//出库
	        	String oid=h.get("orderId");
	        	ShopOrder order = ShopOrder.findByOrderId(oid);
	        	order.set("status","3");
	        	if(0==h.member){
	        		h.member=h.getInt("qywxMember");
				}
				ModifyRecord.creatModifyRecord(order.getOrderId(),"订单出库",h.member,"订单出库");
	        	//按照之前出库完成的通知
	    		//出厂信息
	    		ShopOrderExpress soe = ShopOrderExpress.findByOrderId(order.getOrderId());
	    		//订单附加
	    		ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(order.getOrderId());
	    		String querySql = " AND order_id="+DbAdapter.cite(order.getOrderId());
	    	  	List<ShopOrderData> sodList = ShopOrderData.find(querySql,0,Integer.MAX_VALUE);
	    	  	ShopOrderData odata = sodList.size() > 0 ?sodList.get(0):ShopOrderData.find(0);
	    		//获取短信内容
	    		String content = utils.getSms_content("ckwc");
				if(Config.getInt("gaoke")==order.getPuid()){
					content = utils.getSms_content("ckwcgaoke");
					content = content.replace("activity",odata.getActivity()+"");
				}

	    		content = utils.replace(content, "", order.getOrderId(), soe.express_code, "",sod.getA_hospital(),sod.getA_consignees(),odata.getQuantity()+"");
	    		String user = Profile.find(h.member).getMember();
	    		/*//出库
	    		ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+order.getPuid(),0,1);
	    		if(list.size() > 0){
	    			ShopSMSSetting sms = list.get(0);
	    			List<String> mobiles = ShopSMSSetting.getUserMobile(sms.ckwc);
	    			if(!"".equals(MT.f(mobiles.toString())))
	    				SMSMessage.create(h.community, user, mobiles.toString(), h.language, content);
	    		}*/

				ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+order.getPuid(),0,1);
				if(list.size() > 0){
					ShopSMSSetting sms = list.get(0);
					List<String> mobiles = ShopSMSSetting.getUserMobile(sms.ckwc);
					if(!"".equals(MT.f(mobiles.toString())))
						SMSMessage.create(h.community, user, mobiles.toString(), h.language, content);
				}

				//查看开票单位 是同辐
				int mypuid = ShopOrderData.findPuid(order.getOrderId());
				if(Config.getInt("tongfu")==order.getPuid()){
					list = ShopSMSSetting.find(" and puid="+mypuid,0,1);
					if(list.size() > 0){
						ShopSMSSetting sms = list.get(0);
						List<String> mobiles = ShopSMSSetting.getUserMobile(sms.ckwc);
						if(!"".equals(MT.f(mobiles.toString())))
							SMSMessage.create(h.community, user, mobiles.toString(), h.language, content);
					}
				}

	    		Profile pro = Profile.find(order.getMember());
	    		if(!"".equals(MT.f(pro.mobile,"")))
	    			SMSMessage.create(h.community, user, pro.mobile, h.language, content);
	    		
	    		//给收货人发送短信
	    		SMSMessage.create(h.community, user, sod.getA_mobile(), h.language, content);
	    		//增加数据分析中的，下单后未开票粒子数增加
	    		ChangeLiziData.addnoinvoice(sod.getA_hospital_id(), odata.getQuantity(), order.getCreateDate(), h.member, oid);
	    		
	    		
        	}
	        out.print("<script>parent.mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
       
        }catch (Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
        
        
	
	}
	
}
