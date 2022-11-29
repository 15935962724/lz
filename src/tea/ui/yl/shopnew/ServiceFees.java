package tea.ui.yl.shopnew;

import org.json.JSONObject;
import tea.entity.Http;
import tea.entity.Seq;
import tea.entity.member.Profile;
import tea.entity.yl.shop.*;
import tea.entity.yl.shopnew.Invoice;
import tea.entity.yl.shopnew.InvoiceData;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.*;

/**
 * 记录服务费发票匹配订单发票
 * */
public class ServiceFees extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		resp.setContentType("text/html; charset=UTF-8");
		Http h = new Http(req, resp);
		JSONObject jo = new JSONObject();
		String act = h.get("act"), nexturl = h.get("nexturl", "");
		PrintWriter out = resp.getWriter();

        // 保存记录
        if("save".equals(act)){

			try {
				int fid = h.getInt("fid");
				int zid = h.getInt("zid");
				int sid = h.getInt("sid");
				int puid = h.getInt("puid");			//　厂商id
				double money = h.getDouble("money");	// 发票总额
				int profile = h.getInt("profile");	// 服务商id
				String ids = h.get("ids");				// 发票id集合
				double total = h.getDouble("total");	// 订单服务费总额
				String oids = h.get("oids");			// 订单id集合
				int member = h.member;					// 操作人

				// 记录父表
				ServiceFeeRecord sf = ServiceFeeRecord.find(fid);
				sf.setProfile(profile);
				sf.setTotalMoney((float) money);
				String[] split = ids.split(",");
				ArrayList<Integer> list = new ArrayList<Integer>();
				for (String s : split) {
					int id = Integer.parseInt(s);
					list.add(id);

                }
				sf.setInvoiceArray(list);
				sf.setDescribe(""); // TODO 描述
				sf.setTime(new Date());
				sf.setMember(member);
				sf.setPuid(puid);

				sf.setOids(oids);

				// 修改已使用发票类型
				for (Integer id : list) {
					ServiceInvoice si = ServiceInvoice.find(id);
					si.setState(1); // 已使用
					si.set();
				}

				// 判断是否有发票结余
				if(money>total){
					double remain = money-total;
					// 剩余发票金额 新增记录
					ServiceInvoice s = ServiceInvoice.find(sid);
					s.setInvoiceCode("JY"+ Seq.get());
					s.setProfile(profile);
					s.setMoney((float) (remain+0.0f));
					s.setTime(new Date());
					s.setPuid(puid);
					s.setType(1);
					s.setState(0);
					s.set();

					// 结余发票id添加至记录表中
					list.add(s.getSid());

				}

				// 保存记录父表
				sf.set();

				// 给服务费发票添加fid
				for (Integer id : list) {
					ServiceInvoice s = ServiceInvoice.find(id);
					if(s.getState()==1 && s.getType()==1){

					}else {
						s.setFid(sf.getFid());
						s.set();
					}
				}


				int hospitalid = 0;
				// 记录子表
				Profile p = Profile.find(profile);
				String[] split1 = oids.split(",");
				for (String s : split1) {
					int id = Integer.parseInt(s);
					// 修改匹配发票状态
					Invoice invoice = Invoice.find(id);
					hospitalid = invoice.getHospitalid();
					invoice.setMateType(1);
					invoice.set();

					int phpuid = InvoiceData.getPuid(invoice.getId());

					//ProcurementUnitJoin puj = ProcurementUnitJoin.find(phpuid, invoice.getMember());
					ProcurementUnitJoin puj = ProcurementUnitJoin.find(phpuid, invoice.getMember(),hospitalid);
					// 添加子表记录
					ServiceFeeInfo sfi = ServiceFeeInfo.find(zid);
					sfi.setFid(sf.getFid());
					sfi.setOid(invoice.getId());//改为发票号
					sfi.setTax(puj.tax);


					Map<String, Double> imap = Invoice.getTaxAmount(puj.tax, id, 0.9844, 1.13);
					Double taxAmount = 0.0;
					Double chargeamountsum = 0.0;
					/*for (Map.Entry<String, Double> entry : map.entrySet()) {
						if(entry.getKey()=="taxamount"){
							taxAmount = entry.getValue();
						}
						if(entry.getKey()=="chargeamountsum"){
							chargeamountsum=entry.getValue();
						}
					}*/
					double mysum = imap.get("chargeamountsum")+imap.get("taxamount");
					BigDecimal b2=new BigDecimal(mysum);
					double taxamount2=b2.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
					sfi.setMoney((float) (taxamount2+0.0F));
					//sfi.setTaxMoney((float) (taxAmount+0.0F));
					sfi.set();
				}

				jo.put("type", "0");
			} catch (SQLException e) {
				e.printStackTrace();
				jo.put("type", "2");
				jo.put("mes", "系统异常，请重试！");
			}
			out.print(jo.toString());
			return;
		}
		

	}


	
}
