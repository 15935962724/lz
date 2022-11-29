package tea.ui.node.adword;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.Date;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.node.*;
import tea.html.*;
import tea.htmlx.*;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditAdword extends TeaServlet
{
    public EditAdword()
    {
    }

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
            int adword = Integer.parseInt(teasession.getParameter("adword"));
            String act = teasession.getParameter("act");
            String nexturl = teasession.getParameter("nexturl");
            if ("editadwordname".equals(act))
            {
                String name = teasession.getParameter("name");
                if (adword < 1)
                {
                    adword = Adword.create(teasession._rv._strR, name);
                } else
                {
                    Adword obj = Adword.find(adword);
                    obj.setName(name);
                }
            } else if ("editadwordtarget".equals(act))
            {
                Adword obj = Adword.find(adword);
                String region = teasession.getParameter("region0");
                String language = teasession.getParameter("language0");
                obj.setTarget(region, language);
            } else if ("editadwordshow".equals(act))
            {
                Adword obj = Adword.find(adword);
                String adtitle = teasession.getParameter("adtitle");
                String adexplain1 = teasession.getParameter("adexplain1");
                String adexplain2 = teasession.getParameter("adexplain2");
                String adshow = teasession.getParameter("adshow");
                String adurl = teasession.getParameter("adurl");
                String adpic = null;
                byte by[] = teasession.getBytesParameter("adpic");
                if (by != null)
                {
                    adpic = write(teasession._strCommunity, by, ".gif");
                }
                obj.set(adtitle, adexplain1, adexplain2, adshow, adurl, adpic);
            } else if ("editadwordkeywords".equals(act))
            {
                Adword obj = Adword.find(adword);
                String keywords = teasession.getParameter("keywords");
                obj.setKeyworlds(keywords);
            } else if ("editadwordpricing".equals(act))
            {
                Adword obj = Adword.find(adword);
                BigDecimal budget = new BigDecimal(teasession.getParameter("budget"));
                BigDecimal bid = new BigDecimal(teasession.getParameter("bid"));
                Date stop = obj.sdf.parse(teasession.getParameter("stoptimeYear") + "-" + teasession.getParameter("stoptimeMonth") + "-" + teasession.getParameter("stoptimeDay"));
                obj.set(budget, bid, stop);
            } else if ("editadwordconfirm".equals(act))
            {
                Adword obj = Adword.find(adword);
                if (obj.getStatus() < 1)
                {
                    obj.setStatus(1);
                }
            } else if ("editadwordstatus".equals(act))
            {
                int status = Integer.parseInt(request.getParameter("status"));
                String adwords[] = request.getParameterValues("adwords");
                if (adwords != null)
                {
                    for (int i = 0; i < adwords.length; i++)
                    {
                        Adword obj = Adword.find(Integer.parseInt(adwords[i]));
                        obj.setStatus(status);
                    }
                }
            }
            response.sendRedirect(nexturl + "?community=" + teasession._strCommunity + "&adword=" + adword);
        } catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        // super.r.add("tea/ui/node/ading/EditAding");
    }
}
