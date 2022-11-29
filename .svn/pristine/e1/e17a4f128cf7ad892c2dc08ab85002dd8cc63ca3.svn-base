package tea.ui.cio;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.text.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.member.*;
import tea.entity.cio.*;
import tea.entity.site.*;
import jxl.*;
import jxl.write.*;

public class EditCioPoll extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        TeaSession teasession = new TeaSession(request);
        if(teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(request.getRequestURI() + "?" + request.getQueryString(),"UTF-8"));
            return;
        }
        String act = teasession.getParameter("act");
        String nu = teasession.getParameter("nexturl");
        try
        {
            if(act.equals("edit"))
            {
                int ciocompany = Integer.parseInt(teasession.getParameter("ciocompany"));
                String choose[] = request.getParameterValues("choose");
                String score[] = request.getParameterValues("score");
                CioPoll cp = CioPoll.find(ciocompany);
                if(cp.isExists())
                {
                    cp.set(choose,score);
                } else
                {
                    CioPoll.create(ciocompany,teasession._strCommunity,choose,score);
                }
                PrintWriter out = response.getWriter();
                out.write("<script>");
                out.write("form3=parent.document.form3; alert('问卷调查提交成功');");
                out.write("form3.bs.value='提交'; form3.bs.disabled=false;");
                out.write("</script>");
                out.close();
                return;
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
        response.sendRedirect(nu);
    }
}
