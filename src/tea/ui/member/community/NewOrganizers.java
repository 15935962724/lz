package tea.ui.member.community;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.StringTokenizer;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//import tea.entity.RV;
import tea.entity.member.Profile;
import tea.entity.site.Organizer;
import tea.html.*;
import tea.htmlx.Languages;
import tea.http.RequestHelper;
//import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class NewOrganizers extends TeaServlet
{

    public NewOrganizers()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            String s = request.getParameter("community");
            if (!teasession._rv.isWebMaster() && !teasession._rv.isOrganizer(s))
            {
                response.sendError(403);
                return;
            }
            if (request.getMethod().equals("GET"))
            {
                response.sendRedirect("/jsp/community/NewOrganizers.jsp?Community=" + s);
                /*
                                Form form = new Form("foNew", "POST", "NewOrganizers");
                                form.setOnSubmit("return(submitText(this.Members,'" + super.r.getString(teasession._nLanguage, "InvalidMemberIds") + "'));");
                                form.add(new HiddenField("Community", s));
                                form.add(new Text(super.r.getString(teasession._nLanguage, "MemberId") + ":"));
                                form.add(new TextField("Members"));
                                form.add(new Button(super.r.getString(teasession._nLanguage, "Submit")));
                                PrintWriter printwriter = response.getWriter();
                                printwriter.print(form);
                                printwriter.print(new Script("document.foNew.Members.focus();"));
                                printwriter.print(new Languages(teasession._nLanguage, request));
                                printwriter.close();
                 */
            } else
            {
                String s1;
                for (StringTokenizer stringtokenizer = new StringTokenizer(request.getParameter("Members").trim().toLowerCase(), " ,"); stringtokenizer.hasMoreTokens(); Organizer.create(s, s1))
                {
                    s1 = stringtokenizer.nextToken();
                    if (!Profile.isExisted(s1))
                    {
                        outText(teasession, response, RequestHelper.format(super.r.getString(teasession._nLanguage, "InvalidMember"), s1));
                        return;
                    }
                }

                response.sendRedirect("/jsp/community/Organizers.jsp?community=" + s);
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
        super.r.add("tea/ui/member/community/NewOrganizers");
    }
}
