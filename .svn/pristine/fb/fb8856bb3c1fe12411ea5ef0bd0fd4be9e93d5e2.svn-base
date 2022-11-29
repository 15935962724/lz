package tea.entity.site;

import java.util.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class Communityim extends Entity
{
	private static Cache _cache = new Cache(100);
	private String community;
	private String dayfocus;
	private String report;

	private boolean exists;

	public static Communityim find(String community) throws SQLException
	{
		Communityim obj = (Communityim) _cache.get(community);
		if (obj == null)
		{
			obj = new Communityim(community);
			_cache.put(community, obj);
		}
		return obj;
	}

	public Communityim(String community) throws SQLException
	{
		this.community = community;
		load();
	}

	private void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT dayfocus,report FROM communityim WHERE community=" + DbAdapter.cite(community));
			if (db.next())
			{
				dayfocus = db.getString(1);
				report = db.getString(2);
				exists = true;
			} else
			{
				report = dayfocus = "http://www.redcome.com/";
				exists = false;
			}
		} finally
		{
			db.close();
		}
	}

	public void set(String dayfocus, String report) throws SQLException
	{
		int j = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			j = db.executeUpdate("UPDATE communityim SET dayfocus=" + DbAdapter.cite(dayfocus) + ",report=" + DbAdapter.cite(report) + " WHERE community=" + DbAdapter.cite(community));
		} finally
		{
			db.close();
		}
		if (j < 1)
		{
			exists = true;
			create(community, dayfocus, report);
		}
		this.dayfocus = dayfocus;
		this.report = report;
	}

	public static void create(String community, String dayfocus, String report) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO communityim(community,dayfocus,report)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(dayfocus) + "," + DbAdapter.cite(report) + ")");
		} finally
		{
			db.close();
		}
		_cache.remove(community);
	}

	public static Enumeration find(String sql, int pos, int pagesize) throws SQLException
	{
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT community FROM communityim WHERE 1=1" + sql);
			while (db.next())
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
			db.executeUpdate("DELETE FROM communityim WHERE community=" + DbAdapter.cite(community));
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

	public boolean isExists() throws SQLException
	{
		return exists;
	}

	public String getReport()
	{
		return report;
	}

	public String getDayfocus()
	{
		return dayfocus;
	}
}
