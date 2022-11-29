package tea.ui.node.type.Application;

import java.io.*;
import java.util.Date;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.db.DbAdapter;
import tea.entity.RV;
import tea.entity.node.*;
import tea.entity.site.License;
import tea.entity.site.TypeAlias;
import tea.html.*;
import tea.htmlx.*;
import tea.http.MultipartRequest;
import tea.resource.Common;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.http.RequestHelper;

public class EditApp extends TeaServlet
{

    public EditApp()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            if(request.getMethod().equals("GET"))
            {
                String qs = request.getQueryString();
                response.sendRedirect("/jsp/type/application/EditApp.jsp?" + qs);
                return;
            }

            TeaSession teasession = new TeaSession(request);
            {
                String s11 = teasession.getParameter("xm"); //�� ��
                String s22 = teasession.getParameter("xb");
                String s33 = teasession.getParameter("xl");
                String s44 = teasession.getParameter("xw"); //����ְλ
                String s55 = teasession.getParameter("zw");
                String s77 = teasession.getParameter("xdw");
                String s88 = teasession.getParameter("xbm");
                String s99 = teasession.getParameter("xgw");
                String s10 = teasession.getParameter("phone");
                String s111 = teasession.getParameter("mobile");
                byte abyte0[] = teasession.getBytesParameter("File");

                String s12 = teasession.getParameter("email");
                int k1 = 2113929216;
                if(!RequestHelper.isEmail(s12))
                {
                    outText(teasession,response,super.r.getString(teasession._nLanguage,"InvalidEmail"));
                    return;
                }

                int l3 = teasession._nNode;
                Date date4 = TimeSelection.makeTime(teasession.getParameter("IssueYear"),teasession.getParameter("IssueMonth"),teasession.getParameter("IssueDay"),teasession.getParameter("IssueHour"),teasession.getParameter("IssueMinute"));
                Date date2 = TimeSelection.makeTime(teasession.getParameter("cjgzrqYear"),teasession.getParameter("cjgzrqMonth"),teasession.getParameter("cjgzrqDay"),teasession.getParameter("cjgzrqHour"),teasession.getParameter("cjgzrqMinute"));

                boolean newnode = teasession.getParameter("NewNode") != null;
                if(newnode)
                {
                    Node node1 = Node.find(teasession._nNode);
                    long options = node1.getOptions();
                    int options1 = node1.getOptions1();
                    int defautllangauge = node1.getDefaultLanguage();
                    Category cat = Category.find(teasession._nNode); //42
                    teasession._nNode = Node.create(node1._nNode,0,node1.getCommunity(),new tea.entity.RV("webmaster","Home"),cat.getCategory(),(options1 & 2) != 0,options,options1,defautllangauge,null,null,new java.util.Date(),0,0,0,0,null,teasession._nLanguage,s11,"","",s44,null,"",0,null,"","","","",null,"");
                    node1.finished(teasession._nNode);
                } else
                {
                }
                Application application = new Application(teasession._nNode);
                application.set(teasession._nNode,s11,s22,date4,s33,s44,s55,date2,s77,s88,s99,s10,s111,s12);
                if((abyte0 != null))
                {
                    ByteArrayOutputStream bytestream = new ByteArrayOutputStream();
                    bytestream.write(abyte0);
                    String filefile = getServletContext().getRealPath("/tea/app/" + teasession._nNode + ".doc");
                    OutputStream filesave = new FileOutputStream(filefile);
                    bytestream.writeTo(filesave);
                    filesave.close();
                }
                response.sendRedirect("Node?node=" + l3);
            }
        } catch(Exception exception)
        {
            response.sendError(400,exception.toString());
            exception.printStackTrace();
        }
    }
}
