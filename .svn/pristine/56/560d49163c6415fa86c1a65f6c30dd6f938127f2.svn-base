package tea.entity.member;

import java.util.Hashtable;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class Notification extends Entity
{

	private Notification(RV rv)
	{
		_rv = rv;
		_blLoaded = false;
	}

	public static Notification find(RV rv)
	{
		Notification notification = (Notification) _cache.get(rv);
		if (notification == null)
		{
			notification = new Notification(rv);
			_cache.put(rv, notification);
		}
		return notification;
	}

	public static Notification create(RV rv) throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		char c = '\377';
		try
		{
			// dbadapter.executeUpdate("NotificationCreate " + DbAdapter.cite(rv._strR) + "," +
			// " " + DbAdapter.cite(rv._strV) + ", " + (int) c);
			dbadapter.executeQuery("SELECT rmember, vmember FROM Notification WHERE rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV));
			if (dbadapter.next())
			{
			} else
			{
				dbadapter.executeUpdate("INSERT INTO Notification (rmember, vmember, options)VALUES (" + DbAdapter.cite(rv._strR) + ", " + DbAdapter.cite(rv._strV) + ", " + (int) c + ")");
			}
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			dbadapter.close();
		}
		return find(rv);
	}

	public void set(int i) throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			// dbadapter.executeUpdate("NotificationEdit " + DbAdapter.cite(_rv._strR) + ", " +
			// DbAdapter.cite(_rv._strV) + ", " + i);
			dbadapter.executeQuery("SELECT rmember, vmember FROM Notification WHERE rmember=" + DbAdapter.cite(_rv._strR) + " AND  vmember=" + DbAdapter.cite(_rv._strV));
			if (dbadapter.next())
			{
				dbadapter.executeUpdate("UPDATE Notification  SET options=" + DbAdapter.cite(_rv._strR) + "  WHERE rmember=" + DbAdapter.cite(_rv._strV) + " AND vmember=" + i);
			} else
			{
				dbadapter.executeUpdate("INSERT INTO Notification (rmember, vmember, options)	VALUES (" + DbAdapter.cite(_rv._strR) + ", " + DbAdapter.cite(_rv._strV) + ", " + i + ")");
			}
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			dbadapter.close();
		}
		_cache.remove(_rv);
	}

	private void load() throws SQLException
	{
		if (!_blLoaded)
		{
			DbAdapter dbadapter = new DbAdapter();
			try
			{
				dbadapter.executeQuery("SELECT options FROM Notification WHERE rmember=" + DbAdapter.cite(_rv._strR) + " AND " + "vmember=" + DbAdapter.cite(_rv._strV));
				if (dbadapter.next())
				{
					_nOptions = dbadapter.getInt(1);
				}
			} catch (Exception exception1)
			{
				throw new SQLException(exception1.toString());
			} finally
			{
				dbadapter.close();
			}
			_blLoaded = true;
		}
	}

	public int getOptions() throws SQLException
	{
		load();
		return _nOptions;
	}

	public boolean isExisted(RV rv) throws SQLException
	{
		boolean flag = false;
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeQuery("SELECT rmember, vmember FROM Notification WHERE rmember=" + DbAdapter.cite(rv._strR) + " AND " + "vmember=" + DbAdapter.cite(rv._strV));
			flag = dbadapter.next();
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			dbadapter.close();
		}
		return flag;
	}

	public static final int NOTIFICATIONO_SHOWNEWMESSAGE = 2;
	public static final int NOTIFICATIONO_SHOWNEWSALESORDER = 4;
	public static final int NOTIFICATIONO_SHOWNEWPURCHASEORDER = 8;
	public static final int NOTIFICATIONO_SHOWREQUEST = 16;
	public static final int NOTIFICATIONO_SHOWREMINDER = 32;
	private RV _rv;
	private int _nOptions;
	private boolean _blLoaded;
	private static Cache _cache = new Cache(100);

}
