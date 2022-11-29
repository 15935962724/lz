package tea.ui.member.community;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.StringTokenizer;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Profile;
import tea.entity.node.Node;
import tea.entity.site.Provider;
import tea.html.*;
import tea.htmlx.Languages;
import tea.http.RequestHelper;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditProvider extends TeaServlet
{

    public EditProvider()
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
                String s1 = request.getParameter("Member");

                StringBuilder sb = new StringBuilder("?");
                java.util.Enumeration enumeration = request.getParameterNames();
                while (enumeration.hasMoreElements())
                {
                    String str = enumeration.nextElement().toString();
                    sb.append(str + "=" + request.getParameter(str) + "&");
                }
                response.sendRedirect("/jsp/community/EditProvider.jsp" + sb.toString());

                /* boolean flag = s1 == null;
                   int k = 0;
                                int i1 = 0;
                                if(!flag)
                                {
                                    Provider provider = Provider.find(s, s1);
                                    k = provider.getProviders0();
                                    i1 = provider.getProviders1();
                                }
                                Form form = new Form("foEdit", "POST", "EditProvider");
                                form.setOnSubmit("return(submitText(this.Members,'" + super.r.getString(teasession._nLanguage, "InvalidMemberIds") + "'));");
                                form.add(new HiddenField("Community", s));
                                form.add(new Text(super.r.getString(teasession._nLanguage, "MemberId") + ":"));
                                if(!flag)
                                {
                                    form.add(new Text(s1));
                                    form.add(new HiddenField("Members", s1));
                                } else
                                {
                                    form.add(new TextField("Members", s1));
                                }
                                form.add(new Break());
                                for(int j1 = 0; j1 < Node.NODE_TYPE.length; j1++)
                                {
                                    form.add(new CheckBox(Node.NODE_TYPE[j1], ((j1 >= 32 ? i1 : k) & 1 << j1 % 32) != 0));
                                    form.add(new Text(super.r.getString(teasession._nLanguage, Node.NODE_TYPE[j1]) + " "));
                                }

                                form.add(new Break());
                                form.add(new Button(super.r.getString(teasession._nLanguage, "Submit")));
                                PrintWriter printwriter = response.getWriter();
                                printwriter.print(form);
                                if(flag)
                                    printwriter.print(new Script("document.foEdit.Members.focus();"));
                                printwriter.print(new Languages(teasession._nLanguage, request));
                                printwriter.close();*/
            } else
            {
                int i = 0;
                int j = 0;
                for (int l = 0; l < Node.NODE_TYPE.length; l++)
                {
                    if (request.getParameter(Node.NODE_TYPE[l]) != null)
                    {
                        if (l < 32)
                        {
                            i |= 1 << l;
                        } else
                        {
                            j |= 1 << l % 32;
                        }
                    }
                }

                String s2;
                for (StringTokenizer stringtokenizer = new StringTokenizer(request.getParameter("Members"), " ,"); stringtokenizer.hasMoreTokens(); Provider.create(s, s2, i, j))
                {
                    s2 = stringtokenizer.nextToken();
                    if (!Profile.isExisted(s2))
                    {
                        outText(teasession, response, RequestHelper.format(super.r.getString(teasession._nLanguage, "InvalidMember"), s2));
                        return;
                    }
                }
                String nexturl = request.getParameter("nexturl");
                if (nexturl == null)
                {
                    nexturl = request.getContextPath() + "/jsp/community/Providers.jsp?community=" + s;
                }
                response.sendRedirect(nexturl);
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
        super.r.add("tea/ui/member/community/EditProvider");
    }
}
