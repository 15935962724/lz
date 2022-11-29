package tea.entity.node;

import java.math.BigDecimal;
import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class BidPrice extends Entity
{
	public void set(BigDecimal bigdecimal, BigDecimal bigdecimal1, BigDecimal bigdecimal2, BigDecimal bigdecimal3, BigDecimal bigdecimal4) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT node FROM BidPrice WHERE node=" + _nNode);
			if (db.next())
			{
				db.executeUpdate("UPDATE BidPrice  SET currency=" + _nCurrency + ",supply=" + bigdecimal + ",list=" + bigdecimal1 + ",ask=" + bigdecimal2 + ",reserve=" + bigdecimal3 + ",incre=" + bigdecimal4 + " WHERE node=" + _nNode);
			} else
			{
				db.executeUpdate("INSERT INTO BidPrice (node, currency, supply, list, ask, reserve, incre)VALUES (" + _nNode + ", " + _nCurrency + ", " + bigdecimal + ", " + bigdecimal1 + ", " + bigdecimal2 + ", " + bigdecimal3 + ", " + bigdecimal4 + ")");
			}
		} finally
		{
			db.close();
		}
		_bdSupply = bigdecimal;
		_bdList = bigdecimal1;
		_bdAsk = bigdecimal2;
		_bdReserve = bigdecimal3;
		_bdIncrement = bigdecimal4;
	}

	public BigDecimal getAsk() throws SQLException
	{
		load();
		return _bdAsk;
	}

	private BidPrice(int i, int j)
	{
		_nNode = i;
		_nCurrency = j;
		_blLoaded = false;
	}

	public static BidPrice create(int i, int j, BigDecimal bigdecimal, BigDecimal bigdecimal1, BigDecimal bigdecimal2, BigDecimal bigdecimal3, BigDecimal bigdecimal4) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			// db.executeUpdate("BidPriceCreate " + i + ", " + j + ", " + bigdecimal + ", " + bigdecimal1 + ", " + bigdecimal2 + ", " + bigdecimal3 + ", " + bigdecimal4);
			db.executeQuery("SELECT node FROM BidPrice WHERE node=" + i);
			if (db.next())
			{
				db.executeUpdate("UPDATE BidPrice  SET currency=" + j + ",supply=" + bigdecimal + ",list=" + bigdecimal1 + ",ask=" + bigdecimal2 + ",reserve=" + bigdecimal3 + ",incre=" + bigdecimal4 + " WHERE node=" + i);
			} else
			{
				db.executeUpdate("INSERT INTO BidPrice (node, currency, supply, list, ask, reserve, incre)VALUES (" + i + ", " + j + ", " + bigdecimal + ", " + bigdecimal1 + ", " + bigdecimal2 + ", " + bigdecimal3 + ", " + bigdecimal4 + ")");
			}
		} finally
		{
			db.close();
		}
		return find(i, j);
	}

	public BigDecimal getList() throws SQLException
	{
		load();
		return _bdList;
	}

	public BigDecimal getIncrement() throws SQLException
	{
		load();
		return _bdIncrement;
	}

	private void load() throws SQLException
	{
		if (!_blLoaded)
		{
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery("SELECT supply, list, ask, reserve, incre  FROM BidPrice  WHERE node=" + _nNode + " AND currency=" + _nCurrency);
				while (db.next())
				{
					_bdSupply = db.getBigDecimal(1, 2);
					_bdList = db.getBigDecimal(2, 2);
					_bdAsk = db.getBigDecimal(3, 2);
					_bdReserve = db.getBigDecimal(4, 2);
					_bdIncrement = db.getBigDecimal(5, 2);
				}
			} finally
			{
				db.close();
			}
			_blLoaded = true;
		}
	}

	public BigDecimal getReserve() throws SQLException
	{
		load();
		return _bdReserve;
	}

	public void delete() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM BidPrice  WHERE node=" + _nNode + " AND currency=" + _nCurrency);
		} finally
		{
			db.close();
		}
		_cache.remove(_nNode + ":" + _nCurrency);
	}

	public static BidPrice find(int i, int j)
	{
		BidPrice bidprice = (BidPrice) _cache.get(i + ":" + j);
		if (bidprice == null)
		{
			bidprice = new BidPrice(i, j);
			_cache.put(i + ":" + j, bidprice);
		}
		return bidprice;
	}

	public static Enumeration find(int i) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT currency FROM BidPrice WHERE node=" + i);
			for (; db.next(); vector.addElement(new Integer(db.getInt(1))))
			{
				;
			}
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public BigDecimal getSupply() throws SQLException
	{
		load();
		return _bdSupply;
	}

	private int _nNode;
	private int _nCurrency;
	private BigDecimal _bdSupply;
	private BigDecimal _bdList;
	private BigDecimal _bdAsk;
	private BigDecimal _bdReserve;
	private BigDecimal _bdIncrement;
	private boolean _blLoaded;
	private static Cache _cache = new Cache(100);
}
