package tea.ui.node.listing;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import tea.entity.node.*;
import tea.ui.*;

public class EditSearch extends TeaServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            int listing = Integer.parseInt(request.getParameter("listing"));

            Search search = Search.find(listing);
            search.setContext(request.getParameter("context") != null);
            String str[] = request.getParameterValues("searchlisting");
            StringBuilder sb = new StringBuilder();
            if (str != null)
            {
                for (int loop = 0; loop < str.length; loop++)
                {
                    sb.append("/" + str[loop].trim());
                }
            }
            search.setSearchListing(sb.toString()); // request.getParameter("searchListing"));
            search.setType(Integer.parseInt(request.getParameter("type")));
            search.setSearchNode(Integer.parseInt(request.getParameter("searchnode")));
            search.set();
            String term1 = request.getParameter("term1");
            String field1 = request.getParameter("field1");
            if (term1.length() > 7 && !field1.equals("None"))
            {
                int index = term1.toLowerCase().indexOf("name=\"");
                if (index > 0)
                {
                    int endIndex = term1.indexOf("\"", index + 6);
                    term1 = term1.substring(0, index + 6) + field1 + term1.substring(endIndex);
                }
            } else
            {
                field1 = "None";
            }
            search.setLayer(term1, field1, Integer.parseInt(request.getParameter("sequence1")), 1, teasession._nLanguage);
            //////////
            String term2 = request.getParameter("term2");
            String field2 = request.getParameter("field2");
            if (term2.length() > 7 && !field2.equals("None"))
            {
                int index = term2.toLowerCase().indexOf("name=\"");
                if (index > 0)
                {
                    int endIndex = term2.indexOf("\"", index + 6);
                    term2 = term2.substring(0, index + 6) + field2 + term2.substring(endIndex);
                }
            } else
            {
                field2 = "None";
            }
            search.setLayer(term2, field2, Integer.parseInt(request.getParameter("sequence2")), 2, teasession._nLanguage);
            String term3 = request.getParameter("term3");
            String field3 = request.getParameter("field3");
            if (term3.length() > 7 && !field3.equals("None"))
            {
                int index = term3.toLowerCase().indexOf("name=\"");
                if (index > 0)
                {
                    int endIndex = term3.indexOf("\"", index + 6);
                    term3 = term3.substring(0, index + 6) + field3 + term3.substring(endIndex);
                }
            } else
            {
                field3 = "None";
            }
            search.setLayer(term3, field3, Integer.parseInt(request.getParameter("sequence3")), 3, teasession._nLanguage);
            String term4 = request.getParameter("term4");
            String field4 = request.getParameter("field4");
            if (term4.length() > 7 && !field4.equals("None"))
            {
                int index = term4.toLowerCase().indexOf("name=\"");
                if (index > 0)
                {
                    int endIndex = term4.indexOf("\"", index + 6);
                    term4 = term4.substring(0, index + 6) + field4 + term4.substring(endIndex);
                }
            } else
            {
                field4 = "None";
            }
            search.setLayer(term4, field4, Integer.parseInt(request.getParameter("sequence4")), 4, teasession._nLanguage);
            String termSmall = request.getParameter("termSmall");
            String fieldSmall = request.getParameter("field6");
            if (termSmall.length() > 7 && !fieldSmall.equals("None"))
            {
                int index = termSmall.toLowerCase().indexOf("name=\"");
                if (index > 0)
                {
                    int endIndex = termSmall.indexOf("\"", index + 6);
                    termSmall = termSmall.substring(0, index + 6) + fieldSmall + "Small" + termSmall.substring(endIndex);
                }
            } else
            {
                fieldSmall = "None";
            }
            search.setLayer(termSmall, fieldSmall, Integer.parseInt(request.getParameter("sequenceSmall")), 6, teasession._nLanguage);
            String termBig = request.getParameter("termBig");
            String fieldBig = request.getParameter("field5");
            if (termBig.length() > 7 && !fieldBig.equals("None"))
            {
                int index = termBig.toLowerCase().indexOf("name=\"");
                if (index > 0)
                {
                    int endIndex = termBig.indexOf("\"", index + 6);
                    termBig = termBig.substring(0, index + 6) + fieldBig + "Big" + termBig.substring(endIndex);
                }
            } else
            {
                fieldBig = "None";
            }
            search.setLayer(termBig, fieldBig, Integer.parseInt(request.getParameter("sequenceBig")), 5, teasession._nLanguage);
            String termOrder = request.getParameter("termOrder");
            String fieldOrder = request.getParameter("fieldOrder");
            if (termOrder.length() > 7 && !fieldOrder.equals("None"))
            {
                int index = termOrder.toLowerCase().indexOf("name=\"");
                if (index > 0)
                {
                    int endIndex = termOrder.indexOf("\"", index + 6);
                    termOrder = termOrder.substring(0, index + 6) + fieldOrder + termOrder.substring(endIndex);
                }
            } else
            {
                fieldOrder = "None";
            }
            search.setLayer(termOrder, fieldOrder, Integer.parseInt(request.getParameter("sequenceOrder")), 7, teasession._nLanguage);

            String termAmount = request.getParameter("termAmount");
            String fieldAmount = request.getParameter("fieldAmount");
            if (termAmount.length() > 7 && !fieldAmount.equals("None"))
            {
                int index = termAmount.toLowerCase().indexOf("name=\"");

                if (index > 0)
                {
                    int endIndex = termAmount.indexOf("\"", index + 6);
                    termAmount = termAmount.substring(0, index + 6) + fieldAmount + "Amount" + termAmount.substring(endIndex);
                }
            } else
            {
                fieldAmount = "None";
            }
            search.setLayer(termAmount, fieldAmount, Integer.parseInt(request.getParameter("sequenceAmount")), 9, teasession._nLanguage);
            //
            String submit = request.getParameter("termSubmit");
            search.setLayer(submit, "None", Integer.parseInt(request.getParameter("sequenceSubmit")), 8, teasession._nLanguage);
            if (request.getParameter("GoBack") != null)
            {
                response.sendRedirect("EditListing?node=" + teasession._nNode + "&listing=" + listing);
            } else
            {
                response.sendRedirect("Node?node=" + teasession._nNode + "&edit=ON");
            }
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
    }
}
