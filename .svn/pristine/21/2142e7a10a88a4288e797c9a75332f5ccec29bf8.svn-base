package tea.ui.member.profile;
import tea.entity.node.*;
import java.io.UnsupportedEncodingException;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletException;
import javax.servlet.ServletConfig;
import tea.ui.TeaSession;
import javax.servlet.http.HttpServletResponse;
import tea.entity.member.Profile;
import tea.ui.TeaServlet;
import java.sql.SQLException;
import tea.entity.admin.*;
import tea.entity.member.*;
public class newcaller extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws UnsupportedEncodingException, IOException
    {
         request.setCharacterEncoding("UTF-8");
         TeaSession teasession = new TeaSession(request);
         String nexturl = teasession.getParameter("nexturl");
         String community = teasession._strCommunity;
         int language = teasession._nLanguage;
         String member = teasession.getParameter("member");
         String  password = teasession.getParameter("password");
         String mobile = teasession.getParameter("mobile");
         String site = teasession.getParameter("site");
         String firstname = teasession.getParameter("firstname");
         int  sex = Integer.parseInt( teasession.getParameter("sex"));
         int cardtype = Integer.parseInt( teasession.getParameter("cardtype"));
         String card = teasession.getParameter("card");
         String role = teasession.getParameter("role");
         int type = 0;
         try{
             Caller.create(member,language, site, password, mobile, firstname, sex,community, cardtype, card,type);
             //默认分配话务员权限 角色
             AdminUsrRole.create(teasession._strCommunity,Profile.find(member).getProfile(),"/"+role+"/","/",0,"/","/");
             //response.sendRedirect(nexturl+"?Node="+teasession._nNode);
              response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode("您已经注册成功，管理员会尽快给您审核!", "UTF-8")+"&nexturl=/jsp/admin/log.jsp" );
         }catch(Exception ex)
         {
             System.out.println(ex.toString());
         }
     }
     public void init(ServletConfig servletconfig) throws ServletException
     {
         super.init(servletconfig);
     }
}
