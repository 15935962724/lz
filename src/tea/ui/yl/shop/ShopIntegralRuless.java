package tea.ui.yl.shop;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.entity.Http;
import tea.entity.yl.shop.ShopIntegralRules;

/**
 * 积分规则
 * */
public class ShopIntegralRuless extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		resp.setContentType("text/html; charset=UTF-8");
        Http h = new Http(req, resp);
        String act = h.get("act"), nexturl = h.get("nexturl", "");
		PrintWriter out = resp.getWriter();
		
		try {
			out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
			int id = h.getInt("id");
			if("edit".equals(act)){
				ShopIntegralRules sh = ShopIntegralRules.find(id);
				sh.setIntegral(h.getInt("integral"));
				
				sh.set();
			}else if("alledit".equals(act)){
				int jf0 = h.getInt("integral0");
				int jf1 = h.getInt("integral1");
				int jf2 = h.getInt("integral2");
				ShopIntegralRules sir = ShopIntegralRules.findByItem(0);
				sir.setIntegral(jf0);
				sir.set();
				sir = ShopIntegralRules.findByItem(1);
				sir.setIntegral(jf1);
				sir.set();
				sir = ShopIntegralRules.findByItem(2);
				sir.setIntegral(jf2);
				sir.set();
			}
			out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			out.close();
		}
	}

	
}
