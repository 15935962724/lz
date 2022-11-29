package tea.ui.yl.shop;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.Http;
import tea.entity.yl.shop.ShopProductModel;

/**
 * 产品规格/型号
 * */
public class ShopProductModels extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		resp.setContentType("text/html; charset=UTF-8");
        Http h = new Http(req, resp);
        String act = h.get("act"), nexturl = h.get("nexturl", "");
        PrintWriter out = resp.getWriter();
        
        try {
	        out.println("<script>var mt=parent.mt;</script>");
	        int modelId = h.getInt("modelId");
	        
	        if("edit".equals(act)){
	        	ShopProductModel spm = ShopProductModel.find(modelId);
	        	spm.setCategory(h.getInt("category"));
	        	spm.setModel(h.get("model"));
	        	spm.set();				
	        }else if("del".equals(act)){
	        	String[] arr = modelId > 0 ? new String[] {String.valueOf(modelId)}: h.getValues("modelIds");
	        	for (int i = 0; i < arr.length; i++)
	        	{
	        		ShopProductModel.delete(Integer.parseInt(arr[i]));
	        	}
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
