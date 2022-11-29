package tea.entity.site;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class Communitytrial
{
	private static Cache _cache = new Cache(100);
	private String community;
	private int role;
	private int unit;
	private int daycount;
	private boolean exists;

	public static Communitytrial find(String community) throws SQLException
	{
		Communitytrial obj = (Communitytrial) _cache.get(community);
		if (obj == null)
		{
			obj = new Communitytrial(community);
			_cache.put(community, obj);
		}
		return obj;
	}

	public Communitytrial(String community) throws SQLException
	{
		this.community = community;
		load();
	}

	private void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT role,unit,daycount FROM communitytrial WHERE community=" + DbAdapter.cite(community));
			if (db.next())
			{
				role = db.getInt(1);
				unit = db.getInt(2);
				daycount = db.getInt(3);
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

	public void set(int role, int unit, int daycount) throws SQLException
	{
		int j = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			j = db.executeUpdate("UPDATE communitytrial SET role=" + role + ",unit=" + unit + ",daycount=" + daycount + " WHERE community= " + DbAdapter.cite(community));
		} finally
		{
			db.close();
		}
		this.exists = true;
		this.role = role;
		this.unit = unit;
		this.daycount = daycount;
		if (j < 1)
		{
			create(community, role, unit, daycount);
		}
	}

	public static void create(String community, int role, int unit, int daycount) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO communitytrial(community,role,unit,daycount)VALUES(" + DbAdapter.cite(community) + "," + role + "," + unit + "," + daycount + ")");
		} finally
		{
			db.close();
		}
		_cache.remove(community);
	}

	public String getCommunity()
	{
		return community;
	}

	public boolean isExists()
	{
		return exists;
	}

	public int getDaycount()
	{
		return daycount;
	}

	public int getRole()
	{
		return role;
	}

	public int getUnit()
	{
		return unit;
	}
}
