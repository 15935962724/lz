package tea.entity.westrac;

import java.sql.SQLException;
import java.util.Date;

import tea.db.DbAdapter;
import tea.entity.Entity;

public class IntegralMyScore extends Entity{

	private int imid;
	private String member;//评论用户
	private int ipid;//评论商品的名称
	private int score;//评论积分
	private String community;
	private Date times;
	private boolean exists;
	
	public static IntegralMyScore find(int imid)throws SQLException
	{
		return new IntegralMyScore(imid);
	}
	public IntegralMyScore(int imid)throws SQLException
	{
		this.imid = imid;
		load();
	}
	
	 private void load() throws SQLException
	    {
	       
	        DbAdapter db = new DbAdapter();
	        try
	        {
	            db.executeQuery("SELECT member,ipid,score,community,times  FROM IntegralMyScore where  imid=" + imid);
	            if(db.next())
	            {
	                int i = 1;
	                member=db.getString(i++);
	                ipid=db.getInt(i++);
	                score = db.getInt(i++);
	                
	                community=db.getString(i++); 
	               
	                times =db.getDate(i++);
	        
	                
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
	 
	 public static int getImid(String community, String member,int ipid)throws SQLException
	 {
		 int c = 0;
		 DbAdapter db = new DbAdapter();
		 try
		 {
			 db.executeQuery(" select imid from IntegralMyScore where community="+db.cite(community)+" and member="+db.cite(member)+" and ipid= "+ipid);
			 if(db.next())
			 {
				 c = db.getInt(1);
			 }
		 }finally
		 {
			 db.close();
		 }
		 return c;
	 }
	 
	 public static void create(String member,int ipid,int score,String community,Date times) throws SQLException
	    {
	    
	        DbAdapter db = new DbAdapter();
	        try
	        {
	           db.executeUpdate("INSERT INTO IntegralMyScore( member,ipid,score,community,times )VALUES("+db.cite(member)+" ,"+ipid+"," +
	           		"  "+score+","+db.cite(community)+", "+db.cite(times)+" ) "); 

	        } finally
	        {
	            db.close();
	        }
	       
	    }
	    
	 public  void set(int score) throws SQLException
	    {
	    
	        DbAdapter db = new DbAdapter();
	        try
	        {
	           db.executeUpdate("UPDATE  IntegralMyScore SET score ="+score+" where imid =  "+imid); 

	        } finally
	        {
	            db.close();
	        }
	       
	    }
	    
	    

	    public static int count(String community,String sql)
	    {
	        DbAdapter db = new DbAdapter();
	        int c = 0;
	        try
	        {
	            c =  db.getInt("SELECT COUNT(imid) FROM IntegralMyScore WHERE community=" + DbAdapter.cite(community) + sql);
	        } catch(SQLException ex)
	        {
	            return 0; 
	        } finally
	        {
	            db.close();
	        }
	        return c;
	    }
	    
	    public void delete (int imid)throws  SQLException
	    {
	    	 DbAdapter db = new DbAdapter();
		  
		        try
		        {
		            db.executeUpdate("DELETE FROM IntegralMyScore WHERE imid = "+imid);
		        } catch(SQLException ex)
		        {
		           
		        } finally
		        {
		            db.close();
		        }
		       
	    }
	    
	    public static String getMembericon(String community,int ipid,int count)throws SQLException
		{
			int sum = IntegralMyScore.Countsum(community, " and ipid ="+ipid+" and score !=0 ");
			 
			String sb = "0%";
			float p = (float) count / sum;
			java.text.NumberFormat nf = java.text.NumberFormat.getPercentInstance();
			nf.setMinimumFractionDigits(0); // 小数点后保留几位
			String str = nf.format(p); // 要转化的数

			if(p>0)
			{
				sb =  str ;
			} 
			return sb; 
		}
	
	    public static int Countsum(String community,String sql)
	    {
	        DbAdapter db = new DbAdapter();
	        int c = 0;
	        try
	        {
	            c =  db.getInt("SELECT COUNT(imid) FROM IntegralMyScore WHERE community=" + DbAdapter.cite(community) + sql);
	        } catch(SQLException ex)
	        {
	            return 0; 
	        } finally
	        {
	            db.close();
	        }
	        return c;
	    }
	
		public String getMember() {
			return member;
		}
		public int getIpid() {
			return ipid;
		}
		public int getScore() {
			return score;
		}
		public String getCommunity() {
			return community;
		}
		public Date getTimes() {
			return times;
		}
		public boolean isExists() {
			return exists;
		}
	 
	    
	 
	
}
