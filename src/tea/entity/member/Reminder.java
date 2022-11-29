package tea.entity.member;

import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;
public class Reminder extends Entity
{

	private Reminder(int i)
	{
		_nReminder = i;
		_blLoaded = false;
	}

	public static Reminder find(int i)
	{
		Reminder reminder = (Reminder) _cache.get(new Integer(i));
		if (reminder == null)
		{
			reminder = new Reminder(i);
			_cache.put(new Integer(i), reminder);
		}
		return reminder;
	}

	public static boolean isExisted(RV rv, int i) throws SQLException
	{
		boolean flag = false;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT rmember, vmember, node FROM Reminder WHERE rmember=" + DbAdapter.cite(rv._strR) + " AND " + "vmember=" + DbAdapter.cite(rv._strV) + " AND " + "node=" + i);
			flag = db.next();
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			db.close();
		}
		return flag;
	}

	private void load() throws SQLException
	{
		if (!_blLoaded)
		{
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery("SELECT rmember, vmember, node, time, starttime, stoptime, deltatime, repeattimes, toemail, options, note, status FROM Reminder WHERE reminder=" + _nReminder);
				if (db.next())
				{
					_rv = new RV(db.getString(1), db.getString(2));
					_nNode = db.getInt(3);
					_time = db.getDate(4);
					_startTime = db.getDate(5);
					_stopTime = db.getDate(6);
					_nDeltaTime = db.getInt(7);
					_nRepeatTimes = db.getInt(8);
					_strToEmail = db.getString(9);
					_nOptions = db.getInt(10);
					_strNote = db.getString(11);
					_nStatus = db.getInt(12);
				}
			} catch (Exception exception1)
			{
				throw new SQLException(exception1.toString());
			} finally
			{
				db.close();
			}
			_blLoaded = true;
		}
	}

	public RV getRV() throws SQLException
	{
		load();
		return _rv;
	}

	public int getNode() throws SQLException
	{
		load();
		return _nNode;
	}

	public Date getTime() throws SQLException
	{
		load();
		return _time;
	}

	public Date getStartTime() throws SQLException
	{
		load();
		return _startTime;
	}

	public Date getStopTime() throws SQLException
	{
		load();
		return _stopTime;
	}

	public int getDeltaTime() throws SQLException
	{
		load();
		return _nDeltaTime;
	}

	public int getRepeatTimes() throws SQLException
	{
		load();
		return _nRepeatTimes;
	}

	public String getToEmail() throws SQLException
	{
		load();
		return _strToEmail;
	}

	public int getOptions() throws SQLException
	{
		load();
		return _nOptions;
	}

	public String getNote() throws SQLException
	{
		load();
		return _strNote;
	}

	public int getStatus() throws SQLException
	{
		load();
		return _nStatus;
	}

	public static Reminder create(RV rv, int i, Date date, Date date1, int j, int k, String s, int l, String s1) throws SQLException
	{
		int i1 = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO Reminder(rmember, vmember, node, starttime, stoptime, deltatime, repeattimes, toemail, options, note) VALUES(" + DbAdapter.cite(rv._strR) + ", " + DbAdapter.cite(rv._strV) + ", " + i + ", " + DbAdapter.cite(date) + ", " + DbAdapter.cite(date1) + ", " + j + ", " + k + ", " + DbAdapter.cite(s) + ", " + l + ", " + DbAdapter.cite(s1) + ") ");
			i1 = db.getInt("SELECT MAX(reminder) FROM Reminder");
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			db.close();
		}
		return find(i1);
	}

	public void set(RV rv, int i, Date date, Date date1, int j, int k, String s, int l, String s1, int i1) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			/*
			 * db.executeUpdate("ReminderEdit " + DbAdapter.cite(rv._strR) + ", " + DbAdapter.cite(rv._strV) + ", " + i + ", " + DbAdapter.cite(date) + ", " + DbAdapter.cite(date1) + ", " + j + ", " + k + ", " + DbAdapter.cite(s) + ", " + l + ", " + DbAdapter.cite(s1) + ", " + i1);
			 */
			db.executeQuery("SELECT rmember, vmember, node FROM Reminder WHERE rmember=" + DbAdapter.cite(rv._strR) + " AND  vmember=" + DbAdapter.cite(rv._strV) + " AND node=" + i);
			if (db.next())
			{
				db.executeUpdate("UPDATE Reminder   SET  starttime=" + DbAdapter.cite(date) + ",stoptime=" + DbAdapter.cite(date1) + ",deltatime=" + j + ",repeattimes=" + k + ",toemail=" + DbAdapter.cite(s) + ",options=" + l + ",note= " + DbAdapter.cite(s1) + ",status=" + i1 + "	WHERE rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV) + " AND node=" + i);
			} else
			{
				db.executeUpdate("INSERT INTO Reminder (rmember, vmember, node, starttime, stoptime, deltatime, repeattimes, toemail, options, note, status)VALUES (" + DbAdapter.cite(rv._strR) + ", " + DbAdapter.cite(rv._strV) + ", " + i + ", " + DbAdapter.cite(date) + ", " + DbAdapter.cite(date1) + ", " + j + ", " + k + ", " + DbAdapter.cite(s) + ", " + l + ", " + s1 + ", " + i1 + ")");
			}
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(_nReminder));
	}

	public void set(Date date, Date date1, int i, int j) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Reminder SET starttime=" + DbAdapter.cite(date) + ", stoptime=" + DbAdapter.cite(date1) + ", repeattimes=" + i + ", status=" + j + " WHERE reminder=" + _nReminder);
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(_nReminder));
	}

	public void set(int i) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Reminder SET status=" + i + " WHERE reminder=" + _nReminder);
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(_nReminder));
	}

	public static int count(RV rv) throws SQLException
	{
		int i = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			i = db.getInt("SELECT COUNT(reminder) FROM Reminder WHERE rmember=" + DbAdapter.cite(rv._strR) + " AND " + "vmember=" + DbAdapter.cite(rv._strV));
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			db.close();
		}
		return i;
	}

	public static Enumeration find(RV rv) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT reminder FROM Reminder WHERE rmember=" + DbAdapter.cite(rv._strR) + " AND " + "vmember=" + DbAdapter.cite(rv._strV));
			for (; db.next(); vector.addElement(new Integer(db.getInt(1))))
				;
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public static int find(RV rv, int i) throws SQLException
	{
		int j = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT reminder FROM Reminder WHERE rmember=" + DbAdapter.cite(rv._strR) + " AND " + "vmember=" + DbAdapter.cite(rv._strV) + " AND " + "node=" + i);
			if (db.next())
				j = db.getInt(1);
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			db.close();
		}
		return j;
	}

	public void delete() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM Reminder WHERE reminder=" + _nReminder);
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(_nReminder));
	}

	public static void deleteAll(RV rv) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM Reminder WHERE rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV));
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			db.close();
		}
		_cache.clear();
	}

	public static Enumeration find(RV rv, Date date) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT reminder FROM Reminder WHERE rmember=" + DbAdapter.cite(rv._strR) + " AND " + "vmember=" + DbAdapter.cite(rv._strV) + " AND " + "starttime<" + DbAdapter.cite(date) + " AND " + "stoptime>" + DbAdapter.cite(date));
			for (; db.next(); vector.addElement(new Integer(db.getInt(1))))
				;
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public static Enumeration findPast(RV rv, Date date) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT reminder FROM Reminder WHERE rmember=" + DbAdapter.cite(rv._strR) + " AND " + "vmember=" + DbAdapter.cite(rv._strV) + " AND " + "stoptime<" + DbAdapter.cite(date) + " AND " + "deltatime<>0" + " AND " + "repeattimes<>0");
			for (; db.next(); vector.addElement(new Integer(db.getInt(1))))
				;
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public static final int REMINDERO_VIAMESSAGE = 2;
	public static final int REMINDERO_VIAEMAIL = 4;
	public static final int REMINDER_MESSAGESENT = 2;
	public static final int REMINDER_EMAILSENT = 4;
	private int _nReminder;
	private RV _rv;
	private int _nNode;
	private Date _time;
	private Date _startTime;
	private Date _stopTime;
	private int _nDeltaTime;
	private int _nRepeatTimes;
	private String _strToEmail;
	private int _nOptions;
	private String _strNote;
	private boolean _blLoaded;
	private int _nStatus;
	private static Cache _cache = new Cache(100);

}
