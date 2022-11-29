package tea.ui.contract;

import tea.entity.contract.*;
import tea.ui.TeaServlet;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;
import tea.ui.TeaSession;

/*
 简单的逻辑
 */
public class editItemInfo extends TeaServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        String itemtype = teasession.getParameter("itemtype");
        String itemid = teasession.getParameter("itemid");
//上面是取得页面传来的参数
        try
        {
            //判断有无重复值
            if (Iteminfo.findSame(itemtype) != 0 && teasession.getParameter("id").equals("insert"))
            {
                response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("类型已存在!", "utf-8"));
                return;
            }
            //删除操作
            if (teasession.getParameter("del") != null && teasession.getParameter("del").length() > 0)
            {
                Iteminfo.del(teasession.getParameter("del"));
                response.sendRedirect("/jsp/contract/itemlist.jsp"); //列表路径
                return;
            }
//插入修改操作
            Iteminfo.create(itemid, itemtype, teasession._strCommunity);
            response.sendRedirect("/jsp/contract/itemlist.jsp"); //列表路径
            return;
        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }
}
