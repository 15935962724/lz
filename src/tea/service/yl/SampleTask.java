package tea.service.yl;

import java.util.Calendar;
import java.util.TimerTask;

import tea.entity.Filex;
import tea.entity.yl.shop.ShopHospital;
import tea.entity.yl.shop.ShopOrder;
import tea.entity.yl.shop.ShopQualification;

public class SampleTask extends TimerTask {

	private static boolean isRunning = false; //是否在运行
	private static final int C_SCHEDULE_HOUR = 15; //时间点

	public SampleTask() {

	}

	public void run() {
    	Calendar cal = Calendar.getInstance(); 
    	if (!isRunning) { 
	    	if (C_SCHEDULE_HOUR == cal.get(Calendar.HOUR_OF_DAY)) { 
		    	isRunning = true; 
		    	System.out.print("开始执行指定任务");
		    	//TODO 添加自定义的详细任务，以下只是示例
		    	try {

		    		//下单时间如果超过了7天，订单状态自动变更为“已取消”
		    		//ShopOrder.CancelOrderByTimer(int datatype);--datatype:数据库类型(0:mysql,1:sqlserver,2:oracle)
		    		//ShopOrder.CancelOrderByTimer(1);   2020-12-08去除自动取消功能
		    		//发货日期超过7天，订单状态自动变更为“已完成”，并且记录收货时间
//		    		ShopOrder.AutoReceiptOrderByTimer(1);
		    		//资质日期和今天相同修改为资质过期
		    		ShopQualification.updateUserQua();
		    		//月初去除医院的问卷调查次数
					ShopHospital.updateQuestion();
		    		
				} catch (Exception e) {
					e.printStackTrace();
				}
		    	
		    	isRunning = false;
		    	System.out.print("指定任务执行结束"); 
		    } 
    	} else {
    		System.out.print("上一次任务执行还未结束");
    	}
    }

	public static void main(String[] args) {
//		ProjectMaintenance pm = new ProjectMaintenance();
//		pm.find();
	}
	
} 


