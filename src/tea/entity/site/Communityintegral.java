package tea.entity.site;

import java.sql.*;
import java.util.Date;
import tea.db.*;
import tea.entity.*;


public class Communityintegral extends Entity
{

    private String community;
    private String member;//修改人
    private int integralid;
    private int logintime;//登录次数
    private int loginlimit;//登录次数的限制
    private int loginintegral;//登录的积分
    private int pink_A;//精华
    private int pink_B;
    private int qu_low;//问答中心，低
    private int qu_high;
    private int qu_answer;
    private Date integraltime;//修改时间
    private boolean exists;// 是否存在
    
    //俱乐部会员的积分设置
    private float regpoint;//注册积分
    private float invitepoint;//邀请积分
    private float cluepoint;//线索积分
    private float buspoint;//商机积分
    private float pollpoint;//调查投票 积分
    
    
    public Communityintegral(String community)throws SQLException
    {
        this.community=community;
        load();
    }

    public static Communityintegral find(String community)throws SQLException
    {
        return new Communityintegral(community);
    }

    public void load()throws SQLException
    {
        DbAdapter db =  new DbAdapter();
        try
        {
            db.executeQuery("select  community,member,integralid,logintime,loginlimit,loginintegral,pink_A,pink_B,qu_low,qu_high,qu_answer,integraltime," +
            		" regpoint,invitepoint,cluepoint,buspoint,pollpoint from Communityintegral where community="+DbAdapter.cite(community));
            if(db.next())
            {
                community= db.getString(1);
                member = db.getString(2); //修改人
                integralid = db.getInt(3);
                logintime = db.getInt(4); //登录次数
                loginlimit = db.getInt(5); //登录次数的限制
                loginintegral = db.getInt(6); //登录的积分
                pink_A = db.getInt(7); //精华
                pink_B = db.getInt(8);
                qu_low = db.getInt(9);
                qu_high = db.getInt(10);
                qu_answer = db.getInt(11);
                integraltime = db.getDate(12);
                regpoint =db.getFloat(13);
                invitepoint=db.getFloat(14);
                cluepoint=db.getFloat(15);
                buspoint=db.getFloat(16);
                pollpoint=db.getFloat(17);
                exists = true;
            }
        }
        finally
        {
            db.close();
        }
    }


    public static void create(String community,String member,int logintime,int loginlimit,int loginintegral,int pink_A,int pink_B, int qu_low,int qu_high,int qu_answer,Date integraltime)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("insert into Communityintegral(community,member,logintime,loginlimit,loginintegral,pink_A,pink_B,qu_low,qu_high,qu_answer,integraltime)values("+DbAdapter.cite(community)+","+DbAdapter.cite(member)+","+logintime+","+loginlimit+","+loginintegral+","+pink_A+","+pink_B+","+qu_low+","+qu_high+","+qu_answer+","+DbAdapter.cite(integraltime)+")");
        }
        finally
        {
            db.close();
        }
    }
    
    public static void set (String community,String member,int logintime,int loginlimit,int loginintegral,int pink_A,int pink_B, int qu_low,int qu_high,int qu_answer,Date integraltime)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Communityintegral set community="+DbAdapter.cite(community)+",member="+DbAdapter.cite(member)+",logintime="+logintime+",loginlimit="+loginlimit+",loginintegral="+loginintegral+",pink_A="+pink_A+",pink_B="+pink_B+",qu_low="+qu_low+",qu_high="+qu_high+",qu_answer="+qu_answer+",integraltime="+DbAdapter.cite(integraltime)+" where community="+DbAdapter.cite(community));
        } finally
        {
            db.close();
        }
    }

    public static void create(String community,String member,Date integraltime,float regpoint,float invitepoint,float cluepoint,float buspoint,float pollpoint)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        { 
            db.executeUpdate("insert into Communityintegral(community,member,integraltime,regpoint,invitepoint,cluepoint,buspoint,pollpoint)values("+DbAdapter.cite(community)+","+DbAdapter.cite(member)+"," +
            "  "+DbAdapter.cite(integraltime)+","+regpoint+" ,"+invitepoint+","+cluepoint+","+buspoint+","+pollpoint+"   )");
        }
        finally
        {
            db.close();
        }
    }
    
    public static void set (String community,String member,Date integraltime,float regpoint,float invitepoint,float cluepoint,float buspoint,float pollpoint)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Communityintegral set community="+DbAdapter.cite(community)+",member="+DbAdapter.cite(member)+",integraltime="+DbAdapter.cite(integraltime)+"," +
            		" regpoint="+regpoint+",invitepoint="+invitepoint+",cluepoint="+cluepoint+",buspoint="+buspoint+",pollpoint="+pollpoint+" where community="+DbAdapter.cite(community));
        } finally
        {
            db.close();
        }
    }
    
    
    
    
    public void delete (String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete  Communityintegral where community = "+DbAdapter.cite(community));
        }
        finally
        {
            db.close();
        }
    }

    public String getCommunity()
    {
        return community;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getIntegralid()
    {
        return integralid;
    }

    public int getLoginintegral()
    {
        return loginintegral;
    }

    public int getLoginlimit()
    {
        return loginlimit;
    }

    public int getLogintime()
    {
        return logintime;
    }

    public String getMember()
    {
        return member;
    }

    public int getPink_B()
    {
        return pink_B;
    }

    public int getQu_answer()
    {
        return qu_answer;
    }

    public int getQu_high()
    {
        return qu_high;
    }

    public int getQu_low()
    {
        return qu_low;
    }
    public int getPink_A()
    {
        return pink_A;
    }

    public Date getIntegraltime()
    {
        return integraltime;
    }

	public float getRegpoint() {
		return regpoint;
	}

	public float getInvitepoint() {
		return invitepoint;
	}

	public float getCluepoint() {
		return cluepoint;
	} 

	public float getBuspoint() {
		return buspoint;
	}
	public float getPollpoint()
	{
		return pollpoint;
	}


}
