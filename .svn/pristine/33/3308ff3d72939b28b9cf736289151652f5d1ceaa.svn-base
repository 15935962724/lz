package tea.ui.node.type.ticket;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import tea.ui.TeaSession;
import tea.entity.node.*;

public class EditTicket extends tea.ui.TeaServlet
{
    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            tea.entity.node.Node node = tea.entity.node.Node.find(teasession._nNode);
            boolean delete = teasession.getParameter("delete") != null;
            if (request.getMethod().equals("GET") && !delete)
            {
                response.sendRedirect("/jsp/type/ticket/EditTicket.jsp?node=" + teasession._nNode);
                return;
            }

            if (teasession.getParameter("berth") != null) //舱位表
            {
                int berth = Integer.parseInt(request.getParameter("berth"));

                if (delete)
                {
                    Berth obj = Berth.find(berth);
                    obj.delete();
                } else
                {
                    String name = request.getParameter("name");
                    int aagio = Integer.parseInt(request.getParameter("aagio"));
                    float price = Float.parseFloat(request.getParameter("price"));
                    if (berth == 0)
                    {
                        Berth.create(teasession._nNode, aagio, price, teasession._nLanguage, name);
                    } else
                    {
                        Berth obj = Berth.find(berth);
                        obj.set(teasession._nNode, aagio, price, teasession._nLanguage, name);
                    }
                }
                response.sendRedirect("/jsp/type/flight/EditBerth.jsp?node=" + teasession._nNode + "&flight=" + request.getParameter("flight"));
                return;
            } else //航班表
            {
                /*
                       if (delete)
                       {
                           Flight flight = Flight.find(teasession._nNode);
                           flight.delete();
                       } else*/
                {
                    String logo;
                    byte by[] = teasession.getBytesParameter("logo");
                    if (by != null)
                    {
                        logo = request.getContextPath() + (super.write(node.getCommunity(), by,".gif"));
                    } else
                    {
                        logo = teasession.getParameter("logopath");
                    }

                    String mark = teasession.getParameter("mark");

                    StringBuilder week = new StringBuilder("/");
                    if (teasession.getParameter("week1") != null)
                    {
                        week.append("1/");
                    }
                    if (teasession.getParameter("week2") != null)
                    {
                        week.append("2/");
                    }
                    if (teasession.getParameter("week3") != null)
                    {
                        week.append("3/");
                    }
                    if (teasession.getParameter("week4") != null)
                    {
                        week.append("4/");
                    }
                    if (teasession.getParameter("week5") != null)
                    {
                        week.append("5/");
                    }
                    if (teasession.getParameter("week6") != null)
                    {
                        week.append("6/");
                    }
                    if (teasession.getParameter("week7") != null)
                    {
                        week.append("7/");
                    }

                    java.util.Date takeoff = Flight.sdf.parse(teasession.getParameter("takeoffhour") + ":" + teasession.getParameter("takeoffminute"));
                    java.util.Date descent = Flight.sdf.parse(teasession.getParameter("descenthour") + ":" + teasession.getParameter("descentminute"));

                    String types = teasession.getParameter("types");
                    String start = teasession.getParameter("start");
                    String terminus = teasession.getParameter("terminus");
                    String eat = teasession.getParameter("eat");
                    String remark = teasession.getParameter("remark");
                    float price = Float.parseFloat(teasession.getParameter("price"));
                    int startaerodrome = Integer.parseInt(teasession.getParameter("startaerodrome"));
                    int terminusaerodrome = Integer.parseInt(teasession.getParameter("terminusaerodrome"));
                    float tax = Float.parseFloat(teasession.getParameter("tax"));
                    int company = Integer.parseInt(teasession.getParameter("company"));
                    Flight flight = Flight.find(teasession._nNode);
                    boolean nonstop = teasession.getParameter("nonstop") != null;

                    int fly = Integer.parseInt(teasession.getParameter("fly"));
                    if (!flight.isExists())
                    {
                        Flight.create(teasession._nNode, mark, week.toString(), takeoff, descent, logo, price, startaerodrome, terminusaerodrome, tax, company, nonstop, fly, teasession._nLanguage, types, start, terminus, eat, remark);
                    } else
                    {
                        flight.set(teasession._nNode, mark, week.toString(), takeoff, descent, logo, price, startaerodrome, terminusaerodrome, tax, company, nonstop, fly, teasession._nLanguage, types, start, terminus, eat, remark);
                    }

                    node.setSubject(teasession.getParameter("name"), teasession._nLanguage);
                    node.finished(teasession._nNode);
                    if (teasession.getParameter("GoBack") != null)
                    {
                        response.sendRedirect("/servlet/EditNode?node=" + teasession._nNode);
                    } else
                    if (teasession.getParameter("GoNext") != null)
                    {
                        response.sendRedirect("/jsp/type/flight/EditBerth.jsp?node=" + teasession._nNode);
                    } else
                    {
                        response.sendRedirect("Node?node=" + teasession._nNode + "&edit=ON");
                    }
                }
            }
            delete(node);
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }
}
