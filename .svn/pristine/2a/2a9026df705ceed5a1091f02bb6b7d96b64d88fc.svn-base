package tea.entity.admin.erp;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.Date;
import java.util.Enumeration;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.Entity;
import tea.entity.node.BuyPrice;
import tea.entity.node.Commodity;
import tea.entity.node.Goods;

public class Inventory extends Entity
{
    private int invid;
    private int goods; //商品ID
    private int quantity; //库存
    private int warname; //仓库ID
    private String community;
    private boolean exists;
    private BigDecimal price;//单价
    private BigDecimal total;//合计

    public Inventory(int invid) throws SQLException
    {
        this.invid = invid;
        load();
    }

    public static Inventory find(int invid) throws SQLException
    {
        return new Inventory(invid);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT goods,quantity,warname,community,price,total FROM Inventory WHERE invid=" + (invid));
            if(db.next())
            {
                goods = db.getInt(1);
                quantity = db.getInt(2);
                warname = db.getInt(3);
                community = db.getString(4);
                price =db.getBigDecimal(5,2);
                total = db.getBigDecimal(6,2);
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

    public static void create(int goods,int quantity,int warname,String community,BigDecimal price,BigDecimal total) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("INSERT INTO Inventory (goods,quantity,warname,community,price,total) VALUES (" + (goods) + "," + (quantity) + "," + (warname) + "," + db.cite(community) + ","+price+","+total+")");
        } finally
        {
            db.close();
        }
    }

    public void set(int goods,int quantity,int warname,String community,BigDecimal price,BigDecimal total) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("UPDATE Inventory SET goods=" + (goods) + ",quantity=" + quantity + ",warname=" + warname + ",community=" + db.cite(community) + ",price="+price+",total="+total+"  WHERE invid = " + invid);
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
            db.executeQuery("SELECT invid FROM Inventory WHERE community= " + db.cite(community) + sql);
            for(int i = 0;db.next() && i < pos + size;i++)
            {
                if(i >= pos)
                {
                    vector.add(new Integer(db.getInt(1)));
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
	//没有仓库的
	public static Enumeration find2(String community,String sql,int pos,int size)
   {
	   Vector vector = new Vector();
	   DbAdapter db = new DbAdapter();
	   try
	   {
		   db.executeQuery("SELECT distinct(goods) FROM Inventory WHERE community= " + db.cite(community) + sql);
		   for(int i = 0;db.next() && i < pos + size;i++)
		   {
			   if(i >= pos)
			   {
				   vector.add(new Integer(db.getInt(1)));
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

//仓库和商品 可以知道库存中是否有这个商品
    public static boolean  isGoods(String community,int goods,int warname)throws SQLException
    {
         DbAdapter db = new DbAdapter();
         boolean f = false;
         try
         {
             db.executeQuery("SELECT invid FROM Inventory WHERE community = "+db.cite(community)+" AND goods = "+goods+" AND warname = "+warname);
             if(db.next())
             {
                 f = true;
             }
         }finally
         {
             db.close();
         }
         return f;
    }

	//计算库存中数量
	public static int getQTotal(String community,String sql)throws SQLException
	{
		int q = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT (quantity) FROM Inventory WHERE community= " + db.cite(community) + sql);
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
	//计算总金额

	public static java.math.BigDecimal getTTotal(String community,String sql)throws SQLException
		{
			java.math.BigDecimal t = new java.math.BigDecimal("0");
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery("SELECT invid FROM Inventory WHERE community= " + db.cite(community) + sql);
				while(db.next())
				{
					Inventory iobj = Inventory.find(db.getInt(1));
					t = t.add(iobj.setInvenTotal(community,iobj.getGoods(),iobj.getWarname()));
				}

			} catch(Exception exception3)
			{
				System.out.print(exception3);
			} finally
			{
				db.close();
			}
			return t;
	}
    //通过 商品 是仓库 可以知道 id
    public static int  getInvid(String community,int goods,int warname)throws SQLException
    {
         DbAdapter db = new DbAdapter();
         int f = 0;
         try
         {
             db.executeQuery("SELECT invid FROM Inventory WHERE community = "+db.cite(community)+" AND goods = "+goods+" AND warname = "+warname);
             if(db.next())
             {
                 f = db.getInt(1);
             }
         }finally
         {
             db.close();
         }
         return f;
    }
	//通过 商品 是仓库 可以知道 库存
	   public static int  getQuan(String community,int goods,int warname)throws SQLException
	   {
			DbAdapter db = new DbAdapter();
			int f = 0;
			try
			{
				db.executeQuery("SELECT quantity FROM Inventory WHERE community = "+db.cite(community)+" AND goods = "+goods+" AND warname = "+warname);
				if(db.next())
				{
					f = db.getInt(1);
				}
			}finally
			{
				db.close();
			}
			return f;
    }
	//community ,数量 quantity,商品 Node ,仓库
	public static void setQuantity(String community,int node,int warid,int quantity,String jj)throws SQLException
	{
	   int inid = Inventory.getInvid(community,node,warid);
	   Inventory inobj = Inventory.find(inid);
	   int qs=0;
	   if("+".equals(jj))
	   {
		   qs=inobj.getQuantity()+quantity;
	   }else if("-".equals(jj))
	   {
		    qs=inobj.getQuantity()-quantity;
	   }
		if(inid>0)//说明库存里面有这个商品
		{

			inobj.setInventortyQT(qs,inobj.getTotal());
		}
		else//
		{
			Inventory.create(node,qs,warid,community,null,null);
		}
	}
	//通过数量，计算总金额
	public void setTotal(String community,int node,int warid)throws SQLException
	{
        java.util.Enumeration e = GoodsDetails.find(community," AND node=" + node + "   AND type=2 ",0,Integer.MAX_VALUE); //type=2 说明是采购单
        java.math.BigDecimal p = new java.math.BigDecimal("0");//入库单价格
        while(e.hasMoreElements())
        {
            int gdid = ((Integer) e.nextElement()).intValue();
            GoodsDetails gdobj = GoodsDetails.find(gdid); //可以获得这个订单中的信息
            java.util.Enumeration e2 = OrdersBatch.find(community," AND paid =" + gdobj.getPaid() + " AND node =" + node,0,Integer.MAX_VALUE);
            while(e2.hasMoreElements())
            {
                int obid = ((Integer) e2.nextElement()).intValue();
                OrdersBatch obobj = OrdersBatch.find(obid);
                p = p.add(new java.math.BigDecimal(gdobj.getDsupply()).multiply(new java.math.BigDecimal(obobj.getQuantity())));
            }
            Purchase pobj = Purchase.find(gdobj.getPaid());
            Inventory iobj = Inventory.find(Inventory.getInvid(community,gdobj.getNode(),pobj.getWaridname()));
            iobj.setInventortyQT(iobj.getQuantity(),p);
            this.total = p;
        }
	}
//计算库存 入库价格 - 调出+ 调入 - 报损 - 销售 - 总部退货 + 加盟店退货 - 配送 - 赠送
	//	private int type; //0表示是进货单和销售单，1表示是加盟店的退货单,2入库单,3退货单,4调拨单,5b报损单,6配送单 7 赠送单 8 半成品 生成规则， 9 ，半成品 采购单 10 ，半成品 合成 成品
	public java.math.BigDecimal setInvenTotal(String community,int node,int warid)throws SQLException
	{
        java.math.BigDecimal t = new BigDecimal("0");
        //销售
        java.math.BigDecimal t0 = this.setTotal(community,node,warid,0);
        //加盟店退货
        java.math.BigDecimal t1 = this.setTotal(community,node,warid,1);
        //入库价格
        java.math.BigDecimal t2 = this.setTotal(community,node,warid,2);
        //总部退货
        java.math.BigDecimal t3 = this.setTotal(community,node,warid,3);
        //调出的仓库
        java.math.BigDecimal t4 = this.setTotal2(community,node,warid,"supplname");
		//调入的仓库
		 java.math.BigDecimal tr4 = this.setTotal2(community,node,warid,"waridname");
        //报损
        java.math.BigDecimal t5 = this.setTotal(community,node,warid,5);
        //配送单
        java.math.BigDecimal t6 = this.setTotal(community,node,warid,6);
        //赠送
        java.math.BigDecimal t7 = this.setTotal(community,node,warid,7);
	  t=t2.subtract(t4).add(tr4).subtract(t5).subtract(t0).subtract(t3).add(t1).subtract(t6).subtract(t7);
 
		System.out.println("商品："+tea.entity.node.Node.find(node).getSubject(1)+"仓库："+Warehouse.find(warid).getWarname()+"销售:"+t0+"加盟店退货"+t1+"入库价格"+t2+"总部退货"+t3+"调如"+t4+"调出："+tr4+"报损"+t5+"配送单"+t6+"赠送"+t7);
        return t;
	}


//能计算出来一种订单 的金额
    public BigDecimal setTotal(String community,int node,int warid,int type) throws SQLException
    {
        java.util.Enumeration e = GoodsDetails.find(community," AND node=" + node + " AND warehouse="+warid+"   AND type= " + type,0,Integer.MAX_VALUE); //type=2 说明是采购单
        java.math.BigDecimal p = new java.math.BigDecimal("0"); //入库单价格
        while(e.hasMoreElements())
        {
            int gdid = ((Integer) e.nextElement()).intValue();
            GoodsDetails gdobj = GoodsDetails.find(gdid); //可以获得这个订单中的信息
            Goods g = Goods.find(gdobj.getNode());
            
           // Commodity coobj = Commodity.find(gdobj.getSupplier());
            BuyPrice bpobj = BuyPrice.find(gdobj.getSupplier(), 1);
            String s = gdobj.getSupply();
            if(gdobj.getSupply_2()!=null && gdobj.getSupply_2().length()>0)
            {
            	s= gdobj.getSupply_2();
            }
            
           // g
			//每个批次的总价格
			BigDecimal gdt = this.setRbTotal(community,gdobj.getPaid(),gdobj.getNode(),s);//
			p = p.add(gdt);
        }
		return p;
    } 

	//获取每个数量乘以价格 的总价格
    public java.math.BigDecimal setRbTotal(String community,String paid,int node,String supply) throws SQLException
    {
        java.math.BigDecimal t = new java.math.BigDecimal("0");
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select quantity from OrdersBatch where community=" + db.cite(community) + " and paid=" + db.cite(paid) + " and node=" + node);
            while(db.next())
            {
                t = t.add(new BigDecimal(db.getInt(1)).multiply(new BigDecimal(supply)));
            }
        } finally
        {
            db.close();
        }
        return t.setScale(2,4);
    }
	//获取调出的调入的
	public BigDecimal setTotal2(String community,int node,int warid,String f) throws SQLException
  {

		DbAdapter db =new DbAdapter();
		java.math.BigDecimal p = new java.math.BigDecimal("0"); //调拨单价格
		try
		{

			db.executeQuery("select co.total from Callout co,GoodsDetails gd where co.purchase=gd.paid and gd.node="+node+" AND co."+f+"="+warid);
			while(db.next())
			{
				p = p.add(new java.math.BigDecimal(db.getString(1)));
			}
		}
		finally
		{
			db.close();
		}
		return p.setScale(2,4);
  }



//community ,orders 订单号  数量 quantity  金额 amount  仓库warid
	public static void setQT(String community,String orders,int warid,int quantity,java.math.BigDecimal amount)throws SQLException
	{
        java.util.Enumeration e = GoodsDetails.find(community," AND paid = "+DbAdapter.cite(orders),0,Integer.MAX_VALUE);
        while(e.hasMoreElements())
		{
			int gdid = ((Integer)e.nextElement()).intValue();
			GoodsDetails gdobj = GoodsDetails.find(gdid);//可以获得这个订单中的信息
			int invid = Inventory.getInvid(community,gdobj.getNode(),warid);//库存中记录的 id
			Inventory inobj = Inventory.find(invid);
			int invq = inobj.getQuantity()-quantity;//库存开始有的数量 减去 订单中的数量
			java.math.BigDecimal invt = inobj.getTotal().subtract(amount);
			inobj.setInventortyQT(invq,invt);
		}
	}

    //修改数量和金额
    public void setInventortyQT(int quantity,java.math.BigDecimal amount) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Inventory SET quantity=" + quantity + " , total=" + amount + " WHERE invid=" + invid);
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
            db.executeQuery("SELECT COUNT(invid) FROM Inventory  WHERE community=" + db.cite(community) + sql);
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
	public static int count2(String community,String sql) throws SQLException
  {
	  int count = 0;
	  DbAdapter db = new DbAdapter();
	  try
	  {
		  db.executeQuery("SELECT COUNT(distinct(goods) ) FROM Inventory  WHERE community=" + db.cite(community) + sql);
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


    public String getCommunity()
    {
        return community;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getGoods()
    {
        return goods;
    }

    public BigDecimal getTotal()
    {
        return total;
    }

    public int getWarname()
    {
        return warname;
    }

    public BigDecimal getPrice()
    {
        return price;
    }

    public int getQuantity()
    {
        return quantity;
    }


}
