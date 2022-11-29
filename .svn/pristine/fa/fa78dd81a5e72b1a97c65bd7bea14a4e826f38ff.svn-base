package tea.entity.criterion;

import java.math.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class Outlay extends Entity
{
	private static Cache _cache = new Cache(100);
	// private static final java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-hh HH:mm");
	private int outlay;
	private String type;
	private java.math.BigDecimal money;
	private Date time;
	private String community;

	public Outlay(int outlay) throws SQLException
	{
		this.outlay = outlay;
		loadBasic();
	}

	public Outlay(int outlay, String type, BigDecimal money, java.util.Date time)
	{
		this.outlay = outlay;
		this.type = type;
		this.money = money;
		this.time = time;
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT  type,money  ,time,community	 FROM Outlay WHERE outlay=" + (outlay));
			if (db.next())
			{
				type = db.getString(1);
				money = db.getBigDecimal(2, 2);
				time = db.getDate(3);
				community = db.getString(4);
			}
		} finally
		{
			db.close();
		}
	}

	public void delete() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE Outlay WHERE outlay=" + outlay);
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(outlay));
	}

	public static void create(String type, BigDecimal money, Date time, String community) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO Outlay( type  , money,  time    ,community ) VALUES(" + DbAdapter.cite(type) + "," + (money) + "," + DbAdapter.cite(time) + "," + DbAdapter.cite(community) + ")");
		} finally
		{
			db.close();
		}
	}

	public void set(String type, BigDecimal money, Date time, String community) throws SQLException
	{
		time = new java.util.Date();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Outlay SET type=" + DbAdapter.cite(type) + "  , money=" + (money) + ",community=" + DbAdapter.cite(community) + "    ,time =" + DbAdapter.cite(time) + " WHERE outlay=" + outlay);
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(outlay));
	}

	public static java.util.Enumeration find(String community, String sql, int pos, int pageSize) throws SQLException
	{
		java.util.Vector vector = new java.util.Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT outlay FROM Outlay WHERE community=" + DbAdapter.cite(community) + sql);
			for (int l = 0; l < (pos + pageSize) && db.next(); l++)
			{
				if (l >= pos)
				{
					int outlay = db.getInt(1);
					vector.addElement(new Integer(outlay));
				}
			}
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public static Outlay find(int Outlay) throws SQLException
	{
		Outlay obj = (Outlay) _cache.get(new Integer(Outlay));
		if (obj == null)
		{
			obj = new Outlay(Outlay);
			_cache.put(new Integer(Outlay), obj);
		}
		return obj;
	}

	public Date getTime()
	{
		return time;
	}

	public BigDecimal getMoney()
	{
		return money;
	}

	public String getType()
	{
		return type;
	}

	public String getCommunity()
	{
		return community;
	}

	public String getTimeToString()
	{
		return sdf.format(time);
	}

	public static int countByCommunity(String community) throws SQLException
	{
		int j = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT COUNT(community) FROM Outlay WHERE community=" + DbAdapter.cite(community));
			if (db.next())
			{
				j = db.getInt(1);
			}
		} finally
		{
			db.close();
		}
		return j;
	}

	public static int clear(String community) throws SQLException
	{
		int count = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			count = db.executeUpdate("DELETE Outlay WHERE community=" + DbAdapter.cite(community));

		} finally
		{
			db.close();
		}
		_cache.clear();
		return count;
	}
}
