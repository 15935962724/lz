package tea.entity.admin.erp.semi;

import java.math.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import tea.entity.admin.erp.*;
//半成品库存管理
public class SemiInventory extends Entity
{
	private int invid;
	private int goods; //商品ID半成品id....记录的是供应商供货的ID。。。
	private int quantity; //库存
	private int warname; //仓库ID     .
	private String community;
	private boolean exists;
	private BigDecimal price;//单价
	private BigDecimal total;//合计
	private int goodsnumber;//商品ID半成品id

	public SemiInventory(int invid) throws SQLException
	{
		this.invid = invid;
		load();
	}

	public static SemiInventory find(int invid) throws SQLException
	{
		return new SemiInventory(invid);
	}

	public void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT goods,quantity,warname,community,price,total,goodsnumber FROM SemiInventory WHERE invid=" + (invid));
			if(db.next())
			{
				goods = db.getInt(1);
				quantity = db.getInt(2);
				warname = db.getInt(3);
				community = db.getString(4);
				price =db.getBigDecimal(5,2);
				total = db.getBigDecimal(6,2);
				goodsnumber= db.getInt(7);
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

	public static void create(int goods,int quantity,int warname,String community,BigDecimal price,BigDecimal total,int goodsnumber) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		Date times = new Date();
		try
		{
			db.executeUpdate("INSERT INTO SemiInventory (goods,quantity,warname,community,price,total,goodsnumber) VALUES (" + (goods) + "," + (quantity) + "," + (warname) + "," + db.cite(community) + ","+price+","+total+","+goodsnumber+")");
		} finally
		{
			db.close();
		}
	}

	public void set(int goods,int quantity,int warname,String community,BigDecimal price,BigDecimal total,int goodsnumber) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		Date times = new Date();
		try
		{
			db.executeUpdate("UPDATE SemiInventory SET goods=" + (goods) + ",quantity=" + quantity + ",warname=" + warname + ",community=" + db.cite(community) + ",price="+price+",total="+total+",goodsnumber="+goodsnumber+" WHERE invid = " + invid);
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
			db.executeQuery("SELECT invid FROM SemiInventory WHERE community= " + db.cite(community) + sql);
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
	public static Enumeration findgoodsnumber(String community,String sql,int pos,int size)
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT distinct goodsnumber  FROM SemiInventory WHERE community= " + db.cite(community) + sql);
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
			 db.executeQuery("SELECT invid FROM SemiInventory WHERE community = "+db.cite(community)+" AND goods = "+goods+" AND warname = "+warname);
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

	public static void  addTotal(String qq,String tt,String f ,String community,int goods,int warname,int quantity,String total)throws SQLException
	{
		DbAdapter db = new DbAdapter();
		int q = 0;
		java.math.BigDecimal t = new java.math.BigDecimal(0);
		try
		{
			db.executeQuery("SELECT quantity,total FROM SemiInventory WHERE community = " + db.cite(community) + " AND goods = " + goods + " AND warname = " + warname);
			while(db.next())
			{
				q = db.getInt(1);
				t=db.getBigDecimal(2,2);

			}
			if("true".equals(f)){
				q = q + quantity;
				t = t.add(new BigDecimal(total));
			}else if("false".equals(f))
			{
				q = q - (Integer.parseInt(qq) - quantity);
				t = t.subtract(new BigDecimal(tt).subtract(new BigDecimal(total)) );
			}else
			{
					q=q-quantity;
					t=t.subtract(new BigDecimal(total));
			}

			db.executeUpdate("UPDATE SemiInventory SET quantity = " + q + ",total="+t+" WHERE community = " + db.cite(community) + " AND goods = " + goods + " AND warname = " + warname);
		} finally
		{
			db.close();
		}
	}


	public static void  subtractTotal(String f ,String community,int goods,int warname,int quantity,String total)throws SQLException
	{
		DbAdapter db = new DbAdapter();
		int q = 0;
		  //f  true +++=,false  ----
		java.math.BigDecimal t = new java.math.BigDecimal(0);
		try
		{
			db.executeQuery("SELECT quantity,total FROM SemiInventory WHERE community = " + db.cite(community) + " AND goods = " + goods + " AND warname = " + warname);
			while(db.next())
			{
				q = db.getInt(1);
				t=db.getBigDecimal(2,2);
			}
            if("true".equals(f))
            {
                q = q + quantity;
                t = t.add(new BigDecimal(total));
            } else if("false".equals(f))
            {
                q = q - quantity;
                t = t.subtract(t.subtract(new BigDecimal(total)));
            }
			db.executeUpdate("UPDATE SemiInventory SET quantity = " + q + ",total="+t+" WHERE community = " + db.cite(community) + " AND goods = " + goods + " AND warname = " + warname);
		} finally
		{
			db.close();
		}
    }
    //community ,数量 quantity,商品 Node ,仓库,半成品的编号
    public static void setQuantity(String community,int node,int warid,int quantity,int goodsnumber) throws SQLException
    {
        int inid = SemiInventory.getInvid(community,node,warid);
        if(inid > 0) //说明库存里面有这个商品
        {
            SemiInventory inobj = SemiInventory.find(inid);
            inobj.setInventortyQT(inobj.getQuantity() + quantity,inobj.getTotal());
        } else //
        {
            SemiInventory.create(node,quantity,warid,community,null,null,goodsnumber);
        }
    }

	public static void setQuantity(String community,int node,int warid,int quantity,String jj)throws SQLException
	{
	   int inid = SemiInventory.getInvid(community,node,warid);
	   SemiInventory inobj = SemiInventory.find(inid);
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
			SemiInventory.create(node,qs,warid,community,null,null);
		}
	}
	public static void create(int goods,int quantity,int warname,String community,BigDecimal price,BigDecimal total) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		Date times = new Date();
		try
		{
			db.executeUpdate("INSERT INTO SemiInventory (goods,quantity,warname,community,price,total) VALUES (" + (goods) + "," + (quantity) + "," + (warname) + "," + db.cite(community) + ","+price+","+total+")");
		} finally
		{
			db.close();
		}
	}

	public void setInventortyQT(int quantity,java.math.BigDecimal amount) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE SemiInventory SET quantity=" + quantity + " , total=" + amount + " WHERE invid=" + invid);
		} finally
		{
			db.close();
		}
	}

	//销售单中的库存修改
	public static void  addInv(int yq,String s,boolean f ,String community,int goods,int warname,int quantity,BigDecimal price)throws SQLException
   {
	   DbAdapter db = new DbAdapter();
	   int q = 0;
	   java.math.BigDecimal p = new java.math.BigDecimal(0);
	   java.math.BigDecimal t = new java.math.BigDecimal(0);
	   try
	   {
		   db.executeQuery("SELECT quantity,total FROM SemiInventory WHERE community = " + db.cite(community) + " AND goods = " + goods + " AND warname = " + warname);
		   while(db.next())
		   {
			   q = db.getInt(1);
			   t = db.getBigDecimal(2,2);
		   }
		   if(f){//修改库存数量
			   q = q - quantity;
		   }
		   else
		   {
			   q = q - (quantity- yq);
		   }
		   p = price.multiply(new BigDecimal(quantity));//添加的数量乘以 价格
		   if(f)
		   {
			   t = t.subtract(p);
		   }
		   else
		   {

			 t = t.subtract(p.subtract(new java.math.BigDecimal(s)) );
		   }

		   db.executeUpdate("UPDATE SemiInventory SET quantity = " + q + ",total = " + t + " WHERE community = " + db.cite(community) + " AND goods = " + goods + " AND warname = " + warname);
	   } finally
	   {
		   db.close();
	   }
   }

	//通过 商品 是仓库 可以知道 id
	public static int  getInvid(String community,int goods,int warname)throws SQLException
	{
		 DbAdapter db = new DbAdapter();
		 int f = 0;
		 try
		 {
			 db.executeQuery("SELECT invid FROM SemiInventory WHERE community = "+db.cite(community)+" AND goods = "+goods+" AND warname = "+warname);
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


	public static int count(String community,String sql) throws SQLException
	{
		int count = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT COUNT(invid) FROM SemiInventory  WHERE community=" + db.cite(community) + sql);
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
	//计算商品总价格
	public static BigDecimal sumPrice(int goods,int warname,String community)throws SQLException
	{
        BigDecimal bb = new BigDecimal("0");
		BigDecimal qq = new BigDecimal("0");
		DbAdapter db = new DbAdapter();
		String sql = " and sgid="+goods+" and paid in (select paid from SemiGoodsDetails where warehouse="+warname+")";
		try
		{
			Enumeration eu = OrdersBatch.find(community,sql,0,Integer.MAX_VALUE);
			while(eu.hasMoreElements())
			{
				int boid= Integer.parseInt(String.valueOf(eu.nextElement()));
				OrdersBatch bobj = OrdersBatch.find(boid);
				qq= new BigDecimal(bobj.getQuantity());
				bb = bb.add((bobj.getPrice().multiply(qq)));
			}
		}
		finally
		{
			db.close();
		}
        return bb.setScale(2);
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

    public int getGoodsnumber()
    {
        return goodsnumber;
    }

    public int getInvid()
    {
        return invid;
    }


}
