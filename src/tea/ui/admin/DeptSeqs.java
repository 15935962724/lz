package tea.ui.admin;

import java.io.*;
import java.util.*;
import tea.entity.*;
import tea.entity.admin.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.member.*;
import tea.db.DbAdapter;

public class DeptSeqs extends HttpServlet
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
            out.print("<script>var mt=parent.mt;</script>");
            if(h.member < 1)
            {
                out.print("<script>top.location.replace('/servlet/StartLogin?node=" + h.node + "');</script>");
                return;
            }

            int dept = h.getInt("dept");
            if("sequence".equals(act))
            {
                String[] members = h.get("members").split("[|]");
                for(int i = 1;i < members.length;i++)
                {
                    DeptSeq a = new DeptSeq(dept,Integer.parseInt(members[i]));
                    a.set("sequence",String.valueOf(i * 10));
                }
                return;
            }
            AdminUsrRole cur = AdminUsrRole.find(h.community,h.member);
            if(!"POST".equals(request.getMethod()) || request.getHeader("referer") == null || cur.role.length() < 3)
                act = null;
            if("add".equals(act))
            {
                String username = h.get("member");
                Profile p = Profile.find(username);
                if(p.getTime() == null)
                {
                    out.print("<script>alert('“" + username + "”不存在！');</script>");
                    return;
                }
                out.print("<script>parent.location.replace('/jsp/admin/popedom/DeptSeqEdit.jsp?community=" + h.community + "&dept=" + h.getInt("dept") + "&nexturl=" + Http.enc(h.get("nexturl")) + "&member=" + MT.enc(p.getProfile()) + "')</script>");
                return;
            }
            String key = h.get("member");
            int member = key.length() < 1 ? 0 : Integer.parseInt(MT.dec(key));
            if("edit".equals(act)) //编辑
            {
                String password = h.get("password");
                String email = h.get("email");
                Profile p;
                if(member < 1)
                {
                    String username = h.get("username").trim().toLowerCase();
                    if(Profile.isExisted(username))
                    {
                        out.print("<script>mt.show('“" + username + "”已存在！');</script>");
                        return;
                    }
                    p = Profile.create(username,password,h.community,email,request.getServerName() + ":" + request.getServerPort());
                    member = p.profile;
                    //中国职业教育网 所属的学习中心
                    p.setAgent(h.getInt("agent"));
                } else
                {
                    p = Profile.find(member);
                    p.setEmail(email);
                }

                if(!"********".equals(password))
                {
                    p.setPassword(password);
                }
                p.setType(1);
                p.setSex(h.getBool("sex"));
                p.setFirstName(h.get("name"),h.language);
                p.setLastName("",h.language);
                p.set("qq",p.qq = h.get("qq"));
                p.setJob(h.get("job"),h.language);
                p.setTitle(h.get("title"),h.language);
                // ////
                //String tmp = h.get("birth");
                //Date birth = null;
                //String functions = h.get("functions");
                //String address = h.get("address");
                //String degree = h.get("degree");
                //int polity = Integer.parseInt(h.get("polity"));

                //p.set(null,h.language,h.get("job"),h.get("title"),"",h.get("avatar"));
                //p.setBirth(birth);
                p.setTelephone(h.get("telephone"),h.language);
                p.setFax(h.get("fax"),h.language);
                p.setMobile(h.get("mobile"));
                p.setAddress(h.get("address"),h.language);
                p.set(h.language,"photopath2",h.get("avatar"));
                //p.setDegree(degree,h.language);
                //p.setPolity(polity);
                //

                AdminUsrRole aur = AdminUsrRole.find(h.community,member);
                String old = aur.getUnit() + aur.getDept();
                String role = h.get("role");
                //角色校验
                if(!"webmaster".equals(h.username) && role.length() > 1)
                {
                    String roles = AdminRole.getConsign(cur) + aur.role.substring(1).replace('/','|');
                    int count = AdminRole.count(" AND community=" + DbAdapter.cite(h.community) + " AND id IN(" + roles.substring(1).replace('|',',') + "0) AND id IN(" + role.substring(1).replace('/',',') + "0)");
                    if(count != role.split("/").length - 1)
                    {
                        Filex.logs("hacker.txt","添加角色　IP:" + request.getRemoteAddr() + "　URI:" + request.getRequestURI());
                        role = "/";
                    }
                }
                //
                aur.setRole(role);
                aur.setUnit(dept); //所属部门
                aur.setDept(h.get("depts")); //兼职部门
                aur.setClasses(h.get("classes"));
                //aur.set("servicerole",h.get("kefus"));

                //同步部门 排序
                String depts = aur.getUnit() + aur.getDept();
                //" AND dept IN(" + old.replace('/',',') + "0)
                ArrayList al = DeptSeq.find(" AND dept NOT IN(" + depts.replace('/',',') + "-1) AND member=" + member,0,Integer.MAX_VALUE);
                for(int i = 0;i < al.size();i++)
                {
                    DeptSeq ds = (DeptSeq) al.get(i);
                    ds.delete();
                }
                String[] arr = depts.split("/");
                for(int i = 0;i < arr.length;i++)
                {
                    DeptSeq t = DeptSeq.find(Integer.parseInt(arr[i]),member);
                    if(t.time != null)
                        continue;
                    t.sequence = (int) (System.currentTimeMillis() / 1000);
                    t.set();
                }
            }
            out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
        } catch(Throwable ex)
        {
            out.print("<textarea id='ta'>" + Err.get(h,ex) + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
