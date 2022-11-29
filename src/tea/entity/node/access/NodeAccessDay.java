package tea.entity.node.access;

import java.util.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;
import tea.db.ConnectionPool;
public class NodeAccessDay extends Entity
{
//	private static Cache _cache = new Cache(10);
	private String community;
	private Date time;
	private int pv[] = new int[31];
	private int ip[] = new int[31];
	private int sumPv;
	private int sumIp;
	private int maxPv;
	private int maxIp;
	public NodeAccessDay(String community) throws SQLException
	{
		this.community = community;
		load_community();
	}

	public NodeAccessDay(String community,Date time) throws SQLException
	{
		this.community = community;
		this.time = time;
		load();
	}

	
	public static int  getCountDay(int year,int month) throws SQLException
	{

	int k=31;
	if (month==0) month=12;
	if(month==4||month==6||month==9||month==11)k=30;
	else if(year%4==0&&month==2) k=29;
   else if (month==2)k=28;
	return k;
	}
	private void load() throws SQLException
	{
		Calendar c = Calendar.getInstance();
		c.setTime(time);
		c.add(Calendar.MONTH, -1);
		DbAdapter db = new DbAdapter(8);
		try
		{if (ConnectionPool._nType ==2)
			db.executeQuery("SELECT to_number(to_char(time,'dd'))-1 as day,pv,ip FROM NodeAccessDay WHERE community=" +
					DbAdapter.cite(community) + " AND time>" + DbAdapter.cite(c.getTime(),true) +
					" AND time<=" + DbAdapter.cite(time,true) + " ORDER BY time DESC");

	   	else 
	   		db.executeQuery("SELECT day(time)-1 as day,pv,ip FROM NodeAccessDay WHERE community=" +
					DbAdapter.cite(community) + " AND time>" + DbAdapter.cite(c.getTime(),true) +
					" AND time<=" + DbAdapter.cite(time,true) + " ORDER BY time DESC");
			while(db.next())
			{
				int day = db.getInt(1);
				pv[day] = db.getInt(2);
				ip[day] = db.getInt(3);
				sumPv += pv[day];
				sumIp += ip[day];
				if(maxPv < pv[day])
				{
					maxPv = pv[day];
				}
				if(maxIp < ip[day])
				{
					maxIp = ip[day];
				}
			}
		}
	catch(Exception e)
	{e.printStackTrace();
	}	finally
		{
			db.close();
		}
	}
	public static Enumeration<Integer> getYears(String community) throws SQLException
	{
		Vector<Integer> v = new Vector<Integer>();
		DbAdapter db = new DbAdapter(8);
		try
		{if (ConnectionPool._nType ==2)
			db.executeQuery("SELECT distinct to_number(to_char(time,'yyyy')) FROM NodeAccessDay WHERE community=" + DbAdapter.cite(community) + " ORDER BY to_char(time,'yyyy') DESC");
		else
			db.executeQuery("SELECT distinct year(time) FROM NodeAccessDay WHERE community=" + DbAdapter.cite(community) + " ORDER BY year(time) DESC");
	 	
			while(db.next())
			{
				v.add(db.getInt(1));
			}
		} finally
		{
			db.close();
		}
		return v.elements();
	}
	public static Enumeration<Integer> getMonths(String community,int year) throws SQLException
	{
		Vector<Integer> v = new Vector<Integer>();
		DbAdapter db = new DbAdapter(8);
		try
		{ if (ConnectionPool._nType ==2)
			db.executeQuery("SELECT distinct to_number(to_char(time,'MM')) FROM NodeAccessDay WHERE community=" + DbAdapter.cite(community) + " and  to_number(to_char(time,'yyyy'))="+year+" ORDER BY   to_char(time,'MM') DESC");
		else
			db.executeQuery("SELECT distinct month(time) FROM NodeAccessDay WHERE community=" + DbAdapter.cite(community) + " and year(time)="+year+" ORDER BY month(time) DESC");
			while(db.next())
			{
				v.add(db.getInt(1));
			}
		} finally
		{
			db.close();
		}
		return v.elements();
	}


	private void load_community() throws SQLException
	{
		DbAdapter db = new DbAdapter(8);
		try
		{ if (ConnectionPool._nType ==2)
		  db.executeQuery("SELECT to_number(to_char(time,'dd'))-1 as day,SUM(pv),SUM(ip) FROM NodeAccessDay WHERE community=" + DbAdapter.cite(community) + " GROUP BY to_number(to_char(time,'dd'))-1");
		else
			db.executeQuery("SELECT day(time)-1 as day,SUM(pv),SUM(ip) FROM NodeAccessDay WHERE community=" + DbAdapter.cite(community) + " GROUP BY day(time)-1");
			while(db.next())
			{
				int day = db.getInt(1);
				pv[day] = db.getInt(2);
				ip[day] = db.getInt(3);
				sumPv += pv[day];
				sumIp += ip[day];
				if(maxPv < pv[day])
				{
					maxPv = pv[day];
				}
				if(maxIp < ip[day])
				{
					maxIp = ip[day];
				}
			}
		} finally
		{
			db.close();
		}
	}

	

	public static NodeAccessDay find(String community,Date time) throws SQLException
	{
		return new NodeAccessDay(community,time);
	}

	public static NodeAccessDay find(String community) throws SQLException
	{
		return new NodeAccessDay(community);
	}

	public String getCommunity()
	{
		return community;
	}

	public int[] getPv()
	{
		return pv;
	}

	public int[] getIp()
	{
		return ip;
	}

	public int getSumIp()
	{
		return sumIp;
	}

	public int getSumPv()
	{
		return sumPv;
	}

	public int getMaxPv()
	{
		return maxPv;
	}

	public int getMaxIp()
	{
		return maxIp;
	}
}
