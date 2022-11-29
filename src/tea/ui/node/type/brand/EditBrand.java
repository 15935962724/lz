package tea.ui.node.type.brand;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.node.Brand;
import tea.entity.*;
import tea.ui.*;

public class EditBrand extends TeaServlet
{

    public void init() throws ServletException
    {
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            int brand_id = 0;
            try
            {
                brand_id = Integer.parseInt(teasession.getParameter("brand"));
            } catch(NumberFormatException ex1)
            {
            }
            String nexturl = teasession.getParameter("nexturl");
            String community = teasession._strCommunity;
            if(teasession.getParameter("delete") != null)
            {
                Brand obj = Brand.find(brand_id);
                obj.delete();
            } else
            {
                String logo = teasession.getParameter("logo");
                if(logo == null)
                {
                    logo = teasession.getParameter("logopath");
                }
                String name = teasession.getParameter("name");
                String content = teasession.getParameter("content");
                int company = Integer.parseInt(teasession.getParameter("company"));
                int node = Integer.parseInt(teasession.getParameter("nodex"));
                int sequence = Integer.parseInt(teasession.getParameter("sequence"));
                if(brand_id < 1)
                {
                    Brand.create(logo,community,company,node,sequence,teasession._nLanguage,name,content);
                } else
                {
                    Brand obj = Brand.find(brand_id);
                    obj.set(logo,community,company,node,sequence,teasession._nLanguage,name,content);
                }
            }
            if(nexturl == null)
            {
                nexturl = "/jsp/type/brand/ManageBrand.jsp?community=" + community;
            }
            response.sendRedirect(nexturl);
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }

    // Clean up resources
    public void destroy()
    {
    }
}
