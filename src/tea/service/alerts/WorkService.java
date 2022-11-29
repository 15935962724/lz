package tea.service.alerts;

import java.util.Timer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class WorkService implements ServletContextListener {
	private Timer timer = null;
	private SampleTask sampleTask = null;
	private SampleTask0 samp_01 = null;
	
	public void contextDestroyed(ServletContextEvent arg0) {
		timer.cancel();
		System.out.println("定时器已销毁");
	}

	public void contextInitialized(ServletContextEvent event) {
		timer = new java.util.Timer(true);
		sampleTask = new SampleTask();	//服务商代理医院到期提醒
		samp_01 = new SampleTask0();	//积分清零
		
		System.out.println("定时器已启动");
//		schedule方法的第一个参数是需要执行的任务,此类的类型为java.util.TimerTask,第二个参数为执行任务前等待时间,此处0表示不等待,第三个参数为间隔时间,单位为毫秒
		
//		timer.schedule(sampleTask, 0, 18000);
//		timer.schedule(samp_01,0, 9000);
		
		timer.schedule(sampleTask, 0, 60 * 60 * 1000);
		timer.schedule(samp_01, 0, 60 * 60 * 1000);
		
		System.out.println("已经添加任务调度表");
	}

}

