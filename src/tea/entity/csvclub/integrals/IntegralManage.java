package tea.entity.csvclub.integrals;

import java.sql.*;
import java.util.Date;

import tea.db.*;

public class IntegralManage extends SQLException
{
    private int id;//子增id
    private String login; // 登陆
    private String restrict; // 限制
    private String loginintegral; // 登录积分
    private String A_elite; //精华
    private String B_elite;
    private String qu_neap;//最低分
    private String qu_tiptop;//最高分
    private String qu_answer;//回答
    private String community;
    private String member;
    private Date dateint;
    private boolean isExit;//

    public IntegralManage(String community)throws SQLException
    {
        this.community=community;
        load();

    }
    public static IntegralManage find(String community)throws SQLException
    {
        return new IntegralManage(community);
    }
    public void load () throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("");
            if(db.next())
            {

                isExit=true;
            }
        }
        finally
        {
            db.close();
        }
    }
    public static void create ()throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("");
        }
        finally
        {
            db.close();
        }
    }
    public String getA_elite()
    {
        return A_elite;
    }

    public String getB_elite()
    {
        return B_elite;
    }

    public String getCommunity()
    {
        return community;
    }

    public Date getDateint()
    {
        return dateint;
    }

    public int getId()
    {
        return id;
    }

    public String getLogin()
    {
        return login;
    }

    public String getLoginintegral()
    {
        return loginintegral;
    }

    public String getMember()
    {
        return member;
    }

    public String getQu_answer()
    {
        return qu_answer;
    }

    public String getQu_neap()
    {
        return qu_neap;
    }

    public String getQu_tiptop()
    {
        return qu_tiptop;
    }

    public String getRestrict()
    {
        return restrict;
    }

    public boolean isIsExit()
    {
        return isExit;
    }


}
