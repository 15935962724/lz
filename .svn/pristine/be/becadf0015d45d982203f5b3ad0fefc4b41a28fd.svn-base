package tea.ui.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.admin.*;
import tea.entity.member.*;

public class Roles extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request);
        String act = h.get("act"),nexturl = h.get("nexturl");
        PrintWriter out = response.getWriter();
        try
        {
//            if("exp".equals(act))
//            {
//                response.setContentType("application/octet-stream");
//                response.setHeader("Content-Disposition","attachment; filename=\"" + new String("角色统计.csv".getBytes("GBK"),"ISO-8859-1") + "\"");
//                StringBuilder sb = new StringBuilder();
//                sb.append("部门");
//
//                ArrayList rs = AdminRole.find(h.key,0,Integer.MAX_VALUE);
//                for(int i = 0;i < rs.size();i++)
//                {
//                    AdminRole t = (AdminRole) rs.get(i);
//                    sb.append(",").append(t.name);
//                }
//                sb.append("\r\n");
//
//                ArrayList ds = Dept.find(" AND " + Dept.getRoot(h.community).dept + " IN(dept,father) ORDER BY seq",0,Integer.MAX_VALUE);
//                for(int i = 0;i < ds.size();i++)
//                {
//                    Dept d = (Dept) ds.get(i);
//                    sb.append(d.name);
//                    for(int j = 0;j < rs.size();j++)
//                    {
//                        AdminRole r = (AdminRole) rs.get(j);
//                        int val;
//                        if(r.role == 44)
//                            val = SupExpert.count(" AND m.recycle=0 AND m.member!='webmaster' AND se.expert>0 AND se.type=1 AND se.dept LIKE '%|" + d.dept + "|%'");
//                        else
//                            val = Profile.count(" AND p.recycle=0 AND p.member!='webmaster' AND aur.community=" + DbAdapter.cite(h.community) + " AND aur.role LIKE " + DbAdapter.cite("%/" + r.role + "/%") + " AND aur.unit IN(SELECT dept FROM dept WHERE path LIKE " + DbAdapter.cite(d.path + "%") + ")");
//                        sb.append("," + val);
//                    }
//                    sb.append("\r\n");
//                }
//                out.print(sb.toString());
//                return;
//            }
            out.println("<script>var mt=parent.mt;</script>");
            if(h.member < 1)
            {
                out.print("<script>alert('" + Res.get(h.language,"您还没有登录或登录已超时，请重新登录！") + "');top.location.replace('/admin/Login.jsp');</script>");
                return;
            }
            String key = h.get("role");
            int role = key.length() < 1 ? 0 : Integer.parseInt(MT.dec(key));
            if("sequence".equals(act))
            {
                int sequence = h.getInt("sequence");
                if(sequence > 0)
                {
                    AdminRole.find(role).set("sequence",String.valueOf(sequence));
                } else
                {
                    int pos = h.getInt("pos");
                    String[] arr = h.get("roles").split("[|]");
                    for(int i = 1;i < arr.length;i++)
                    {
                        AdminRole r = AdminRole.find(Integer.parseInt(arr[i]));
                        r.set("sequence",String.valueOf(i + pos));
                    }
                    return;
                }
            }
            AdminRole r = AdminRole.find(role);
            if("edit".equals(act))
            {
                r.community = h.community;
                r.name = h.get("name");
                r.type = h.getInt("type");
                r.levels = h.getInt("levels");
                r.content = h.get("content");
                //t.member = h.get("members","|");
                r.distinguish = h.getBool("distinguish");
                if(role < 1)
                    r.sequence = (int) (System.currentTimeMillis() / 1000);
                r.time = new Date();
                r.set();
            } else if("clone".equals(act))
            {
                r = r.clone();
                if(r.type == 1)
                    r.type = 2;
                r.name = "复制 " + r.name;
                r.set();
            } else if("setmenu".equals(act))
            {
                int len = r.distinguish ? 2 : 1;
                for(int i = 0;i < len;i++)
                {
                    StringBuilder sb = new StringBuilder("|");
                    String[] arr = h.getValues("menu" + i);
                    if(arr != null)
                    {
                        for(int j = 0;j < arr.length;j++)
                        {
                            sb.append(arr[j] + ":" + h.get("menu" + i + "_" + arr[j],"|").substring(1).replace('|',',') + "|");
                        }
                    }
                    r.set(i == 0 ? "adminfunction" : "ethernet",sb.toString());
                }
            } else if("setconsign".equals(act))
            {
                r.consign = h.get("consign");
                r.set("consign",r.consign);
            } else if("del".equals(act))
            {
                r.delete();
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
