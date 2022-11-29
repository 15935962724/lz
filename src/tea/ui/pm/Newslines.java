package tea.ui.pm;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.pm.*;
import javax.servlet.*;
import javax.servlet.http.*;
import sun.misc.BASE64Encoder;

public class Newslines extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        ServletContext application = this.getServletContext();
        PrintWriter out = response.getWriter();
        try
        {
            String url = request.getRequestURI();
            if(url.startsWith("/socket.io/1/websocket/"))
            {
                response.setStatus(101);
                response.addHeader("Upgrade","websocket");
                response.addHeader("Connection","Upgrade");
                response.addHeader("Sec-WebSocket-Accept",new BASE64Encoder().encode(Enc.dec(Enc.SHA1(request.getHeader("Sec-WebSocket-Key") + "258EAFA5-E914-47DA-95CA-C5AB0DC85B11"))));
            } else if(url.startsWith("/socket.io/1/"))
            {
                response.addHeader("Access-Control-Allow-Origin","http://127.0.0.1");
                response.addHeader("Access-Control-Allow-Credentials","true");
                out.print("ZldH74eMESX9gJ57Qm_Y:60:60:websocket,htmlfile,xhr-polling,jsonp-polling");
            } else if("htm".equals(act))
            {
                int size = h.getInt("size");
                String last = null;
                ArrayList al = Newsline.find(" ORDER BY time DESC",0,size);
                for(int i = 0;i < al.size();i++)
                {
                    Newsline t = (Newsline) al.get(i);
                    String time = MT.f(t.time,1);
                    if(!time.substring(0,10).equals(last))
                    {
                        last = time.substring(0,10);
                        if(i > 0)
                            out.print("<div class=separator>以下为 " + (last = time.substring(0,10)) + " 资讯</div>");
                    }
                    out.print("<div class=newsline>");
                    out.print("<table><tr>");
                    out.print("<td class=type><img src=/res/" + h.community + "/newsline/type_" + t.type + ".png>");
                    out.print("<td class=time>" + time.substring(11));
                    out.print("<td class=content>" + t.content);
                    if(t.attch > 0 || t.url != null)
                    {
                        out.print("<td class=url>");
                        if(t.attch > 0)
                        {
                            Attch a = Attch.find(t.attch);
                            out.print("<img src=" + a.path + " onclick=mt.img(src)>");
                        }
                        if(t.url != null)
                        {
                            out.print("<a href='" + t.url + "' target=_blank><img src=/res/" + h.community + "/newsline/url_" + (t.url.contains(".swf") ? 2 : 1) + ".png></a>");
                        }
                    }
                    out.print("</table></div>");
                }
            } else
            {
                out.println("<script>var mt=parent.mt;</script>");
                int newsline = h.getInt("newsline");
                Newsline t = Newsline.find(newsline);
                if("del".equals(act)) //删除
                {
                    t.delete();
                } else if("edit".equals(act)) //编辑
                {
                    t.type = h.getInt("type");
                    t.content = h.get("content");
                    int val = h.getInt("picture.attch");
                    if(val > 0)
                        t.attch = val;
                    t.url = h.get("url");
                    t.time = h.getDate("time");
                    t.set();
                }
                out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
            }
        } catch(Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
