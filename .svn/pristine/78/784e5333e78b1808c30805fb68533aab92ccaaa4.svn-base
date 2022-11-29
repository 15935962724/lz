package tea.ui.node.type.category;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.node.*;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditCategory extends TeaServlet
{
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
                response.sendRedirect("/jsp/general/EditCategory.jsp?" + request.getQueryString());
            } else
            {
                Category category = Category.find(teasession._nNode);
                int type = Integer.parseInt(request.getParameter("type"));
                int i2 = 0;
                if(request.getParameter("CategoryOOpen") != null)
                {
                    i2 |= 1;
                }
                if(request.getParameter("CategoryONeedGrant") != null)
                {
                    i2 |= 2;
                }

                if(request.getParameter("CategoryOContributors") != null)
                {
                    i2 |= 4;
                }
                if(request.getParameter("CategoryORole") != null)
                {
                    i2 |= 8;
                }

                int j2 = 0; //Integer.parseInt(request.getParameter("Template"));
                /*  if(j2 != 0 && !Node.isExisted(j2))
                  {
                      outText(response, teasession._nLanguage, super.r.getString(teasession._nLanguage, "InvalidTemplate"));
                      return;
                  }*/

                /**
                 * 审核权限
                 * 2012-04-06
                 * zjs
                 */
                int i3 = 0;
                if(request.getParameter("Permissions1") != null)
                {
                    i3 |= 1;
                }
                if(request.getParameter("Permissions2") != null)
                {
                    i3 |= 2;
                }

                if(request.getParameter("Permissions3") != null)
                {
                    i3 |= 4;
                }
                if(request.getParameter("Permissions4") != null)
                {
                    i3 |= 8;
                }

                int c = 0;
                String tmp = teasession.getParameter("clewtype");
                if(tmp != null)
                {
                    c = Integer.parseInt(tmp);
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
                node.set(node.isMostly(),node.isMostly1(),node.isMostly2(),h.toString());

                String cc = teasession.getParameter("clewcontent");
                node.setOptions1(i2);
                node.setType(type);
                category.set(type,j2,c,cc,i3);
                if(request.getParameter("GoBack") != null)
                {
                    response.sendRedirect("/servlet/EditNode?node=" + teasession._nNode);
                } else
                {
                    node.finished(teasession._nNode);
                    if(category.getClewtype() != 0)
                    {
                        //strClick = "window.open('/servlet/OfferBuy?Node=" + _nNode + "&commodity=" + id + "&currency=" + currency + "&quantity=1','dialog_frame');"; // ,'height=170,width=370,left=250,top=150'

                        //response.sendRedirect("/jsp/general/EditCategory.jsp?node="+n.getFather());
                    }
                    response.sendRedirect("/servlet/Node?node=" + teasession._nNode + "&edit=ON");
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
        // super.r.add("tea/ui/node/type/category/EditCategory");
    }
}
