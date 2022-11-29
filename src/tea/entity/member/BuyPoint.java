package tea.entity.member;

import java.math.BigDecimal;
import java.util.Enumeration;
import java.util.Vector;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class BuyPoint extends Entity
{

	private BuyPoint(int i)
	{
		_nBuyPoint = i;
		_blLoaded = false;
	}

	public static BuyPoint find(int i)
	{
		BuyPoint buypoint = (BuyPoint) _cache.get(new Integer(i));
		if (buypoint == null)
		{
			buypoint = new BuyPoint(i);
			_cache.put(new Integer(i), buypoint);
		}
		return buypoint;
	}

	public int getCurrency() throws SQLException
	{
		load();
		return _nCurrency;
	}

	public boolean isVendor(RV rv) throws SQLException
	{
		load();
		return rv.equals(_vendor) || rv._strR.equals(_vendor._strR) && rv.isAccountant();
	}

	public boolean isCustomer(RV rv) throws SQLException
	{
		load();
		return rv.equals(_customer) || rv._strR.equals(_customer._strR) && (rv.isPurchaser() || rv.isAccountant());
	}

	public RV getVendor() throws SQLException
	{
		load();
		return _vendor;
	}

	public RV getCustomer() throws SQLException
	{
		load();
		return _customer;
	}

	public BigDecimal getCurrentPoint() throws SQLException
	{
		load();
		return _bdCurrentPoint;
	}

	public BigDecimal getUsedPoint() throws SQLException
	{
		load();
		return _bdUsedPoint;
	}

	private void load() throws SQLException
	{
		if (!_blLoaded)
		{
			DbAdapter dbadapter = new DbAdapter();
			try
			{
				dbadapter.executeQuery("SELECT rvendor, vvendor, rcustomer, vcustomer, currency, currentpoint, usedpoint FROM BuyPoint WHERE buypoint=" + _nBuyPoint);
				if (dbadapter.next())
				{
					_vendor = new RV(dbadapter.getString(1), dbadapter.getString(2));
					_customer = new RV(dbadapter.getString(3), dbadapter.getString(4));
					_nCurrency = dbadapter.getInt(5);
					_bdCurrentPoint = dbadapter.getBigDecimal(6, 2);
					_bdUsedPoint = dbadapter.getBigDecimal(7, 2);
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

	public static boolean isExisted(RV rv, RV rv1, int i) throws SQLException
	{
		boolean flag = false;
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeQuery("SELECT buypoint FROM BuyPoint WHERE rvendor=" + DbAdapter.cite(rv._strR) + " AND vvendor=" + DbAdapter.cite(rv._strV) + " AND rcustomer=" + DbAdapter.cite(rv1._strR) + " AND vcustomer=" + DbAdapter.cite(rv1._strV) + " AND currency=" + i);
			if (dbadapter.next())
			{
				flag = true;
			}
		} catch (Exception _ex)
		{
		} finally
		{
			dbadapter.close();
		}
		return flag;
	}

	public static int create(RV rv, RV rv1, int i, BigDecimal bigdecimal, BigDecimal bigdecimal1) throws SQLException
	{
		int j = 0;
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("INSERT INTO BuyPoint (rvendor, vvendor, rcustomer, vcustomer, currency, currentpoint, usedpoint)  VALUES( " + DbAdapter.cite(rv._strR) + ", " + DbAdapter.cite(rv._strV) + ", " + DbAdapter.cite(rv1._strR) + ", " + DbAdapter.cite(rv1._strV) + ", " + i + ", " + bigdecimal + ", " + bigdecimal1 + ")");
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

	public static int find(RV rv, RV rv1, int i) throws SQLException
	{
		int j = 0;
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeQuery("SELECT buypoint FROM BuyPoint WHERE rvendor=" + DbAdapter.cite(rv._strR) + " AND vvendor=" + DbAdapter.cite(rv._strV) + " AND rcustomer=" + DbAdapter.cite(rv1._strR) + " AND vcustomer=" + DbAdapter.cite(rv1._strV) + " AND currency=" + i);
			if (dbadapter.next())
			{
				j = dbadapter.getInt(1);
			}
		} catch (Exception _ex)
		{
		} finally
		{
			dbadapter.close();
		}
		return j;
	}

	public void set(BigDecimal bigdecimal) throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("UPDATE BuyPoint SET currentpoint=" + bigdecimal + " WHERE buypoint=" + _nBuyPoint);
		} catch (Exception _ex)
		{
		} finally
		{
			dbadapter.close();
		}
		_blLoaded = false;
	}

	public void set(BigDecimal bigdecimal, BigDecimal bigdecimal1) throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("UPDATE BuyPoint SET currentpoint=" + bigdecimal + ", " + " usedpoint=" + bigdecimal1 + " WHERE buypoint=" + _nBuyPoint);
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			dbadapter.close();
		}
		_blLoaded = false;
	}

	public static Enumeration findVendor(RV rv) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeQuery("SELECT DISTINCT rvendor, vvendor FROM BuyPoint WHERE rcustomer=" + DbAdapter.cite(rv._strR) + " AND vcustomer=" + DbAdapter.cite(rv._strV));
			for (; dbadapter.next(); vector.addElement(new RV(dbadapter.getString(1), dbadapter.getString(2))))
			{
				;
			}
		} catch (Exception _ex)
		{
		} finally
		{
			dbadapter.close();
		}
		return vector.elements();
	}

	public static Enumeration findCustomer(RV rv) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeQuery("SELECT DISTINCT rcustomer, vcustomer FROM BuyPoint WHERE rvendor=" + DbAdapter.cite(rv._strR) + " AND vvendor=" + DbAdapter.cite(rv._strV));
			for (; dbadapter.next(); vector.addElement(new RV(dbadapter.getString(1), dbadapter.getString(2))))
			{
				;
			}
		} catch (Exception _ex)
		{
		} finally
		{
			dbadapter.close();
		}
		return vector.elements();
	}

	public static Enumeration find(RV rv, RV rv1) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeQuery("SELECT buypoint FROM BuyPoint WHERE rvendor=" + DbAdapter.cite(rv._strR) + " AND vvendor=" + DbAdapter.cite(rv._strV) + " AND rcustomer=" + DbAdapter.cite(rv1._strR) + " AND vcustomer=" + DbAdapter.cite(rv1._strV));
			for (; dbadapter.next(); vector.addElement(new Integer(dbadapter.getInt(1))))
			{
				;
			}
		} catch (Exception _ex)
		{
		} finally
		{
			dbadapter.close();
		}
		return vector.elements();
	}

	private int _nBuyPoint;
	private RV _vendor;
	private RV _customer;
	private int _nCurrency;
	private BigDecimal _bdCurrentPoint;
	private BigDecimal _bdUsedPoint;
	private boolean _blLoaded;
	private static Cache _cache = new Cache(100);

}
