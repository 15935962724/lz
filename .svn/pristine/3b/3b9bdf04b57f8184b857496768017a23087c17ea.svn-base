

package tea.ui.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.TeaServlet;
import tea.entity.admin.*;
import tea.entity.member.Message;
import java.text.*;



public class EditAmend extends TeaServlet
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
        	int apid =0;
        	if(teasession.getParameter("apid")!=null && teasession.getParameter("apid").length()>0)
        	{
        		apid = Integer.parseInt(teasession.getParameter("apid"));
        	}
        	
        	String vehicle1 =teasession.getParameter("vehicle");//车牌id 和车辆的司机
        	String a[] = vehicle1.split("#");
        	String  vehicle = a[0];//车辆的ID（int）
        	String chauffeur = a[1];//司机
        	String man = teasession.getParameter("man");
        	int unit =0;
        	if(teasession.getParameter("unit")!=null && teasession.getParameter("unit").length()>0)//用车部门ID
        		unit = Integer.parseInt(teasession.getParameter("unit"));
        	
        	String timek = teasession.getParameter("timek");//年月日
        	String begintime = teasession.getParameter("begintime");//时分秒
        	String begintime1 = teasession.getParameter("begintime1");
        	
        	String timej = teasession.getParameter("timej");
        	String begintime2 = teasession.getParameter("begintime2");
        	String begintime22 = teasession.getParameter("begintime22");
        	
        	String timesd1 = timek+" "+begintime +":"+ begintime1;//开始时间
        	String timesd2 = timej+" "+begintime2+":"+begintime22;//结束时间
        	Date times1=null,times2=null;
        	DateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm");
        	if(timesd1!=null && timesd1.length()>0) 
        	{
        		times1 = format.parse(timesd1);
        	}
        	if(timesd2!=null && timesd2.length()>0)
        	{
        		times2 = format.parse(timesd2);
        	}
        	
        	String destination = teasession.getParameter("destination");
        	int mileage =0;
        	if(teasession.getParameter("mileage")!=null && teasession.getParameter("mileage").length()>0)
        		mileage = Integer.parseInt(teasession.getParameter("mileage"));
        	String findingmanid =teasession.getParameter("findingmanid");
        	
        	String attemper = teasession.getParameter("attemper");
        	//在线调度人员空缺
        	String cause = teasession.getParameter("cause");
        	String remark = teasession.getParameter("remark");
        	int type = 0;
        	int uses =0;
        	
        	String checkbox1 = teasession.getParameter("checkbox1");
        	String checkbox2 = teasession.getParameter("checkbox2");
        	
        	  if(checkbox1!=null)
              {
              	 //tea.entity.member.Profile profile1 = tea.entity.member.Profile.find(node.getCreator()._strR);
                   //String s11 = profile1.getMember();
              	//Message.create(teasession._strCommunity, teasession._rv, null, 0, 0, 0, 0, teasession._nLanguage,"回复:"+ node.getSubject(teasession._nLanguage),"<font color=red>您的回复是：</font>"+ text+"<hr>"+node.getText(teasession._nLanguage), null, null, "", null,s11 , "", "", null, null, 0, 0);
              }
        	  
        	  if(apid>0)
        	  {
        		  Applys apobj = Applys.find(apid);
        		  apobj.set(vehicle, chauffeur, man, unit, times1, times2, destination, mileage, findingmanid, attemper, cause, remark, type, uses);
        	  }else
        	  {
        		  Applys.create(vehicle, chauffeur, man, unit, times1, times2, destination, mileage, findingmanid, attemper, cause, remark, type, uses, teasession._strCommunity,teasession._rv);
        	  }
        	  
        	  response.sendRedirect("/jsp/admin/vehicle/query/query_all.jsp");
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

