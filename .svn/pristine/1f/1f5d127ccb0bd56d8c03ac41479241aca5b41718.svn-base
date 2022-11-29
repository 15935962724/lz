package tea.ui.node.type.dynamic;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.entity.site.*;
import tea.entity.*;
import tea.db.*;
import java.sql.SQLException;

public class EditDynamic extends TeaServlet
{

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("/tea/resource/Dynamic");
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        if(teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
            return;
        }
        String nu = teasession.getParameter("nexturl");
        try
        {
            int dynamic = Integer.parseInt(teasession.getParameter("dynamic"));
            String act = teasession.getParameter("act");
            if("delete".equals(act))
            {
                if(exist(teasession._strCommunity,dynamic))
                {
                    // response.sendRedirect(request.getContextPath() + "/jsp/info/Alert.jsp?node=" + teasession._nNode + "&community=" + community);
                    super.outText(teasession,response,r.getString(teasession._nLanguage,"NotDelete"));
                    return;
                }
                Dynamic obj = Dynamic.find(dynamic);
                obj.delete(teasession._nLanguage);
            } else if("clone".equals(act))
            {
                Dynamic.find(dynamic).clone(teasession._nLanguage);
            } else
            {
                int sort = Integer.parseInt(teasession.getParameter("sort"));
                String name = teasession.getParameter("name");
                String type = teasession.getParameter("type");
                String template = null;
                byte by[] = teasession.getBytesParameter("template");
                if(by != null)
                {
                    template = write(teasession._strCommunity,by,".xls");
                } else if(teasession.getParameter("clear") != null)
                {
                    template = "";
                }
                if(dynamic > 0)
                {
                    Dynamic obj = Dynamic.find(dynamic);
                    obj.set(type,teasession._nLanguage,name,template);
                } else
                {
                    dynamic = Dynamic.create(teasession._strCommunity,type,sort,teasession._nLanguage,name,template);
                }
                if(teasession.getParameter("GoNext") != null)
                {
                    nu = "/jsp/community/DynamicTypes.jsp?community=" + teasession._strCommunity + "&dynamic=" + dynamic + "&dynamictype=0&nexturl=" + java.net.URLEncoder.encode(nu,"UTF-8");
                }
            }
        } catch(Exception e)
        {
            e.printStackTrace();
        }
        response.sendRedirect(nu);
    }

    public boolean exist(String community,int type) throws SQLException
    {
        boolean bool = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM Category WHERE category=" + type);
            bool = db.next();
        } finally
        {
            db.close();
        }
        return bool;
    }

    // Clean up resources
    public void destroy()
    {
    }
}
