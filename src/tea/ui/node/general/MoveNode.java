package tea.ui.node.general;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.*;
import tea.html.*;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class MoveNode extends TeaServlet
{

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            AccessMember am = AccessMember.find(teasession._nNode,teasession._rv);
            if(am.getPurview() < 3)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            if(request.getMethod().equals("GET"))
            {
                response.sendRedirect("/jsp/general/MoveNode.jsp?node=" + teasession._nNode);
                return;
            }
            String nexturl = request.getParameter("nexturl");
            int newf = Integer.parseInt(request.getParameter("NewFather")); //接受的新节点
            boolean flag = request.getParameter("flag") != null;
            Node node = Node.find(teasession._nNode);
            if(!Node.isExisted(newf) || newf == teasession._nNode)
            {
                response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"InvalidNewFather"),"UTF-8"));
                return;
            }
            // 判断 不能把节点移动到自已的子节点中
            Node node1 = Node.find(newf);
            if(node1.getPath().startsWith(node.getPath()))
            {
                response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"InvalidNewFather"),"UTF-8"));
                return;
            }
            int k = node.getFather();
            Node node2 = Node.find(k);
            int l = node1.getType();
            int i1 = node2.getType();
            if(l == 1 && i1 == 1)
            {
                if(Category.find(newf).getCategory() != Category.find(k).getCategory())
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"InvalidNewFather"),"UTF-8"));
                    return;
                }
            }
            if(nexturl == null)
            {
                nexturl = "Node?node=" + newf;
            }
            node.move(newf,flag);
            response.sendRedirect(nexturl);
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/node/general/MoveNode");
    }
}
