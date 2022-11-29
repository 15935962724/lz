package tea.entity.admin.erp;

import java.math.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import tea.entity.node.*;
import tea.entity.league.*;
import tea.entity.admin.*;
public class Paidinfull extends Entity
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
    private int type; //总部下的销售单 默认为0 ，个人下的订货单为 1，个人确认总部下的订单为2，总部确认个人订单为3,库房备货 4 为保持订单 8
	private int deltype;//发货选择
	private String deltype2;
    public static final String TYPE_NAME[] =
            {"处理中", //0
            "等待总部确认订单", //1
            "已下单,正在备货", //2
            "已下单,正在备货", //3
            "备货完成，正在发货", //4
            "发货完成，请等待收货", //5
            "收货确认，订单完成", //6
            "加盟店已经删除的订单", //7
            "","",""};
//发货选择
	public static final String DEL_TYPE[] =
			   {"","物流","快递","大巴","自提"};
	public static final String DEL_TYPE2[] =
			   {"","物流电话","快递单号","司机电话","提货人"};
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
    
    private String  sdmember1;//库房备货人员签字
    private String  sdmember2;//库房备货人员签字
    private String  sdmember3;//库房备货人员签字
    private String  sdmember4;//库房备货人员签字


    public Paidinfull(String purchase) throws SQLException
    {
        this.purchase = purchase;
        load();
    }

    public static Paidinfull find(String purchase) throws SQLException
    {
        return new Paidinfull(purchase);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT supplname,waridname,quantityarr,totalarr,quantity,total,time_s,member,community,remarks,rsgoods,discountarr,supplyarr,total_2,dsupplyarr,type,member2," +
            		"telephone,address,remarksarr,city,shipaddress,consignee,zip, tel,stime,ftime,updatetime,deltype,deltype2,sdmember1,sdmember2,sdmember3,sdmember4 FROM Paidinfull WHERE purchase =" + db.cite(purchase));
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
				deltype=db.getInt(29);
				deltype2=db.getString(30);
				sdmember1=db.getString(31);
				sdmember2=db.getString(32);
				sdmember3=db.getString(33);
				sdmember4=db.getString(34);
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
            db.executeUpdate("INSERT INTO Paidinfull (purchase,supplname,waridname,quantityarr,totalarr,quantity,total,time_s,member,community,remarks,rsgoods,discountarr,supplyarr," +
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
            db.executeUpdate("UPDATE Paidinfull SET supplname=" + (supplname) + ",waridname=" + waridname + ",quantityarr=" + db.cite(quantityarr) + ",totalarr=" + db.cite(totalarr) + ",quantity=" + db.cite(quantity) + ",total=" + db.cite(total) + ",time_s=" + db.cite(time_s) + ",member=" + db.cite(member) + ",community=" + db.cite(community) + ",remarks=" + db.cite(remarks) + ",rsgoods=" + db.cite(rsgoods) + ",discountarr=" + db.cite(discountarr) + ",supplyarr=" + db.cite(supplyarr) + ",total_2=" + db.cite(total_2) + ",dsupplyarr=" + db.cite(dsupplyarr) + ",type=" + type + ",member2=" + db.cite(member2) + ",telephone=" + db.cite(telephone) + ",address=" + db.cite(address) + ",remarksarr=" + db.cite(remarksarr) + ",updatetime=" + db.cite(updatetime) + "  WHERE purchase = " +
                             db.cite(purchase));
        } finally
        {
            db.close();
        }
    }

    public void set(String city,String shipaddress,String consignee,String zip,String tel,Date stime,Date ftime,int deltype,String deltype2) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Paidinfull SET city=" + db.cite(city) + ",shipaddress=" + db.cite(shipaddress) + ",consignee=" + db.cite(consignee) + ",zip=" + db.cite(zip) + ",tel=" + db.cite(tel) + ",stime=" + db.cite(stime) + ",ftime=" + db.cite(ftime) + ",deltype="+deltype+",deltype2="+db.cite(deltype2)+" WHERE purchase = " + db.cite(purchase));
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
            db.executeQuery("SELECT purchase FROM Paidinfull WHERE community= " + db.cite(community) + sql,pos,size);
            while(db.next())
            {
                vector.add(db.getString(1));
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
            db.executeUpdate("DELETE FROM  Paidinfull WHERE purchase = " + db.cite(purchase));

        } finally
        {
            db.close();
        }
    }

    public void setType(int type) throws SQLException
    {
        updatetime = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Paidinfull SET type=" + type + ",updatetime=" + db.cite(updatetime) + "  WHERE purchase=" + db.cite(purchase));
        } finally
        {
            db.close();
        }
    }
    public void setSdmember(String sdmember1,String sdmember2,String sdmember3,String sdmember4) throws SQLException
    {
        
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Paidinfull SET sdmember1="+db.cite(sdmember1)+", sdmember2="+db.cite(sdmember2)+", sdmember3="+db.cite(sdmember3)+", sdmember4="+db.cite(sdmember4)+" WHERE purchase=" + db.cite(purchase));
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
            db.executeQuery("SELECT COUNT(purchase) FROM Paidinfull  WHERE community=" + db.cite(community) + sql);
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
        BigDecimal bb = BigDecimal.ZERO;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT " + attribute + " FROM Paidinfull WHERE community= " + db.cite(community) + sql,0,size);
            while(db.next())
            {
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
        float d = 0;
        Goods gobj = Goods.find(node);
        Commodity cobj = Commodity.find_goods(node);
        String gts[] = (gobj.getGoodstype() + "0/0/0/0/").split("/"); //防止没有"类别" 报错问题
        Date times = new Date();
        DbAdapter db = new DbAdapter();
		StringBuffer sp = new StringBuffer();
        if(cobj.getSupplier() > 0)
        {
            sp.append(" AND  supplier =").append(cobj.getSupplier());
        }
        if(gobj.getBrand() > 0)
        {
            sp.append(" AND brand =").append(gobj.getBrand());
        }
        if(Integer.parseInt(gts[2]) > 0)
        {
            sp.append(" AND ( goodstype= ").append(Integer.parseInt(gts[2])).append(" or goodstype=0 )");

        }
        if(Integer.parseInt(gts[3]) > 0)
        {
            sp.append(" AND ( goodstype2= ").append(Integer.parseInt(gts[3])).append(" or goodstype2=0 )");
        }


        try
        {
           // db.executeQuery("SELECT discounts FROM SupplierBrandDiscounts WHERE supplier=" + cobj.getSupplier() + " AND brand = " + gobj.getBrand() + " AND starttime<=" + db.cite(sdf.format(times)) + " AND stoptime>=" + db.cite(sdf.format(times)) + " AND( goodstype =" + gts[2] + " OR goodstype =0) AND (goodstype2=" + gts[3] + " OR goodstype2=0)");
		   if(SupplierBrandDiscounts.getNode(node)>0){
			   d = SupplierBrandDiscounts.getNode(node);
		   }else{
                   db.executeQuery("SELECT discounts FROM SupplierBrandDiscounts WHERE  starttime<=" + db.cite(sdf.format(times)) + " AND stoptime>=" + db.cite(sdf.format(times)) + sp);
                   //System.out.println("SELECT discounts FROM SupplierBrandDiscounts WHERE  starttime<=" + db.cite(sdf.format(times)) + " AND stoptime>=" + db.cite(sdf.format(times))+sp);
                   if(db.next())
                   {
                       d = db.getBigDecimal(1,2).floatValue();
                   }
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
        int d = 0;
        Goods gobj = Goods.find(node);
        Commodity cobj = Commodity.find_goods(node);
        Date times = new Date();
        String gts[] = (gobj.getGoodstype() + "0/0/0/0/").split("/"); //防止没有"类别" 报错问题
        DbAdapter db = new DbAdapter();
		StringBuffer sp = new StringBuffer();
		if(cobj.getSupplier() > 0)
		{
			sp.append(" AND  supplier =").append(cobj.getSupplier());
		}
		if(gobj.getBrand() > 0)
		{
			sp.append(" AND brand =").append(gobj.getBrand());
		}
		if(Integer.parseInt(gts[2]) > 0)
		{
			sp.append(" AND (goodstype= ").append(Integer.parseInt(gts[2])).append(" or goodstype=0) ");
		}
		if(Integer.parseInt(gts[3]) > 0)
		{
			sp.append(" AND( goodstype2= ").append(Integer.parseInt(gts[3])).append(" or goodstype2=0) ");
		}

        try
        {
          //  db.executeQuery("select floor from SupplierBrandDiscounts where supplier=" + cobj.getSupplier() + " and brand = " + gobj.getBrand() + " and starttime<=" + db.cite(sdf.format(times)) + " and  stoptime>=" + db.cite(sdf.format(times)) + "  and( goodstype =" + gts[2] + " or goodstype =0) and (goodstype2=" + gts[3] + " or goodstype2=0)");
		  if(SupplierBrandDiscounts.getNode(node)>0){
		}else
		{

            db.executeQuery("SELECT floor FROM SupplierBrandDiscounts WHERE  starttime<=" + db.cite(sdf.format(times)) + " AND stoptime>=" + db.cite(sdf.format(times)) + sp);
            if(db.next())
            {
                d = db.getInt(1);
            }
        }
        } finally
        {
            db.close();
        }
        return d;
    }

//销售统计中的出货数量
    public static int getShuLiang(String communtiy,int supplname) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int s = 0;
        try
        {
            db.executeQuery("SELECT quantity FROM Paidinfull WHERE community =" + db.cite(communtiy) + " AND supplname=" + supplname);
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
    public static java.math.BigDecimal getJinE(String communtiy,int supplname) throws SQLException
    {
        BigDecimal s = BigDecimal.ZERO;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT total_2 FROM Paidinfull WHERE community =" + db.cite(communtiy) + " AND supplname=" + supplname);
            while(db.next())
            {
				if(db.getString(1)!=null && db.getString(1).length()>0)
				{
                    s = s.add(new java.math.BigDecimal(db.getString(1)));
                } 
            }
        } finally
        {
            db.close();
        }
        return s;
    }

	//取加盟店属于那个用户
	public static String getLeagueShopId(String community,String member)throws SQLException
	{
        StringBuffer sql = new StringBuffer();
        AdminUsrRole arobj = AdminUsrRole.find(community,member);
        LeagueShop lsobj = LeagueShop.find(LeagueShop.findid(arobj.getUnit()));
        boolean f = false;
        if(lsobj.getId() != 0)
        {
            sql.append(" AND ");
            if(arobj.getDept().split("/").length - 1 >= 1) //说明有兼职部门
            {
                sql.append(" ( ");
                f = true;
            }
            sql.append(" supplname= ").append(lsobj.getId());

            if(f)
            {
                sql.append(" or ");
            }
        }
        for(int i = 1;i < arobj.getDept().split("/").length;i++)
        {
            int dept = Integer.parseInt(arobj.getDept().split("/")[i]);
            LeagueShop lsobj2 = LeagueShop.find(LeagueShop.findid(dept));
            if(lsobj2.getId() != 0)
            {

                sql.append(" supplname=").append(lsobj2.getId());
                if(arobj.getDept().split("/").length > i + 1)
                {
                    sql.append(" or supplname=").append(lsobj2.getId());
                } else
                {
                    sql.append(")");
                }
            }
        }
		return sql.toString();
	}

//获取订单中没有审核的订单的金额
    public static java.math.BigDecimal getTotalaaa(String community,int supplname) throws SQLException
    {
        BigDecimal s = BigDecimal.ZERO;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select total_2 from Paidinfull where community  ="+db.cite(community)+" and  type = 1 and supplname = "+supplname);
            while(db.next())
            {
                s = s.add(new java.math.BigDecimal(db.getString(1)));
            }
        } finally
        {
            db.close();
        }
        return s;

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

    public String getDiscountarr()
    {
        return discountarr;
    }

    public String getSupplyarr()
    {
        return supplyarr;
    }

    public String getTotal_2()
    {
        return total_2;
    }

    public String getDsupplyarr()
    {
        return dsupplyarr;
    }

    public int getType()
    {
        return type;
    }

    public String getMember2()
    {
		if(member2!=null && member2.length()>0)
		{
			return member2;
		}else
		{
		   return "";
		}

    }

    public String getTelephone()
    {
        return telephone;
    }

    public String getAddress()
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
	public int getDeltype()
	{
		return deltype;
	}
	public String getDeltype2()
	{
		return deltype2;
	}
	public String getSdmember1()
	{
		return sdmember1;
	}
	public String getSdmember2()
	{
		return sdmember2;
	}
	public String getSdmember3()
	{
		return sdmember3;
	}
	public String getSdmember4()
	{
		return sdmember4;
	}

}
