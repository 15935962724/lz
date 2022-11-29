package tea.entity.node;

import java.sql.SQLException;
import java.math.*;
import java.util.*;
import tea.db.*;
import tea.entity.*;

public class Stock2 extends Entity
{
	public void set(String stockname, String estockname, float datedata, float openingprice, float high, float low, float closingprice, float percentchange, String graphWeek, String graphMonth, String graphYear, String graphYet) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			int j = db.executeUpdate("UPDATE Stock2 SET stockname=" + DbAdapter.cite(stockname) + ",estockname=" + DbAdapter.cite(estockname) + ",datedata=" + datedata + ",openingprice=" + openingprice + ",high=" + (high) + ",low=" + low + ",closingprice=" + closingprice + ",percentchange=" + percentchange + ",graphweek=" + DbAdapter.cite(graphWeek) + ",graphmonth=" + DbAdapter.cite(graphMonth) + ",graphyear=" + DbAdapter.cite(graphYear) + ",graphyet=" + DbAdapter.cite(graphYet)
					+ " WHERE node=" + _nNode);
			if (j < 1)
			{
				db.executeUpdate("INSERT INTO Stock2(node,stockname,estockname,datedata,openingprice,high,low,closingprice,percentchange,graphweek,graphmonth,graphyear,graphyet)VALUES(" + _nNode + "," + DbAdapter.cite(stockname) + "," + DbAdapter.cite(estockname) + "," + datedata + "," + openingprice + "," + (high) + "," + low + "," + closingprice + "," + percentchange + "," + DbAdapter.cite(graphWeek) + "," + DbAdapter.cite(graphMonth) + "," + DbAdapter.cite(graphYear) + ","
						+ DbAdapter.cite(graphYet) + ")");
			}
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(_nNode));
		_blLoaded = false;
	}

	private Stock2(int node)
	{
		_nNode = node;
		_blLoaded = false;
	}

	private void load() throws SQLException
	{
		if (!_blLoaded)
		{
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery("SELECT stockname    ,datedata     ,openingprice ,high         ,low          ,closingprice ,percentchange,graphweek    ,graphmonth   ,graphyear    ,graphyet,estockname      FROM Stock2 WHERE node=" + _nNode);
				if (db.next())
				{
					this.stockName = db.getVarchar(1, 1, 1);
					this._dbdatedata = db.getBigDecimal(2, 2);
					_bdOpen = db.getBigDecimal(3, 2);
					_bdHigh = db.getBigDecimal(4, 2);
					_bdLow = db.getBigDecimal(5, 2);
					this._bdclosingprice = db.getBigDecimal(6, 2);
					this._bdpercentchange = db.getBigDecimal(7, 2);
					this.graphWeek = db.getString(8);
					this.graphMonth = db.getString(9);
					this.graphYear = db.getString(10);
					this.graphYet = db.getString(11);
					estockName = db.getString(12);
				}
			} finally
			{
				db.close();
			}
			_blLoaded = true;
		}
	}

	public String getStockName(int language) throws SQLException
	{
		load();
		if (language == 1)
		{
			return stockName;
		} else
		{
			return estockName;
		}
	}

	public BigDecimal getHigh() throws SQLException
	{
		load();
		return _bdHigh;
	}

	public BigDecimal getOpen() throws SQLException
	{
		load();
		return _bdOpen;
	}

	public BigDecimal getChangePercent() throws SQLException
	{
		load();
		return _bdpercentchange;
	}

	public BigDecimal getLow() throws SQLException
	{
		load();
		return _bdLow;
	}

	public static int count() throws SQLException
	{
		int i = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			i = db.getInt("SELECT COUNT(symbol)  FROM Stock2 ");
		} finally
		{
			db.close();
		}
		return i;
	}

	public static Stock2 find(int node)
	{
		Stock2 stock = (Stock2) _cache.get(new Integer(node));
		if (stock == null)
		{
			stock = new Stock2(node);
			_cache.put(new Integer(node), stock);
		}
		return stock;
	}

	public static String find(int i, int j) throws SQLException
	{
		StringBuilder stringbuffer = new StringBuilder();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT symbol, suffix  FROM Stock2 ");
			for (int k = 0; k < i + j && db.next(); k++)
			{
				if (k >= i)
				{
					String s = db.getString(1);
					String s1 = db.getString(2);
					if (s.startsWith("^"))
					{
						stringbuffer.append(s);
					} else
					{
						stringbuffer.append(s + s1);
					}
					stringbuffer.append("+");
				}
			}
		} finally
		{
			db.close();
		}
		return stringbuffer.toString();
	}

	public static Enumeration find() throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT distinct(stockid) from stock");
			for (; db.next(); vector.addElement(db.getString(1)))
			{
				;
			}
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public static Vector find(String stockid, Date date1, Date date2) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT id from stock where stockid like '" + stockid + "' and date between  " + DbAdapter.cite(date1) + " and " + DbAdapter.cite(date2) + " order by date desc");
			for (; db.next(); vector.addElement(new Integer(db.getInt(1))))
			{
				;
			}
		} finally
		{
			db.close();
		}
		return vector;
	}

	public static int count_s(String stockid, Date date1, Date date2) throws SQLException
	{
		int c_s;
		DbAdapter db = new DbAdapter();
		try
		{
			c_s = db.getInt("SELECT count(id) from stock where stockid like '" + stockid + "' and date between  " + DbAdapter.cite(date1) + " and " + DbAdapter.cite(date2));
		} finally
		{
			db.close();
		}
		return c_s;
	}

	public String getGraphWeek() throws SQLException
	{
		load();
		return graphWeek;
	}

	public String getGraphMonth() throws SQLException
	{
		load();
		return graphMonth;
	}

	public String getGraphYear() throws SQLException
	{
		load();
		return graphYear;
	}

	public String getGraphYet() throws SQLException
	{
		load();
		return graphYet;
	}

	public String getStockName() throws SQLException
	{
		load();
		return stockName;
	}

	public BigDecimal getdatedata() throws SQLException
	{
		load();
		return _dbdatedata;
	}

	public BigDecimal getclosingprice() throws SQLException
	{
		load();
		return _bdclosingprice;
	}

	public BigDecimal getPercentchange() throws SQLException
	{
		load();
		return _bdpercentchange;
	}

	private int _nNode;
	private boolean _blLoaded;
	private static Cache _cache = new Cache(100);
	private String graphWeek;
	private String graphMonth;
	private String graphYear;
	private String graphYet;
	private String stockName;
	private BigDecimal _bdOpen; // 开盘价
	private BigDecimal _bdLow; // 最低价
	private BigDecimal _bdHigh; // 最高价
	private BigDecimal _dbdatedata; // 前收盘
	private BigDecimal _bdclosingprice; // 收盘价
	private BigDecimal _bdpercentchange; // 涨跌幅
	private String estockName;
}
