package tea.entity.admin.sales;

import java.sql.*;
import java.text.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import tea.entity.member.*;

public class Task extends Entity
{
    private int id;
    private String assigner; // 被分配的人
    private String motif; // 任务主题
    private Date attime; // 到期日期
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
    private int Taskfrequency; //标识是否是周期性任务
    private int datefq; //
    private boolean exists;
    private static Cache _cache = new Cache(100);

    public static final String FETTLE[] =
            {"------------","进行中","已完成","等待其他人","延迟"};
    public static final String PRI[] =
            {"------------","高","普通","低"};

    public Task(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static Task find(int id) throws SQLException
    {
        return new Task(id);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT assigner,motif,attime,times,remark,fettle,pri,member,memberxg,timexg,assignerid,flowitem,acceefile,acceename,ztcontent,worklog,Taskfrequency,datefq FROM Task WHERE id = " + id);
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
                Taskfrequency = db.getInt(17);
                datefq = db.getInt(17);
            } else
            {
                this.exists = false;

            }
        } finally
        {
            db.close();
        }
    }

    public static int create(String assigner,String motif,Date attime,String remark,int fettle,int pri,String member,String community,String assignerid,int flowitem,String acceefile,String acceename) throws SQLException
    {
        int id = 0;
        Date times = new Date();
        DbAdapter db = new DbAdapter();
        try
        {

            db.executeUpdate("INSERT INTO Task (assigner,motif,attime,times,remark,fettle,pri,member,community,assignerid,flowitem,acceefile,acceename)VALUES (" + DbAdapter.cite(assigner) + "," + DbAdapter.cite(motif) + "," + DbAdapter.cite(attime) + "," + DbAdapter.cite(times) + "," + DbAdapter.cite(remark) + "," + fettle + "," + pri + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(assignerid) + "," + flowitem + "," + DbAdapter.cite(acceefile) + "," + DbAdapter.cite(acceename) + "  )");
            id = db.getInt("SELECT @@IDENTITY");
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
        return id;
    }

    public static int createTask(String assigner,String motif,Date attime,String remark,int fettle,int pri,String member,String community,String assignerid,int flowitem,String acceefile,String acceename,int Taskfrequency,int datefq) throws SQLException
    {
        int id = 0;
        Date times = new Date();
        DbAdapter db = new DbAdapter();
        try
        {

            db.executeUpdate("INSERT INTO Task (assigner,motif,attime,times,remark,fettle,pri,member,community,assignerid,flowitem,acceefile,acceename,Taskfrequency,datefq)VALUES (" + DbAdapter.cite(assigner) + "," + DbAdapter.cite(motif) + "," + DbAdapter.cite(attime) + "," + DbAdapter.cite(times) + "," + DbAdapter.cite(remark) + "," + fettle + "," + pri + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(assignerid) + "," + flowitem + "," + DbAdapter.cite(acceefile) + "," + DbAdapter.cite(acceename) + "," + Taskfrequency + "," + datefq + " )");
            id = db.getInt("SELECT @@IDENTITY");
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
        return id;
    }

    public void set(String assigner,String motif,Date attime,String remark,int fettle,int pri,String memberxg,String community,String assignerid,int flowitem,String acceefile,String acceename) throws SQLException
    {
        Date timexg = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Task SET  assigner=" + DbAdapter.cite(assigner) + ", motif=" + DbAdapter.cite(motif) + ",attime=" + DbAdapter.cite(attime) + ",remark=" + DbAdapter.cite(remark) + " ,fettle=" + fettle + ",pri=" + pri + ",memberxg=" + DbAdapter.cite(memberxg) + ",timexg=" + DbAdapter.cite(timexg) + ",community=" + DbAdapter.cite(community) + ",assignerid=" + DbAdapter.cite(assignerid) + ",flowitem=" + flowitem + ",acceefile=" + DbAdapter.cite(acceefile) + ",acceename=" + DbAdapter.cite(acceename) + "  WHERE id=" + id);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));

    }

    public void setTask(String assigner,String motif,Date attime,String remark,int fettle,int pri,String memberxg,String community,String assignerid,int flowitem,String acceefile,String acceename) throws SQLException
    {
        Date timexg = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Task SET  assigner=" + DbAdapter.cite(assigner) + ", motif=" + DbAdapter.cite(motif) + ",attime=" + DbAdapter.cite(attime) + ",remark=" + DbAdapter.cite(remark) + " ,fettle=" + fettle + ",pri=" + pri + ",memberxg=" + DbAdapter.cite(memberxg) + ",timexg=" + DbAdapter.cite(timexg) + ",community=" + DbAdapter.cite(community) + ",assignerid=" + DbAdapter.cite(assignerid) + ",flowitem=" + flowitem + ",acceefile=" + DbAdapter.cite(acceefile) + ",acceename=" + DbAdapter.cite(acceename) + "  WHERE id=" + id);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));

    }

    public static void set(int fettle,int taid,String community,String ztcontent,int worklog) throws SQLException
    {
        Date timexg = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Task SET  fettle=" + fettle + ",ztcontent=" + DbAdapter.cite(ztcontent) + ",worklog=" + worklog + "   WHERE community =" + DbAdapter.cite(community) + " and id=" + taid);
        } finally
        {
            db.close();
        }
    }

    // 修改工作日志号
    public static void set(int id,int worklog,String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Task SET  worklog=" + worklog + "  WHERE community =" + DbAdapter.cite(community) + " and id=" + id);
        } finally
        {
            db.close();
        }
    }

    public static Enumeration findByCommunity(String community,String sql) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM Task WHERE community=" + DbAdapter.cite(community) + sql);
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

    /* 10-12 */
    public static Enumeration findByCommunitybh(String community,String sql,String bianhuan,int i) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT " + bianhuan + " FROM Task WHERE community=" + DbAdapter.cite(community) + sql);
            while(db.next())
            {
                if(i == 1) // 字符串
                {
                    vector.addElement(db.getString(1));
                } else if(i == 2) // 数值
                {
                    vector.addElement(new Integer(db.getInt(1)));
                } else if(i == 3) // 时间
                {

                }

            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static Enumeration findByCommunitybh2(String community,String sql,String bianhuan,int i,int pos,int size) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT " + bianhuan + " FROM Task WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
            while(db.next())
            {
                if(i == 1) // 字符串
                {
                    vector.addElement(db.getString(1));
                } else if(i == 2) // 数值
                {
                    vector.addElement(new Integer(db.getInt(1)));
                } else if(i == 3) // 时间
                {

                }
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    // 按接受人转换
    public static Enumeration findByCommunitybh3(String community,String sql,String bianhuan,int i,int pos,int size) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select distinct p.member from Profile p,Task t where t.community=" + DbAdapter.cite(community) + " and t.assignerid like '%/'+ p.member+'/%' and fettle!=2",pos,size);
            while(db.next())
            {
                if(i == 1) // 字符串
                {
                    vector.addElement(db.getString(1));
                } else if(i == 2) // 数值
                {
                    vector.addElement(new Integer(db.getInt(1)));
                } else if(i == 3) // 时间
                {

                }
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    // Date d = new Date(System.currentTimeMillis() - 24 * 60 * 60 * 1000);
    public static Enumeration findByCommunity(String community,String sql,int pos,int size) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM Task WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
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

    public static Enumeration findByCommunitytime(String community,String sql,int pos,int size,int x) throws SQLException
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
                db.executeQuery("SELECT id FROM Task WHERE community=" + DbAdapter.cite(community) + sql + " and   " + DbAdapter.cite(timetoday) + " <times and times < " + DbAdapter.cite(timetomorrow),pos,size);
            } else if(x == 1) // 昨天
            {
                db.executeQuery("SELECT id FROM Task WHERE community=" + DbAdapter.cite(community) + sql + " and   " + DbAdapter.cite(timeyesterday) + " <times and times < " + DbAdapter.cite(timetoday),pos,size);
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

    public static int counttime(String community,int i) throws SQLException
    {
        int count = 0;
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
            // count = db.getInt(" select count(*) from Task where community="+ DbAdapter.cite(community)+" and fettle!=2 and "+DbAdapter.cite(timez)+" < times and times< "+DbAdapter.cite(timej));
        } finally
        {
            db.close();
        }
        return count;
    }

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            count = db.getInt("SELECT COUNT(id) FROM Task WHERE community=" + DbAdapter.cite(community) + sql);
            // System.out.println("SELECT COUNT(*) FROM Task WHERE community=" + DbAdapter.cite(community) + sql);
        } finally
        {
            db.close();
        }
        return count;
    }

    /** ****项目分类 和 创建人分类****** */
    public static int count(String community,String sql,String str) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            count = db.getInt("SELECT COUNT(" + str + ") FROM Task WHERE community=" + DbAdapter.cite(community) + sql);
            // System.out.println("SELECT COUNT(" + str + ") FROM Task WHERE community=" + DbAdapter.cite(community) + sql);
        } finally
        {
            db.close();
        }
        return count;
    }

    public static int countmember(String community,String sql,String list,String table) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            count = db.getInt("select count(distinct p.member) from Profile p,Task t where t.community=N'REDCOME' and t.assignerid like '%/'+ p.member+'/%' and fettle!=2");
            // count = db.getInt("select count("+list+") from "+table+" where t.community "+DbAdapter.cite(community)+sql);
        } finally
        {
            db.close();
        }
        return count;

    }

    // /提交人 列表
    public static Enumeration findByAssignerid(String community,String assignerid) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT DISTINCT member FROM Task WHERE community=" + DbAdapter.cite(community) + " AND assignerid LIKE " + DbAdapter.cite("%/" + assignerid + "/%"));
            while(db.next())
            {
                v.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    // /接纳人 列表
    public static Enumeration findByMember(String community,String member) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT DISTINCT assignerid FROM Task WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member));
            while(db.next())
            {
                String m = db.getString(1);
                String ms[] = m.split("/");
                for(int i = 1;i < ms.length;i++)
                {
                    if(ms[i].length() > 0 && v.indexOf(ms[i]) == -1)
                    {
                        v.addElement(ms[i]);
                    }
                }
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Task WHERE id=" + id);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
    }

    public String getAssigner()
    {
        return assigner;
    }

    public String getMotif()
    {
        return motif;
    }

    public Date getAttime()
    {
        return attime;
    }

    public String getAttimeToString()
    {
        if(attime == null)
        {
            return "";
        }
        return sdf2.format(attime);
    }

    public Date getTimes()
    {
        return times;
    }

    public String getTimesToString()
    {
        if(times != null)
        {
            return Task.sdf2.format(times);
        } else
        {
            return "";
        }
    }

    public String getRemark()
    {
        return remark;
    }

    public int getFettle()
    {
        return fettle;
    }

    public int getPri()
    {
        return pri;
    }

    public String getMember()
    {
        return member;
    }

    public String getMemberxg()
    {
        return memberxg;
    }

    public Date getTimexg()
    {
        return timexg;
    }

    public String getTimexgtoString()
    {
        if(timexg != null)
        {
            return Task.sdf.format(timexg);
        } else
        {
            return "";

        }
    }


    public String getTimexgToString()
    {
        if(timexg == null)
        {
            return "";
        }
        return sdf2.format(timexg);
    }

    public String getAssignerid()
    {
        return assignerid;
    }

    public String getAssigneridToString(int language) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        String str[] = assignerid.split("/");
        for(int i = 0;i < str.length;i++)
        {
            Profile p = Profile.find(str[i]);
            if(p.getTime() != null)
            {
                sb.append(p.getLastName(language)).append(p.getFirstName(language)).append(" ");
            }
        }
        return sb.toString();
    }

    public String getAcceefile()
    {
        return acceefile;
    }

    public String getAcceename()
    {
        return acceename;
    }

    public int getFlowitem()
    {
        return flowitem;
    }

    public String getZtcontent()
    {
        return ztcontent;
    }

    public int getWorklog()
    {
        return worklog;
    }

    public int getId()
    {
        return id;
    }

    public int getDatefq()
    {
        return datefq;
    }

    public int getTaskfrequency()
    {
        return Taskfrequency;
    }
}
