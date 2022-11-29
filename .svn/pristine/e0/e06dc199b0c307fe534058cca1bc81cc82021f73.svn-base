package tea.ui.util;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.site.*;
import tea.entity.*;
import tea.ui.TeaServlet;
public class UploadPlugin extends TeaServlet
{
    //Initialize global variables
    public void init() throws ServletException
    {
    }
    //Process the HTTP Post request 处理http请求
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            String file = request.getParameter("file");
            if (file != null)
            {
                DNS obj = DNS.find(request.getServerName());
                if (!obj.isExists())
                {
                    obj = DNS.find("%");
                }
                String community = obj.getCommunity();
                String str[] = file.split(",");
                byte by[] = new byte[str.length];
                for (int i = 0; i < by.length; i++)
                {
                    by[i] = Byte.parseByte(str[i]);
                }
                String path = super.write(community, by, ".gif");
                System.out.println("plug-in上传:"+path);

                PrintWriter out = response.getWriter();
                out.print(path);
                out.close();
            }
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
