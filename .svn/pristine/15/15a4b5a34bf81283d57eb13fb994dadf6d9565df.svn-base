package tea.ui;

import java.io.ByteArrayOutputStream;
import java.io.ObjectOutputStream;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContextAttributeEvent;
import javax.servlet.ServletContextAttributeListener;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.ServletRequestAttributeEvent;
import javax.servlet.ServletRequestEvent;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import javax.servlet.ServletContext;
import tea.entity.member.OnlineList;
import tea.entity.node.*;
import tea.entity.yl.shop.*;
import tea.entity.*;
import tea.entity.stat.TJBaidu;

public class Listener extends HttpServlet implements ServletContextListener,HttpSessionListener
{
    private Timer ts = new Timer(true);
    ServletContext application = null;
    public static ArrayList<Thread> al = new ArrayList();
    public void contextInitialized(ServletContextEvent sce)
    {
        application = sce.getServletContext();

        new Timer("每小时执行一次").schedule(new TimerTask()
        {
            public void run()
            {
                try
                {
                    //Filex.logs("Listener.hour.log","小时：start  id:" + Thread.currentThread().getId());
                    int hour = Calendar.getInstance().get(Calendar.HOUR_OF_DAY);
                    //ShopExchanged.yesupdate();//退货自动确认修改
                    Filex.logs("Listener.log","hour:" + hour);
                    //每季度1点清空
                    if(hour==1) {
                        Filex.logs("clearAQ.log","----------------");
                        String f = MT.f(new Date());
                        String[] split = f.split("-");
                        if(split[1].equals("01")||split[1].equals("04")||split[1].equals("07")||split[1].equals("10")){
                            if(split[2].equals("01")) {//每季度第一天执行
                                Filex.logs("clearAQ.log","-------执行清除服务商满意度、签收人问卷次数---------");
                                Agreed.clearAgreed();
                                Question.clearQuestion();
                            }
                        }
                    }
                    //资质到期 30 天预警  19时
                    if(hour==19){
                        Filex.logs("zizhitixing","hour:" + hour);
                        Filex.logs("zizhitixing","----------------------------------" );
                        ShopHospital.SendMessage();//医院资质到期预警
                        ProcurementUnit.SendMessage();//厂商资质到期预警
                    }

                } catch(Throwable ex)
                {
                    //Filex.logs("Listener.hour.log",ex);
                }
            }
        },10000L,1000L * 60 * 60);
        new Timer("两秒执行一次").schedule(new TimerTask()
        {
            public void run()
            {
                try
                {
                    if(new Date().getHours()>7&&new Date().getHours()<21) {
                        //库存、占用不可为负数
                        List<ProductStock> productStocks = ProductStock.find(" AND amount<0 or ordernum<0 ", 0, Integer.MAX_VALUE);
                        for (int i = 0; i <productStocks.size() ; i++) {
                            ProductStock productStock = productStocks.get(i);
                            productStock.setOrdernum(0);
                            productStock.setAmount(0);
                            productStock.set();
                        }

                    }
                } catch(Throwable ex)
                {
                    Filex.logs("Listener.hour.log",ex);
                }
            }
        },1000L,1000L*10);

        // Backup obj = new Backup();
        // obj.start();
       /* new Thread()
        {
            public void run()
            {
                try
                {
//                    sleep(10000L);
                    //TestTask.main(null); //任务定时器

                    //履友生日 发送短信--已经加入到编辑执照页面设置中
//                    Profile.sync();

                    //PerformOrders.sync();//订座释放订单 定时器--没有用到
//                    DNS.start(); //DDNS同步定时器

//                    Subscibe.robot(); //发送订阅
                    //威斯特活动扫描到期时间--已经加入到编辑执照页面设置中
//                    Event.sync();

//                    Html.start();
//                    Cluster.getInstance().start();

                    //电子版 删除订单没有付费的和过期的订单套餐
                    //    PackageOrder.sync();
                    //差点鉴定更新
                    //  Score.sync();
                    //劳动报 的电子报封面抓取--已经加入到编辑执照页面设置中
//                    ClssnCollection.sync();

                    //威斯特--会员
//                    final String name = System.getenv("COMPUTERNAME");
                    // if(!"LIU".equals(name))
                    //  Westrac.start();
//                    al.add(Course.start());
//                    Stock.start();
//                    SMSMessage.receive(); //自动接收短信
                    //
//                    DbAdapter db = new DbAdapter();
//                    try
//                    {
//                        db.executeQuery("SELECT worklog FROM Worklog WHERE time>" + db.cite(new Date(),true));
//                        if(db.next())
//                        {
//                            RobotSendWorklog.activateRobot();
//                        }
//                        //机器重启PID会变更，所以要清空上次数据
//                        //db.executeUpdate("UPDATE taskmgr SET cpu0=0,received=0,sent=0");
//                    } finally
//                    {
//                        db.close();
//                    }
                    // System.out.println("已经添加任务调度表");
                    //访问统计 2小时更新
                    //ts.schedule(new NodeAccessTrans(),0,2 * 60 * 60 * 1000);
//                    ts.schedule(new NodeAccessTrans(),0,10 * 60 * 1000);

                } catch(Throwable ex)
                {
                    ex.printStackTrace();
                }
            }
        }.start();*/

        //每天执行一次,清理冗余的数据（删除前两月当前天的数据）
      /*  final Date nowDate = new Date(); //当前时间
        Calendar setcal = Calendar.getInstance();
        // 指定02:01:00点执行   传入飞机状态数据值晚上2点1分执行
        setcal.set(Calendar.DATE,nowDate.getDate() + 1); //明天
        setcal.set(Calendar.HOUR_OF_DAY,2);
        setcal.set(Calendar.MINUTE,0);
        setcal.set(Calendar.SECOND,1);
        Date setDate = setcal.getTime();
        // 任务执行周期(毫秒)
        Long setperiod = Long.valueOf(24 * 60 * 60 * 1000);*/

        /*new Timer().schedule(new TimerTask()
        {
            public void run()
            {
                DbAdapter db = new DbAdapter(8);
                System.out.println("开始删除访问统计两月前当天数据时间:" + MT.f(new Date(),1));
                try
                {
                    //开始时间（根据时间段删除NodeAccessReferer_来源表数据，为一天）
                    Calendar startcal = Calendar.getInstance();
                    //startcal.set(Calendar.MONTH, nowDate.getMonth());//前两个月所在月
                    startcal.set(Calendar.DATE,nowDate.getDate() - 61); //前一天（一个月默认为30天）
                    startcal.set(Calendar.HOUR_OF_DAY,0);
                    startcal.set(Calendar.MINUTE,0);
                    startcal.set(Calendar.SECOND,1);
                    String startdate = MT.f(startcal.getTime(),1);
                    Calendar stopcal = Calendar.getInstance();
                    //stopcal.set(Calendar.MONTH, nowDate.getMonth());//前两个月所在月
                    stopcal.set(Calendar.DATE,nowDate.getDate() - 60);
                    stopcal.set(Calendar.MINUTE,0);
                    stopcal.set(Calendar.SECOND,1);
                    String stopdate = MT.f(stopcal.getTime(),1);
                    //根据时间段删除资源表(NodeAccessReferer)中数据
                    db.executeUpdate("delete from NodeAccessReferer where time between '" + startdate + "' and '" + stopdate + "'");
                    //根据时间段删除NodeAccessLastHistory表中数据
                    db.executeUpdate("delete from NodeAccessLastHistory where time between '" + startdate + "' and '" + stopdate + "'");
                } catch(Throwable ex)
                {
                    ex.printStackTrace();
                } finally
                {
                    db.close();
                }
                // 催促垃圾回收器工作
                System.gc();
                // 把CPU让给垃圾回收器线程
                try
                {
                    Thread.sleep(60000);
                } catch(InterruptedException e)
                {
                    e.printStackTrace();
                }
                System.out.println("结束时间:" + MT.f(new Date(),1));
            }
        },setDate,setperiod);
*/
        //每小时执行一次
        /*new Timer().schedule(new TimerTask()
        {
            public void run()
            {
                try
                {
                    Filex.logs("listener.log","小时：start  id:" + Thread.currentThread().getId() + " cache:" + (Entity._cache != null));
                    Calendar c = Calendar.getInstance();
                    int hour = c.get(Calendar.HOUR_OF_DAY);

                    //差异索引
                    ArrayList al = LuceneList.find("",0,Integer.MAX_VALUE);
                    for(int i = 0;i < al.size();i++)
                    {
                        LuceneList t = (LuceneList) al.get(i);
                        t.index(1,hour == 0 && c.get(Calendar.DAY_OF_YEAR) % 10 == 0,null);
                    }
                    if(hour == 0)
                    {
                        Html.start(2);
                        DbAdapter db = new DbAdapter();
                        try
                        {
                            db.executeUpdate("TRUNCATE TABLE sip");
                        } finally
                        {
                            db.close();
                        }
                    }
                    Flowview.activate(); //流程: 收回委托
                    Backups.start(false);
                    Historical.run();

                    //自动授权
                    WConfig wc = WConfig.find("westrac");
                    if(wc.tudouuser != null)
                        wc.token();

                    if(hour != 4)
                        return;

                    //删除到期的Node
                    Iterator it = Course.find(" AND regstop=" + DbAdapter.cite(new Date(),true),0,1000).iterator();
                    while(it.hasNext())
                    {
                        Course t = (Course) it.next();
                        TeaServlet.delete(Node.find(t.node));
                    }

                    //民族服
                    E_News en = new E_News("Home");
                    en.imp(null);
                    en.index(null);

                    //统计
                    int update = 0;
                    long cur = System.currentTimeMillis();
                    Enumeration e = Node.find(" AND type<2",0,Integer.MAX_VALUE);
                    while(e.hasMoreElements())
                    {
                        int node = ((Integer) e.nextElement()).intValue();
                        Node n = Node.find(node);
                        int child = Node.count(" AND path LIKE " + DbAdapter.cite(n.getPath() + "%") + " AND type>1 AND hidden=0 AND finished=1");
                        if(child != n.child)
                        {
                            update++;
                            n.set("child",String.valueOf(n.child = child));
                        }
                    }
                    cur = (System.currentTimeMillis() - cur) / 1000;
                    Filex.logs("listener.log","Node.child：所需时间：" + cur + "ms " + MT.ss((int) cur) + " 更新数量：" + update);

                    IpSec.delete(2);
                } catch(Throwable ex)
                {
                    Filex.logs("listener.log",ex);
                }
            }
        },10000L,1000L * 60 * 60);*/

        //每分钟执行一次
       /* new Timer().schedule(new TimerTask()
        {
            public void run()
            {
                //TaskMgr.ref();
                try
                {
                    Filex.logs("listener.log","分钟：start");
                    Thread.currentThread().setName("每分钟执行一次");
                    ArrayList al = Community.find(" AND wxuser IS NOT NULL",0,200);
                    for(int i = 0;i < al.size();i++)
                    {
                        //WxUser.refresh(community);
                    }
                    Files.start();
                    Smoke.conv();
                    Video.conv();
                    Calendar c = Calendar.getInstance();
                    if(c.get(Calendar.HOUR_OF_DAY) > 6)
                    {
                        if(c.get(Calendar.MINUTE) % 5 == 0)
                            Newsline.ref();
                    }
                    //MTC.run();
                } catch(Throwable ex)
                {
                    Filex.logs("listener.log",ex);
                }
            }
        },20000L,1000L * 60);*/
    }

    // Notification that the servlet context is about to be shut down
    public void contextDestroyed(ServletContextEvent sce)
    {
        for(int i = 0;i < al.size();i++)
        {
            Thread t = al.get(i);
            if(t != null)
            {
                t.interrupt();
            }
        }
        sce.getServletContext().log("BP定时器销毁");
    }

    // SESSION/////////////////////////////////////////////////////////////////////////////////////

    public void sessionCreated(HttpSessionEvent se)
    {
        //HttpSession session = se.getSession();
    }

    // Notification that a session was invalidated
    public void sessionDestroyed(HttpSessionEvent se)
    {
        HttpSession session = se.getSession();

        try
        {
            OnlineList obj = OnlineList.find(session.getId());

            obj.delete();

        } catch(SQLException ex)
        {
        }
        String myuser = (String) application.getAttribute("myuser");

        if(myuser != null && myuser.length() > 0)
        {

            Vector temp = (Vector) application.getAttribute("myuser");

            String member = (String) session.getAttribute("username");

            for(int i = 0;i < temp.size();i++)
            {
                UserForm mylist = (UserForm) temp.elementAt(i);
                if(mylist.username.equals(member))
                {
                    temp.removeElementAt(i);
                    session.setAttribute("username","null");
                    System.out.println("监听器中：聊天室退出用户：" + member);
                }

            }
        }

    }







}
