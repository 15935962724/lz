package tea.ui.yl.shop;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.entity.Http;
import tea.entity.yl.shop.ShopProduct_data_list;

public class ShopProductDatalists extends HttpServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request, response);
        String act = h.get("act"), nexturl = h.get("nexturl", "");
        PrintWriter out = response.getWriter();
        try
        {
//        	上传视频时添加
//        	if ("upload".equals(act))
//            {
//            	int battch = h.getInt("file.attch");
//        		out.print(battch);
//        		return;
//            }
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
                    ShopProduct_data_list sd = new ShopProduct_data_list(Integer.parseInt(arr[i]));
                    sd.set("sort", String.valueOf(i * 10));
                }
                return;
            }
            int sid = h.getInt("sid");
            if ("edit".equals(act))
            {
            	ShopProduct_data_list sd = ShopProduct_data_list.find(sid);
            	String title=h.get("title");
            	String content=h.get("content");
            	String brief=h.get("brief");
            	int logo=h.getInt("logo.attch");
            	int attch=h.getInt("attch");
            	int logoclear=h.getInt("logoclear");
            	int attchclear=h.getInt("attchclear");
            	int data_id=h.getInt("data_id");
            	if(attchclear>0||attch>0){
            		sd.attch=attch;
            	}
            	if(logoclear>0||logo>0){
            		sd.logo=logo;
            	}
            	sd.data_id=data_id;
            	sd.title=title;
            	sd.content=content;
            	sd.brief=brief;
            	sd.set();
            	
            } else if ("del".equals(act))
            {
            	ShopProduct_data_list sd = ShopProduct_data_list.find(sid);
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
