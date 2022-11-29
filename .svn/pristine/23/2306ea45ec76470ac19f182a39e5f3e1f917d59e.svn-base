package tea.ui.admin.erp.icard;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.net.URLEncoder;
import java.util.*;
import tea.ui.*;
import tea.db.*;
import tea.entity.admin.erp.*;
import javax.servlet.http.HttpSession;
import tea.entity.member.*;
import tea.entity.admin.erp.icard.*;

public class EditICardType extends TeaServlet
{

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        if(teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
            return;
        }
        String act = teasession.getParameter("act");
        String nexturl = teasession.getParameter("nexturl");
        try
        {
            if("edit".equals(act))
            {
                int icardtype = Integer.parseInt(request.getParameter("icardtype"));
                String name = teasession.getParameter("name");
                int j = ICardType.count(teasession._strCommunity," AND icardtype!=" + icardtype + " AND name=" + DbAdapter.cite(name));
                if(j > 0)
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("不能重复添加卡类型!","UTF-8") + "&nexturl=/jsp/erp/icard/EditICardType.jsp%3Ficardtype=" + icardtype);
                    return;
                }
                int mode = Integer.parseInt(request.getParameter("mode"));
                float integral = 0.0F;
                try
                {
                    integral = Float.parseFloat(request.getParameter("integral"));
                } catch(NumberFormatException ex1)
                {
                }
                int discount = 0;
                try
                {
                    discount = Integer.parseInt(request.getParameter("discount"));
                } catch(NumberFormatException ex2)
                {
                }
                //分店类型
                int lstypeid = 0;
                if(teasession.getParameter("lstypeid")!=null && teasession.getParameter("lstypeid").length()>0)
                {
                	lstypeid = Integer.parseInt(teasession.getParameter("lstypeid"));
                }
                if(icardtype == 0)
                {
                    ICardType.create(teasession._strCommunity,name,mode,integral,discount,lstypeid);
                } else
                {
                    ICardType ct = ICardType.find(icardtype); 
                    ct.set(name,mode,integral,discount,lstypeid);
                }
            } else if("del".equals(act))
            {
                int icardtype = Integer.parseInt(request.getParameter("icardtype"));
                ICardType ct = ICardType.find(icardtype);
                ct.delete();
            }
            response.sendRedirect(nexturl);
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }
}
