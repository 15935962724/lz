package tea.ui.Consultant;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import oracle.net.aso.e;

import tea.db.DbAdapter;
import tea.entity.Err;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.member.Profile;
import tea.entity.pm.Transactions;

/**
 * Servlet implementation class EditConsultant
 */
public class EditConsultant extends HttpServlet
{
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
            	 String key = h.get("member");
                 int member = key.length() < 1 ? 0 : Integer.parseInt(MT.dec(key));
                 String password = h.get("password");
                 Profile p;
                 if(member < 1)
                 {
                     String username = h.get("name").trim().toLowerCase();
                     if(Profile.isExisted(username))
                     {
                         out.print("<script>mt.show('“" + username + "”已存在！');</script>");
                         return;
                     }
                     p = Profile.create(username,password,h.community,"",request.getServerName() + ":" + request.getServerPort());
                     member = p.profile;
                     p.setPMMJ(1);
                 } else
                 {
                     p = Profile.find(member); 
                 }

                 if(!"******".equals(password))
                 {
                     p.setPassword(password);
                 }
                 p.setFirstName(h.get("firstname"), h.language);
                 p.setJob(h.get("job"), h.language);
                 p.setTitle(h.get("title"), h.language);
                 p.setIntroduce(h.get("content"), h.language);
                 p.setValidate(h.getBool("ishow"));
                 String logo=h.get("logo");
                 if(logo!=null&&logo.length()>0){
                     p.setPhotopath(h.get("logo"), h.language);
                 }
             } else  //批量删除用户
             {
            	 String key = h.get("member");
                 int member = key.length() < 1 ? 0 : Integer.parseInt(MT.dec(key));
                 String[] arr = member < 1 ? h.getValues("members") : new String[]
                                {String.valueOf(member)};
                 if("del".equals(act)){
	                 for(int i = 0;i < arr.length;i++)
	                 {
	                     Profile p = Profile.find(Integer.parseInt(arr[i]));
	                     p.delete();
	                     
	                     if(p.getPMMJ()==1){
	                    	 Enumeration e=Transactions.find(" AND hidden!=1 AND community="+DbAdapter.cite(h.community)+" AND member="+p.getProfile(), 0, Integer.MAX_VALUE);
	                    	 while(e.hasMoreElements()){
	                    		 int tid=(Integer)e.nextElement();
	                    		 Transactions.delete(tid);
	                    	 }
	                    	 
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
