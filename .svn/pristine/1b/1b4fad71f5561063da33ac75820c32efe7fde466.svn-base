package tea.ui.admin.erp.icard;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.net.URLEncoder;
import java.util.*;
import tea.ui.*;
import tea.entity.admin.erp.*;
import javax.servlet.http.HttpSession;
import tea.entity.member.*;
import tea.entity.admin.erp.icard.*;

public class EditShopICard extends TeaServlet
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
                int shopicard = Integer.parseInt(request.getParameter("shopicard"));
                int leagueshop = Integer.parseInt(request.getParameter("leagueshop"));
                int icardtype = Integer.parseInt(request.getParameter("icardtype"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                Date time = ShopICard.sdf.parse(request.getParameter("timeYear") + "-" + request.getParameter("timeMonth") + "-" + request.getParameter("timeDay"));
                int j = ICard.count(icardtype,"");
                if(j < quantity)
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("剩余张数不足(剩余:" + j + "张,需要:" + quantity + "张)","UTF-8"));
                    return;
                }
                ShopICard.create(leagueshop,icardtype,quantity,time);
            } else if("del".equals(act))
            {
                int shopicard = Integer.parseInt(request.getParameter("shopicard"));
                ShopICard sic = ShopICard.find(shopicard);
                sic.delete();
            }
            response.sendRedirect(nexturl);
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }
}
