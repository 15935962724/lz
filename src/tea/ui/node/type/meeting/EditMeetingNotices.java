package tea.ui.node.type.meeting;

import java.io.IOException;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.Http;
import tea.entity.node.MeetingNotice;

public class EditMeetingNotices extends HttpServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        java.io.PrintWriter out = response.getWriter();

        try
        {
            Http h = new Http(request,response);
            String act = h.get("act");
            String nexturl = h.get("nexturl");
            
            String info = "操作执行成功！";
            out.println("<script>var mt=parent.mt;</script>");
            
            int id = h.getInt("id");
            MeetingNotice mn = MeetingNotice.find(id);
            if(act.equals("edit"))
            {
            	mn.setNode(h.getInt("node"));
                mn.setTitle(h.get("title"));
                mn.setContent(h.get("content"));
                mn.setTime(new Date());
                mn.set();
            	//out.print("<script language='javascript'>alert('操作成功');window.open('" + nexturl + "','_parent');</script> ");
				//return;
            }else if(act.equals("del")){
            	mn.delete();
            }
            out.print("<script language='javascript'>alert('"+info+"');mt.refresh('"+nexturl+"');</script> ");
			return;
            //out.print("<script>mt.show('" + info + "',1,\"" + nexturl + "\");</script>");
            /*if(nexturl!=null && nexturl.length()>0)
            {
            	//response.sendRedirect(nexturl+"&adminrole="+teasession.getParameter("adminrole"));

            	 out.print("<script>window.open('" + nexturl + "','_parent');</script>");
            	 out.close();

            	return;
            }*/
        } catch (Exception ex)
        {
            response.sendRedirect("/jsp/info/Error.jsp?info=" + ex.getMessage());
            ex.printStackTrace();
        }finally
        {
        	 out.close();
        }
    }

}
