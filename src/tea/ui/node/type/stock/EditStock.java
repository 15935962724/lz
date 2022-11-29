package tea.ui.node.type.stock;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.*;
import tea.entity.*;
import tea.html.*;
import tea.htmlx.Go;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.db.DbAdapter;

public class EditStock extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setHeader("Cache-Control","no-cache");
        Http h = new Http(request);
        TeaSession teasession = new TeaSession(request);
        if(teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
            return;
        }
        PrintWriter out = response.getWriter();
        try
        {
            int node = h.getInt("node");
            String act = h.get("act");
            if("edit".equals(act))
            {
                String subject = h.get("subject");
                String content = h.get("content");
                Node n = Node.find(node);
                if(n.getType() == 1)
                {
                    int options1 = n.getOptions1();
                    Category cat = Category.find(teasession._nNode);
                    node = Node.create(teasession._nNode,0,teasession._strCommunity,teasession._rv,cat.getCategory(),(options1 & 2) != 0,n.getOptions(),options1,n.getDefaultLanguage(),null,null,new java.util.Date(),n.getStyle(),n.getRoot(),n.getKstyle(),n.getKroot(),null,teasession._nLanguage,subject,"","",content,null,"",0,null,"","","","",null,null);
                    n = Node.find(node);
                } else
                {
                    n.set(teasession._nLanguage,subject,content);
                }
                n.finished(node);
                Stock t = Stock.find(node);
                t.code = h.get("code");
//                String tmp = h.get("graphweek");
//                String graphweek = tmp != null ? tmp : obj2.getGraphWeek();
//                tmp = h.get("graphmonth");
//                String graphmonth = tmp != null ? tmp : obj2.getGraphMonth();
//                tmp = h.get("graphyear");
//                String graphyear = tmp != null ? tmp : obj2.getGraphYear();
//                tmp = h.get("graphyet");
//                String graphyet = tmp != null ? tmp : obj2.getGraphYet();
                t.set();
                if(h.getBool("list"))
                {
                    out.print("<script>parent.mt.show(null,0);parent.location.href=('/jsp/type/stock/EditStockList.jsp?node=" + node + "');</script>");
                    return;
                }
            } else if("list".equals(act))
            {
                java.util.Date date = h.getDate("Issue");
                StockList obj = StockList.find(teasession._nNode,date);
                float datedata = Float.parseFloat(h.get("datedata").replaceAll(",",""));
                float openingprice = Float.parseFloat(h.get("openingprice").replaceAll(",",""));
                float high = Float.parseFloat(h.get("high").replaceAll(",",""));
                float low = Float.parseFloat(h.get("low").replaceAll(",",""));
                float closingprice = Float.parseFloat(h.get("closingprice").replaceAll(",",""));
                float percentchange = Float.parseFloat(h.get("percentchange").replaceAll(",",""));
                int volume = Integer.parseInt(h.get("volume").replaceAll(",",""));
                String stockname = h.get("stockname");
                String estockname = h.get("estockname");
                obj.set(teasession._nNode,date,stockname,datedata,openingprice,high,low,closingprice,percentchange,volume,estockname);
            } else if("del".equals(act))
            {
                StockList.find(h.getInt("id")).delete();
                out.print("<script>parent.mt.show('数据删除成功!',1,'location.reload()');</script>");
                return;
            }
            out.print("<script>parent.mt.show('数据修改成功!',1,'/html/"+teasession._strCommunity+"/stock/" + node + ".htm');</script>");
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }
//
//    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
//    {
//        request.setCharacterEncoding("UTF-8");
//        try
//        {
//            TeaSession teasession = new TeaSession(request);
//            tea.entity.node.Node node = tea.entity.node.Node.find(teasession._nNode);
//            if (h.get("Stockid") != null)
//            {
//                id = Integer.parseInt(h.get("Stockid"));
//            }
//            if (h.get("Listing") != null)
//            {
//                listing = Integer.parseInt(h.get("Listing"));
//            }
//            if (h.get("Page") != null)
//            {
//                page = Integer.parseInt(h.get("Page"));
//            }
//            if (teasession._rv == null)
//            {
//                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
//                return;
//            }
//            if (request.getMethod().equals("GET"))
//            {
//                String qs = request.getQueryString();
//                qs = qs == null ? "" : "?" + qs;
//                response.sendRedirect("/jsp/type/stock/EditStock.jsp" + qs);
//            } else
//            {

//                response.sendRedirect("Node?node=" + teasession._nNode + "&stocksearch=1&Listing=" + listing + "&Page=" + page);
//            }
//        } catch (Exception exception)
//        {
//            response.sendError(400, exception.toString());
//            exception.printStackTrace();
//        }
//    }
//
//    public void init(ServletConfig servletconfig) throws ServletException
//    {
//        super.init(servletconfig);
//        super.r.add("tea/ui/node/type/stock/EditStock");
//    }
//
//    int id = 1;
//    int listing = 0;
//    int page = 0;
}
