package tea.entity.admin.erp.semi;


import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

//半成品的细节表
public class SemiGoodsDetails extends Entity
{
    private int gdid;
    private String paid; //订单ID
    private int sgid; //半成品ID
    private String supply; //商品单价
    private int quantity; //合计数量
    private String total; //合计价格
    private String remarksarr; //商品备注
    private String community;
    private Date time_s; //进货日期 8 半成品生成规则，
    private int type; //0表示是进货单和销售单，1表示是加盟店的退货单,2入库单,3退货单,4调拨单,5b报损单,6配送单 7 赠送单     9.半成品合成 进货单,采购单  10.半成品合成成品  11.成品拆卸成半成品
    private int warehouse; //商品的仓库
    private int quantity2; //剩余数量quantity2,quantity22
    private int quantity22; //采购商品数量
    private int supplier; //供货商
    private String paidjj; //用的是原有的那笔订单 当type=10
    private boolean exists;

    public SemiGoodsDetails(int gdid) throws SQLException
    {
        this.gdid = gdid;
        load();
    }

    public static SemiGoodsDetails find(int gdid) throws SQLException
    {
        return new SemiGoodsDetails(gdid);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT paid,sgid,supply,quantity,total,remarksarr,community,time_s,type,warehouse,quantity2,quantity22,supplier,paidjj FROM SemiGoodsDetails WHERE gdid=" + gdid);
            if(db.next())
            {
                int j = 1;
                paid = db.getString(j++);
                sgid = db.getInt(j++);
                supply = db.getString(j++);
                quantity = db.getInt(j++);
                total = db.getString(j++);
                remarksarr = db.getString(j++);
                community = db.getString(j++);
                time_s = db.getDate(j++);
                type = db.getInt(j++);
                warehouse = db.getInt(j++);
                quantity2 = db.getInt(j++);
                quantity22 = db.getInt(j++);
                supplier = db.getInt(j++);
				paidjj = db.getString(j++);
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

    public static void create(String paid,int sgid,String supply,int quantity,String total,String remarksarr,String community,int type,int warehouse,int quantity2,int quantity22) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO SemiGoodsDetails (paid,sgid,supply,quantity,total,remarksarr,community,type,warehouse,quantity2,quantity22) VALUES (" + db.cite(paid) + "," + sgid + "," + db.cite(supply) + "," + quantity + "," + db.cite(total) + "," + db.cite(remarksarr) + "," + db.cite(community) + "," + type + "," + warehouse + "," + quantity2 + "," + quantity22 + " )");
        } finally
        {
            db.close();
        }
    }
	//半成品合成 成品时需要记录的信息
    public static void createjj(String paid,int sgid,String supply,int quantity,String total,String remarksarr,String community,int type,int warehouse,int quantity2,int quantity22,int supplier,String paidjj) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO SemiGoodsDetails (paid,sgid,supply,quantity,total,remarksarr,community,type,warehouse,quantity2,quantity22,supplier,paidjj) VALUES (" + db.cite(paid) + "," + sgid + "," + db.cite(supply) + "," + quantity + "," + db.cite(total) + "," + db.cite(remarksarr) + "," + db.cite(community) + "," + type + "," + warehouse + "," + quantity2 + "," + quantity22 + ","+supplier+","+paidjj+" )");
        } finally
        {
            db.close();
        }
    }


    public static void set(String paid,int sgid,String supply,int quantity,String total,String remarksarr,Date time_s,int type,int warehouse) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE SemiGoodsDetails SET supply=" + db.cite(supply) + ",quantity=" + quantity + ",total=" + db.cite(total) + ",remarksarr=" + db.cite(remarksarr) + ",time_s=" + db.cite(time_s) + ",type=" + type + ",warehouse=" + warehouse +  " WHERE paid=" + db.cite(paid) + "AND sgid=" + sgid);
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
            db.executeQuery("SELECT gdid FROM SemiGoodsDetails WHERE community= " + db.cite(community) + sql,pos,size);
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

    public static java.math.BigDecimal getTotal(String community,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        java.math.BigDecimal t = new java.math.BigDecimal("0");
        try
        {
            db.executeQuery("SELECT total FROM SemiGoodsDetails WHERE community= " + db.cite(community) + sql);
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
            db.executeUpdate("DELETE FROM SemiGoodsDetails WHERE gdid=" + gdid);
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
            db.executeQuery("SELECT COUNT(gdid) FROM SemiGoodsDetails  WHERE community=" + db.cite(community) + sql);
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

    public static int isGdid(String community,int sgid,String paid,int type) throws SQLException
    {
        int gdid = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT gdid FROM SemiGoodsDetails  WHERE community=" + db.cite(community) + " AND sgid=" + sgid + " AND paid=" + db.cite(paid) + " AND type=" + type);
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

	public static int isGdid(String community,int sgid,String paid,int type,String paidjj) throws SQLException
	{
		int gdid = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT gdid FROM SemiGoodsDetails  WHERE community=" + db.cite(community) + " AND sgid=" + sgid + " AND paid=" + db.cite(paid) + " AND type=" + type+" and paidjj="+paidjj);
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


	public static int isGdid(String community,int sgid,String paid) throws SQLException
		{
			int gdid = 0;
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery("SELECT gdid FROM SemiGoodsDetails  WHERE community=" + db.cite(community) + " AND sgid=" + sgid + " AND paid=" + db.cite(paid));
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
            db.executeQuery("SELECT gdid FROM SemiGoodsDetails  WHERE community=" + db.cite(community) + " AND paid=" + db.cite(paid) + " AND type=" + type);
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

    public static String getSemiGoodsarr(String community,String paid,int type) throws SQLException
    {
        StringBuffer SemiGoodsarr = new StringBuffer("/");
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT sgid FROM SemiGoodsDetails  WHERE community=" + db.cite(community) + " AND paid=" + db.cite(paid));
            while(db.next())
            {
                SemiGoodsarr.append(db.getInt(1)).append("/");
            }
        } finally
        {
            db.close();
        }
        return SemiGoodsarr.toString();

    }

    public static int getGoodsTYPE(String community,String paid) throws SQLException
    {
        int type = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT type FROM SemiGoodsDetails  WHERE community=" + db.cite(community) + " AND paid=" + db.cite(paid));
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


    //修改时间
    public static void setTime_s(String paid,Date time_s) throws SQLException
    {

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM SemiGoodsDetails WHERE time_s is  null ");
            db.executeUpdate("UPDATE SemiGoodsDetails SET  time_s=" + db.cite(time_s) + " WHERE paid=" + db.cite(paid));
        } finally
        {
            db.close();
        }
    }
	public static void setTime_s(String paid,Date time_s,int warehouse) throws SQLException
	{

		DbAdapter db = new DbAdapter();

		try
		{
			db.executeUpdate("UPDATE SemiGoodsDetails SET  time_s=" + db.cite(time_s) + ",warehouse=" + warehouse + " WHERE paid=" + db.cite(paid));
			db.executeUpdate("DELETE FROM SemiGoodsDetails WHERE time_s is  null ");
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
            db.executeQuery("select gdid from SemiGoodsDetails where paid =" + db.cite(paid));
            while(db.next())
            {
                SemiGoodsDetails gobj = SemiGoodsDetails.find(db.getInt(1));
                db2.executeUpdate("update SemiGoodsDetails set quantity22 =" + gobj.getQuantity() + ",quantity2=0 where gdid=" + db.getInt(1));
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
            db.executeUpdate("update SemiGoodsDetails set quantity2 =" + quantity2 + " where gdid=" + gdid);
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
            db.executeQuery("select gdid from  SemiGoodsDetails  where quantity2 !=0  and  paid=" + db.cite(paid));
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

    //修改进货数量
    public void setQuantity(int quantity) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update SemiGoodsDetails set quantity =" + quantity + " where gdid=" + gdid);
        } finally
        {
            db.close();
        }
    }

    public static void clearTime() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete SemiGoodsDetails  where time_s is null");
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

    public int getGdid()
    {
        return gdid;
    }

    public int getSgid()
    {
        return sgid;
    }

    public int getQuantity22()
    {
        return quantity22;
    }

    public int getQuantity2()
    {
        return quantity2;
    }

    public int getSupplier()
    {
        return supplier;
    }

    public String getPaidjj()
    {
        return paidjj;
    }
}
