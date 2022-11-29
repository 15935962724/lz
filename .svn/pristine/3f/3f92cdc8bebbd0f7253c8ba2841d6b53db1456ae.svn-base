package tea.ui.member.profile;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.node.*;
import tea.entity.member.*;

public class EditEducate extends HttpServlet
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
            int id = 0;
            if (teasession.getParameter("id") != null)
            {
                id = Integer.parseInt(teasession.getParameter("id"));
            }
            Node node = Node.find(teasession._nNode);
            Educate educate = Educate.find(id);
            if (!node.isCreator(teasession._rv) || (id != 0 && educate.getNode() != teasession._nNode))
            {
                response.sendError(403);
                return;
            }
            educate.setStart(tea.htmlx.TimeSelection.makeTime(teasession.getParameter("ymStartDate:ymYear"), teasession.getParameter("ymStartDate:ymMonth"), "1"));
            educate.setStop(tea.htmlx.TimeSelection.makeTime(teasession.getParameter("ymEndDate:ymYear"), teasession.getParameter("ymEndDate:ymMonth"), "1"));
            educate.setSchool(teasession.getParameter("tbSchoolName"));
            educate.setCity(teasession.getParameter("tbRegion"));
            educate.setMajorCategory(Integer.parseInt(teasession.getParameter("ddlMajorCategory")));
            educate.setMajorName(teasession.getParameter("tbMajorName"));
            educate.setDegree(teasession.getParameter("ddlDegree"));
            String tbComment = teasession.getParameter("tbComment");
            if (tbComment.length() > 800) //限800字
            {
                tbComment = tbComment.substring(0, 800);
            }
            int anzkl = 0;
            if(teasession.getParameter("anzkl")!=null && teasession.getParameter("anzkl").length()>0)
            {
                anzkl = Integer.parseInt(teasession.getParameter("anzkl"));
            }
            educate.setComment(teasession.getParameter("tbComment"));
            educate.setLanguage(teasession._nLanguage);

            educate.setSland(teasession.getParameter("sland"));
            educate.setAnzkl(anzkl);
            educate.setAnzeh(teasession.getParameter("anzeh"));
            educate.setZzjylx(new java.lang.Boolean(teasession.getParameter("zzjylx")).booleanValue());
            educate.setZzzymc2(teasession.getParameter("zzzymc2"));
            educate.setZzxlbh(teasession.getParameter("zzxlbh"));
            educate.setZzxwsj(educate.sdf.parse(teasession.getParameter("zzxwsjYear") + "-" + teasession.getParameter("zzxwsjMonth") + "-" + teasession.getParameter("zzxwsjDay")));
            educate.setZzjgdz(teasession.getParameter("zzjgdz"));
            educate.setZzxxxs(teasession.getParameter("zzxxxs"));
            educate.setZzzgxl(Boolean.valueOf(teasession.getParameter("zzzgxl")).booleanValue());
            educate.setZzzgxw(Boolean.valueOf(teasession.getParameter("zzzgxw")).booleanValue());
            educate.setZzbsh("true".equals(teasession.getParameter("zzbsh")));
            educate.setZzxlbh2(teasession.getParameter("zzxlbh2"));
            educate.setNode(teasession._nNode);
            educate.set();

            String nexturl = request.getParameter("nexturl");
            response.sendRedirect(nexturl);

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
