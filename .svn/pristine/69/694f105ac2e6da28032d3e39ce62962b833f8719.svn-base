package tea.ui.yl.shop;

import java.io.*;
import java.util.*;
import tea.entity.*;
import tea.entity.yl.shop.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class ShopCategorys extends HttpServlet
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
            if ("ajax".equals(act))
            {
                String type = h.get("type");
                StringBuilder sb = new StringBuilder();
                Iterator it = ShopCategory.findByFather(h.getInt("father")).iterator();
                while (it.hasNext())
                {
                    ShopCategory c = (ShopCategory) it.next();
                    if ("js".equals(type))
                        sb.append("op[op.length]=new Option('" + MT.f(c.name[1]) + "'," + c.category + ");");
                    else
                        sb.append(",[id:" + c.category + ",name:'" + MT.f(c.name[1]) + "']");
                }
                out.print(sb.toString());
                return;
            }
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            if (h.member < 1)
            {
                out.println("<script>mt.show('您还没有登陆或登陆已超时！请重新登陆',2,'/my/Login.jsp');</script>");
                return;
            }
            int category = h.getInt("category");
            if ("edit".equals(act))
            {
                ShopCategory t = ShopCategory.find(category);
                t.father = h.getInt("father");
                t.name[0] = h.get("name0");
                t.name[1] = h.get("name1");
                t.price = h.getInt("price");
                t.pcolor = h.getBool("pcolor");
                t.psize = h.getBool("psize");
                t.hidden = h.getBool("hidden");
                t.pic = h.getInt("pic.attch");
                if (t.category < 1)
                    t.time = new Date();
                t.set();
            } else if ("setAttribute".equals(act))
            {
            	ShopCategory t = ShopCategory.find(category);
            	String attribute = MT.f(h.get("attribute"));
            	if(attribute==null||attribute.length()<1){
            		List<ShopProductModel> spmlist = ShopProductModel.find(" AND category="+category,0,100);
            		if(spmlist!=null&&spmlist.size()>0){
            			out.print("<script>parent.mt.show('抱歉，当规格/型号中数据不为空时，属性名称不能为空！',1,'" + nexturl + "');</script>");
            			return;
            		}
            			
            	}
            	t.set("attribute",attribute);
            }else if ("del".equals(act))
            {
                String[] arr = category > 0 ? new String[]
                               {String.valueOf(category)}
                               : h.getValues("categorys");
                for (int i = 0; i < arr.length; i++)
                {
                    ShopCategory t = new ShopCategory(Integer.parseInt(arr[i]));
                    t.delete();
                }
            } else if("shopswitch".equals(act))
            {
            	ShopCategory t = ShopCategory.find(category);
            	t.set("offswitch",String.valueOf(t.offswitch?0:1));//true为关闭
            }else if ("sequence".equals(act))
            {
                int sequence = h.getInt("sequence");
                if (sequence > 0)
                {
                    ShopCategory.find(h.getInt("category")).set("sequence", String.valueOf(sequence));
                } else
                {
                    int pos = h.getInt("pos");
                    String[] arr = h.get("categorys").split("[|]");
                    for (int i = 1; i < arr.length; i++)
                    {
                        ShopCategory t = new ShopCategory(Integer.parseInt(arr[i]));
                        t.set("sequence", String.valueOf(i + pos));
                    }
                    return;
                }
            } else
            ///jsp/yl/shop/ShopCategoryBrand.jsp
            if ("brandadd".equals(act))
            {
                ShopCategory t = ShopCategory.find(category);
                String[] arr = h.get("brand").split("[|]");
                for (int i = 1; i < arr.length; i++)
                {
                    if (t.brand.indexOf("|" + arr[i] + "|") != -1)
                        continue;
                    t.brand += arr[i] + "|";
                }
                t.set("brand", t.brand);
            } else if ("branddel".equals(act))
            {
                ShopCategory t = ShopCategory.find(category);
                String[] arr = h.getValues("brands");
                for (int i = 0; i < arr.length; i++)
                {
                    t.brand = t.brand.replaceAll("\\|" + arr[i] + "\\|", "|");
                }
                t.set("brand", t.brand);
            }
            out.print("<script>parent.mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
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
