package tea.ui.node.type.folder;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.*;
import tea.html.*;
import tea.htmlx.Go;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditFolder extends TeaServlet
{

    public EditFolder()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            Node node = Node.find(teasession._nNode);
            if(!node.isCreator(teasession._rv) && AccessMember.find(teasession._nNode,teasession._rv).getPurview() < 2)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            if(request.getMethod().equals("GET"))
            {
                response.sendRedirect("/jsp/general/EditFolder.jsp?node=" + teasession._nNode);
            } else
            {
                int i2 = 0;
                if(request.getParameter("CategoryOOpen") != null)
                {
                    i2 |= 1;
                }
                if(request.getParameter("CategoryONeedGrant") != null)
                {
                    i2 |= 2;
                }
                System.out.println(request.getParameter("CategoryOContributors"));
                if(request.getParameter("CategoryOContributors") != null)
                {
                    i2 |= 4;
                }
                if(request.getParameter("CategoryORole") != null)
                {
                    i2 |= 8;
                }
                //发行添加
                String categoryosubscribe = "/";

                if(teasession.getParameter("categoryosubscribe") != null && teasession.getParameter("categoryosubscribe").length() > 0)
                {
                    String bcString[] = teasession.getParameterValues("categoryosubscribe");
                    for(int ii = 0;ii < bcString.length;ii++)
                    {
                        categoryosubscribe = categoryosubscribe + bcString[ii] + "/";
                    }
                }

                StringBuilder h = new StringBuilder("/");
                String ms[] = teasession.getParameterValues("mark");
                if(ms != null)
                {
                    for(int i = 0;i < ms.length;i++)
                    {
                        h.append(ms[i]).append("/");
                    }
                }
                node.set("mark",node.mark = h.toString());
                node.setOptions1(i2);
                node.setCategoryosubscribe(categoryosubscribe);
                if(request.getParameter("GoBack") != null)
                {
                    response.sendRedirect("EditNode?node=" + teasession._nNode);
                } else if(request.getParameter("GoFinish") != null)
                {
                    node.finished(teasession._nNode);
                    response.sendRedirect("Node?node=" + teasession._nNode + "&edit=ON");
                }
            }
        } catch(Exception exception)
        {
            response.sendError(400,exception.toString());
            exception.printStackTrace();
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/node/type/category/EditCategory");
    }
}
