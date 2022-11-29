package tea.ui.util;

import java.io.IOException;
import java.util.Vector;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import tea.db.DbAdapter;
import tea.entity.*;
import tea.entity.member.OnlineList;
import tea.entity.node.UserForm;
import tea.entity.site.Community;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class Logout extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        try
        {
            Http h = new Http(request,response);
            HttpSession session = request.getSession(true);
            //
            h.setCook("member","NULL",0);
            h.setCook("autologin","NULL",0);
            Cookie cook = new Cookie("editmode","");
            cook.setPath("/");
            cook.setMaxAge(0);
            response.addCookie(cook);
            if(h.member > 0)
            {
                DbAdapter db = new DbAdapter();
                try
                {
                    db.executeUpdate("UPDATE OnlineList SET member=''  WHERE member=" + DbAdapter.cite(h.username));
                } finally
                {
                    db.close();
                }
            }
            ServletContext application = getServletContext();
            String member = (String) session.getAttribute("username");

            System.out.println("用户网站退出：用户：" + session.getAttribute("username") + "--成功退出聊天室");

            if(application.getAttribute("myuser") != null)
            {
                Vector temp = (Vector) application.getAttribute("myuser");

                for(int i = 0;i < temp.size();i++)
                {
                    UserForm mylist = (UserForm) temp.elementAt(i);
                    if(mylist.username.equals(member))
                    {
                        temp.removeElementAt(i);
                        session.setAttribute("username","null");
                    }
                    if(temp.size() == 0)
                    {
                        application.removeAttribute("message");
                    }
                }
            }

            session.removeAttribute("member");
            session.removeAttribute("messageclose"); //Reminder.jsp
            OnlineList obj = OnlineList.find(session.getId());
            obj.setMember(null);

//            String s = request.getParameter("nexturl");
//            if(s == null)
//            {
//                s = "/servlet/Node?node=" + teasession._nNode + "&em=0&language=" + teasession._nLanguage;
//            }
            Community c = Community.find(h.community);

            String nexturl = h.get("nexturl","/servlet/Node?node=" + (c.getLogin() > 0 ? c.getLogin() : c.getNode()) + "&em=0&language=" + h.language);

            response.sendRedirect(nexturl);
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }
}
