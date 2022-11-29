package tea.entity.node.access;

import tea.entity.*;
import tea.db.ConnectionPool;
import tea.db.DbAdapter;
import java.sql.SQLException;

public class NodeAccessHour
{
	private static Cache _cache = new Cache(100);
	private String community;
	private int[] count = new int[24];
	private int[] sum = new int[24];

	public NodeAccessHour(String commonity) throws SQLException
	{
		this.community = commonity;
		// count = new int[24];
		// sum = new int[24];
		load();
	}

	private void load() throws SQLException
	{
		int index;
		DbAdapter dbadapter = new DbAdapter(8);
		try
		{if(ConnectionPool._nType ==1)
		dbadapter.executeQuery("SELECT datepart(hh,time) as hour,sum(sum) FROM NodeAccessHour WHERE community=" +
		                DbAdapter.cite(community)+"and datediff(hour,time,getdate()) between 0 and 23 group by " +
					  "datepart(hh,time) order by datepart(hh,time)");
		else if(ConnectionPool._nType ==0)
		{ 
			dbadapter.executeQuery("SELECT hour(time) as hour,sum(sum) FROM NodeAccessHour WHERE community=" +
	                DbAdapter.cite(community)+
	                " and ( (TO_DayS(NOW())-TO_DayS(time)=0) or (TO_DayS(NOW())-TO_DayS(time)=1 and hour(time)>hour(now())))" +
	                " group by  hour(time) order by hour(time)");
		}else if(ConnectionPool._nType ==2)
			dbadapter.executeQuery("SELECT to_number(to_char(time,'hh24')) as hour,sum(sum) FROM NodeAccessHour WHERE community=" +
			                DbAdapter.cite(community)+"and floor((sysdate - time)*24) between 0 and 23 group by " +
						  " to_char(time,'hh24') order by to_char(time,'hh24')");
			while (dbadapter.next())
			{
				index = dbadapter.getInt(1);
			    count[index] = dbadapter.getInt(2);
				//sum[index] = dbadapter.getInt(2);
			}
			if(ConnectionPool._nType ==1)
			dbadapter.executeQuery("SELECT datepart(hh,time) as hour,sum(sum) FROM NodeAccessHour WHERE community=" +
						DbAdapter.cite(community)+" group by datepart(hh,time) order by datepart(hh,time)");
			else if(ConnectionPool._nType ==0)
			{	
				dbadapter.executeQuery("SELECT hour(time) as hour,sum(sum) FROM NodeAccessHour WHERE community=" +
						DbAdapter.cite(community)+" group by hour(time) order by hour(time)");
			
			}else if(ConnectionPool._nType ==2)
			dbadapter.executeQuery("SELECT to_number(to_char(time,'hh24')) as hour,sum(sum) FROM NodeAccessHour WHERE community=" +
						DbAdapter.cite(community)+" group by  to_number(to_char(time,'hh24')) order by  to_number(to_char(time,'hh24'))");
			
			while (dbadapter.next())
			{
				index = dbadapter.getInt(1);
				//count[index] = dbadapter.getInt(2);
				sum[index] = dbadapter.getInt(2);
			}


		} finally
		{
			dbadapter.close();
		}
	}


	public static NodeAccessHour find(String commonity) throws SQLException
	{
		//NodeAccessHour community = (NodeAccessHour) _cache.get(commonity);
		//if (community == null)
		//{
		NodeAccessHour 	community = new NodeAccessHour(commonity);
			_cache.put(commonity, community);
		//}
		return community;
	}

	public String getCommunity()
	{
		return community;
	}

	public int[] getCount()
	{
		return count;
	}

	public int getCountMax()
	{
		int max = count[0];
		for (int index = 1; index < count.length; index++)
		{
			if (max < count[index])
			{
				max = count[index];
			}
		}
		return max;
	}

	public int[] getSum()
	{
		return sum;
	}

	public int getSumMax()
	{
		int max = sum[0];
		for (int index = 1; index < sum.length; index++)
		{
			if (max < sum[index])
			{
				max = sum[index];
			}
		}
		return max;
	}
}
