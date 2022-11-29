package tea.entity.subscribe;


import java.math.BigDecimal;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.Timer;
import java.util.TimerTask;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.Entity;
import tea.entity.SeqTable;

public class MobileOrder extends Entity {
	
	private String mobileorder;//订单
	private String mobile;//手机
	private String mobilecode;//手机验证码
	private int node;
	private String community;
	private boolean exists;
	private int type;//是否支付  0 没有支付，1 支付成功,3 过期
	private BigDecimal amount;
	
	private Date times;//创建时间
	private Date paytimes;//激活时间
	private Date maturitytimes;//到期时间
	
	

	public MobileOrder(String mobileorder)throws SQLException
	{
		this.mobileorder = mobileorder;
		load();
	}
	public static MobileOrder find(String mobileorder) throws SQLException
	{
		return new MobileOrder(mobileorder);
	}
	
	

	public void load() throws SQLException {
		DbAdapter db = new DbAdapter();
		try {
			db
					.executeQuery("SELECT mobile,mobilecode,node,community,type,times,paytimes,maturitytimes,amount FROM MobileOrder WHERE  mobileorder=  "+db.cite(mobileorder));
			if (db.next()) {
				mobile=db.getString(1);
				
				mobilecode=db.getString(2);
				node=db.getInt(3);
				community=db.getString(4);
				type=db.getInt(5);
				times=db.getDate(6);
				paytimes=db.getDate(7);
				maturitytimes=db.getDate(8);
				amount=db.getBigDecimal(9, 2);
				
				exists = true;
			} else {
				exists = false;
			}
		} finally {
			db.close();
		}
	}
	
	
	 public static String create(String mobile,String mobilecode,int node,String community,BigDecimal amount) throws SQLException
	 {
			SimpleDateFormat sdf = new  SimpleDateFormat("yyyyMMdd"); 
	    	Date timestring = new Date();
	    	String mobileorder = sdf.format(timestring)+"-4-" + SeqTable.getSeqNo("MobileOrder");
	        DbAdapter db = new DbAdapter();
	        String i = "";
	        try
	        {
	            db.executeUpdate("INSERT INTO MobileOrder (mobileorder,mobile,mobilecode,node,community,type,times,amount)VALUES("+db.cite(mobileorder)+","+db.cite(mobile)+","+db.cite(mobilecode)+","+(node)+","+db.cite(community)+",0,"+db.cite(timestring)+","+amount+"  )");
	            i = db.getString("SELECT MAX(mobileorder) FROM MobileOrder");
	        } finally
	        {
	            db.close();
	        }
	        return i;
	  }
	 
	 public static Enumeration find(String community,String sql,int pos,int size)throws SQLException
	    {
	        Vector vector = new Vector();
	        DbAdapter db = new DbAdapter();
	        try
	        {
	            db.executeQuery("SELECT mobileorder FROM MobileOrder WHERE community= " + db.cite(community) + sql,pos,size);
	           
	            while(db.next())
	            {
	                vector.add(db.getString(1));
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
	 public static String getMobileOrder(String mobile,String mobilecode,int node,String community)throws SQLException
	 {
		 DbAdapter db = new DbAdapter();
		 String morder="";
		 try
		 {
			 db.executeQuery("SELECT mobileorder FROM MobileOrder WHERE mobile = "+ db.cite(mobile)+" and mobilecode = "+db.cite(mobilecode)+" and community="+db.cite(community));
			 if(db.next())
			 {
				 morder = db.getString(1);
			 }
		 }finally
		 {
			 db.close();
		 }
		 return morder;
	 }
	 
	 public void delete() throws SQLException
	 {
			DbAdapter db = new DbAdapter();
			try {
				db.executeUpdate("DELETE FROM  MobileOrder WHERE mobileorder = "+ db.cite(mobileorder));

			} finally {
				db.close();
			}
		}

		    public static int count(String community,String sql) throws SQLException
		    {
		        int count = 0;
		        DbAdapter db = new DbAdapter();
		        try
		        {
		            db.executeQuery("SELECT COUNT(mobileorder) FROM MobileOrder  WHERE community=" + db.cite(community) + sql);
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
		    
		    //激活时间
		    public void setPaytime(Date paytime)throws SQLException
		    {
		    	DbAdapter db = new DbAdapter();
		    	Date maturitytimes = PackageOrder.getAfterDate(paytime,1,"D"); 
		    	try
		    	{
		    		db.executeUpdate("UPDATE MobileOrder SET paytimes="+db.cite(paytime)+",maturitytimes="+db.cite(maturitytimes)+" WHERE mobileorder =  "+db.cite(mobileorder));
		    		
		    	}finally
		    	{
		    		db.close();
		    	}
		    }
		 
		    public void setType(int type)throws SQLException
		    {
		    	DbAdapter db = new DbAdapter();
		    	try
		    	{
		    		db.executeUpdate("UPDATE MobileOrder SET type="+type+" WHERE mobileorder =  "+db.cite(mobileorder));
		    	}finally
		    	{
		    		db.close();
		    	}
		    }
		    
		    //判断是否有短信确认码
		    public static boolean isMobilecode(String mobile,String mobilecode,int node)throws SQLException
		    {
		    	boolean f = false;
		    	DbAdapter db = new DbAdapter();
		    	try
		    	{
		    		db.executeQuery("SELECT mobileorder FROM MobileOrder WHERE type = 0 and  mobile="+db.cite(mobile)+" and mobilecode="+db.cite(mobilecode)+"  and node= "+node);
		    		//System.out.println("SELECT mobileorder FROM MobileOrder WHERE type = 0 and  mobile="+db.cite(mobile)+" and mobilecode="+db.cite(mobilecode)+"  and node= "+node);
		    		if(db.next())
		    		{
		    			f = true;
		    		}
		    	}finally
		    	{
		    		db.close();
		    	}
		    	return f;
		    }
		    
		    //判断是否是数字
		    public static boolean isNumeric(String str)
		    {
		    	  final String number = "0123456789";
		    	  for(int i = 0;i<str.length();i++){   
		    	            if(number.indexOf(str.charAt(i)) == -1){   
		    	             return false;   
		    	            }   
		    	  }   
		    	  return true; 
		    }
		    //判断是否有短信确认码
		    public static int isMobilecode(String mobilecode,int node)throws SQLException
		    {
		    	int f = -1;// 0,没有激活,1,激活使用,3,过期
		    	DbAdapter db = new DbAdapter();
		    	try
		    	{
		    		db.executeQuery("SELECT mobileorder FROM MobileOrder WHERE type = 1  and mobilecode="+db.cite(mobilecode)+"  and node= "+node);
		    		if(db.next())
		    		{
		    			f = 1;
		    		}else
		    		{
		    			db.executeQuery("SELECT mobileorder FROM MobileOrder WHERE type = 0  and mobilecode="+db.cite(mobilecode)+"  and node= "+node);
		    			if(db.next())
		    			{
		    				f = 0;
		    			}else
		    			{
		    				db.executeQuery("SELECT mobileorder FROM MobileOrder WHERE type = 3  and mobilecode="+db.cite(mobilecode)+"  and node= "+node);
		    				if(db.next())
		    				{
		    					f = 3;
		    				}
		    			}
		    		}
		    		
		    	}finally
		    	{
		    		db.close();
		    	}
		    	return f;
		    }
		    //通过激活码 获取 订单号
		    public static String getMobileOrder(String mobilecode,int node)throws SQLException
		    {
		    	String f="";// 0,没有激活,1,激活使用,3,过期
		    	DbAdapter db = new DbAdapter();
		    	try
		    	{
		    		db.executeQuery("SELECT mobileorder FROM MobileOrder WHERE type = 1  and mobilecode="+db.cite(mobilecode)+"  and node= "+node);
		    		if(db.next())
		    		{
		    			f = db.getString(1);
		    		}
		    		
		    	}finally
		    	{ 
		    		db.close();
		    	} 
		    	return f;
		    }
		    
			public String getMobile() {
				return mobile;
			}
			public String getMobilecode() {
				return mobilecode;
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
			public int getType() {
				return type;
			}
			public Date getTimes() {
				return times;
			}
			 
			public Date getPaytimes() {
				return paytimes;
			}
			
			public Date getMaturitytimes()
			{
				return maturitytimes;
			}
		    
		    
			public java.math.BigDecimal getAmount()
			{
				return amount;
			}
		    
		    
}
