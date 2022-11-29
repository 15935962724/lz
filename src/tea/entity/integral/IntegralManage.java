package tea.entity.integral;

import java.sql.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class IntegralManage extends Entity
{
    private String member;
    private String community;
    private int id;
    private int applyIntegral;//申请的积分
    private Date applytime;//申请时间
    private int reg_int;//注册积分
    private int login_int;//登陆积分
    private int qu_int;//问答积分
    private int shop_int;//商品积分
    private int hairnet_int;//发贴积分
    private int change_int;//兑换积分
    private int sum_int;//总积分
    private int add_int;//添加积分
    private int minus_int;//减少积分
    private boolean isexists;
    ///注册积分 登陆积分 问答积分 商品积分 发贴积分 兑换积分 总积分

    public IntegralManage(int id) throws SQLException
    {
        this.id=id;
        load();
    }
    public static IntegralManage find(int id)throws SQLException
    {
        return new IntegralManage(id);
    }
    public void load()throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("");

        } finally
        {
            db.close();
        }
    }
    public static void create() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("");

        } finally
        {
            db.close();
        }
    }

    public static void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("");

        } finally
        {
            db.close();
        }
    }

    public static void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("");

        } finally
        {
            db.close();
        }
    }

    public int getAdd_int()
    {
        return add_int;
    }

    public int getApplyIntegral()
    {
        return applyIntegral;
    }

    public Date getApplytime()
    {
        return applytime;
    }

    public int getChange_int()
    {
        return change_int;
    }

    public String getCommunity()
    {
        return community;
    }

    public int getHairnet_int()
    {
        return hairnet_int;
    }

    public int getId()
    {
        return id;
    }

    public boolean isIsexists()
    {
        return isexists;
    }

    public int getLogin_int()
    {
        return login_int;
    }

    public String getMember()
    {
        return member;
    }

    public int getMinus_int()
    {
        return minus_int;
    }

    public int getQu_int()
    {
        return qu_int;
    }

    public int getReg_int()
    {
        return reg_int;
    }

    public int getShop_int()
    {
        return shop_int;
    }

    public int getSum_int()
    {
        return sum_int;
    }


}
