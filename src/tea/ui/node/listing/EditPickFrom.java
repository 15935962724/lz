package tea.ui.node.listing;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.*;
import tea.entity.node.*;
import tea.entity.site.Community;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditPickFrom extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt;</script>");
            TeaSession teasession = new TeaSession(request);

            PickFrom obj = null;
            int listing = h.getInt(("listing"));
            int pickfrom = h.getInt(("pickfrom"));
            if(pickfrom != 0)
            {
                obj = PickFrom.find(pickfrom);
                listing = obj.getListing();
            }
            int realnode = Listing.find(listing).getNode();
            if(realnode > 0 && !Node.find(realnode).isCreator(teasession._rv) && AccessMember.find(realnode,teasession._rv).getPurview() < 2)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            String act = h.get("act");
            if("delete".equals(act))
            {
                obj.delete();
            } else
            {
                int l = h.getInt(("FromStyle"));
                String s2 = request.getParameter("FromCommunity");
                if(!Community.find(s2).isExists())
                {
                    outText(teasession,response,super.r.getString(teasession._nLanguage,"InvalidCommunity"));
                    return;
                }
                int j1 = h.getInt(("FromNode"));
                if(!Node.isExisted(j1))
                {
                    out.print("<script>mt.show('“源节点”不存在！');</script>");
                    return;
                }
                if(pickfrom == 0)
                {
                    PickFrom.create(listing,l,s2,j1);
                } else
                {
                    obj.set(l,s2,j1);
                }
                ListingCache.expire(listing);
            }
            out.print("<script>window.open('/jsp/listing/Picks.jsp?node=" + teasession._nNode + "&listing=" + listing + "','_parent');</script>");
        } catch(Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/node/listing/EditPickFrom").add("tea/ui/node/listing/Picks");
    }
}
