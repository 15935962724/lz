package tea.entity.node;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import tea.entity.node.*;
import java.math.BigDecimal;

public class PriceSubarea extends Entity
{
	private int prsubid;
	private int psid;//场次设置ID
	private String subareaname;//区域名称
	private BigDecimal price;//价格
	private String picturename;//示意图名称
	private int picturepath;//示意图id
	private String member;
	private String community;
	private boolean exist;

	public PriceSubarea(int prsubid)throws SQLException
	{
		this.prsubid = prsubid;
		 load();
	}
	public static PriceSubarea find(int prsubid)throws SQLException
	{
		return new PriceSubarea(prsubid);
	}

	public void load()throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT psid,subareaname,price,picturename,picturepath,member,community FROM PriceSubarea WHERE prsubid ="+prsubid);
			if(db.next())
			{
				psid = db.getInt(1);
				subareaname=db.getString(2);
				price=db.getBigDecimal(3,2);
				picturename=db.getString(4);
				picturepath=db.getInt(5);
				member=db.getString(6);
				community=db.getString(7);
				exist=true;
			}else {
				exist = false;
			}
		}finally
		{
			db.close();
		}
	}
	public static void create(int psid,String subareaname,BigDecimal price,String picturename,int picturepath ,String member, String community) throws SQLException
	   {
		   DbAdapter db = new DbAdapter();
		   try
		   {
			   db.executeUpdate("INSERT INTO PriceSubarea( psid,subareaname,price,picturename,picturepath,member,community) VALUES("+psid+","+db.cite(subareaname)+","
					   +" "+price+","+db.cite(picturename)+","+(picturepath)+","+db.cite(member)+","
					   + db.cite(community)+"  )");

		   } finally
		   {
			   db.close();
		   }

	   }
	 public void set(int psid,String subareaname,BigDecimal price,String picturename,int picturepath ,String member) throws SQLException
	   {
		   DbAdapter db = new DbAdapter();
		   try
		   {
			   db.executeUpdate("UPDATE PriceSubarea SET psid="+psid+",subareaname="+db.cite(subareaname)+",price="+price+",picturename="+db.cite(picturename)+",picturepath="+(picturepath)+","
								+" member="+db.cite(member)+" WHERE prsubid="+prsubid);
		   } finally
		   {
			   db.close();
		   }
	       this.psid = psid;
	       this.subareaname = subareaname;
	       this.price = price;
	       this.picturename = picturename;
	       this.picturepath = picturepath;
	       this.member = member;
	   }

	  public static Enumeration find(String community,String sql,int pos,int size)
	   {
	       Vector vector = new Vector();
	       DbAdapter db = new DbAdapter();
	       try
	       {
	           db.executeQuery("SELECT prsubid FROM PriceSubarea WHERE community= " + db.cite(community) + sql,pos,size);
	           while(db.next())
	           {
	               vector.add(new Integer(db.getInt(1)));
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
	           db.executeUpdate("DELETE FROM  PriceSubarea WHERE prsubid = " + prsubid);
	       } finally
	       {
	           db.close();
	       }
	   }
	  public static void delete(int psid)throws SQLException
	  {
		  DbAdapter db = new DbAdapter();
	       try
	       {
	           db.executeUpdate("DELETE FROM  PriceSubarea WHERE psid = " + psid);
	       } finally
	       {
	           db.close();
	       }
	  }
	  //显示票价
	  public static String getPriceSubareaPrice(int psid,String community)throws SQLException
	  {
		  StringBuffer sp = new StringBuffer();
		  DbAdapter db = new DbAdapter();
		  try{
			  db.executeQuery("SELECT price FROM PriceSubarea WHERE psid="+psid+" AND community = "+db.cite(community));
			  while(db.next())
			  {

				  sp.append(db.getBigDecimal(1,2));
				  sp.append("&nbsp;&nbsp;");
			  }
		  }finally
		  {
			  db.close();

		  }
		  return sp.toString();
	  }
	  //计算票价的id字符串
	  public static String getPsPrsubid(int psid,String community)throws SQLException
	  {
		  StringBuffer sp = new StringBuffer("/");
		  DbAdapter db = new DbAdapter();
		  try{
			  db.executeQuery("SELECT prsubid FROM PriceSubarea WHERE psid="+psid+" AND community = "+db.cite(community));
			  while(db.next())
			  {

				  sp.append(String.valueOf(db.getInt(1))).append("/");
			  }
		  }finally
		  {
			  db.close();

		  }
		  return sp.toString();
	  }
	  //计算票价
	  public static String getPsPrice(int psid,String community)throws SQLException
	  {
		  StringBuffer sp = new StringBuffer("/");
		  DbAdapter db = new DbAdapter();
		  try{
			  db.executeQuery("SELECT price FROM PriceSubarea WHERE psid="+psid+" AND community = "+db.cite(community));
			  while(db.next())
			  {

				  sp.append(String.valueOf(db.getBigDecimal(1,2))).append("/");
			  }
		  }finally
		  {
			  db.close();

		  }
		  return sp.toString();
	  }

      public static int count(String community,String sql) throws SQLException
      {
          int i = 0;
          DbAdapter db = new DbAdapter();
          try
          {
              i = db.getInt("SELECT COUNT(*) FROM PriceSubarea WHERE community = "+db.cite(community) + sql);
          } finally
          {
              db.close();
          }
          return i;
      }


	public int getPsid()
	{
		return psid;
	}
	public String getSubareaname()
	{
		return subareaname;
	}
	public BigDecimal getPrice()
	{
		return price;
	}
	public String getPicturename()
	{
		return picturename;
	}
	public int getPicturepath()
	{
		return picturepath;
	}
	public String getMember()
	{
		return member;
	}
	public String getCommunity()
	{
		return community;
	}
	public boolean isExist()
	{
		return exist;
	}

}
