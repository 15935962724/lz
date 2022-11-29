package tea.entity.node;


import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;


public class Seat extends Entity
{
	private static Cache _cache = new Cache(100);
    private Hashtable _htLayer;

    private int node;
    private int linage; //总排数
    private int row2; //总列数
    private String community; //
    private String member;
    private Date times;
    private boolean exists;

	public static Seat find(int node) throws SQLException
   {
	   Seat obj = (Seat) _cache.get(new Integer(node));
	   if(obj == null)
	   {
		   obj = new Seat(node);
		   _cache.put(new Integer(node),obj);
	   }
	   return obj;
   }

   public Seat(int node) throws SQLException
   {
	   this.node = node;
	   _htLayer = new Hashtable();
	   load();
   }

   private void load() throws SQLException
   {
       DbAdapter db = new DbAdapter(0);
       try
       {
           db.executeQuery("SELECT linage,row2,community,member,times FROM Seat  WHERE node=" + node);
           if(db.next())
           {
               linage = db.getInt(1);
               row2 = db.getInt(2);
               community = db.getString(3);
               member = db.getString(4);
               times = db.getDate(5);
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

   public static void create(int node,int linage,int row2,String community,String member) throws SQLException
   {
	   DbAdapter db = new DbAdapter();
	   Date times = new Date();
	   try
	   {
		   db.executeUpdate("INSERT INTO Seat(node,linage,row2,community,member,"
							+ " times )VALUES(" + node + "," + linage + "," + row2 + "," + db.cite(community) + "," + db.cite(member) + "," + db.cite(times) + " )");
	   } finally
	   {
		   db.close();
	   }
	   _cache.remove(new Integer(node));
   }

   public void set(int linage,int row2) throws SQLException
   {
	   DbAdapter db = new DbAdapter();
	   try
	   {

		   db.executeUpdate("UPDATE Seat SET linage="+linage+",row2="+row2+" WHERE node = " + node);

	   } finally
	   {
		   db.close();
	   }
	   this.linage=linage;
	   this.row2=row2;
	   _htLayer.clear();
   }

   public static Enumeration find(String community,String sql,int pos,int size)
   {
	   Vector vector = new Vector();
	   DbAdapter db = new DbAdapter();
	   try
	   {
		   db.executeQuery("SELECT node FROM Seat WHERE community= " + db.cite(community) + sql,pos,size);
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
		   db.executeUpdate("DELETE FROM  Seat WHERE node = " + node);

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

    public int getLinage()
    {
        return linage;
    }

    public String getMember()
    {
        return member;
    }

    public int getRow()
    {
        return row2;
    }

    public Date getTimes()
    {
        return times;
    }
	public String getTimeToString()
	{
		if(times == null)
			return "";
		return sdf.format(times);
	}


}
