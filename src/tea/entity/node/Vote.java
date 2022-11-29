package tea.entity.node;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.Entity;

public class Vote extends Entity
{
	private int voteid;// 主键id
	private int psid;//场次id
	private String votename;//票种名称
	private int carfare1;//票价
	private int carfare2;//和票价关联的ID号
	private int carfare3;//是否打印票价
	private int carfare4;
	private int carfare5;
	private int carfare6;
	private int carfare7;
	private int carfare8;
	private int carfare9;
	private int carfare10;
	private String member;
	private String community;
	private Date times;

	private boolean exist; //

	public Vote(int voteid)throws SQLException
	{
		this.voteid = voteid;
		load();
	}

	public static Vote find(int voteid)throws SQLException
	{
		return new Vote(voteid);
	}

	public void load()throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try{
			db.executeQuery("SELECT psid,votename,carfare1,carfare2,carfare3,carfare4,carfare5,carfare6,carfare7,carfare8,carfare9,carfare10,member,community,times FROM Vote WHERE voteid="+voteid);
			if(db.next())
			{
				psid=db.getInt(1);
				votename=db.getString(2);
				carfare1=db.getInt(3);
				carfare2=db.getInt(4);
				carfare3=db.getInt(5);
				carfare4=db.getInt(6);
				carfare5=db.getInt(7);
				carfare6=db.getInt(8);
				carfare7=db.getInt(9);
				carfare8=db.getInt(10);
				carfare9=db.getInt(11);
				carfare10=db.getInt(12);
				exist=true;
			}else
			{
				exist = false;
			}
		}
		finally{
			db.close();
		}
	}

	public static int create(int  psid,String votename,int carfare1,int carfare2,int carfare3,int carfare4,int carfare5,int carfare6,int carfare7,int carfare8,int carfare9,int carfare10,
				 			 String member,String community) throws SQLException
	   {
		   DbAdapter db = new DbAdapter();
		   int id = 0;
		   Date times = new Date();
		   try
		   {
			   db.executeUpdate("INSERT INTO Vote(psid,votename,carfare1,carfare2,carfare3,carfare4,carfare5,carfare6,carfare7,carfare8,carfare9,carfare10,member,community,times) VALUES("+psid+","+db.cite(votename)+","
					   +" "+carfare1+","+carfare2+","+carfare3+","+carfare4+","+carfare5+","+carfare6+","+carfare7+","+carfare8+","+carfare9+","+carfare10+", "
					   + db.cite(member)+","+db.cite(community)+","+db.cite(times)+" )");

			 db.executeQuery("Select SCOPE_IDENTITY()  as voteid");
			 if(db.next())
			 {
			  id= db.getInt(1);
			 }
		   } finally
		   {
			   db.close();
		   }
		   return id;
	   }

	 public void set(int  psid,String votename,int carfare1,int carfare2,int carfare3,int carfare4,int carfare5,int carfare6,int carfare7,int carfare8,int carfare9,int carfare10,
			    String member) throws SQLException
	   {
		   DbAdapter db = new DbAdapter();
		   Date times = new Date();
		   try
		   {
			   db.executeUpdate("UPDATE Vote SET psid="+psid+",votename="+db.cite(votename)+",carfare1="+carfare1+",carfare2="+carfare2+",carfare3="+carfare3+",carfare4="+carfare4+","
					   +" carfare5="+carfare5+",carfare6="+carfare6+",carfare7="+carfare7+",carfare8="+carfare8+",carfare9="+carfare9+",carfare10="+carfare10+", "
								+" member="+db.cite(member)+",times="+db.cite(times)+" WHERE voteid="+voteid);
		   } finally
		   {
			   db.close();
		   }
	       this.psid = psid;
	       this.votename = votename;
	       this.carfare1 = carfare1;
	       this.carfare2 = carfare2;
	       this.carfare3 = carfare3;
	       this.carfare4 = carfare4;
	       this.carfare5 = carfare5;
	       this.carfare6 = carfare6;
	       this.carfare7 = carfare7;
	       this.carfare8 = carfare8;
	       this.carfare9 = carfare9;
	       this.carfare10 = carfare10;
	       this.member = member;
	       this.times = times;
	   }

	 public static Enumeration find(String community,String sql,int pos,int size)
	   {
	       Vector vector = new Vector();
	       DbAdapter db = new DbAdapter();
	       try
	       {
	           db.executeQuery("SELECT voteid FROM Vote WHERE community= " + db.cite(community) + sql,pos,size);
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
	           db.executeUpdate("DELETE FROM  Vote WHERE voteid = " + voteid);
	       } finally
	       {
	           db.close();
	       }
	   }
	   public static void delete(int psid)throws SQLException
	   {
		   DbAdapter db = new DbAdapter();
		   try{
			   db.executeUpdate("DELETE FROM Vote WHERE psid = "+psid);
		   }finally{
			   db.close();
		   }
	   }
	   //获取票的id号
	   public static String getVoteCarfare(int vottid)throws SQLException
	   {
		   StringBuffer s = new StringBuffer("/");
		   DbAdapter db = new DbAdapter();
		   try{
			   db.executeQuery("SELECT ckcarfare FROM VoteCarfare WHERE vottid = "+vottid);
			   while(db.next())
			   {
				   s = s.append(db.getInt(1)).append("/");
			   }
		   }finally{
			   db.close();
		   }
		   return s.toString();
	   }

	   //获取票的价格id
	   public static String getCarfare(int vottid)throws SQLException
	   {
		   StringBuffer s = new StringBuffer("/");
		   DbAdapter db = new DbAdapter();
		   try{
			   db.executeQuery("SELECT carfare FROM VoteCarfare WHERE vottid = "+vottid);
			   while(db.next())
			   {
				   s = s.append(db.getInt(1)).append("/");
			   }
		   }finally{
			   db.close();
		   }
		   return s.toString();
	   }
	   //通过票种id 和标准票的票价 得出价格
	   public static java.math.BigDecimal getVotePrice(int voteid,int prsubid)throws SQLException
	   {
		   DbAdapter db = new DbAdapter();
		   java.math.BigDecimal bp = new java.math.BigDecimal("0");
		   try{
			   db.executeQuery("select carfare from VoteCarfare where vottid ="+voteid+" and ckcarfare="+prsubid);
			   if(db.next())
			   {
				   bp = new java.math.BigDecimal(db.getInt(1));
			   }
		   }finally
		   {
			   db.close();
		   }
		   return bp.setScale(0,java.math.BigDecimal.ROUND_HALF_UP);
	   }

	public int getPsid()
	{
		return psid;
	}

	public String getVotename()
	{
		return votename;
	}

	public int getCarfare1()
	{
		return carfare1;
	}

	public int getCarfare2()
	{
		return carfare2;
	}

	public int getCarfare3()
	{
		return carfare3;
	}

	public int getCarfare4()
	{
		return carfare4;
	}

	public int getCarfare5()
	{
		return carfare5;
	}

	public int getCarfare6()
	{
		return carfare6;
	}

	public int getCarfare7()
	{
		return carfare7;
	}

	public int getCarfare8()
	{
		return carfare8;
	}

	public int getCarfare9()
	{
		return carfare9;
	}

	public int getCarfare10()
	{
		return carfare10;
	}

	public String getMember()
	{
		return member;
	}

	public String getCommunity()
	{
		return community;
	}

	public Date getTimes()
	{
		return times;
	}

	public boolean isExist()
	{
		return exist;
	}





}
