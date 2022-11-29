package tea.ui.yl.shop;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import tea.entity.Filex;
import tea.entity.Http;
import tea.entity.yl.shop.ProcurementUnit;
import tea.entity.yl.shop.ShopHospital;
import tea.entity.yl.shop.ShopSMSSetting;

/**
 * 短信提醒设置
 * */
public class ShopSMSSettings extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		resp.setContentType("text/html; charset=UTF-8");
        Http h = new Http(req, resp);
        String act = h.get("act"), nexturl = h.get("nexturl", "");
		PrintWriter out = resp.getWriter();
		JSONObject jo = new JSONObject();

		
		try {
			out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
			int id = h.getInt("id");
			if("edit".equals(act)){
				int puid = h.getInt("puid");
				ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+puid,0,1);
				ShopSMSSetting smss = ShopSMSSetting.find(0);

				if(list.size()>0){
					smss = list.get(0);
				}

				//ShopSMSSetting smss = ShopSMSSetting.find(id);
				smss.tjdd = h.get("tjdd","|");
				smss.qrfh = h.get("qrfh","|");
				smss.ckwc = h.get("ckwc","|");
				smss.syfp = h.get("syfp","|");
				smss.fpjc = h.get("fpjc","|");
				smss.thsq = h.get("thsq","|");
				smss.thwc = h.get("thwc","|");
				smss.zhtx = h.get("zhtx","|");
				smss.qxckdd = h.get("qxckdd","|");
				smss.ckfh = h.get("ckfh", "|");
				smss.ckcs = h.get("ckcs","|");
				smss.ckjgtz = h.get("ckjgtz", "|");
				smss.sczjbg = h.get("sczjbg","|");
				smss.dck = h.get("dck", "|");
				smss.fpkj = h.get("fpkj","|");
				smss.hkds = h.get("hkds", "|");
				smss.hkshwc = h.get("hkshwc","|");
				smss.hkfpsh = h.get("hkfpsh","|");
				smss.fwfsh = h.get("fwfsh","|");
				smss.cwykp = h.get("cwykp","|");
				smss.puid = puid;
				if(puid==0){
					smss.setT();
				}else{
					smss.set();
				}
			}
			out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			out.close();
		}
		// 查询所有厂商短信设置列表

	}

	
}
