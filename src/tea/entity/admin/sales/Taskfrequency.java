package tea.entity.admin.sales;

import java.sql.*;
import java.text.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class Taskfrequency extends Entity
{
    private int id; // 发生频率的id 与Task中的id意义不相同
    private String community;
    private String assigner; // 被分配的人
    private String motif; // 任务主题
    private Date attime; // 结束日期
    private Date times; // 创建时间
    private String remark; // 备注
    private int fettle; // 状态
    private int pri; // 优先级
    private String member; // 创建人
    private String memberxg; // 修改人
    private Date timexg; // 修改时间
    private String assignerid;
    private int flowitem;
    private String acceefile;
    private String acceename;
    private String ztcontent; // 状态说明
    private int worklog; // 日志号

    // /////////////
    private int frequencyid; // 发生频率
    private int datefq; // /年月日周
    private String week; // 周
    private int month; // 一个月中的第几天创建
    private Date expressdate; // 特殊日期
    private int task; // 对应任务的id号
    private Date Enddatetime; // 结束日期

    public Taskfrequency()
    {
    }

    private boolean exists;
    private static Cache _cache = new Cache(100);

    public static final String Frequencys[] =
            {"------------","每天","每周","每月","特定日期"};
    public static final String Falgs[] =
            {"------------","是","否"};

    public static final String WEEKS[] =
            {"周日","周一","周二","周三","周四","周五","周六"};

    public Taskfrequency(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static Taskfrequency find(int id) throws SQLException
    {
        return new Taskfrequency(id);
    }

    // frequencyid,datefq,week,month,expressdate,task,Enddatetime
    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT assigner,motif,attime,times,remark,fettle,pri,member,memberxg,timexg,assignerid,flowitem,acceefile,acceename,ztcontent,worklog, frequencyid,datefq,week,month,expressdate,task,Enddatetime,community FROM Taskfrequency WHERE id = " + id);
            if(db.next())
            {
                assigner = db.getVarchar(1,1,1);
                motif = db.getVarchar(1,1,2);
                attime = db.getDate(3);
                times = db.getDate(4);
                remark = db.getVarchar(1,1,5);
                fettle = db.getInt(6);
                pri = db.getInt(7);
                member = db.getVarchar(1,1,8);
                memberxg = db.getVarchar(1,1,9);
                timexg = db.getDate(10);
                assignerid = db.getVarchar(1,1,11);
                flowitem = db.getInt(12);
                acceefile = db.getVarchar(1,1,13);
                acceename = db.getVarchar(1,1,14);
                ztcontent = db.getVarchar(1,1,15);
                worklog = db.getInt(16);
                frequencyid = db.getInt(17); // 发生频率
                datefq = db.getInt(18); // /年月日周
                week = db.getString(19); // 周
                month = db.getInt(20); // 一个月中的第几天创建
                expressdate = db.getDate(21); // 特殊日期
                task = db.getInt(22); // 对应任务的id号
                Enddatetime = db.getDate(23); // 结束日期
                community = db.getString(24);
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    // ,frequencyid,datefq,week,month,expressdate,task,Enddatetime
    public static int create(String assigner,String motif,Date attime,String remark,int fettle,int pri,String member,String community,String assignerid,int flowitem,String acceefile,String acceename,int frequencyid,int datefq,String week,int month,Date expressdate,int task,Date Enddatetime) throws SQLException
    {
        int id = 0;
        Date times = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Taskfrequency (assigner,motif,attime,times,remark,fettle,pri,member,community,assignerid,flowitem,acceefile,acceename,frequencyid,datefq,week,month,expressdate,task,Enddatetime)VALUES (" + DbAdapter.cite(assigner) + "," + DbAdapter.cite(motif) + "," + DbAdapter.cite(attime) + "," + DbAdapter.cite(times) + "," + DbAdapter.cite(remark) + "," + fettle + "," + pri + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(assignerid) + "," + flowitem + "," + DbAdapter.cite(acceefile) + ","
                             + DbAdapter.cite(acceename) + "," + frequencyid + "," + datefq + "," + DbAdapter.cite(week) + "," + month + "," + DbAdapter.cite(expressdate) + "," + task + "," + DbAdapter.cite(Enddatetime) + " )");
            id = db.getInt("SELECT MAX(id) FROM Taskfrequency");
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
        return id;
    }

    public static void set(String assigner,String motif,Date attime,String remark,int fettle,int pri,String memberxg,String community,String assignerid,int flowitem,String acceefile,String acceename,int frequencyid,int datefq,String week,int month,Date expressdate,int task,Date Enddatetime,int taskfrequency) throws SQLException
    {
        Date timexg = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Taskfrequency SET  assigner=" + DbAdapter.cite(assigner) + ", motif=" + DbAdapter.cite(motif) + ",attime=" + DbAdapter.cite(attime) + ",remark=" + DbAdapter.cite(remark) + " ,fettle=" + fettle + ",pri=" + pri + ",memberxg=" + DbAdapter.cite(memberxg) + ",timexg=" + DbAdapter.cite(timexg) + ",community=" + DbAdapter.cite(community) + ",assignerid=" + DbAdapter.cite(assignerid) + ",flowitem=" + flowitem + ",acceefile=" + DbAdapter.cite(acceefile) + ",acceename=" + DbAdapter.cite(acceename) + ",frequencyid=" + frequencyid
                             + ",datefq=" + datefq + ",week=" + DbAdapter.cite(week) + ",month=" + month + ",expressdate=" + DbAdapter.cite(expressdate) + ",task=" + task + ",Enddatetime=" + DbAdapter.cite(Enddatetime) + "  WHERE id=" + taskfrequency);
        } finally
        {
            db.close();
        }
        // _cache.remove(new Integer(id));

    }

    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM Taskfrequency WHERE 1=1  " + sql,pos,size);
            while(db.next())
            {
                v.add(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    // /调用进程的类
    public static void track_option(String community,String sql) throws SQLException
    {
        // int frequencyids; //年，月，日，周 {"------------", "每天", "每周", "每月", "特定日期任务添加"};
        // int datefqs;///每天都要发生的
        // int weeks;//周
        // int months;//一个月中的第几天创建
        // Date expressdates;//特殊日期
        // int tasks;//对应任务的id号

        java.util.Date today = new java.util.Date();
        Date yesterday = new Date(System.currentTimeMillis() - 24 * 60 * 60 * 1000);
        Date tomorrow = new Date(System.currentTimeMillis() + 24 * 60 * 60 * 1000);
        Date threedate = new Date(System.currentTimeMillis() + 3 * 24 * 60 * 60 * 1000);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String timetoday = sdf.format(today);
        String timeyesterday = sdf.format(yesterday);
        String timetomorrow = sdf.format(tomorrow);
        String timethree = sdf.format(threedate);

        Enumeration e = Taskfrequency.find(" AND datefq=1 AND Enddatetime >" + DbAdapter.cite(timetoday) + sql,0,Integer.MAX_VALUE);
        while(e.hasMoreElements())
        {
            int id = ((Integer) e.nextElement()).intValue();
            Taskfrequency tf = Taskfrequency.find(id);
            String assigners = tf.getAssigner(); // db.getVarchar(1,1,1);
            String motifs = tf.getMotif();
            Date attimes = tf.getAttime();
            String remarks = tf.getRemark();
            int fettles = tf.getFettle();
            int pris = tf.getPri();
            String members = tf.getMember();
            String assignerids = tf.getAssignerid();
            int flowitems = tf.getFlowitem();
            String acceefiles = tf.getAcceefile();
            String acceenames = tf.getAcceename();
            int frequencyids = tf.getFrequencyid();
            String weeks = tf.getWeek();
            int months = tf.getMonth();
            Date expressdates = tf.getExpressdate();
            String communitys = tf.getCommunity();

            int j = Task.count(communitys," AND Taskfrequency=" + id + " AND times>" + DbAdapter.cite(timetoday) + " AND times<" + DbAdapter.cite(timetomorrow));
            if(j < 1)
            {
                if(frequencyids == 1) // 每天都发生的事情
                {
                    Task.createTask(assigners,motifs,attimes,remarks,fettles,pris,members,communitys,assignerids,flowitems,acceefiles,acceenames,id,1);
                } else if(frequencyids == 2) // 每周的那几天发生任务创建
                {
                    String weekstoday[] = weeks.split("/");
                    java.util.Calendar c = java.util.Calendar.getInstance();
                    int week = c.get(c.DAY_OF_WEEK);
                    week = week - 1;
                    for(int i = 0;i < weekstoday.length;i++)
                    {
                        if(weekstoday[i].toString().equals(String.valueOf(week)))
                        {
                            Task.createTask(assigners,motifs,attimes,remarks,fettles,pris,members,communitys,assignerids,flowitems,acceefiles,acceenames,id,1);
                        }
                    }
                } else if(frequencyids == 3) // 每月的第几天发生任务呼创建
                {
                    java.util.Calendar c = java.util.Calendar.getInstance();
                    int week = c.get(c.DATE);
                    if(week == months)
                    {
                        Task.createTask(assigners,motifs,attimes,remarks,fettles,pris,members,communitys,assignerids,flowitems,acceefiles,acceenames,id,1);
                    }
                } else if(frequencyids == 4) // 特定日期的创建任务
                {
                    String expressdate = sdf.format(expressdates);
                    if(timetoday == expressdate)
                    {
                        Task.createTask(assigners,motifs,attimes,remarks,fettles,pris,members,communitys,assignerids,flowitems,acceefiles,acceenames,id,1);
                    }
                }
            }
        }
    }

    // 添加一个方法是关于，添加一条新的记录并且返回这条记录所对应的记录id
    public static int backnum() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select max(id) from Taskfrequency");
            if(db.next())
            {
                return db.getInt(1);
            } else
            {
                return 0;
            }
        } finally
        {
            db.close();
        }
    }

    public Cache get_cache()
    {
        return _cache;
    }

    public String getAcceefile()
    {
        return acceefile;
    }

    public String getAcceename()
    {
        return acceename;
    }

    public String getAssigner()
    {
        return assigner;
    }

    public String getAssignerid()
    {
        return assignerid;
    }

    public Date getAttime()
    {
        return attime;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getFettle()
    {
        return fettle;
    }

    public int getFlowitem()
    {
        return flowitem;
    }

    public int getFrequency()
    {
        return frequencyid;
    }

    public int getId()
    {
        return id;
    }

    public String getMember()
    {
        return member;
    }

    public String getMemberxg()
    {
        return memberxg;
    }

    public String getMotif()
    {
        return motif;
    }

    public int getPri()
    {
        return pri;
    }

    public String getRemark()
    {
        return remark;
    }

    public Date getTimes()
    {
        return times;
    }

    public Date getTimexg()
    {
        return timexg;
    }

    public int getWorklog()
    {
        return worklog;
    }

    public String getZtcontent()
    {
        return ztcontent;
    }

    public String getWeek()
    {
        return week;
    }

    public int getTask()
    {
        return task;
    }

    public int getMonth()
    {
        return month;
    }

    public int getFrequencyid()
    {
        return frequencyid;
    }

    public Date getExpressdate()
    {
        return expressdate;
    }
	public String getExpressdatetoString()
		{
			if(expressdate!=null)
			{

				return Task.sdf.format(expressdate);
			}
			else
			{
				return "";
			}
	}

    public int getDatefq()
    {
        return datefq;
    }

    public String getCommunity()
    {
        return community;
    }

    public Date getEnddatetime()
    {
        return Enddatetime;
    }

    public String getEnddatetimeToString()
    {
        if(Enddatetime != null)
        {
            return Taskfrequency.sdf.format(Enddatetime);
        } else
        {
            return "";
        }
    }

}
