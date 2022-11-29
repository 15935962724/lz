package tea.ui.markplus;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.Attch;
import tea.entity.Http;
import tea.entity.markplus.MarkPlus;

public class EditMarkPlus extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        
        PrintWriter out = response.getWriter();
        try
        {
            int markplus = h.getInt("markplus");
            if("markplus".equals(act))
            {
            	MarkPlus.click(markplus);
            	out.print(true);
                return;
            }
            out.println("<script>var mt=parent.mt,$=parent.$$;</script>");
            if(h.member < 1)
            {
                out.print("<script>top.location.replace('/servlet/StartLogin?community=" + h.community + "');</script>");
                return;
            }
            if("edit".equals(act))
            {
                MarkPlus t = MarkPlus.find(markplus);
                t.setCommunity(h.get("community"));
                t.setName(h.get("name"));
                if(h.getInt("path.attch")>0){
                	t.setPath(h.getInt("path.attch"));
                }
                t.setUnit(h.get("unit"));
                t.setSequence(h.getInt("sequence"));
                t.setTime(new Date());
                t.set();
            }else if("del".equals(act)) //删除
            {
            	String[] ids = markplus < 1 ? h.getValues("markpluses") : new String[]
                    {String.valueOf(markplus)};
                for(int i = 0;i < ids.length;i++)
                {
                	markplus = Integer.parseInt(ids[i]);
                	MarkPlus t = MarkPlus.find(markplus);
                	if(t.getPath()>0){
                		Attch a = Attch.find(t.getPath());
                		a.delete();
                	}                	
                	MarkPlus.delete(markplus);
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
