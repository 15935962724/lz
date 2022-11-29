package tea.ui.site;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.*;
import tea.entity.site.*;
import tea.entity.node.*;
import tea.ui.*;

public class EditDNS extends TeaServlet
{

    // Initialize global variables
    public void init() throws ServletException
    {
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(request.getRequestURI() + "?" + request.getQueryString(),"UTF-8"));
                return;
            }
            String nu;
            String act = request.getParameter("act");
            if(act != null && act.endsWith("dnscity"))
            {
                int dnscity = Integer.parseInt(request.getParameter("dnscity"));
                String domainname = request.getParameter("domainname");
                DNSCity dc = DNSCity.find(dnscity);
                if(act.equals("deletednscity"))
                {
                    dc.delete();
                } else
                {
                    String tmp = request.getParameter("city1");
                    if(tmp.length() < 1)
                    {
                        tmp = request.getParameter("city0");
                    }
                    int city = Integer.parseInt(tmp);
                    String url = request.getParameter("url");
                    dc.set(domainname,city,url);
                }
                nu = "/jsp/site/DNSCitys.jsp?community=" + teasession._strCommunity + "&domainname=" + domainname;
            } else
            {
                String dn = teasession.getParameter("domainname").toLowerCase().replaceAll("\\*","%");
                DNS dns = DNS.find(dn);
                if(request.getParameter("delete") != null)
                {
                    dns.delete();
                } else
                {
                    Http h = new Http(request);

                    String community = h.community;
                    int node = h.getInt("node");
                    String url = h.get("url"); // URL转向
                    if(node > 0)
                    {
                        Node node_obj = Node.find(node);
                        community = node_obj.getCommunity();
                        if(community == null)
                        {
                            // community = request.getParameter("community");
                            response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"InvalidNodeNumber"),"UTF-8"));
                            return;
                        }
                    }
                    dns.set(community,teasession._nStatus,url,node,false,h.get("gkey"));
                }
                nu = "/jsp/site/EditDNS.jsp?community=" + teasession._strCommunity;
            }
            response.sendRedirect(nu);
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }

    // Clean up resources
    public void destroy()
    {
    }
}
