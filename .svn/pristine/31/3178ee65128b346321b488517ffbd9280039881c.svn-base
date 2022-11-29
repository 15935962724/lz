package tea.entity.member;

import java.sql.SQLException;
import java.math.BigDecimal;
import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;

public class BuyPointConvert extends Entity
{

	private BuyPointConvert(int i)
	{
		_nBuyPointConvert = i;
		_blLoaded = false;
	}

	public static BuyPointConvert find(int i)
	{
		BuyPointConvert buypointconvert = (BuyPointConvert) _cache.get(new Integer(i));
		if (buypointconvert == null)
		{
			buypointconvert = new BuyPointConvert(i);
			_cache.put(new Integer(i), buypointconvert);
		}
		return buypointconvert;
	}

	public String getAccount() throws SQLException
	{
		load();
		return _strAccount;
	}

	public String getPassword() throws SQLException
	{
		load();
		return _strPassword;
	}

	public String getOtherID() throws SQLException
	{
		load();
		return _strOtherID;
	}

	public int getCurrency() throws SQLException
	{
		load();
		return _nCurrency;
	}

	public BigDecimal getAmount() throws SQLException
	{
		load();
		return _bdAmount;
	}

	public int getStatus() throws SQLException
	{
		load();
		return _nStatus;
	}

	public int getConvertCurrency() throws SQLException
	{
		load();
		return _nConvertCurrency;
	}

	public BigDecimal getConvertPoint() throws SQLException
	{
		load();
		return _bdConvertPoint;
	}

	public BigDecimal getConvertedPoint() throws SQLException
	{
		load();
		return _bdConvertedPoint;
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

	public Date getTime() throws SQLException
	{
		load();
		return _time;
	}

	private void load() throws SQLException
	{
		if (!_blLoaded)
		{
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery("SELECT account, password, otherid, currency, amount, status, convertcurrency, convertpoint, convertedpoint, rvendor, vvendor, rcustomer, vcustomer, time FROM BuyPointConvert WHERE buypointconvert=" + _nBuyPointConvert);
				if (db.next())
				{
					_strAccount = db.getString(1);
					_strPassword = db.getString(2);
					_strOtherID = db.getString(3);
					_nCurrency = db.getInt(4);
					_bdAmount = db.getBigDecimal(5, 2);
					_nStatus = db.getInt(6);
					_nConvertCurrency = db.getInt(7);
					_bdConvertPoint = db.getBigDecimal(8, 2);
					_bdConvertedPoint = db.getBigDecimal(9, 2);
					_vendor = new RV(db.getString(10), db.getString(11));
					_customer = new RV(db.getString(12), db.getString(13));
					_time = db.getDate(14);
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

	public static int create(String s, String s1, String s2, int i, BigDecimal bigdecimal, int j, BigDecimal bigdecimal1, RV rv, Date date) throws SQLException
	{
		int k = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate(" INSERT INTO BuyPointConvert  (account, password, otherid, currency, amount, convertcurrency, convertpoint, rvendor, vvendor, time)  VALUES( " + DbAdapter.cite(s) + ", " + DbAdapter.cite(s1) + ", " + DbAdapter.cite(s2) + ", " + i + ", " + bigdecimal + ", " + j + ", " + bigdecimal1 + ", " + DbAdapter.cite(rv._strR) + ", " + DbAdapter.cite(rv._strV) + ", " + DbAdapter.cite(date) + ")");
			k = db.getInt("SELECT @@IDENTITY");
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			db.close();
		}
		return k;
	}

	public static boolean isExisted(String s, String s1, String s2, RV rv) throws SQLException
	{
		boolean flag = false;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT buypointconvert FROM BuyPointConvert WHERE account=" + DbAdapter.cite(s) + " AND password=" + DbAdapter.cite(s1) + " AND otherid=" + DbAdapter.cite(s2) + " AND rvendor=" + DbAdapter.cite(rv._strR) + " AND vvendor=" + DbAdapter.cite(rv._strV));
			if (db.next())
				flag = true;
		} catch (Exception _ex)
		{
		} finally
		{
			db.close();
		}
		return flag;
	}

	public static int find(String s, String s1, String s2, RV rv) throws SQLException
	{
		int i = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT buypointconvert FROM BuyPointConvert WHERE account=" + DbAdapter.cite(s) + " AND password=" + DbAdapter.cite(s1) + " AND otherid=" + DbAdapter.cite(s2) + " AND rvendor=" + DbAdapter.cite(rv._strR) + " AND vvendor=" + DbAdapter.cite(rv._strV));
			if (db.next())
				i = db.getInt(1);
		} catch (Exception _ex)
		{
		} finally
		{
			db.close();
		}
		return i;
	}

	public void set(int i, BigDecimal bigdecimal, RV rv) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE BuyPointConvert SET status=" + i + ", " + " convertedpoint=" + bigdecimal + ", " + " rcustomer=" + DbAdapter.cite(rv._strR) + ", " + " vcustomer=" + DbAdapter.cite(rv._strV) + " WHERE buypointconvert=" + _nBuyPointConvert);
		} catch (Exception _ex)
		{
		} finally
		{
			db.close();
		}
		_blLoaded = false;
	}

	public static Enumeration findVendor(RV rv) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT DISTINCT rvendor, vvendor FROM BuyPointConvert WHERE rcustomer=" + DbAdapter.cite(rv._strR) + " AND vcustomer=" + DbAdapter.cite(rv._strV));
			for (; db.next(); vector.addElement(new RV(db.getString(1), db.getString(2))))
				;
		} catch (Exception _ex)
		{
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public static Enumeration findCustomer(RV rv) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT DISTINCT rcustomer, vcustomer FROM BuyPointConvert WHERE rvendor=" + DbAdapter.cite(rv._strR) + " AND vvendor=" + DbAdapter.cite(rv._strV));
			for (; db.next(); vector.addElement(new RV(db.getString(1), db.getString(2))))
				;
		} catch (Exception _ex)
		{
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public static Enumeration find(RV rv, RV rv1) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT buypointconvert FROM BuyPointConvert WHERE rvendor=" + DbAdapter.cite(rv._strR) + " AND vvendor=" + DbAdapter.cite(rv._strV) + " AND rcustomer=" + DbAdapter.cite(rv1._strR) + " AND vcustomer=" + DbAdapter.cite(rv1._strV));
			for (; db.next(); vector.addElement(new Integer(db.getInt(1))))
				;
		} catch (Exception _ex)
		{
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	private int _nBuyPointConvert;
	private String _strAccount;
	private String _strPassword;
	private String _strOtherID;
	private int _nCurrency;
	private BigDecimal _bdAmount;
	private int _nStatus;
	private int _nConvertCurrency;
	private BigDecimal _bdConvertPoint;
	private BigDecimal _bdConvertedPoint;
	private RV _vendor;
	private RV _customer;
	private Date _time;
	private boolean _blLoaded;
	private static Cache _cache = new Cache(100);

}
