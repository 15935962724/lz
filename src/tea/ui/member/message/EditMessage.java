package tea.ui.member.message;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.member.*;
import tea.entity.admin.*;
import tea.service.*;
import tea.ui.*;

public class EditMessage extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        if(teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
            return;
        }
        String act = request.getParameter("act");
        String member = teasession._rv._strV;
        String nexturl;
        int messagefolder = 0;
        String tmp = request.getParameter("messagefolder");
        if(tmp != null)
        {
            messagefolder = Integer.parseInt(tmp);
        }
        int folder = 0;
        tmp = request.getParameter("folder");
        if(tmp != null)
        {
            folder = Integer.parseInt(tmp);
        }
        try
        {
            if("TrashAll".equals(act))
            {
                Iterator e = Message.find(teasession._strCommunity,member,folder,0,Integer.MAX_VALUE);
                while(e.hasNext())
                {
                    int id = ((Integer) e.next()).intValue();
                    Message obj = Message.find(id);
                    obj.setFolder(member,3);
                }
            } else if("DeleteAll".equals(act))
            {
                Iterator e = Message.find(teasession._strCommunity,member,folder,0,Integer.MAX_VALUE);
                while(e.hasNext())
                {
                    int id = ((Integer) e.next()).intValue();
                    Message obj = Message.find(id);
                    obj.setFolder(member,5);
                }
            } else
            {
                String as[] = request.getParameterValues("messages");
                if(as != null)
                {
                    for(int i = 0;i < as.length;i++)
                    {
                        int j = Integer.parseInt(as[i]);
                        Message obj = Message.find(j);
                        if(act.equals("Trash"))
                        {
                            obj.setFolder(member,3);
                        } else if(act.equals("Delete"))
                        {
                            obj.setFolder(member,5);
                        } else if(act.equals("PutInFolder") && messagefolder > 0)
                        {
                            obj.setFolder(member,messagefolder);
                        } else if(act.equals("Block"))
                        {
                            // obj.delete(teasession._rv);
                        } else if(act.equals("Reader"))
                        {
                            obj.setReader(member);
                            IfNotRead.create(j,member);
                        }
                    }
                }
            }
            if(act.equals("PutInFolder") && messagefolder > 0)
            {
                nexturl = "/jsp/message/MessageFolderContents.jsp?community=" + teasession._strCommunity + "&messagefolder=" + messagefolder;
            } else
            {
                nexturl = "/jsp/message/Messages.jsp?community=" + teasession._strCommunity + "&folder=" + folder;
            }
            if(teasession.getParameter("nexturl") != null && teasession.getParameter("nexturl").length() > 0)
            {
                nexturl = teasession.getParameter("nexturl");
            }
            response.sendRedirect(nexturl);
        } catch(Exception exception)
        {
            response.sendError(400,exception.toString());
            exception.printStackTrace();
        }

    }
}
