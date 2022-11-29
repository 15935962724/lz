package tea.ui.node.listing;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.node.*;
import tea.entity.site.*;
import tea.entity.*;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditPickManual extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            Http h = new Http(request,response);

            int listing = h.getInt("listing");
            int pickmanual = h.getInt("pickmanual");
            boolean _nNew = pickmanual == 0;
            PickManual obj = null;
            if(!_nNew)
            {
                obj = PickManual.find(pickmanual);
                listing = obj.listing;
            }
            int _nNode = Listing.find(listing).getNode();
            Node node = Node.find(_nNode);
            if(!node.isCreator(h.member) && AccessMember.find(_nNode,h.username).getPurview() < 2)
            {
                response.sendError(403);
                return;
            }
            String nu = "/jsp/listing/Picks.jsp?node=" + h.node + "&listing=" + listing;
            String act = request.getParameter("act");
            if("delete".equals(act))
            {
                obj.delete();
            } else
            {
                PickManual pm = PickManual.find(pickmanual);
                pm.listing = listing;
                pm.community = request.getParameter("community");
                pm.type = h.getInt("type");
                pm.classes = h.getInt("classes");
                pm.set();
                // 255->所有类型 0->文件夹 1->类别
                if(request.getParameter("GoNext") != null && pm.type != 255) // 下一步
                {
                    if(pm.type >= 65535)
                    {
                        pm.type = TypeAlias.find(pm.type).getType();
                    }
                    String qs = null;
                    if(pm.type < 1024)
                    {
                        nu = "/jsp/type/" + Node.NODE_TYPE[pm.type].toLowerCase() + "/" + Node.NODE_TYPE[pm.type] + "Detail.jsp";
                    } else
                    {
                        nu = "/jsp/type/dynamicvalue/DynamicValueDetail.jsp";
                    }
                    nu = nu + "?Listing=" + listing + "&Node=" + h.node + "&PickManual=" + pickmanual + "&Type=" + pm.type;
                    if(!_nNew)
                    {
                        nu += "&edit=ON";
                    }
                }
            }
            response.sendRedirect(nu);
        } catch(Exception exception)
        {
            response.sendError(400,exception.toString());
            exception.printStackTrace();
        }
    }
}
