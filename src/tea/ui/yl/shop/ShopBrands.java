package tea.ui.yl.shop;

import java.io.*;
import java.util.*;
import tea.entity.*;
import tea.entity.yl.shop.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class ShopBrands extends HttpServlet
{
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
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            int brand = h.getInt("brand");
            if ("edit".equals(act))
            {
                ShopBrand t = ShopBrand.find(brand);
                int lang = h.getInt("lang");
                //String smallimg=h.get("smallimg");//缩略图
                //t.logo=smallimg;
                int logo = h.getInt("logo.attch");
                Attch attch = Attch.find(logo);
                if(logo>0) {
                	t.logo = attch.path;
                }
                t.name[lang] = h.get("name");
                t.content[lang] = h.get("content");
                if (brand < 1)
                {
                    t.sequence = (int) (System.currentTimeMillis() / 1000);
                    t.time = new Date();
                }
                t.set();
            } else if ("del".equals(act))
            {
                ShopBrand t = ShopBrand.find(brand);
                ShopCategory.delBrands(brand);
                t.delete();
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
