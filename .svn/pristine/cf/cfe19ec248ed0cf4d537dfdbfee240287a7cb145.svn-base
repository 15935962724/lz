package tea.entity.site;

import java.math.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;
import java.io.*;
import java.sql.SQLException;

public class SMSEnterCode extends Entity
{
	private static Cache _cache = new Cache(100);
	private int code;
	private String community;
	private String password;
	private boolean exists;

	public SMSEnterCode(String community) throws SQLException
	{
		this.community = community;
		loadBasic();
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeQuery("SELECT code   ,password    FROM SMSEnterCode  WHERE community=" + DbAdapter.cite(community));
			if (dbadapter.next())
			{
				code = dbadapter.getInt(1);
				password = dbadapter.getString(2);
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

	public void delete() throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("DELETE FROM SMSEnterCode WHERE code=" + code);
		} finally
		{
			dbadapter.close();
		}
		_cache.remove(new Integer(code));
	}

	public void set(int code, String password) throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			if (exists)
			{
				dbadapter.executeUpdate("UPDATE SMSEnterCode SET code=" + (code) + ",password=" + DbAdapter.cite(password) + " WHERE community=" + DbAdapter.cite(community));
			} else
			{
				dbadapter.executeUpdate("INSERT INTO SMSEnterCode(community,code,password)VALUES(" + DbAdapter.cite(community) + "," + code + "," + DbAdapter.cite(password) + ")");
			}
		} finally
		{
			dbadapter.close();
		}
		this.exists = true;
		this.code = code;
		this.password = password;
		// _cache.remove(community);
	}

	public static SMSEnterCode find(String community) throws SQLException
	{
		SMSEnterCode obj = (SMSEnterCode) _cache.get(community);
		if (obj == null)
		{
			obj = new SMSEnterCode(community);
			_cache.put(community, obj);
		}
		return obj;
	}

	public int getCode()
	{
		return code;
	}

	public String getCommunity()
	{
		return community;
	}

	public String getPassword()
	{
		return password;
	}

	public int getBalance()
	{
		try
		{
			java.io.InputStream is = new java.net.URL("http://sms.redcome.com/servlet/GetBalance?fincode=" + code + "&password=" + password).openStream();
			StringBuilder sb = new StringBuilder();
			int value = 0;
			while ((value = is.read()) != -1)
			{
				sb.append((char) value);
			}
			is.close();
			return Integer.parseInt(sb.toString().trim());
		} catch (NumberFormatException ex)
		{
			return 0;
		} catch (IOException ex)
		{
			return 0;
		}
	}

	public boolean isExists()
	{
		return exists;
	}

}
