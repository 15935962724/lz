package tea.ui.member.message;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.member.Message;
import tea.entity.member.MessageRead;
import tea.html.*;
import tea.htmlx.FPNL;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class MessageReaders extends TeaServlet
{

    public MessageReaders()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            response.sendRedirect("/jsp/message/MessageReaders.jsp?"+request.getQueryString());
            /*
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            String s = request.getParameter("Folder");
            int i = Integer.parseInt(request.getParameter("Message"));
            Message message = Message.find(i);
            Text text = new Text(hrefGlance(teasession._rv) + ">" + new Anchor("MessageFolders", super.r.getString(teasession._nLanguage, "MessageFolders")) + ">" + new Anchor("Messages?Folder=" + s, new Text(super.r.getString(teasession._nLanguage, s))) + "><font>" + message.getSubject(teasession._nLanguage) + "</font>");
            text.setId("PathDiv");
            String s1 = request.getParameter("Pos");
            int j = s1 == null ? 0 : Integer.parseInt(s1);
            Table table = new Table();
            int k = MessageRead.count(i);
            table.setCaption(k + "  " + super.r.getString(teasession._nLanguage, "MessageReaders"));
            if (k != 0)
            {
                Row row;
                for (Enumeration enumeration = MessageRead.find(i, j, 25); enumeration.hasMoreElements(); table.add(row))
                {
                    MessageRead messageread = (MessageRead) enumeration.nextElement();
                    row = new Row(new Cell(getRvDetail(messageread.getReader(), teasession._nLanguage, request.getContextPath())));
                    row.add(new Cell(" <font>" + (new SimpleDateFormat("yyyy.MM.dd hh:mm aaa")).format(messageread.getTime()) + "</font>"));
                }

            }
            PrintWriter printwriter = response.getWriter(); // beginOut(response, teasession);
            printwriter.print(text);
            printwriter.print(table);
            printwriter.print(new FPNL(teasession._nLanguage, "MessageReaders?Folder=" + s + "&Message=" + i + "&Pos=", j, k));
            printwriter.print(new Languages(teasession._nLanguage, request));
            printwriter.close(); //printwriter.close();
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
        super.r.add("tea/ui/member/message/MessageFolders").add("tea/ui/member/message/Messages").add("tea/ui/member/message/MessageServlet").add("tea/ui/member/message/MessageReaders");
    }
}
