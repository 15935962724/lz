package tea.ui.yl.shop;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.db.DbAdapter;
import tea.entity.Filex;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.member.Profile;
import tea.entity.member.SMSMessage;
import tea.entity.yl.shop.ShopOrder;
import tea.entity.yl.shop.ShopOrderData;
import tea.entity.yl.shop.ShopOrderDispatch;
import tea.entity.yl.shop.ShopSMSSetting;
import util.CommonUtils;

/**
 * 产品规格/型号
 * */
public class ShopOrderDispatchs extends HttpServlet{

	private static final long serialVersionUID = 1L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request, response);
        String act = h.get("act"), nexturl = h.get("nexturl", "");
        PrintWriter out = response.getWriter();
        CommonUtils utils = new CommonUtils();
        try {
        	String info="操作执行成功！";
	        out.println("<script>var mt=parent.mt;</script>");
	        int dispatch = h.getInt("dispatch");
	        ShopOrderDispatch sod = ShopOrderDispatch.find(dispatch);
	        if("invoiceStatus".equals(act)){
		        sod.setN_invoiceNo(h.get("n_invoiceNo"));
		        sod.setN_expressNo(h.get("n_expressNo"));
		        sod.setN_invoiceTime(h.getDate("n_invoiceTime"));
		        Filex.logs("ytnotfp.txt", "发票号====="+h.get("n_invoiceNo")+"---"+h.get("n_expressNo")+"---"+h.getDate("n_invoiceTime"));
		        sod.set();
		        ShopOrder so = ShopOrder.findByOrderId(sod.getOrder_id());
		        so.set("invoiceStatus", h.get("invoiceStatus"));
		        
		        if("3".equals(h.get("invoiceStatus"))){
		        	Profile pro = Profile.find(so.getMember());
		        	
		        	String user = Profile.find(h.member).getMember();
		        	//订单附加表
	        		ShopOrderDispatch sodis = ShopOrderDispatch.findByOrderId(so.getOrderId());
	        		
		        	//获取短信内容
	        		String content = utils.getSms_content("fpjc");
	    			content = utils.replace(content, "", so.getOrderId(), h.get("n_expressNo"), "",sod.getN_company(),sod.getN_consignees(),"");
	    			Filex.logs("ytnotfp.txt", "短信内容===="+content);
	    			if(!"".equals(MT.f(pro.mobile,"")))
	    				SMSMessage.create(h.community, user, pro.mobile, h.language, content);
	    			
	    			ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+so.getPuid(),0,1);
	        		if(list.size() > 0){
		    			ShopSMSSetting sms = list.get(0);
		    			List<String> mobiles = ShopSMSSetting.getUserMobile(sms.fpjc);
		    			//if(!"".equals(MT.f(mobiles.toString())))
		    			if(mobiles.size()>0)
		    				SMSMessage.create(h.community, user, mobiles.toString(), h.language, content);
	        		}
	        		//三期新加内容
	        		List<ShopOrderData> lstdata=ShopOrderData.find(" and order_id="+DbAdapter.cite(so.getOrderId()), 0, Integer.MAX_VALUE);
	        		if(lstdata.size()>0){
	        			ShopOrderData data=lstdata.get(0);
	        			int quantity0=data.getQuantity();
	        			float amount0=data.getAgent_amount();
	        			so.set("noinvoicenum", String.valueOf(0));
		    			so.set("noinvoiceamount", String.valueOf(0));
		    			so.set("isinvoicenum", String.valueOf(quantity0));
		    			so.set("isinvoiceamount", String.valueOf(amount0));
	        		}
	        		
	        		
		        }
		        
	        }else if("submitInvoice".equals(act)){
	        	//取消开票
	        	//清除上次开票信息
	        	sod.setN_invoiceNo("");
		        sod.setN_expressNo("");
		        sod.setN_invoiceTime(null);
		        //17.12.7加
		        sod.setCaninvotime(new Date());
		        sod.setCaninvomember(h.member);
		        sod.set();
	        	ShopOrder so = ShopOrder.findByOrderId(sod.getOrder_id());
		        so.set("invoiceStatus", h.get("invoiceStatus"));
		        
		        
		        
	        }else if("wancheng".equals(act)){
	        	//完成开票
	        	ShopOrder so = ShopOrder.findByOrderId(sod.getOrder_id());
		        so.set("invoiceStatus", h.get("invoiceStatus"));
		        
		        //发送短信给服务商
	        	Profile pro = Profile.find(so.getMember());
	        	
	        	String user = Profile.find(h.member).getMember();
	        	
	        	//获取短信内容
        		String content = utils.getSms_content("fpjc");
    			content = utils.replace(content, "", so.getOrderId(), sod.getN_expressNo(), "",sod.getN_company(),sod.getN_consignees(),"");
    			Filex.logs("ytnotfp.txt", "短信内容===="+content);
    			
    			if(!"".equals(MT.f(pro.mobile,"")))
    				SMSMessage.create(h.community, user, pro.mobile, h.language, content);
    			
    			ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+so.getPuid(),0,1);
        		if(list.size() > 0){
	    			ShopSMSSetting sms = list.get(0);
	    			List<String> mobiles = ShopSMSSetting.getUserMobile(sms.fpjc);
	    			//if(!"".equals(MT.f(mobiles.toString())))
	    			if(mobiles.size()>0)
	    				SMSMessage.create(h.community, user, mobiles.toString(), h.language, content);
        		}
        		//三期新加内容
        		List<ShopOrderData> lstdata=ShopOrderData.find(" and order_id="+DbAdapter.cite(so.getOrderId()), 0, Integer.MAX_VALUE);
        		if(lstdata.size()>0){
        			ShopOrderData data=lstdata.get(0);
        			int quantity0=data.getQuantity();
        			float amount0=data.getAgent_amount();
        			so.set("noinvoicenum", String.valueOf(0));
	    			so.set("noinvoiceamount", String.valueOf(0));
	    			so.set("isinvoicenum", String.valueOf(quantity0));
	    			so.set("isinvoiceamount", String.valueOf(amount0));
        		}
        		
	        
	        }else if("invoice_edit".equals(act)){
	        	sod.setN_invoiceNoNew(h.get("n_invoiceNoNew"));
	        	sod.setN_invoiceTimeNew(new Date());
	        	sod.set();
	        }
	        out.print("<script>mt.show('"+info+"',1,'" + nexturl + "');</script>");
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
