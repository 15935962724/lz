package tea.service.alerts;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import tea.db.DbAdapter;
import tea.entity.MT;
import tea.entity.member.Email;
import tea.entity.member.SMSMessage;
import tea.entity.yl.shop.ShopSMSSetting;

/**
 * 服务商代理的医院资质到期提醒
 * @author guodh
 * */
public class HospitalExpiration {
	
	/**
	 * 到期的项目 - 提前30天
	 * */
	public void find() {
		DbAdapter db = new DbAdapter();
		try {
			String Qsql = "select id,name from shophospital where addflag=1 and expirationDate is not null and datediff(d,getdate(),expirationDate) = 30";
			ResultSet rs = db.executeQuery(Qsql,0,Integer.MAX_VALUE);
			while (rs.next()) {
				int id = rs.getInt("id");
				String name = rs.getString("name");
				String member = getMember(id);
				String mobiles = "15010780215";
				String mobile_fw=getMobile(id);//2017.1.3加 获取服务商手机
				String email_fw=getEmail(id);//2017.1.3加 获取服务商邮箱
				/*ArrayList<ShopSMSSetting> list = ShopSMSSetting.find("",0,1);
        		if(list.size() > 0){
	    			ShopSMSSetting sms = list.get(0);
	    			List<String> mlist = ShopSMSSetting.getUserMobile(sms.zhtx);
	    			if(!"".equals(MT.f(mlist.toString())))
	    				mobiles = mlist.toString();
        		}*/
				Email.create("Home",null,"guanchunyan@circ.com.cn","服务商代理医院到期提醒","服务商："+member+"代理的医院【"+name+"】还有一个月就到期了，请及时处理！");
				//2017、1、3加，增加服务商邮件通知
				if(email_fw!=""){
				    Email.create("Home",null,email_fw,"服务商代理医院到期提醒","服务商："+member+"代理的医院【"+name+"】还有一个月就到期了，请及时处理！");
				}//发送短信通知
				//String result = SMSMessage.create("Home","SYSTEM",mobiles,1,"服务商代理医院到期提醒：服务商："+member+"代理的医院【"+name+"】还有一个月就到期了，请及时处理！");
		    	//2017、1、3加，增加服务商短信通知
				String result2= SMSMessage.create("Home","SYSTEM",mobile_fw,1,"服务商代理医院到期提醒：服务商："+member+"代理的医院【"+name+"】还有一个月就到期了，请及时处理！");
				//System.out.println(result);
				System.out.println(result2);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			db.close();
		}
	}
	
	/**
	 * 到期的项目 - 提前1天
	 * */
	public void findOneDay() {
		DbAdapter db = new DbAdapter();
		try {
			String Qsql = "select id,name from shophospital where addflag=1 and expirationDate is not null and datediff(d,getdate(),expirationDate) = 1";
			ResultSet rs = db.executeQuery(Qsql,0,Integer.MAX_VALUE);
			while (rs.next()) {
				int id = rs.getInt("id");
				String name = rs.getString("name");
				String member = getMember(id);
				String mobiles = "15010780215";
				String mobile_fw=getMobile(id);//2017.1.3加 获取服务商手机
				String email_fw=getEmail(id);//2017.1.3加 获取服务商邮箱
				/*ArrayList<ShopSMSSetting> list = ShopSMSSetting.find("",0,1);
        		if(list.size() > 0){
	    			ShopSMSSetting sms = list.get(0);
	    			List<String> mlist = ShopSMSSetting.getUserMobile(sms.zhtx);
	    			if(!"".equals(MT.f(mlist.toString())))
	    				mobiles = mlist.toString();
        		}*/
        		
				Email.create("Home",null,"guanchunyan@circ.com.cn","服务商代理医院到期提醒","服务商："+member+"代理的医院【"+name+"】还有一天就到期了，请及时处理！");
				if(email_fw!=""){
					Email.create("Home",null,email_fw,"服务商代理医院到期提醒","服务商："+member+"代理的医院【"+name+"】还有一天就到期了，请及时处理！");
				}
				
				//发送短信通知
				//String result = SMSMessage.create("Home","SYSTEM",mobiles,1,"服务商代理医院到期提醒：服务商："+member+"代理的医院【"+name+"】还有一天就到期了，请及时处理！");
				String result2 = SMSMessage.create("Home","SYSTEM",mobile_fw,1,"服务商代理医院到期提醒：服务商："+member+"代理的医院【"+name+"】还有一天就到期了，请及时处理！");
//		    	System.out.println(result);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			db.close();
		}
	}
	
	/**
	 * 根据hospitalId获取其服务商
	 * @param hospitalId
	 * @return member
	 * */
	private String getMember(int hospitalId) {
		String member = "";	//服务商
		DbAdapter db = new DbAdapter();
		try {
			String Qsql = "select * from profile where hospitals like'%"+hospitalId+"%';";
			ResultSet rs = db.executeQuery(Qsql,0,1);
			while (rs.next()) {
				member = rs.getString("member");
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			db.close();
		}
		return member;
	}
	/**
	 * 根据hospitalId获取服务商电话（ 2017.1.3加）
	 * @param hospitalId
	 * @return
	 */
	private String getMobile(int hospitalId) {
		String mobile = "";	//服务商电话
		DbAdapter db = new DbAdapter();
		try {
			String Qsql = "select * from profile where hospitals like'%"+hospitalId+"%';";
			ResultSet rs = db.executeQuery(Qsql,0,1);
			while (rs.next()) {
				mobile = rs.getString("mobile");
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			db.close();
		}
		return mobile;
	}
	/**
	 * 根据hospitalId获取服务商邮箱（ 2017.1.3加）
	 * @param hospitalId
	 * @return
	 */
	private String getEmail(int hospitalId) {
		String email = "";	//服务商
		DbAdapter db = new DbAdapter();
		try {
			String Qsql = "select * from profile where hospitals like'%"+hospitalId+"%';";
			ResultSet rs = db.executeQuery(Qsql,0,1);
			while (rs.next()) {
				email = rs.getString("email");
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			db.close();
		}
		return email;
	}
	public static void main(String[] args) {
		try {
			Email.create(null,null,"122729637@qq.com","服务商代理医院到期提醒","代理的医院还有一个月就到期了！");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
