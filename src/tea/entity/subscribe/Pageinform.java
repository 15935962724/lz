package tea.entity.subscribe;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.*;

import tea.db.DbAdapter;
public class Pageinform {
	
	private int pfid;
	private int pagenumber; //版次信息编号
	private String pagename; //服务器路径
	private int node;
	private String community;
	private boolean exists;
	
	public Pageinform(int pfid)throws SQLException
	{
		this.pfid = pfid;
		load();
	}
	public static Pageinform find(int pfid) throws SQLException
	{
		return new Pageinform(pfid);
	}

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT pagenumber,pagename,node,community FROM Pageinform WHERE pfid= " + pfid);
            if(db.next())
            {
            	pagenumber = db.getInt(1);
            	pagename = db.getString(2);
                node = db.getInt(3);
                community = db.getString(4);
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
    public static int create(int pagenumber,String pagename,int node,String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int i = 0;
        try
        {
            db.executeUpdate("INSERT INTO Pageinform (pagenumber,pagename,node,community) " +
                             " VALUES (" + pagenumber + "," + db.cite(pagename) + "," + node + "," + db.cite(community) + ")");
            i = db.getInt("SELECT MAX(pfid) FROM Pageinform");
        } finally
        {
            db.close();
        }
        return i;
    }

    public void set(int pagenumber,String pagename) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Pageinform SET pagenumber =" +pagenumber + ",pagename=" + db.cite(pagename) + "  WHERE pfid=" + pfid);
        } finally
        {
            db.close();
        }
    }

    public static int getPfid(int node ,String community)throws SQLException
    {
    	int pfid = 0;
    	  DbAdapter db = new DbAdapter();
          try
          {
              db.executeQuery("SELECT pfid FROM Pageinform WHERE community ="+db.cite(community)+" and node= "+node);
              if(db.next())
              {
            	  pfid = db.getInt(1);
              }
          } finally
          {
              db.close();
          }
          return pfid;
    }
    
	public static Enumeration find(String community,String sql,int pos,int size)
   {
	   Vector vector = new Vector();
	   DbAdapter db = new DbAdapter();
	   try
	   {
		   db.executeQuery("SELECT pfid FROM Pageinform WHERE community= " + db.cite(community) + sql,pos,size);
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
           db.executeUpdate("DELETE FROM  Pageinform WHERE pfid = " + pfid);

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
           db.executeQuery("SELECT COUNT(pfid) FROM Pageinform  WHERE community=" + db.cite(community) + sql);
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
	public int getPagenumber() {
		return pagenumber;
	}
	public String getPagename() {
		return pagename;
	}
	public int getNode() {
		return node;
	}
	public String getCommunity() {
		return community;
	}
	public boolean isExists() {
		return exists;
	}
   
}
