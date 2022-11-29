package tea.ui.yl.shop;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.entity.*;
import tea.entity.yl.shop.*;
import tea.entity.member.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class ShopProductDatas extends HttpServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request, response);
        String act = h.get("act"), nexturl = h.get("nexturl", "");
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt,$=parent.$,doc=parent.document;</script>");
            if (h.member <1 )
            {
            	response.sendRedirect("/servlet/StartLogin?community="+h.community);
            	return;
            }
            if ("sequence".equals(act))
            {
                String[] arr = h.get("sids").split("[|]");
                for (int i = 1; i < arr.length; i++)
                {
                    ShopProduct_data sd = new ShopProduct_data(Integer.parseInt(arr[i]));
                    sd.set("sort", String.valueOf(i * 10));
                }
                return;
            }
            int sid = h.getInt("sid");
            if ("edit".equals(act))
            {
            	ShopProduct_data sd = ShopProduct_data.find(sid);
            	String title=h.get("title");
            	String content=h.get("content");
            	String brief=h.get("brief");
            	int logo=h.getInt("logo.attch");
            	int clear=h.getInt("clear");
            	int showtype=h.getInt("showtype");
            	int product_id=h.getInt("product_id");
            	int category=h.getInt("category");
            	int type=h.getInt("type");
            	if(clear>0||logo>0){
            		sd.logo=logo;
            	}
            	sd.showtype = showtype;
            	sd.category = category;
            	sd.product_id=product_id;
            	sd.title=title;
            	sd.content=content;
            	sd.brief=brief;
            	sd.type=type;
            	sd.hidden=1;
            	sd.set();
            	
            } else if ("del".equals(act))
            {
            	ShopProduct_data sd = ShopProduct_data.find(sid);
            	List<ShopProduct_data_list> spdl = ShopProduct_data_list.find(" AND data_id="+sd.id, 0, Integer.MAX_VALUE);
            	for(int i=0;i<spdl.size();i++){
            		ShopProduct_data_list spd = spdl.get(0);
            		spd.delete();
            	}
                sd.delete();
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
