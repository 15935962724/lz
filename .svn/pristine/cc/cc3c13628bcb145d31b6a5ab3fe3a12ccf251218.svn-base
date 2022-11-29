package tea.ui.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.TeaServlet;
import tea.entity.admin.*;
import tea.entity.member.Message;
import java.text.*;


public class EditArchives extends TeaServlet
{

    //Initialize global variables
    public void init() throws ServletException
    {
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        tea.ui.TeaSession teasession = null;
        teasession = new tea.ui.TeaSession(request);
        try
        {
            String act = teasession.getParameter("act");
            String nexturl = teasession.getParameter("nexturl");
            String str = null;
            int archives = 0;
            if(teasession.getParameter("archives")!=null && teasession.getParameter("archives").length()>0)
                archives = Integer.parseInt(teasession.getParameter("archives"));
            Archives avobj = Archives.find(archives);
            if ("EditArchives".equals(act))
            {
                String adminunit = teasession.getParameter("adminunit");
                String role = teasession.getParameter("role");
                String caption = teasession.getParameter("caption");
                String content = teasession.getParameter("content");
                String filename = "";
                String fileurl = "";
                byte by[] = teasession.getBytesParameter("fileurl");
                if (teasession.getParameter("clear1") != null)
                {
                    fileurl = "";
                    filename = "";
                } else if (by != null)
                {
                    fileurl = write(teasession._strCommunity, by, ".gif");
                    filename = teasession.getParameter("fileurlName");
                } else
                {
                   fileurl = avobj.getFileurl();
                   filename = avobj.getFilename();
                }
                if(archives>0)
                {
                    avobj.set(teasession._rv.toString(),adminunit,role,caption,content,filename,fileurl);
                    str ="文件登记修改成功!";
                }else{
                    Archives.create(teasession._rv.toString(),teasession._strCommunity,adminunit,role,caption,content,filename,fileurl);
                    str ="文件登记成功!";
                }

            }
            if("delete".equals(act))
            {
                avobj.delete();
                str="文件登记删除成功!";
            }

            // response.sendRedirect(nexturl);
            response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode(str, "UTF-8") + "&nexturl=" + nexturl);
        } catch (Exception ex)
        {
            ex.printStackTrace();

        }

    }

    //Clean up resources
    public void destroy()
    {
    }
}

