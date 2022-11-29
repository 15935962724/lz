package tea.ui.admin.map;

import java.io.*;
import java.net.*;
import java.awt.image.*;
import javax.imageio.*;
import javax.servlet.*;
import tea.ui.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.admin.map.*;
import tea.entity.util.*;

/**
 * Servlet implementation class for Servlet: EditMapabc
 *
 */
public class EditMapabc extends TeaServlet
{
    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("/tea/resource/Mapabc");
    }

    protected void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(true);
        ServletContext application = getServletContext();
        TeaSession teasession = new TeaSession(request);
        String sid = teasession.getParameter("sid");
        String oper = teasession.getParameter("oper");
        String nexturl = teasession.getParameter("nexturl");
        try
        {
            // 全景图////////////////////////////////////////////////////////////
            String jsid = teasession.getParameter("jsid");
            if(jsid == null)
            {
                jsid = (String) session.getAttribute("map.sessionid");
                if(jsid == null)
                {
                    jsid = Mapabc.getSessionid();
                    session.setAttribute("map.sessionid",jsid);
                }
            }
            if("1".equals(oper)) // 1．创建/修改地图标点
            {
                String name = teasession.getParameter("name");
                String addr = teasession.getParameter("addr");
                String tel = teasession.getParameter("tel");
                String info = teasession.getParameter("info");
                String email = teasession.getParameter("email");
                String keyword = teasession.getParameter("keyword");
                // ////start///
                StringBuilder u = new StringBuilder();
                u.append("http://mc.mapabc.com/newedit/pmiservlet;jsessionid=").append(jsid);
                u.append("?oper=1&type=text&keytpe=343&appname=dn&name=").append(URLEncoder.encode(name,"GBK"));
                u.append("&addr=").append(URLEncoder.encode(addr,"GBK"));
                u.append("&tel=").append(URLEncoder.encode(tel,"GBK"));
                u.append("&info=").append(URLEncoder.encode(info,"GBK"));
                u.append("&email=").append(URLEncoder.encode(email,"GBK"));
                u.append("&keyword=").append(URLEncoder.encode(keyword,"GBK"));
                if(sid != null)
                {
                    u.append("&sid=").append(sid);
                }
                // System.out.println(u.toString());
                String content = ((String) Mapabc.open(u.toString())).trim();
                System.out.println("MAPABC: SID:" + sid + " 返回值:" + content);
                if("parameter deficient".equals(content)) // 必须改变X-Y标点.
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + URLEncoder.encode("1180421882590","UTF-8"));
                    return;
                }
                sid = content.split("&")[2];
                // ////end///
                Mapabc obj = Mapabc.find(sid);
                if(obj.isExists())
                {
                    obj.set(name,addr,tel,info,email,keyword);
                } else
                {
                    Mapabc.create(sid,teasession._strCommunity,teasession._rv._strV,name,addr,tel,info,email,keyword);
                }
                nexturl = "/jsp/admin/map/EditMapabc360.jsp?community=" + teasession._strCommunity + "&sid=" + sid;
            } else if("6".equals(oper)) // 6.数据删除
            {
                Mapabc obj = Mapabc.find(sid);
                StringBuilder u = new StringBuilder();
                u.append("http://mc.mapabc.com/newedit/pmiservlet;jsessionid=").append(jsid);
                u.append("?oper=6&type=text&keytpe=343&appname=dn&sid=").append(obj.getSid());
                String content = (String) Mapabc.open(u.toString());
                // System.out.println(obj.getSid() + ":" + content);
                obj.delete();
            } else if("7".equals(oper)) // 7.标点状态更改
            {
                boolean hidden = "true".equals(request.getParameter("hidden"));
                Mapabc obj = Mapabc.find(sid);
                StringBuilder u = new StringBuilder();
                u.append("http://mc.mapabc.com/newedit/pmiservlet;jsessionid=").append(jsid);
                u.append("?oper=7&type=text&appname=dn&sid=").append(obj.getSid());
                u.append("&state=").append(!hidden);
                String content = (String) Mapabc.open(u.toString());
                // System.out.println(obj.getSid() + ":" + content);
                obj.setHidden(hidden);
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
        response.sendRedirect(nexturl);
    }
}
