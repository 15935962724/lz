package tea.ui.member.community;

import java.io.IOException;
//import java.io.PrintWriter;
//import java.util.Enumeration;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//import tea.entity.site.Community;
//import tea.entity.site.Organizer;
//import tea.html.*;
//import tea.htmlx.Languages;
//import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class OrganizingCommunities extends TeaServlet
{
    public OrganizingCommunities()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }

            response.sendRedirect("/jsp/community/OrganizingCommunities.jsp?community="+teasession._strCommunity+"&language=1");
            /*
                        Text text = new Text(hrefGlance(teasession._rv) + ">" + new Anchor("Communities", r.getString(teasession._nLanguage, "Communities")) + ">" + r.getString(teasession._nLanguage, "OrganizingCommunities"));
                        text.setId("PathDiv");
                        Table table = new Table();
                        int i = Organizer.countOrganizing(teasession._rv);
                        table.setCaption(i + " " + r.getString(teasession._nLanguage, "OrganizingCommunities"));
                        Row row;
                        for(Enumeration enumeration = Organizer.findOrganizing(teasession._rv); enumeration.hasMoreElements(); table.add(row))
                        {
                            String s = (String)enumeration.nextElement();
                            Community community = Community.find(s);
                            row = new Row(new Cell(new Anchor("Node?Community=" + s, new Text(s))));
                            row.add(new Cell(new Text("  ")));
                            row.add(new Cell(new Button(1, "CB", "CBJoinRequests", r.getString(teasession._nLanguage, "CBJoinRequests"), "window.open('JoinRequests?Community=" + s + "', '_self');")));
                            row.add(new Cell(new Button(1, "CB", "CBSubscribers", r.getString(teasession._nLanguage, "CBSubscribers"), "window.open('Subscribers?Community=" + s + "', '_self');")));
                            row.add(new Cell(new Button(1, "CB", "CBOrganizers", r.getString(teasession._nLanguage, "CBOrganizers"), "window.open('Organizers?Community=" + s + "', '_self');")));
                            row.add(new Cell(new Button(1, "CB", "CBProviders", r.getString(teasession._nLanguage, "CBProviders"), "window.open('Providers?Community=" + s + "', '_self');")));
                            row.add(new Cell(new Button(1, "CB", "CBEdit", r.getString(teasession._nLanguage, "CBEdit"), "window.open('EditCommunity?Community=" + s + "', '_self');")));
                            if(community.isLayerExisted(teasession._nLanguage))
                                row.add(new Cell(new Button(1, "CB", "CBDelete", r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + r.getString(teasession._nLanguage, "ConfirmDelete") + "')){window.open('DeleteCommunity?Community=" + s + "', '_self');}")));
                        }

                        PrintWriter printwriter = response.getWriter();
                        printwriter.print(text);
                        printwriter.print(table);
                        printwriter.print(new Break());
                        printwriter.print(new Button(1, "CB", "CBNew", r.getString(teasession._nLanguage, "CBNew"), "window.open('EditCommunity', '_self');"));
                        printwriter.print(new Languages(teasession._nLanguage, request));
                        printwriter.close();*/
        } catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
    }
    //private static Resource r = (new Resource("tea/ui/member/community/Communities")).add("tea/ui/member/community/OrganizingCommunities");
}
