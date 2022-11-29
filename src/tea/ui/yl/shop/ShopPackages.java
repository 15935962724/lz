package tea.ui.yl.shop;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import tea.entity.Http;
import tea.entity.MT;
import tea.entity.yl.shop.ShopPackage;
import tea.entity.yl.shop.ShopPrice;
import tea.entity.yl.shop.ShopQualification;

/**
 * Servlet implementation class ShopQualifications
 */
public class ShopPackages extends HttpServlet {

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request, response);
        String act = h.get("act"), nexturl = h.get("nexturl", "");
        ServletContext application = this.getServletContext();
        HttpSession session = request.getSession(true);
        PrintWriter out = response.getWriter();
        try
        {
        	if("edit".equals(act)){
        		out.println("<script src='/tea/mt.js'></script>");
        	}else{
        		out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
        	}
            if ("edit".equals(act))
            {
            	int sid = h.getInt("sid");
            	String packagename = h.get("packagename");
            	int productid = h.getInt("productid");
            	float price = h.getFloat("price");
            	float setprice = h.getFloat("setprice");
            	String [] pros = h.getValues("myproduct");
            	if(pros==null){
            		out.print("<script>mt.show('请选择副商品！');</script>");
            		return;
            	}
            	String pstr  = "|";
            	for(int i=0;i<pros.length;i++){
            		pstr += pros[i]+"|";
            	}
            	ShopPackage sp = ShopPackage.find(sid);
            	sp.setPrice(price);
            	sp.setSetPrice(setprice);
            	sp.setProduct_id(productid);
            	sp.setProduct_link_id(pstr);
            	sp.setPackageName(packagename);
            	sp.set();
            }else if("del".equals(act)){
            	int pid = h.getInt("pid");
            	ShopPackage sp = ShopPackage.find(pid);
            	sp.delete();
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
