

package tea.ui.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.TeaServlet;
import tea.entity.admin.*;
import tea.entity.member.Message;
import java.text.*;



public class EditCertificate extends TeaServlet
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
            String str =null;
            int certificate = 0;
            if (teasession.getParameter("certificate") != null && teasession.getParameter("certificate").length() > 0)
                certificate = Integer.parseInt(teasession.getParameter("certificate"));
            Certificate obj = Certificate.find(certificate);
           if("EditCertificate".equals(act))
           {

               String names = teasession.getParameter("names");
               String cardname = teasession.getParameter("cardname");
               String content = teasession.getParameter("content");
               int type = Integer.parseInt(teasession.getParameter("type"));
               String filename =  "";
               String fileurl ="";
               byte by[] = teasession.getBytesParameter("fileurl");
               if (teasession.getParameter("clear1") != null)
               {
                   fileurl = "";
                   filename ="";
               } else if (by != null)
               {
                   fileurl = write(teasession._strCommunity, by, ".gif");
                   filename =  teasession.getParameter("fileurlName");
               } else
               {
                 fileurl = obj.getFileurl();
                 filename = obj.getFilename();
               }
               if(certificate>0)
               {
                   obj.set(names,cardname,filename,fileurl ,content,type,teasession._rv.toString());
                   str ="证照修改成功！";
               }else{
                   Certificate.create(names,cardname,filename,fileurl,content,type,teasession._rv.toString(),teasession._strCommunity);
                   str ="证照创建成功！";
               }
           }
           if("delete".equals(act))
           {
               obj.delete();
               str ="证照删除成功";
           }


          // response.sendRedirect(nexturl);
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

