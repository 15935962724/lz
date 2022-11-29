package tea.ui.sup;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.ui.*;
import tea.entity.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.sup.*;

public class SupQualifications extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        ServletContext application = this.getServletContext();
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt;</script>");
            if(h.member < 1)
            {
                out.print("<script>top.location.replace('/servlet/StartLogin?node=" + h.node + "');</script>");
                return;
            }

            if("ajax".equals(act))
            {
                SupQualification t = SupQualification.find(h.getInt("father"));
                out.print(t.toTree("|",h.getInt("dept"),h.key));
                return;
            }
            if("list".equals(act))
            {
                int category = h.getInt("category");
                Iterator it = SupQualification.findByFather(category).iterator();
                while(it.hasNext())
                {
                    SupQualification t = (SupQualification) it.next();
                    out.print("<li onclick='f_sel(this)' id='" + t.qualification + "'>" + MT.f(t.name) + "</li>");
                }
                return;
            }
            if("search".equals(act))
            {
                String q = h.get("q");
                Iterator it = SupQualification.find(" AND deleted=0 AND name LIKE " + DbAdapter.cite("%" + q + "%"),0,200).iterator();
                while(it.hasNext())
                {
                    SupQualification t = (SupQualification) it.next();
                    StringBuilder sb = new StringBuilder();
                    String[] arr = t.getPath().split("[|]");
                    for(int i = 2;i < arr.length;i++)
                        sb.append("<em>></em>" + MT.red(SupQualification.find(Integer.parseInt(arr[i])).name,q));
                    out.print("<li onclick='f_sel(this,true)' id='" + t.qualification + "'>" + sb.toString() + "</li>");
                }
                return;
            }

            int qualification = h.getInt("qualification");
            SupQualification t = SupQualification.find(qualification);
            if("del".equals(act)) //删除
            {
                String[] arr = qualification < 1 ? h.getValues("qualifications") : new String[]
                               {String.valueOf(qualification)};
                for(int i = 0;i < arr.length;i++)
                {
                    t = SupQualification.find(Integer.parseInt(arr[i]));
                    t.delete();
                }
                qualification = t.father;
            } else if("edit".equals(act)) //编辑
            {
                t.father = h.getInt("father");
                t.name = h.get("name");
                t.code = h.get("code");
                t.spec = h.get("spec");
                t.unit = h.get("unit");
                qualification = t.set();
            } else if("brandadd".equals(act)) //品牌 添加
            {
                String[] arr = h.get("brand").split("[|]");
                for(int i = 1;i < arr.length;i++)
                {
                    if(t.brand.contains("|" + arr[i] + "|"))
                        continue;
                    t.brand += arr[i] + "|";
                }
                t.set("brand",t.brand);
            } else if("branddel".equals(act)) //品牌 删除
            {
                String[] arr = h.getValues("brands");
                for(int i = 0;i < arr.length;i++)
                {
                    t.brand = t.brand.replaceAll("\\|" + arr[i] + "\\|","|");
                }
                t.set("brand",t.brand);
            }
            SupQualification.cache();
            out.print("<script>parent.parent.qualification_tree.document.form1.submit(); window.open('" + nexturl + "','_parent');</script>");
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
