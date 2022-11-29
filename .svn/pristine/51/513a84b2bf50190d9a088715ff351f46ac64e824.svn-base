package tea.ui.yl.shop;

import java.io.*;
import tea.entity.*;
import tea.entity.member.Profile;
import tea.entity.yl.shop.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class ShopPrices extends HttpServlet
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
            int price = h.getInt("price");
            if ("edit".equals(act))
            {
                String[] arr = h.getValues("area");
                int j = 0;
                ShopPrice t = ShopPrice.find(price);
                StringBuilder sb = new StringBuilder("|");
                for (int i = 0; i < arr.length; i++)
                {
                    if (arr[i].length() < 1)
                        continue;
                    sb.append(arr[i]).append("|");
                    j++;
                    t.maxi = Integer.parseInt(arr[i]);
                }
                if (j < 3)
                {
                    out.print("<script>mt.show('至少要填写三个价格！');</script>");
                    return;
                }
                t.area = sb.toString();
                t.set();
            } else if ("del".equals(act))
            {
                ShopPrice t = ShopPrice.find(price);
                t.delete();
            } else if ("productedit".equals(act))//商品价格设置
            {
            	int product = h.getInt("product");
            	int hospital = h.getInt("hospital");
            	int membertype = h.getInt("membertype");
            	float proprice = 0;
            	float agentPrice = 0;
            	float agentpricenew = 0;
            	if(hospital==0){
            		out.print("<script>mt.show('请选择医院/服务商！');</script>");
            		return;
            	}
            	/*if(membertype==-1){
            		out.print("<script>mt.show('请选择用户类型！');</script>");
            		return;
            	}*/
            	try {
            		proprice = h.getFloat("proprice");
            		agentPrice = h.getFloat("agentprice");
            		agentpricenew = h.getFloat("agentpricenew");
            	} catch (Exception e) {
            		out.print("<script>mt.show('请输入正确价格！');</script>");
            		return;
            	}
            	//String sql = " AND product_id = "+product+" AND hospital_id = "+hospital + " AND membertype ="+ membertype;
            	String sql = "  AND hospital_id = "+hospital + " AND product_id = "+product;
            	int hflag = ShopPriceSet.count(sql);
            	if(hflag>0){
            		out.print("<script>mt.show('该商品已经在这家医院/服务商设置过价格，可通过搜索“类型选择”进行查找！');</script>");
            		return;
            	}
            	ShopPriceSet ss = new ShopPriceSet();
            	ss.hospital_id = hospital;
            	ss.memberType = membertype;
            	ss.product_id = product;
            	ss.price = proprice;
            	ss.agentPrice = agentPrice;
            	ss.agentPriceNew = agentpricenew;
            	ss.set();
                /*ShopPrice t = ShopPrice.find(price);
                t.delete();*/
            }else if("productdelete".equals(act)){
            	int did = h.getInt("did");
            	/*ShopPriceSet ss = ShopPriceSet.find(did);
            	ss.delete();*/
            	String[] arr = did > 0 ? new String[]
                        {String.valueOf(did)}
                        : h.getValues("dids");
		         for (int i = 0; i < arr.length; i++)
		         {
		        	 ShopPriceSet t = new ShopPriceSet(Integer.parseInt(arr[i]));
		             t.delete();
		         }
            }else if("delone".equals(act)){
            	int did = h.getInt("did");
            	ShopPriceSet ss = ShopPriceSet.find(did);
            	ss.delete();
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
