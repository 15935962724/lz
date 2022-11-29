
package tea.ui.admin.sales;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.TeaServlet;
import tea.entity.admin.*;
import tea.entity.admin.sales.*;



public class EditDocument extends TeaServlet
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
        	int doid = 0;
        	
        	if(teasession.getParameter("doid")!=null && teasession.getParameter("doid").length()>0)
        		doid = Integer.parseInt(teasession.getParameter("doid"));
        	Document doobj = Document.find(doid);
        	String documentname = teasession.getParameter("documentname");
        	String keyword = teasession.getParameter("keyword");
        	String fileold = teasession.getParameter("fileoldName");//原文件名字
        	String fileurl = null;
        	String files =null;//暂没有用到
        	String filetype =null;//文件的扩展名 暂没有用到
        	
        		 byte by[] = teasession.getBytesParameter("fileold");
        		 if (teasession.getParameter("clear") != null && teasession.getParameter("clear").length()>0)
      			{
        			 fileurl = "";
      			} else if (by != null)
      			{
      				fileurl = write(teasession._strCommunity, by,"."+fileold.substring(fileold.lastIndexOf(".")+1));
      				
      			}else
      			{
      				fileurl = doobj.getFileurl();
      				fileold = doobj.getFileold();
      			}

        	String remark = teasession.getParameter("remark");
        	if(doid>0)
        	{
        		
        		doobj.set(documentname, keyword, fileold, files, fileurl, remark, filetype, teasession._rv, teasession._strCommunity);
        	}else
        	{
        		Document.create(documentname, keyword, fileold, files, fileurl, remark, filetype, teasession._rv, teasession._strCommunity);
        	}
        	response.sendRedirect("/jsp/admin/sales/document.jsp");
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

