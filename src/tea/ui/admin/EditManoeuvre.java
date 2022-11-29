

package tea.ui.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.TeaServlet;
import tea.entity.admin.*;
import tea.entity.member.Message;
import java.text.*;



public class EditManoeuvre extends TeaServlet
{

    //Initialize global variables
    public void init() throws ServletException
    {
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        tea.ui.TeaSession teasession = null;
        teasession = new tea.ui.TeaSession(request);
        try
        {
            String act = teasession.getParameter("act");
            String nexturl = teasession.getParameter("nexturl");
            String str ="操作失败";
            int manoeuvre= 0;
            if(teasession.getParameter("manoeuvre")!=null && teasession.getParameter("manoeuvre").length()>0)
                manoeuvre = Integer.parseInt(teasession.getParameter("manoeuvre"));
            Manoeuvre  mobj = Manoeuvre.find(manoeuvre);
            if("EditManoeuvre".equals(act))
            {
                String manmember = teasession.getParameter("manmember");
                String content = teasession.getParameter("content");
                String formerduty = teasession.getParameter("formerduty");
                String backduty = teasession.getParameter("backduty");
                Date mantime =Manoeuvre.sdf.parse(teasession.getParameter("mantime"));
                String audmamber = teasession.getParameter("audmamber");
                if (manoeuvre > 0)
                {
                    mobj.set(manmember, content, formerduty, backduty, mantime, audmamber, teasession._rv.toString());
                    str = "人事调动修改成功！";
                } else
                {
                    Manoeuvre.create(manmember, content, formerduty, backduty, mantime, audmamber, teasession._rv.toString(), teasession._strCommunity);
                    str = "人事调动添加成功！";
                }
            }

            if("delete".equals(act))
            {
                mobj.delete();
                str="人事调动记录删除成功！";
            }
            if("piz".equals(act))//批准
            {
               mobj.set(1);
               str="人事调动审批成功！";
            }
            if("bupiz".equals(act))
            {
                mobj.set(-1);
                str="人事调动审批成功！";
            }
           response.sendRedirect("/jsp/info/Succeed.jsp?info="+ java.net.URLEncoder.encode(str,"UTF-8")+"&nexturl="+nexturl);
        }catch (Exception ex)
        {
            ex.printStackTrace();

        }


    }

    //Clean up resources
    public void destroy()
    {
    }
}

