package tea.entity.member;

import java.sql.SQLException;
import java.util.Date;
import java.util.Enumeration;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.Entity;

public class ProfileConsulting extends Entity {
	
	private int cid;
	private String text;// 记录
	private String community;
	private String member;//会员编号
	private Date times;
	private boolean loaded;
	
	
	public ProfileConsulting(int cid)throws SQLException
	{
		this.cid = cid;
		load();
	}
	public static ProfileConsulting find(int cid)throws SQLException
	{
		return new ProfileConsulting(cid);
	}
	
	public void load()throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("select text,community,member,times from ProfileConsulting where cid = "+cid);
			if(db.next())
			{
				text =db.getString(1);
				community=db.getString(2);
				member=db.getString(3);
				times =db.getDate(4);
				
				loaded=true;
			}else
			{
				loaded = false;
			}
		}finally
		{
			db.close();
		}
	}
	
	 public static void create(String text,String community,String member,Date times) throws SQLException
	    {
	        DbAdapter db = new DbAdapter();
	        try
	        {

	            db.executeUpdate("insert into ProfileConsulting(text,community,member,times) values(" + db.cite(text) + ", " + db.cite(community) + ", " + db.cite(member) + ", " + db.cite(times) + ")");
	            
	        } finally
	        {
	            db.close();
	        }
	    }

	 public static int count(String community,String sql) throws SQLException
	    {
	        int i = 0;
	        DbAdapter db = new DbAdapter();
	        try
	        {
	            i = db.getInt("SELECT COUNT(cid)  FROM ProfileConsulting  WHERE community ="+db.cite(community)+sql);
	        } finally
	        {
	            db.close();
	        }
	        return i;
	    }
	

	    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
	    {
	        Vector v = new Vector();
	        DbAdapter db = new DbAdapter(1);
	        try
	        {
	            db.executeQuery("SELECT cid FROM ProfileConsulting WHERE community="+db.cite(community)+sql,pos,size);
	            while(db.next())
	            {
	                v.addElement(db.getInt(1));
	            }
	        } finally
	        {
	            db.close();
	        }
	        return v.elements();
	    }
		public String getText() {
			return text;
		}
		public String getCommunity() {
			return community;
		}
		public String getMember() {
			return member;
		}
		public Date getTimes() {
			return times;
		}
		public boolean isLoaded() {
			return loaded;
		}
	    
	    
	
	

}
