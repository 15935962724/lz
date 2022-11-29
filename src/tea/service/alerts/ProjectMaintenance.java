package tea.service.alerts;

import java.sql.ResultSet;
import java.sql.SQLException;

import tea.db.DbAdapter;
import tea.entity.member.SMSMessage;

/**
 * 到期收取维护费的项目
 * @author guodh
 * */
public class ProjectMaintenance {
	
	/**
	 * 到期的项目 - 提前30天
	 * */
	public void find() {
		DbAdapter db = new DbAdapter();
		try {
			String Qsql = "select flowitem,manager from flowitem where period=0 and (365 - datediff(d,nextcosttime,getdate()) % 365) = 30 and year(lastcosttime) < year(getdate())";
			ResultSet rs = db.executeQuery(Qsql,0,Integer.MAX_VALUE);
			while (rs.next()) {
				//项目ID
				int flowitem = rs.getInt("flowitem");
				//项目名称
				String projectName = getProjectName(flowitem);
				//项目负责人
				String manager = rs.getString("manager");
				//项目负责人手机
				String mobile = getMemberMobile(manager);
				//发送短信通知
				String result = SMSMessage.create("redcome2007","webmaster",mobile,1,"您好，您负责的项目：(" + projectName + ")还有一个月将到期！");
		    	System.out.println(result);
//				System.out.println("您好"+manager+"，您负责的项目：(" + projectName + ") 维护交费还有一个月将到期！");
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			db.close();
		}
	}
	
	/**
	 * 根据项目ID获取项目名称
	 * @param flowitem
	 * @return projectName
	 * */
	private String getProjectName(int flowitem){
		DbAdapter db = new DbAdapter();
		String projectName = "";
		try {
			String Qsql = "SELECT name FROM FlowitemLayer where flowitem = " + flowitem;
			ResultSet rs = db.executeQuery(Qsql,0,1);
			while (rs.next()) {
				//项目名称
				projectName = rs.getString("name");
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			db.close();
		}
		return projectName;
	}
	
	/**
	 * 根据member获取其手机
	 * @param manager (example:/yuguangtao/liuhongyan/shangbinjie/)
	 * @return mobile
	 * */
	private String getMemberMobile(String manager) {
		String mobile = "";	//项目负责人手机
		String managerArr[] = manager.split("/");
		if(managerArr.length>1){
			DbAdapter db = new DbAdapter();
			try {
				String Qsql = "select mobile from profile where member='" + managerArr[1] + "'";
				ResultSet rs = db.executeQuery(Qsql,0,1);
				while (rs.next()) {
					//项目负责人手机
					mobile = rs.getString("mobile");
				}
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally{
				db.close();
			}
		}
		return mobile;
	}
}
