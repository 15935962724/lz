package tea.ui.member.community;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.site.*;
import tea.html.*;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class Communities extends TeaServlet
{

    public Communities()
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
            response.sendRedirect("/jsp/community/Communities.jsp");
/*
            Text text = new Text(hrefGlance(teasession._rv) + ">" + super.r.getString(teasession._nLanguage, "Communities"));
            text.setId("PathDiv");
            List list = new List();
            list.add(new ListItem(new Anchor("JoiningCommunities", JoinRequest.countJoining(teasession._rv) + " " + super.r.getString(teasession._nLanguage, "JoiningCommunities"))));
            list.add(new ListItem(new Anchor("JoinedCommunities", Subscriber.countJoined(teasession._rv) + " " + super.r.getString(teasession._nLanguage, "JoinedCommunities"))));
            list.add(new ListItem(new Anchor("OrganizingCommunities", Organizer.countOrganizing(teasession._rv) + " " + super.r.getString(teasession._nLanguage, "OrganizingCommunities"))));
            PrintWriter printwriter = response.getWriter(); // beginOut(response, teasession);
            printwriter.print(text);
            printwriter.print(list);
            printwriter.print(new Languages(teasession._nLanguage, request));
            printwriter.close(); //  printwriter.close();
*/
        } catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/member/community/Communities");
    }
}
