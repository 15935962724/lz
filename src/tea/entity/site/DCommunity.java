package tea.entity.site;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class DCommunity extends Entity
{
	private static Cache _cache = new Cache(100);
	private String community;
	private int node;
	private boolean exists;

	public DCommunity(String community) throws SQLException
	{
		this.community = community;
		loadBasic();
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeQuery("SELECT node FROM DCommunity WHERE community=" + DbAdapter.cite(community));
			if (dbadapter.next())
			{
				this.node = dbadapter.getInt(1);
				exists = true;
			} else
			{
				exists = false;
			}
		} finally
		{
			dbadapter.close();
		}
	}

	public static String create(String community, int node) throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("INSERT INTO DCommunity(community,node)VALUES(" + DbAdapter.cite(community) + "," + node + ")");
		} finally
		{
			dbadapter.close();
		}
		_cache.remove(community);
		return community;
	}

	public void set(int node) throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("UPDATE DCommunity SET node=" + node + " WHERE community=" + DbAdapter.cite(community));
		} finally
		{
			dbadapter.close();
		}
		this.node = node;
	}

	public static DCommunity find(String name) throws SQLException
	{
		DCommunity community = (DCommunity) _cache.get(name);
		if (community == null)
		{
			community = new DCommunity(name);
			_cache.put(name, community);
		}
		return community;
	}

	public String getCommunity()
	{
		return community;
	}

	public int getNode()
	{
		return node;
	}

	public boolean isExists()
	{
		return exists;
	}

}
