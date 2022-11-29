package tea.entity.admin.mov;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.Date;
import java.util.Enumeration;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.Entity;

public class UpgradeMember extends Entity {

		private int umid;
		private String member;//升级会员
		private Date becometime;//阅读有效期
		private int period;//兑换积分
		private BigDecimal remittance;//汇款金额
		private int remtype;//汇款方式  0邮局,1 银行,2 代理人  
		private int proxymembertype;//升级方式，0自己注册，1会员代理
		private String proxymember;//代理会员的ID
		private String invoiceremarks;//发票备注
		private int invoicetype;//邮寄状态 ,0 不需要,1   未寄 ,2  已寄  
		
		private String adminmember;//添加记录会员
		private String community;
		private Date times;
		private int years;//添加年份
		private boolean exists;
		
		 public UpgradeMember(int umid) throws SQLException
		    {
		        this.umid = umid;
		        load();

		    }

		    public static UpgradeMember find(int umid) throws SQLException
		    {
		        return new UpgradeMember(umid);
		    }
		    

		    public void load() throws SQLException
		    {
		        DbAdapter db = new DbAdapter();
		        try
		        {
		            db.executeQuery("SELECT member,becometime,period,remittance,remtype,proxymembertype,proxymember,invoiceremarks," +
		            		"  invoicetype,community,times,adminmember, years FROM UpgradeMember WHERE umid=" + umid);
		            if(db.next())
		            {
		            	member = db.getString(1);
		            	becometime=db.getDate(2);
		            	period=db.getInt(3);
		            	remittance =db.getBigDecimal(4, 1);
		            	remtype=db.getInt(5);
		            	proxymembertype=db.getInt(6);
		            	proxymember=db.getString(7);
		            	invoiceremarks=db.getString(8);
		            	invoicetype=db.getInt(9);
		            	community=db.getString(10);
		            	times =db.getDate(11);
		            	adminmember=db.getString(12);    
		            	 years=db.getInt(13);
		            	  exists = true;
		            }else
		            {
		                exists = false;
		            }
		        } finally
		        {
		            db.close();
		        }
		    }
		    
		    

			public static void create(String member,Date becometime,int period,BigDecimal remittance,int remtype,int proxymembertype,String proxymember,String invoiceremarks,
		    							int invoicetype,String adminmember,String community,Date times,int  years) throws SQLException
		    {
		        DbAdapter db = new DbAdapter();

		        try
		        {
		            db.executeUpdate("INSERT INTO UpgradeMember(member,becometime,period,remittance,remtype,proxymembertype,proxymember,invoiceremarks,invoicetype,adminmember,community,times, years) " +
		            		         "VALUES("+db.cite(member)+","+db.cite(becometime)+","+period+","+remittance+","+remtype+","+proxymembertype+","+db.cite(proxymember)+","+db.cite(invoiceremarks)+"," +
		            		         		" "+invoicetype+","+db.cite(adminmember)+","+db.cite(community)+","+db.cite(times)+","+years+" )");
		           
		        
		        } finally 
		        {
		            db.close();
		        }

		    }

		    public void set(Date becometime,int period,BigDecimal remittance,int remtype,int proxymembertype,String proxymember,String invoiceremarks,
					int invoicetype,String adminmember,Date times,int  years) throws SQLException
		    {
		        DbAdapter db = new DbAdapter();
		        try
		        {
		            db.executeUpdate("UPDATE UpgradeMember SET becometime="+db.cite(becometime)+",period="+period+",remittance="+remittance+",remtype="+remtype+",proxymembertype="+proxymembertype+"," +
		            		" proxymember="+db.cite(proxymember)+",invoiceremarks="+db.cite(invoiceremarks)+",invoicetype="+invoicetype+",adminmember="+db.cite(adminmember)+",times="+db.cite(times)+"," +
		            		"  years="+ years+" WHERE umid=" + umid);
		        } finally
		        {
		            db.close();
		        }
		    }
		    
		    //阅读有效期时间修改
		    public void setBecometime(Date becometime) throws SQLException
		    {
		        DbAdapter db = new DbAdapter();
		        try
		        {
		            db.executeUpdate("UPDATE UpgradeMember SET becometime="+db.cite(becometime)+" WHERE umid=" + umid);
		        } finally
		        {
		            db.close();
		        }
		    }
		    //邮寄发票状态修改
		    public void setInvoice(int invoicetype)throws SQLException
		    {
		    	 DbAdapter db = new DbAdapter();
		         try
		         {
		             db.executeUpdate("UPDATE UpgradeMember SET invoicetype="+invoicetype+" WHERE umid=" +umid);
		         } finally
		         { 
		             db.close();
		         }
		    }
		    public void delete()throws SQLException
		    {
		    	 DbAdapter db = new DbAdapter();
		         try
		         {
		             db.executeUpdate("DELETE FROM UpgradeMember  WHERE umid=" +umid);
		         } finally
		         { 
		             db.close();
		         }
		    }
		    
		    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
		    {
		        Vector v = new Vector();
		        DbAdapter db = new DbAdapter();
		        try
		        {
		            db.executeQuery("SELECT umid FROM UpgradeMember WHERE community=" + db.cite(community) + sql,pos,size);
		            while(db.next())
		            {
		                v.addElement(new Integer(db.getInt(1)));
		            }

		        } finally
		        {
		            db.close();
		        }
		        return v.elements();
		    }
		    
		    //添加用户
		    public static Enumeration findMember(String community,String sql,int pos,int size) throws SQLException
		    {
		        Vector v = new Vector();
		        DbAdapter db = new DbAdapter();
		        try
		        {
		            db.executeQuery("SELECT member FROM UpgradeMember WHERE community=" + db.cite(community) + sql,pos,size);
		            while(db.next())
		            {
		                v.addElement(db.getString(1));
		            }

		        } finally
		        {
		            db.close();
		        }
		        return v.elements();
		    }
		    
		    public static int count(String community,String sql) throws SQLException
		    {
		        int count = 0;
		        DbAdapter db = new DbAdapter();
		        try
		        {
		            count = db.getInt("SELECT COUNT(umid) FROM UpgradeMember WHERE community=" + DbAdapter.cite(community) + sql);
		        } finally
		        {
		            db.close();
		        }
		        return count;
		    }
		    public static java.math.BigDecimal countRemittance(String community,String sql)throws SQLException
		    {
		    	java.math.BigDecimal r = new java.math.BigDecimal("0.0");
		    	 DbAdapter db = new DbAdapter();
			        try
			        {
			           db.executeQuery("SELECT remittance FROM UpgradeMember WHERE community=" + DbAdapter.cite(community) + sql);
			           while(db.next())
			           {
			        	   r = r.add(db.getBigDecimal(1, 1));
			           }
			        } finally
			        { 
			            db.close();
			        }
		    	return r;
		    }
		   
		    
		    public static int countMember(String community ,String sql)throws SQLException
		    {
		    	int c = 0;
		    	 DbAdapter db = new DbAdapter();
			        try 
			        {
			           db.executeQuery("select member from UpgradeMember  WHERE community=" + DbAdapter.cite(community) + sql+"   group by member ");
			           while(db.next())
			           {
			        	   c++;
			           }
			        } finally
			        { 
			            db.close();
			        }
		    	return c;
		    }
		    
		    public String getMember() {
				return member;
			}

			public Date getBecometime() {
				return becometime;
			}

			public int getPeriod() {
				return period;
			}

			public BigDecimal getRemittance() {
				return remittance;
			}

			public int getRemtype() {
				return remtype;
			}

			public int getProxymembertype() {
				return proxymembertype;
			}

			public String getProxymember() {
				return proxymember;
			}

			public String getInvoiceremarks() {
				return invoiceremarks;
			}

			public int getInvoicetype() {
				return invoicetype;
			}

			public String getAdminmember() {
				return adminmember;
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
			public int getYears()
			{
				return  years;
			}

		    
		
		
		
		
}
