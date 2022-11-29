package tea.entity.admin;

import java.util.*;

import tea.db.DbAdapter;
import java.sql.SQLException;
import tea.entity.*;

public class XiangMuBiao extends Entity {
	
	private int id;
	private String clientname;//客户的Name
	private int clientid;//客户的ID号
	private String itemname;//项目的名字
	private int itemid;//项目的ID
	
	private boolean exists;
	
	public XiangMuBiao(int id) throws SQLException
	{
		this.id = id;
		load();
	}
	public static XiangMuBiao find(int id) throws SQLException
	{
		return new XiangMuBiao(id);
	}
	
	public void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT clientname,clientid,itemname,itemid FROM XiangMuBiao where id ="+id);
			if(db.next())
			{
				clientname= db.getVarchar(1,1,1);
				clientid = db.getInt(2);
				itemname = db.getVarchar(1,1,3);
				itemid = db.getInt(4);
				exists= true;
			}else{
				exists= false;
			}
		}catch(Exception e)
		{
			 throw new SQLException(e.toString());
		}finally
		{
			db.close();
		}
	}
	  
	public static Enumeration findBy(String sql) throws SQLException
	{
		 
	      Vector vector = new Vector();
	      DbAdapter db = new DbAdapter();
	      try
	      {
	    	  db.executeQuery("SELECT id FROM XiangMuBiao "+sql);
	    	  for(int l =0;db.next();l++)
	    	  {
	    		  vector.addElement(new Integer(db.getInt(1)));
	    	  }
	      }catch(Exception ex)
    	  {
    		  throw new SQLException(ex.toString());
    	  }finally
    	  {
    		  db.close();
    	  }
	      return vector.elements();
	}
	
	
	 public static void set(int workproject,int worklog) throws SQLException
	    {
	        DbAdapter db = new DbAdapter();
	        try
	        {
	            db.executeUpdate("UPDATE Worklog SET workproject=" + workproject + " where worklog ="+worklog);
	} finally
	        {
	            db.close();
	        }
	       
	    }
	 
	public int getClientid() {
		return clientid;
	}
	public String getClientname() {
		return clientname;
	}
	public int getItemid() {
		return itemid;
	}
	public String getItemname() {
		return itemname;
	}
	
	
	
	
}
