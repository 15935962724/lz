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

import sun.misc.BASE64Decoder;
import tea.entity.Attch;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.Seq;
import tea.entity.member.Profile;
import tea.entity.member.SMSMessage;
import tea.entity.yl.shop.ShopNvoice;
import tea.entity.yl.shop.ShopOrder;
import tea.entity.yl.shop.ShopOrderAddress;
import tea.entity.yl.shop.ShopOrderDispatch;
import tea.entity.yl.shop.ShopSMSSetting;
import util.CommonUtils;

/**
 * 提交订单
 * */
public class ShopOrderForms extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		resp.setContentType("text/html; charset=UTF-8");
        Http h = new Http(req, resp);
        String act = h.get("act"), nexturl = h.get("nexturl", "");
		PrintWriter out = resp.getWriter();
		//out.println("<script src=\"/tea/mt.js\" type=\"text/javascript\"></script>");
		//out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
		CommonUtils utils = new CommonUtils();
		try {
			if (act.equals("ajaxbitmap")) { // 压缩图片
				String ext = "png";
				String name = "";
				int imgsize = 0;
				String savepath = "/res/Home/yl/";
				try {
					int id = Seq.get();
					String realPath = this.getServletConfig().getServletContext().getRealPath("/");

					String filePath = realPath + savepath;
					String fileData = req.getParameter("base64String"); // Base64
					String newFileName = id + "." + ext;
					File f = new File(filePath, newFileName);
					if(!f.exists()){
						f.createNewFile();
					}else{
						throw new Exception("already exists");
					}
					// 使用BASE64对图片文件数据进行解码操作
					BASE64Decoder decoder = new BASE64Decoder();
					// 通过Base64解密，将图片数据解密成字节数组
					fileData = fileData.substring(fileData.indexOf(",") + 1);
					byte[] bytes = decoder.decodeBuffer(fileData);
					// 构造字节数组输入流
					ByteArrayInputStream bais = new ByteArrayInputStream(bytes);
					// 读取输入流的数据
					BufferedImage bi = ImageIO.read(bais);
					// 将数据信息写进图片文件中
					ImageIO.write(bi, "jpg", f);// 不管输出什么格式图片，此处不需改动
					bais.close();
					name = id + "";
					Attch a = new Attch(id);
					a.node = 14050050;
					a.name = name + "." + ext;
					a.path = savepath + name + "." + ext;
					a.type = ext;
					a.length = imgsize;
					a.community = "Home";
					a.set();
					out.print(a.attch + "%" + a.path);
				} catch (Exception es) {
					es.printStackTrace();
					out.print("");
				}
				return;
			}
			if("orderAddress".equals(act)){
				insertAddress(h);
				resp.sendRedirect(nexturl);
				return;
			}else if("nvoice".equals(act)){
				insertNvoice(h);
				ShopOrder so = ShopOrder.findByOrderId(h.get("orderid"));
				so.setAskInvoiceDate(new Date());
				so.set();
				Profile profile = Profile.find(so.getMember());
				//订单附加
        		ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(so.getOrderId());
        		//获取短信内容
        		String content = utils.getSms_content("syfp");
    			content = utils.replace(content, profile.getMember(), so.getOrderId(), "", "",sod.getN_company(),sod.getN_consignees(),"");
    			
    			String user = Profile.find(h.member).getMember();
    			
				ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+so.getPuid(),0,1);
        		if(list.size() > 0){
	    			ShopSMSSetting sms = list.get(0);
	    			List<String> mobiles = ShopSMSSetting.getUserMobile(sms.syfp);
	    			if(!"".equals(MT.f(mobiles.toString())))
	    				SMSMessage.create("Home", user, mobiles.toString(), h.language, content);
        		}
        		if(!"".equals(MT.f(profile.mobile,"")))
    				SMSMessage.create("Home", user, profile.mobile, h.language, content);
        		
        		out.print("<script>parent.parent.mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
        		return;
			}
			out.print("<script>parent.mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			out.close();
		}
	}

	/**
	 * 收货人信息
	 * @throws SQLException 
	 * */
	private void insertAddress(Http h) throws SQLException{
		ShopOrderAddress soa = ShopOrderAddress.getObjByMember(h.member);
		soa.setId(h.getInt("id"));
		soa.setConsignees(h.get("consignees"));
		soa.setConsignees_id(h.getInt("consignees_id"));
		soa.setAddress(h.get("address"));
		soa.setMobile(h.get("mobile"));
		soa.setTelphone(h.get("telphone"));
		soa.setMember(h.member);
		soa.setCity(h.getInt("city2"));
		soa.setDepartment(h.get("department"));
		soa.setHospitalId(h.getInt("hospital_id"));
		soa.setHospital(h.get("hospital"));
		soa.setZipcode(h.get("zipcode"));
		soa.setSor_id(h.getInt("sor_id"));
		soa.set();
		//收货人 -- 收货人改为后台设置，用户选择  此表废弃
//		ShopOrderRecipient sor = ShopOrderRecipient.find(h.getInt("sor_id"));
//		sor.setConsignees(h.get("consignees"));
//		sor.setMobile(h.get("mobile"));
//		sor.setTelphone(h.get("telphone"));
//		sor.setMember(h.member);
//		sor.set();
	}
	
	/**
	 * 发票
	 * @throws SQLException 
	 * */
	private void insertNvoice(Http h) throws SQLException{
		ShopNvoice sn = ShopNvoice.getObjByMember(h.member);
		sn.setTelphone(h.get("telphone"));
		sn.setAddress(h.get("address"));
		sn.setCompany(h.get("company"));
		sn.setConsignees(h.get("consignees"));
		sn.setMember(h.member);
		sn.setRemark(h.get("remark"));
		sn.set();
		ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(h.get("orderid"));
		sod.setN_address(h.get("address"));
		sod.setN_telphone(h.get("telphone"));
		sod.setN_company(h.get("company"));
		sod.setN_consignees(h.get("consignees"));
		sod.setN_remark(h.get("remark"));
		sod.set();
		ShopOrder so = ShopOrder.findByOrderId(h.get("orderid"));
		so.set("invoiceStatus","1");
		/*		sn.setMember(h.member);
		sn.setCompany(h.get("company"));
		sn.setOpenbank(h.get("openbank"));
		sn.setAccountNo(h.get("accountno"));
		sn.setTaxpayerId(h.get("taxpayerid"));
		sn.setTelphone(h.get("telphone"));
		sn.setZip(h.get("zip"));
		sn.setAddress(h.get("address"));
		sn.setType(h.getInt("type"));*/
		
	}
	/**
	 * 订单附加信息
	 * */
}
