package tea.ui.site;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.util.Date;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Profile;
import tea.entity.node.Node;
import tea.entity.site.Community;
import tea.entity.site.License;
import tea.html.*;
import tea.http.RequestHelper;
import tea.resource.Common; //import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.entity.*;

public class EditLicense extends TeaServlet //
{

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException //
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt;</script>");
            TeaSession teasession = new TeaSession(request);
            License obj = License.getInstance();
            String s = obj.getWebName();
            if(s != null && s.length() != 0)
            {
                if(teasession._rv == null)
                {
                    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                    return;
                }
                if(!teasession._rv._strR.equals(teasession._rv._strV) && !teasession._rv._strR.equals(obj.getWebMaster()))
                {
                    response.sendError(403);
                    return;
                }
            }
            String license = h.get("license");
            String website = h.get("website");
            String s3 = h.get("WebName");
            String s4 = h.get("WebMaster");
            String s5 = h.get("WebSupport");
            String s6 = h.get("SmtpServer");
            //启动定时器  开关选项
            String lt[] = request.getParameterValues("Listenertype");
            StringBuffer sp = new StringBuffer("/");

            if(lt != null)
            {
                for(int i = 0;i < lt.length;i++)
                {
                    sp.append(lt[i]).append("/");
                }
            }

            int i = 0;
            String[] lang = h.getValues("language");
            for(int j = 0;j < lang.length;j++)
            {
                i |= 1 << Integer.parseInt(lang[j]);
            }
            obj.set(license,website,s3,s4,s5,s6,0,i,sp.toString());
            if(!Profile.isExisted(s4))
            {
                String sn = request.getServerName() + ":" + request.getServerPort();
                Profile.create(s4,s4,"Home","",sn);
            }
            out.print("<script>mt.show('操作执行成功！');</script>");
        } catch(Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/site/EditLicense");
    }
}
