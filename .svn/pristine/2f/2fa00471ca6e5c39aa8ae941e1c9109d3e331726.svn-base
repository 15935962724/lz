package tea.ui.member.feedback;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Feedback;
import tea.html.*;
import tea.htmlx.HintImg;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class FeedbackServlet extends TeaServlet
{

    public FeedbackServlet()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            String qs = request.getQueryString();
            qs = qs == null ? "" : "?" + qs;
            response.sendRedirect("/jsp/feedback/Feedback.jsp" + qs);

            /*
                        TeaSession teasession = new TeaSession(request);
                        String s = request.getParameter("Member");
                        int i = Integer.parseInt(request.getParameter("Feedback"));
                        Feedback feedback = Feedback.find(i);
                        if(!s.equals(feedback.getMember()))
                        {
                            response.sendError(403);
                            return;
                        }
                        RV rv = feedback.getRV();
                        Table table = new Table();
                        Row row = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Poster") + ":"), true));
                        row.add(new Cell(hrefGlance(rv)));
                        table.add(row);
                        Row row1 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Time") + ":"), true));
                        row1.add(new Cell(new Text((new SimpleDateFormat("MM.dd HH:mm")).format(feedback.getTime()))));
                        table.add(row1);
                        String s1 = new HintImg(teasession._nLanguage, feedback.getHint()) + feedback.getSubject(teasession._nLanguage);
                        Row row2 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Subject") + ":"), true));
                        row2.add(new Cell(new Text(s1)));
                        table.add(row2);
                        Text text = new Text(hrefGlance(s) + ">" + new Anchor("Feedbacks", super.r.getString(teasession._nLanguage, "Feedbacks")) + s1);
                        text.setId("PathDiv");
                        PrintWriter printwriter = response.getWriter();
                        printwriter.print(text);
                        printwriter.print(table);
                        printwriter.print(feedback.getContent(teasession._nLanguage));
                        if(feedback.getPictureFlag())
                            printwriter.print(new Image("FeedbackPicture?Member=" + s + "&Feedback=" + i));
                        if(feedback.getVoiceFlag())
                            printwriter.print(new Anchor("FeedbackVoice?Member=" + s + "&Feedback=" + i, super.r.getCommandImg(teasession._nLanguage, "Play")));
                        if(feedback.getFileFlag())
                            printwriter.print(new Anchor("FeedbackFile?Member=" + s + "&Feedback=" + i, super.r.getCommandImg(teasession._nLanguage, "Download")));
                        if(teasession._rv != null && (teasession._rv.equals(rv) || teasession._rv.isWebMaster()))
                            printwriter.print(new Anchor("DeleteFeedback?Member=" + s + "&Feedback=" + i, super.r.getCommandImg(teasession._nLanguage, "Delete"), "return(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDelete") + "'));"));
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
        super.r.add("tea/ui/member/feedback/Feedbacks").add("tea/ui/member/feedback/FeedbackServlet");
    }
}
