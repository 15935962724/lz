package tea.ui.site;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.*;
import tea.entity.site.*;
import tea.ui.*;

public class EditTypeAlias extends TeaServlet
{

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            Http h = new Http(request);
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            if(!teasession._rv.isReal())
            {
                response.sendError(403);
                return;
            }
            int typealias = h.getInt(("typealias"));
            String act = h.get("act");
            String community = h.get("community");
            if("delete".equals(act))
            {
                if(!teasession._rv.isWebMaster() && !teasession._rv.isOrganizer(community))
                {
                    response.sendError(403);
                    return;
                }
                TypeAlias ta = TypeAlias.find(typealias);
                ta.delete(teasession._nLanguage);
            } else
            {
                int type = h.getInt(("type"));
                String name = h.get("name");
                String picture = h.get("picture");
                if(h.get("clear") != null)
                    picture = "";
                String alt = h.get("alt");
                TypeAlias ta = TypeAlias.find(typealias);
                ta.type = h.getInt(("type"));
                ta.set();
                ta.setLayer(teasession._nLanguage,name,picture,alt);
            }
            response.sendRedirect("/jsp/site/TypeAliases.jsp?community=" + community);
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }
}
