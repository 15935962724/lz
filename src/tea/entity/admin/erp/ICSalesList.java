package tea.entity.admin.erp;

import java.math.*;
import java.sql.SQLException;
import java.util.*;
import tea.db.*;

//客户端IC卡的销售记录_明细
public class ICSalesList
{
    private int icsaleslist;
    private String icsales; //单据号
    private int node;
    private String no; //商品编号
    private String name; //商品名称
    private String icard; //卡  null:非会员
    private boolean type; //false:商品, true:服务
    private BigDecimal price; //单价
    private BigDecimal discount; //优惠
    private int quantity; //数量
    //统计是用到
    private Date date;
    private int day;
    private int hour;
    private boolean exists;


    public ICSalesList(int icsaleslist) throws SQLException
    {
        this.icsaleslist = icsaleslist;
        load();
    }

    public static void create(String icsales,int node,String no,String name,String icard,boolean type,int quantity,BigDecimal price) throws SQLException
    {
        Date time = ICSales.find(icsales).getTime();
        Calendar c = Calendar.getInstance();
        c.setTime(time);
        int day = c.get(Calendar.DAY_OF_MONTH);
        int hour = c.get(Calendar.HOUR_OF_DAY);
        DbAdapter db = new DbAdapter();
        try
        {     System.out.println("INSERT INTO ICSalesList(icsales,node,no,name,icard,type,quantity,price,date,day,hour)VALUES(" + db.cite(icsales) + "," + node + "," + db.cite(no) + "," + db.cite(name) + "," + db.cite(icard) + "," + db.cite(type) + "," + quantity + "," + price + "," + db.cite(time,true) + "," + day + "," + hour + ")");
        
            db.executeUpdate("INSERT INTO ICSalesList(icsales,node,no,name,icard,type,quantity,price,date,day,hour)VALUES(" + db.cite(icsales) + "," + node + "," + db.cite(no) + "," + db.cite(name) + "," + db.cite(icard) + "," + db.cite(type) + "," + quantity + "," + price + "," + db.cite(time,true) + "," + day + "," + hour + ")");
            
        } finally
        {
            db.close();
        }
    }
    public static void create(String icsales,int node,String no,String name,String icard,boolean type,int quantity,BigDecimal price,BigDecimal discount) throws SQLException
    {
        Date time = ICSales.find(icsales).getTime();
        Calendar c = Calendar.getInstance();
        c.setTime(time);
        int day = c.get(Calendar.DAY_OF_MONTH);
        int hour = c.get(Calendar.HOUR_OF_DAY);
        DbAdapter db = new DbAdapter();
        try
        {     System.out.println("INSERT INTO ICSalesList(icsales,node,no,name,icard,type,quantity,price,discount,date,day,hour)VALUES(" + db.cite(icsales) + "," + node + "," + db.cite(no) + "," + db.cite(name) + "," + db.cite(icard) + "," + db.cite(type) + "," + quantity + "," + price + "," + discount+ "," + db.cite(time,true) + "," + day + "," + hour + ")");
        
            db.executeUpdate("INSERT INTO ICSalesList(icsales,node,no,name,icard,type,quantity,price,discount,date,day,hour)VALUES(" + db.cite(icsales) + "," + node + "," + db.cite(no) + "," + db.cite(name) + "," + db.cite(icard) + "," + db.cite(type) + "," + quantity + "," + price+ "," + discount + "," + db.cite(time,true) + "," + day + "," + hour + ")");
            
        } finally
        {
            db.close();
        }
    }
    public static ICSalesList find(int icsaleslist) throws SQLException
    {
        return new ICSalesList(icsaleslist);
    }


    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT icsales,node,no,name,icard,type,quantity,price,discount FROM ICSalesList WHERE icsaleslist=" + icsaleslist);
            if(db.next())
            {
                icsales = db.getString(1);
                node = db.getInt(2);
                no = db.getString(3);
                name = db.getString(4);
                icard = db.getString(5);
                type = db.getInt(6) != 0;
                quantity = db.getInt(7);
                price = db.getBigDecimal(8,2);
                discount = db.getBigDecimal(9,2);
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
            db.executeQuery("SELECT icsaleslist FROM ICSalesList WHERE 1= 1 " + sql,pos,size);
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
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

//zhangjinshu /****/2009-5-27添加
    public static int getMemberTotal(int leagueshop,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int mt = 0;
        try
        {    System.out.println("select count(distinct(ic.icard)) from ICSales i,ICSalesList ic where i.icsales=ic.icsales and i.leagueshop=" + leagueshop + sql);
        
            db.executeQuery("select count(distinct(ic.icard)) from ICSales i,ICSalesList ic where i.icsales=ic.icsales and i.leagueshop=" + leagueshop + sql);
             
            
            if(db.next())
            {
                mt = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return mt;
    }

//求会员消费笔数和非会员消费笔数
    public static int getSQLB(int leagueshop,String str1,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int mt = 0;
        try
        {
            db.executeQuery("select " + str1 + " from ICSales ic,ICSalesList ics where ic.icsales=ics.icsales and ic.leagueshop=" + leagueshop + sql);
            if(db.next())
            {
                mt = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return mt;

    }

    //求会员消费金额和非会员消费金额
    public static java.math.BigDecimal getJiE(int leagueshop,String str1,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        java.math.BigDecimal mt = new java.math.BigDecimal("0");
        try
        {
            db.executeQuery("select ics.price, ics.quantity,ics.discount from ICSales ic,ICSalesList ics where ic.icsales=ics.icsales and ic.leagueshop=" + leagueshop + sql);
            while(db.next())
            {
               mt =  mt.add(db.getBigDecimal(1,2).multiply(new java.math.BigDecimal(db.getInt(2))));
               mt=mt.subtract(db.getBigDecimal(3, 2));
            }
        } finally
        {
            db.close();
        }
        return mt;
    }


//获取商品
    public static java.util.Enumeration findNo(String sql,int pos,int size)
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select (ics.no) from ICSales ic,ICSalesList ics,LeagueShop ls,Node n  where ic.icsales=ics.icsales and ic.leagueshop=ls.id and n.goodsnumber=ics.no  " + sql + " group  by   ics.no",pos,size);
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


    //获取商品的数量
    public static int getNoTotal(String no) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int n = 0;
        try
        {
            db.executeQuery("select quantity from ICSalesList where no =" + db.cite(no));
            while(db.next())
            {
                n = n + db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return n;
    }

//	获取商品的消费金额
    public static java.math.BigDecimal getPriceTotal(String no) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        java.math.BigDecimal p = new java.math.BigDecimal("0");
        try
        {
            db.executeQuery("select price from ICSalesList where no =" + db.cite(no));
            while(db.next())
            {
                p = p.add(db.getBigDecimal(1,2));
            }
        } finally
        {
            db.close();
        }
        return p;
    }

    //获取商品的总数量
    public static int getZNoTotal(String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int n = 0;
        try
        {
            db.executeQuery("select (ics.no) from ICSales ic,ICSalesList ics,LeagueShop ls,Node n where ic.icsales=ics.icsales and ic.leagueshop=ls.id and n.goodsnumber=ics.no " + sql + " group  by   ics.no");
            while(db.next())
            {
                n = n + ICSalesList.getNoTotal(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return n;
    }

    public static java.math.BigDecimal getZPriceTotal(String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        java.math.BigDecimal p = new java.math.BigDecimal("0");
        try
        {
            db.executeQuery("select (ics.no) from ICSales ic,ICSalesList ics,LeagueShop ls,Node n where ic.icsales=ics.icsales and ic.leagueshop=ls.id and n.goodsnumber=ics.no " + sql + " group  by   ics.no");
            while(db.next())
            {
                p = p.add(ICSalesList.getPriceTotal(db.getString(1)));
            }
        } finally
        {
            db.close();
        }
        return p;
    }

    public static int count2(String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int num = 0;
        try
        {
            db.executeQuery("select  count(distinct(ics.no)) from ICSales ic,ICSalesList ics,LeagueShop ls,Node n where ic.icsales=ics.icsales and ic.leagueshop=ls.id  and n.goodsnumber=ics.no " + sql);
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

    public static int count(String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int num = 0;
        try
        {
            db.executeQuery("SELECT count(icsaleslist) FROM ICSalesList WHERE 1= 1 " + sql);
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


//合计
    public boolean isType()
    {
        return type;
    }

    public int getQuantity()
    {
        return quantity;
    }

    public BigDecimal getPrice()
    {
        return price;
    }

    public String getNo()
    {
        return no;
    }

    public BigDecimal getDiscount() {
		return discount;
	}

	public void setDiscount(BigDecimal discount) {
		this.discount = discount;
	}

	public String getName()
    {
        return name;
    }

    public int getIcsaleslist()
    {
        return icsaleslist;
    }

    public String getIcsales()
    {
        return icsales;
    }

    public String getIcard()
    {
        return icard;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getNode()
    {
        return node;
    }

}
