package tea.ui.Consultant;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.entity.Entity;
import tea.entity.Err;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.member.Profile;
import tea.entity.pm.Transactions;
import java.util.Date;

/**
 * Servlet implementation class EditTransactionRecord
 */
public class EditTransactionRecord extends HttpServlet {


	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
    	 response.setContentType("text/html; charset=UTF-8");
         Http h = new Http(request,response);
         String act = h.get("act"),nexturl = h.get("nexturl","");
         ServletContext application = this.getServletContext();
         PrintWriter out = response.getWriter();
         try
         {
             out.print("<script>var mt=parent.mt;</script>");
             if(h.member < 1)
             {
                 out.print("<script>top.location.replace('/servlet/StartLogin?node=" + h.node + "');</script>");
                 return;
             }
             if("edit".equals(act)){
            	 String key = h.get("tid");
                 int tid = key.length() < 1 ? 0 : Integer.parseInt(MT.dec(key));
                 
                 Date ttime=new Date();
                 if(h.get("ttime")!=null&&h.get("ttime").length()>1){
                	 ttime=Entity.sdf2.parse(h.get("ttime"));
                 }
                
                 Transactions.set(h.member,h.community,tid, h.get("varieties"), h.get("direction"),ttime , h.getInt("quantity"),h.getFloat("tmoney") , h.get("content"));
             } else  
             {
            	 if("hidden".equals(act)){
	            	 String key = h.get("tid");
	                 int tid = key.length() < 1 ? 0 : Integer.parseInt(MT.dec(key));
	                 if(tid>0){
	                	 Transactions.hidden(tid);
	                 }
	                 
                 }else if("hiddens".equals(act)){
                	 String[] member = h.getValues("tids");
                     for(int i = 0;i < member.length;i++)
                     {
                    	 if(member[i]!=null){
                    		 int tid = member[i].length() < 1 ? 0 : Integer.parseInt(MT.dec(member[i]));
                    		 Transactions.hidden(tid);
                    	 }
                     }
                	 
	            	                
                 }else if("nhidden".equals(act)){
	            	 String key = h.get("tid");
	                 int tid = key.length() < 1 ? 0 : Integer.parseInt(MT.dec(key));
	                 if(tid>0){
	                	 Transactions.show(tid);
	                 }
	                 
                 }else if("nhiddens".equals(act)){
                	 String[] member = h.getValues("tids");
                     for(int i = 0;i < member.length;i++)
                     {
                    	 if(member[i]!=null){
                    		 int tid = member[i].length() < 1 ? 0 : Integer.parseInt(MT.dec(member[i]));
                    		 Transactions.show(tid);
                    	 }
                     }
                	 
	            	                
                 }
             }
             
             out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
         } catch(Throwable ex)
         {
             out.print("<textarea id='ta'>" + Err.get(h,ex) + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
             ex.printStackTrace();
         } finally
         {
             out.close();
         }
    }

}
