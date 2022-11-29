package tea.entity.integral;

import java.sql.*;
import java.util.*;
import java.util.Date;
import tea.entity.site.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.member.*;

public class IntegralCycle extends Entity
{
    private int id;
    private Date times;
    private String member;
    private String community;
    private int integral;
    private int type; //获得积分的几种类型
    private boolean exists;
    //注册积分 登陆积分 问答积分 商品积分 发贴积分 兑换积分
    public final static String TYPES[] =
            {"其他","登陆积分","注册积分","回答问题的积分","商品积分","发贴积分","兑换积分","添加积分","减少积分","悬赏积分","问答奖励积分"};

    public IntegralCycle(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static IntegralCycle find(int id) throws SQLException
    {
        return new IntegralCycle(id);

    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select id,times,member,community,integral,type form IntegralCycle where id =" + id);
            if(db.next())
            {
                id = db.getInt(1);
                times = db.getDate(2);
                member = db.getString(3);
                community = db.getString(4);
                integral = db.getInt(5);
                type = db.getInt(6);
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

    public static void set(String member,int integral,Date times,int id) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update IntegralCycle set member =" + db.cite(member) + ",integral=" + integral + ",times=" + db.cite(times) + " where id =" + id);
        } finally
        {
            db.close();
        }
    }

    public static void create(String member,int integral,Date times) throws SQLException
    {
        Date time = new Date();
        String dates = IntegralCycle.sdf.format(time);

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("insert into IntegralCycle (member,integral,times)values(" + db.cite(member) + "," + integral + "," + db.cite(dates) + ")");
        } finally
        {
            db.close();
        }
    }

    public static void create(String member,int integral,Date times,int type,String community) throws SQLException
    {
        Date time = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(time);

        Profile pro = Profile.find(member);
        DbAdapter db = new DbAdapter();
        DbAdapter db_1 = new DbAdapter();
        Communityintegral comint = Communityintegral.find(pro.getCommunity());
        community = pro.getCommunity();
        cal.set(cal.DATE,cal.get(Calendar.DATE) - 1);

        Date ss1 = cal.getTime();

        cal.set(cal.DATE,cal.get(Calendar.DATE) + 2);
        Date ss2 = cal.getTime();

        int num = 0;
        try
        {

            if(type == 1)
            {
                db_1.executeQuery("select count(id) from IntegralCycle where member = " + db_1.cite(member) + " and times>" + db_1.cite(ss1) + " and times < " + db_1.cite(ss2));
                if(db_1.next())
                {
                    num = db_1.getInt(1);
                    if(num > comint.getLoginlimit())
                    {

                    } else
                    {
                        db.executeUpdate("insert into IntegralCycle (member,integral,times,community,type)values(" + db.cite(member) + "," + integral + "," + db.cite(times) + "," + db.cite(community) + "," + type + ")");
                        pro.setIntegral(pro.getIntegral() + integral);
                    }
                } else
                {
                    db.executeUpdate("insert into IntegralCycle (member,integral,times,community,type)values(" + db.cite(member) + "," + integral + "," + db.cite(times) + "," + db.cite(community) + "," + type + ")");
                    pro.setIntegral(pro.getIntegral() + integral);
                }
            } else if(type == 7)
            {
                db.executeUpdate("insert into IntegralCycle (member,integral,times,community,type)values(" + db.cite(member) + "," + integral + "," + db.cite(times) + "," + db.cite(community) + "," + type + ")");
                pro.setIntegral(pro.getIntegral() + integral);
            }

            else if(type == 8)
            {
                db.executeUpdate("insert into IntegralCycle (member,integral,times,community,type)values(" + db.cite(member) + "," + ( -integral) + "," + db.cite(times) + "," + db.cite(community) + "," + type + ")");
                pro.setIntegral(pro.getIntegral() - integral);
            } else if(type == 6)
            {
                db.executeUpdate("insert into IntegralCycle (member,integral,times,community,type)values(" + db.cite(member) + "," + ( -integral) + "," + db.cite(times) + "," + db.cite(community) + "," + type + ")");
                pro.setIntegral(pro.getIntegral() - integral);

            } else if(type == 9)
            {
                db.executeUpdate("insert into IntegralCycle (member,integral,times,community,type)values(" + db.cite(member) + "," + ( -integral) + "," + db.cite(times) + "," + db.cite(community) + "," + type + ")");
                pro.setIntegral(pro.getIntegral() - integral);

            } else
            {
                db.executeUpdate("insert into IntegralCycle (member,integral,times,community,type)values(" + db.cite(member) + "," + integral + "," + db.cite(times) + "," + db.cite(community) + "," + type + ")");
                pro.setIntegral(pro.getIntegral() + integral);
            }
        } finally
        {
            db.close();
            db_1.close();
        }
    }


    public static Enumeration findByintegral() throws SQLException
    {
        Date date = new Date();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);

        String before = null;
        String anon = null;

        anon = IntegralCycle.sdf.format(calendar.getTime());
        calendar.set(calendar.DATE, -7);
        before = IntegralCycle.sdf.format(calendar.getTime());

        Vector v = new Vector();

        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT top 10 member FROM IntegralCycle  WHERE times> " + db.cite(before) + " and times < " + db.cite(anon) + " GROUP BY member   order by SUM(Integral)  DESC");
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

    //计算各类积分
    public static int findsum(String member,String community,String str,int types) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int sum = 0;
        try
        {
            db.executeQuery("select SUM(" + str + ") from IntegralCycle where community=" + db.cite(community) + " and member=" + db.cite(member) + " and type=" + types);
            if(db.next())
            {
                sum = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return sum;
    }

    public String getCommunity()
    {
        return community;
    }

    public int getId()
    {
        return id;
    }

    public String getMember()
    {
        return member;
    }

    public Date getTimes()
    {
        return times;
    }

    public int getIntegral()
    {
        return integral;
    }

    public int getType()
    {
        return type;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getTimesToString()
    {
        if(times == null)
        {
            return " ";
        }
        return IntegralCycle.sdf.format(times);

    }


}
