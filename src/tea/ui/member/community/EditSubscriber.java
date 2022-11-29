package tea.ui.member.community;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.site.Subscriber;
import tea.html.*;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditSubscriber extends TeaServlet
{

    public EditSubscriber()
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
            String s = request.getParameter("Community");
            Subscriber subscriber = Subscriber.find(s, teasession._rv);
            if (request.getMethod().equals("GET"))
            {
                int i = subscriber.getOptions();
                Form form = new Form("foEdit", "POST", "EditSubscriber");
                form.add(new HiddenField("Community", s));
                form.add(new CheckBox("SubscriberOEmailNews", (i & 0x1) != 0));
                form.add(new Text(r.getString(teasession._nLanguage, "SubscriberOEmailNews")));
                form.add(new Button(r.getString(teasession._nLanguage, "Submit")));
                PrintWriter printwriter1 = response.getWriter(); // beginOut(response, teasession);
                printwriter1.print(form);
                printwriter1.print(new Languages(teasession._nLanguage, request));
                printwriter1.close(); // endOut(printwriter1, teasession);
            } else
            {
                int j = 0;
                if (request.getParameter("SubscriberOEmailNews") != null)
                {
                    j |= 0x1;
                }
                subscriber.set(j);
                PrintWriter printwriter = response.getWriter(); // beginOut(response, teasession);
                printwriter.print(r.getString(teasession._nLanguage, "InfSubscriberEdited"));
                printwriter.print(new Languages(teasession._nLanguage, request));
                printwriter.close(); //  printwriter.close();
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
        r.add("tea/ui/member/community/EditSubscriber");
    }
}
