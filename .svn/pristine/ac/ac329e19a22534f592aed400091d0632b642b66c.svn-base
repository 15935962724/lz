package tea.ui.node.access;

import java.io.IOException;
//import java.io.PrintWriter;
//import java.util.Enumeration;
//import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import tea.entity.node.*;
//import tea.html.*;
//import tea.http.RequestHelper;
//import tea.resource.Common;
//import tea.resource.Resource;
import tea.ui.*;

public class RequestAccess extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            /*
                Node node = Node.find(teasession._nNode);
                tea.entity.node.AccessMember obj_am = tea.entity.node.AccessMember.find(node._nNode, teasession._rv);
                if (!node.isCreator(teasession._rv) && !obj_am.isEdit())
                {
             response.sendRedirect("/servlet/Node?node=" + teasession._nNode);
             return;
                }
             */

            response.sendRedirect("/jsp/access/RequestAccess.jsp?" + request.getQueryString());

//            PrintWriter printwriter = response.getWriter();
//            if(AccessRequest.isAccessRequest(teasession._nNode,teasession._rv))
//            {
//                printwriter.print(super.r.getString(teasession._nLanguage,"InfRequested"));
//            } else
//            {
//                for(Enumeration enumeration = AccessPrice.find(teasession._nNode);enumeration.hasMoreElements();printwriter.print(new Break()))
//                {
//                    int i = ((Integer) enumeration.nextElement()).intValue();
//                    java.math.BigDecimal bigdecimal = AccessPrice.find(teasession._nNode,i).getPrice();
//                    printwriter.print(new Anchor("PayAccess?node=" + teasession._nNode + "&Currency=" + i + "&Price=" + bigdecimal,new Text(RequestHelper.format(super.r.getString(teasession._nLanguage,
//                            "InfPay"),super.r.getString(teasession._nLanguage,Common.CURRENCY[i]) + bigdecimal))));
//                }
//            }
//            printwriter.close();

        } catch(Exception ex)
        {
            response.sendError(500,ex.toString());
            ex.printStackTrace();
        }
    }
    /*
     * public void init(ServletConfig servletconfig) throws ServletException { super.init(servletconfig); super.r.add("tea/ui/node/access/RequestAccess"); }
     */
}
