package tea.ui.node.type;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import tea.ui.TeaSession;
import tea.entity.node.*;
import tea.entity.*;
import tea.ui.*;

public class TypePicture extends TeaServlet
{
    // Initialize global variables
    public void init() throws ServletException
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            int id = Integer.parseInt(teasession.getParameter("id"));
            String act = teasession.getParameter("act");
            String mt = teasession.getParameter("mt");
            if(mt != null && mt.length() > 0)
            {
                mt = "admin";
            }
            if("del".equals(act))
            {
                tea.entity.node.TypePicture obj = tea.entity.node.TypePicture.findByPrimaryKey(id);
                obj.delete();
            } else
            {
                String picture = teasession.getParameter("picture");
                if(picture == null && id < 1)
                {
                    response.sendRedirect("/jsp/info/Alert.jsp");
                    return;
                }
                String name = teasession.getParameter("picname");
                int width = 0,height = 0;
                try
                {
                    width = Integer.parseInt(teasession.getParameter("width"));
                    height = Integer.parseInt(teasession.getParameter("height"));
                } catch(NumberFormatException ex1)
                {
                }
                String picture2 = teasession.getParameter("bigpicture");
                if(picture2 != null)
                {
                    if(width <= 28 && height <= 30) // 如果ie没有取得图片大小,则...
                    {
                        try
                        {
                            java.awt.image.BufferedImage bi = javax.imageio.ImageIO.read(new File(this.getServletContext().getRealPath(picture2)));
                            width = bi.getWidth();
                            height = bi.getHeight();
                        } catch(IOException ex2)
                        {
                        }
                    }
                }
                if(id < 1)
                {
                    tea.entity.node.TypePicture.create(teasession._nNode,width,height,picture,name,picture2);
                } else
                {
                    tea.entity.node.TypePicture obj = tea.entity.node.TypePicture.findByPrimaryKey(id);
                    if(picture == null)
                    {
                        picture = obj.getPicture();
                    }
                    if(picture2 == null)
                    {
                        picture2 = obj.getPicture2();
                    }
                    obj.set(width,height,picture,name,picture2);
                }
            }
            response.sendRedirect("/jsp/type/TypePicture.jsp?community=" + teasession._strCommunity + "&node=" + teasession._nNode + "&mt=" + MT.enc(mt));
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }

    // Clean up resources
    public void destroy()
    {
    }
}
