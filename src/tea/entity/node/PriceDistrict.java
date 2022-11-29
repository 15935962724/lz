package tea.entity.node;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class PriceDistrict extends Entity
{
	private int numbers;
	private int psid;//场次id
	private int pricesubareaid;// 价格分区对应的价格
	private String member;
	private String community;
    private boolean exist; //
    
    public PriceDistrict(int numbers,int psid) throws SQLException
    {
        this.numbers = numbers;
        this.psid = psid;
        load();
    }
  
    public static PriceDistrict find(int numbers,int psid) throws SQLException
    {
        return new PriceDistrict(numbers,psid);
    }
    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT psid,pricesubareaid,member,community FROM PriceDistrict  WHERE numbers = " + numbers + " AND psid ="+psid);
            if(db.next())
            {
            	pricesubareaid=db.getInt(2);
            	member = db.getString(3);
            	community = db.getString(4);
                exist = true;
            } else
            {
                exist = false;
            }
        } finally
        {
            db.close();
        }
    }
     
    public static void create(int numbers,int psid ,int pricesubareaid  ,String member,String community) throws SQLException
    {
 	   DbAdapter db = new DbAdapter();
 	   Date times = new Date();
 	   try
 	   {
 		   db.executeUpdate("INSERT INTO PriceDistrict(numbers,psid,pricesubareaid,member,community) VALUES("+numbers+","+psid+","+pricesubareaid+","+db.cite(member)+","+db.cite(community)+" )");
 		  // System.out.println("INSERT INTO PriceDistrict(numbers,psid,pricesubareaid,member,community) VALUES("+numbers+","+psid+","+pricesubareaid+","+db.cite(member)+","+db.cite(community)+" )");
 	   } finally
 	   {
 		   db.close();
 	   }
    }
    public void set(int pricesubareaid,String member) throws SQLException
    {
 	   DbAdapter db = new DbAdapter();
 	   try
 	   {
 		   db.executeUpdate("UPDATE PriceDistrict SET pricesubareaid="+pricesubareaid+",member="+db.cite(member)+"  WHERE numbers="+numbers+" AND psid = "+psid );
 	   } finally
 	   {
 		   db.close();
 	   }
        this.pricesubareaid=pricesubareaid;
        this.member = member;
    }
    public static Enumeration find(String community,String sql,int pos,int size)
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT numbers FROM PriceDistrict WHERE community= " + db.cite(community) + sql,pos,size);
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
            db.executeUpdate("DELETE FROM  PriceDistrict WHERE numbers = " + numbers +" AND psid = "+psid);
        } finally
        {
            db.close();
        }
    }
    public static void delete(int psid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM  PriceDistrict WHERE  psid = "+psid);
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
            db.executeQuery("SELECT COUNT(numbers) FROM PriceDistrict  WHERE community=" + db.cite(community) + sql);
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
	public int getPsid()
	{
		return psid;
	}

	public int getPricesubareaid()
	{
		return pricesubareaid;
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
