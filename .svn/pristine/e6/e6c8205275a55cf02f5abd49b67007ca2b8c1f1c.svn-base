package tea.entity.csvclub;


import java.math.*;
import java.sql.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class Csvdogcharge extends Entity
{

    private int id;
    private String member ;
    private BigDecimal monenys;
    private String years;
    private BigDecimal regcharge; /// 注册费用
    private String community;
    private Date datetimes;
    private int chargetype; /// 关于费用的类型 1 注册费用，0 每年的服务费用
    private int financeid;//对应Finance 表的id 以确认这个交费财务是否已经确认


    private boolean exists = false;



    public Csvdogcharge(String member ,String years,int type)throws SQLException
    {
        this.member = member;
        this.years = years ;
        this.chargetype = type;
        load();
    }

    public static Csvdogcharge find(String member,String years,int type)throws SQLException
    {
        return new Csvdogcharge(member,years,type);
    }

    public Csvdogcharge(String member)throws SQLException
   {
       this.member = member;
       loadreg();
   }

   public static Csvdogcharge find(String member)throws SQLException
   {
       return new Csvdogcharge(member);
   }



    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select id,member,monenys,years,regcharge,community,datetimes,chargetype,financeid from  Csvdogcharge where member ="+db.cite(member)+" and years = "+db.cite(years)+ " and   chargetype ="+chargetype  );
            if(db.next())
            {
               id=db.getInt(1);
               member = db.getString(2);
               monenys = db.getBigDecimal(3, 2);
               years = db.getString(4);
               regcharge = db.getBigDecimal(5, 2);
               community = db.getString(6);
               datetimes = db.getDate(7);
               chargetype = db.getInt(8);
               financeid = db.getInt(9);
               exists = true;
           } else
           {
               exists = false;
           }
           }
        finally
        {
            db.close();
        }
    }

    public void loadreg() throws SQLException
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("select id,member,monenys,years,regcharge,community,datetimes,chargetype,financeid from  Csvdogcharge where member ="+db.cite(member)+" and chargetype = 1");
                if(db.next())
                {
                   id=db.getInt(1);
                   member = db.getString(2);
                   monenys = db.getBigDecimal(3, 2);
                   years = db.getString(4);
                   regcharge = db.getBigDecimal(5, 2);
                   community = db.getString(6);
                   datetimes = db.getDate(7);
                   chargetype = db.getInt(8);
                   financeid = db.getInt(9);
                   exists = true;
               } else
               {
                   exists = false;
               }
               }
            finally
            {
                db.close();
            }
        }


    public static void create (String member,BigDecimal monenys,String years,BigDecimal regcharge,String community,Date datetimes,int chargetype,int financeid)throws SQLException
    {


        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("insert into Csvdogcharge(member,monenys,years,regcharge,community,datetimes,chargetype,financeid) values("+db.cite(member)+","+monenys+","+db.cite(years)+","+regcharge+","+db.cite(community)+","+db.cite(Csvdogcharge.sdf.format(datetimes))+","+chargetype+","+financeid+")");
        }
        finally
        {
            db.close();
        }
    }



    public BigDecimal getRegcharge()
    {
        return regcharge;
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

    public BigDecimal getMonenys()
    {
        return monenys;
    }

    public String getYears()
    {
        return years;
    }

    public Date getDatetimes()
    {
        return datetimes;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getChargetype()
    {
        return chargetype;
    }

    public int getFinanceid()
    {
        return financeid;
    }


}
