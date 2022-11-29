// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2004-9-23 11:01:54
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   Feedbacks.java

package tea.ui.member.feedback;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
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

public class Feedbacks extends TeaServlet
{

    public Feedbacks()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        try
        {
            String qs = request.getQueryString();
            qs = qs == null ? "" : "?" + qs;
            response.sendRedirect("/jsp/feedback/Feedbacks.jsp" + qs);
            /*
                        TeaSession teasession = new TeaSession(request);
                        String s = request.getParameter("Member");
                        if(s == null)
                            if(teasession._rv != null)
                            {
                                s = teasession._rv._strR;
                            } else
                            {
                                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                                return;
                            }
                        Text text = new Text(hrefGlance(teasession._rv) + ">" + super.r.getString(teasession._nLanguage, "Feedbacks"));
                        text.setId("PathDiv");
                        String s1 = request.getParameter("Pos");
                        int i = s1 != null ? Integer.parseInt(s1) : 0;
                        int j = Feedback.count(s);
                        Table table = new Table();
                        table.setCaption(j + " " + super.r.getString(teasession._nLanguage, "Feedbacks"));
                        if(j != 0)
                        {
                            Row row;
                            for(Enumeration enumeration = Feedback.find(s, i, 25); enumeration.hasMoreElements(); table.add(row))
                            {
                                int k = ((Integer)enumeration.nextElement()).intValue();
                                Feedback feedback = Feedback.find(k);
                                RV rv = feedback.getRV();
                                row = new Row(new Cell(new Anchor("Feedback?Member=" + s + "&Feedback=" + k, new Text(new HintImg(teasession._nLanguage, feedback.getHint()) + feedback.getSubject(teasession._nLanguage)))));
                                row.add(new Cell(hrefGlance(rv)));
                                if(teasession._rv != null && teasession._rv.equals(rv) || teasession._rv.isWebMaster())
                                    row.add(new Cell(new Anchor("DeleteFeedback?Member=" + s + "&Feedback=" + k, super.r.getCommandImg(teasession._nLanguage, "Delete"), "return(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDelete") + "'));")));
                            }

                        }
                        PrintWriter printwriter = response.getWriter();
                        printwriter.print(text);
                        printwriter.print(table);
                        if(teasession._rv != null && teasession._rv.isWebMaster())
                            printwriter.print(new Anchor("DeleteAllFeedbacks?Member=" + s, super.r.getCommandImg(teasession._nLanguage, "DeleteAll"), "return(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDeleteAll") + "'));"));
                        printwriter.print(new Anchor("NewFeedback?Member=" + s, super.r.getCommandImg(teasession._nLanguage, "PostFeedback")));
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
        super.r.add("tea/ui/member/feedback/Feedbacks");
    }
}
