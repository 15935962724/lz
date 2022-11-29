package tea.ui.node.ading;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.Date;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.node.*;
import tea.html.*;
import tea.htmlx.*;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditAding extends TeaServlet
{

    public EditAding()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            int ading = Integer.parseInt(teasession.getParameter("ading"));
            int i = teasession._nNode;
            if(ading > 0)
            {
                i = Ading.find(ading).getNode();
            }
            Node node = Node.find(i);
            if((!node.isCreator(teasession._rv) || !teasession._rv.isAdManager()) && AccessMember.find(teasession._nNode,teasession._rv._strV).getPurview() < 2)
            {
                response.sendError(403);
                return;
            }
            boolean flag1 = teasession._rv.isOrganizer(node.getCommunity());
            boolean flag2 = teasession._rv.isWebMaster();

            int style = Integer.parseInt(teasession.getParameter("style"));
            int i1 = Integer.parseInt(teasession.getParameter("Currency"));
            BigDecimal bigdecimal1 = null;
            try
            {
                bigdecimal1 = new BigDecimal(teasession.getParameter("CPM"));
            } catch(Exception _ex)
            {}
            if(bigdecimal1 == null)
            {
                outText(teasession,response,super.r.getString(teasession._nLanguage,"InvalidCPM"));
                return;
            }
            Date date1 = null;
            Date date3 = null;
            if(teasession.getParameter("AdingOForever") == null)
            {
                date1 = TimeSelection.makeTime(teasession.getParameter("StartYear"),teasession.getParameter("StartMonth"),teasession.getParameter("StartDay"),teasession.getParameter("StartHour"),teasession.getParameter("StartMinute"));
                date3 = TimeSelection.makeTime(teasession.getParameter("StopYear"),teasession.getParameter("StopMonth"),teasession.getParameter("StopDay"),teasession.getParameter("StopHour"),teasession.getParameter("StopMinute"));
            }
            String name = teasession.getParameter("name");
            int position = Integer.parseInt(teasession.getParameter("position"));
            int sequence = Integer.parseInt(teasession.getParameter("sequence"));
            int styletype = Integer.parseInt(teasession.getParameter("type"));
            int ectypal = 0;
            if(teasession.getParameter("ectypal")!=null && teasession.getParameter("ectypal").length()>0)
            {
            	ectypal = 	Integer.parseInt(teasession.getParameter("ectypal"));
            }
            String tmp = teasession.getParameter("stylecategory");
            int stylecategory = 0;
            if(tmp != null && tmp.length() > 0)
            {
                stylecategory = Integer.parseInt(tmp);
            }
            String beforeitem = teasession.getParameter("beforeitem");
            String afteritem = teasession.getParameter("afteritem");
            String picture = teasession.getParameter("picture");
            String imgSize = teasession.getParameter("imgSize");
            String picturepath = picture != null ? picture : teasession.getParameter("picturepath");
            if(ading == 0)
            {
                Ading.create(style,styletype,stylecategory,teasession._nNode,teasession._nStatus,i1,bigdecimal1,date1,date3,teasession._nLanguage,position,sequence,name,beforeitem,
                		afteritem,picturepath,ectypal,imgSize);
            } else
            {
                Ading ad = Ading.find(ading);
                ad.set(style,styletype,stylecategory,i1,bigdecimal1,date1,date3,teasession._nLanguage,position,sequence,name,beforeitem,afteritem,picturepath,ectypal,imgSize);
            }
            response.sendRedirect("/jsp/ading/Adings.jsp?node=" + teasession._nNode);
            return;
        } catch(Exception exception)
        {
            response.sendError(400,exception.toString());
            exception.printStackTrace();
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/node/ading/EditAding");
    }
}
