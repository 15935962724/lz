package tea.service.alerts;

import java.util.Calendar;
import java.util.TimerTask;

public class SampleTask extends TimerTask {

	private static boolean isRunning = false; //是否在运行
	private static final int C_SCHEDULE_HOUR = 10; //时间点

	public SampleTask() {

	}

	public void run() {
    	Calendar cal = Calendar.getInstance(); 
    	if (!isRunning) { 
	    	if (C_SCHEDULE_HOUR == cal.get(Calendar.HOUR_OF_DAY)) { 
		    	isRunning = true; 
		    	System.out.print("开始执行指定任务——邮件");
		    	//TODO 添加自定义的详细任务，以下只是示例
		    	try {
		    		//
			    	HospitalExpiration pm = new HospitalExpiration();
			    	pm.find();
		    		pm.findOneDay();
				} catch (Exception e) {
					e.printStackTrace();
				}
		    	
		    	isRunning = false;
		    	System.out.println("指定任务执行结束——邮件"); 
		    } 
    	} else {
    		System.out.print("上一次任务执行还未结束——邮件");
    	}
    }

	public static void main(String[] args) {
//		ProjectMaintenance pm = new ProjectMaintenance();
//		pm.find();
	}
	
} 


