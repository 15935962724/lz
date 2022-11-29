package tea.ui.node.type.gazetteer;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.sql.SQLException;

public class EditDiscourse extends tea.ui.TeaServlet
{
    private static final String CONTENT_TYPE = "text/html; charset=GBK";

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
            final tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            tea.entity.node.Node node = tea.entity.node.Node.find(teasession._nNode);
            String member = teasession.getParameter("member");
            if (member == null)
            {
                member = teasession._rv.toString();
            }
            tea.entity.node.Discourse obj = tea.entity.node.Discourse.find(member);
            String nexturl = teasession.getParameter("nexturl");
            String act = teasession.getParameter("act");
            boolean boold = act.startsWith("d");
            if (act != null && act.startsWith("down")) //下载
            {
                byte by[];
                java.io.File file;
                String name = null;
                if (act.equals("downdiscourse"))
                {
                    file = new java.io.File(getServletContext().getRealPath(obj.getDiscourse()));
                    name = obj.getDiscourseName();
                } else
                {
                    file = new java.io.File(getServletContext().getRealPath(obj.getSyllabus()));
                    name = obj.getSyllabusName();
                }
                java.io.FileInputStream fis = new java.io.FileInputStream(file);
                by = new byte[(int) file.length()];
                fis.read(by);
                fis.close();
                response.setContentType("application/x-msdownload");
                response.setHeader("Content-disposition", "attachment; filename=" + new String(name.getBytes(), "ISO-8859-1"));
                javax.servlet.ServletOutputStream out = response.getOutputStream();
                out.write(by);
                out.close();
                return;
            } else
            if (teasession.getParameter("delete") != null)
            {
                if (boold) //论文
                {
                    obj.deleteDiscourse();
                } else
//if(teasession.getParameter("syllabus")!=null)//提纲
                {
                    obj.deleteSyllabus();
                }
//out.print(new tea.html.Script("alert('已成功删除.');history.back();"));
                // return;
            } else //编辑
            {
                byte by[];
                String name;
                by = teasession.getBytesParameter("content");
                name = teasession.getParameter("contentName");
                if (by == null || name == null)
                {
                    response.setContentType(CONTENT_TYPE);
                    PrintWriter out = response.getWriter();
                    out.print(new tea.html.Script("alert('文件无效.');history.back();"));
                    out.close();
                    return;
                }
                if (!obj.isExists())
                {
                    obj = tea.entity.node.Discourse.create(teasession._rv.toString());
                }
                if (boold) //论文
                {
                    obj.setDiscourse(write(node.getCommunity(), by,".gif"), name);
                } else
                //if(teasession.getParameter("syllabus")!=null)//提纲
                {
                    obj.setSyllabus(write(node.getCommunity(), by,".gif"), name);
                }
            }
            if (nexturl != null && nexturl.length() > 0)
            {
                response.sendRedirect(nexturl);
            } else
            {
                response.sendRedirect("/jsp/type/gazetteer/EditDiscourse.jsp?act=" + (boold ? "discourse" : "syllabus"));
            }
        } catch (IOException ex)
        {
            ex.printStackTrace();
        } catch (SQLException ex)
        {
            ex.printStackTrace();
        } finally
        {
//            out.close();
        }
    }

    //Clean up resources
    public void destroy()
    {
    }
}
