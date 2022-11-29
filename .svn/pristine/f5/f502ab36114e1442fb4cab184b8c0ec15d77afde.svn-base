package tea.ui.yl.shop;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import tea.entity.Http;
import tea.entity.member.Profile;
import tea.entity.yl.shop.ShopIntegralRules;
import tea.entity.yl.shop.ShopMyPoints;
import tea.entity.yl.shop.ShopQualification;

/**
 * Servlet implementation class ShopQualifications
 */
public class ShopQualifications extends HttpServlet {

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request, response);
        String act = h.get("act"), nexturl = h.get("nexturl", "");
        ServletContext application = this.getServletContext();
        HttpSession session = request.getSession(true);
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            String message = "操作执行成功！";
            if ("edit".equals(act))
            {
            	int state = h.getInt("state");
            	int qua = h.getInt("qua");
                String name = h.get("name");
                int hospital = h.getInt("hospital");
                int department = h.getInt("department");
                int city = h.getInt("city2");
                String address = h.get("address");
                String mobile = h.get("mobile");
                String telphone = h.get("tel");
                int qualification = h.getInt("qualification.attch");
                if(hospital==-1){
                	out.print("<script>mt.show('请选择医院！');</script>");
                	return;
                }
                if(department==-1){
                	out.print("<script>mt.show('请选择科室！');</script>");
                	return;
                }
                if(city==0){
                	out.print("<script>mt.show('请选择城市！');</script>");
                	return;
                }
                ShopQualification sq = ShopQualification.find(qua);
                sq.member = h.member;
                sq.area = city;
                sq.address = address;
                sq.mobile = mobile;
                sq.hospital_id = hospital;
                sq.department = department;
                sq.qualification = qualification;
                sq.telphone = telphone;
                sq.realname = name;
                sq.status = state;
                sq.set();
                
                message = h.get("mesg"); //提示信息
                
            }else if("updatetype".equals(act)){
            	int qid = h.getInt("qid");
            	ShopQualification sq = ShopQualification.find(qid);
            	int type = h.getInt("type");
            	Date time = h.getDate("validity");
            	String returnv = h.get("returnv");
            	if(type==0){
            		sq.status = (sq.status==1?3:6);
            		sq.returnv = returnv;
            	}else{
            		if(sq.status==1){
            			ShopIntegralRules sir = ShopIntegralRules.findByItem(2);
            			ShopMyPoints.creatPoint(sq.member,"资质通过审核赠送积分", sir.getIntegral(), null);
            		}
            		sq.status = 2;
            		Profile p = Profile.find(sq.member);
            		p.set("validity",time);
            		p.set("qualification","1");
            		p.set("membertype", "1");
            	}
            	sq.set();
            }else if("addmember".equals(act)){
            	int member = h.getInt("member");
            	Date time = h.getDate("validity");
            	int hospital = h.getInt("hospital");
                int department = h.getInt("department");
                String name = h.get("name");
                if(hospital==-1){
                	out.print("<script>mt.show('请选择医院！');</script>");
                	return;
                }
                if(department==-1){
                	out.print("<script>mt.show('请选择科室！');</script>");
                	return;
                }
                ShopQualification.findByMember(member).delete();
            	ShopQualification sq = new ShopQualification(0);
            	sq.member = member;
            	sq.status = 2;
            	sq.hospital_id = hospital;
            	sq.department = department;
            	sq.realname = name;
            	sq.set();
            	Profile p = Profile.find(sq.member);
        		p.set("validity",time);
        		p.set("membertype", "1");
        		p.set("qualification","1");
        		ShopIntegralRules sir = ShopIntegralRules.findByItem(2);
        		ShopMyPoints.creatPoint(sq.member,"资质通过审核赠送积分", sir.getIntegral(), null);
            }else if("updatetime".equals(act)){
            	int qid = h.getInt("qid");
            	ShopQualification sq = ShopQualification.find(qid);
            	Date time = h.getDate("validity");
            	Profile p = Profile.find(sq.member);
        		p.set("validity",time);
        		Date day = new Date();
        		if(time.after(day)){
        			p.set("qualification","1");
        			sq.status = 2;
        		}
            	sq.set();
            }
            out.print("<script>mt.show('" + message + "',1,'" + nexturl + "');</script>");
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
