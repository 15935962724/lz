package tea.ui.node.general;


import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.node.Node;
import tea.entity.site.*;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class JoinCommunity extends TeaServlet
{

    public JoinCommunity()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            Node node = Node.find(teasession._nNode);
            String s = node.getCommunity();
            Community community = Community.find(s);
            if (teasession._rv.isOrganizer(s) || Subscriber.find(s, teasession._rv).getOptions()==2)
            {
                response.sendRedirect("Node?node=" + teasession._nNode + "&Login=true");
                return;
            }
            String info;
            if (community.getType() == 0)
            {
//                JoinRequest.create(s, teasession._rv);
                Subscriber.create(s,teasession._rv,0);
                info = r.getString(teasession._nLanguage, "InfAlreadyRequestedJoin");
            } else
            {
                info = r.getString(teasession._nLanguage, "InfPrivateCommunity");
            }
            response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(info, "UTF-8"));
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
            return;
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        r.add("tea/ui/node/general/JoinCommunity");
    }
}
