package tea.ui.node.type.resume;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import tea.db.DbAdapter;
import java.util.*;
import tea.entity.node.*;
import tea.ui.TeaSession;

public class DeleteResume extends tea.ui.TeaServlet
{

    //Initialize global variables
    public void init() throws ServletException
    {
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            Node node = Node.find(teasession._nNode);
            AccessMember obj_am = AccessMember.find(node._nNode, teasession._rv._strV);
            if (!node.isCreator(teasession._rv) && obj_am.getPurview()<2)
            {
                response.sendError(403);
                return;
            }
//            int language = Integer.parseInt(request.getParameter("Language"));
            dbadapter.executeUpdate(" DELETE FROM Resume WHERE node=" + node._nNode + //����ɾ��
                                    " DELETE FROM Apply WHERE resumenode=" + node._nNode //ְλ��ɾ��
                    ); //+ " AND language=" + language);//Educate    Employment
        } catch (Exception ex)
        {
            ex.printStackTrace();
        } finally
        {
            dbadapter.close();
        }
        response.sendRedirect("/jsp/type/resume/Resume.jsp");
    }

    //Clean up resources
    public void destroy()
    {
    }
}
