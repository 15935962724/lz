package tea.ui.member.community;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.site.Organizer;
import tea.html.*;
import tea.htmlx.FPNL;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class Organizers extends TeaServlet
{

    public Organizers()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }

            String s = request.getParameter("community");
            if(!teasession._rv.isWebMaster() && !teasession._rv.isOrganizer(s))
            {
                response.sendError(403);
                return;
            }
            response.sendRedirect("/jsp/community/Organizers.jsp?" + request.getQueryString());

            /*
                        Text text = new Text(hrefGlance(teasession._rv) + ">" + new Anchor("Communities", super.r.getString(teasession._nLanguage, "Communities")) + ">" + new Anchor("OrganizingCommunities", super.r.getString(teasession._nLanguage, "OrganizingCommunities")) + ">" + s + ":" + super.r.getString(teasession._nLanguage, "Organizers"));
                        String s1 = request.getParameter("Pos");
                        int i = s1 == null ? 0 : Integer.parseInt(s1);
                        int j = Organizer.count(s);



                        Form form = new Form("foDelete", "GET", "DeleteOrganizers");
                        form.add(new HiddenField("Community", s));
                        Table table = new Table();
                        table.setCaption(j + " " + super.r.getString(teasession._nLanguage, "Organizers"));
                        if(j != 0)
                        {
                            boolean flag = true;
                            Row row;
                            for(Enumeration enumeration = Organizer.find(s, i, 25); enumeration.hasMoreElements(); table.add(row))
                            {
                                String s2 = (String)enumeration.nextElement();
                                row = new Row(new Cell(new CheckBox(s2, false)));
                                row.add(new Cell(getRvDetail(s2, teasession._nLanguage,request.getContextPath())));
                                row.add(new HiddenField("Organizers", s2));
                                row.setId(flag ? "OddRow" : "EvenRow");
                                flag = !flag;
                            }

                        }
                        form.add(table);
                        PrintWriter printwriter = response.getWriter();
                        printwriter.print(text);
                        printwriter.print(form);
                        printwriter.print(new FPNL(teasession._nLanguage, "Organizers?Community=" + s + "&Pos=", i, j));
                        printwriter.print(new Button(1, "CB", "CBNew", super.r.getString(teasession._nLanguage, "CBNew"), "window.open('NewOrganizers?Community=" + s + "', '_self');"));
                        if(j != 0)
                        {
                            printwriter.print(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDeleteSelected") + "')){window.open('javascript:foDelete.submit();" + "', '_self');}"));
                            printwriter.print(new Button(1, "CB", "CBDeleteAll", super.r.getString(teasession._nLanguage, "CBDeleteAll"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDeleteAll") + "')){window.open('DeleteAllOrganizers?Community=" + s + "', '_self');}"));
                        }
                        printwriter.print(new Languages(teasession._nLanguage, request));
                        printwriter.close();
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
        super.r.add("tea/ui/member/community/Communities").add("tea/ui/member/community/OrganizingCommunities").add("tea/ui/member/community/Organizers");
    }
}
