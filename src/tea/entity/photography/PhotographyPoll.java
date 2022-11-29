package tea.entity.photography;

import java.sql.SQLException;
import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Entity;



public class PhotographyPoll  extends Entity
{
	private static Cache _cache = new Cache(100);
	private int pollid;
	private int node;

	private String member;//投票用户

	private String ip;//
	private Date times;
	private String community;
	private boolean exists;

	public static PhotographyPoll find(int pollid) throws SQLException
	{
		PhotographyPoll obj = (PhotographyPoll) _cache.get(new Integer(pollid));
		if(obj == null)
		{
			obj = new PhotographyPoll(pollid);
			_cache.put(new Integer(pollid),obj);
		}
		return obj;
	}

	public PhotographyPoll(int pollid) throws SQLException
	{
		this.pollid = pollid;
		load();
	}

	private void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT node,member,ip,times,community FROM PhotographyPoll WHERE pollid=" + pollid);
			if(db.next())
			{
				node = db.getInt(1);
				member=db.getString(2);
				ip=db.getString(3);
				times=db.getDate(4);
				community=db.getString(5);
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

	public static void create(int node,String member,String ip,String community) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		Date times = new Date();
		try
		{
			db.executeUpdate("INSERT INTO PhotographyPoll(node,member,ip,times,community)VALUES("+node+","+db.cite(member)+","+db.cite(ip)+","+db.cite(times)+","+db.cite(community)+"  )");

		} finally
		{
			db.close();
		}
		 _cache.clear();
	}

	 public static Enumeration find(String community,int pos,int size) throws SQLException
	    {
	        Vector v = new Vector();
	        DbAdapter db = new DbAdapter();
	        try
	        {
	            db.executeQuery("SELECT pollid FROM PhotographyPoll WHERE community=" + DbAdapter.cite(community) ,pos,size);
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


	 public void delete() throws SQLException
	    {
	        DbAdapter db = new DbAdapter();
	        try
	        {
	            db.executeUpdate("DELETE FROM PhotographyPoll WHERE pollid=" + pollid);
	        } finally
	        {
	            db.close();
	        }
	        _cache.clear();

	    }


	 public static void delete(int node) throws SQLException
	    {
	        DbAdapter db = new DbAdapter();
	        try
	        {
	            db.executeUpdate("DELETE FROM PhotographyPoll WHERE node=" + node);
	        } finally
	        {
	            db.close();
	        }
	        _cache.clear();

	    }

	  public static int count(String community,String sql) throws SQLException
	    {
	        int i = 0;
	        DbAdapter db = new DbAdapter(1);
	        try
	        {
	            i = db.getInt("SELECT COUNT(pollid)  FROM PhotographyPoll  WHERE community="+db.cite(community)+sql);
	        } finally
	        {
	            db.close();
	        }
	        return i;
	    }

	public int getNode()
	{
		return node;
	}

	public String getMember()
	{
		return member;
	}

	public String getIp()
	{
		return ip;
	}

	public Date getTimes()
	{
		return times;
	}

	public String getCommunity()
	{
		return community;
	}

	public boolean isExists()
	{
		return exists;
	}





}
