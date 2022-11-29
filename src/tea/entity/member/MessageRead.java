package tea.entity.member;

import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class MessageRead extends Entity
{

	private MessageRead(int i, RV rv, Date date)
	{
		_nMessage = i;
		_rv = rv;
		_time = date;
	}

	public static boolean isRead(int i, RV rv) throws SQLException
	{
		boolean flag = false;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT message FROM MessageRead WHERE message=" + i + " AND rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV));
			flag = db.next();
		} finally
		{
			db.close();
		}
		return flag;
	}

	public static boolean isRead(int i) throws SQLException
	{
		boolean flag = false;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT message FROM MessageRead WHERE message=" + i);
			flag = db.next();
		} finally
		{
			db.close();
		}
		return flag;
	}

	public static boolean isReadExcludeSender(int i, RV rv) throws SQLException
	{
		boolean flag = false;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT  message FROM MessageRead WHERE message=" + i + " AND rmember<>" + DbAdapter.cite(rv._strR));
			flag = db.next();
		} finally
		{
			db.close();
		}
		return flag;
	}

	public static int count(int i) throws SQLException
	{
		int j = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			j = db.getInt("SELECT COUNT(message) FROM MessageRead WHERE message=" + i);
		} finally
		{
			db.close();
		}
		return j;
	}

	public static void read(int i, RV rv) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT rmember FROM MessageRead	WHERE message=" + i + "  AND rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV));
			if (!db.next())
			{
				db.executeUpdate("INSERT INTO MessageRead(message, rmember, vmember,time)VALUES (" + i + ", " + DbAdapter.cite(rv._strR) + ", " + DbAdapter.cite(rv._strV) + ", " + DbAdapter.cite(new Date()) + ")");
			}
		} finally
		{
			db.close();
		}
	}

	public static Enumeration find(int i, int j, int k) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT rmember, vmember, time FROM MessageRead  WHERE message=" + i + " ORDER BY time DESC ");
			for (int l = 0; l < j + k && db.next(); l++)
			{
				if (l >= j)
				{
					vector.addElement(new MessageRead(i, new RV(db.getString(1), db.getString(2)), db.getDate(3)));
				}
			}
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public RV getReader() throws SQLException
	{
		return _rv;
	}

	public Date getTime() throws SQLException
	{
		return _time;
	}

	public static Date getTime(int i, RV rv) throws SQLException
	{
		Date date = null;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT time FROM MessageRead WHERE message=" + i + " AND rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV));
			if (db.next())
			{
				date = db.getDate(1);
			}
		} finally
		{
			db.close();
		}
		return date;
	}

	private int _nMessage;
	private RV _rv;
	private Date _time;
}
