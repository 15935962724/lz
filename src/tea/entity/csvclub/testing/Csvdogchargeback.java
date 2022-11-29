package tea.entity.csvclub.testing;

import java.math.*;
import java.sql.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;


public class Csvdogchargeback extends Entity
{
    private int id;
    private String community;
    private String member;
    private String service;
    private BigDecimal servicecharge;
    private Date datetimes;
    private int servicetype;///这个类型下的那个服务 子
    private int types;  //服务类型 父
    private int typecw ;//是否被财务确认过。。。。暂时未用到   0 表示没有确认
    private int defray;///支付的类型~
    public boolean exists = false;

    ///0，会员缴费，犬舍以及会员缴费  对应的字段是types
    /*****"其他0","会员服务1","繁殖服务2","赛事服务3","商城"
     * 0
     * Csvservice//会员1
     *  Csvdogservice//繁殖服务2  会员自己申请的 ： 申请配犬证明1，补做血统证书2，转发血统证书3， 补做繁殖证书4  转发繁殖证书5  髋肘检测6  耳号刺青7
     *  Csvcompete//赛事3
     * "商城"4
     * ***********/


    public static String[] SERVICETYPES ={"其他","注册会员","犬舍以及会员缴费","赛事费用","补交会员服务费用","补做血统证书","转发血统证书"};
    public static String[] TYPES = {"其他","会员服务","繁殖服务","赛事服务","商城"};
    public static String[] DEFRAYS = {"支付宝","汇款","POS","现金"};////5为短信报名



    public Csvdogchargeback(int id) throws SQLException
    {
        this.id = id;

    }

    public static Csvdogchargeback find(int id) throws SQLException
    {
        return new Csvdogchargeback(id);
    }

    public void load()throws SQLException
    {
        DbAdapter db = new DbAdapter();

        try
        {
            db.executeQuery("select id,community,member,service,servicecharge,datetimes,types,servicetype,typecw,defray from Csvdogchargeback where id = "+id);
            if(db.next())
            {
                id = db.getInt(1);
                community = db.getString(2);
                member = db.getString(3);
                service = db.getString(4);
                servicecharge = db.getBigDecimal(1,5);
                datetimes = db.getDate(6);
                types = db.getInt(7);
                servicetype = db.getInt(8);
                typecw = db.getInt(9);
                defray = db.getInt(10);
                exists = true;
            }
            else
            {
                exists = false;
            }
        }
        finally
        {
            db.close();

        }

    }
    public static void create(String community,String member,String service,BigDecimal servicecharge,Date datetimes,int types,int servicetype,int typecw)throws SQLException
    {
        DbAdapter db = new DbAdapter();

           try
           {
               db.executeUpdate("insert into Csvdogchargeback (community ,member , service,servicecharge,datetimes,types,servicetype,typecw) values("+db.cite(community)+","+db.cite(member)+","+db.cite(service)+","+servicecharge+","+db.cite(datetimes)+","+types+","+servicetype+","+typecw+")");
           }
           finally
           {
               db.close();
           }
    }
    public static void create_id(String community,String member,String service,BigDecimal servicecharge,Date datetimes,int types,int servicetype,int typecw,int defray)throws SQLException
    {
        DbAdapter db = new DbAdapter();

           try
           {
               db.executeUpdate("insert into Csvdogchargeback (community ,member , service,servicecharge,datetimes,types,servicetype,typecw,defray) values("+db.cite(community)+","+db.cite(member)+","+db.cite(service)+","+servicecharge+","+db.cite(datetimes)+","+types+","+servicetype+","+typecw+","+defray+")");
//               System.out.print("insert into Csvdogchargeback (community ,member , service,servicecharge,datetimes,types,servicetype,typecw,defray) values("+db.cite(community)+","+db.cite(member)+","+db.cite(service)+","+servicecharge+","+db.cite(datetimes)+","+types+","+servicetype+","+typecw+","+defray+")");

           }
           finally
           {
               db.close();
           }
    }
    public static int getID_max(String community,String sql)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select max(id) from Csvdogchargeback where community ="+db.cite(community)+sql);
            if(db.next())
            {
                return db.getInt(1);
            }
            else
            {
                return 0;
            }
        }
        finally
        {
            db.close();
        }
    }


    public static void set (int id,String community,String member,String service,BigDecimal servicecharge,Date datetimes)throws SQLException
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
    public static void setDefray(int idmax,int defray )throws SQLException
    {
        DbAdapter db = new DbAdapter();

        try
        {
            db.executeUpdate("update  Csvdogchargeback  set defray="+defray+"  where id="+idmax);
        } finally
        {
            db.close();
        }
    }
    /*
       private BigDecimal servicecharge;
         private Date datetimes;
         private int servicetype;///这个类型下的那个服务 子
         private int types;  //服务类型 父

     **/
    //3	csvclub	liencai	会员及犬舍申请liencai	1665.0000	2008-04-28 14:26:28.000	44578	1	0	NULL

    public static int getMoney(int types,int servicetype,String sql)throws SQLException
    {

        //sql为时间段
        DbAdapter db = new DbAdapter();
        int money=0;
        try
        {
            if(types==1)
            {
                db.executeQuery("select sum(servicecharge) from Csvdogchargeback where servicetype=" + servicetype + " and types=" + types + sql);
                if (db.next())
                {
                    money = db.getInt(1);
                }
            }
            if(types==2)
           {
               db.executeQuery("select sum(servicecharge) from Csvdogchargeback where servicetype=" + servicetype + " and types=" + types + sql);
               if (db.next())
               {
                   money = db.getInt(1);
               }
           }
           if(types==3)
           {
               db.executeQuery("select sum(servicecharge) from Csvdogchargeback where  types=" + types + sql);
               if (db.next())
               {
                   money = db.getInt(1);
               }
           }
           if(types==4)
           {
               db.executeQuery("select sum(servicecharge) from Csvdogchargeback where servicetype=" + servicetype + " and types=" + types + sql);
               if (db.next())
               {
                   money = db.getInt(1);
               }
           }




        }
        finally
        {
            db.close();
        }
        return money;
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

    public String getService()
    {
        return service;
    }

    public BigDecimal getServicecharge()
    {
        return servicecharge;
    }

    public Date getDatetimes()
    {
        return datetimes;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getTypes()
    {
        return types;
    }

    public int getServicetype()
    {
        return servicetype;
    }

    public int getTypecw()
    {
        return typecw;
    }

    public int getDefray()
    {
        return defray;
    }

}
