package tea.entity.admin.erp;

import java.math.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class Distribution extends Entity
{
    private String dibid;
    private int lsid; //加盟店ID
    private int warid; //仓库ID
    private Date time_s; //配送日期
    private String member; //经办人
    private String member2; //联系人
    private String telephone; //联系电话
    private String address; //联系地址
    private String remarks; //备注
    private String community; //社区
    private int quantity; //总数量
    private java.math.BigDecimal total; //总金额
    private int type; // 1 等待审核的，2 审核通过的 ,3库房备货成功，4
	//收货
	private String city;//省州
	private String address2;//收货地址
	private String consignee;//收货人
	private String zip;//邮编
	private String telephone2;//收货联系电话
	private Date stime;//发货时间
	private Date ftime;//到达时间


    private boolean exists;

	public Distribution(String dibid)throws SQLException
	{
		this.dibid = dibid;
		load();
	}
	public static Distribution find(String dibid)throws SQLException
	{
		return  new Distribution(dibid);
	}

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
			db.executeQuery(" SELECT lsid,warid,time_s,member,member2,telephone,address,remarks,community,quantity,total,type,city,address2,consignee,zip,telephone2,stime,ftime FROM Distribution  WHERE dibid =" + db.cite(dibid));
            if(db.next())
            {
                lsid = db.getInt(1);
                warid = db.getInt(2);
                time_s = db.getDate(3);
                member = db.getString(4);
                member2 = db.getString(5);
                telephone = db.getString(6);
                address = db.getString(7);
                remarks = db.getString(8);
                community = db.getString(9);
				quantity=db.getInt(10);
				total=db.getBigDecimal(11,2);
				type=db.getInt(12);
				city=db.getString(13);
				address2=db.getString(14);
				consignee=db.getString(15);
				zip=db.getString(16);
				telephone2=db.getString(17);
				stime=db.getDate(18);
				ftime=db.getDate(19);
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

	public static void create(String dibid,int lsid,int warid,Date time_s,String member,String member2,String telephone,String address,String remarks,String community,int quantity,java.math.BigDecimal total,int type) throws SQLException
   {
	   DbAdapter db = new DbAdapter();
	   try
	   {
		   db.executeUpdate("INSERT INTO Distribution (dibid,lsid,warid,time_s,member,member2,telephone,address,remarks," +
							" community,quantity,total,type) VALUES ("+db.cite(dibid)+"," +lsid + "," + warid + "," +db.cite(time_s)+ "," + db.cite(member) + "," + db.cite(member2) + "," + db.cite(telephone) + "," + db.cite(address) + "," + db.cite(remarks) + "," + db.cite(community) + ","+quantity+","+total+","+type+"  )");
	   } finally
	   {
		   db.close();
	   }
   }

   public void set(int lsid,int warid,Date time_s,String member,String member2,String telephone,String address,String remarks,String community,int quantity,java.math.BigDecimal total,int type) throws SQLException
   {
	   DbAdapter db = new DbAdapter();
	   try
	   {
		   db.executeUpdate("UPDATE Distribution SET lsid=" +lsid+ ",warid=" + warid + ",time_s=" + db.cite(time_s) + ",member=" + db.cite(member) + ",member2=" + db.cite(member2) + ",telephone=" + db.cite(telephone) + ",address=" + db.cite(address) + ",remarks=" + db.cite(remarks) + ",community=" + db.cite(community) + ",quantity="+quantity+",total ="+total+",type="+type+" WHERE dibid = " +
							db.cite(dibid));
	   } finally
	   {
		   db.close();
	   }
   }
   //添加收货地址
   public void set(String city,String address2,String consignee,String zip,String telephone2,Date stime,Date ftime)throws SQLException
   {
	   DbAdapter db = new DbAdapter();
	  try
	  {
		  db.executeUpdate("UPDATE Distribution SET city="+db.cite(city)+",address2="+db.cite(address2)+",consignee="+db.cite(consignee)+",zip="+db.cite(zip)+",telephone2="+db.cite(telephone2)+",stime="+db.cite(stime)+",ftime="+db.cite(ftime)+"  WHERE dibid = " +
						   db.cite(dibid));
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
           db.executeQuery("SELECT dibid FROM Distribution WHERE community= " + db.cite(community) + sql,pos,size);
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
           db.executeUpdate("DELETE FROM  Distribution WHERE dibid = " + db.cite(dibid));

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
		   db.executeQuery("SELECT COUNT(dibid) FROM Distribution  WHERE community=" + db.cite(community) + sql);
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
            db.executeUpdate("UPDATE Distribution SET type =" + type + " WHERE dibid = " + db.cite(dibid));
        } finally
        {
            db.close();
        }

    }

    public String getAddress()
    {
        return address;
    }

    public String getCommunity()
    {
        return community;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getLsid()
    {
        return lsid;
    }

    public String getMember()
    {
        return member;
    }

    public String getMember2()
    {
        return member2;
    }

    public String getRemarks()
    {
        return remarks;
    }

    public String getTelephone()
    {
        return telephone;
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
    public int getWarid()
    {
        return warid;
    }
    public int getQuantity()
    {
        return quantity;
    }

    public BigDecimal getTotal()
    {
        return total;
    }
	public int getType()
	{
		return type;
	}

    public String getAddress2()
    {
        return address2;
    }

    public String getCity()
    {
        return city;
    }

    public String getConsignee()
    {
        return consignee;
    }

    public Date getFtime()
    {
        return ftime;
    }

    public String getFtimeToString()
    {
        if(ftime == null)
            return "";
        return sdf.format(ftime);
    }

    public Date getStime()
    {
        return stime;
    }

    public String getStimeToString()
    {
        if(stime == null)
            return "";
        return sdf.format(stime);
    }
    public String getTelephone2()
    {
        return telephone2;
    }

    public String getZip()
    {
        return zip;
    }


}
