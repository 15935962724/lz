package tea.entity.admin.erp;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class Callout extends Entity
{
   private String purchase;//入库单
   private int supplname;//调出仓库
   private int waridname;//调入仓库
   private String rsgoods;//入库单中的所有商品
   private String quantityarr;//每个商品的数量
   private String totalarr;//每个商品的价格
   private String quantity;//合计数量
   private String total;//合计价格
   private Date time_s;//入库日期
   private String member;//经办人
   private String community;//社区
   private String remarks;//备注
   private int type; // 1 等待审核的，2 审核通过的
   private boolean exists;

   public Callout(String  purchase) throws SQLException
   {
       this.purchase = purchase;
       load();
   }

   public static Callout find(String purchase) throws SQLException
   {
       return new Callout(purchase);
   }

   public void load() throws SQLException
   {
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeQuery("SELECT supplname,waridname,quantityarr,totalarr,quantity,total,time_s,member,community,remarks,rsgoods,type FROM Callout WHERE purchase =" + db.cite(purchase));
           if(db.next())
           {
               supplname = db.getInt(1);
               waridname = db.getInt(2);
               quantityarr = db.getString(3);
               totalarr = db.getString(4);
               quantity = db.getString(5);
               total = db.getString(6);
               time_s = db.getDate(7);
               member = db.getString(8);
               community = db.getString(9);
               remarks = db.getString(10);
               rsgoods = db.getString(11);
			   type =db.getInt(12);
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

   public static void create(String purchase,int supplname,int waridname,String quantityarr,String totalarr,String quantity,String total,Date time_s,String member,String community,String remarks,String rsgoods,int type) throws SQLException
   {
       DbAdapter db = new DbAdapter();
       Date times = new Date();
       try
       {
           db.executeUpdate("INSERT INTO Callout (purchase,supplname,waridname,quantityarr,totalarr,quantity,total,time_s,member,community,remarks,rsgoods,type) VALUES (" + db.cite(purchase) + "," + (supplname) + "," + (waridname) + "," + db.cite(quantityarr) + "," + db.cite(totalarr) + "," + db.cite(quantity) + "," + db.cite(total) + "," + db.cite(time_s) + "," + db.cite(member) + "," + db.cite(community) + ","+db.cite(remarks)+","+db.cite(rsgoods)+","+type+" )");
       } finally
       {
           db.close();
       }
   }

   public void set(int supplname,int waridname,String quantityarr,String totalarr,String quantity,String total,Date time_s,String member,String community,String remarks,String rsgoods,int type) throws SQLException
   {
       DbAdapter db = new DbAdapter();
       Date times = new Date();
       try
       {
           db.executeUpdate("UPDATE Callout SET supplname="+(supplname)+",waridname="+waridname+",quantityarr="+db.cite(quantityarr)+",totalarr="+db.cite(totalarr)+",quantity="+db.cite(quantity)+",total="+db.cite(total)+",time_s="+db.cite(time_s)+",member="+db.cite(member)+",community="+db.cite(community)+",remarks="+db.cite(remarks)+",rsgoods="+db.cite(rsgoods)+" ,type="+type+"  WHERE purchase = " + db.cite(purchase));
       } finally
       {
           db.close();
       }
   }

   public static Enumeration find(String community,String sql,int pos,int size)
   {
       Vector vector = new Vector();
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeQuery("SELECT purchase FROM Callout WHERE community= " + db.cite(community) + sql);
           for(int i = 0;db.next() && i < pos + size;i++)
           {
               if(i >= pos)
               {
                   vector.add(db.getString(1));
               }
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
   public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM  Callout WHERE purchase = " + db.cite(purchase));
        } finally
        {
            db.close();
        }
    }

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(purchase) FROM Callout  WHERE community=" + db.cite(community) + sql);
            if(db.next())
            {
                count = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return count;
    }

    //修改审核type
    public void setType(int type) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Callout SET type =" + type + " WHERE purchase = " + db.cite(purchase));
        } finally
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

    public String getMember()
    {
        return member;
    }

    public String getQuantity()
    {
        return quantity;
    }

    public String getQuantityarr()
    {
        return quantityarr;
    }

    public String getRemarks()
    {
        return remarks;
    }

    public int getSupplname()
    {
        return supplname;
    }

    public Date getTime_s()
    {
        return time_s;
    }
    public String getTime_sToString()
    {
        if(time_s == null)
            return "";
        return sdf.format(time_s);
    }

    public String getTotal()
    {
        return total;
    }

    public String getTotalarr()
    {
        return totalarr;
    }

    public int getWaridname()
    {
        return waridname;
    }
    public String getRsgoods()
    {
        return rsgoods;
    }
	public int getType()
	{
		return type;
	}
    public static int  isGoods(String goodsname)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int f = 0;
        try
        {
         db.executeQuery("SELECT node FROM Node WHERE  type =34 AND hidden = 0 AND node IN (SELECT node FROM NodeLayer WHERE  subject LIKE '%"+goodsname+"%')");
         while(db.next())
         {
             f=f+1;
         }
        }finally
        {
          db.close();
        }
        return f;
    }
}
