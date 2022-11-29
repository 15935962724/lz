package tea.entity.subscribe;

import java.sql.SQLException;
import java.util.Date;
import java.util.Enumeration;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.Entity;

public class ReadRight extends Entity{
	
	private int rrid;
	private int suoyou;//是否选择了所有页面//0 选择了页面，1 没有选中
	private String banci;//选中的版次
	
	private int qici_fanwei;//是绝对1，相对2 -期次范围
	private Date qc_timec;//开始绝对时间
	private String qc_2_timec;//开始相对时间
	
	private Date qc_timed;//结束绝对时间
	private String qc_2_timed;//结束相对时间
	
	private int yuedu_yxqi;//是绝对1，相对2 -阅读权限
	
	private Date yd_timec;//开始绝对时间
	private String yd_2_timec;//开始相对时间
	
	private Date yd_timed;//结束绝对时间
	private String yd_2_timed;//结束相对时间
	
	private int node;
	private int father;//父亲的id号
	private String type;//是策略 Tactics 是套餐 Subscribe
	
	private int rnum;//动态添加表格的id
	
	private int qici_suoyou;//所有期次
	private int yd_sheweiyoujiu;//设为永久
	
	private boolean exists;
	
	public final static String FANWEI_TYPE [] ={"---","绝对","相对"};
	
	public ReadRight(int rrid)throws SQLException
	{
		this.rrid = rrid;
		load();
	}
	public static ReadRight find(int rrid) throws SQLException
	{
		return new ReadRight(rrid);
	}

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT suoyou,banci,qici_fanwei,qc_timec,qc_2_timec,yuedu_yxqi,yd_timec,yd_2_timec,node,father,type,qc_timed,qc_2_timed,yd_timed,yd_2_timed,rnum," +
            		" qici_suoyou,yd_sheweiyoujiu FROM ReadRight  WHERE rrid =  " + rrid);
            if(db.next())
            {
            	suoyou=db.getInt(1);
            	banci=db.getString(2);
            	
            	qici_fanwei=db.getInt(3);
            	qc_timec=db.getDate(4);
            	qc_2_timec=db.getString(5);
            	
            	yuedu_yxqi=db.getInt(6);
            	yd_timec=db.getDate(7);
            	yd_2_timec=db.getString(8);
            	
                node = db.getInt(9);
                father=db.getInt(10);
                type=db.getString(11);
            	qc_timed=db.getDate(12);
            	qc_2_timed=db.getString(13);
            	yd_timed=db.getDate(14);
            	yd_2_timed=db.getString(15);
            	rnum=db.getInt(16);

            	qici_suoyou=db.getInt(17);
            	yd_sheweiyoujiu=db.getInt(18);
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
    public static int create(int suoyou,String banci,int qici_fanwei,Date qc_timec,String qc_2_timec,int yuedu_yxqi,Date yd_timec,String yd_2_timec,
    		int node,int father,String type,Date qc_timed,String qc_2_timed,Date yd_timed,String yd_2_timed,int rnum,int qici_suoyou,int yd_sheweiyoujiu) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int i = 0;
        try
        {
            db.executeUpdate("INSERT INTO ReadRight (suoyou,banci,qici_fanwei,qc_timec,qc_2_timec,yuedu_yxqi,yd_timec,yd_2_timec,node,father,type,qc_timed,qc_2_timed,yd_timed,yd_2_timed,rnum," +
            		"qici_suoyou,yd_sheweiyoujiu ) " +
                             " VALUES ("+(suoyou)+" , "+db.cite(banci)+","+qici_fanwei+","+db.cite(qc_timec)+","+db.cite(qc_2_timec)+","+yuedu_yxqi+","+db.cite(yd_timec)+" ,"+
                             " "+ db.cite(yd_2_timec)+","+node+","+father+","+db.cite(type)+","+db.cite(qc_timed)+","+db.cite(qc_2_timed)+" ,"+db.cite(yd_timed)+","+ db.cite(yd_2_timed)+","+rnum+" ," +
                             		" "+qici_suoyou+", "+yd_sheweiyoujiu+" )");
            i = db.getInt("SELECT MAX(rrid) FROM ReadRight");
        } finally
        {
            db.close();
        }
        return i;
    }

    public void set(int suoyou,String banci,int qici_fanwei,Date qc_timec,String qc_2_timec,int yuedu_yxqi,Date yd_timec,String yd_2_timec,
    		Date qc_timed,String qc_2_timed,Date yd_timed,String yd_2_timed,int rnum,int qici_suoyou,int yd_sheweiyoujiu) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE ReadRight SET suoyou =" + (suoyou) + ",banci=" + db.cite(banci) + ",qici_fanwei=" + qici_fanwei + " ,qc_timec =" + db.cite(qc_timec) + "," +
            		" qc_2_timec =" + db.cite(qc_2_timec) + ",yuedu_yxqi="+yuedu_yxqi+",yd_timec="+db.cite(yd_timec)+",yd_2_timec="+db.cite(yd_2_timec)+","+
            		" qc_timed =" + db.cite(qc_timed) + ",qc_2_timed =" + db.cite(qc_2_timed)+",yd_timed="+db.cite(yd_timed)+",yd_2_timed="+db.cite(yd_2_timed)+" ,rnum="+rnum+"," +
            				" qici_suoyou ="+qici_suoyou+",yd_sheweiyoujiu="+yd_sheweiyoujiu+" WHERE rrid=" + rrid);
        } finally
        {
            db.close();
        }
    }
    
    
    
    public static Enumeration find(String sql,int pos,int size)
    {
 	   Vector vector = new Vector();
 	   DbAdapter db = new DbAdapter();
 	   try
 	   {
 		   db.executeQuery("SELECT rrid FROM ReadRight WHERE 1=1 " + sql,pos,size);
 		   while(db.next())
 		   {
 			   vector.add(new Integer(db.getInt(1)));
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

    public static int getRRid(int node,int father,String type,int rnum)throws SQLException
    {
    	int rid = 0;
    	DbAdapter db = new DbAdapter();
    	try {
    		db.executeQuery("SELECT rrid FROM ReadRight WHERE node="+node+" AND  father="+father+" AND type= "+db.cite(type)+" AND rnum = "+rnum);
    		if(db.next())
    		{
    			rid = db.getInt(1);
    		}
		} finally
		{
			db.close();
		}
		return rid;
    }
    
    public static String getRnum(int node,int father,String type)throws SQLException
    {
    	String rid = "/";
    	DbAdapter db = new DbAdapter();
    	try {
    		db.executeQuery("SELECT rnum FROM ReadRight WHERE node="+node+" AND  father="+father+" AND type= "+db.cite(type));
    		while(db.next())
    		{
    			rid = rid +db.getString(1)+"/";
    		}
		} finally
		{
			db.close();
		}
		return rid;
    }
    
    public void delete() throws SQLException
	   {
	       DbAdapter db = new DbAdapter();
	       try
	       {
	           db.executeUpdate("DELETE FROM  ReadRight WHERE rrid = " + rrid);

	       } finally
	       {
	           db.close();
	       }
	   }
    public static void delete(int tid)throws SQLException
    {
    	DbAdapter db = new DbAdapter();
	       try
	       {
	           db.executeUpdate("DELETE FROM  ReadRight WHERE father = " + tid);

	       } finally
	       {
	           db.close();
	       }
    } 

	   public static int count(String sql) throws SQLException
	   {
	       int count = 0;
	       DbAdapter db = new DbAdapter();
	       try
	       {
	           db.executeQuery("SELECT COUNT(rrid) FROM ReadRight  WHERE 1=1 " + sql);
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
	public int getSuoyou() {
		return suoyou;
	}
	public String getBanci() {
		return banci;
	}
	public int getQici_fanwei() {
		return qici_fanwei;
	}
	
	public Date getQc_timec() {
		return qc_timec;
	}
	public String getQc_timecToString() 
	{
		if(qc_timec==null)
		{
			return "";
		}
		return sdf.format(qc_timec);
	}
	
	public String getQc_2_timec() {
		return qc_2_timec;
	}
	public int getYuedu_yxqi() {
		return yuedu_yxqi;
	}
	public Date getYd_timec() {
		return yd_timec;
	}
	
	public String getYd_timecToString() {
		if(yd_timec == null)
			return "";
		return sdf.format(yd_timec);
	}
	
	
	public String getYd_2_timec() {
		return yd_2_timec;
	}
	public int getNode() {
		return node;
	}
	public int getFather() {
		return father;
	}
	public String getType() {
		return type;
	}
	public boolean isExists() {
		return exists;
	}
	public Date getQc_timed() {
		return qc_timed;
	}
	
	public String getQc_timedToString() {
		if(qc_timed==null)
		   return "";
		return sdf.format(qc_timed);
	}
	public String getQc_2_timed() {
		return qc_2_timed;
	}
	public Date getYd_timed() {
		return yd_timed;
	}
	
	public String getYd_timedToString() {
		if(yd_timed == null)
		  return "";
		return sdf.format(yd_timed);
	}
	public String getYd_2_timed() {
		return yd_2_timed;
	}
    
    public int getRnum()
    {
    	return rnum; 
    }
       
    public int getQici_suoyou()
    {
    	return qici_suoyou;
    }
    public int getYd_sheweiyoujiu()
    {
    	return yd_sheweiyoujiu;
    }
    
    
    
    
    
    
    
    
}
