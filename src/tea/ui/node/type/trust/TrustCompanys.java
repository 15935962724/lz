package tea.ui.node.type.trust;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.entity.Http;
import tea.entity.RV;
import tea.entity.member.Profile;
import tea.entity.node.Category;
import tea.entity.node.Node;
import tea.entity.trust.TrustCompany;
import tea.entity.trust.TrustProduct;

public class TrustCompanys extends HttpServlet{
     
	public void service(HttpServletRequest request, HttpServletResponse response)
    		throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		Http h = new Http(request);

		if (h.member < 1) {
			response.sendRedirect("/jsp/user/StartLogin.jsp?nexturl="
					+ request.getRequestURI());
			return;
		}
		PrintWriter out=response.getWriter();
		out.print("<script src='/tea/mt.js' type='text/javascript'></script>");
		String act = h.get("act");
		String nexturl = h.get("nexturl","");
		boolean newnode = h.getBool("NewNode");
		String msg="操作执行成功！";
		try {
			
			if (act.equals("edit")) {
				int node =h.getInt("node");
				String subject = h.get("nameMsg");
                String content = h.get("content");
				Node n=Node.find(node);
				if(newnode){
	                	int options1 = n.getOptions1();
	                    Category cat = Category.find(h.getInt("node"));
	                    h.node = Node.create(h.getInt("node"),0,n.getCommunity(),new RV(Profile.find(h.member).getMember()),cat.getCategory(),(options1 & 2) != 0,n.getOptions(),options1,n.getDefaultLanguage(),null,null,new Date(),n.getStyle(),n.getRoot(),n.getKstyle(),n.getKroot(),null,h.language,subject,subject,null,content,null,null,0,null,null,null,null,null,null,null);
	                    n=Node.find(h.node);
	                    msg="添加成功！";
	            }else{
	            	msg="修改成功！";
	            }
	            n.set(h.language,subject,content);
	            n.finished(h.node);
	            n.setHidden(h.getBool("hidden"));
	            TrustCompany t=TrustCompany.find(node);
				
				t.nameMsg=subject;
				t.background=h.get("background");
				t.bigShareholders=h.get("bigShareholders");
				t.chairman=h.get("chairman");
				t.city=h.getInt("city1",h.getInt("city0"));
				t.type=h.getInt("type");
				t.isListed=h.getInt("isListed");
				t.legalPerson=h.get("legalPerson");
				t.logo=h.get("logo.attch");
				t.name=h.get("name");
				t.regMoney=BigDecimal.valueOf(h.getDouble("regMoney"));
				t.scopeOf=h.get("scopeOf");
				t.time=h.getDate("time");
				t.yield=BigDecimal.valueOf(h.getDouble("yield"));
				
				t.deleted=h.getInt("deleted");
				t.node=h.node;
				t.set();
				if(nexturl.length()<1){
					nexturl="/html/"+h.community+"/trustcompany/"+h.node+"-1.htm";
				}
			}
			out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
		}catch (Exception e) {
			out.print("<textarea id='ta'>" + e.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            e.printStackTrace();
		}
		
    }
}
