

package tea.ui.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.TeaServlet;
import tea.entity.admin.*;
import tea.entity.member.Message;
import java.text.*;



public class EditFileEndorse extends TeaServlet
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
            int fileendorse = 0;
            if (teasession.getParameter("fileendorse") != null && teasession.getParameter("fileendorse").length() > 0)
                fileendorse = Integer.parseInt(teasession.getParameter("fileendorse"));
            FileEndorse feobj = FileEndorse.find(fileendorse);
           if("EditFileendorse".equals(act))
           {

               String acceptmember = teasession.getParameter("acceptmember");
               String caption = teasession.getParameter("caption");
               String content = teasession.getParameter("content");
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
                 fileurl = feobj.getFileurl();
                 filename = feobj.getFilename();
               }
               if(fileendorse>0)
               {
                   feobj.set(teasession._rv.toString(),filename,fileurl,acceptmember,caption,content);
                   str ="文件信息修改成功！";
               }else{
                   FileEndorse.create(teasession._rv.toString(),teasession._strCommunity,filename,fileurl,acceptmember,caption,content);
                   str ="文件信息创建成功！";
               }
           }
           if("delete".equals(act))
           {
               feobj.delete();
               feobj.deletemember();
               str ="文件信息删除成功";
           }
           if("authorize".equals(act))
           {
               feobj.create(fileendorse,teasession._rv.toString(),1,null);
               str="修改成功!";
           }
           if("notauthorize".equals(act))
           {
               String content = teasession.getParameter("content");
               feobj.create(fileendorse,teasession._rv.toString(),-1,content);
               str ="提交成功!";
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

