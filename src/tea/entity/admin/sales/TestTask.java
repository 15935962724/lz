package tea.entity.admin.sales;

import java.util.Calendar;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;
import tea.entity.admin.sales.*;
import tea.entity.*;
import java.sql.*;



public class TestTask extends Entity
{

    public TestTask()
    {
    }

    private final static long JOB_INTERNAL = 1000 * 60 * 60;

    /*public static void main(String[] args)
    {
        TestTask testtask = new TestTask();
        Timer timer = new Timer();
        //   timer.scheduleAtFixedRate(new   MyTask,   );

        Calendar currentTime = Calendar.getInstance();
        currentTime.setTime(new Date());

       // int currentHour = currentTime.get(Calendar.HOUR);
        int currenMinute = currentTime.get(Calendar.MINUTE);


        currentTime.set(Calendar.HOUR, 0);

        currentTime.set(Calendar.MINUTE, currenMinute+1);
        currentTime.set(Calendar.SECOND, 0);
        currentTime.set(Calendar.MILLISECOND, 0);

        Date NextHour = currentTime.getTime();
        // System.out.println(NextHour);

        Timer t = new Timer();

        t.schedule(new TimerTask()
        {
            public void run()
            {
                Taskfrequency tt = new Taskfrequency();
                try
                {
                    tt.track_option("","");
                } catch (SQLException ex)
                {
                    ex.printStackTrace();
                }

            }
        },  1000*3, 1000*60);


///10月31日
//        //在Date指定的特定时刻之后执行TimerTask的任务
//        Date d1 = new Date(System.currentTimeMillis() + 1000);
//        t.schedule(new TimerTask()
//        {
//            public void run()
//            {
//                TestTask2 task = new TestTask2();
//               task.run();
//
//            }
//        }, d1, 24 * 60 * 60 * 1000);
//  //在5秒之后执行TimerTask的任务
//    t.schedule(new TimerTask(){
//       public void run()
//       {System.out.println("this is task you do1");}
//      },5*1000);
//    //在Date指定的特定时刻之后,每隔1秒执行TimerTask的任务一次
//    Date d2 = new Date(System.currentTimeMillis()+1000);
//    t.schedule(new TimerTask(){
//     public void run()
//     {System.out.println("this is task you do3");}
//    },d2,1*1000);
//
//
//  //在3秒之后,每隔1秒执行TimerTask的任务一次
//    t.schedule(new TimerTask(){
//     public void run()
//     {System.out.println("this is task you do4");}
//    },3*1000,1*1000);
//
//    //在3秒之后,绝对每隔2秒执行TimerTask的任务一次
//
//    t.scheduleAtFixedRate(new TimerTask(){
//     public void run()
//     {System.out.println("this is task you do6");}
//    },3*1000,2*1000);
    }*/
}
