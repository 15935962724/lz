package tea.entity.node;


import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.site.CommunityOption;
import tea.entity.site.Subscriber;
import tea.translator.*;

public class NodePoll_2 extends Entity {

	private int npid;
	private int node;
	private int npindex1;
	private int npindex2;
	private int npindex3;
	private int npindex4;
	private int npindex5;
	private int npindex6;
	private Date times;
	private String ip;

	//pirvate

	private boolean exists;
	private static Cache _cache = new Cache(100);
	public static final String  POLL_TYPE[]={"","喜欢","一般","不喜欢"};

	 public static NodePoll_2 find(int npid)throws SQLException
	 {
		 NodePoll_2 obj = (NodePoll_2) _cache.get(npid);
	        if(obj == null)
	        {
	            obj = new NodePoll_2(npid);
	            _cache.put(npid,obj);
	        }
	        return obj;
	  }
	public NodePoll_2(int npid) throws SQLException
	{
		 this.npid = npid;
	      load();
	}

	 private void load() throws SQLException
	 {

	            DbAdapter db = new DbAdapter();
	            try
	            {
	                db.executeQuery("SELECT npindex1,npindex2,npindex3,npindex4,npindex5,npindex6,node,times,ip FROM NodePoll_2 WHERE npid=" + npid);
	                if(db.next())
	                {
	                	npindex1=db.getInt(1);
	                	npindex2=db.getInt(2);
	                	npindex3=db.getInt(3);
	                	npindex4=db.getInt(4);
	                	npindex5=db.getInt(5);
	                	npindex6=db.getInt(6);
	                	node = db.getInt(7);
	                	times =db.getDate(8);
	                	ip = db.getString(9);
	                    exists=true;
	                } else
	                {
	                	exists = false;
	                }
	            } finally
	            {
	                db.close();
	            }

	  }


	 public static void create(int node,int npindex1,int npindex2,int npindex3,int npindex4,int npindex5,int npindex6,Date times,String ip) throws SQLException
	 {
	        DbAdapter db = new DbAdapter(1);
	        try
	        {
	            db.executeUpdate("INSERT INTO NodePoll_2(node,npindex1,npindex2,npindex3,npindex4,npindex5,npindex6,times,ip) VALUES(" + node+ "," +
	            		"" + npindex1+ "," + npindex2 + "," + npindex3 + "," + npindex4 + "," + npindex5 + "," + npindex6+ ","+db.cite(times)+","+db.cite(ip)+" )");
	        } finally
	        {
	            db.close();
	        }
	        _cache.clear();
	 }

	 public  void set(int npindex1,int npindex2,int npindex3,int npindex4,int npindex5,int npindex6) throws SQLException
	 {
	        DbAdapter db = new DbAdapter(1);
	        try
	        {
	            db.executeUpdate("UPDATE  NodePoll_2 SET npindex1="+npindex1+",npindex2="+npindex2+",npindex3="+npindex3+"," +
	            		"npindex4="+npindex4+",npindex5="+npindex5+",npindex6="+npindex6+" WHERE npid =  "+npid);
	        } finally
	        {
	            db.close();
	        }
	        this.npindex1 = npindex1;
	        this.npindex2 = npindex2;
	        this.npindex3 = npindex3;
	        this.npindex4 = npindex4;
	        this.npindex5 = npindex5;
	        this.npindex6 = npindex6;
	        _cache.clear();
	 }
	 public static int getNp(int index,int node)throws SQLException
	 {
		 int i = 0;
		 NodePoll_2 npobj = NodePoll_2.find(node);
		  switch(index)
			{
			  case 1 :
				  i=npobj.getNpindex1();
				  break;
			  case 2 :
				  i=npobj.getNpindex2();
				  break;
			  case 3 :
				  i=npobj.getNpindex3();
				  break;
			  case 4 :
				  i=npobj.getNpindex4();
				  break;
			  case 5 :
				  i=npobj.getNpindex5();
				  break;
			  case 6 :
				  i=npobj.getNpindex6();
				  break;
			}

		 return i;
	 }

	 public static String getNpconut(int index,int npid)throws SQLException
	 {
		 float i = 0;

		 int count = 0;
		 DbAdapter db = new DbAdapter();
		 try
		 {
			 db.executeQuery("select npindex1,npindex2,npindex3,npindex4,npindex5,npindex6 from NodePoll_2 where npid="+npid);
			 if(db.next())
			 {
				 count = db.getInt(1)+db.getInt(2)+db.getInt(3)+db.getInt(4)+db.getInt(5)+db.getInt(6);
			 }
		 }finally
		 {
			 db.close();
		 }
		 //  float p = (float) to / count;
		 NodePoll_2 npobj = NodePoll_2.find(npid);
		  switch(index)
			{
			  case 1 :
				  i=(float)npobj.getNpindex1() / count;
				  break;
			  case 2 :
				  i=(float)npobj.getNpindex2() / count;
				  break;
			  case 3 :
				  i=(float)npobj.getNpindex3() / count;
				  break;
			  case 4 :
				  i=(float)npobj.getNpindex4() / count;
				  break;
			  case 5 :
				  i=(float)npobj.getNpindex5() / count;
				  break;
			  case 6 :
				  i=(float)npobj.getNpindex6() / count;
				  break;
			}


		  java.text.NumberFormat nf = java.text.NumberFormat.getPercentInstance();
		  String str = "100%";
		  if(i>0)
		  {
		    i = (1-i);
	        nf.setMinimumFractionDigits(0); // 小数点后保留几位
	         str = nf.format(i);
		  }


		 return str;
	 }

	 public static int getNpid(String ip,int node,Date times )throws SQLException
	 {
		 int c = 0;
		 DbAdapter db = new DbAdapter();
		 try{
			 db.executeQuery("SELECT npid FROM NodePoll_2 WHERE ip ="+db.cite(ip)+" AND node ="+node+" AND  times= "+db.cite(times));
			 if(db.next()){
				 c = db.getInt(1);
			 }
		 }finally
		 {
			 db.close();
		 }
		 return c;
	 }

	 public static int count(int node)throws SQLException
	 {
		 int i = 0;
	        DbAdapter db = new DbAdapter();
	        try
	        {
	            i = db.getInt("SELECT sum(npindex1) FROM NodePoll_2 WHERE node = "+node);
	        } finally
	        {
	            db.close();
	        }
	        return i;
	 }




	public int getNpindex1() throws SQLException {

		return npindex1;
	}
	public int getNpindex2() throws SQLException {

		return npindex2;
	}
	public int getNpindex3() throws SQLException {

		return npindex3;
	}
	public int getNpindex4() throws SQLException {

		return npindex4;
	}
	public int getNpindex5() throws SQLException {

		return npindex5;
	}
	public int getNpindex6() throws SQLException {

		return npindex6;
	}
	public boolean isExists() throws SQLException {

		return exists;
	}
	public String getIp()throws SQLException
	{
		return ip;
	}
	public Date getTimes()throws SQLException
	{
		return times;
	}


}
