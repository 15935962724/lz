package tea.ui.node.type.investor;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.entity.*;
import tea.htmlx.TimeSelection;
import tea.entity.node.*;

public class EditInvestor extends TeaServlet
{

    // Initialize global variables
    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        r.add("/tea/resource/Investor");
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        try
        {
            int options1 = 0;
            Node node = Node.find(teasession._nNode);

            if (teasession._rv == null)
            {
                if ((node.getOptions1() & 1) == 0)
                {
                    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                    return;
                }
                teasession._rv = RV.ANONYMITY;
            } else
            {
                if (!node.isCreator(teasession._rv) && !AccessMember.find(teasession._nNode, teasession._rv._strV).isProvider(51))
                {
                    // response.sendError(403);
                    // return;
                }
            }

            String subject = teasession.getParameter("Subject");
            String text = request.getParameter("fund_info");
            Date issue = TimeSelection.makeTime(teasession.getParameter("IssueYear"), teasession.getParameter("IssueMonth"), teasession.getParameter("IssueDay"), "0", "0");
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
                options &= 0xffdffbff;
                int defautllangauge = node.getDefaultLanguage();
                Category cat = Category.find(teasession._nNode); //51
                teasession._nNode = Node.create(teasession._nNode, sequence, community, teasession._rv, cat.getCategory(), (options1 & 2) != 0, options, options1, defautllangauge, null, null, new java.util.Date(), 0, 0, 0, 0, null,teasession._nLanguage, subject, "","", text, null, "", 0, null, "", "", "", "", null,null);
				node=Node.find(teasession._nNode);
            } else
            {
                node.set(teasession._nLanguage, subject, text);
                node.setTime(issue);
            }

            Investor investor = Investor.find(teasession._nNode, teasession._nLanguage);
            investor.setFundname(request.getParameter("fund_name"));
            investor.setFundinfo(text);
            investor.setFundsum(request.getParameter("fund_sum"));
            Date date5 = null;
            try
            {
                date5 = TimeSelection.makeTime(teasession.getParameter("fund_sum_load_1"), teasession.getParameter("fund_sum_load_2"), "0", "0", "0");
            } catch (Exception ex1)
            {
            }
            investor.setFundsumload(date5);
            investor.setFundarea(request.getParameter("fund_area_pro")); // "fund_area_city"
            investor.setFundtrade(request.getParameter("fund_trade"));
            investor.setFundsymbiosis((request.getParameter("fund_symbiosis")));
            investor.setFundwill(request.getParameter("fund_will"));
            investor.setFundwebsite(request.getParameter("fund_website"));
            investor.setFundperiod(Integer.parseInt(request.getParameter("fund_period")));
            investor.setFundidcard(request.getParameter("fund_IDcard"));
            investor.setFundlinkman(request.getParameter("fund_linkMan"));
            investor.setFundtel(request.getParameter("fund_tel"));
            investor.setFundfax(request.getParameter("fund_fax"));
            investor.setFundmail(request.getParameter("fund_mail"));
            investor.setFundpostcode(request.getParameter("fund_postcode"));
            investor.setFundaddress(request.getParameter("fund_address"));

            investor.setId(request.getParameter("id"));

            response.setContentType("text/html;charset=UTF-8");
            java.io.PrintWriter out = response.getWriter();
            out.print("<script>");
            if (!investor.isExists() && (options1 & 2) != 0)
            {
                out.print("window.alert('" + r.getString(teasession._nLanguage, "InfoAuditing") + "');");
            }
            investor.set();
            delete(node);
            String nexturl = teasession.getParameter("nexturl");
            if (request.getParameter("GoBack") != null)
            {
                String parm = "";
                if (nexturl != null)
                {
                    parm = "&nexturl=" + nexturl;
                }
                out.print("window.open('EditNode?node=" + teasession._nNode + parm + "','_self');");
                // response.sendRedirect("EditNode?node=" + teasession._nNode + parm);
            } else
            {
                Node.find(teasession._nNode).finished(teasession._nNode);
                if (nexturl != null)
                {
                    out.print("window.open('" + nexturl + "','_self');");
                }
                // response.sendRedirect(nexturl);
                else
                {
                    out.print("window.open('Investor?node=" + teasession._nNode + "&edit=ON','_self');");
                }
                // response.sendRedirect("Investor?node=" + teasession._nNode + "&edit=ON");
            }
            out.print("</script>");
            out.close();
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }

    // Clean up resources
    public void destroy()
    {
    }
}
