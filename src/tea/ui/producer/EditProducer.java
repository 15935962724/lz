package tea.ui.producer;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.entity.*;
import tea.ui.netdisk.*;

public class EditProducer extends TeaServlet
{
    //Initialize global variables
    public void init() throws ServletException
    {
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        ServletContext application = this.getServletContext();
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }

            String community = teasession.getParameter("community");
            String action = teasession.getParameter("action");
            String path = teasession.getParameter("path");
            if ("mkdir".equals(action))
            {
                String name = teasession.getParameter("name");
                java.io.File file = new java.io.File(application.getRealPath(path + name));
                file.mkdirs();
                java.io.Writer out = response.getWriter();
                out.write("<script>window.open('/jsp/producer/EditProducer.jsp?node=" + teasession._nNode + "&community=" + community + "&path=" + java.net.URLEncoder.encode(path, "UTF-8") + "','_self');      window.open('/jsp/producer/ProducerList.jsp?node=" + teasession._nNode + "&community=" + community + "&path=" + java.net.URLEncoder.encode(path + name, "UTF-8") + "','producer_list');</script>");
                out.close();
                return;
            } else
            if ("upfile".equals(action))
            {
                String name = teasession.getParameter("fileName");
                if (name == null)
                {
                    outText(teasession, response, r.getString(teasession._nLanguage, "InvalidFile"));
                    return;
                }
                if (name.endsWith(".jsp"))
                {
                    name += ".html";
                }
                java.io.File file = new java.io.File(application.getRealPath(path));
                file.mkdirs(); //防止第一次上传文件,出错.(第一次上传没有社区文件夹)
                byte by[] = teasession.getBytesParameter("file");
                boolean deco = teasession.getParameter("deco") != null;
                if (deco)
                {
                    String ex;
                    int i = name.lastIndexOf(".");
                    if (i != -1)
                    {
                        ex = name.substring(i).toLowerCase();
                    } else
                    {
                        ex = ".rar";
                    }
                    java.io.File temp = java.io.File.createTempFile("000", ex);
                    java.io.FileOutputStream tempfos = new java.io.FileOutputStream(temp);
                    tempfos.write(by);
                    tempfos.close();
                    String str = EditNetDisk.decompression(temp, new java.io.File(application.getRealPath(path))); //+ name
//                    outText(teasession, response, str);
//                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(str, "UTF-8"));
                    temp.delete();
//                    System.out.println(str);
                    // request.setAttribute();
//                    return;
                } else
                {
                    file = new java.io.File(application.getRealPath(path + name));
                    if (!file.exists())
                    {
                        java.io.FileOutputStream os = new FileOutputStream(file);
                        os.write(by);
                        os.close();
                    } else
                    {
                        outText(teasession, response, r.getString(teasession._nLanguage, "FileExist"));
                        return;
                    }
                }
            } else
            if ("delete".equals(action))
            {
                String name = teasession.getParameter("name");
                java.io.File file = new java.io.File(application.getRealPath(path + name));
                if (file.isFile())
                {
                    file.delete();
                } else
                {
                    EditNetDisk.del(file);
                }
            }
            response.sendRedirect("/jsp/producer/EditProducer.jsp?community=" + community + "&path=" + java.net.URLEncoder.encode(path, "UTF-8"));
        } catch (IOException ex)
        {
            ex.printStackTrace();
        } 
    }

    //Clean up resources
    public void destroy()
    {
    }
}
