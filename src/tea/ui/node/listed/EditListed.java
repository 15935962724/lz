package tea.ui.node.listed;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.*;
import tea.html.*;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditListed extends TeaServlet
{

    public EditListed()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            Node node = Node.find(teasession._nNode);
            if(!node.isCreator(teasession._rv) && AccessMember.find(teasession._nNode,teasession._rv._strV).getPurview() < 2)
            {
                response.sendError(403);
                return;
            }

            String s = request.getParameter("Listed");
            boolean flag = s == null;
            int i = 0;
            String listings[] = null;
            if(!flag)
            {
                int j = Integer.parseInt(s);

                Listed listed = Listed.find(j);
                i = listed.getListing();
            } else
            {
                listings = (request.getParameterValues("Listing"));
            }

            if(request.getMethod().equals("GET"))
            {
                if(!flag)
                {

                    response.sendRedirect("/jsp/listing/EditListed.jsp?node=" + teasession._nNode + "&Listed=" + s);
                } else
                {
                    StringBuilder sb = new StringBuilder();
                    for(int index = 0;index < listings.length;index++)
                    {
                        sb.append("&Listing=" + listings[index]);
                    }
                    response.sendRedirect("/jsp/listing/EditListed.jsp?node=" + teasession._nNode + sb.toString());
                }

                /*
                                Form form = new Form("foEdit", "POST", "EditListed");
                                form.setOnSubmit("return(submitInteger(this.Term,'" + super.r.getString(teasession._nLanguage, "InvalidTerm") + "')" + ");");
                                form.add(new HiddenField("Node", teasession._nNode));
                                form.add(new HiddenField("Listing", i));
                                if(!flag)
                                    form.add(new HiddenField("Listed", s));
                                Listing listing = Listing.find(i);
                                Table table = new Table();
                                Row row = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Name") + ":"), true));
                                Cell cell = new Cell(new Text("<font>" + listing.getName(teasession._nLanguage) + "</font>"));
                                row.add(cell);
                                table.add(row);
                                Row row1 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "ListingNode") + ":"), true));
                                Cell cell1 = new Cell(Node.find(listing.getNode()).getAnchor(teasession._nLanguage));
                                row1.add(cell1);
                                table.add(row1);
                                Row row2 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Style") + ":"), true));
                                Cell cell2 = new Cell(new Text(super.r.getString(teasession._nLanguage, Section.APPLY_STYLE[listing.getStyle()])));
                                row2.add(cell2);
                                table.add(row2);
                                Row row3 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "ListedTerm") + ":"), true));
                                Cell cell3 = new Cell(new TextField("Term"));
                                cell3.add(new Text(super.r.getString(teasession._nLanguage, "Days")));
                                row3.add(cell3);
                                table.add(row3);
                                form.add(table);
                                form.add(new Button(super.r.getString(teasession._nLanguage, "Submit")));
                                PrintWriter printwriter = response.getWriter();
                                printwriter.print(node.getAncestor(teasession._nLanguage, "Path"));
                                printwriter.print(form);
                                printwriter.print(new Languages(teasession._nLanguage, request));
                                printwriter.close();*/
            } else
            {
                int k = 0;
                try
                {
                    k = Integer.parseInt(request.getParameter("Term"));
                } catch(Exception exception1)
                {}
                if(k < 0)
                {
                    outText(teasession,response,super.r.getString(teasession._nLanguage,"InvalidTerm"));
                    return;
                }
                Date date = null;

                if(k > 0)
                {
                    date = new Date(System.currentTimeMillis() + (long) k * 24L * 60L * 60L * 1000L);
                }

                if(flag)
                {
                    for(int index = 0;index < listings.length;index++)
                    {
                        int id = Integer.parseInt(listings[index]);
                        Listed.create(teasession._nNode,id,date);
                        ListingCache.expire(id);
                    }
                } else
                {
                    Listed.find(Integer.parseInt(s)).set(date);
                    ListingCache.expire(i);
                }
                response.sendRedirect("/jsp/listing/Listeds.jsp?node=" + teasession._nNode);
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
        super.r.add("tea/ui/node/listed/EditListed").add("tea/ui/node/listed/NewListed");
    }
}
