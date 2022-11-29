package tea.ui.im;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.entity.*;
import tea.db.*;
import java.util.regex.*;
import tea.entity.im.*;
import tea.entity.node.access.*;

public class EditImMessage extends HttpServlet
{

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        HttpSession session = request.getSession();
        try
        {
            TeaSession teasession = new TeaSession(request);
//            if (teasession._rv == null)
//            {
//                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(request.getRequestURI() + "?" + request.getQueryString(), "UTF-8"));
//                return;
//            }
            String act = request.getParameter("act");
            if ("ajax".equals(act))
            {
                PrintWriter out = response.getWriter();
                String sid = session.getId();
                String ip = request.getRemoteAddr();
                String me = (teasession._rv == null) ? ip : teasession._rv._strV;
                String content = request.getParameter("content");
                if (content != null)
                {
                    String tmember = request.getParameter("tmember");
                    if (me.equals(tmember))
                    {
                        out.print("<div class=error>不能发送消息给自已...</div>");
                    } else
                    {
                        ImMessage.create(teasession._strCommunity, sid, me, tmember, content, ip);
                    }
                }
                int last = 0;
                Integer inte = (Integer) session.getAttribute("tea.immessage");
                if (inte != null)
                {
                    last = inte.intValue();
                }
                Enumeration e = ImMessage.find(teasession._strCommunity, " AND immessage>" + last + " AND reader=0 AND (fmember=" + DbAdapter.cite(me) + " OR tmember=" + DbAdapter.cite(me) + " OR tmember='')", 0, Integer.MAX_VALUE);
                if (e.hasMoreElements())
                {
                    StringBuilder js = new StringBuilder();
                    int id = 0;
                    while (e.hasMoreElements())
                    {
                        ImMessage obj = (ImMessage) e.nextElement();
                        id = obj.getImMessage();
                        String fmember = obj.getFMember();
                        ip = obj.getIp();
                        String tmember = obj.getTMember();
                        boolean isMe = me.equals(fmember);
                        out.print("<span class=member style=color:#4A6FB5;line-height:120%;>" + (isMe ? "我" : fmember) + " 说:</span>");
                        out.print("<div class=content style=margin-top:0px;width:310px;word-break:break-all;color:#8B8B8B;>" + obj.getContent() + "</div>");
                        if (!isMe) // tmember.length() == 0 || me.equals(tmember)) //没有收件人 或  收件人是我
                        {
                            obj.setReader();
                            String addr = NodeAccessWhere.findByIp(ip);
                            String title = "地区:" + addr + "&#13;I P:" + ip;
                            js.append("im_add('" + fmember + "','<input name=tmember type=radio value=" + fmember + " id=f" + id + "><label for=f" + id + " title=\"" + title + "\">" + fmember + "</label> ( " + addr + " )');");
                        }
                    }
                    session.setAttribute("tea.immessage", new Integer(id));
                    out.print("<script>");
                    out.print(js.toString());
                }
//                e = ImMessage.findByTMember(teasession._strCommunity, from, " AND time>" + DbAdapter.cite(new Date(System.currentTimeMillis() - 1000L * 60 * 30)));
//                for (int i = 0; e.hasMoreElements(); i++)
//                {
//                    from = (String) e.nextElement();
//                    StringBuilder sb = new StringBuilder();
//                    int id = ((Integer) ImMessage.find(teasession._strCommunity, " AND fmember=" + DbAdapter.cite(from), 0, 1).nextElement()).intValue();
//                    ImMessage im = ImMessage.find(id);
//                    String ip = im.getIp();
//                    String addr = NodeAccessWhere.findByIp(ip);
//                    sb.append("地区:").append(addr);
//                    sb.append("I P:").append(ip);
//                    out.print("<input name=tmember type=radio id=f" + i + "><label for=f" + i + " title=" + sb.toString() + ">" + from + "</label> ( " + addr + " )<br>");
//                }
                out.close();
                return;
            }
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }

}
