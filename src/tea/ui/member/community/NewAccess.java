package tea.ui.member.community;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.StringTokenizer;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Profile;
import tea.entity.site.GrantAccess;
import tea.html.*;
import tea.htmlx.Languages;
import tea.http.RequestHelper;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class NewAccess extends TeaServlet
{

    public NewAccess()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession;
        try
        {
            teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            String s = request.getParameter("Community");
            if (!teasession._rv.isWebMaster() && !teasession._rv.isOrganizer(s) && !teasession._rv.isManager(s))
            {
                response.sendError(403);
                return;
            }

            if (request.getMethod().equals("GET"))
            {
                response.sendRedirect("/jsp/community/NewAccess.jsp?Community=" + s);
                /*
                             Form form = new Form("foNew", "POST", "NewAccess");
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
                return;
            } else
            {
                StringTokenizer stringtokenizer = new StringTokenizer(request.getParameter("Members"), " ,");
                while (stringtokenizer.hasMoreTokens())
                {
                    String s1 = stringtokenizer.nextToken();
                    if (!Profile.isExisted(s1))
                    {
                        outText(response, teasession._nLanguage, RequestHelper.format(super.r.getString(teasession._nLanguage, "InvalidMember"), s1));
                        return;
                    }
                    GrantAccess.create(s, s1);
                }
                response.sendRedirect("Manager?Community=" + s);
            }
        } catch (Exception e)
        {
            e.printStackTrace();
            response.sendError(404, e.getMessage());
        }
    }
}
