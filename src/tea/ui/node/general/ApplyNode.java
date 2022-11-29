package tea.ui.node.general;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.node.*;
import tea.db.DbAdapter;

public class ApplyNode extends HttpServlet
{
    public void init() throws ServletException
    {
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            Node node = Node.find(teasession._nNode);
            long options = node.getOptions();
            int kstyle = node.getKstyle();
            int style = node.getStyle();
            String accessmembersnode = node.getAccessmembersnode();
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT node FROM Node WHERE path LIKE " + DbAdapter.cite(node.getPath() + "_%"));
                while (db.next())
                {
                    Node obj = Node.find(db.getInt(1));
                    obj.set(options, kstyle, style,accessmembersnode);
                }
            } finally
            {
                db.close();
            }
            response.sendRedirect("/jsp/info/Succeed.jsp?nexturl=" + java.net.URLEncoder.encode("/jsp/general/SonNodes.jsp?node=" + teasession._nNode, "UTF-8"));
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }

    //Clean up resources
    public void destroy()
    {
    }
}
