package tea.ui.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.*;
import java.sql.SQLException;
import sun.misc.*;

public class Imgs extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        ServletContext application = getServletContext();
        String act = h.get("act"),nexturl = h.get("nexturl","");
        if("verify".equals(act))
        {
            response.setContentType("image/png");
            ByteArrayOutputStream ba = new ByteArrayOutputStream();
            String str = Img.verify(ba,20);
            h.setCook("verify",MT.enc(str), -1);
            request.getSession(true).setAttribute("verify",str);
            OutputStream os = response.getOutputStream();
            ba.writeTo(os);
            os.close();
            return;
        }
        if("chart".equals(act))
        {
            //response.setHeader("Cache-Control","private");
            //response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition","attachment; filename=\"Img.png\"");
            byte[] by = new BASE64Decoder().decodeBuffer(h.get("q"));
            response.setHeader("Content-Length",String.valueOf(by.length));
            OutputStream os = response.getOutputStream();
            os.write(by);
            os.close();
            return;
        }
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            if("upload".equals(act))
            {
                String file = h.get("file");
                String name = h.get("name");
                if(name == null)
                    out.print(file);
                else if(file != null)
                {
                    if(name.length() > 0)
                    {
                        name = name.replaceAll("[ /\\\\" + (char) 0 + "]|[.]+$","_");
                        if(name.endsWith(".jsp"))
                            name += ".htm";
                        File f1 = new File(application.getRealPath(file));
                        file = file.substring(0,file.lastIndexOf('/') + 1) + name;
                        File f2 = new File(application.getRealPath(file));
                        f2.delete();
                        f1.renameTo(f2);
                    }
                    response.sendRedirect("/admin/site/ImgUpload.jsp?file=" + Http.enc(file));
                }
                return;
            } else if("del".equals(act))
            {
                new File(application.getRealPath("/res/img/" + h.get("name"))).delete();
            }
            out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
        } catch(Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }

}
