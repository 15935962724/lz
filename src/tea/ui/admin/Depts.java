package tea.ui.admin;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.admin.*;
import tea.entity.member.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.ui.*;

public class Depts extends HttpServlet
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
            Profile p = Profile.find(h.member);

            int dept = h.getInt("dept");
            AdminUnit t = AdminUnit.find(dept);
            if("ajax".equals(act))
            {
                out.print(t.toTree(h.getInt("type"),h.key == null ? "" : h.key,h.get("depts")));
                return;
            }
            if("code".equals(act)) //部门编号
            {
                String tmp;
                int i = 1;
                do
                {
                    tmp = t.code + (i < 10 ? "0" : "") + i++;
                } while(AdminUnit.count(" AND father=" + t.id + " AND code=" + DbAdapter.cite(tmp)) > 0);
                out.print(tmp);
                return;
            }
            if("del".equals(act)) //删除
            {
                if(AdminUnit.count(" AND father=" + t.id) > 0)
                {
                    out.print("<script>mt.show('请先删除“子部门”！');</script>");
                    return;
                }
                if(Profile.count(" AND p.recycle=0 AND aur.unit=" + t.id) > 0)
                {
                    out.print("<script>mt.show('请先删除部门下的“用户”！');</script>");
                    return;
                }
                t.delete();
            } else if("edit".equals(act)) //编辑
            {
                t.community = h.community;
                t.father = h.getInt("father");
                if(t.id < 1)
                {
                    t.member = p.getProfile();
                } else if(AdminUnit.find(t.father).path.startsWith(t.path))
                {
                    out.print("<script>mt.show('“上级部门”选择错误！');</script>");
                    return;
                }
                t.name = h.get("name");
                t.sname = h.get("sname");
                //t.depttype = h.getInt("depttype");
                String tmp = h.get("code2");
                if(tmp != null)
                {
                    t.code = h.get("code1") + tmp;
                    if(AdminUnit.count(" AND community=" + DbAdapter.cite(h.community) + " AND dept!=" + t.id + " AND code=" + DbAdapter.cite(t.code)) > 0)
                    {
                        out.print("<script>mt.show('“" + t.code + "”已存在！');</script>");
                        return;
                    }
                } else
                {
                    t.code = h.get("code");
                }
                t.email = h.get("email");
                t.tel = h.get("tel");
                t.fax = h.get("fax");
                t.address = h.get("address");
                t.zip = h.get("zip");
                t.content = h.get("content");
                t.picture = h.get("picture");
                t.usepic = h.getBool("usepic");
                //t.options = h.get("options","|");
                t.sequence = h.getInt("sequence");
                //t.set();
            }
            //AdminUnit.cache(h.community);
            AdminUnit.ref(0);
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
