package tea.entity.node;

import java.sql.SQLException;
import java.util.*;

import tea.db.DbAdapter;
import tea.entity.*;

public class TravelType
{
	private static Cache _cache = new Cache(100);
	private int id;
	private String community;
	private String name;
	private boolean exists;

	public TravelType(int id) throws SQLException
	{
		this.id = id;
		load();
	}

	public static TravelType find(int id) throws SQLException
	{
		TravelType obj = (TravelType) _cache.get(new Integer(id));
		if (obj == null)
		{
			obj = new TravelType(id);
			_cache.put(new Integer(id), obj);
		}
		return obj;
	}

	private void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT community,name FROM TravelType WHERE id=" + id);
			if (db.next())
			{
				community = db.getString(1);
				name = db.getString(2);
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

	public static Enumeration find(String community, String sql) throws SQLException
	{
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT id FROM TravelType WHERE community=" + DbAdapter.cite(community) + sql);
			while (db.next())
			{
				v.add(new Integer(db.getInt(1)));
			}
		} finally
		{
			db.close();
		}
		return v.elements();
	}

	public static void create(String community, String name) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO TravelType(community,name)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(name) + ")");
		} finally
		{
			db.close();
		}
	}

	public void set(String name) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE TravelType SET name=" + DbAdapter.cite(name) + " WHERE id=" + id);
		} finally
		{
			db.close();
		}
		this.name = name;
		this.exists = true;
	}

	public void delete() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM TravelType WHERE id=" + id);
		} finally
		{
			db.close();
		}
		exists = false;
		_cache.remove(new Integer(id));
	}

	public String getCommunity()
	{
		return community;
	}

	public boolean isExists()
	{
		return exists;
	}

	public int getId()
	{
		return id;
	}

	public String getName()
	{
		return name;
	}
}
