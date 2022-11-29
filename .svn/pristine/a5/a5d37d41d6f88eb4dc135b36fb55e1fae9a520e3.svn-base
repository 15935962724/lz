// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2004-10-9 15:10:55
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   SendToMeeting.java

package tea.ui.member.meeting;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Meeting;
import tea.html.*;
import tea.htmlx.FileInput;
import tea.htmlx.Languages;
import tea.http.MultipartRequest;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class SendToMeeting extends TeaServlet
{

    public SendToMeeting()
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
            String s = teasession.getParameter("To");
            if(request.getMethod().equals("GET"))
            {
                String qs = request.getQueryString();
                qs = qs == null ? "" : "?" + qs;
                response.sendRedirect("/jsp/meeting/SendToMeeting.jsp" + qs);

                /*   Form form = new Form("foSend", "POST", "SendToMeeting");
                   form.setMultiPart(true);
                   form.setOnSubmit("this.Text.value=this.Buffer.value;this.Buffer.value='';return(true);");
                   form.add(new HiddenField("To", s));
                   Table table = new Table();
                   Row row = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Text") + ":"), true));
                   Cell cell = new Cell(new TextField("Buffer", "", 60, 255));
                   cell.add(new Button("Submit", super.r.getString(teasession._nLanguage, "Submit"), "this.form.Buffer.focus();"));
                   cell.add(new Button(1, "HangUp", super.r.getString(teasession._nLanguage, "HangUp"), "window.location='HangUpMeeting'"));
                   row.add(cell);
                   table.add(row);
                   table.add(new FileInput(teasession._nLanguage, "Picture"));
                   table.add(new FileInput(teasession._nLanguage, "Voice"));
                   table.add(new FileInput(teasession._nLanguage, "File"));
                   form.add(new HiddenField("Text"));
                   form.add(table);
                   outText(teasession,response, form.toString() + new Languages(teasession._nLanguage, request));
                 */
            } else
            {
                String s1 = teasession.getParameter("Text");
                byte abyte0[] = teasession.getBytesParameter("Picture");
                String s2 = "";
                int i = 1;
                byte abyte1[] = teasession.getBytesParameter("Voice");
                String s3 = teasession.getParameter("FileName");
                byte abyte2[] = teasession.getBytesParameter("File");
                boolean flag = abyte0 != null || abyte1 != null || abyte2 != null;
                if(s1.trim().length() != 0 || flag)
                    Meeting.create(teasession._rv,new RV(s),2,teasession._nLanguage,s1,abyte0,s2,i,abyte1,s3,abyte2);
                if(flag)
                    response.sendRedirect("SendToMeeting?To=" + s);
                else
                    response.sendError(204);
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
        super.r.add("tea/ui/member/meeting/SendToMeeting");
    }
}
