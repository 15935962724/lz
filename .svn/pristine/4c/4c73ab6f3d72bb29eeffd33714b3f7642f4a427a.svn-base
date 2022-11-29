package tea.ui.yl.shop;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.yl.shop.ShopAdvisory;

/**
 * 产品规格/型号
 * */
public class ShopAdvisorys extends HttpServlet{

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request, response);
        String act = h.get("act"), nexturl = h.get("nexturl", "");
        PrintWriter out = response.getWriter();
        
        try {
        	String info="操作执行成功！";
	        out.println("<script>var mt=parent.mt;</script>");
	        int advisoryId = h.getInt("advisoryId");
	        ShopAdvisory sa = ShopAdvisory.find(advisoryId);
	        if("submit".equals(act)){
	        	String verify = h.get("verify");
                String str = h.getCook("verify",null);
                if(verify == null || str == null || !MT.dec(str).equalsIgnoreCase(verify))
                {
                    out.print("<script>mt.show('抱歉，验证码错误！');</script>");
                    return;
                }
	        	if(h.member<1){
	        		out.print("<script>mt.show(\"&nbsp;&nbsp;&nbsp;&nbsp;对不起！您还未登录，登陆后才可以在线留言！<br/>"
						+"已是网站会员，点击<a href='/html/folder/14102033-1.htm' target='_blank'>登录</a>"
						+"&nbsp;&nbsp;还不是网站会员，点击<a href='/html/folder/14102034-1.htm' target='_blank'>注册</a>\");</script>");
	        		return;
	        	}else{
	        		sa.setProduct_id(h.getInt("product_id"));
		        	sa.setMember(h.member);
		        	sa.setDepict(h.get("depict"));
		        	sa.setCreatedate(new Date());
		        	sa.setIsDelete(0);
		        	sa.set();
		        	info = "您提交的咨询，需要管理员审核通过后，才能显示，请您耐心等待！";
	        	}
	        	
	        }else if("reply".equals(act)){
		        sa.setReplyMember(h.member);
		        sa.setDepict(h.get("depict"));
		        sa.setReplycont(h.get("replycont"));
		        sa.setReplyTime(new Date());
		        sa.set();
	        	
	        }else if("del".equals(act)){
	        	sa.set("isDelete","1");
	        }
	        out.print("<script>mt.show('"+info+"',1,'" + nexturl + "');</script>");
        } catch (Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
        
	}

	
}
