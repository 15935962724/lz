package tea.ui.node.type.lfinancing;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.TeaSession;
import tea.entity.*;
import tea.htmlx.TimeSelection;
import tea.entity.node.*;
import java.sql.SQLException;

public class EditLFinancing extends tea.ui.TeaServlet
{
    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        r.add("/tea/resource/LFinancing");
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        try
        {
            int options1 = 0;
            TeaSession teasession = new TeaSession(request);
            Node node = Node.find(teasession._nNode);
            if (teasession._rv == null)
            {
                if ((node.getOptions1() & 1) == 0)
                {
                    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                    return;
                }
                teasession._rv = new tea.entity.RV("ANONYMITY", "Home");
            } else
            {
                if (!node.isCreator(teasession._rv) && !AccessMember.find(teasession._nNode, teasession._rv._strV).isProvider(53))
                {
                    // response.sendError(403);
                    // return;
                }
            }
            String subject = teasession.getParameter("Subject");
            Date date5 = TimeSelection.makeTime(teasession.getParameter("IssueYear"), teasession.getParameter("IssueMonth"), teasession.getParameter("IssueDay"), teasession.getParameter("IssueHour"), teasession.getParameter("IssueMinute"));
            String text = teasession.getParameter("synopsis");
            boolean newnode = teasession.getParameter("NewNode") != null;
            if (newnode)
            {
                int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                options1 = node.getOptions1();
                int typealias = 0;
                String community = node.getCommunity();
                try
                {
                    typealias = Integer.parseInt(teasession.getParameter("TypeAlias"));
                } catch (Exception exception1)
                {
                }
                long options = node.getOptions();
                // options &= 0xffdffbff;
                int defautllangauge = node.getDefaultLanguage();
                Category cat = Category.find(teasession._nNode); //53
                teasession._nNode = Node.create(teasession._nNode, sequence, community, teasession._rv, cat.getCategory(), (options1 & 2) != 0, options, options1, defautllangauge, null, null, new java.util.Date(), 0, 0, 0, 0, null,teasession._nLanguage, subject, "","", text, null, "", 0, null, "", "", "", "", null,null);
				node=Node.find(teasession._nNode);
            } else
            {
                node.set(teasession._nLanguage, subject, text);
                node.setTime(date5);
            }
            LFinancing financing = LFinancing.find(teasession._nNode, teasession._nLanguage);
            // financing.setIssuedate(date5);
            financing.setYearrestrict(request.getParameter("yearrestrict"));
            financing.setMobile(request.getParameter("mobile"));
            String linkman = request.getParameter("linkman");
            financing.setLinkman(linkman);

            String allmoney = request.getParameter("allmoney");
            financing.setAllmoney(allmoney);

            String postalcode = request.getParameter("postalcode");
            financing.setPostalcode(postalcode);

            String website = request.getParameter("website");
            financing.setWebsite(website);

            String homeplace = request.getParameter("homeplace");
            financing.setHomeplace(homeplace);

            String address = request.getParameter("address");
            financing.setAddress(address);

            String synopsis = request.getParameter("synopsis");
            financing.setSynopsis(synopsis);

            String fashion = request.getParameter("fashion");
            financing.setFashion(fashion);

            String unitname = request.getParameter("unitname");
            financing.setUnitname(unitname);

            String phone = request.getParameter("phone");
            financing.setPhone(phone);

            String future = request.getParameter("future");
            financing.setFuture(future);

            String reside = request.getParameter("reside");
            financing.setReside(reside);

            String evolve = request.getParameter("evolve");
            financing.setEvolve(evolve);

            String financingmoney = request.getParameter("financingmoney");
            financing.setFinancingmoney(financingmoney);

            String investcallback = request.getParameter("investcallback");
            financing.setInvestcallback(investcallback);

            String unitsynopsis = request.getParameter("unitsynopsis");
            financing.setUnitsynopsis(unitsynopsis);

            String idcard = request.getParameter("idcard");
            financing.setIdcard(idcard);

            String email = request.getParameter("email");
            financing.setEmail(email);

            String redound = request.getParameter("redound");
            financing.setRedound(redound);

            String unitessence = request.getParameter("unitessence");
            financing.setUnitessence(unitessence);

            String area = request.getParameter("area");
            financing.setArea(area);

            String fax = request.getParameter("fax");
            financing.setFax(fax);

            String essence = request.getParameter("essence");
            financing.setEssence(essence);

            String name = request.getParameter("name");
            financing.setName(name);

            java.io.PrintWriter out = response.getWriter();
            out.print("<script>");
            if (!financing.isExists() && (options1 & 2) != 0)
            {
                out.print("window.alert('" + r.getString(teasession._nLanguage, "InfoAuditing") + "');");
            }
            financing.set();
            super.delete(node);
            String nexturl = teasession.getParameter("nexturl");
            if (request.getParameter("GoBack") != null)
            {
                String parm = "";
                if (nexturl != null)
                {
                    parm = "&nexturl=" + nexturl;
                }
                out.print("window.open('EditNode?node=" + teasession._nNode + parm + "','_self');");
                // response.sendRedirect("EditNode?node=" + teasession._nNode +
                // parm);
            } else
            {
                node.finished(teasession._nNode);
                if (nexturl != null)
                {
                    out.print("window.open('" + nexturl + "','_self');");
                }
                // response.sendRedirect(nexturl);
                else
                {
                    out.print("window.open('Financing?node=" + teasession._nNode + "&edit=ON','_self');");
                }
                // response.sendRedirect("Financing?node=" + teasession._nNode +
                // "&edit=ON");
            }
            out.print("</script>");
            out.close();
        } catch (SQLException ex)
        {
            ex.printStackTrace();
        } catch (IOException ex)
        {
            ex.printStackTrace();
        }
    }

    // Clean up resources
    public void destroy()
    {
    }
}
