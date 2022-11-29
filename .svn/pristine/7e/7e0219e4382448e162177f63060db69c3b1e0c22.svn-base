// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2003-6-30 20:03:54
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   TalkbackServlet.java

package tea.ui.node.talkback;

import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.node.Node;
import tea.entity.node.Talkback;
import tea.html.*;
import tea.htmlx.HintImg;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class TalkbackServlet extends TeaServlet
{

    public TalkbackServlet()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        try
        {
String qs=request.getQueryString();
qs=qs==null?"":"?"+qs;
response.sendRedirect("/jsp/talkback/Talkback.jsp"+qs);
/*
            TeaSession teasession = new TeaSession(request);
            Node node = Node.find(teasession._nNode);
            boolean flag = node.isCreator(teasession._rv);
            int i = Integer.parseInt(request.getParameter("Talkback"));
            Talkback talkback = Talkback.find(i);
            if(flag)
                talkback.read();
            RV rv = talkback.getCreator();
            Table table = new Table();
            Row row = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Poster") + ":"), true));
            try
            {
                row.add(new Cell(hrefGlanceWithName(rv, teasession._nLanguage,request.getContextPath())));
            }
            catch(Exception exception1) { }
            table.add(row);
            Row row1 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Time") + ":"), true));
            row1.add(new Cell(new Text("<font>" + (new SimpleDateFormat("yyyy.MM.dd HH:mm aaa")).format(talkback.getTime()) + "</font>")));
            table.add(row1);
            Row row2 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Subject") + ":"), true));
            row2.add(new Cell(new Text(new HintImg(teasession._nLanguage, talkback.getHint()) + "<font>" + talkback.getSubject(teasession._nLanguage) + "</font>")));
            table.add(row2);
            PrintWriter printwriter = response.getWriter();
            printwriter.print(node.getAncestor(teasession._nLanguage, "Path"));
            printwriter.print(table);
            String picturefile1 =getServletContext().getRealPath("/tea/image/talkback/"+i+".jpg");
            File file1=new File(picturefile1);
			if (file1.exists())
			{
			   Image image1 = new Image("/tea/image/talkback/" + i+".jpg");
               				  printwriter.print(image1);

			  }
          	  printwriter.print("<br>");

			  printwriter.print("<font>" + talkback.getContent(teasession._nLanguage) + "</font>");

            if(talkback.getVoiceFlag())
                printwriter.print(new Button(1, "CB", "CBPlay", super.r.getString(teasession._nLanguage, "CBPlay"), "window.open('TalkbackVoice?node=" + teasession._nNode + "&Talkback=" + i + "', '_self');"));
            if(talkback.getFileFlag())
                printwriter.print(new Button(1, "CB", "CBDownload", super.r.getString(teasession._nLanguage, "CBDownload"), "window.open('TalkbackFile?node=" + teasession._nNode + "&Talkback=" + i + "', '_self');"));
            printwriter.print(new Break());
            printwriter.print(new Break());
            if(teasession._rv != null)
            {
                boolean flag1 = rv.equals(teasession._rv);
                if(flag1)
                    printwriter.print(new Button(1, "CB", "CBEdit", super.r.getString(teasession._nLanguage, "CBEdit"), "window.open('EditTalkback?node=" + teasession._nNode + "&Talkback=" + i + "', '_self');"));
                if(flag1 || flag)
                    printwriter.print(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDelete") + "')){window.open('DeleteTalkback?node=" + teasession._nNode + "&Talkback=" + i + "', '_self')};"));
            }
            printwriter.print(new Button(1, "CB", "CBForward", super.r.getString(teasession._nLanguage, "CBForward"), "window.open('ForwardTalkback?node=" + teasession._nNode + "&Talkback=" + i + "', '_blank');"));
            printwriter.print(new Button(1, "CB", "CBReplyToCreator", super.r.getString(teasession._nLanguage, "CBReplyToCreator"), "window.open('ReplyTalkback?node=" + teasession._nNode + "&Talkback=" + i + "', '_blank');"));
            printwriter.print(new Break());
            printwriter.print(new Text("<HR SIZE=1>"));
            int j = talkback.findNext();
            if(j != 0)
            {
                printwriter.print(new Text(super.r.getString(teasession._nLanguage, "Previous") + ": "));
                printwriter.print(Talkback.find(j).getAnchor(teasession._nLanguage, "TalkbackIndex"));
                printwriter.print(new Break());
            }
            int k = talkback.findPrev();
            if(k != 0)
            {
                printwriter.print(new Text(super.r.getString(teasession._nLanguage, "Next") + ": "));
                printwriter.print(Talkback.find(k).getAnchor(teasession._nLanguage, "TalkbackIndex"));
                printwriter.print(new Break());
            }
            printwriter.print(new Break());
            printwriter.print(new Languages(teasession._nLanguage, request));
            printwriter.close();*/
        }
        catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
    }

    public void init(ServletConfig servletconfig)
        throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/node/talkback/TalkbackServlet");
    }
}
