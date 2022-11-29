package tea.ui.site;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.*;
import java.sql.SQLException;
import sun.misc.*;


public class Structures extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request);
        ServletContext application = getServletContext();
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            if(h.member < 1)
            {
                out.print("<script>top.location.replace('/servlet/StartLogin?community=" + h.community + "');</script>");
                return;
            }
            String act = h.get("act"),nexturl = h.get("nexturl","");
            if("upload".equals(act))
            {
                String file = h.get("file");
                if(file == null)
                    return;
                if(file.startsWith("data:image/png;base64,"))//剪切板
                {
                    byte[] by = new BASE64Decoder().decodeBuffer(file.substring(22));
                    Attch a = new Attch(Seq.get());
                    a.name = a.attch + ".jpg";
                    a.type = "jpg";
                    a.community = h.community;
                    a.member = h.member;
                    file = a.path = "/res/" + a.community + "/" + h.get("repository") + "/" + h.get("attchname",a.name);
                    File f = new File(Http.REAL_PATH + a.path);
                    Filex.write(f.getPath(),by);
                    Img img = new Img(f);
                    img.start(f);
                    a.length = (int) f.length();
                    a.set();
                }
                //EditHelp.jsp
                int j = file.indexOf("/../../");
                if(j != -1)
                    file = file.substring(j + 6);
                //out.print("<script>mt.clear(doc);mt.show(\"<input value='" + file + "' size='35'/>\");</script>");
                out.print("<script>parent.location.replace('/jsp/site/StructureUpload.jsp?community=" + h.community + "&repository=" + h.get("repository") + "&file=" + Http.enc(file) + "');</script>");
                return;
            } else if("del".equals(act))
            {
                new File(application.getRealPath("/res/" + h.community + "/structure/" + h.get("name"))).delete();
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
