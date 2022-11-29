package tea.ui.yl.shop;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import tea.entity.Filex;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.member.Profile;
import tea.entity.weixin.WxUser;
import tea.entity.yl.shopnew.Invoice;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Date;

/**
 * 扫码签收
 * 
 * @author Guodh
 * 
 * */
public class ScanQRCodeInvoice extends HttpServlet{

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
		Filex.logs("yt_qianshou2.txt", "param:==============="+param);
		//获取微信openid
		String openid = h.getCook("openid","");
		if("".equals(openid)){
			response.sendRedirect("/mobjsp/yl/user/login_mobile.html?nexturl="+Http.enc("/ScanQRCode?"+param));
			return;
		}
		try {
			if(!"".equals(param) && null != param){
				String json = MT.dec(param);
				JSONObject obj = JSON.parseObject(json);
				String act = obj.getString("act");
				String invoiceid = obj.getString("invoiceid");
				//微信发送消息
				WxUser wu = WxUser.find(openid);
				String info = "无效命令";
				if("lzsign_invoice".equals(act)){
					info = this.invoice(openid,invoiceid,sn);
				}
				Filex.logs("yt_qianshou2.txt", "info:==============="+info);
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
	 * 发票扫码签收
	 * @param openid  微信ID
	 * @param invoiceid 发票ID
	 * @param sn 地址
	 * @return info
	 * @throws SQLException 
	 * */
	public String invoice(String openid,String invoiceid,String sn) throws SQLException{
		String info = "";
		boolean flag = Profile.flagopenid(openid);
		if(flag){
			//判断签收人
			//根据openid 查找其所在的医院 -发票签收
			int hospital = Profile.getHospitalByOpenId(openid,1);
			String member=Profile.getMemberByOpenId(openid);
			Profile profile=Profile.find(member);
			if(hospital > 0){
		    	//查找发票所属医院
				Invoice invoice=Invoice.find(Integer.parseInt(invoiceid));
		    	int invohospital=invoice.getHospitalid();
		    	
		    	//判断签收人和订单所属的医院是否相同
		    	if(hospital == invohospital){
		    		//签收成功
		    		if(invoice.getIssign() == 1){
		    			info += "该发票单已签收过，谢谢！";
		    		}else{
		    			invoice.setIssign(1);				//签收
		    			invoice.setSignopenid(openid);      //签收人openid
		    			invoice.setSignmember(profile.profile);	//签收人
		    			invoice.setSigndate(new Date());	//签收时间
		    			invoice.set();
		    			
		    			info += "发票号："+invoice.getInvoiceno()+"\n金额："+invoice.getAmount();
		    			info += "\n您的发票签收成功，如有疑问，请与管理员联系-010-68533123";
		    		}
		    	}else{
		    		info += "发票签收人不匹配，请与管理员联系-010-68533123";	//签收人不匹配
		    	}
			}else{
				info += "您尚未成为签收人，请与管理员联系-010-68533123";
			}
		}else{
			//info += "<a href='"+sn+"/mobjsp/yl/user/login_wx.jsp?nexturl="+Http.enc("/ShopOrders.do?act=fpsign&orderid="+orderid)+"'>点击绑定用户</a>";
		}
			
	    return info;
	}
}
