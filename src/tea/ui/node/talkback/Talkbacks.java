package tea.ui.node.talkback;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.node.Node;
import tea.entity.node.Talkback;
import tea.html.*;
import tea.htmlx.*;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class Talkbacks extends TeaServlet
{

    public Talkbacks()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            response.sendRedirect("/jsp/talkback/Talkbacks.jsp?node=" + teasession._nNode);
            /*
                         Node node = Node.find(teasession._nNode);
                         int i = node.getOptions();
                         boolean flag = (i & 0x8000) != 0;
                         if(teasession._rv == null && !flag)
                         {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
                         }
                         boolean flag1 = node.isCreator(teasession._rv);
                         PrintWriter printwriter = response.getWriter();
                         printwriter.print(node.getAncestor(teasession._nLanguage, "Path"));
                         printwriter.print(getSections(teasession._nNode, teasession._rv, teasession._nLanguage, 10, false));
                         int j = 0;
                         try
                         {
                j = Integer.parseInt(request.getParameter("Pos"));
                         }
                         catch(Exception exception1) { }
                         int k = Talkback.count(teasession._nNode);
                         if(k != 0)
                         {
                Table table = new Table();
                table.setId("TalkbackIndex");
                table.setTitle(" \n" + super.r.getString(teasession._nLanguage, "Subject") + "\n" + " &nbsp;" + "\n" + super.r.getString(teasession._nLanguage, "Time") + "\n" + " &nbsp;" + "\n" + super.r.getString(teasession._nLanguage, "Poster") + "\n");
                Row row;
                for(Enumeration enumeration = Talkback.find(teasession._nNode, j, 25); enumeration.hasMoreElements(); table.add(row))
                {
                    int l = ((Integer)enumeration.nextElement()).intValue();
                    Talkback talkback = Talkback.find(l);
                    RV rv = talkback.getCreator();
                    java.util.Date date = talkback.getTime();
                    talkback.getStatus();
                    row = new Row(new Cell(new HintImg(teasession._nLanguage, talkback.getHint())));
                    row.add(new Cell(talkback.getAnchor(teasession._nLanguage, "TalkbackIndex")));
                    row.add(new Cell(new Text("  ")));
                    row.add(new Cell(new Text("<font>" + (new SimpleDateFormat("yyyy.MM.dd HH:mm aaa")).format(date) + "</font>")));
                    row.add(new Cell(new Text("  ")));
                    try
                    {   if (rv!=null)
                    {
                    row.add(new Cell(hrefGlanceWithName(rv, teasession._nLanguage,request.getContextPath())));
                    }
                    }
                    catch(Exception exception2) {


                  }
                    if(teasession._rv != null && (flag1 || rv.equals(teasession._rv) || teasession._rv.isOrganizer(node.getCommunity()) || teasession._rv.isWebMaster()||teasession._rv.isManager(node.getCommunity())))
                        row.add(new Cell(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDelete") + "')){window.open('DeleteTalkback?node=" + teasession._nNode + "&Talkback=" + l + "', '_self')};")));
                }

                printwriter.print(table);
                printwriter.print(new FPNL(teasession._nLanguage, "Talkbacks?node=" + teasession._nNode + "&Pos=", j, k));
                         }
                         printwriter.print(new Break());
                         if(flag || flag1)
                printwriter.print(new Button(1, "CB", "CBPostTalkback", super.r.getString(teasession._nLanguage, "CBPostTalkback"), "window.open('EditTalkback?node=" + teasession._nNode + "', '_self');"));
                         if(teasession._rv != null && (flag1 || teasession._rv.isOrganizer(node.getCommunity()) || teasession._rv.isWebMaster()|| teasession._rv.isManager(node.getCommunity())))
                printwriter.print(new Button(1, "CB", "CBDeleteAll", super.r.getString(teasession._nLanguage, "CBDeleteAll"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDeleteAll") + "')){window.open('DeleteAllTalkbacks?node=" + teasession._nNode + "', '_self')};"));
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
        super.r.add("tea/ui/node/talkback/Talkbacks");
    }
}
