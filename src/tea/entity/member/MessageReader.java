package tea.entity.member;

import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class MessageReader extends Entity
{
	public static final int MSGS_INBOX = 0;
	public static final int MSGS_TRASH = 4;
	public static final int MSGS_DELETED = 8;
	private int _nMessage;
	private RV _rv;
	private Date _time;
	private int _nStatus;

	private MessageReader(int i, RV rv, Date date)
	{
		_nMessage = i;
		_rv = rv;
		_time = date;
	}

	public static boolean isRead(int i) throws SQLException
	{
		boolean flag = false;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT message FROM MessageReader WHERE message=" + i);
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
			db.executeQuery("SELECT  message FROM MessageReader  WHERE message=" + i + " AND rmember<>" + DbAdapter.cite(rv._strR));
			flag = db.next();
		} finally
		{
			db.close();
		}
		return flag;
	}

	public static boolean isRead(int i, RV rv) throws SQLException
	{
		boolean flag = false;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT  message FROM MessageReader  WHERE message=" + i + " AND rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV));
			flag = db.next();
		} finally
		{
			db.close();
		}
		return flag;
	}

	public static void read(int i, RV rv) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT rmember FROM MessageReader WHERE message=" + i + "  AND rmember=" + DbAdapter.cite(rv._strR) + "  AND vmember=" + DbAdapter.cite(rv._strV));
			if (!db.next())
			{
				db.executeUpdate("INSERT INTO MessageReader(message, rmember, vmember,time)VALUES(" + i + ", " + DbAdapter.cite(rv._strR) + ", " + DbAdapter.cite(rv._strV) + "," + db.citeCurTime() + ")");
			}
		} finally
		{
			db.close();
		}
	}

	public Date getTime() throws SQLException
	{
		return _time;
	}

	public RV getReader() throws SQLException
	{
		return _rv;
	}

	public static int count(int i) throws SQLException
	{
		int j = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			j = db.getInt("SELECT COUNT(message) FROM MessageReader  WHERE message=" + i);
		} finally
		{
			db.close();
		}
		return j;
	}

	public static Enumeration find(int i, int j, int k) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT rmember, vmember, time FROM MessageReader  WHERE message=" + i + " ORDER BY time DESC ");
			for (int l = 0; l < j + k && db.next(); l++)
			{
				if (l >= j)
				{
					vector.addElement(new MessageReader(i, new RV(db.getString(1), db.getString(2)), db.getDate(3)));
				}
			}
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public static void trash(int i, RV rv) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE MessageReader SET status=4 WHERE rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV) + " AND message=" + i);
		} finally
		{
			db.close();
		}
	}

	public static void delete(int i, RV rv) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE MessageReader SET status=8 WHERE rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV) + " AND message=" + i);
		} finally
		{
			db.close();
		}
	}

	public static void trashAll(RV rv, String s) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			if (s.equals("Inbox"))
			{
				db.executeUpdate("UPDATE MessageReader SET status=4 WHERE rmember=" + DbAdapter.cite(rv._strR) + " AND status=" + 0);
			}
		} finally
		{
			db.close();
		}
	}

	public static void deleteAll(RV rv, String s) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			if (s.equals("Inbox"))
			{
				db.executeUpdate("UPDATE MessageReader SET status=8 WHERE rmember=" + DbAdapter.cite(rv._strR) + " AND status=" + 0);
			} else if (s.equals("Trash"))
			{
				db.executeUpdate("UPDATE MessageReader SET status=8 WHERE rmember=" + DbAdapter.cite(rv._strR) + " AND status=" + 4);
			}
		} finally
		{
			db.close();
		}
	}

	public static Date findTime(int i, RV rv) throws SQLException
	{
		Date date = null;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT time FROM MessageReader WHERE message=" + i + " AND rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV));
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
}
