package tea.entity.admin;

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
import tea.entity.subscribe.MobileOrder;
public class PayOrder extends Entity {
	
	private int poid;
	private String payorder;//支付类型的订单号 商品，会员， 套餐，手机支付
	private BigDecimal amount;//订单金额 
	private Date paytime;// 支付时间
	private Date times;//添加时间
	private String community;
	private int potype; // 0 没支付
	private int type;//支付类型的订单号 商品，会员， 套餐，手机支付
	private boolean exists;
	

	public PayOrder(int poid)throws SQLException
	{
		this.poid = poid;
		load();
	}
	public static PayOrder find(int poid) throws SQLException
	{
		return new PayOrder(poid);
	}
	
	
	public void load() throws SQLException {
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("SELECT payorder,amount,paytime,times,community,potype,type FROM PayOrder WHERE  poid =  "+poid);
			if (db.next()) {
				payorder = db.getString(1);
				amount =db.getBigDecimal(2,2);
				paytime=db.getDate(3);
				times =db.getDate(4);
				community=db.getString(5);
				potype=db.getInt(6);
				type=db.getInt(7);
				
				exists = true;
			} else {
				exists = false;
			}
		} finally {
			db.close();
		}
	}

	public static int create(String payorder,BigDecimal amount,Date paytime,String community,int potype,int type) throws SQLException
	{
	        DbAdapter db = new DbAdapter();
	       int i = 0;
	        try
	        {
	            db.executeUpdate("INSERT INTO PayOrder (payorder,amount,paytime,times,community,potype,type)VALUES("+db.cite(payorder)+","+amount+","+db.cite(paytime)+","+db.cite(new Date())+","+db.cite(community)+","+potype+","+type+"  )");
	            i = db.getInt("SELECT MAX(poid) FROM PayOrder");
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
	            db.executeQuery("SELECT poid FROM PayOrder WHERE community= " + db.cite(community) + sql,pos,size);
	            while(db.next())
	            {
	                vector.add((Integer)db.getInt(1));
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
			try {
				db.executeUpdate("DELETE FROM  PayOrder WHERE poid = "+ poid);

			} finally {
				db.close();
			}
		}
	 public static void delete(String community,String payorder)throws SQLException
	 {
		 DbAdapter db = new DbAdapter();
			try {
				db.executeUpdate("DELETE FROM  PayOrder WHERE community="+db.cite(community)+" and potype=0 and payorder = "+db.cite(payorder));
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
	            db.executeQuery("SELECT COUNT(poid) FROM PayOrder  WHERE community=" + db.cite(community) + sql);
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
	    //根据订单号，判断表中是否有记录
	    
	    public static int isPoid(String community,String payorder,int type)throws SQLException
	    {
	    	DbAdapter db = new DbAdapter();
	    	int f = 0;
	    	try
	    	{ 
	    		db.executeQuery("SELECT poid FROM PayOrder WHERE community="+db.cite(community)+" and payorder="+db.cite(payorder)+" and type="+type+" and potype=0 ");
	    		if(db.next())
	    		{
	    			f = db.getInt(1);
	    		}
	    		
	    	}finally
	    	{
	    		db.close();
	    	}
	    	return f;
	    	
	    }
	    public void setPotype(int potype)throws SQLException
	    {
	    	DbAdapter db = new DbAdapter();
	    	try
	    	{ 
	    		db.executeUpdate(" UPDATE PayOrder SET potype ="+potype+" WHERE poid= "+poid);
	    	}finally
	    	{
	    		db.close();
	    	}
	    }
	    public void setPaytime(Date paytime)throws SQLException
	    {
	    	DbAdapter db = new DbAdapter();
	    	try 
	    	{ 
	    		db.executeUpdate(" UPDATE PayOrder SET paytime ="+db.cite(paytime)+" WHERE poid= "+poid);
	    	}finally
	    	{
	    		db.close();
	    	}
	    }
	    
		public String getPayorder() {
			return payorder;
		}
		public BigDecimal getAmount() {
			return amount;
		}
		public Date getPaytime() {
			return paytime;
		}
		public Date getTimes() {
			return times;
		}
		public String getCommunity() {
			return community;
		}
		public int getPotype() {
			return potype;
		}
		public boolean isExists() {
			return exists;
		}
	    public int getType()
	    {
	    	return type;
	    }
	    
}
