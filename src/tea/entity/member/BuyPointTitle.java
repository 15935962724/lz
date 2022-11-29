package tea.entity.member;

import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class BuyPointTitle extends Entity
{

	private BuyPointTitle(int i)
	{
		_nBuyPointTitle = i;
		_blLoaded = false;
	}

	public static BuyPointTitle find(int i)
	{
		BuyPointTitle buypointtitle = (BuyPointTitle) _cache.get(new Integer(i));
		if (buypointtitle == null)
		{
			buypointtitle = new BuyPointTitle(i);
			_cache.put(new Integer(i), buypointtitle);
		}
		return buypointtitle;
	}

	public String getMember() throws SQLException
	{
		load();
		return _strMember;
	}

	public int getLanguage() throws SQLException
	{
		load();
		return _nLanguage;
	}

	public String getTitle() throws SQLException
	{
		load();
		return _strTitle;
	}

	public String getAccountTitle() throws SQLException
	{
		load();
		return _strAccountTitle;
	}

	public String getPasswordTitle() throws SQLException
	{
		load();
		return _strPasswordTitle;
	}

	public String getOtherIDTitle() throws SQLException
	{
		load();
		return _strOtherIDTitle;
	}

	private void load() throws SQLException
	{
		if (!_blLoaded)
		{
			DbAdapter dbadapter = new DbAdapter();
			try
			{
				dbadapter.executeQuery("SELECT member, language, title, accounttitle, passwordtitle, otheridtitle FROM BuyPointTitle WHERE buypointtitle=" + _nBuyPointTitle);
				if (dbadapter.next())
				{
					_strMember = dbadapter.getString(1);
					_nLanguage = dbadapter.getInt(2);
					_strTitle = dbadapter.getString(3);
					_strAccountTitle = dbadapter.getString(4);
					_strPasswordTitle = dbadapter.getString(5);
					_strOtherIDTitle = dbadapter.getString(6);
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

	public static int create(String s, int i, String s1, String s2, String s3, String s4) throws SQLException
	{
		int j = 0;
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate(" INSERT INTO BuyPointTitle  (member, language, title, accounttitle, passwordtitle, otheridtitle)  VALUES( " + DbAdapter.cite(s) + ", " + i + ", " + DbAdapter.cite(s1) + ", " + DbAdapter.cite(s2) + ", " + DbAdapter.cite(s3) + ", " + DbAdapter.cite(s4) + ")");
			j = dbadapter.getInt("SELECT @@IDENTITY");
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			dbadapter.close();
		}
		return j;
	}

	public static int find(String s, int i, String s1) throws SQLException
	{
		int j = 0;
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeQuery("SELECT buypointtitle FROM BuyPointTitle WHERE member=" + DbAdapter.cite(s) + " AND language=" + i + " AND title=" + DbAdapter.cite(s1));
			if (dbadapter.next())
				j = dbadapter.getInt(1);
		} catch (Exception _ex)
		{
		} finally
		{
			dbadapter.close();
		}
		return j;
	}

	public void set(String s, String s1, String s2, String s3) throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("UPDATE BuyPointTitle SET title=" + DbAdapter.cite(s) + ", " + " accounttitle=" + DbAdapter.cite(s1) + ", " + " passwordtitle=" + DbAdapter.cite(s2) + ", " + " otheridtitle=" + DbAdapter.cite(s3) + " WHERE buypointtitle=" + _nBuyPointTitle);
		} catch (Exception _ex)
		{
		} finally
		{
			dbadapter.close();
		}
		_blLoaded = false;
	}

	public void delete() throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("DELETE FROM BuyPointTitle WHERE buypointtitle=" + _nBuyPointTitle);
		} catch (Exception _ex)
		{
		} finally
		{
			dbadapter.close();
		}
		_cache.remove(new Integer(_nBuyPointTitle));
	}

	public static Enumeration find(String s) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeQuery("SELECT DISTINCT buypointtitle FROM BuyPointTitle WHERE member=" + DbAdapter.cite(s));
			for (; dbadapter.next(); vector.addElement(new Integer(dbadapter.getInt(1))))
				;
		} catch (Exception _ex)
		{
		} finally
		{
			dbadapter.close();
		}
		return vector.elements();
	}

	private int _nBuyPointTitle;
	private String _strMember;
	private int _nLanguage;
	private String _strTitle;
	private String _strAccountTitle;
	private String _strPasswordTitle;
	private String _strOtherIDTitle;
	private boolean _blLoaded;
	private static Cache _cache = new Cache(100);

}
