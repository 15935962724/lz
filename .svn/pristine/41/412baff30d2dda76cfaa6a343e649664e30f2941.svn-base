package tea.ui.node.listing;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.*;
import tea.entity.node.*;
import tea.entity.member.*;
import tea.ui.*;

//import tea.db.DbAdapter;

public class EditListingDetail extends TeaServlet // HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            Http h = new Http(request,response);
            if(h.member < 1)
            {
                response.sendRedirect("/servlet/StartLogin?community=" + h.community);
                return;
            }
            int listing = h.getInt("Listing");
            Listing l = Listing.find(listing);
            int realnode = l.getNode();
            Node node = Node.find(realnode);
            RV rv = new RV(Profile.find(h.member).getMember());
            if(realnode > 0 && !node.isCreator(rv) && AccessMember.find(realnode,rv).getPurview() < 2)
            {
                response.sendError(403);
                return;
            }
            ListingDetail ld = ListingDetail.find(listing,h.getInt("ListingType"),h.language);
            Enumeration e = request.getParameterNames();
            while(e.hasMoreElements())
            {
                String str = (String) e.nextElement();
                if(!str.endsWith("_1"))
                    continue;

                String name = str.substring(0,str.length() - 2);
                String tmp = h.get(name);
                int isType = tmp != null ? 1 : 0;
                try
                {
                    isType = Integer.parseInt(tmp);
                } catch(NumberFormatException ex1)
                {
                }
                String before = h.get(name + "_1").replaceAll("%u3c","<");
                String after = h.get(name + "_2").replaceAll("%u3c","<");
                int order = h.getInt(name + "_3");

                int anchor = 0;
                tmp = h.get(name + "_4");
                if(tmp != null)
                {
                    try
                    {
                        anchor = Integer.parseInt(tmp);
                    } catch(NumberFormatException ex)
                    {
                        anchor = 1;
                    }
                }
                int quantity = h.getInt(name + "_5");
                Date time = null;
                String year = h.get(name + "_6Year");
                if(year != null)
                {
                    time = ListingDetail.sdf.parse(year + "-" + h.get(name + "_6Month") + "-" + h.get(name + "_6Day"));
                }
                StringBuilder sb = new StringBuilder("/");
                String[] options = h.getValues(name + "_7");
                if(options != null)
                {
                    for(int i = 0;i < options.length;i++)
                    {
                        sb.append(options[i]).append("/");
                    }
                }
                if(isType == 0 && before.length() == 0 && after.length() == 0 && quantity == 0)
                {
                    ld.delete(name);
                } else
                {
                    ld.set(name,isType,before,after,order,anchor,quantity,sb.toString(),time,0);
                }
            }
            delete(node);

            String nexturl = "/jsp/listing/Picks.jsp?listing=" + listing + "&node=" + h.node;
            if(request.getParameter("GoBack") != null) // 上一步
            {
                String picknode = request.getParameter("PickNode");
                if(picknode != null) // 自动列举
                {
                    nexturl = "/jsp/listing/EditPickNode.jsp?listing=" + listing + "&node=" + h.node + "&picknode=" + picknode;
                } else
                // 手动列举
                {
                    nexturl = "/jsp/listing/EditPickManual.jsp?listing=" + listing + "&node=" + h.node + "&pickmanual=" + h.get("PickManual");
                }
            }
            response.sendRedirect(nexturl);
        } catch(Throwable ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
    }
}
