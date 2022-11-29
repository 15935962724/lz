package tea.ui.node.type.company;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.db.DbAdapter;
import tea.entity.member.Impower;

public class AddUserImpower extends HttpServlet
{

    //Initialize global variables
    public void init() throws ServletException
    {
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
            String member = teasession.getParameter("txtUserName");
            if (tea.entity.member.Profile.isExisted(member))
            {
                response.sendRedirect("/jsp/user/loginerror.jsp?node=" + teasession._nNode);
                return;
            }
            dbadapter.executeUpdate("INSERT INTO ProfileLayer(member,language,firstname,organization,email,telephone,job) VALUES(" +
                                    DbAdapter.cite(member) + "," +
                                    teasession._nLanguage + "," +
                                    DbAdapter.cite(teasession.getParameter("txtName")) + "," +
                                    DbAdapter.cite(teasession.getParameter("selOrg")) + "," +
                                    DbAdapter.cite(teasession.getParameter("txtEmail")) + "," +
                                    DbAdapter.cite(teasession.getParameter("txtTelephone")) + "," +
                                    DbAdapter.cite(teasession.getParameter("txtWork_Title")) + ")" +
                                    " INSERT INTO Profile(member,password) VALUES(" +
                                    DbAdapter.cite(member) + "," +
                                    teasession.getParameter("txtComfirmPwd") + ")");
            Impower impower = new Impower();
            impower.setNode(Integer.parseInt(teasession.getParameter("selCompanyxx"))); //chkRights
            impower.setObject(member);
            impower.setId(teasession.getParameterValues("chkRights"));//Integer.parseInt(teasession.getParameter("chkRights")));
            impower.set();
            response.sendRedirect("Node?node="+teasession._nNode);
        } catch (Exception ex)
        {
            ex.printStackTrace();
        } finally
        {
            dbadapter.close();
        }
    }

    //Clean up resources
    public void destroy()
    {
    }
}
