package tea.entity.westrac;

import java.sql.SQLException;
import java.util.Date;
import java.util.Enumeration;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.Entity;
import tea.entity.admin.mov.MemberOrder;
import tea.entity.node.BBS;
import tea.entity.node.Node;

public class Eventregistration extends Entity{
	
	private int erid;//主键id 
	private int node;//活动iD
	private String member;//报名用户
	private String mobile;//手机号
	private String city;//省市
	private String address;//地址
	
	private int acco;//是否有随行人员 0 是，1 否
	private int accoquantity;//随行人员人数
	
	private int catering;//是否安排餐饮 0是，1否
	private String specials;// 餐饮的特殊要求
	
	
	private int stay;//是否需要安排住宿 0是，1否
	private int roomnumber;//房间数 
	private int accoroom;//随行人员住宿房型
	private String accoother;//随行人员其他要求

	private int shuttle;//是否安排接送 0 是，1否
	 
	private int transport;//交通工具
	private String gotrainnumber;//去程 车次
	private Date reachtime;//到达日期
	private String reachtimedate;//到达时间
	
	
	private String returnrainnumber;//返程 车次
	private Date returntime;//到达日期
	private String returntimedate;//到达时间
	
	private String community;
	private boolean exists;
	private Date times;
	private int verifg;//是否审核 0 未审核，1 审核通过
	private Date verifgtime;//审核日期
	private int confirmtype;//是否到会 记录 ,1 到会，2 没有到会
	
	private int score;//会员评论 分
	  public static String SCORE_TYPE[]={"","1分","2分","3分","4分","5分"};
	  
//暂时不用字段
		private String email;//邮箱 
		private String acconame;//随行人员 姓名
		private int accorel;//随行人员 关系
		private int accogender;//随行人员性别 0 男，1女

		private String accocode;//随行人员身份证号
	
	   
	
	public static final String  ACCOREL_TYPE[] = {"机主","配偶","子女","亲戚","朋友","司机","其他"};
	public static final String  ACCOROOM_TYPE[] = {"单人大床房","标准间合住"};
	public static final String  TRANSPORT_TYPE[]={"火车","飞机","长途汽车"};	

	public static Eventregistration find(int erid)throws SQLException
	{
		return new Eventregistration(erid);
	}
	public Eventregistration(int erid)throws SQLException
	{
		this.erid = erid;
		load();
	}
	
	 private void load() throws SQLException
	    {
	       
	        DbAdapter db = new DbAdapter();
	        try
	        {
	            db.executeQuery("SELECT node,member,mobile,address,email,acco,accoquantity,stay,acconame,accorel,accogender,accoroom,accocode,accoother,shuttle,transport," +
	            		" gotrainnumber,reachtime,reachtimedate,returnrainnumber,returntime,returntimedate,community,times," +
	            		" verifg,verifgtime,confirmtype,score,catering,specials,roomnumber,city FROM Eventregistration WHERE erid=" + erid);
	            if(db.next())
	            {
	                int i = 1;
	                node = db.getInt(i++);
	                member=db.getString(i++);
	                
	                mobile=db.getString(i++);
	                address=db.getString(i++);
	                email=db.getString(i++);
	                acco=db.getInt(i++);
	                accoquantity=db.getInt(i++);
	                stay=db.getInt(i++);
	                acconame=db.getString(i++);
	                accorel=db.getInt(i++);
	                accogender=db.getInt(i++);
	                accoroom=db.getInt(i++);
	                accocode=db.getString(i++);
	                accoother=db.getString(i++);
	                shuttle=db.getInt(i++);
	                
	                transport=db.getInt(i++);
	                
	                gotrainnumber=db.getString(i++);
	                reachtime=db.getDate(i++);
	                reachtimedate=db.getString(i++);
	                
	                returnrainnumber=db.getString(i++);
	                returntime=db.getDate(i++);
	                returntimedate=db.getString(i++);
	                
	                community=db.getString(i++);
	                times=db.getDate(i++);
	                verifg=db.getInt(i++);
	                verifgtime=db.getDate(i++);
	                confirmtype=db.getInt(i++);
	                score=db.getInt(i++);
	                catering=db.getInt(i++);
	                specials=db.getString(i++);
	                roomnumber=db.getInt(i++);
	                city=db.getString(i++);
	                
	               
	                
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
	 	
	 
	 public static int getErid(int node ,String member,String community)throws SQLException
	 {
		 DbAdapter db = new DbAdapter();
		 int e = 0;
		 try
		 {
			 db.executeQuery("select erid from Eventregistration where node="+node+" and member ="+db.cite(member)+" and community ="+db.cite(community));
			 if(db.next())
			 {
				 e = db.getInt(1);
			 }
		 }finally
		 {
			 db.close(); 
		 }
		 return e;
	 }
	 
	 
	    public static int create(int node,String member,String mobile,String address,String email,int acco,int accoquantity,int stay,String acconame,int accorel,
	    		int accogender,int accoroom,String accocode,String accoother,int shuttle,int transport,String gotrainnumber,Date reachtime,
	    		String reachtimedate,String returnrainnumber,Date returntime, String returntimedate, String community,Date times,
	    		int catering,String specials,int roomnumber,String city ) throws SQLException
	    {
	    	int c = 0;
	        DbAdapter db = new DbAdapter();
	        try
	        {
	           db.executeUpdate("INSERT INTO Eventregistration(node,member,mobile,address,email,acco,accoquantity,stay,acconame,accorel,accogender," +
	            		" accoroom,accocode,accoother,shuttle,transport,gotrainnumber,reachtime,reachtimedate,returnrainnumber,returntime,returntimedate," +
	            		"community,times,catering,specials,roomnumber,city)VALUES("+node+","+db.cite(member)+","+db.cite(mobile)+","+db.cite(address)+","+db.cite(email)+","+acco+"," +
	            		" "+accoquantity+","+stay+","+db.cite(acconame)+","+accorel+","+accogender+","+accoroom+","+db.cite(accocode)+","+db.cite(accoother)+"," +
	            	    " "+shuttle+","+transport+","+db.cite(gotrainnumber)+","+db.cite(reachtime)+","+db.cite(reachtimedate)+","+db.cite(returnrainnumber)+","+db.cite(returntime)+"," +
	            	    " "+db.cite(returntimedate)+","+db.cite(community)+","+db.cite(times)+","+catering+","+db.cite(specials)+","+roomnumber+","+db.cite(city)+" ) "); 
	           c = db.getInt("select erid from Eventregistration order by times desc ");
	           
	        } finally
	        {
	            db.close();
	        }
	        return c;
	    }
	    
	    
	    public void set(int node,String member,String mobile,String address,String email,int acco,int accoquantity,int stay,String acconame,int accorel,
	    		int accogender,int accoroom,String accocode,String accoother,int shuttle,int transport,String gotrainnumber,Date reachtime,
	    		String reachtimedate,String returnrainnumber,Date returntime, String returntimedate,int catering,String specials,int roomnumber,String city ) throws SQLException
	    {
	        DbAdapter db = new DbAdapter();
	        try
	        {
	        	StringBuffer sp = new StringBuffer();
	        	sp.append("UPDATE Eventregistration SET ");
	        	sp.append("node=").append(node).append(",");
	        	sp.append("member=").append(db.cite(member)).append(",");
	        	sp.append("mobile=").append(db.cite(mobile)).append(",");
	        	sp.append("address=").append(db.cite(address)).append(",");
	        	sp.append("email=").append(db.cite(email)).append(",");
	        	
	        	sp.append("acco=").append(acco).append(",");
	        	sp.append("accoquantity=").append(accoquantity).append(",");
	        	sp.append("stay=").append(stay).append(",");
	        	sp.append("acconame=").append(db.cite(acconame)).append(",");
	        	sp.append("accorel=").append(accorel).append(",");
	        	
	        	sp.append("accogender=").append(accogender).append(",");
	        	sp.append("accoroom=").append(accoroom).append(",");
	        	sp.append("accocode=").append(db.cite(accocode)).append(",");
	        	sp.append("accoother=").append(db.cite(accoother)).append(",");
	        	
	        	
	        	sp.append("shuttle=").append(shuttle).append(",");
	        	sp.append("transport=").append(transport).append(",");
	        	sp.append("gotrainnumber=").append(db.cite(gotrainnumber)).append(",");
	        	sp.append("reachtime=").append(db.cite(reachtime)).append(",");
	        	sp.append("reachtimedate=").append(db.cite(reachtimedate)).append(",");
	        	sp.append("returnrainnumber=").append(db.cite(returnrainnumber)).append(",");
	        	sp.append("returntime=").append(db.cite(returntime)).append(",");
	        	sp.append("catering=").append(catering).append(",");
	        	sp.append("specials=").append(db.cite(specials)).append(",");
	        	sp.append("roomnumber=").append(roomnumber).append(",");
	        	sp.append("city=").append(DbAdapter.cite(city)).append(",");
	        	
	        	
	        	
	        	sp.append("returntimedate=").append(db.cite(returntimedate));
	        	
	        
	        	
	        	
	    
	        	sp.append(" WHERE erid=" + erid);
	        	
	        	
	        	
	            db.executeUpdate(sp.toString() );
	        } finally
	        {
	            db.close();
	        }
	        
	    }
	    //编辑随行人员信息
	    public void setAcco(int stay,String acconame,int accorel,int accogender,int accoroom,String accocode,String accoother) throws SQLException
	    {
	        DbAdapter db = new DbAdapter();
	        try
	        {
	        	StringBuffer sp = new StringBuffer();
	        	sp.append("UPDATE Eventregistration SET ");
	        	
	        	
	        	
	        	sp.append("stay=").append(stay).append(",");
	        	sp.append("acconame=").append(db.cite(acconame)).append(",");
	        	sp.append("accorel=").append(accorel).append(",");
	        	
	        	sp.append("accogender=").append(accogender).append(",");
	        	sp.append("accoroom=").append(accoroom).append(",");
	        	sp.append("accocode=").append(db.cite(accocode)).append(",");
	        	sp.append("accoother=").append(db.cite(accoother));
	        	
	        	
	    
	        	sp.append(" WHERE erid=" + erid);
	        	
	        	
	        	
	            db.executeUpdate(sp.toString() );
	        } finally
	        {
	            db.close();
	        }
	        
	    }
	    
	    public void setVerifg(int verifg)throws SQLException
	    {
	    	DbAdapter db = new DbAdapter();
	    	try
	    	{
	    		db.executeUpdate("UPDATE Eventregistration SET verifg = "+verifg+" WHERE erid = "+erid);
	    	}finally
	    	{
	    		db.close();
	    	}
	    }
	    //同一个会员不能多次报名 
	    public static boolean isBool(int node,String member)throws SQLException
	    {
	    	boolean f = false;
	    	DbAdapter db = new DbAdapter();
	    	try
	    	{
	    		db.executeQuery("select erid from Eventregistration WHERE node ="+node+" and member= "+db.cite(member));
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
	    public void setConfirmtype(int confirmtype)throws SQLException
	    {
	    	DbAdapter db = new DbAdapter();
	    	try
	    	{
	    		db.executeUpdate("update Eventregistration set confirmtype = "+confirmtype+" where erid = "+erid);
	    	}finally
	    	{
	    		db.close();
	    	}
	    }
	    //修改随行人员人数
	    public void setAccoquantity(int accoquantity)throws SQLException
	    {
	    	DbAdapter db = new DbAdapter();
	    	try
	    	{
	    		db.executeUpdate("update Eventregistration set accoquantity = "+accoquantity+" where erid = "+erid);
	    	}finally
	    	{
	    		db.close();
	    	}
	    }
	    public void setScore(int score)throws SQLException
	    {
	    	DbAdapter db = new DbAdapter();
	    	try
	    	{
	    		db.executeUpdate("update Eventregistration set score = "+score+" where erid = "+erid);
	    	}finally
	    	{
	    		db.close();
	    	}
	    }

	    
	    public void setVerifgTime(Date verifgtime)throws SQLException
	    {
	    	DbAdapter db = new DbAdapter();
	    	try
	    	{
	    		db.executeUpdate("UPDATE Eventregistration SET verifgtime = "+db.cite(verifgtime)+" WHERE erid = "+erid);
	    	}finally
	    	{
	    		db.close();
	    	}
	    }
	    //
		public static String getMembericon(String community,int node,int count)throws SQLException
		{
			int sum = Eventregistration.Countsum(community, " and node ="+node+" and score !=0 ");
			
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
	    
	    public static Enumeration find(String community,String sql,int pos,int pagesize) throws SQLException
	    {
	        Vector v = new Vector();
	        DbAdapter db = new DbAdapter();
	        try
	        {
	            db.executeQuery("SELECT erid FROM Eventregistration WHERE  community=" + DbAdapter.cite(community) + sql,pos,pagesize);
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

	 
	    public static int Count(String community,String sql)
	    {
	        DbAdapter db = new DbAdapter();
	        int c = 0;
	        try
	        {
	            c =  db.getInt("SELECT COUNT(erid) FROM Eventregistration WHERE community=" + DbAdapter.cite(community) + sql);
	        } catch(SQLException ex)
	        {
	            return 0; 
	        } finally
	        {
	            db.close();
	        }
	        return c;
	    }
	    
	    public static int Countsum(String community,String sql)
	    {
	        DbAdapter db = new DbAdapter();
	        int c = 0;
	        try
	        {
	            c =  db.getInt("SELECT COUNT(erid) FROM Eventregistration WHERE community=" + DbAdapter.cite(community) + sql);
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
		            db.executeUpdate("DELETE FROM Eventregistration WHERE erid = "+erid);
		        } catch(SQLException ex)
		        {
		           
		        } finally
		        {
		            db.close();
		        }
		       
	    }
		public int getNode() {
			return node;
		}
		public String getMember() {
			return member;
		}
		public String getMobile() {
			return mobile;
		}
		public String getAddress() {
			return address;
		}
		public String getEmail() {
			return email;
		}
		public int getAcco() {
			return acco;
		}
		public int getAccoquantity() {
			return accoquantity;
		}
		public int getStay() {
			return stay;
		}
		public String getAcconame() {
			return acconame;
		}
		public int getAccorel() {
			return accorel;
		}
		public int getAccogender() {
			return accogender;
		}
		public int getAccoroom() {
			return accoroom;
		}
		public String getAccocode() {
			return accocode;
		}
		public String getAccoother() {
			return accoother;
		}
		public int getShuttle() {
			return shuttle;
		}
		public int getTransport() {
			return transport;
		}
		public String getGotrainnumber() {
			return gotrainnumber;
		}
		public Date getReachtime() {
			return reachtime;
		}
		public String getReachtimedate() {
			return reachtimedate;
		}
		public String getReturnrainnumber() {
			return returnrainnumber;
		}
		public Date getReturntime() {
			return returntime;
		}
		public String getReturntimedate() {
			return returntimedate;
		}
		public String getCommunity() {
			return community;
		}
		public boolean isExists() {
			return exists;
		}
		public Date getTimes() {
			return times;
		}
		public int getVerifg() {
			return verifg;
		}
		public Date getVerifgtime() {
			return verifgtime;
		}
		public int getConfirmtype()
		{
			return confirmtype;
		}
		
		public int getScore()
		{
			return score;
		}
		
		public int getCatering()
		{
			return catering;
		}
		public String getSpecials()
		{
			return specials;
		}
		public int getRoomnumber()
		{
			return roomnumber;
		}
	    public String getCity()
	    {
	    	return city;
	    }
	    
	    

	    
	    
	 

	
	
	
	
	
	
	

}
