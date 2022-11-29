package tea.entity.westrac;

import java.sql.SQLException;
import java.util.Date;

import tea.db.DbAdapter;
import tea.entity.Entity;

public class WestracClue extends Entity{

	private int wcid;
	private String wcname;//姓名
	private String mobile;//个人手机号
	
	//提供公司的信息
	private int industrys;//所属行业
	private String clientname;//客户姓名
	private String contactname;//联系人姓名
	private String phone;//公司电话
	private String clientmobile;//公司手机号
	private String city;//公司地区
	private Date buytime;//购买预计日期
	private String remarks;//购买描述
	private Date times;//添加日期
	private String community;
	private String member;//添加用户，如果是非用户，则为null
	private int exporttype;// 0 否，1 是  是否有导出
	private int wctype;//状态  0 审核中，1 线索是否真实 是，2 否
	private int wctype2;//商机状态 ，0未判断商机","1形成商机","2未形成商机 
	private String wcmember;//处理用户是否线索
	

	
	private boolean exists;   
	
	public static final String INDUSTRYS_TYPE[]={"所属行业","港口","农业","工程建设","筑路和压实","工业","林业","采矿业","采石和水泥","废物处理","租赁及设备服务","OEM厂商","海运业（船用）","海上石油行业",
		                                  "天然气行业","EPG和发电机组","卡车","铁路","油田","混凝土行业"};
	 public static final String WCTYPE_TYPE[]={"线索审核中","真实线索","无效线索"};	
	 public static final String WCTYPE_TYPE2[]={"未判断商机","新商机","旧商机"};
	public static WestracClue find(int wcid)throws SQLException
	{
		return new WestracClue(wcid);
	}
	public WestracClue(int wcid)throws SQLException
	{
		this.wcid = wcid;
		load();
	}
	
	 private void load() throws SQLException
	    {
	       
	        DbAdapter db = new DbAdapter();
	        try
	        {
	            db.executeQuery("SELECT wcname,mobile,industrys,clientname,contactname,phone,clientmobile,city,buytime,remarks,times,community,member,exporttype,wctype,wcmember,wctype2 FROM WestracClue WHERE wcid=" + wcid);
	            if(db.next())
	            {
	                int i = 1;
	                
	            	wcname=db.getString(i++);//个人信息
	            	mobile=db.getString(i++);//个人手机号
	            	
	            	//提供公司的信息
	            	industrys=db.getInt(i++);//所属行业
	            	clientname=db.getString(i++);//客户姓名
	            	contactname=db.getString(i++);//联系人姓名
	            	phone=db.getString(i++);//公司电话
	            	clientmobile=db.getString(i++);//公司手机号
	            	city=db.getString(i++);//公司地区
	            	buytime=db.getDate(i++);//购买预计日期
	            	remarks=db.getString(i++);//购买描述
	            	times=db.getDate(i++);//添加日期
	            	community=db.getString(i++);
	            	member=db.getString(i++);//添加用户，如果是非用户，则为null
	            	exporttype=db.getInt(i++);// 0 否，1 是
	            	wctype=db.getInt(i++);
	            	wcmember=db.getString(i++);
	            	wctype2=db.getInt(i++);
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
	 
	 
	 public static int create(String wcname,String mobile,int industrys,String clientname,String contactname,String phone,String clientmobile,String city,Date buytime,String remarks,
			 Date times,String community,String member,int exporttype) throws SQLException
	    {
	    
		 	int c = 0;
	        DbAdapter db = new DbAdapter();
	        try
	        {
	           db.executeUpdate("INSERT INTO WestracClue(wcname,mobile,industrys,clientname,contactname,phone,clientmobile,city,buytime,remarks,times,community,member,exporttype)" +
	           		" VALUES("+db.cite(wcname)+" ,"+db.cite(mobile)+","+industrys+","+db.cite(clientname)+","+db.cite(contactname)+","+db.cite(phone)+","+db.cite(clientmobile)+"," +
	           			    " "+db.cite(city)+","+db.cite(buytime)+","+db.cite(remarks)+","+db.cite(times)+","+db.cite(community)+","+db.cite(member)+","+exporttype+" ) "); 
	          db.executeQuery("select wcid from WestracClue order by times desc ", 0, 1);
	          if(db.next())
	          {
	        	  c = db.getInt(1);
	          }

	        } finally
	        {
	            db.close();
	        }
	       return c;    
	    }
	    
	 public void set(String wcname,String mobile,int industrys,String clientname,String contactname,String phone,String clientmobile,String city,Date buytime,String remarks) throws SQLException
	    {
	    
		 	
	        DbAdapter db = new DbAdapter();
	        try
	        {
	           db.executeUpdate(" UPDATE WestracClue SET wcname="+db.cite(wcname)+",mobile="+db.cite(mobile)+",industrys="+industrys+",clientname="+db.cite(clientname)+"," +
	           		" contactname="+db.cite(contactname)+",phone="+db.cite(phone)+",clientmobile="+db.cite(clientmobile)+",city="+db.cite(city)+",buytime="+db.cite(buytime)+"," +
	           		" remarks="+db.cite(remarks)+" where wcid = "+wcid); 
	          
	        } finally
	        {
	            db.close();
	        }
	      
	    }
	 public void setWctype(int wctype)throws SQLException
	 {
		 DbAdapter db = new DbAdapter();
	        try
	        {
	           db.executeUpdate(" UPDATE WestracClue SET wctype="+wctype+"  where wcid = "+wcid); 
	          
	        } finally
	        {
	            db.close();
	        }
	 }
	 public void setWctype2(int wctype2)throws SQLException
	 {
		 DbAdapter db = new DbAdapter();
	        try
	        {
	           db.executeUpdate(" UPDATE WestracClue SET wctype2="+wctype2+"  where wcid = "+wcid); 
	          
	        } finally
	        {
	            db.close();
	        }
	 }
	 
	 
	 public void setWcmember(String wcmember)throws SQLException
	 {
		 DbAdapter db = new DbAdapter();
	        try
	        {
	           db.executeUpdate(" UPDATE WestracClue SET wcmember="+db.cite(wcmember)+"  where wcid = "+wcid); 
	          
	        } finally
	        {
	            db.close();
	        }
	 }
	 //是否导出
	 public void setExporttype(int exporttype) throws SQLException
	 {
		 DbAdapter db = new DbAdapter();
		 try
		 {
			 db.executeUpdate("UPDATE WestracClue SET exporttype ="+exporttype+" where wcid="+wcid);
		 }finally
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
	            c =  db.getInt("SELECT COUNT(wcid) FROM WestracClue WHERE community=" + DbAdapter.cite(community) + sql);
	        } catch(SQLException ex)
	        {
	            return 0; 
	        } finally
	        {
	            db.close();
	        }
	        return c;
	    }
	    
	    public void delete ()throws  SQLException
	    {
	    	 DbAdapter db = new DbAdapter();
		  
		        try
		        {
		            db.executeUpdate("DELETE FROM WestracClue WHERE wcid = "+wcid);
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
	            db.executeQuery("SELECT wcid FROM WestracClue WHERE community=" + DbAdapter.cite(community) + sql,pos,pageSize);

	            while (db.next())
	            {
	               
	                    vector.addElement(new Integer(db.getInt(1)));
	            
	            }
	        } finally
	        {
	            db.close();
	        }
	        return vector.elements();
	    }
		public String getWcname() {
			return wcname;
		}
		public String getMobile() {
			return mobile;
		}
		public int getIndustrys() {
			return industrys;
		}
		public String getClientname() {
			return clientname;
		}
		public String getContactname() {
			return contactname;
		}
		public String getPhone() {
			return phone;
		}
		public String getClientmobile() {
			return clientmobile;
		}
		public String getCity() {
			return city;
		}
		public Date getBuytime() {
			return buytime;
		}
		public String getRemarks() {
			return remarks;
		}
		public Date getTimes() {
			return times;
		}
		public String getCommunity() {
			return community;
		}
		public String getMember() {
			return member;
		}
		public int getExporttype() {
			return exporttype;
		}
		public boolean isExists() {
			return exists;
		}
		public int getWctype()
		{
			return wctype;
		}
		public int getWctype2()
		{
			return wctype2;
		}
		public String getWcmember()
		{
			return wcmember;
		}
	    
	    
	 
	    
	 
	 
	
	
	
}
