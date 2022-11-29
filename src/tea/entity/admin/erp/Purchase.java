package tea.entity.admin.erp;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class Purchase extends Entity
{
   private String purchase;//入库单
   private int supplname;//供货商
   private int waridname;//仓库
   private String rsgoods;//入库单中的所有商品
   private String quantityarr;//每个商品的数量
   private String totalarr;//每个商品的价格
   private String quantity;//合计数量
   private String total;//合计价格
   private Date time_s;//入库日期
   private String member;//经办人
   private String community;//社区
   private String remarks;//备注
   private int type;//0 成品，1半成品 2半成品合成成品 3.成品拆成半成品
   private int flowtype;//流程状态 0 添加的采购单，1 审核通过的采购单，2 已审核,未到账， 3 部分到货，4 全部到货
   private int retquan;//退货数量

   public static final String [] FLOWTYPE  ={"等待审核中",""};

   public static final String [] FLOWSTR={"等待审核采购单","已审核未到货","部分商品未到货","部分商品未到货","商品全部到货"};

   private boolean exists;

   public Purchase(String  purchase) throws SQLException
   {
       this.purchase = purchase;
       load();
   }

   public static Purchase find(String purchase) throws SQLException
   {
       return new Purchase(purchase);
   }

   public void load() throws SQLException
   {
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeQuery("SELECT supplname,waridname,quantityarr,totalarr,quantity,total,time_s,member,community,remarks,rsgoods,type,flowtype FROM Purchase WHERE purchase =" + db.cite(purchase));
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
			   type = db.getInt(12);
			   flowtype=db.getInt(13);
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

   public static void create(String purchase,int supplname,int waridname,String quantityarr,String totalarr,String quantity,String total,Date time_s,String member,String community,String remarks,String rsgoods,int type,int flowtype) throws SQLException
   {
       DbAdapter db = new DbAdapter();
       Date times = new Date();
       try
       {
           db.executeUpdate("INSERT INTO Purchase (purchase,supplname,waridname,quantityarr,totalarr,quantity,total,time_s,member,community,remarks,rsgoods,type,flowtype) VALUES (" + db.cite(purchase) + "," + (supplname) + "," + (waridname) + "," + db.cite(quantityarr) + "," + db.cite(totalarr) + "," + db.cite(quantity) + "," + db.cite(total) + "," + db.cite(time_s) + "," + db.cite(member) + "," + db.cite(community) + ","+db.cite(remarks)+","+db.cite(rsgoods)+","+type+","+flowtype+" )");
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
           db.executeUpdate("UPDATE Purchase SET supplname="+(supplname)+",waridname="+waridname+",quantityarr="+db.cite(quantityarr)+",totalarr="+db.cite(totalarr)+",quantity="+db.cite(quantity)+",total="+db.cite(total)+",time_s="+db.cite(time_s)+",member="+db.cite(member)+",community="+db.cite(community)+",remarks="+db.cite(remarks)+",rsgoods="+db.cite(rsgoods)+",type="+type+"  WHERE purchase = " + db.cite(purchase));
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
           db.executeQuery("SELECT purchase FROM Purchase WHERE  community= " + db.cite(community) + sql);
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
            db.executeUpdate("DELETE FROM  Purchase WHERE purchase = " + db.cite(purchase));
			db.executeUpdate("DELETE FROM  GoodsDetails WHERE paid = " + db.cite(purchase));
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
            db.executeQuery("SELECT COUNT(purchase) FROM Purchase  WHERE community=" + db.cite(community) + sql);
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

	//返回数量
	public static int getQ(String community,String sql) throws SQLException
	{
		int q = 0;
		DbAdapter db = new DbAdapter();
		try
		{
				db.executeQuery("SELECT quantity FROM Purchase  WHERE community=" + db.cite(community) + sql );
				while(db.next())
				{
					q = q+db.getInt(1);
				}

		} finally
		{
			db.close();
		}
		return q;
    }
	//返回金额
	public static java.math.BigDecimal getT(String community,String sql) throws SQLException
	{
		java.math.BigDecimal t = new java.math.BigDecimal("0");
		DbAdapter db = new DbAdapter();


		try
		{

				db.executeQuery("SELECT total FROM Purchase  WHERE community=" + db.cite(community) + sql );
				while(db.next())
				{
					t = t.add(new java.math.BigDecimal(db.getString(1)));
				}

		} finally
		{
			db.close();
		}
		return t;
	}
//修改流程状态
	public void setFlowType(int flowtype)throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Purchase SET flowtype = "+flowtype+" WHERE purchase="+db.cite(purchase));
		}finally
		{
			db.close();
		}
	}
	//修改采购单中的金额和数量
    public void setQuantityTotal(String quantity,String total) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Purchase SET quantity = " + db.cite(quantity) + ",total="+db.cite(total)+" WHERE purchase=" + db.cite(purchase));
        } finally
        {
            db.close();
        }
    }
//	//退货单时候用的按时间退货 获取 进货时候的进货价格
//	public static  java.math.BigDecimal  getRGsupply(String community,int node)throws SQLException
//	{
//		DbAdapter db = new DbAdapter();
//		java.math.BigDecimal p = null;
//		try
//		{
//			db.executeQuery("select  gd.dsupply  from GoodsDetails gd,Purchase p where gd.paid=p.purchase and gd.community="+db.cite(community)+" and p.waridname=1 and gd.time_s is not null and p.flowtype =4 and gd.node="+node+"  order by gd.time_s desc ");
//			//System.out.println("select  gd.dsupply  from GoodsDetails gd,Purchase p where gd.paid=p.purchase and gd.community="+db.cite(community)+" and p.waridname=1 and gd.time_s is not null and p.flowtype =4 and gd.node="+node+"  order by gd.time_s desc ");
//			if(db.next())
//			{
//				p = new java.math.BigDecimal(db.getString(1));
//			}
//		}finally
//		{
//			db.close();
//		}
//		return p;
//	}
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

    public String getPurchase()
    {
        return purchase;
    }
    public int getFlowtype()
	{
		return flowtype;
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
