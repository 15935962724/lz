package tea.entity.westrac;

import java.sql.SQLException;
import java.util.Date;
import java.util.Enumeration;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.Entity;

public class EventaccoMember extends Entity{
	
	private int emid;
	private String acconame;
	private int sex;//0男，1女
	private int accorel;//关系
	private String cadr;//身份证号
	private int eregid;//报名活动的id
	private int node;//活动ID
	private boolean exists;
	
	
	public static EventaccoMember find(int emid)throws SQLException
	{
		return new EventaccoMember(emid);
	}
	public EventaccoMember(int emid)throws SQLException
	{
		this.emid = emid;
		load();
	}
	
	 private void load() throws SQLException
	    {
	       
	        DbAdapter db = new DbAdapter();
	        try
	        {
	            db.executeQuery("SELECT acconame,sex,accorel,cadr,eregid,node FROM EventaccoMember WHERE emid=" + emid);
	            if(db.next())
	            {
	                int i = 1;
	                acconame=db.getString(i++);
	                sex = db.getInt(i++);
	                accorel=db.getInt(i++);
	                cadr=db.getString(i++);
	                eregid=db.getInt(i++);
	                node=db.getInt(i++);
	     
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
	 
	 public static int create(String acconame,int sex,int accorel,String cadr,int eregid,int node) throws SQLException
	    {
	    	int c = 0;
	        DbAdapter db = new DbAdapter();
	        try
	        {
	           db.executeUpdate("INSERT INTO EventaccoMember(acconame,sex,accorel,cadr,eregid,node)VALUES("+db.cite(acconame)+","+sex+"," +
	           		""+accorel+" ,"+db.cite(cadr)+","+eregid+","+node+" ) "); 
	           
	        
	           
	        } finally
	        {
	            db.close();
	        }
	        return c;
	    }
	    
	    
	    public void set(String acconame,int sex,int accorel,String cadr,int eregid ) throws SQLException
	    {
	        DbAdapter db = new DbAdapter();
	        try
	        {
	        	StringBuffer sp = new StringBuffer();
	        	sp.append("UPDATE EventaccoMember SET ");
	        	sp.append("acconame=").append(db.cite(acconame)).append(",");
	        	
	        	sp.append("sex=").append(sex).append(",");
	        	sp.append("accorel=").append(accorel).append(",");
	        	sp.append("cadr=").append(DbAdapter.cite(cadr)).append(",");
	        	
	        	sp.append("eregid=").append(eregid);
	        
	        	sp.append(" WHERE emid=" + emid);
	        	
	        	
	        	
	            db.executeUpdate(sp.toString() );
	        } finally
	        {
	            db.close();
	        }
	        
	    }
	    
	    
	    public static Enumeration find(String sql,int pos,int pagesize) throws SQLException
	    {
	        Vector v = new Vector();
	        DbAdapter db = new DbAdapter();
	        try
	        {
	            db.executeQuery("SELECT emid FROM EventaccoMember WHERE 1=1 " + sql,pos,pagesize);
	            while(db.next())
	            {
	                v.add(new Integer(db.getInt(1)));
	            } 
	        } finally
	        {
	            db.close();
	        }
	        return v.elements();
	    }
	    
	    public static int Count(String sql)
	    {
	        DbAdapter db = new DbAdapter();
	        int c = 0;
	        try
	        {
	            c =  db.getInt("SELECT COUNT(emid) FROM EventaccoMember WHERE 1=1 " + sql);
	        } catch(SQLException ex)
	        {
	            return 0; 
	        } finally
	        {
	            db.close();
	        }
	        return c;
	    }
	    
	    public static void delete (int eregid)throws  SQLException
	    {
	    	 DbAdapter db = new DbAdapter();
		  
		        try
		        {
		            db.executeUpdate("DELETE FROM EventaccoMember WHERE eregid = "+eregid);
		        } catch(SQLException ex)
		        {
		           
		        } finally
		        {
		            db.close();
		        }
		       
	    }
	    public  void delete ()throws  SQLException
	    {
	    	 DbAdapter db = new DbAdapter();
		  
		        try
		        {
		            db.executeUpdate("DELETE FROM EventaccoMember WHERE emid = "+emid);
		        } catch(SQLException ex)
		        {
		           
		        } finally
		        {
		            db.close();
		        }
		       
	    }
		public String getAcconame() {
			return acconame;
		}
		public int getSex() {
			return sex;
		}
		public int getAccorel() {
			return accorel;
		}
		public String getCadr() {
			return cadr;
		}
		public int getEregid() {
			return eregid;
		}
		public boolean isExists() {
			return exists;
		}
		public int getNode()
		{
			return node;
		}
	    

}
