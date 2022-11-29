package tea.entity.admin;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class SalesRecord extends Entity
{
   private int srid;
   private int goods;
   private int workproject;//
   private Date buytime;//
   private int squantity;
   private String member;//经
   private String community;//
    private Date times;//

   private boolean exists;

   public SalesRecord(int  srid) throws SQLException
   {
	   this.srid = srid;
	   load();
   }

   public static SalesRecord find(int srid) throws SQLException
   {
	   return new SalesRecord(srid);
   }

   public void load() throws SQLException
   {
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeQuery("SELECT goods,workproject,buytime,squantity,community,member,times FROM SalesRecord WHERE srid = " + srid);
           if(db.next())
           {
               goods = db.getInt(1);
               workproject = db.getInt(2);
               buytime = db.getDate(3); //
               squantity = db.getInt(4);
               member = db.getString(5); //经
               community = db.getString(6); //
               times = db.getDate(7); //
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

   public static void create(int goods,int workproject,Date buytime,int squantity,String community,String member) throws SQLException
   {
	   DbAdapter db = new DbAdapter();
	   Date times = new Date();
	   try
	   {
		   db.executeUpdate("INSERT INTO SalesRecord (goods,workproject,buytime,squantity,community,member,times ) VALUES (" + goods + "," +workproject + "," + db.cite(buytime) + "," + squantity + "," + db.cite(community) + "," + db.cite(member) + "," + db.cite(times) + ")");
	   } finally
	   {
		   db.close();
	   }
   }

   public void set(int goods,int workproject,Date buytime,int squantity) throws SQLException
   {
	   DbAdapter db = new DbAdapter();
	   Date times = new Date();
	   try
	   {
		   db.executeUpdate("UPDATE SalesRecord SET goods="+(goods)+",workproject="+workproject+",buytime="+db.cite(buytime)+",squantity="+squantity+"  WHERE srid = " + srid);
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
		   db.executeQuery("SELECT srid FROM SalesRecord WHERE community= " + db.cite(community) + sql);
		   for(int i = 0;db.next() && i < pos + size;i++)
		   {
			   if(i >= pos)
			   {
				   vector.add(db.getInt(1));
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
			db.executeUpdate("DELETE FROM  SalesRecord WHERE srid = " +srid);
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
			db.executeQuery("SELECT COUNT(srid) FROM SalesRecord  WHERE community=" + db.cite(community) + sql);
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

    public Date getBuytime()
    {
        return buytime;
    }
	public String getBuytimeToString()
	{
		if(buytime == null)
			return "";
		return sdf.format(buytime);
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

    public String getMember()
    {
        return member;
    }

    public int getSquantity()
    {
        return squantity;
    }

    public Date getTimes()
    {
		return times;
    }
	public String getTimesToString()
	{

		if(times == null)
			return "";
		return sdf.format(times);

	}

    public int getWorkproject()
    {
        return workproject;
    }

}
