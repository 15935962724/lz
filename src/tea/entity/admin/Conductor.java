package tea.entity.admin;

import tea.db.*;
import java.sql.SQLException;
import java.sql.SQLException;

public class Conductor
{
	private static tea.entity.Cache _cache = new tea.entity.Cache(100);
	private String member;
	private String community;
	private boolean sex;
	private String name;
	private String address;
	private String zone;
	private boolean exists;

	public Conductor(String member, String community) throws SQLException
	{
		this.member = member;
		this.community = community;
		load();
	}

	public static Conductor find(String member, String community) throws SQLException
	{
		Conductor obj = (Conductor) _cache.get(member + ":" + community);
		if (obj == null)
		{
			obj = new Conductor(member, community);
			_cache.put(member + ":" + community, obj);
		}
		return obj;
	}

	public void delete() throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("delete from Conductor where member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));} finally
		{
			dbadapter.close();
		}
		_cache.remove(member + ":" + community);
	}

	public void set(boolean sex, String name, String address, String zone) throws SQLException
	{
		if (exists)
		{
			DbAdapter dbadapter = new DbAdapter();
			try
			{
				dbadapter.executeUpdate("UPDATE Conductor SET " + "sex   =" + (sex ? "1" : "0") + "," + "name   =" + DbAdapter.cite(name) + "," + "address   =" + DbAdapter.cite(address) + "," + "zone   =" + DbAdapter.cite(zone) + " WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));} finally
			{
				dbadapter.close();
			}
			_cache.remove(member + ":" + community);
		} else
		{
			create(member, community, sex, name, address, zone);
		}
	}

	public static void create(String member, String community, boolean sex, String name, String address, String zone) throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("insert into Conductor(member,community,sex,name,address,zone) values (" + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(sex ? "1" : "0") + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(address) + "," + DbAdapter.cite(zone) + ")");} finally
		{
			dbadapter.close();
		}
		_cache.remove(member + ":" + community);
	}

	private void load() throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeQuery("SELECT sex,name,address,zone FROM Conductor WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
			if (dbadapter.next())
			{
				this.sex = dbadapter.getInt(1) != 0;
				name = dbadapter.getVarchar(1, 1, 2);
				address = dbadapter.getVarchar(1, 1, 3);
				zone = dbadapter.getString(4);
				this.exists = true;
			} else
			{
				this.exists = false;
			}
		}  finally
		{
			dbadapter.close();
		}
	}

	public static java.util.Enumeration findByCommunity(String community) throws SQLException
	{
		java.util.Vector vector = new java.util.Vector();
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeQuery("SELECT DISTINCT c.member FROM Conductor c,Profile p WHERE c.member=p.member AND c.community=p.community AND p.community=" + DbAdapter.cite(community));
			while (dbadapter.next())
			{
				vector.addElement(dbadapter.getString(1));
			}
	} finally
		{
			dbadapter.close();
		}
		return vector.elements();
	}

	public String getMember()
	{
		return member;
	}

	public String getCommunity()
	{
		return community;
	}

	public boolean isSex()
	{
		return sex;
	}

	public String getName()
	{
		return name;
	}

	public String getAddress()
	{
		return address;
	}

	public String getZone()
	{
		return zone;
	}

	public boolean isExists()
	{
		return exists;
	}
}
