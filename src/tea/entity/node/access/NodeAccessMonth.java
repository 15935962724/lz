package tea.entity.node.access;

import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.db.ConnectionPool;

public class NodeAccessMonth
{
	private static Cache _cache = new Cache(10);
	private String community;
	private Date time;
	private int pv[] = new int[12];
	private int ip[] = new int[12];
	private int sumPv;
	private int sumIp;
	private int maxPv;
	private int maxIp;
		public NodeAccessMonth(String commonity,Date time) throws SQLException
	{
		this.community = commonity;
		this.time = time;
	}

	public NodeAccessMonth(String community) throws SQLException
	{
		this.community = community;
		load_community();
	}


	private void load() throws SQLException
	{
	//	if(!_bLoad)
		{
			DbAdapter db = new DbAdapter(8);
			
			try
			{
				if(ConnectionPool._nType ==1)
				db.executeQuery("SELECT month(time)-1,pv,ip FROM NodeAccessMonth WHERE community=" + DbAdapter.cite(community)
								+ " AND datediff(month,time," + DbAdapter.cite(time) + ") between 0 and 11 ORDER BY time DESC");
				else if(ConnectionPool._nType ==0)
				{	
					db.executeQuery("SELECT month(time)-1,pv,ip FROM NodeAccessMonth WHERE community=" + DbAdapter.cite(community)
							+ " AND TO_DayS( NOW( ) ) - TO_DayS("+DbAdapter.cite(time) + ") <=365 ORDER BY time DESC");
				}else	if(ConnectionPool._nType ==2)
					db.executeQuery("SELECT to_number(to_char(time,'MM'))-1,pv,ip FROM NodeAccessMonth WHERE community=" + DbAdapter.cite(community)
							+ " AND floor(months_between(" + DbAdapter.cite(time) +",time )) between 0 and 11 ORDER BY time DESC");
			
					
				for(int i = 0;i < 12 && db.next();i++)
				{
					int month = db.getInt(1);
					pv[month] = db.getInt(2);
					ip[month] = db.getInt(3);
					sumPv += pv[month];
					sumIp += ip[month];
					if(maxPv < pv[month])
					{
						maxPv = pv[month];
					}
					if(maxIp < ip[month])
					{
						maxIp = ip[month];
					}
				}

           
			} finally
			{
				db.close(); 
			}
			//_bLoad = true;
		}
	}

	private void load_community() throws SQLException
	{
		DbAdapter db = new DbAdapter(8);
	
		try
		{	if(ConnectionPool._nType ==2)
			db.executeQuery("SELECT to_number(to_char(time,'MM'))-1,SUM(pv),SUM(ip) FROM NodeAccessMonth WHERE community=" + DbAdapter.cite(community) + " GROUP BY to_number(to_char(time,'MM'))-1");
		
		else
			db.executeQuery("SELECT month(time)-1,SUM(pv),SUM(ip) FROM NodeAccessMonth WHERE community=" + DbAdapter.cite(community) + " GROUP BY month(time)-1");
			while(db.next())
			{
				int month = db.getInt(1);
				pv[month] = db.getInt(2);
				ip[month] = db.getInt(3);
				sumPv += pv[month];
				sumIp += ip[month];
				if(maxPv < pv[month])
				{
					maxPv = pv[month];
				}
				if(maxIp < ip[month])
				{
					maxIp = ip[month];
				}
			}
      
		} finally
		{
			db.close();
		}
	}

	
	public static NodeAccessMonth find(String commonity,Date time) throws SQLException
	{
		Calendar c = Calendar.getInstance();
		c.setTime(time);
		c.set(5,1);
		c.set(11,0);
		c.set(12,0);
		c.set(13,0);
		c.set(14,0);
		time = c.getTime();
		NodeAccessMonth obj = (NodeAccessMonth) _cache.get(commonity + ":" + time);
		//if(obj == null)
		{
			obj = new NodeAccessMonth(commonity,time);
			_cache.put(commonity + ":" + time,obj);
		}
		return obj;
	}

	public static NodeAccessMonth find(String community) throws SQLException
	{
		NodeAccessMonth obj = new NodeAccessMonth(community);
		return obj;
	}

	public String getCommunity()
	{
		return community;
	}

	public int[] getPv() throws SQLException
	{
		//if(time != null)
		{
			load();
		}
		return pv;
	}

	public int getMaxPv() throws SQLException
	{
		//if(time != null)
		{
			load();
		}
		return maxPv;
	}

	public int[] getIp() throws SQLException
	{
		//if(time != null)
		{
			load();
		} 
		return ip;
	}

	public int getMaxIp() throws SQLException
	{
		//if(time != null)
		{
			load();
		}
		return maxIp;
	}

	public int getSumIp() throws SQLException
	{
		//if(time != null)
		{
			load();
		}
		return sumIp;
	}

	public int getSumPv() throws SQLException
	{
		//if(time != null)
		{
			load();
		}
		return sumPv;
	}
}
