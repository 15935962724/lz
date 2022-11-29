package tea.ui.node.type.buy;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.Commodity;
import tea.entity.node.Node;
import tea.html.*;
import tea.htmlx.Go;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditCommodity extends TeaServlet
{

    public EditCommodity()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            Node node = Node.find(teasession._nNode);

            System.setProperty("sun.net.client.defaultConnectTimeout", String.valueOf(10000));// （单位：毫秒)

            if (teasession._rv == null)
            {
                if ((node.getOptions1() & 1) == 0)
                {
                    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                    return;
                }
            } else
            {
                tea.entity.node.AccessMember obj_am = tea.entity.node.AccessMember.find(node._nNode, teasession._rv.toString());
                if (!node.isCreator(teasession._rv) && !obj_am.isProvider(node.getType()))
                {
                    response.sendError(403);
                    return;
                }
            }
            int i = node.getType();

            if (request.getMethod().equals("GET"))
            {
                response.sendRedirect("/jsp/type/buy/EditBuy.jsp?" + request.getQueryString());
                return;
            }
            int commodity = Integer.parseInt(request.getParameter("commodity"));
            if (request.getParameter("delete") != null)
            {
                Commodity obj = Commodity.find(commodity);
                obj.delete();
                response.sendRedirect("/jsp/type/buy/Buys.jsp?node=" + teasession._nNode);
            } else
            {
                /*
                          i = Integer.parseInt(teasession.getParameter("Type"));
                          boolean newbrother = teasession.getParameter("NewBrother") != null;
                          boolean newnode = teasession.getParameter("NewNode") != null;
                          String subject = teasession.getParameter("subject");
                          if (newnode || newbrother)
                          {
                 int father;
                 father = teasession._nNode;
                 if (newbrother)
                 {
                     father = Node.find(father).getFather();
                 }
                 Node node1 = Node.find(father);
                 int sequence = Node.getMaxSequence(father) + 10;
                 int options = 0, options1 = 0;
                 int typealias = 0;
                 String community = node1.getCommunity();
                 try
                 {
                     typealias = Integer.parseInt(teasession.getParameter("TypeAlias"));
                 } catch (Exception exception1)
                 {}
                 options = node1.getOptions();
                 int defautllangauge = node1.getDefaultLanguage();
                 teasession._nNode = tea.entity.node.Node.create(father, sequence, community, teasession._rv, i, typealias, false, options, options1, defautllangauge, null, null, teasession._nLanguage, subject, "", "", null, "", 0, null, "", "", "", "", null);
                 commodity = Commodity.find(teasession._nNode);
                          } else
                          {
                 node.setSubject(subject, teasession._nLanguage);
                 commodity = Commodity.find(teasession._nNode);
                          }*/

                int j = 0;
                switch (i)
                {
                case 4: // '\004'
                    if (request.getParameter("BuyOFast") != null)
                    {
                        j |= 1;
                    }
                    break;

                case 5: // '\005'
                    if (request.getParameter("BidOOnce") != null)
                    {
                        j |= 1;
                    }
                    break;

                case 6: // '\006'
                    if (request.getParameter("BargainOOnce") != null)
                    {
                        j |= 1;
                    }
                    break;
                }
                if (request.getParameter("BuyOFreeShipping") != null)
                {
                    j |= 2;
                }
                int s = Integer.parseInt(request.getParameter("Supplier"));
                String s1 = request.getParameter("SKU");
                String s2 = request.getParameter("SerialNumber");
                int l = Integer.parseInt(request.getParameter("Quality"));
                int i1 = 0;
                try
                {
                    i1 = Integer.parseInt(request.getParameter("Inventory"));
                } catch (Exception _ex)
                {
                    outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidInventory"));
                    return;
                }
                int j1 = 0;
                try
                {
                    j1 = Integer.parseInt(request.getParameter("MinQuantity"));
                } catch (Exception _ex)
                {
                    outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidMinQuantity"));
                    return;
                }
                int k1 = 0;
                try
                {
                    k1 = Integer.parseInt(request.getParameter("MaxQuantity"));
                } catch (Exception _ex)
                {
                    outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidMaxQuantity"));
                    return;
                }
                int l1 = 0;
                try
                {
                    l1 = Integer.parseInt(request.getParameter("Delta"));
                } catch (Exception _ex)
                {
                    outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidDelta"));
                    return;
                }
                int i2 = 0;
                try
                {
                    i2 = Integer.parseInt(request.getParameter("Weight"));
                } catch (Exception _ex)
                {
                    outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidWeight"));
                    return;
                }
                int k2 = 0;
                try
                {
                    k2 = Integer.parseInt(request.getParameter("Volume"));
                } catch (Exception _ex)
                {
                    outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidVolume"));
                    return;
                }
                node.setOptions1(j);
                if (commodity == 0)
                {
                    commodity = Commodity.create(s1, s2, l, i1, j1, k1, l1, s, i2, k2, teasession._nNode);
                } else
                {
                    Commodity obj = Commodity.find(commodity);
                    obj.set(s1, s2, l, i1, j1, k1, l1, s, i2, k2, teasession._nNode);
                }
                String nexturl = teasession.getParameter("nexturl");
                if (request.getParameter("GoBack") != null)
                {
                    response.sendRedirect("EditNode?node=" + teasession._nNode + (nexturl != null ? "&nexturl=" + nexturl : ""));
                    return;
                }
                if (nexturl != null)
                {
                    nexturl = "&nexturl=" + nexturl;
                } else
                {
                    nexturl = "";
                }
                if (request.getParameter("GoNext") != null)
                {
                    switch (i)
                    {
                    case 4: // '\004'
                        response.sendRedirect("BuyPrices?node=" + teasession._nNode + nexturl);
                        return;

                    case 5: // '\005'
                        response.sendRedirect("BidPrices?node=" + teasession._nNode + nexturl);
                        return;

                    case 6: // '\006'
                        response.sendRedirect("BargainPrices?node=" + teasession._nNode + nexturl);
                        return;
                    }
                    response.sendRedirect("/jsp/type/buy/BuyPrices.jsp?commodity=" + commodity + "&Node=" + teasession._nNode + nexturl);
                } else
                if (request.getParameter("GoFinish") != null)
                {
                    response.sendRedirect("/jsp/type/buy/Buys.jsp?node=" + teasession._nNode + nexturl);
                }
            }
        } catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}


    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/node/type/buy/EditCommodity");
    }
}
