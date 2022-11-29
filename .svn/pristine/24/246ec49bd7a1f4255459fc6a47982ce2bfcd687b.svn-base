package tea.ui.node.type.trust;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.db.DbAdapter;
import tea.entity.Http;
import tea.entity.RV;
import tea.entity.member.Profile;
import tea.entity.node.Category;
import tea.entity.node.Node;
import tea.entity.trust.TrustCompany;
import tea.entity.trust.TrustProduct;
import tea.newer.Newexperts;

public class TrustProducts extends HttpServlet{
     
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
				String subject = h.get("name");
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
				TrustProduct t=TrustProduct.find(node);
				t.bankName=h.get("bankName");
				t.bankNum=h.get("bankNum");
				
				t.city=h.getInt("city1",h.getInt("city0"));
				t.companyName=h.get("companyName");
				t.companyNode=h.getInt("companyNode");
				t.conditions=h.getInt("conditions");
				t.distribution=h.getInt("distribution");
				t.earnings=h.get("earnings");
				t.earningsType=h.getInt("earningsType");
				t.field=h.getInt("field");
				t.income1=h.getFloat("income1");
				t.income2=h.getFloat("income2");
				t.investmentWay=h.getInt("investmentWay");
				t.maneyUse=h.get("maneyUse");
				t.name=subject;
				
				t.regulatory=h.get("regulatory");
				t.releaseTime=h.getDate("releaseTime");
				t.sizeOf=h.getDouble("sizeOf");
				t.state=h.getInt("state");
				t.threshold=h.getDouble("threshold");
				String timeLimit=h.get("timeLimit");
				if(timeLimit.indexOf("-")==-1){
					t.timeLimit1=Integer.valueOf(timeLimit);
					t.timeLimit2=0;
				}else{
					String temp[]=timeLimit.split("-");
					t.timeLimit1=Integer.valueOf(temp[0]);
					t.timeLimit2=Integer.valueOf(temp[1]);
				}
				t.type=h.getInt("type");
				t.measures=h.get("measures");
				t.deleted=h.getInt("deleted");
				t.node=h.node;
				t.set();
				if(nexturl.length()<1){
					nexturl="/html/"+h.community+"/trustproduct/"+h.node+"-1.htm";
				}
			}else if("changecom".equals(act)){
        		String nname=h.get("ename");

        		out.print("<iframe src='/jsp/type/trustproduct/serchMsg.jsp?nname="+nname+"' scrolling='no' frameborder=0 marginwidth=0 id=xilidiv3>");
        		out.print("</iframe>");
        		return;
        	}
			out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
		}catch (Exception e) {
			out.print("<textarea id='ta'>" + e.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            e.printStackTrace();
		}finally{
			out.close();
		}
		
    }
}
