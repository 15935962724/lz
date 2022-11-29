package tea.entity.admin.erp;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import java.math.BigDecimal;

public class GoodsDetails extends Entity
{
    private int gdid;
    private String paid; //订单ID
    private int node; //商品ID
    private String supply; //商品单价
    private String discount; //折扣
    private String dsupply; //折后单价
    private int quantity; //合计数量
    private String total; //合计价格
    private String remarksarr; //商品备注
    private String community;
    private Date time_s; //进货日期
    private int type; //0表示是进货单和销售单，1表示是加盟店的退货单,2入库单,3退货单,4调拨单,5b报损单,6配送单 7 赠送单 8 半成品 生成规则， 9 ，半成品 采购单 10 ，半成品 合成 成品
    private int warehouse; //商品的仓库
    private String discount2; //商品的打折
    private int quantity2; //采购剩余数量
    private int quantity22; //采购数量
    private int rgquantity; //退货数量
    private int coquantity; //调拨数量
    private int lossquantity; //报损数量
    private int paiquantity; //销售数量
    private int rsquantity; //加盟店给总部的退货数量
    private int dbquantity; //配送数量
    private int clquantity; //赠送数量
    private int supplier; //供货商
    private String supply_2;//采购的商品的销售价格
    private String purchaseid; //采购单的订单号
    //private int
	public  static final  String TYPE [] ={"总部销售单","加盟店退货单","总部采购单","总部退货单","总部调拨单","总部报损单","总部配送单","总部赠送单"};
    private boolean exists;
//
//    static
//    {
//
//    }
    public GoodsDetails(int gdid) throws SQLException
    {
        this.gdid = gdid;
        load();
    }

    public static GoodsDetails find(int gdid) throws SQLException
    {
        return new GoodsDetails(gdid);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        { 
            db.executeQuery("SELECT paid,node,supply,discount,dsupply,quantity,total,remarksarr,community,time_s,type,warehouse,discount2,quantity22,quantity2,rgquantity,purchaseid,coquantity,lossquantity," +
                            " paiquantity,rsquantity,dbquantity,clquantity,supplier,supply_2 FROM GoodsDetails WHERE gdid=" + gdid);
            if(db.next())
            {
                paid = db.getString(1);
                node = db.getInt(2);
                supply = db.getString(3);
                discount = db.getString(4);
                dsupply = db.getString(5);
                quantity = db.getInt(6);
                total = db.getString(7);
                remarksarr = db.getString(8);
                community = db.getString(9);
                time_s = db.getDate(10);
                type = db.getInt(11);
                warehouse = db.getInt(12);
                discount2 = db.getString(13);
                quantity22 = db.getInt(14);
                quantity2 = db.getInt(15);
                rgquantity = db.getInt(16);
                purchaseid = db.getString(17);
                coquantity = db.getInt(18);
                lossquantity = db.getInt(19);
                paiquantity = db.getInt(20);
                rsquantity = db.getInt(21);
                dbquantity = db.getInt(22);
                clquantity = db.getInt(23);
                supplier = db.getInt(24);
                supply_2=db.getString(25);
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

    public static int create(String paid,int node,String supply,String discount,String dsupply,int quantity,String total,String remarksarr,String community,int type,int warehouse,String discount2) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int gd = 0;
        try
        {
            db.executeUpdate("INSERT INTO GoodsDetails (paid,node,supply,discount,dsupply,quantity,total,remarksarr,community,type,warehouse,discount2) VALUES (" + db.cite(paid) + "," + node + "," + db.cite(supply) + "," + db.cite(discount) + "," + db.cite(dsupply) + "," + quantity + "," + db.cite(total) + "," + db.cite(remarksarr) + "," + db.cite(community) + "," + type + "," + warehouse + "," + db.cite(discount2) + " )");
            gd = db.getInt("SELECT MAX(gdid) FROM GoodsDetails");
        } finally
        {
            db.close();
        }
        return gd;
    }

    public void set(String supply,String discount,String dsupply,int quantity,String total,String discount2) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE GoodsDetails SET supply=" + db.cite(supply) + ",discount=" + db.cite(discount) + ",dsupply=" + db.cite(dsupply) + ",quantity=" + quantity + ",total=" + db.cite(total) + ",discount2=" + db.cite(discount2) + " WHERE gdid=" + gdid);
        } finally
        {
            db.close();
        }
    }

// 修改供货商
    public void setSupplier(int supplier) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE GoodsDetails SET supplier=" + supplier + " WHERE gdid=" + gdid);
        } finally
        {
            db.close();
        }
    }
    //修改采购的实际价格
    public void setSupply_2(String supply_2)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE GoodsDetails SET supply_2=" + db.cite(supply_2) + " WHERE gdid=" + gdid);
        } finally
        {
            db.close();
        }
    }

//通过 订单号和商品
    public static void set(String paid,int node,String supply,String discount,String dsupply,int quantity,String total,String remarksarr,Date time_s,int type,int warehouse,String discount2) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE GoodsDetails SET supply=" + db.cite(supply) + ",discount=" + db.cite(discount) + ",dsupply=" + db.cite(dsupply) + ",quantity=" + quantity + ",total=" + db.cite(total) + ",remarksarr=" + db.cite(remarksarr) + ",time_s=" + db.cite(time_s) + ",type=" + type + ",warehouse=" + warehouse + ",discount2=" + db.cite(discount2) + " WHERE paid=" + db.cite(paid) + "AND node=" + node);
        } finally
        {
            db.close();
        }

    }

//修改商品的总价格和数量
    public void setCOQT(int quantity,String total) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE GoodsDetails SET quantity = " + quantity + ", total=" + db.cite(total) + " WHERE gdid=" + gdid);
        } finally
        {
            db.close();
        }
        this.total = total;
        this.quantity = quantity;

    }

    //通过供货商和订单号删除商品
    public static void SuppDelete(String paid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from GoodsDetails where  paid=" + db.cite(paid));
        } finally
        {
            db.close();
        }

    }

    public static int getGDid(String paid,int node) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int i = 0;
        try
        {
            db.executeQuery("SELECT gdid FROM  GoodsDetails  WHERE paid=" + db.cite(paid) + " AND node=" + node);
            if(db.next())
            {
                i = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return i;
    }
	//通过订单号 获取最近一个的折扣
	public static int getDico(String paid)throws SQLException
	{
        DbAdapter db = new DbAdapter();
        int i = 0;
        try
        {
            db.executeQuery("SELECT discount FROM  GoodsDetails  WHERE paid=" + db.cite(paid) +" order by gdid desc");
            if(db.next())
            {
                i = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return i;

	}

    //修改备注
    public void set(String remarksarr) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE GoodsDetails SET remarksarr=" + db.cite(remarksarr) + " WHERE gdid=" + gdid);
        } finally
        {
            db.close();
        }

    }

    //修改存放仓库
    public void setWarehouse(int warehouse) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE GoodsDetails SET warehouse=" + warehouse + " WHERE gdid=" + gdid);
        } finally
        {
			db.close();
        }
		this.warehouse = warehouse;

    }


//获取总金额
    public static java.math.BigDecimal getTotal_2(String purchase) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        java.math.BigDecimal t = new java.math.BigDecimal("0");
        try
        {
            db.executeQuery("SELECT total FROM GoodsDetails WHERE paid=" + db.cite(purchase));
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

    public static String getTimes_sas(String purchase) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        java.text.SimpleDateFormat sf = new java.text.SimpleDateFormat("yyyy-MM-dd"); //yyyy-MM-dd
        GregorianCalendar gc = new GregorianCalendar();
        try
        {
            db.executeQuery("SELECT time_s FROM GoodsDetails WHERE paid=" + db.cite(purchase));
            if(db.next())
            {
                if(db.getDate(1) != null)
                {
                    times = db.getDate(1);
                }
            }
            gc.setTime(times);
            gc.add(2, +3);
            gc.set(gc.get(Calendar.YEAR),gc.get(Calendar.MONTH),gc.get(Calendar.DATE));
            times = gc.getTime();

        } finally
        {
            db.close();
        }

        return sdf.format(times);
    }

    public static Enumeration find(String community,String sql,int pos,int size)
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
           System.out.println("SELECT gdid FROM GoodsDetails WHERE community= " + db.cite(community) + sql);
            db.executeQuery("SELECT gdid FROM GoodsDetails WHERE community= " + db.cite(community) + sql,pos,size);
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

	//获得细节表中的node

	//通过采购订单获取商品
	public static Enumeration findPurNode(String community,String tablename,String sql,int pos,int size)
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("select  gd.node from GoodsDetails gd,"+tablename+" p where gd.paid=p.purchase  and gd.time_s is not null  and   gd.community= " + db.cite(community) + sql+" group by gd.node",pos,size);
		//	db.executeQuery("select gd.node from "+tablename+" p,(select node ,max(paid) as max_paid from GoodsDetails group by node )gd where max_paid=p.purchase and   p.community="+db.cite(community)+sql+"  order by p.purchase desc ");
			//System.out.print("select gd.node from "+tablename+" p,(select node ,max(paid) as max_paid from GoodsDetails group by node )gd where max_paid=p.purchase and   p.community="+db.cite(community)+sql+"  order by p.purchase desc ");

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
//去掉重复的node 获得数量
	public static int countNode(String community,String tablename,String sql) throws SQLException
	{
		int count = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("  select  count(distinct(gd.node)) from GoodsDetails gd,"+tablename+" p where gd.paid=p.purchase  and gd.time_s is not null  and  p.community=" + db.cite(community) + sql);
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
//	//计算数量
//	public static int countQuantity(String community,int node)throws SQLException
//	{
//		int count = 0;
//		DbAdapter db = new DbAdapter();
//		try
//		{
//			db.executeQuery("  select gd.quantity from GoodsDetails gd,Purchase p where gd.paid=p.purchase  and p.flowtype =4  and gd.node ="+node+" and  p.community=" + db.cite(community));
//			while(db.next())
//			{
//				count = count+db.getInt(1);
//			}
//		} finally
//		{
//			db.close();
//		}
//		return count;
//
//	}
	//计算数量
	public static int countQuantity(String community,String tablename,String sql)throws SQLException
	{
		int count = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("  select gd.quantity from GoodsDetails gd,"+tablename+" p where gd.paid=p.purchase  and gd.time_s is not null   and  p.community=" + db.cite(community)+sql);
			while(db.next())
			{
				count = count+db.getInt(1);
			}
		} finally
		{
			db.close();
		}
		return count;
	}

//	计算金额

	public static java.math.BigDecimal countTotal(String community,String tablename,String sql)throws SQLException
	{
		java.math.BigDecimal t = new java.math.BigDecimal("0");
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("  select gd.total from GoodsDetails gd,"+tablename+" p where gd.paid=p.purchase  and gd.time_s is not null  and  p.community=" + db.cite(community)+sql);
			while(db.next())
			{
				t = t.add(new java.math.BigDecimal(db.getString(1)));
			}
		} finally
		{
			db.close();
		}
		return t.setScale(2,2);

	}



    //通过采购订单获取商品
    public static Enumeration findPur(String community,String sql,int pos,int size)
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select  gd.gdid from GoodsDetails gd,Purchase p where gd.paid=p.purchase  and gd.time_s is not null and p.flowtype =4  and  gd.community= " + db.cite(community) + sql,pos,size);
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

    //通过销售单 获取商品
    public static Enumeration findPai(String community,String sql,int pos,int size)
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select  gd.gdid from GoodsDetails gd,Paidinfull p where gd.paid=p.purchase  and gd.time_s is not null and (p.type!=0 or p.type!=1) and  gd.community= " + db.cite(community) + sql,pos,size);
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
//计算 订单的退货数量

	//销售统计中的出货数量
	public static int getReturnQuantity(String communtiy,String paid) throws SQLException
		{
			DbAdapter db = new DbAdapter();
			int s = 0;
			try
			{
				db.executeQuery("SELECT rsquantity FROM GoodsDetails WHERE community =" + db.cite(communtiy) + " AND paid=" + db.cite(paid));
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
  public static java.math.BigDecimal getAmount(String communtiy,String paid) throws SQLException
  {
	  BigDecimal s = BigDecimal.ZERO;
	  DbAdapter db = new DbAdapter();
	  try
	  {
		  db.executeQuery("SELECT rsquantity,supply FROM GoodsDetails WHERE community =" + db.cite(communtiy) + " AND paid=" + db.cite(paid));
		  while(db.next())
		  {
			  s = s.add(new BigDecimal(db.getInt(1)).multiply(new BigDecimal(db.getString(2))));
		  }
	  } finally
	  {
		  db.close();
	  }
	  return s;
  }

    public static java.math.BigDecimal getTotal(String community,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        java.math.BigDecimal t = new java.math.BigDecimal("0");
        try
        {
            db.executeQuery("SELECT total FROM GoodsDetails WHERE community= " + db.cite(community) + sql);
            while(db.next())
            {
                t = t.add(db.getBigDecimal(1,2));
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

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {

            db.executeUpdate("DELETE FROM GoodsDetails WHERE gdid=" + gdid);
        } finally
        {
            db.close();
        }

    }

//删除相关一样订单号的订单商品细节
    public static void delete(String paid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM GoodsDetails WHERE paid=" + db.cite(paid));
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
            db.executeQuery("SELECT COUNT(gdid) FROM GoodsDetails  WHERE community=" + db.cite(community) + sql);
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

    public static int countpur(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select  count(gd.gdid) from GoodsDetails gd,Purchase p where gd.paid=p.purchase  and gd.time_s is not null and p.flowtype =4  and  gd.community= " + db.cite(community) + sql);
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

    public static int countpai(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        { // select  gd.gdid from GoodsDetails gd,Paidinfull p where gd.paid=p.purchase  and gd.time_s is not null and (p.type!=0 or p.type!=1) and  gd.community=
            db.executeQuery("select  count(gd.gdid) from GoodsDetails gd,Paidinfull p where gd.paid=p.purchase  and gd.time_s is not null  and (p.type!=0 or p.type!=1)  and  gd.community= " + db.cite(community) + sql);
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

    public static int isGdid(String community,int node,String paid,int type) throws SQLException
    {
        int gdid = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT gdid FROM GoodsDetails  WHERE community=" + db.cite(community) + " AND node=" + node + " AND paid=" + db.cite(paid));
            if(db.next())
            {
                gdid = db.getInt(1);
            }
        } finally
        {
            db.close();
        }

        return gdid;
    }

    public static int isGZ(String community,String paid,int type) throws SQLException
    {
        int gdid = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT count(gdid) FROM GoodsDetails  WHERE community=" + db.cite(community) + "  AND paid=" + db.cite(paid) + " AND type=" + type);
            if(db.next())
            {
                gdid = db.getInt(1);
            }
        } finally
        {
            db.close();
        }

        return gdid;
    }

    public static int isGZnode(String community,int node,String paid,int type) throws SQLException
    {
        int gdid = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT count(gdid) FROM GoodsDetails  WHERE community=" + db.cite(community) + " and node=" + node + "  AND type=" + type);
            if(db.next())
            {
                gdid = db.getInt(1);
            }
        } finally
        {
            db.close();
        }

        return gdid;
    }


    public static boolean isPaid(String community,String paid,int type) throws SQLException
    {
        boolean f = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT gdid FROM GoodsDetails  WHERE community=" + db.cite(community) + " AND paid=" + db.cite(paid) + " AND type=" + type);
            if(db.next())
            {
                f = true;
            }
        } finally
        {
            db.close();
        }
        return f;
    }

    public static String getNodearr(String community,String paid,int type) throws SQLException
    {
        StringBuffer nodearr = new StringBuffer("/");
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM GoodsDetails  WHERE community=" + db.cite(community) + " AND paid=" + db.cite(paid));
            while(db.next())
            {
                nodearr.append(db.getInt(1)).append("/");
            }
        } finally
        {
            db.close();
        }
        return nodearr.toString();

    }

    public static int getGoodsTYPE(String community,String paid) throws SQLException
    {
        int type = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT type FROM GoodsDetails  WHERE community=" + db.cite(community) + " AND paid=" + db.cite(paid));
            if(db.next())
            {
                type = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return type;

    }

//修改数量和价格
    public void set(String supply,String total,int quantity) throws SQLException
    {

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE GoodsDetails SET  supply=" + db.cite(supply) + ",total=" + db.cite(total) + ",quantity=" + quantity + "  WHERE gdid=" + gdid);
        } finally
        {
            db.close();
        }
    }

    //修改数量和价格和折扣价格
    public void set(String supply,String total,int quantity,String dsupply) throws SQLException
    {

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE GoodsDetails SET  dsupply =" + db.cite(dsupply) + ", supply=" + db.cite(supply) + ",total=" + db.cite(total) + ",quantity=" + quantity + "  WHERE gdid=" + gdid);
        } finally
        {
            db.close();
        }
    }

    //修改时间
    public static void setTime_s(String paid,Date time_s,int warehouse) throws SQLException
    {

        DbAdapter db = new DbAdapter();

        try
        {
            db.executeUpdate("UPDATE GoodsDetails SET  time_s=" + db.cite(time_s) + ",warehouse=" + warehouse + " WHERE paid=" + db.cite(paid));
            db.executeUpdate("DELETE FROM GoodsDetails WHERE time_s is  null ");
        } finally
        {
            db.close();
        }
    }

// 删除一没有时间的 订单商品
    public static void delete2(String paid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM GoodsDetails WHERE time_s is  null and  paid=" + db.cite(paid));
        } finally
        {
            db.close();
        }
    }


//添加实际采购数量
    public static void setQuantity22(String paid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        DbAdapter db2 = new DbAdapter();
        try
        {
            //db.executeUpdate("UPDATE GoodsDetails SET  time_s="+db.cite(time_s)+" WHERE paid="+db.cite(paid));
            db.executeQuery("select gdid from GoodsDetails where paid =" + db.cite(paid));
            while(db.next())
            {
                GoodsDetails gobj = GoodsDetails.find(db.getInt(1));
                db2.executeUpdate("update GoodsDetails set quantity22 =" + gobj.getQuantity() + ",quantity2=0 where gdid=" + db.getInt(1));
            }
        } finally
        {
            db.close();
            db2.close();
        }
    }

    //修改剩余数量
    public void setQuantity2(int quantity2) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update GoodsDetails set quantity2 =" + quantity2 + " where gdid=" + gdid);
        } finally
        {
            db.close();
        }
    }

    //修改进货数量
    public void setQuantity(int quantity) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update GoodsDetails set quantity =" + quantity + " where gdid=" + gdid);
        } finally
        {
            db.close();
        }
    }

//修改进货金额
    public void setTotal(java.math.BigDecimal total) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update GoodsDetails set total =" + total + " where gdid=" + gdid);
        } finally
        {
            db.close();
        }
    }

    //判断还有没有剩余数量，如果没有了说明全部进货完成
    public static boolean isQuantity2(String paid) throws SQLException
    {
        boolean f = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select gdid from  GoodsDetails  where quantity2 !=0  and  paid=" + db.cite(paid));
            if(db.next())
            {
                f = true;
            }
        } finally
        {
            db.close();
        }
        return f;
    }

    //获取剩余数量总和
    public static int getQuantity2Total(String paid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int q2 = 0;
        try
        {
            db.executeQuery("select sum(quantity2) from  GoodsDetails where paid=" + db.cite(paid));
            if(db.next())
            {
                q2 = db.getInt(1);
            }

        } finally
        {
            db.close();
        }
        return q2;
    }

    //审核退货时候 要修改选择的采购单中的商品的退货数量
    public void setRgquantity(String community,String field,int rgquantity,String paid,int node,int type) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE GoodsDetails SET " + field + " = " + rgquantity + " WHERE community=" + db.cite(community) + " AND paid=" + db.cite(paid) + " AND node=" + node);
        } finally
        {
            db.close();
        }
    }

    //添加退货单时候 要添加退货单商品时属于哪个采购单的
    public void setPurchaseid(String purchaseid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE GoodsDetails SET purchaseid = " + db.cite(purchaseid) + " WHERE gdid = " + gdid);
        } finally
        {
            db.close();
        }
    }

//调拨单修改数量的方法
    public java.math.BigDecimal getCOTotal(String community,int quantity,int node) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int q2 = 0;
        java.math.BigDecimal su = new BigDecimal("0");
        int qqqqqqqqqqqqqq = 0;
        java.math.BigDecimal sssssssssssssssssss = new BigDecimal("0");

        try
        {

            db.executeQuery("select quantity22,supply from Purchase p,GoodsDetails gd where p.purchase=gd.paid and p.flowtype=4 and gd.node=" + node + " order by gd.time_s desc");
            while(db.next())
            {
                q2 = db.getInt(1);
                su = new java.math.BigDecimal(db.getString(2));
                if(q2 >= quantity) //要库存的采购单数值大于修改的数量
                {
                    sssssssssssssssssss = sssssssssssssssssss.add(su.multiply(new BigDecimal(quantity)).setScale(2));
                    break;
                } else if(q2 < quantity)
                {
                    sssssssssssssssssss = sssssssssssssssssss.add(su.multiply(new BigDecimal(q2).setScale(2)));
                    quantity = quantity - q2;
                }
            }
        } finally
        {
            db.close();
        }
        return sssssssssssssssssss;
    } //返回数量

    public void setCOquantity(int gdid,String field) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        GoodsDetails gdobj = GoodsDetails.find(gdid);
        int q2 = 0;
        int quantity = gdobj.getQuantity();
        int qqqqqqqqqqqqqq = 0;
        try
        {
            //quantity22 采购单中的采购数量
            db.executeQuery("select quantity22,gd.paid from Purchase p,GoodsDetails gd where p.purchase=gd.paid and p.flowtype=4 and gd.node=" + gdobj.getNode() + " order by gd.time_s desc");
            while(db.next())
            {
                q2 = db.getInt(1);
                GoodsDetails g222222222 = GoodsDetails.find(GoodsDetails.getGDid(db.getString(2),gdobj.getNode()));
                //添加是调拨那个采购单
                gdobj.setPurchaseid(db.getString(2));
                int quti = 0; //上次的数量 如 调拨单调拨数量
                if("coquantity".equals(field)) //调拨单
                {
                    quti = g222222222.getCoquantity();
                } else if("lossquantity".equals(field)) //报损单
                {
                    quti = g222222222.getLossquantity();
                } else if("paiquantity".equals(field)) //销售单
                {
                    quti = g222222222.getPaiquantity();
                } else if("dbquantity".equals(field)) //配送单
                {
                    quti = g222222222.getDbquantity();
                } else if("clquantity".equals(field)) //赠送单
                {
                    quti = g222222222.getClquantity();
                }
                if(q2 >= quantity && quantity > 0) //要库存的采购单数值大于修改的数量
                {
                    gdobj.setRgquantity(gdobj.getCommunity(),field,quantity + quti,db.getString(2),gdobj.getNode(),2);
                    quantity = 0;
                } else if(q2 < quantity && quantity > 0)
                {
                    gdobj.setRgquantity(gdobj.getCommunity(),field,quantity - q2 + quti,db.getString(2),gdobj.getNode(),2);
                    quantity = quantity - q2;
                }
            }
        } finally
        {
            db.close();
        }
    }

    //修改库存 逐步修改
    public static void setZQuantity(String community,int type,String paid,String field,int waridname,String member,String rv_,Date time_s) throws SQLException
    {
        java.util.Enumeration e = GoodsDetails.find(community,"and  paid=" + DbAdapter.cite(paid),0,Integer.MAX_VALUE); // and type = "+type+"
        while(e.hasMoreElements())
        {
            int gdid = ((Integer) e.nextElement()).intValue();
            GoodsDetails gdobj = GoodsDetails.find(gdid);

            //给采购单添加调拨数量
            gdobj.setCOquantity(gdid,field);
            //给商品流水表添加记录
            OrdersBatch.create(gdobj.getPaid(),gdobj.getNode(),gdobj.getQuantity(),member,rv_,community,time_s,5);
            //剩余数量计算使用库存里面的数量 减去 退货的数量 等于 开始数量
            //  int quan =  gdobj.getQuantity()-Integer.parseInt(quantity);
            //添加库存,应该减
            Inventory.setQuantity(community,gdobj.getNode(),waridname,gdobj.getQuantity(),"-");
            //修改了商品细节表中的商品退货数量
            //gdobj.setRgquantity(gdobj.get);
        }

    }

    public String getCommunity()
    {
        return community;
    }

    public String getDiscount()
    {
        return discount;
    }

    public String getDsupply()
    {
        return dsupply;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getNode()
    {
        return node;
    }

    public String getPaid()
    {
        return paid;
    }

    public int getQuantity()
    {
        return quantity;
    }

    public String getRemarksarr()
    {
        return remarksarr;
    }

    public String getSupply()
    {
        return supply;
    }

    public String getTotal()
    {
        return total;
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

    public int getType()
    {
        return type;
    }

    public int getWarehouse()
    {
        return warehouse;
    }

    public String getDiscount2()
    {
        return discount2;
    }

    public int getQuantity22()
    {
        return quantity22;
    }

    public int getQuantity2()
    {
        return quantity2;
    }

    public int getRgquantity()
    {
        return rgquantity;
    }

    public String getPurchaseid()
    {
        return purchaseid;
    }

    public int getCoquantity()
    {
        return coquantity;
    }

    public int getLossquantity()
    {
        return lossquantity;
    }

    public int getPaiquantity()
    {
        return paiquantity;
    }

    public int getRsquantity()
    {
        return rsquantity;
    }

    public int getDbquantity()
    {
        return dbquantity;
    }

    public int getClquantity()
    {
        return clquantity;
    }

    public int getSupplier()
    {
        return supplier;
    }
    public String getSupply_2()
    {
    	return supply_2;
    }

}
