package tea.ui.member;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.ui.TeaSession;
import tea.entity.*;
import tea.entity.member.*;


public class FriendLists extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html;charset=utf-8");
        Http h = new Http(request,response);
        PrintWriter out = response.getWriter();
        try
        {
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                out.print("<script>top.location='/servlet/StartLogin?node=" + h.node + "';</script>");
                return;
            }
            h.username = teasession._rv.toString();
            //
            String act = h.get("act"),nexturl = h.get("nexturl","");
            out.print("<script>var mt=parent.mt;</script>");
            if("add".equals(act))
            {
                String member = h.get("member");
                if(!Profile.isExisted(member))
                {
                    out.print("<script>alert('不存在此用户!');</script>");
                    return;
                }
                if(h.username.equalsIgnoreCase(member))
                {
                    out.print("<script>alert('自己不能添加自己为好友!');</script>");
                    return;
                }
                FriendList fl = new FriendList(h.username,member);
                fl.time = new Date();
                out.print("<script>alert('" + (fl.set() ? "好友添加成功！" : "已经是好友，不用重复添加!") + "');var a='" + nexturl + "';if(a)parent.location=a;</script>");
                return;
            } else if("del".equals(act))
            {
                new FriendList(h.username,h.get("member")).delete();
            } else if("remark".equals(act))
            {
                new FriendList(h.username,h.get("member")).set("remark",h.get("remark"));
            }
            out.print("<script>mt.show('数据操作成功！',1,'" + nexturl + "')</script>");
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        } finally
        {
            out.close();
        }
    }
}
