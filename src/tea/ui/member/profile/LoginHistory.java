package tea.ui.member.profile;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.html.*;
import tea.htmlx.FPNL;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class LoginHistory extends TeaServlet
{

    public LoginHistory()
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
            String qs = request.getQueryString();
            qs = qs == null ? "" : "?" + qs;
            response.sendRedirect("/jsp/profile/LoginHistory.jsp" + qs);
            /*
                        Text text = new Text(hrefGlance(teasession._rv) + ">" + new Anchor("Profile", super.r.getString(teasession._nLanguage, "Profile")) + ">" + super.r.getString(teasession._nLanguage, "LoginHistory"));
                        text.setId("PathDiv");
                        String s = request.getParameter("Pos");
                        int i = s == null ? 0 : Integer.parseInt(s);
                        Table table = new Table();
                        table.setTitle(super.r.getString(teasession._nLanguage, "MemberId") + "\n" + " &nbsp;" + "\n" + super.r.getString(teasession._nLanguage, "Time") + "\n" + " &nbsp;" + "\n" + super.r.getString(teasession._nLanguage, "Type") + "\n" + " &nbsp;" + "\n");
                        Row row;
                        for(Enumeration enumeration = Log.find(teasession._rv, i, 25); enumeration.hasMoreElements(); table.add(row))
                        {
                            Log log = (Log)enumeration.nextElement();
                            row = new Row(new Cell(new Text(log.getVMember())));
                            row.add(new Cell(new Text("  ")));
                            row.add(new Cell(new Text("<font>" + (new SimpleDateFormat("yyyy.MM.dd HH:mm")).format(log.getTime()) + "</font>")));
                            row.add(new Cell(new Text("  ")));
                            row.add(new Cell(new Text(super.r.getString(teasession._nLanguage, Log.LOGIN_TYPE[log.getType()]))));
                            row.add(new Cell(new Text("  ")));
                            row.add(new Cell(new Text(log.getLog())));
                        }

                        PrintWriter printwriter = response.getWriter();
                        printwriter.print(text);
                        printwriter.print(table);
                        printwriter.print(new FPNL(teasession._nLanguage, "LoginHistory?Pos=", i, 0x7fffffff));
                        printwriter.print(new Languages(teasession._nLanguage, request));
                        printwriter.close();*/
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/member/profile/ProfileServlet").add("tea/ui/member/profile/LoginHistory");
    }
}
