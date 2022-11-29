package tea.entity.admin.erp;

import java.math.*;
import java.sql.*;
import java.util.Date;
import java.util.*;

import tea.db.*;
import tea.entity.*;

//客户端IC卡的销售记录
public class ICSales extends Entity
{
    private String icsales; //单据号
    private int leagueshop; //加盟店
    private BigDecimal price; //总价
    private boolean type; //false: 会员, true:非会员
    private int quantity; //总数
    private Date time; //时间
    private boolean exists;
    public ICSales(String icsales) throws SQLException
    {
        this.icsales = icsales;
        load();
    }

    public static boolean create(String icsales,int leagueshop,int quantity,BigDecimal price,boolean type,Date time) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
        	System.out.println("INSERT INTO ICSales(icsales,leagueshop,quantity,price,type,time)VALUES(" + db.cite(icsales) + "," + leagueshop + "," + quantity + "," + price + "," + db.cite(type) + "," + db.cite(time) + ")");
            return db.executeUpdate("INSERT INTO ICSales(icsales,leagueshop,quantity,price,type,time)VALUES(" + db.cite(icsales) + "," + leagueshop + "," + quantity + "," + price + "," + db.cite(type) + "," + db.cite(time) + ")") > 0;
        } finally
        {
            db.close();
        }
    }

    public static ICSales find(String icsales) throws SQLException
    {
        return new ICSales(icsales);
    }


    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT leagueshop,quantity,price,type,time FROM ICSales WHERE icsales=" + db.cite(icsales));
            if(db.next())
            {
                leagueshop = db.getInt(1);
                quantity = db.getInt(2);
                price = db.getBigDecimal(3,2);
                type = db.getInt(4) != 0;
                time = db.getDate(5);
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

    //zhangjinshu
    public static java.util.Enumeration find(String sql,int pos,int size)
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT icsales FROM ICSales WHERE 1= 1 " + sql,pos,size);
            while(db.next())
            {
                vector.addElement(db.getString(1));
            }
        } catch(Exception exception3)
        {
            System.out.print(exception3);
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static java.util.Enumeration findIcsales(String sql,int pos,int size)
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select ic.icsales from  ICSales ic ,ICSalesList ics,LeagueShop ls  where ic.icsales=ics.icsales and ls.id=ic.leagueshop  " + sql,pos,size);
            while(db.next())
            {
                vector.addElement(db.getString(1));
            }
        } catch(Exception exception3)
        {
            System.out.print(exception3);
        } finally
        {
            db.close();
        }
        return vector.elements();
    }


    //zhangjinshu
    public static int count2(String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int num = 0;
        try
        {
            db.executeQuery("select count(distinct(ic.icsales)) from  ICSales ic ,ICSalesList ics,LeagueShop ls  where ic.icsales=ics.icsales and ls.id=ic.leagueshop " + sql);
            if(db.next())
            {
                num = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return num;
    }

    //获取消费卡号
    public static String getIcMember(String icsales) throws SQLException
    {
        String s = null;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select icard from ICSalesList where icsales =" + DbAdapter.cite(icsales));
            if(db.next())
            {
                s = db.getString(1);
            }
        } finally
        {
            db.close();
        }
        return s;
    }

    //计算数量
    public static int getShuLiang(String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int i = 0;
        try
        {
            db.executeQuery("select ic.icsales from  ICSales ic ,ICSalesList ics,LeagueShop ls  where ic.icsales=ics.icsales and ls.id=ic.leagueshop  " + sql);
            while(db.next())
            {
                ICSales icobj = ICSales.find(db.getString(1));
                i = i + icobj.getQuantity();
            }
        } finally
        {
            db.close();
        }
        return i;
    }

    //计算金额
    public static java.math.BigDecimal getJinE(String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        java.math.BigDecimal i = new java.math.BigDecimal("0");
        try
        {
            db.executeQuery("select ic.icsales from  ICSales ic ,ICSalesList ics,LeagueShop ls  where ic.icsales=ics.icsales and ls.id=ic.leagueshop  " + sql);
            while(db.next())
            {
                ICSales icobj = ICSales.find(db.getString(1));
                i = i.add(icobj.getPrice());
            }
        } finally
        {
            db.close();
        }
        return i;
    }


    public String getIcsales()
    {
        return icsales;
    }

    public boolean isExists()
    {
        return exists;
    }

    public boolean isType()
    {
        return type;
    }

    public Date getTime()
    {
        return time;
    }

    public String getTimeToString()
    {
        if(time == null)
        {
            return "";
        }
        return sdf.format(time);
    }

    public int getQuantity()
    {
        return quantity;
    }

    public java.math.BigDecimal getPrice()
    {
        return price;
    }

    public int getLeagueshop()
    {
        return leagueshop;
    }

}
