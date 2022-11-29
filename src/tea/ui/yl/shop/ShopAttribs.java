package tea.ui.yl.shop;

import java.io.*;
import tea.entity.*;
import tea.entity.yl.shop.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class ShopAttribs extends HttpServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request, response);
        String act = h.get("act"), nexturl = h.get("nexturl", "");
        ServletContext application = this.getServletContext();
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            int attrib = h.getInt("attrib");
            if ("edit".equals(act))
            {
                ShopAttrib t = ShopAttrib.find(attrib);
                t.category = h.getInt("category");
                t.type = h.getInt("type");
                t.need = h.getBool("need");
                t.name[0] = h.get("name0");
                t.name[1] = h.get("name1");
                if (t.type > 1)
                {
                    t.query = h.getBool("query");
                    t.content[0] = h.get("content0");
                    t.content[1] = h.get("content1");
                    for (int i = 0; i < t.content.length; i++)
                    {
                        if (!t.content[i].startsWith("|"))
                            t.content[i] = "|" + t.content[i];
                        if (!t.content[i].endsWith("|"))
                            t.content[i] += "|";
                    }
                } else
                    t.query = false;
                if (attrib < 1)
                    t.sequence = (int) (System.currentTimeMillis() / 1000);
                t.set();
            } else if ("del".equals(act))
            {
                String[] arr = attrib > 0 ? new String[]
                               {String.valueOf(attrib)}
                               : h.getValues("attribs");
                for (int i = 0; i < arr.length; i++)
                {
                    new ShopAttrib(Integer.parseInt(arr[i])).delete();
                }
            } else if ("sequence".equals(act))
            {
                String[] arr = h.get("attribs").split("[|]");
                for (int i = 1; i < arr.length; i++)
                {
                    ShopAttrib a = new ShopAttrib(Integer.parseInt(arr[i]));
                    a.set("sequence", String.valueOf(i * 10));
                }
                return;
            }
            out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
        } catch (Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
