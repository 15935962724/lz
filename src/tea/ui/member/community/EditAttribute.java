package tea.ui.member.community;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.node.*;
import tea.ui.*;

public class EditAttribute extends HttpServlet
{

    //Initialize global variables
    public void init() throws ServletException
    {
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            int id = 0;
            TeaSession teasession = new TeaSession(request);
            try
            {
                id = Integer.parseInt(request.getParameter("attribute"));
            } catch (NumberFormatException ex)
            {
            }
            String nexturl = request.getParameter("nexturl");
            if (request.getParameter("delete") != null) //删除
            {
                if (id > 0)
                {
                    Attribute obj = Attribute.find(id);
                    obj.delete(teasession._nLanguage);
                } else
                {
                    Attribute.deleteByGoodstype(Integer.parseInt(request.getParameter("goodstype")));
                }
            } else
            { //编辑or创建
                String community = request.getParameter("community");
                String types = request.getParameter("types");
                int goodstype = Integer.parseInt(request.getParameter("goodstype"));
                String name = request.getParameter("name");
                String text = request.getParameter("text");
                if (id == 0)
                {
                    Attribute.create(community, types, goodstype, teasession._nLanguage, name, text);
                } else
                {
                    Attribute obj = Attribute.find(id);
                    obj.set(types, goodstype, teasession._nLanguage, name, text);
                }
            }
            response.sendRedirect(nexturl);
        } catch (Exception ex1)
        {
            ex1.printStackTrace();
        }
    }

    //Clean up resources
    public void destroy()
    {
    }
}
