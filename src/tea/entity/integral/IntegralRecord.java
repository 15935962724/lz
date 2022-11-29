package tea.entity.integral;

import java.sql.*;
import java.util.Date;
import java.util.Enumeration;
import java.util.Vector;

import tea.db.*;
import tea.entity.*;
import tea.entity.member.Logs;

public class IntegralRecord extends Entity
{

    public static final String MODIFY_TYPE[] =
            {"注册赠送","医生会员升级赠送","邀请会员","登录网站","上传文章","上传资源",
            "文章被浏览","资源被下载","浏览文章","下载资源","手动加积分"}; //加分获减分类型
    private int id;
    private String member; //积分修改的用户
    private String community; //所属的社区
    private Date time; //修改积分的时间
    private float integral; // 修改的积分数, 正数加积分,负数扣积分
    private int reason; //积分修改的原因ID
    private int node; // 跟修改积分相关的节点
    private String rmember; //与本次修改相关的用户;
    private String reasonstring; //手动填写加减分原因

    public IntegralRecord(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static IntegralRecord find(int id) throws SQLException
    {
        return new IntegralRecord(new Integer(id));
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,member,time,integral,reason,node,rmember,reasonstring FROM IntegralRecord WHERE id = " + id);
            if(db.next())
            {
                member = db.getString(1);
                community = db.getString(2);
                time = db.getDate(3);
                integral = db.getFloat(4);
                reason = db.getInt(5);
                node = db.getInt(6);
                rmember = db.getString(7);
                reasonstring = db.getString(8);
            } else
            {

            }
        } finally
        {
            db.close();
        }
    }

    public static void create(String community,String member,float integral,int reason,int node,String rmember,String reasonstring) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date now = new Date();

        try
        {
            db.executeUpdate("INSERT INTO IntegralRecord (community,member,time,integral,reason,node,rmember,reasonstring) " +
                             "VALUES (" + DbAdapter.cite(community) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(now) + "," +
                             integral + "," + reason + "," + node + "," + DbAdapter.cite(rmember) + "," + db.cite(reasonstring) + ")");

        } finally
        {
            db.close();
        }

    }

    public static void create(String community,String member,float integral,int reason,int node,String rmember) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date now = new Date();

        try
        {
            db.executeUpdate("INSERT INTO IntegralRecord (community,member,time,integral,reason,node,rmember) " +
                             "VALUES (" + DbAdapter.cite(community) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(now) + "," +
                             integral + "," + reason + "," + node + "," + DbAdapter.cite(rmember) + ")");

        } finally
        {
            db.close();
        }

    }

    public static Enumeration find(String member,int pos,int size) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM IntegralRecord" +
                            " WHERE member=" + DbAdapter.cite(member) + " ORDER BY time DESC",pos,size);
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

    public static float getIntegral(String community,String member,String sql) throws SQLException
    {
        float f = 0f;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT sum(integral) FROM IntegralRecord WHERE community=" + db.cite(community) + " and member=" + DbAdapter.cite(member) + sql);
            if(db.next())
            {
                f = db.getFloat(1);
            }
        } finally
        {
            db.close();
        }

        return f;
    }

    public static int count(String member) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT count(id) FROM IntegralRecord" +
                            " WHERE member=" + DbAdapter.cite(member));
            if(db.next())
            {
                i = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return i;

    }

    public static void delete(String member) throws SQLException
    {

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from IntegralRecord where member=" + db.cite(member));

        } finally
        {
            db.close();
        }

    }

    public String getMember()
    {
        return member;
    }

    public String getCommunity()
    {
        return community;
    }

    public Date getTime()
    {
        return time;
    }

    public float getIntegral()
    {
        return integral;
    }

    public int getReason()
    {
        return reason;
    }

    public int getNode()
    {
        return node;
    }

    public String getRmember()
    {
        return rmember;
    }

    public String getReasonstring()
    {
        return reasonstring;
    }

    public static Enumeration find(String member,int reason) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM IntegralRecord" +
                            " WHERE member=" + DbAdapter.cite(member) + " and reason=" + reason + " ORDER BY time DESC");
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

    public static Date getLastLoginGift(String member) throws SQLException
    {
        Date date = null;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT  time  FROM IntegralRecord WHERE rmember=" + DbAdapter.cite(member) + " AND reason=3 order by time desc"); //top 1
            if(db.next())
            {
                date = db.getDate(1);
            }
        } finally
        {
            db.close();
        }
        return date;
    }
}
