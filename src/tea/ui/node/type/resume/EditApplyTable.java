package tea.ui.node.type.resume;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.entity.node.*;
import tea.entity.site.*;
import tea.entity.admin.*;

public class EditApplyTable extends TeaServlet
{
    //Initialize global variables
    public void init() throws ServletException
    {
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            String member = teasession._rv._strV;
            String act = teasession.getParameter("act");
            int applytable = Integer.parseInt(teasession.getParameter("applytable"));
            Communityjob communityjob = Communityjob.find(teasession._strCommunity);
            AdminUsrRole aur = AdminUsrRole.find(teasession._strCommunity, member);
            String role = aur.getRole();
            if (applytable == 0 || (applytable != 0 && member.equals(ApplyTable.find(applytable).getMember())) || role.indexOf("/" + communityjob.getRoleapp() + "/") != -1 || role.indexOf("/" + communityjob.getRolecom() + "/") != -1 || role.indexOf("/" + communityjob.getRolejob() + "/") != -1 || role.indexOf("/" + communityjob.getRoleresume() + "/") != -1 || member.equals(tea.entity.site.License.getInstance().getWebMaster()))
            {
            } else
            {
                response.sendError(403);
                return;
            }
            if ("down".equals(act)) //下载
            {
                ApplyTable at_obj = ApplyTable.find(applytable);
                java.io.File objfile = new java.io.File(this.getServletContext().getRealPath(at_obj.getFile()));
                java.io.FileInputStream is = new FileInputStream(objfile);
                byte by[] = new byte[(int) objfile.length()];
                is.read(by);
                is.close();
                /*
                                 String name = teasession.getParameter("name");
                                 if (name == null)
                                 {
                    name = objfile.getName();
                                 }*/
                response.setContentType("application/x-msdownload");
                response.setHeader("Content-disposition", "attachment; filename=" + new String(at_obj.getName().getBytes("GBK"), "ISO-8859-1"));
                response.setContentLength(by.length);
                javax.servlet.ServletOutputStream out = response.getOutputStream();
                out.write(by);
                out.close();
                return;
            } else
            if ("delete".equals(act)) //删除
            {
                ApplyTable atobj = ApplyTable.find(applytable);
                if (atobj.getMember().equals(teasession._rv._strR))
                {
                    atobj.delete();
                    java.io.File f = new java.io.File(this.getServletContext().getRealPath(atobj.getFile()));
                    f.delete();
                } else
                {
                    response.sendError(403);
                    return;
                }
            } else //上传
            {
                byte by[] = teasession.getBytesParameter("file");
                if (by == null)
                {
                    outText(teasession, response, r.getString(teasession._nLanguage, "InvalidFile"));
                } else
                {
                    String name = teasession.getParameter("fileName");
                    //name = name.substring(0, name.lastIndexOf("."));
                    ApplyTable at;
                    if (applytable > 0)
                    {
                        at = ApplyTable.find(applytable);
                        at.setName(name);
                        at.set();
                    } else
                    {
                        at = ApplyTable.create(member, teasession._strCommunity, name);
                    }
                    java.io.File f = new java.io.File(this.getServletContext().getRealPath(at.getFile()));
                    if (!f.getParentFile().exists())
                    {
                        f.getParentFile().mkdirs();
                    }
                    java.io.FileOutputStream fos = new java.io.FileOutputStream(f);
                    fos.write(by);
                    fos.close();
                }
            }
            response.sendRedirect("/jsp/type/resume/Resume.jsp?node=" + teasession._nNode);
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
