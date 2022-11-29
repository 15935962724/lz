package tea.newer;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.db.DbAdapter;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.entity.*;
import java.util.ArrayList;
import tea.entity.node.Media;

/**
 * Servlet implementation class EditNewexperts
 */
public class EditNewexperts extends TeaServlet
{
    private static final long serialVersionUID = 1L;

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        Http h = new Http(request,response);
        if(h.member < 1)
        {
            response.sendRedirect("/servlet/StartLogin?community=" + h.community);
            return;
        }
        PrintWriter out = response.getWriter();
        try
        {
            String act = h.get("act");
            if("changeprovideexperts".equals(act))
            {
                String nname = h.get("ename");
                List list = Newexperts.findList(" AND ename like " + DbAdapter.cite("%" + nname.trim() + "%"),0,10);
                out.print("<div id=xilidiv3>");
                out.print("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"xiaoliajatable3\" onMouseOut=\"\" onMouseOver=\"\" >");
                Iterator it = list.iterator();
                while(it.hasNext())
                {
                    Newexperts np = (Newexperts) it.next();
                    out.print("<tr onMouseOver=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\" style=\"cursor:pointer\" onclick=\"setexperts('" + np.getEname() + "')\">");
                    out.print("<td>");
                    out.print(np.getEname());
                    out.print("</td>");
                    out.print("</tr>");
                }
                out.print("</table></div>");
                return;
            }

            int nid = 0;
            String s = h.get("eid");
            if(h.get("eid") != null)
            {
                nid = Integer.parseInt(h.get("eid"));
            }
            String nexturl = "";
            if(h.get("nexturl") != null)
            {
                nexturl = h.get("nexturl");
            }
            if("delete".equals(act))
            {
                Newexperts np = Newexperts.finds(nid);
                np.delete();
                response.sendRedirect(nexturl);
            } else if("add".equals(act) || "edit".equals(act))
            {
                String nname = h.get("ename");
                Newexperts np = new Newexperts(nid,nname);
                np.set();
                response.sendRedirect(nexturl);
            }
        } catch(Throwable ex)
        {
            response.sendError(400,ex.getMessage());
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }

}
