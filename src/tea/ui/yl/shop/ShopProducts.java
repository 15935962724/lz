package tea.ui.yl.shop;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import tea.entity.Attch;
import tea.entity.Http;
import tea.entity.Img;
import tea.entity.yl.shop.AValue;
import tea.entity.yl.shop.ShopAttrib;
import tea.entity.yl.shop.ShopCategory;
import tea.entity.yl.shop.ShopProduct;

public class ShopProducts extends HttpServlet
{
    /* (non-Javadoc)
     * @see javax.servlet.http.HttpServlet#service(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
     */
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
        	//获取粒子类中的一个产品
        	if("getOneP".equals(act)){
            	ShopProduct sp = ShopProduct.find(0);
            	int classT = ShopCategory.getCategory("lzCategory");
            	ArrayList list = ShopProduct.find(" AND category=" + classT + " AND state=0  order by price asc ", 0, 1);
            	if(list.size()>0){
            		sp = (ShopProduct) list.get(0);
            	}
            	out.write(sp.product+"");
            	return ;
            }
            //最近浏览过的商品
            if ("history".equals(act))
            {
                int count = h.getInt("count") + 1;
                String ps = h.getCook("history", "|");
                out.print("$$('history').innerHTML=\"");
                out.print("<table class='history'>");
                if (ps.length() < 2)
                    out.print("<tr><td>暂无记录！");
                else
                {
                    String[] arr = ps.split("[|]");
                    for (int i = 1; i < count && i < arr.length; i++)
                    {
                        ShopProduct t = ShopProduct.find(Integer.parseInt(arr[i]));
                        out.print("<tr><td>" + t.getAnchor('t') + "</td><td>" + t.getAnchor(h.language) + "</td></tr>");
                    }
                }
                out.print("</table>\";");
                return;
            }
            int product = h.getInt("product");
            if ("upload".equals(act))
            {
                Attch a = Attch.find(h.getInt("Filedata.attch"));
                String dir = a.path.substring(0, a.path.lastIndexOf('/') + 1) + a.attch;
                File fu = new File(application.getRealPath(a.path));
                //大图
                File fs = new File(application.getRealPath(a.path = dir + "_s.jpg"));
                Img img = new Img(fu);
                img.width = img.height = 800;
                img.start(fs);
                fu.delete();
//                Site.find(1).mark(fs);
                //中图
                File fb = new File(application.getRealPath(a.path2 = dir + "_b.jpg"));
                img = new Img(fs);
                img.height = img.width = 350;
                img.start(fb);
                //小图
                File ft = new File(application.getRealPath(a.path3 = dir + "_t.jpg"));
                img = new Img(fb);
                img.height = img.width = 52;
                img.start(ft);
                //
                a.set();
                ShopProduct t = ShopProduct.find(product);
                t.set("picture", t.picture + a.attch + "|");
                out.print("mt.add('" + a.path3 + "');");
                return;
            }
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            if (h.member < 1)
            {
                out.println("<script>mt.show('您还没有登陆或登陆已超时！请重新登陆',2,'/admin/Login.jsp');</script>");
                return;
            }
            if ("edit".equals(act))
            {
                ShopProduct t = ShopProduct.find(product);
                int brand=h.getInt("brand");
                int model_id=h.getInt("model_id");
                ShopProduct sp = ShopProduct.find(brand,model_id);
                if(model_id>0&&sp.isExist&&sp.product!=t.product){
                	out.print("<script>parent.mt.show('该商品已经存在，请重新选择品牌或商品类型！');</script>");
                	return;
                }
                t.member = h.member;
                t.category = h.getInt("category");
                t.yucode = h.get("yucode");
                t.brand = brand;
                t.view_type = h.getInt("view_type");
                //t.category = h.getInt("category");
                t.name[0] = h.get("name0");
                t.name[1] = h.get("name1");
                t.supply = h.getFloat("supply");
                t.list = h.getFloat("list");
                t.price = h.getFloat("price");
                t.price_type = h.get("price_type");
                t.price_display = h.getInt("price_display");
                t.code = h.get("code");
                t.inventory = h.getInt("inventory");
                t.picture = h.get("picture");
             
                t.state = h.getInt("state");
                t.origin = h.getInt("origin");
                t.gross = h.getFloat("gross");
                t.recommend = h.get("products", "|");
                t.content[0] = h.get("content0");
                t.content[1] = h.get("content1");
                t.activity = h.get("activity");
                t.spec[0] = h.get("spec0");
                t.spec[1] = h.get("spec1");
                t.color = h.get("ycolor");
                t.size = h.get("ysize");
                t.farming = h.getInt("farming");
                t.commend = h.get("commend");
                t.shopid = h.getInt("shopid");
                t.packing = h.get("packing");
                t.place = h.get("place");
        	    t.model_id = model_id;
        	    t.factory = h.get("factory");
        	    t.tps_attch = h.getInt("tps_attch.attch");
        	    t.puid = h.getInt("puid");
                t.send_tps_number = h.getInt("send_tps_number");
        	    t.state = 0;

                if (t.time == null)
                    t.time = new Date();
                t.set();
                //
                Iterator it = ShopAttrib.find(" AND category=" + t.category, 0, 200).iterator();
                while (it.hasNext())
                {
                    ShopAttrib a = (ShopAttrib) it.next();
                    AValue av = AValue.find(t.product, a.attrib);
                    av.value[1] = h.get("a" + a.attrib);
                    av.set();
                }
            } else if ("del".equals(act))
            {
            	/*int count = ShopOrder.count(" AND member = "+product);
            	if(count>0){
            		out.print("<script>parent.mt.show('该商品已有订单不能删除！',1,'" + nexturl + "');</script>");
            		return;
            	}*/
                ShopProduct t = ShopProduct.find(product);
                t.set("state", "2");
            } else if ("setcategory".equals(act))
            {
                ShopProduct t = ShopProduct.find(product);
                t.member = h.member;
                //t.shopid = h.getInt("shopid");
                /*if(t.yucode==null&&t.shopid!=0){
                	String mcode = "";
                	int mct = ShopProduct.count(" AND state <> 2 AND shopid = "+t.shopid);
                	mct++;
                	String mcount = mct+"";
                	List<ShopProduct> lostp = ShopProduct.find(" AND shopid = "+t.shopid+" and state = 2 and pcode is not null order by pcode", 0, 200);
                	for(int i=0;i<lostp.size();i++){
                		ShopProduct p = lostp.get(i);
                		int lostc = ShopProduct.countweb(" AND yucode = '"+p.yucode+"' and state in (0,1);");
                		if(lostc==0){
                			mct = p.pcode;
                			break;
                		}
                	}
                	int clength = mcount.length();
                	if(clength==1){
                		mcode = "00"+mct;
                	}else if(clength==2){
                		mcode = "0"+mct;
                	}else if(clength==3){
                		mcode = ""+mct;
                	}
                	YuShop ys = YuShop.find(t.shopid);
                	mcode = ys.scode + mcode;
                	t.yucode = mcode;
                }*/
                t.category = h.getInt("category");
                t.state = 2;
                /*if (t.product < 1)
                {
                	t.state = 2;
                }else{
                	t.state = 3;//未审核
                }*/
                t.set();
                out.print("<script>window.open('/jsp/yl/shop/ShopProductEdit.jsp?product=" + t.product + "&nexturl=" + Http.enc(nexturl) + "','_parent');</script>");
                return;
            }else if ("sequence".equals(act))
            {
                String[] arr = h.get("products").split("[|]");
                for (int i = 1; i < arr.length; i++)
                {
                    ShopProduct t = new ShopProduct(Integer.parseInt(arr[i]));
                    t.set("indexShow", String.valueOf(i * 10));
                }
                return;
            } else if ("indexdel".equals(act))
            {
            	int pid = h.getInt("pid");
            		ShopProduct pd = ShopProduct.find(pid);
            		pd.set("indexShow", "0");
            	
            } else if ("indexshow".equals(act))
            {
            	String[] arr = h.get("product").split("[|]");
            	for (int i = 1; i < arr.length; i++){
            		ShopProduct pd = ShopProduct.find(Integer.parseInt(arr[i]));
            		pd.set("indexShow", "10000");
            	}
            }else if("updatetype".equals(act)){
            	int qid = h.getInt("qid");
            	int type = h.getInt("type");
            	String returnc = h.get("returnv");
            	ShopProduct sp = ShopProduct.find(qid);
            	sp.state = type;
            	sp.returnc = returnc;
            	sp.set();
            }else if("uptype".equals(act)){
            	int qid = h.getInt("product");
            	ShopProduct sp = ShopProduct.find(qid);
            	sp.state = h.getInt("mystate");
            	sp.set();
            }
//            else if("recommendedit".equals(act)){
//            	int sid = h.getInt("sid");
//            	int shownum = h.getInt("shownum");
//            	Recommend rc = Recommend.find(sid);
//            	rc.shownum = shownum;
//            	rc.set();
//            }
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
