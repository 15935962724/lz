package tea.entity.node;

import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class AdedCounter extends Entity
{
	private AdedCounter(int i)
	{
		_nAded = i;
		_blLoaded = false;
	}

	public int getImpression() throws SQLException
	{
		load();
		return _nImpression;
	}

	private void load() throws SQLException
	{
		if (!_blLoaded)
		{
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery("SELECT impression, click  FROM AdedCounter  WHERE aded=" + _nAded);
				if (db.next())
				{
					_nImpression = db.getInt(1);
					_nClick = db.getInt(2);
				}
			} finally
			{
				db.close();
			}
			_blLoaded = true;
		}
	}

	public int getClick() throws SQLException
	{
		load();
		return _nClick;
	}

	/*
	 * CREATE PROCEDURE AdedClick @aded int
	 *
	 * AS IF EXISTS (SELECT aded FROM AdedCounter WHERE aded=@aded) UPDATE AdedCounter SET click=click+1 WHERE aded=@aded ELSE INSERT INTO AdedCounter(aded, click, impression) VALUES (@aded, 1, 0)
	 */
	public void click() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE AdedCounter SET click=click+1 WHERE aded=" + _nAded);
		} finally
		{
			db.close();
		}
		_nClick++;
	}

	public static AdedCounter find(int i)
	{
		AdedCounter adedcounter = (AdedCounter) _cache.get(new Integer(i));
		if (adedcounter == null)
		{
			adedcounter = new AdedCounter(i);
			_cache.put(new Integer(i), adedcounter);
		}
		return adedcounter;
	}

	public void impress() throws SQLException
	{

		DbAdapter db = new DbAdapter();
		try
		{
			//db.executeUpdate("AdedImpress " + _nAded);
			db.executeUpdate("UPDATE AdedCounter SET impression= "+(_nImpression+1)+" WHERE aded="+_nAded);
		} finally
		{
			db.close();
		}
		_nImpression++;

	}

	private int _nAded;
	private int _nImpression;
	private int _nClick;
	private boolean _blLoaded;
	private static Cache _cache = new Cache(100);
}
