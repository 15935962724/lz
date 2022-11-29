package tea.ui.member.node;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.Favorite;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class DeleteFavorite extends TeaServlet
{
    public DeleteFavorite()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            String nu = teasession.getParameter("nexurl");
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            String nodes[] = teasession.getParameterValues("nodes");
            String submit2 = teasession.getParameter("submit2");
            if("submit2".equals(submit2))
            {
                Favorite.delete_2(teasession._strCommunity,teasession._rv);
            } else
            if(nodes != null) //选择删除
            {
                for(int i = 0;i < nodes.length;i++)
                {
                    Favorite.delete(teasession._strCommunity,teasession._rv,Integer.parseInt(nodes[i]));
                }
            }
            if(nu == null)
            {
                nu = "/jsp/node/FavoriteNodes.jsp";
            }
            response.sendRedirect(nu);
        } catch(Exception exception)
        {
            response.sendError(400,exception.toString());
            exception.printStackTrace();
        }
    }
}
