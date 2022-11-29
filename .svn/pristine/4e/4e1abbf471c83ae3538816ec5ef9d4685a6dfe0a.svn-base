package tea.ui.admin;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.TeaServlet;
import tea.entity.admin.*;
public class EditManage extends TeaServlet
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
        	String vehicle = teasession.getParameter("vehicle");
        	String factory = teasession.getParameter("factory");
        	String engine = teasession.getParameter("engine");
        	int genre = 0;
        	int maid = 0;
        	if(teasession.getParameter("maid")!=null && teasession.getParameter("maid").length()>0)
        		maid = Integer.parseInt(teasession.getParameter("maid"));
        	Manage obj = Manage.find(maid);
        	if(teasession.getParameter("genre")!=null)
        	{
        		genre = Integer.parseInt(teasession.getParameter("genre"));
        	}
        	String chauffeur = teasession.getParameter("chauffeur");
        	float price = 0;
        	if(teasession.getParameter("price")!=null && teasession.getParameter("price").length()>0)
        	{
        		price = Float.parseFloat(teasession.getParameter("price"));
        	}

        	String pic = null;//图片上传
        	 byte by[] = teasession.getBytesParameter("pic");
        	 if (teasession.getParameter("clear") != null)
 			{
        		 pic = "";
 			} else if (by != null)
 			{
 				pic = write(teasession._strCommunity, by, ".gif");
 			}else
 			{
 				pic = obj.getPic();
 			}

        	Date times = null;
        	if(teasession.getParameter("times")!=null && teasession.getParameter("times").length() >0){

        		times =Bulletin.sdf.parse(teasession.getParameter("times"));
        	}
        	int fettle =0;
        	if(teasession.getParameter("fettle")!=null)
        	{
        		fettle = Integer.parseInt(teasession.getParameter("fettle"));
        	}
        	String remark = teasession.getParameter("remark");
        	if(maid>0)
        	{
        		obj.set(vehicle, factory, engine, genre, chauffeur, price, pic, times, fettle, remark);

        	}else{
        		Manage.create(vehicle, factory, engine, genre, chauffeur, price, pic, times, fettle, remark, teasession._strCommunity, teasession._rv);
        	}
        	response.sendRedirect("/jsp/admin/vehicle/manage1.jsp");
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

