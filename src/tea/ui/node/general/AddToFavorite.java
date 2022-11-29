package tea.ui.node.general;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.MessageFormat;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.Favorite;
import tea.html.Anchor;
import tea.html.Text;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class AddToFavorite extends TeaServlet
{

    public AddToFavorite()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }

            response.sendRedirect("/jsp/add/AddToFavorite.jsp?node=" + teasession._nNode);

            /*
                        PrintWriter printwriter = response.getWriter();
                        Favorite.create(teasession._nNode, teasession._rv);
                        Object aobj[] = {
                            new Anchor("FavoriteNodes", new Text(super.r.getString(teasession._nLanguage, "ClickHere"))), new Anchor("Node?node=" + teasession._nNode, new Text(super.r.getString(teasession._nLanguage, "ClickHere")))
                        };
                        printwriter.print(MessageFormat.format(super.r.getString(teasession._nLanguage, "InfViewFavorites"), aobj));
                        printwriter.close();*/
        } catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/node/general/AddToFavorite");
    }
}
