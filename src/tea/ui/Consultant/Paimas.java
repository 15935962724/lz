package tea.ui.Consultant;

import java.io.CharArrayWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import tea.entity.Entity;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.RV;
import tea.entity.member.Logs;
import tea.entity.member.OnlineList;
import tea.entity.member.Profile;
import tea.entity.member.SMessage;
import tea.ui.TeaServlet;



public class Paimas extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");

            String info = h.get("info","操作执行成功！");
            if("pmwreg".equals(act))
            {
                String username = h.get("username");
                if(username == null || Profile.isExisted(username))
                {
                    out.print("<script>mt.show('抱歉“" + username + "”已存在！');</script>");
                    return;
                }
                String email=h.get("email");
                if(email == null || Profile.isExisted(email))
                {
                    out.print("<script>mt.show('抱歉“" + email + "”已存在！');</script>");
                    return;
                }
                
                int type = h.getInt("type");
                String sname = "verify";
                if(!h.get("verify").equalsIgnoreCase((String) session.getAttribute(sname)))
                {
                    out.print("<script>mt.show('抱歉“验证码”不正确！');</script>");
                    return;
                }
                session.removeAttribute(sname);

                //注册
                Profile p = Profile.create(username,h.get("password"),h.community,email,request.getServerName());
                
                p.setSex(h.getBool("sex"));
                p.setType(2);//注册会员
                p.setFirstName(username, h.language);
                //登录
                RV rv = new RV(username);
                Logs.create(h.community,rv,1,h.node,request.getRemoteAddr());
                OnlineList.create(session.getId(),h.community,username,request.getRemoteAddr());
                session.setAttribute("member",p.getProfile());
                h.setCook("member",MT.enc(p.getProfile() + "|" + p.getPassword()), -1);
                p.setLogin(request.getRemoteAddr(),request.getHeader("user-agent") + " Screen/" + request.getParameter("screen"),new Date());
                out.print("<script>mt.show('注册成功！',1,'" + nexturl + "');</script>");
                return;
            } else if("pmwEdit".equals(act)){
            	 String key = h.get("member");
                 int member = key.length() < 1 ? 0 : Integer.parseInt(MT.dec(key));
                 if(member>0){
                	 Profile p=Profile.find(member);
                	 String name=h.get("name","");
                	 String date=h.get("ttime");
                	 
                	 String email=h.get("email","");
                	 
                	 if(date!=null&&date.length()>1){
                		 p.setBirth(Entity.sdf.parse(date));
                     }
                	 p.setEmail(email);
                	 p.setFirstName(name, h.language);
                	 p.setSex(h.getBool("sex"));
                	 p.setMobile(h.get("mobile",""));
                	 
                 }
                 out.print("<script>mt.show('信息修改成功！',1,'" + nexturl + "');</script>");
                 return;
            	
            } else if("changpwd".equals(act)){
            	String key = h.get("member");
                int member = key.length() < 1 ? 0 : Integer.parseInt(MT.dec(key));
                if(member>0){
                	Profile p=Profile.find(member);
                	String pwd=h.get("pwd");
                	if(pwd.equals(p.getPassword())){
                		p.setPassword(h.get("password"));
                		out.print("<script>mt.show('密码修改成功！',1,'" + nexturl + "');</script>");
                        return;
                	}else{
                		out.print("<script>mt.show('原密码不正确！',1,'" + nexturl + "');</script>");
                        return;
                	}
                }
            }
            
            String key = h.get("member");
            int member = key.length() < 1 ? 0 : Integer.parseInt(MT.dec(key));
            if("del".equals(act)) //删除用户
            {
                String[] arr = member < 1 ? h.getValues("members") : new String[]
                               {String.valueOf(member)};
                for(int i = 0;i < arr.length;i++)
                {
                    Profile p = Profile.find(Integer.parseInt(arr[i]));
                    p.delete();
                }
            }
            

            out.print("<script>mt.show('" + info + "',1,'" + nexturl + "');</script>");
        } catch(Exception ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
