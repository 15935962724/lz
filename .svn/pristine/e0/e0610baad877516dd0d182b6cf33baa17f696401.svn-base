package tea.entity.admin.erp;

import java.math.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class ShopService extends Entity
{
    int shopservice;
    String community;
    String no;
    String name;
    BigDecimal price;
    String spec;
    boolean dtype; //提成类型
    float deduct; //提成量
    float point; //积分
    int brand;
    Date time;
    boolean exists;
    public ShopService(int shopservice) throws SQLException
    {
        this.shopservice = shopservice;
        load();
    }

    public static ShopService find(int shopservice) throws SQLException
    {
        return new ShopService(shopservice);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT no,name,price,spec,dtype,deduct,point,brand,time FROM ShopService WHERE shopservice=" + shopservice);
            if(db.next())
            {
                no = db.getString(1);
                name = db.getString(2);
                price = db.getBigDecimal(3,2);
                spec = db.getString(4);
                dtype = db.getInt(5) != 0;
                deduct = db.getFloat(6);
                point = db.getFloat(7);
                brand = db.getInt(8);
                time = db.getDate(9);
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

    public static void create(String community,String no,String name,BigDecimal price,String spec,boolean dtype,float deduct,float point,int brand) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO ShopService(community,no,name,price,spec,dtype,deduct,point,brand,time)VALUES(" + db.cite(community) + "," + db.cite(no) + "," + db.cite(name) + "," + price + "," + db.cite(spec) + "," + db.cite(dtype) + "," + deduct + "," + point + "," + brand + "," + db.cite(new Date()) + ")");
        } finally
        {
            db.close();
        }
    }

    public void set(String no,String name,BigDecimal price,String spec,boolean dtype,float deduct,float point,int brand) throws SQLException
    {
        time = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE ShopService SET no=" + db.cite(no) + ",name=" + db.cite(name) + ",price=" + price + ",spec=" + db.cite(spec) + ",dtype=" + db.cite(dtype) + ",deduct=" + deduct + ",point=" + point + ",brand=" + brand + ",time=" + db.cite(time) + " WHERE shopservice=" + shopservice);
        } finally
        {
            db.close();
        }
        this.no = no;
        this.name = name;
        this.price = price;
        this.spec = spec;
        this.dtype = dtype;
        this.deduct = deduct;
        this.point = point;
        this.brand = brand;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM ShopService WHERE shopservice=" + shopservice);
        } finally
        {
            db.close();
        }
    }

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT shopservice FROM ShopService WHERE community=" + db.cite(community) + sql,pos,size);
            while(db.next())
            {
                v.add(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static int count(String community,String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(shopservice) FROM ShopService WHERE community=" + db.cite(community) + sql);
            if(db.next())
            {
                j = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return j;
    }

    public Date getTime()
    {
        return time;
    }

    public String getTimeToString()
    {
        return Entity.sdf.format(time);
    }

    public boolean isExists()
    {
        return exists;
    }

    public float getDeduct()
    {
        return deduct;
    }

    public boolean isDType()
    {
        return dtype;
    }

    public String getName()
    {
        return name;
    }

    public String getNo()
    {
        return no;
    }

    public float getPoint()
    {
        return point;
    }

    public BigDecimal getPrice()
    {
        return price;
    }

    public int getShopService()
    {
        return shopservice;
    }

    public String getSpec()
    {
        return spec;
    }

    public int getBrand()
    {
        return brand;
    }


}
