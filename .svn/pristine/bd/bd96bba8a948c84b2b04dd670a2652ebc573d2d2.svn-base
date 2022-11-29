package tea.entity.admin;

import java.sql.*;
import java.text.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class Worklog extends Entity
{
    private static Cache _cache = new Cache(100);
    public static final String STATES_TYPE[] =
            {"1173239677859","1173240146031","1173240155078"}; //已完成,进行中,新添加
    private int worklog;
    private String content;
    private boolean exists;
    private String community;
    private Date time;
    private int workproject;
    private String worklinkman;
    private int worktype;
    private boolean publicity;
    private String member; //姓名
    private int states;
    private String tomember; //to姓名
    private String accessories;
    private String path;
    private boolean sumupreport; //是否是总结报告
    private boolean problemreport; //问题反馈
    private int wearhours; //耗时---小时
    private int wearminutes; //耗时--分钟
    private String revertquestion;
    private String revertmember; ///新加字段 用来记录 回复人的id
    private int score; //得分
    public static final java.text.DecimalFormat dff = new java.text.DecimalFormat("#,#0.0");


    public Worklog(int worklog) throws SQLException
    {
        this.worklog = worklog;
        load();
    }

    public Worklog(String member) throws SQLException
    {
        this.member = member;
        loadmember();
    }


    public static Worklog find(int worklog) throws SQLException
    {
        Worklog obj = (Worklog) _cache.get(new Integer(worklog));
        if(obj == null)
        {
            obj = new Worklog(worklog);
            _cache.put(new Integer(worklog),obj);
        }
        return obj;
    }

    public static Worklog find(String member) throws SQLException
    {
        Worklog obj = (Worklog) _cache.get(member);
        if(obj == null)
        {
            obj = new Worklog(member);
            _cache.put(new Integer(member),obj);
        }
        return obj;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,member,workproject,worklinkman,worktype,time,publicity,content,states,tomember,accessories,path,sumupreport,problemreport,wearhours,wearminutes,revertquestion,revertmember,score FROM Worklog WHERE worklog=" + worklog);
            if(db.next())
            {
                community = db.getString(1);
                member = db.getString(2);
                workproject = db.getInt(3);
                worklinkman = db.getString(4);
                worktype = db.getInt(5);
                time = db.getDate(6);
                publicity = db.getInt(7) != 0;
                content = db.getText(8);
                states = db.getInt(9);
                tomember = db.getString(10);
                accessories = db.getString(11);
                path = db.getString(12);
                sumupreport = db.getInt(13) != 0;
                problemreport = db.getInt(14) != 0;
                wearhours = db.getInt(15);
                wearminutes = db.getInt(16);
                revertquestion = db.getString(17);
                revertmember = db.getString(18);
                score = db.getInt(19);
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    /*新加按姓名 查询出所有属于这个人这个的所有项目*/

    private void loadmember() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,member,workproject,worklinkman,worktype,time,publicity,content,states,tomember,accessories,path,sumupreport,problemreport,wearhours,wearminutes,revertquestion,revertmember FROM Worklog WHERE member=" + member);
            if(db.next())
            {
                community = db.getString(1);
                member = db.getString(2);
                workproject = db.getInt(3);
                worklinkman = db.getString(4);
                worktype = db.getInt(5);
                time = db.getDate(6);
                publicity = db.getInt(7) != 0;
                content = db.getString(8);
                states = db.getInt(9);
                tomember = db.getString(10);
                accessories = db.getString(11);
                path = db.getString(12);
                sumupreport = db.getInt(13) != 0;
                problemreport = db.getInt(14) != 0;
                wearhours = db.getInt(15);
                wearminutes = db.getInt(16);
                revertquestion = db.getString(17);
                revertmember = db.getString(18);
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }


    /*
     * 暂时保留 ** 误删**
         //通过Member来获取参数
         public Worklog (String member) throws SQLException
         {
     this.member = member;
     load_member();
         }
         public static Worklog find(String member) throws SQLException
         {
     Worklog obj = (Worklog)_cache.get(String.valueOf(member));
     if(obj==null)
     {
      obj = new Worklog(member);
      _cache.put(String.valueOf(member), obj);
     }
     return obj;
         }


         private void load_member()throws SQLException
         {
     DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,member,workproject,worklinkman,worktype,time,publicity,content,states,tomember,accessories,path,sumupreport,problemreport,wearhours,wearminutes FROM Worklog WHERE member=" + DbAdapter.cite(member));
            if (db.next())
            {
                community = db.getString(1);
                member = db.getString(2);
                workproject = db.getInt(3);
                worklinkman = db.getString(4);
                worktype = db.getInt(5);
                time = db.getDate(6);
                publicity = db.getInt(7) != 0;
                content = db.getString(8);
                states = db.getInt(9);
                tomember = db.getString(10);
                accessories = db.getString(11);
                path = db.getString(12);
                sumupreport = db.getInt(13) != 0;
                problemreport = db.getInt(14) != 0;
                wearhours = db.getInt(15);
                wearminutes = db.getInt(16);
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
         }
         //通过工作类型
         public Worklog(int worktype,int a) throws SQLException
         {
        this.worktype = worktype;
        load_worktype();
         }

         public static Worklog find_worktype(int worktype) throws SQLException
         {
        Worklog obj = (Worklog) _cache.get(new Integer(worktype));
        if (obj == null)
        {
            obj = new Worklog(worktype);
            _cache.put(new Integer(worktype), obj);
        }
        return obj;
         }
         private void load_worktype() throws SQLException
         {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,member,workproject,worklinkman,worktype,time,publicity,content,states,tomember,accessories,path,sumupreport,problemreport,wearhours,wearminutes FROM Worklog WHERE worktype=" + worktype);
            if (db.next())
            {
                community = db.getString(1);
                member = db.getString(2);
                workproject = db.getInt(3);
                worklinkman = db.getString(4);
                worktype = db.getInt(5);
                time = db.getDate(6);
                publicity = db.getInt(7) != 0;
                content = db.getString(8);
                states = db.getInt(9);
                tomember = db.getString(10);
                accessories = db.getString(11);
                path = db.getString(12);
                sumupreport = db.getInt(13) != 0;
                problemreport = db.getInt(14) != 0;
                wearhours = db.getInt(15);
                wearminutes = db.getInt(16);
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
         }
     */

    public static int create(String community,String member,int workproject,String worklinkman,int worktype,Date time,boolean publicity,String content,int states,String tomember,String accessories,String path,boolean sumupreport,boolean problemreport,int wearhours,int wearminutes) throws SQLException
    {
        int worklog = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Worklog(community,member,workproject,worklinkman,worktype,time,publicity,content,states,tomember,accessories,path,sumupreport,problemreport,wearhours,wearminutes)VALUES(" +
                             DbAdapter.cite(community) + "," + DbAdapter.cite(member) + "," + workproject + "," + DbAdapter.cite(worklinkman) + "," + worktype + "," + DbAdapter.cite(time) + "," + DbAdapter.cite(publicity) + "," + DbAdapter.cite(content) + "," + (states) + "," + DbAdapter.cite(tomember) + "," + DbAdapter.cite(accessories) + " ," + DbAdapter.cite(path) + "," + DbAdapter.cite(sumupreport) + "," + DbAdapter.cite(problemreport) + "," + wearhours + "," + wearminutes + ")");
            worklog = db.getInt("SELECT MAX(worklog) FROM Worklog");
        } finally
        {
            db.close();
        }
        return worklog;
    }


    public void set(String accessories,String path) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Worklog SET accessories=" + DbAdapter.cite(accessories) + ",path=" + DbAdapter.cite(path) + " WHERE worklog=" + worklog);
        } finally
        {
            db.close();
        }
        this.accessories = accessories;
        this.path = path;
    }

    //保存回复问题的答案
    public void set(String revertquestion,int worklog,String revertmember) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Worklog SET problemreport=1 ,  revertquestion=" + DbAdapter.cite(revertquestion) + " ,revertmember=" + DbAdapter.cite(revertmember) + " WHERE worklog=" + worklog);
        } finally
        {
            db.close();
        }
        this.revertquestion = revertquestion;
        this.worklog = worklog;
    }


    public void set(int workproject,String worklinkman,int worktype,Date time,boolean publicity,String content,int states,String tomember,boolean sumupreport,boolean problemreport,int wearhours,int wearminutes) throws SQLException
    {

        //tea.service.SendEmaily sey=new   tea.service.SendEmaily("");
        //sey.sendEmail("fff","","");

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Worklog SET workproject=" + workproject + ",worklinkman=" + DbAdapter.cite(worklinkman) + ",worktype=" + worktype + ",time=" + DbAdapter.cite(time) + ",publicity=" + DbAdapter.cite(publicity) + ",content=" + DbAdapter.cite(content) + ",states=" + states + ",tomember=" + DbAdapter.cite(tomember) + ",sumupreport=" + DbAdapter.cite(sumupreport) + ",problemreport=" + DbAdapter.cite(problemreport) + ",wearhours=" + wearhours + ",wearminutes=" + wearminutes + " WHERE worklog=" + worklog);
        } finally
        {
            db.close();
        }
        this.workproject = workproject;
        this.worklinkman = worklinkman;
        this.worktype = worktype;
        this.time = time;
        this.publicity = publicity;
        this.content = content;
        this.sumupreport = sumupreport;
        this.problemreport = problemreport;
        this.wearhours = wearhours;
        this.wearminutes = wearminutes;
        this.states=states;
    }

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            count = db.getInt("SELECT COUNT(worklog) FROM Worklog WHERE community=" + DbAdapter.cite(community) + sql);
        } finally
        {
            db.close();
        }
        return count;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Worklog WHERE worklog=" + worklog);
        } finally
        {
            db.close();
        }
        this.exists = false;
        _cache.remove(new Integer(worklog));
    }

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT worklog FROM Worklog WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
            while(db.next())
            {
                vector.addElement(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }


    //
    public static Enumeration findWorklog(String community,int worklog) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT DISTINCT workproject FROM Worklog WHERE community=" + DbAdapter.cite(community) + " AND worklog=" + worklog);
            while(db.next())
            {
                vector.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }


    //对项目核算的枚举类型--通过Member
    public static Enumeration find_member(String community,String sql,int pos,int size) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT  distinct (member) from Worklog WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
            while(db.next())
            {
                vector.addElement(String.valueOf(db.getVarchar(1,1,1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

	//实耗成本
	public static int getMembercost(String community,int flowitem)throws SQLException
	{
		 DbAdapter db = new DbAdapter();
         int hours = 0; //小时
         float minutes = 0; //分钟
         int wagetype = 0; //工资标准
         float c = 0; //成本费用
         float cc = 0;
         float aa = 0;
		 try
		 {
			 db.executeQuery("SELECT worklog FROM Worklog WHERE community="+db.cite(community)+" AND  workproject= "+flowitem);
			 while(db.next())
			 {
                 int wid = db.getInt(1);
                 Worklog wobj = Worklog.find(wid);

                 Worklog worobj = Worklog.find(wid);
                 minutes = minutes + worobj.getWearMinutes();
                 hours = hours + worobj.getWearHours();
                 //求出员工的工资标准
                 tea.entity.member.Profile probj = tea.entity.member.Profile.find(worobj.getMember());
                 wagetype = probj.getWagetype() / 20 / 8; //1小时这个用户的工资
                 aa = worobj.getWearMinutes();
                 cc = (worobj.getWearHours() + (aa / 60));
                 c = c + (wagetype * cc); //算出一个用户根据工资标准的 成本
                 //out.print(c+"<br>");
			 }
		 }finally
		 {
			 db.close();
		 }
		 return (int)c;
     }
     public static int getMembercost(String community,String sql) throws SQLException
     {
         DbAdapter db = new DbAdapter();
         int hours = 0; //小时
         float minutes = 0; //分钟
         int wagetype = 0; //工资标准
         float c = 0; //成本费用
         float cc = 0;
         float aa = 0;
         try
         {
             db.executeQuery("SELECT worklog FROM Worklog WHERE community=" + db.cite(community) + sql);
             while(db.next())
             {
                 int wid = db.getInt(1);
                 Worklog wobj = Worklog.find(wid);

                 Worklog worobj = Worklog.find(wid);
                 minutes = minutes + worobj.getWearMinutes();
                 hours = hours + worobj.getWearHours();
                 //求出员工的工资标准
                 tea.entity.member.Profile probj = tea.entity.member.Profile.find(worobj.getMember());
                 wagetype = probj.getWagetype() / 20 / 8; //1小时这个用户的工资
                 aa = worobj.getWearMinutes();
                 cc = (worobj.getWearHours() + (aa / 60));
                 c = c + (wagetype * cc); //算出一个用户根据工资标准的 成本
                 //out.print(c+"<br>");
             }
         } finally
         {
             db.close();
         }
         return(int) c;
     }
    //通过开发类型--核算成本worktype
    public static Enumeration find_worktype(String community,String sql,int pos,int size) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT  distinct (worktype) from Worklog WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    //
    public static Enumeration findByWorkproject(int pos,int size,int workproject) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT worklog FROM Worklog WHERE workproject= " + workproject + " ORDER BY time desc",pos,size);
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }


    public static Enumeration findCommunity() throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT DISTINCT community FROM Worklog ");
            while(db.next())
            {
                vector.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    //通过用户获取开发成本
    public static int count_member(String community,String sql) throws SQLException
    {
        int count = 0;
        float flo = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT worklog FROM Worklog  WHERE community=" + DbAdapter.cite(community) + sql);

            while(db.next())
            {
                Worklog woobj = Worklog.find(db.getInt(1));
                tea.entity.member.Profile probj = tea.entity.member.Profile.find(woobj.getMember());
                flo = flo + (probj.getWagetype() / 20 / 8) * (woobj.getWearHours() + ((float) woobj.getWearMinutes() / 60));
            }
            count = (int) flo;
        } finally
        {
            db.close();
        }
        return count;
    }

    //开发耗时
    public static float count_Hm(String community,String sql) throws SQLException
    {

        float hm = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT worklog FROM Worklog  WHERE community=" + DbAdapter.cite(community) + sql);

            while(db.next())
            {
                Worklog woobj = Worklog.find(db.getInt(1));
                tea.entity.member.Profile probj = tea.entity.member.Profile.find(woobj.getMember());
                hm = hm + (woobj.getWearHours() + ((float) woobj.getWearMinutes() / 60));
            }
        } finally
        {
            db.close();
        }
        return hm;
    }

///
    public static Enumeration findByCommunitymode(String community,String sql,int pos,int size,String falg,int y) throws SQLException
    {
        Vector vector = new Vector();
        java.util.Date today = new java.util.Date();
        Date yesterday = new Date(System.currentTimeMillis() - 2 * 24 * 60 * 60 * 1000);
        Date tomorrow = new Date(System.currentTimeMillis() + 24 * 60 * 60 * 1000);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String timetoday = sdf.format(today);
        String timeyesterday = sdf.format(yesterday);
        String timetomorrow = sdf.format(tomorrow);

        DbAdapter db = new DbAdapter();
        try
        {
//workproject   sql=" group by workproject"
            db.executeQuery("select " + falg + " from Worklog where community=" + DbAdapter.cite(community) + " and  time > " + DbAdapter.cite(timeyesterday) + " and time < " + DbAdapter.cite(timetomorrow) + sql,pos,size);
            while(db.next())
            {

                if(y == 0)
                {
                    vector.addElement(new Integer(db.getInt(1)));
                } else if(y == 1)
                {
                    vector.addElement(db.getString(1));
                }
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static Enumeration findByCommunitytoday(String community,String sql,int pos,int size,String falg,int x) throws SQLException
    {
        Vector vector = new Vector();
        java.util.Date today = new java.util.Date();
        Date yesterday = new Date(System.currentTimeMillis() - 24 * 60 * 60 * 1000);
        Date tomorrow = new Date(System.currentTimeMillis() + 24 * 60 * 60 * 1000);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String timetoday = sdf.format(today);
        String timeyesterday = sdf.format(yesterday);
        String timetomorrow = sdf.format(tomorrow);

        DbAdapter db = new DbAdapter();
        try
        {
            if(x == 0) // 今天
            {
                db.executeQuery("select worklog from Worklog where community=" + DbAdapter.cite(community) + " and   " + DbAdapter.cite(timetoday) + " <time and time < " + DbAdapter.cite(timetomorrow) + sql,pos,size);
                //  System.out.print("select worklog from Worklog where community=" + DbAdapter.cite(community) +  " and   " + DbAdapter.cite(timetoday) + " <time and time < " + DbAdapter.cite(timetomorrow)+sql);
            } else if(x == 1) // 昨天
            {
                db.executeQuery("select worklog from Worklog where community=" + DbAdapter.cite(community) + " and   " + DbAdapter.cite(timeyesterday) + " <time and time < " + DbAdapter.cite(timetoday) + sql,pos,size);
            }
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static int countmode(String community,String sql,String lieming) throws SQLException
    {
        int count = 0;
        Date yesterday = new Date(System.currentTimeMillis() - 2 * 24 * 60 * 60 * 1000);
        Date tomorrow = new Date(System.currentTimeMillis() + 24 * 60 * 60 * 1000);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String timeyesterday = sdf.format(yesterday);
        String timetomorrow = sdf.format(tomorrow);

        DbAdapter db = new DbAdapter();
        try
        {
            count = db.getInt("SELECT COUNT(" + lieming + ") FROM Worklog WHERE community=" + DbAdapter.cite(community) + " and  time > " + DbAdapter.cite(timeyesterday) + " and time < " + DbAdapter.cite(timetomorrow) + sql);
        } finally
        {
            db.close();
        }
        return count;
    }

    public int getWorklog()
    {
        return worklog;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getCommunity()
    {
        return community;
    }

    public Date getTime()
    {
        return time;
    }

    public int getWorkproject()
    {
        return workproject;
    }

    public String getWorklinkman()
    {
        return worklinkman;
    }

    public int getWorktype()
    {
        return worktype;
    }

    public boolean isPublicity()
    {
        return publicity;
    }

    public boolean isSumupreport() //总结报告
    {
        return sumupreport;
    }

    public boolean isProblemreport() //问题反馈
    {
        return problemreport;
    }


    public String getMember()
    {
        return member;
    }

    public int getStates()
    {
        return states;
    }

    public String getToMember()
    {
        return tomember;
    }

    public String getAccessories() //文件的名字
    {
        return accessories;
    }

    public String getPath() //文件路径
    {
        return path;
    }

    public String getTimeToString()
    {
        return sdf.format(time);
    }

    public String getTimeToString2()
    {
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("HH:mm");
        String str = sdf.format(time);
        if("00:00".equals(str))
        {
            return "";
        } else
        {
            return str;
        }
    }

    public String getContent(int language)
    {
        return content;
    }

    public int getWearHours()
    {
        return wearhours;
    }

    public int getWearMinutes()
    {
        return wearminutes;
    }

    public String getRevertQuestion()
    {
        return revertquestion;
    }

    public String getRevertmember()
    {
        return revertmember;
    }

    public int getScore()
    {
        return score;
    }

    public void setScore(int score) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Worklog SET score=" + score + " WHERE worklog=" + worklog);
        } finally
        {
            db.close();
        }
        this.score = score;
    }
}
