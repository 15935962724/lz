package tea.entity.site;

import tea.db.DbAdapter;
import tea.entity.*;
import java.util.*;
import java.sql.SQLException;

//特服号
public class SMSScode
{
	private static Cache _cache = new Cache(100);
	private String scode;
	private String pwd;
	private boolean exists;

	public SMSScode(String scode) throws SQLException
	{
		this.scode = scode;
		load();
	}

	private void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT pwd FROM SMSScode WHERE scode=" + DbAdapter.cite(scode));
			if (db.next())
			{
				pwd = db.getString(1);
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

	public static Enumeration find() throws SQLException
	{
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT scode FROM SMSScode ORDER BY scode");
			while (db.next())
			{
				v.add(db.getString(1));
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
			db.executeUpdate("DELETE FROM SMSScode WHERE scode=" + DbAdapter.cite(scode));
		} finally
		{
			db.close();
		}
		this.exists = false;
		_cache.remove(scode);
	}

	public void set(String pwd) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			if (exists)
			{
				db.executeUpdate("UPDATE SMSScode SET pwd=" + DbAdapter.cite(pwd) + " WHERE scode=" + DbAdapter.cite(scode));
			} else
			{
				db.executeUpdate("INSERT INTO SMSScode(scode,pwd)VALUES(" + DbAdapter.cite(scode) + "," + DbAdapter.cite(pwd) + ")");
			}
		} finally
		{
			db.close();
		}
		this.exists = true;
		this.pwd = pwd;
		_cache.remove(scode);
	}

	public static SMSScode find(String scode) throws SQLException
	{
		SMSScode obj = (SMSScode) _cache.get(scode);
		if (obj == null)
		{
			obj = new SMSScode(scode);
			_cache.put(scode, obj);
		}
		return obj;
	}

	public String getScode()
	{
		return scode;
	}

	public String getPwd()
	{
		return pwd;
	}

	public boolean isExists()
	{
		return exists;
	}
}
