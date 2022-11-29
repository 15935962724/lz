package tea.service.alerts;

import java.util.Calendar;
import java.util.TimerTask;

import tea.entity.yl.shop.ShopMyPoints;

public class SampleTask0 extends TimerTask {

	private static boolean isRunning = false; //是否在运行
	private static final int C_SCHEDULE_HOUR = 23; //时间点

	public SampleTask0() {

	}

	public void run() {
    	Calendar cal = Calendar.getInstance(); 
    	if (!isRunning) { 
	    	if (C_SCHEDULE_HOUR == cal.get(Calendar.HOUR_OF_DAY)) { 
		    	isRunning = true; 
		    	System.out.print("开始执行指定任务");
		    	//TODO 添加自定义的详细任务，以下只是示例
		    	try {
		    		//
		    		ShopMyPoints.clearIntegral(cal);//清空无效积分
		    		
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


