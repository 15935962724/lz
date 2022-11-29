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

public class PreInfo extends TeaServlet
{

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {

        TeaSession teasession = new TeaSession(request);
        int count = 0;
        String kinds = teasession.getParameter("count");
        if (kinds != null)
        {
            count = Integer.parseInt(kinds);
        }
        for(int i = 1; i <=count; i++){
            String totelNum = teasession.getParameter("id"+i);
        }


        if (teasession._rv == null)
        {

        }

    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/node/general/PreInfo");
    }
}
