package tea.ui.node.type.chat;

import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.node.Chat;
import tea.entity.node.Node;
import tea.html.*;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class ChatRoom extends TeaServlet
{

    public ChatRoom()
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

            String qs = request.getQueryString();
            qs = qs == null ? "" : "?" + qs;
            response.sendRedirect("/jsp/type/chat/ChatRoom.jsp" + qs);
            /*
            Node.find(teasession._nNode);
            PrintWriter printwriter = new PrintWriter(new OutputStreamWriter(response.getOutputStream()));
            printwriter.println("<HTML><HEAD><META HTTP-EQUIV=Content-Type CONTENT=\"text/html; charset=" + TeaServlet.CHARSET[teasession._nLanguage] + "\">" + "<LINK REL=StyleSheet HREF=/tea/tea.css TYPE=text/css MEDIA=screen>" + "<SCRIPT LANGUAGE=JAVASCRIPT SRC=/tea/tea.js></SCRIPT>" + "</HEAD>");
            printwriter.print(getSections(teasession._nNode, teasession._rv, teasession._nLanguage, 11, false));
            Chat.create(teasession._nNode, teasession._rv, 0, new RV("", ""));
            int i = 0;
            do
            {
                boolean flag = false;
                for (Enumeration enumeration = Chat.find(teasession._nNode, teasession._rv, i); enumeration.hasMoreElements(); )
                {
                    i = ((Integer) enumeration.nextElement()).intValue();
                    Chat chat = Chat.find(i);
                    RV rv = chat.getFrom();
                    String s = rv.toString();
                    int j = chat.getAction();
                    switch (j)
                    {
                    case 0: // '\0'
                        printwriter.print(new Script("enterMember('" + s + "');"));
                        break;

                    case 1: // '\001'
                        printwriter.print(new Script("leaveMember('" + s + "');"));
                        break;

                    default:
                        printwriter.print(rv);
                        RV rv1 = chat.getTo();
                        rv1.toString();
                        printwriter.print(super.r.getString(teasession._nLanguage, Chat.CHAT_ACTION[j]));
                        printwriter.print(hrefCall(rv1));
                        printwriter.print(" (" + (new SimpleDateFormat("MM.dd HH:mm")).format(chat.getTime()) + ") ");
                        if (chat.getPictureFlag())
                        {
                            printwriter.print(new Image("ChatPicture?Chat=" + i, chat.getAlt(teasession._nLanguage), chat.getAlign()));
                        }
                        printwriter.print(chat.getText(teasession._nLanguage));
                        if (chat.getVoiceFlag())
                        {
                            printwriter.print(new Anchor("ChatVoice?Chat=" + i, super.r.getCommandImg(teasession._nLanguage, "Play")));
                        }
                        if (chat.getFileFlag())
                        {
                            printwriter.print(new Anchor("ChatFile?Chat=" + i, super.r.getCommandImg(teasession._nLanguage, "Download")));
                        }
                        printwriter.print(new Break(2));
                        break;
                    }
                    printwriter.print(new Script("self.scrollBy(0,801);"));
                    printwriter.flush();
                    flag = true;
                }

                if (!flag)
                {
                    printwriter.print(" ");
                    printwriter.flush();
                }
                if (printwriter.checkError())
                {
                    break;
                }
                try
                {
                    Thread.currentThread();
                    Thread.sleep(5000L);
                } catch (Exception exception1)
                {
                    exception1.printStackTrace();
                }
            } while (true);
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
      //  super.r.add("tea/ui/node/type/chat/ChatRoom");
    }
}
