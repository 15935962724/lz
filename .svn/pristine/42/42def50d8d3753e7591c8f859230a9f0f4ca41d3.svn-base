
package tea.ui.node.type.buy;

import java.io.*;
import java.math.BigDecimal;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.RV;
import tea.entity.node.*;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.entity.member.Profile;

public class OfferCollect extends TeaServlet
{

    public OfferCollect()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        TeaSession teasession = new TeaSession(request);

        PrintWriter out = response.getWriter();
        try
        {
            if (teasession._rv == null)
            {
                //response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                out.print("<script>window.open('/servlet/StartLogin?node=" + teasession._nNode + "','_top');</script>");
                return;
            }

            Node node = Node.find(teasession._nNode);
            Favorite.create(teasession._strCommunity, teasession._rv,teasession._nNode);
            out.write("<html><head><link href=/res/" + teasession._strCommunity + "/cssjs/community.css rel=stylesheet type=text/css></head><body><div id=tishi_box>");
            out.write("<span id =li_zong>您已经把</span><span id=li_shuling>[" + node.getSubject(teasession._nLanguage) + "]</span> <br><span id =li_zong>商品加入了收藏夹中!</span><br/> <a href=/jsp/add/AddToFavorite_1.jsp?Node=" + teasession._nNode + " target=_parent class=bag>查看收藏夹</a>　　<a href=javascript:parent.location.reload(); class=trade>返回</a>");
            out.write("</div>");
            // response.sendRedirect("/jsp/type/buy/ATSCAlert.jsp?node=" +
            // teasession._nNode + "&community=" + teasession._strCommunity +
            // "&Quantity=" + s);
        } catch (Exception ex)
        {
            ex.printStackTrace();
            response.sendError(400, ex.toString());
        } finally
        {
            out.close();
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        r.add("tea/ui/node/type/buy/OfferBuy");
    }
}
