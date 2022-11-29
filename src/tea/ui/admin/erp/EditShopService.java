package tea.ui.admin.erp;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.net.URLEncoder;
import java.math.*;
import java.util.*;
import tea.ui.*;
import tea.db.*;
import tea.entity.admin.erp.*;
import tea.entity.member.*;
import tea.entity.admin.erp.icard.*;

public class EditShopService extends TeaServlet
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
                int shopservice = Integer.parseInt(request.getParameter("shopservice"));
                int brand = Integer.parseInt(request.getParameter("brand"));
                String no = request.getParameter("no");
                String name = request.getParameter("name");
                BigDecimal price = new BigDecimal(request.getParameter("price"));
                String spec = request.getParameter("spec");
                boolean dtype = Boolean.parseBoolean(request.getParameter("dtype"));
                float deduct = Float.parseFloat(request.getParameter("deduct"));
                float point = Float.parseFloat(request.getParameter("point"));
                Enumeration e = ShopService.find(teasession._strCommunity," AND shopservice!=" + shopservice + " AND no=" + DbAdapter.cite(no),0,1);
                if(e.hasMoreElements())
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(no + " 编码重复!!!","UTF-8"));
                    return;
                }
                if(shopservice < 1)
                {
                    ShopService.create(teasession._strCommunity,no,name,price,spec,dtype,deduct,point,brand);
                } else
                {
                    ShopService ss = ShopService.find(shopservice);
                    ss.set(no,name,price,spec,dtype,deduct,point,brand);
                }
            } else if("del".equals(act))
            {
                int shopservice = Integer.parseInt(request.getParameter("shopservice"));
                ShopService ss = ShopService.find(shopservice);
                ss.delete();
            }
            response.sendRedirect(nexturl);
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }
}
