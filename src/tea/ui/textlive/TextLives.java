package tea.ui.textlive;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.entity.Http;
import tea.entity.MT;
import tea.entity.textlive.TextLive;

public class TextLives extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        
        PrintWriter out = response.getWriter();
        try
        {
        	if("loadMore".equals(act))
            {
            	String sql = h.get("sql");
            	int pagePos = h.getInt("pagePos");
            	StringBuffer buffer = new StringBuffer();//"<table>"
            	Iterator it=TextLive.find(sql,pagePos,2).iterator();
            	SimpleDateFormat df = new SimpleDateFormat("HH:mm");
            	for(int i=1+pagePos;it.hasNext();i++)
            	{
            		TextLive t=(TextLive)it.next();
            		buffer.append("<tr onMouseOver=\"bgColor='#FFFFCA'\" onMouseOut=\"bgColor=''\">");
            		buffer.append("<td class='td01'>"+MT.f(t.getAuthor())+"</td>");
            		buffer.append("<td class='td02'>"+t.getContent().replaceAll("\r\n","<br/>")+"</td>");
            		buffer.append("<td nowrap class='td03'>"+MT.f(df.format(t.getTime()))+"</td>");
            		buffer.append("</tr>");
            	}
            	//buffer.append("</table>");
            	out.print(buffer.toString());
            	return;
            }
            out.println("<script>var mt=parent.mt,$=parent.$$;</script>");
            if(h.member < 1)
            {
                out.print("<script>top.location.replace('/servlet/StartLogin?community=" + h.community + "');</script>");
                return;
            }
            int textlive = h.getInt("textlive");
            if("edit".equals(act))
            {
                TextLive t = new TextLive(textlive);
                t.setCommunity(h.get("community"));
                t.setAuthor(h.get("author"));
                t.setContent(h.get("content"));
                t.setTime(new Date());
                t.set();
                out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
                return;
            }
             
            {
                String[] ids = textlive < 1 ? h.getValues("textlives") : new String[]
                               {String.valueOf(textlive)};
                if("del".equals(act)) //删除
                {
                    for(int i = 0;i < ids.length;i++)
                    {
                        TextLive.delete(Integer.parseInt(ids[i]));
                    }
                }
            }
            out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
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
