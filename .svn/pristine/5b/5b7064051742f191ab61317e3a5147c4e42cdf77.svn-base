package tea.ui.node.type.classes;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.node.*;
import tea.ui.*;
import tea.db.*;

public class EditClasses extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        TeaSession teasession = new TeaSession(request);
        if(teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
            return;
        }
        PrintWriter out = response.getWriter();
        out.write("<script>");
        try
        {
             int id = Integer.parseInt(request.getParameter("classid"));
			 int clchid = 0;
			 if(teasession.getParameter("clchid")!=null && teasession.getParameter("clchid").length()>0)
			 {
				 clchid  = Integer.parseInt(teasession.getParameter("clchid"));
			 }
            String act = teasession.getParameter("act");
            String nu = teasession.getParameter("nexturl");
			int type = 0;
			if(teasession.getParameter("type")!=null && teasession.getParameter("type").length()>0)
			{
				type = Integer.parseInt(teasession.getParameter("type"));
			}
            Classes obj = Classes.find(id);
            if("del".equals(act))
            {
                obj.delete();
                response.sendRedirect(nu);
				return;
            }
			if("delete2".equals(act))
			{
				ClassesChild.delete(clchid);
				response.sendRedirect(nu);
				return;
			}
            if("del2".equals(act))
            {
                int classcid = Integer.parseInt(request.getParameter("classid"));
                ClassesChild.delete(classcid);
                response.sendRedirect(nu);
				return;
            } else if("EditClassesChild".equals(act))
            {
                int classcid = Integer.parseInt(request.getParameter("classcid"));
                ClassesChild obj2 = ClassesChild.find(classcid);
                int class_id = Integer.parseInt(request.getParameter("class_id"));
                String name = teasession.getParameter("name");
                name = name.replaceAll("\"","&quot;");

                if(classcid == 0)
                {
                    if(ClassesChild.getfalg(class_id,name))
                    {
                        out.write("alert(\"标题重复!\");var name=parent.document.form1.name;name.focus();name.select();");
                        return;
                    }
					else
					{
						obj2.set(classcid,class_id,teasession._strCommunity,name,teasession._nLanguage);
					}
                }
				else
				{
					obj2.set(classcid,class_id,teasession._strCommunity,name,teasession._nLanguage);
				}
				 out.write("window.returnValue=true;parent.window.close();");

            }
			else
            {
                String name = teasession.getParameter("name");
                name = name.replaceAll("\"","&quot;");
                Enumeration e = Classes.find(" AND community=" + DbAdapter.cite(teasession._strCommunity) + " AND class_id!=" + id + " AND name=" + DbAdapter.cite(name),0,1);
                if(e.hasMoreElements())
                {
                    out.write("alert(\"标题重复!\");var name=parent.document.form1.name;name.focus();name.select();");
                    return;
                }
                obj.set(teasession._strCommunity,teasession._nLanguage,name,type);
                out.write("window.returnValue=true;parent.window.close();");
            }
        } catch(Exception ex)
        {
            response.sendError(400,ex.toString());
            ex.printStackTrace();
        } finally
        {
            out.write("</script>");
            out.close();
        }
    }
}
