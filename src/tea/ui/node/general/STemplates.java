package tea.ui.node.general;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.RV;
import java.util.*;
import tea.entity.node.*;
import tea.ui.*;
import tea.entity.*;

public class STemplates extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act");
        PrintWriter out = response.getWriter();
        try
        {
            TeaSession teasession = new TeaSession(request);
            if("tree".equals(act))
            {
                StringBuilder sb = new StringBuilder();
                Enumeration enumer = Node.find(" AND father=" + h.node + " AND node NOT IN(" + h.get("tid") + ") AND hidden=0 AND type=0",0,200);
                while(enumer.hasMoreElements())
                {
                    int j = ((Integer) enumer.nextElement()).intValue();
                    Node n = Node.find(j);
                    sb.append("<img src='/tea/image/tree/tree_plus.gif' align=absmiddle onclick='f_c(this)' /><input type='checkbox' name='node' id='n" + j + "' value='" + j + "' onclick='mt.radio(this)' /><label for='n" + j + "'>" + n.getSubject(h.language) + "<br/></label>");
                    sb.append("<div class='tree' style='display:none'></div>");
                }
                out.print(sb.toString());
                return;
            } else if("add".equals(act))
            {
                STemplate t = STemplate.find(h.node);
                t.community = h.community;
                t.name = h.get("name");
                t.sequence = (int) System.currentTimeMillis() / 1000;
                t.time = new Date();
                t.set();
            } else if("del".equals(act))
            {
                new STemplate(h.node).delete();
            } else if("copy".equals(act))
            {
                int tid = h.getInt("tid");
                STemplate t = STemplate.find(tid);
                t.set("hits",String.valueOf(++t.hits));
                //
                h.node = Node.clone(tid,h.node,true,true,4,teasession._rv,null);
                Node.find(h.node).setSubject(h.get("name"),h.language);
                out.print("<script>top.location='/" + (teasession._nStatus == 1 ? "xhtml" : "html") + "/" + teasession._strCommunity + "/folder/" + h.node + "-" + h.language + ".htm'</script>");
                return;
            }
            out.print("<script>parent.mt.show('操作执行成功！',1,'" + h.get("nexturl","") + "');</script>");
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
