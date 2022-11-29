package tea.entity.westrac;

import java.sql.SQLException;
import java.util.Date;

import tea.db.DbAdapter;
import tea.entity.Entity;

public class WestracIntegralLog  extends Entity{
	
	
	private int wlogid;//主键ID
	private String member;//会员idd
	private int wlogtype;//积分类型
	private String wname;//积分的标题
	private int node;//有标题的的 id号
	
	private float integral;//所获积分
	private String remarks;//积分说明
	private Date times;//积分时间
	private float cutintegral;//扣分的 积分
	 
	private String community;
	private boolean exists;
	
	public static final String WLOG_TYPE [] ={"活动到会","活动没有到会","注册","邀请注册","线索真实","形成商机","调查积分","活动报名审核通过","活动报名审核取消",
		"审核手动加分","审核手动减分","商品兑换减分","线索更改减分","商机更改减分","工分奖励积分","生日加分"};
	
	public static WestracIntegralLog find(int wlogid)throws SQLException
	{
		return new WestracIntegralLog(wlogid);
	}
	public WestracIntegralLog(int wlogid)throws SQLException
	{
		this.wlogid = wlogid;
		load();
	}
	
	 private void load() throws SQLException
	    {
	       
	        DbAdapter db = new DbAdapter();
	        try
	        {
	            db.executeQuery("SELECT member,wlogtype,wname,node,integral,remarks,times,cutintegral,community FROM WestracIntegralLog WHERE wlogid=" + wlogid);
	            if(db.next())
	            {
	                int i = 1;
	                member=db.getString(i++);
	                wlogtype=db.getInt(i++);
	                wname = db.getString(i++);
	                node =db.getInt(i++);
	                integral=db.getFloat(i++);
	                remarks=db.getString(i++);
	                times =db.getDate(i++);
	                cutintegral=db.getFloat(i++);
	                community=db.getString(i++); 
	                
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
	 
	 
	  public static void create(String member,int wlogtype,String wname,int node,float integral,String remarks,Date times,float cutintegral,String community) throws SQLException
	    {
	    
	        DbAdapter db = new DbAdapter();
	        try
	        {
	           db.executeUpdate("INSERT INTO WestracIntegralLog(member,wlogtype,wname,node,integral,remarks,times,cutintegral,community)VALUES("+db.cite(member)+" ,"+wlogtype+"," +
	           		"  "+db.cite(wname)+","+node+","+integral+","+db.cite(remarks)+", "+db.cite(times)+","+cutintegral+","+db.cite(community)+" ) "); 

	        } finally
	        {
	            db.close();
	        }
	       
	    }
	    
	    

	    public static int Count(String community,String sql)
	    {
	        DbAdapter db = new DbAdapter();
	        int c = 0;
	        try
	        {
	            c =  db.getInt("SELECT COUNT(wlogid) FROM WestracIntegralLog WHERE community=" + DbAdapter.cite(community) + sql);
	        } catch(SQLException ex)
	        {
	            return 0; 
	        } finally
	        {
	            db.close();
	        }
	        return c;
	    }

	    public static float count_integral(String community,String sql)
	    {
	        DbAdapter db = new DbAdapter();
	        float c = 0;
	        try
	        {
	           db.executeQuery("SELECT integral FROM WestracIntegralLog WHERE community=" + DbAdapter.cite(community) + sql);
	           if(db.next())
	           {
	        	   c = db.getFloat(1);
	           }
	        } catch(SQLException ex)
	        {
	            return 0; 
	        } finally
	        {
	            db.close();
	        }
	        return c;
	    }
	    public static float count_cutintegral(String community,String sql)
	    {
	        DbAdapter db = new DbAdapter();
	        float c = 0;
	        try
	        {
	           db.executeQuery("SELECT cutintegral FROM WestracIntegralLog WHERE community=" + DbAdapter.cite(community) + sql);
	           if(db.next())
	           {
	        	   c = db.getFloat(1);
	           }
	        } catch(SQLException ex)
	        {
	            return 0; 
	        } finally
	        {
	            db.close();
	        }
	        return c;
	    }
	    
	    
	    
	    
	    public void delete (int erid)throws  SQLException
	    {
	    	 DbAdapter db = new DbAdapter();
		  
		        try
		        {
		            db.executeUpdate("DELETE FROM WestracIntegralLog WHERE wlogid = "+wlogid);
		        } catch(SQLException ex)
		        {
		           
		        } finally
		        {
		            db.close();
		        }
		       
	    }
	    public static void delete (String member)throws SQLException
	    {
	    	DbAdapter db = new DbAdapter();
			  
	        try
	        {
	            db.executeUpdate("DELETE FROM WestracIntegralLog WHERE member = "+db.cite(member));
	        } catch(SQLException ex)
	        {
	           
	        } finally
	        {
	            db.close();
	        }
	    }
	    
	    public static java.util.Enumeration find(String community, String sql, int pos, int pageSize) throws SQLException
	    {
	        java.util.Vector vector = new java.util.Vector();
	        DbAdapter db = new DbAdapter();
	        try
	        {
	            db.executeQuery("SELECT wlogid FROM WestracIntegralLog WHERE community=" + DbAdapter.cite(community) + sql,pos,pageSize);

	            while (db.next())
	            {
	               
	                    vector.addElement(String.valueOf(db.getInt(1)));
	            
	            }
	        } finally
	        {
	            db.close();
	        }
	        return vector.elements();
	    }
	    //获取时间
	    public static  Date getTime_asc(String member,String community)throws SQLException
	    {
	    	Date time = null;
	    	DbAdapter db = new DbAdapter();
	    	try
	    	{
	    		db.executeQuery("select times from WestracIntegralLog where member="+db.cite(member)+" and community="+db.cite(community)+" order by times asc  ");
	    		if(db.next())
	    		{
	    			time = db.getDate(1);
	    		}
	    	}finally
	    	{
	    		db.close();
	    	}
	    	return time;
	    }
	    
		public String getMember() {
			return member;
		}
		public int getWlogtype() {
			return wlogtype;
		}
		public String getWname() {
			return wname;
		}
		public int getNode() {
			return node;
		}
		public float getIntegral() {
			return integral;
		}
		public String getRemarks() {
			return remarks;
		}
		public Date getTimes() {
			return times;
		}
		public float getCutintegral() {
			return cutintegral;
		}
		public String getCommunity() {
			return community;
		}
		public boolean isExists() {
			return exists;
		}
	    
	    
	

}
