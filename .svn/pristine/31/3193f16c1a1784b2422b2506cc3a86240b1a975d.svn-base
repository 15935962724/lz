package tea.entity.node;

import java.math.*;
import java.sql.*;
import java.util.Date;
import java.util.*;

import tea.db.*;
import tea.entity.*;
public class ShoppingCarts extends Entity
{
   private int id;
   private String sessionid;
   private int node;
   private int status;//
   private Date times;
   private int currency;//货币类型
   private BigDecimal price;//价钱
   private int quantity;//数量
   private int commodity;//商品
   private String community;

   public ShoppingCarts (int id) throws SQLException
   {
       this.id = id;
       load();
   }

   public static ShoppingCarts find(int id)throws SQLException
   {
       return new ShoppingCarts (id);
   }

   public void load()throws SQLException
   {
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeQuery("SELECT node,status,times,currency,price,quantity,commodity,community FROM ShoppingCarts WHERE id = " + id);
           if(db.next())
           {
               node = db.getInt(1);
               status = db.getInt(2);
               times = db.getDate(3);
               currency = db.getInt(4);
               price = db.getBigDecimal(2,5);
               quantity = db.getInt(6);
               commodity = db.getInt(7);
               community = db.getString(8);
           }
       } finally
       {
           db.close();
       }
   }


   public static void create(String community, String sessionid, int node, int commodity, int currency, BigDecimal price, int quantity) throws SQLException
   {
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeUpdate("INSERT INTO ShoppingCarts (community,sessionid,node,commodity,currency,price,quantity,status,times) VALUES (" + DbAdapter.cite(community) + ", " + DbAdapter.cite(sessionid) + ", " + node + ", " + commodity + "," + currency + "," + price + "," + quantity + ",0," + db.citeCurTime() + ")");
           //i1 = db.getInt("SELECT MAX(buy) FROM ShoppingCarts");
       } finally
       {
           db.close();
       }
   }

   // 查找是否存在相同的商品
   public static int find(String sessionid, int node, int commodity, int currency) throws SQLException
   {
       int buy = 0;
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeQuery("SELECT id FROM ShoppingCarts WHERE sessionid = "+db.cite(sessionid)+" AND node=" + node + " AND commodity=" + commodity + " AND currency=" + currency + " AND status=0");
           if (db.next())
           {
             //  sessionid = db.getString(1);
               buy = db.getInt(1);
           }
       } finally
       {
           db.close();
       }
       return buy;
   }

   // 修改数量
   public void set(int i) throws SQLException
   {
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeUpdate("UPDATE ShoppingCarts SET quantity=" + i + " WHERE id=" + id);
       } finally
       {
           db.close();
       }
   }

   public static Enumeration find(String community,String sql) throws SQLException
   {
       Vector v = new Vector();
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeQuery("SELECT id FROM ShoppingCarts WHERE community=" + DbAdapter.cite(community) + sql);
           while(db.next())
           {
               v.addElement(new Integer(db.getInt(1)));
           }
       } finally
       {
           db.close();
       }
       return v.elements();
   }

   public void delete()throws SQLException
   {
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeUpdate("DELETE FROM  ShoppingCarts WHERE id = "+id);
       }finally
       {
           db.close();
       }
   }
    public int getCommodity()
    {
        return commodity;
    }

    public String getCommunity()
    {
        return community;
    }

    public int getCurrency()
    {
        return currency;
    }

    public int getNode()
    {
        return node;
    }

    public BigDecimal getPrice()
    {
        return price;
    }

    public int getQuantity()
    {
        return quantity;
    }

    public int getStatus()
    {
        return status;
    }

    public Date getTimes()
    {
        return times;
    }

    public String getSessionid()
    {
        return sessionid;
    }


}
