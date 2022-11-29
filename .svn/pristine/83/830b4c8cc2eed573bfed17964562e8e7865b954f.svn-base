package tea.entity.admin.erp;

import java.math.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import tea.entity.node.*;

public class ReturnedShop extends Entity
{
	private String purchase; //销售单
	private int supplname; //加盟店
	private int waridname; //仓库
	private String rsgoods; //入库单中的所有商品
	private String quantityarr; //每个商品的数量
	private String totalarr; //每个商品的价格
	private String quantity; //合计数量
	private String total; //合计价格
	private Date time_s; //入库日期
	private String member; //经办人
	private String community; //社区
	private String remarks; //备注
	private String discountarr; //折扣
	private String supplyarr; //商品单价
	private String total_2; //折后金额总计
	private String dsupplyarr; //折后单价
	private int type; //退货单 0 添加退货默认 1 为可以退货 2 不同意退货 3为软删除 4，收到退货
	public static final String TYPE_NAME[] =
			{"处理中","等待总部确认订单","已下单,正在备货","已下单,正在备货","备货完成，正在发货","","","","",""};
	private String member2; //联系人
	private String telephone; //联系电话
	private String address; //联系地址
	private String remarksarr; //商品的备注
	//商品发货时候用
	private String city; //省州，城市
	private String shipaddress; //收货地址
	private String consignee; //收货人
	private String zip; //邮编
	private String tel; //电话
	private Date stime; //发布时间
	private Date ftime; //到达时间
	private Date updatetime; //订单最后一次的更新日期
	private boolean exists;


	public ReturnedShop(String purchase) throws SQLException
	{
		this.purchase = purchase;
		load();
	}

	public static ReturnedShop find(String purchase) throws SQLException
	{
		return new ReturnedShop(purchase);
	}

	public void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT supplname,waridname,quantityarr,totalarr,quantity,total,time_s,member,community,remarks,rsgoods,discountarr,supplyarr,total_2,dsupplyarr,type,member2,telephone,address,remarksarr,city,shipaddress,consignee,zip, tel,stime,ftime,updatetime FROM ReturnedShop WHERE purchase =" + db.cite(purchase));
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
				discountarr = db.getString(12);
				supplyarr = db.getString(13);
				total_2 = db.getString(14);
				dsupplyarr = db.getString(15);
				type = db.getInt(16);
				member2 = db.getString(17);
				telephone = db.getString(18);
				address = db.getString(19);
				remarksarr = db.getString(20);
				city = db.getString(21); //省州，城市
				shipaddress = db.getString(22); //收货地址
				consignee = db.getString(23); //收货人
				zip = db.getString(24); //邮编
				tel = db.getString(25); //电话
				stime = db.getDate(26); //发布时间
				ftime = db.getDate(27); //到达时间
				updatetime = db.getDate(28);
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

	public static void create(String purchase,int supplname,int waridname,String quantityarr,String totalarr,String quantity,String total,Date time_s,String member,String community,String remarks,String rsgoods,String discountarr,String supplyarr,String total_2,String dsupplyarr,int type,String member2,String telephone,String address,String remarksarr,Date updatetime) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		Date times = new Date();
		try
		{
			db.executeUpdate("INSERT INTO ReturnedShop (purchase,supplname,waridname,quantityarr,totalarr,quantity,total,time_s,member,community,remarks,rsgoods,discountarr,supplyarr," +
							 " total_2,dsupplyarr,type,member2, telephone,address,remarksarr,updatetime) VALUES (" + db.cite(purchase) + "," + (supplname) + "," + (waridname) + "," + db.cite(quantityarr) + "," + db.cite(totalarr) + "," + db.cite(quantity) + "," + db.cite(total) + "," + db.cite(time_s) + "," + db.cite(member) + "," + db.cite(community) + "," + db.cite(remarks) + "," + db.cite(rsgoods) + "," + db.cite(discountarr) + "," + db.cite(supplyarr) + "," + db.cite(total_2) + "," + db.cite(dsupplyarr) + "," + type + "," + db.cite(member2) + "," + db.cite(telephone) + "," + db.cite(address) + "," + db.cite(remarksarr) + "," + db.cite(updatetime) + " )");
		} finally
		{
			db.close();
		}
	}

	public void set(int supplname,int waridname,String quantityarr,String totalarr,String quantity,String total,Date time_s,String member,String community,String remarks,String rsgoods,String discountarr,String supplyarr,String total_2,String dsupplyarr,int type,String member2,String telephone,String address,String remarksarr,Date updatetime) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		Date times = new Date();
		try
		{
			db.executeUpdate("UPDATE ReturnedShop SET supplname=" + (supplname) + ",waridname=" + waridname + ",quantityarr=" + db.cite(quantityarr) + ",totalarr=" + db.cite(totalarr) + ",quantity=" + db.cite(quantity) + ",total=" + db.cite(total) + ",time_s=" + db.cite(time_s) + ",member=" + db.cite(member) + ",community=" + db.cite(community) + ",remarks=" + db.cite(remarks) + ",rsgoods=" + db.cite(rsgoods) + ",discountarr=" + db.cite(discountarr) + ",supplyarr=" + db.cite(supplyarr) + ",total_2=" + db.cite(total_2) + ",dsupplyarr=" + db.cite(dsupplyarr) + ",type=" + type + ",member2=" + db.cite(member2) + ",telephone=" + db.cite(telephone) + ",address=" + db.cite(address) + ",remarksarr=" + db.cite(remarksarr) + ",updatetime=" + db.cite(updatetime) + "  WHERE purchase = " +
							 db.cite(purchase));
		} finally
		{
			db.close();
		}
	}

	public void set(String city,String shipaddress,String consignee,String zip,String tel,Date stime,Date ftime) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE ReturnedShop SET city=" + db.cite(city) + ",shipaddress=" + db.cite(shipaddress) + ",consignee=" + db.cite(consignee) + ",zip=" + db.cite(zip) + ",tel=" + db.cite(tel) + ",stime=" + db.cite(stime) + ",ftime=" + db.cite(ftime) + " WHERE purchase = " + db.cite(purchase));
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
			db.executeQuery("SELECT purchase FROM ReturnedShop WHERE community= " + db.cite(community) + sql);
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
			db.executeUpdate("DELETE FROM  ReturnedShop WHERE purchase = " + db.cite(purchase));

		} finally
		{
			db.close();
		}
	}

	public void setType(int type) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE ReturnedShop SET type =" + type + "  WHERE purchase = " + db.cite(purchase));
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
			db.executeQuery("SELECT COUNT(purchase) FROM ReturnedShop  WHERE community=" + db.cite(community) + sql);
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

	public static BigDecimal pfsum(String community,String sql,String attribute,int size) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		BigDecimal bb = new BigDecimal("0");
		try
		{
			db.executeQuery("SELECT " + attribute + " FROM ReturnedShop WHERE community= " + db.cite(community) + sql);
			for(int i = 0;db.next() && i < Integer.MAX_VALUE;i++)
			{
				vector.add(db.getString(1));
				BigDecimal bb2 = new BigDecimal(db.getString(1));
				bb = bb.add(bb2);
			}
		} catch(Exception exception3)
		{
			System.out.print(exception3);
		} finally
		{
			db.close();
		}
		return bb;
	}

///打折数值
	public static float getDis(int node) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		float d = 0;
		Node nobj = Node.find(node);
		Goods gobj = Goods.find(node);
		Commodity cobj = Commodity.find_goods(node);
		Date times = new Date();
		String g1 ="",g2="";
        if(gobj.getGoodstype().split("/").length - 2 >= 1)
        {
            g1 = " goodstype =" + gobj.getGoodstype().split("/")[2] + " or ";
        }
        if(gobj.getGoodstype().split("/").length - 3 >=1 )
        {
			g2= "goodstype2=" + gobj.getGoodstype().split("/")[3] + " or ";
        }

		try
		{

			db.executeQuery("select discounts from SupplierBrandDiscounts where supplier=" + cobj.getSupplier() + " and brand = " + gobj.getBrand() +
							" and starttime<=" + db.cite(sdf.format(times)) + " and  stoptime>=" + db.cite(sdf.format(times)) +
							" and( "+g1+" goodstype =0) and ( "+g2+" goodstype2=0)");
//			System.out.println("select discounts from SupplierBrandDiscounts where supplier=" + cobj.getSupplier() + " and brand = " + gobj.getBrand() +
//						   " and starttime<=" + db.cite(sdf.format(times)) + " and  stoptime>=" + db.cite(sdf.format(times)) +
//						   " and( "+g1+" goodstype =0) and ( "+g2+" goodstype2=0)");

			if(db.next())
			{
				d = db.getBigDecimal(1,2).floatValue();
			}

		} finally
		{
			db.close();
		}
		return d;
	}


//打折金额
	public static int getFloor(int node) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		int d = 0;
		Node nobj = Node.find(node);
		Goods gobj = Goods.find(node);
		Commodity cobj = Commodity.find_goods(node);
		Date times = new Date();
		String g1 ="",g2="";
		if(gobj.getGoodstype().split("/").length - 2 >= 1)
		{
			g1 = " goodstype =" + gobj.getGoodstype().split("/")[2] + " or ";
		}
		if(gobj.getGoodstype().split("/").length - 3 >=1 )
		{
			g2= "goodstype2=" + gobj.getGoodstype().split("/")[3] + " or ";
		}

		try
		{
			//db.executeQuery("select floor from SupplierBrandDiscounts where supplier=" + cobj.getSupplier() + " and brand = " + gobj.getBrand() +
			//" and starttime<=" + db.cite(sdf.format(times)) + " and  stoptime>=" + db.cite(sdf.format(times)) + "
					//and( goodstype =" + gobj.getGoodstype().split("/")[2] + " or goodstype =0) and (goodstype2=" + gobj.getGoodstype().split("/")[3] + " or goodstype2=0)");

			///System.out.println("select discounts from SupplierBrandDiscounts where supplier=" + cobj.getSupplier() + " and brand = " + gobj.getBrand() + " and starttime<=" + db.cite(sdf.format(times)) + " and  stoptime>=" + db.cite(sdf.format(times)) + " and goodstype =" + gobj.getGoodstype().split("/")[2] + " and goodstype2=" + gobj.getGoodstype().split("/")[3] + " ");
			db.executeQuery("select floor from SupplierBrandDiscounts where supplier=" + cobj.getSupplier() + " and brand = " + gobj.getBrand() +
									" and starttime<=" + db.cite(sdf.format(times)) + " and  stoptime>=" + db.cite(sdf.format(times)) +
							" and( "+g1+" goodstype =0) and ( "+g2+" goodstype2=0)");
			if(db.next())
			{
				d = db.getInt(1);
			}
		} finally
		{
			db.close();
		}
		return d;
	}


	//销售统计中的出货数量
	public static int getReturnQuantity(String communtiy,int supplname) throws SQLException
		{
			DbAdapter db = new DbAdapter();
			int s = 0;
			try
			{
				db.executeQuery("SELECT quantity FROM ReturnedShop WHERE community =" + db.cite(communtiy) + " AND supplname=" + supplname);
				while(db.next())
				{
					s = s + db.getInt(1);
				}
			} finally
			{
				db.close();
			}
			return s;
    }
	//销售统计中的出货总金额
  public static java.math.BigDecimal getAmount(String communtiy,int supplname) throws SQLException
  {
	  BigDecimal s = BigDecimal.ZERO;
	  DbAdapter db = new DbAdapter();
	  try
	  {
		  db.executeQuery("SELECT total_2 FROM ReturnedShop WHERE community =" + db.cite(communtiy) + " AND supplname=" + supplname);
		  while(db.next())
		  {
			  s = s.add(new java.math.BigDecimal(db.getString(1)));
		  }
	  } finally
	  {
		  db.close();
	  }
	  return s.setScale(2,4);
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
		{
			return "";
		}
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

	public String getDiscountarr() throws SQLException
	{
		return discountarr;
	}

	public String getSupplyarr() throws SQLException
	{
		return supplyarr;
	}

	public String getTotal_2() throws SQLException
	{
		return total_2;
	}

	public String getDsupplyarr() throws SQLException
	{
		return dsupplyarr;
	}

	public int getType() throws SQLException
	{
		return type;
	}

	public String getMember2() throws SQLException
	{
		return member2;
	}

	public String getTelephone() throws SQLException
	{
		return telephone;
	}

	public String getAddress() throws SQLException
	{
		return address;
	}

	public String getRemarksarr()
	{
		return remarksarr;
	}

	public String getCity()
	{
		return city;
	}

	public String getShipaddress()
	{
		return shipaddress;
	}

	public String getConsignee()
	{
		return consignee;
	}

	public String getZip()
	{
		return zip;
	}

	public String getTel()
	{
		return tel;
	}

	public Date getStime()
	{
		return stime;
	}

	public String getStimeToString()
	{
		if(stime == null)
		{
			return "";
		}
		return sdf.format(stime);
	}

	public Date getFtime()
	{
		return ftime;
	}

	public Date getUpdateTime()
	{
		return updatetime;
	}

	public String getFtimeToString()
	{
		if(ftime == null)
		{
			return "";
		}
		return sdf.format(ftime);
	}


}
