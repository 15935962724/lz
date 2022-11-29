package tea.ui.Consultant;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.entity.Http;
import tea.entity.pm.PoFamousComment;
import tea.entity.pm.PoWakeUpCall;

public class EditFamousComment extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt,$=parent.$$;</script>");
            if(h.member < 1)
            {
                out.print("<script>top.location.replace('/servlet/StartLogin?community=" + h.community + "');</script>");
                return;
            }
            int pfcid = h.getInt("pfcid");
            PoFamousComment pfc = PoFamousComment.find(pfcid);
            if("edit".equals(act))
            {
            	pfc.setCommunity(h.get("community"));
            	pfc.setTitle(h.get("title"));
                pfc.setContent(h.get("content"));
                pfc.setApplyTime(new Date());
                pfc.setMember(h.member);
                pfc.set();
            }else if("del".equals(act)){
				pfc.delete();
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
