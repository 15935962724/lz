package tea.ui.member.meeting;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Meeting;
import tea.html.*;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import java.io.OutputStreamWriter;

public class Call extends TeaServlet
{

    public Call()
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
            response.setContentType("text/html;charset=UTF-8");
            String s = request.getParameter("Receiver");
            String community = request.getParameter("community");
            String s1 = request.getParameter("InviteToChat");
            boolean flag = s1 != null;
//            PrintWriter printwriter = response.getWriter();
            PrintWriter printwriter = new PrintWriter(new OutputStreamWriter(response.getOutputStream()));
            printwriter.print("<HTML><HEAD><SCRIPT LANGUAGE=JAVASCRIPT SRC=\"/tea/tea.js\"></SCRIPT><link href=\""+request.getContextPath()+"/res/"+tea.entity.node.Node.find(teasession._nNode).getCommunity() +"/cssjs/community.css\" rel=\"stylesheet\" type=\"text/css\"><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"></HEAD><body><div id=head6><img SRC=about:blank height=6></div>");
            if (s == null)
            {
                Form form = new Form("foCall", "GET", "Call");
                form.setOnSubmit("return(submitText(this.Receiver,'" + super.r.getString(teasession._nLanguage, "InvalidReceiver") + "'));");
                if (flag)
                {
                    form.add(new HiddenField("InviteToChat", s1));
                }
                form.add(new TextField("Receiver"));
                form.add(new Button("Call"));
                printwriter.print(form);
                printwriter.print(new Languages(teasession._nLanguage, request));
            } else
            {
                printwriter.print("<bgsound src=\"/tea/audio/ringout.au\" loop=infinite>"+r.getString(teasession._nLanguage,"Wait"));
                printwriter.flush();
                Meeting meeting = Meeting.create(teasession._rv, new RV(s,community), 0, 0, s1, null, null, 0, null, null, null);
                String s2 = "DivertCall?Receiver=" + s;
                int i = 0;
                do
                {
                    try
                    {
                        Thread.currentThread();
                        //Thread.sleep(10000L);
                        Thread.sleep(5000L);
                    } catch (Exception _ex)
                    {}
                    RV rv = Meeting.getAcker(teasession._rv);
                    if (rv == null)
                    {
                        continue;
                    }
                    if (flag)
                    {
                        s2 = "ChatFrameSet?node=" + s1;
                    } else
                    {
                        s2 = "MeetingFrameSet?To=" + rv;
                    }
                    break;
                } while (++i < 10);//5);
                meeting.delete();
                printwriter.print(new Script("window.location='" + s2 + "';"));
            }
            printwriter.close();
//            printwriter.close();
        } catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/member/meeting/Call");
    }
}
