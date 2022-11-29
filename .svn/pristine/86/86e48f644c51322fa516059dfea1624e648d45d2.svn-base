package tea.entity.westrac;



import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import tea.entity.Entity;
import tea.entity.Http;
import tea.entity.RV;
import tea.entity.SeqTable;
import tea.entity.admin.AdminUsrRole;
import tea.entity.admin.mov.MemberOrder;
import tea.entity.admin.mov.MemberRecord;
import tea.entity.admin.mov.MemberType;
import tea.entity.admin.mov.RegisterInstall;
import tea.entity.integral.IntegralRecord;
import tea.entity.member.Logs;
import tea.entity.member.OnlineList;
import tea.entity.member.Profile;
import tea.entity.site.Communityintegral;
import tea.entity.westrac.WestracIntegralLog;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;


public class EditWestracClue extends TeaServlet
{
        // Initialize global variables
        public void init() throws ServletException
        {
        }
        // Process the HTTP Get request
        public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
        {
                request.setCharacterEncoding("UTF-8");
                response.setContentType("text/html;charset=UTF-8");
                java.io.PrintWriter out = response.getWriter();
                TeaSession teasession = new TeaSession(request);

                HttpSession session =request.getSession();
                String act = teasession.getParameter("act");
                String nexturl = request.getParameter("nexturl");
                Http h=new Http(request);

                try
                {
	                
                	
	                 if("EditWestracClue".equals(act))
	                 {
	                	    int wcid = h.getInt("wcid");
	                		 String wcname=h.get("wcname");//个人信息
	                		 String mobile=h.get("mobile");//个人手机号
	                		
	                		//提供公司的信息
	                		 int industrys=h.getInt("industrys");//所属行业
	                		 String clientname=h.get("clientname");//客户姓名
	                		 String contactname=h.get("contactname");//联系人姓名
	                		 String phone=h.get("phone");//公司电话
	                		 String clientmobile=h.get("clientmobile");//公司手机号
	                		 String city=null;//公司地区
	                		 if(h.get("city0")!=null && h.get("city1")!=null)
	                		 {
	                			 city = h.get("city1");
	                		 }
	                		 
	                		 Date buytime=h.getDate("buytime");//购买预计日期
	                		 String remarks=h.get("remarks");//购买描述
	                		 Date times=new Date();//添加日期 
	                		 String community=h.community;
	                		 String member="";//添加用户，如果是非用户，则为null
	                		 String iprizenameid = h.get("iprizenameid");
	                		 if(iprizenameid!=null && iprizenameid.length()>0)
	                		 {
	                			 if(h.get("member")!=null && h.get("member").length()>0)
	                			 {
	                				 member = h.get("member");
	                			 }
	                		 }else
	                		 {
		                		 if(teasession._rv!=null)
		                		 {
		                			 member = teasession._rv.toString(); 
		                		 }
	                		 }
	                		 
	                		 int exporttype=0;// 0 否，1 是
	                		 String sr = "您的销售线索已经提交成功，请等待管理员...";
	                		 WestracClue wcobj = WestracClue.find(wcid);
	                		 if(wcobj.isExists())
	                		 {
	                			 wcobj.set(wcname, mobile, industrys, clientname, contactname, phone, clientmobile, city, buytime, remarks);
	                			 sr = "会员的销售线索修改成功";
	                		 }else
	                		 {
	                			 WestracClue.create(wcname, mobile, industrys, clientname, contactname, phone, clientmobile, city, buytime, remarks, times, community, member, exporttype);
	                		 }
	                		
	                		 if("my".equals(teasession.getParameter("myact")))
	                		 {
	                			 out.print("<script  language='javascript'>alert('"+sr+"');parent.ymPrompt.close();parent.window.location.reload();</script> ");
	                		 }else 
	                		 {
	                			 out.print("<script  language='javascript'>alert('"+sr+"');window.location.href='"+nexturl+"';</script> ");
	                		 }
	                		 return;
	                		 
	                 }else if("WestracClueDelete".equals(act))
	                 {
	                	  String value[] = request.getParameterValues("checkwcid");
	    		            if(value != null)
	    		            {
	    		            	String next_str ="操作成功"; 
	    		                for(int index = 0;index < value.length;index++)
	    		                {
	    		                    int wcid =Integer.parseInt(value[index]);
	    		                    WestracClue wcobj = WestracClue.find(wcid);
	    		                     wcobj.delete();    		            	  
	    		                }
	    						out.print("<script  language='javascript'>alert('" + next_str + "');window.location.href='" + nexturl + "';</script> ");
	    						return;
	    		            } 
	                 }
                }catch(Exception e)
                {
                	e.getStackTrace();
                }finally
                {
                	out.close();
                }
                
        }
}
