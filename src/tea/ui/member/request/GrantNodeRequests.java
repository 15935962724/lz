package tea.ui.member.request;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.entity.Http;
import tea.entity.RV;
import tea.entity.member.Message;
import tea.entity.node.*;
import tea.html.Anchor;
import tea.html.Text;
import tea.http.RequestHelper;
import tea.resource.Resource;
import tea.ui.*;
import tea.db.DbAdapter;

public class GrantNodeRequests extends TeaServlet
{

    public GrantNodeRequests()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {

        try
        {
            Http h = new Http(request);
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                outLogin(request,response,h);
                return;
            }
            Node node = Node.find(teasession._nNode);
            if(!node.isCreator(teasession._rv) && !AccessMember.find(teasession._nNode,teasession._rv._strV).isAuditing())
            {
                response.sendError(403);
                return;
            }

            String as[] = request.getParameterValues("nodes");
            if(as != null)
            {
                for(int i = 0;i < as.length;i++)
                {
                    int j = Integer.parseInt(as[i]);

                    Node node1 = Node.find(j);
                    RV rv = node1.getCreator();
                    String s = node1.getSubject(teasession._nLanguage);
                    if(request.getParameter("Grant") != null)
                    {
                        node1.grant();
                        //String s1 = RequestHelper.format(r.getString(teasession._nLanguage,"InfPermitNode"),s);
                        //String s3 = r.getString(teasession._nLanguage,"ClickHere");
                        //Message.create(teasession._strCommunity,teasession._rv._strV,rv.toString(),teasession._nLanguage,s1,"" + new Anchor("http://" + request.getServerName() + "/servlet/Node?node=" + j,new Text(s3)));
                    } else if(request.getParameter("Deny") != null)
                    {
                        //node1.deny();
                        node1.setHidden(true);
                        //String s2 = RequestHelper.format(r.getString(teasession._nLanguage,"InfProhibitNode"),s);
                        //String s4 = r.getString(teasession._nLanguage,"ClickHere");
                        //Message.create(teasession._strCommunity,teasession._rv._strV,rv.toString(),teasession._nLanguage,s2,"" + new Anchor("http://" + request.getServerName() + "/servlet/Node?node=" + j,new Text(s4)));
                    }
                }
            }

            this.delete(node);
            String nexturl = request.getParameter("nexturl");
            if(nexturl == null)
            {
                nexturl = "/jsp/request/NodeRequests.jsp?node=" + teasession._nNode;
            }
            response.sendRedirect(nexturl);
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        r.add("tea/ui/member/request/GrantNodeRequests");
    }
}
