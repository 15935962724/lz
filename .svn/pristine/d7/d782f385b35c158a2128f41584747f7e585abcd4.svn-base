package tea.entity.node;

import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class NodeAccessManage
{
	private static Cache _cache = new Cache(50);
	private String community;
	private String ip;
	private Date time;
	private boolean load;
	private boolean exists;
	private int hits; // 拦截次数

	public NodeAccessManage(String commonity, String ip)
	{
		this.community = commonity;
		this.ip = ip;
		load = false;
	}

	public void delete() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM NodeAccessManage WHERE community=" + DbAdapter.cite(community) + " AND ip=" + DbAdapter.cite(ip));
		} finally
		{
			db.close();
		}
		_cache.remove(community);
		_cache.remove(community + ":" + ip);
	}

	public static void deleteByCommunity(String community) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM NodeAccessManage WHERE community=" + DbAdapter.cite(community));
		} finally
		{
			db.close();
		}
		_cache.remove(community);
	}

	public static void create(String community, String ip) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO NodeAccessManage(community,ip,hits)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(ip) + ",0)");
		} finally
		{
			db.close();
		}
		_cache.remove(community);
		_cache.remove(community + ":" + ip);
	}

	private void loadBasic() throws SQLException
	{
		if (!load)
		{
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery("SELECT hits FROM NodeAccessManage WHERE community=" + DbAdapter.cite(community) + " AND ip=" + DbAdapter.cite(ip));
				if (db.next())
				{
					hits = db.getInt(1);
					exists = true;
				} else
				{
					exists = false;
				}
			} finally
			{
				db.close();
			}
			load = true;
		}
	}

	public static java.util.Enumeration findByCommunity(String community) throws SQLException
	{
		Vector vector = (Vector) _cache.get(community);
		if (vector == null)
		{
			vector = new Vector();
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery("SELECT ip FROM NodeAccessManage WHERE community=" + DbAdapter.cite(community));
				while (db.next())
				{
					String ip = db.getString(1);
					vector.addElement(ip);
				}
			} finally
			{
				db.close();
			}
			_cache.put(community, vector);
		}
		return vector.elements();
	}

	public static NodeAccessManage find(String commonity, String ip) throws SQLException
	{
		NodeAccessManage obj = (NodeAccessManage) _cache.get(commonity + ":" + ip);
		if (obj == null)
		{
			obj = new NodeAccessManage(commonity, ip);
			_cache.put(commonity + ":" + ip, obj);
		}
		return obj;
	}

	public String getCommunity()
	{
		return community;
	}

	public String getIp()
	{
		return ip;
	}

	public Date getTime() throws SQLException
	{
		loadBasic();
		return time;
	}

	public boolean isExists() throws SQLException
	{
		loadBasic();
		return exists;
	}

	public void setAccess(int hits) throws SQLException
	{
		if (hits % 10 == 0) // 减少写库的次数
		{
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeUpdate("UPDATE NodeAccessManage SET hits=" + hits + " WHERE community=" + DbAdapter.cite(community) + " AND ip=" + DbAdapter.cite(ip));
			} finally
			{
				db.close();
			}
		}
		this.hits = hits;
	}

	public int getAccess() throws SQLException
	{
		loadBasic();
		return hits;
	}
}
