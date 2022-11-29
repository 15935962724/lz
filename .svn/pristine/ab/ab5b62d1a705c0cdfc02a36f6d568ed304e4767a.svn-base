package tea.entity.member;

import java.math.BigDecimal;
import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;
public class Shipping extends Entity
{
	class Layer
	{
		public String _strName;
		public String _strText;

		Layer()
		{
		}
	}

	public String getMember() throws SQLException
	{
		loadBasic();
		return _strMember;
	}

	public void set(int i, int j, BigDecimal bigdecimal, BigDecimal bigdecimal1, int k, String s, String s1, BigDecimal bigdecimal2) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			// db.executeUpdate("ShippingEdit " + _nShipping + ", " + i + ", " + j + ", " +
			// // bigdecimal + ", " + bigdecimal1 + ", " + k + ", " + DbAdapter.cite(s) + ", " +
			// DbAdapter.cite(s1) + ", " + bigdecimal2);
			db.executeUpdate("UPDATE Shipping	   SET currency=" + i + ",  options=" + j + ",   pershipment=" + bigdecimal + ",   peritem=" + bigdecimal1 + ",   taxrate=" + bigdecimal2 + " WHERE shipping=" + _nShipping);
			db.executeQuery("SELECT shipping	 FROM ShippingLayer		WHERE shipping=" + _nShipping + "  AND language=" + k);
			if (db.next())
			{
				db.executeUpdate("UPDATE ShippingLayer   SET name=" + DbAdapter.cite(s) + ",   text=" + DbAdapter.cite(s1) + "	 WHERE shipping=" + _nShipping + "  AND language=" + k);
			} else
			{
				db.executeUpdate("INSERT ShippingLayer(shipping, language, name, text)VALUES (" + _nShipping + ", " + k + ", " + DbAdapter.cite(s) + ", " + bigdecimal2 + ")");
			}
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			db.close();
		}
		_nCurrency = i;
		_nOptions = j;
		_bdPerShipment = bigdecimal;
		_bdPerItem = bigdecimal1;
		_bdTaxRate = bigdecimal2;
		_htLayer.clear();
	}

	public void set(int payMethod, String parameters) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Shipping  SET paymethod=" + payMethod + ", " + " parameters=" + DbAdapter.cite(parameters) + " WHERE shipping=" + _nShipping);
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			db.close();
		}
		_nPayMethod = payMethod;
		_strParameters = parameters;
	}

	public BigDecimal getPerShipment() throws SQLException
	{
		loadBasic();
		return _bdPerShipment;
	}

	public BigDecimal getPerItem() throws SQLException
	{
		loadBasic();
		return _bdPerItem;
	}

	public BigDecimal getTaxRate() throws SQLException
	{
		loadBasic();
		return _bdTaxRate;
	}

	private Shipping(int _nShipping)
	{
		this._nShipping = _nShipping;
		_blLoaded = false;
		_htLayer = new Hashtable();
	}

	public static int create(String community, String member, int currency, int options, BigDecimal pershipment, BigDecimal peritem, int language, String name, String text, BigDecimal taxrate) throws SQLException
	{
		int l = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO Shipping(community, member, currency, options, pershipment, peritem, taxrate)VALUES (" + DbAdapter.cite(community) + ", " + DbAdapter.cite(member) + ", " + currency + ", " + options + ", " + pershipment + ", " + peritem + ", " + language + ", " + DbAdapter.cite(name) + ", " + DbAdapter.cite(text) + ", " + taxrate + ")");
			l = db.getInt("SELECT MAX(shipping) FROM Shipping");
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			db.close();
		}
		return l;
	}

	public boolean isLayerExisted(int i) throws SQLException
	{
		boolean flag = false;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT shipping  FROM ShippingLayer  WHERE shipping=" + _nShipping + " AND language=" + i);
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

	public int getOptions() throws SQLException
	{
		loadBasic();
		return _nOptions;
	}

	public int getPayMethod() throws SQLException
	{
		loadBasic();
		return _nPayMethod;
	}

	private void loadBasic() throws SQLException
	{
		if (!_blLoaded)
		{
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery("SELECT community,member, currency, options, pershipment,  peritem, paymethod, parameters, taxrate   FROM Shipping  WHERE shipping=" + _nShipping);
				if (db.next())
				{
					_strCommunity = db.getString(1);
					_strMember = db.getString(2);
					_nCurrency = db.getInt(3);
					_nOptions = db.getInt(4);
					_bdPerShipment = db.getBigDecimal(5, 2);
					_bdPerItem = db.getBigDecimal(6, 2);
					_nPayMethod = db.getInt(7);
					_strParameters = db.getString(8);
					_bdTaxRate = db.getBigDecimal(9, 2);
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

	public String getName(int i) throws SQLException
	{
		return getLayer(i)._strName;
	}

	private Layer getLayer(int i) throws SQLException
	{
		Layer layer = (Layer) _htLayer.get(new Integer(i));
		if (layer == null)
		{
			layer = new Layer();
			int j = this.getLanguage(i);
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery(" SELECT name,text FROM ShippingLayer  WHERE shipping=" + _nShipping + " AND language=" + j);
				if (db.next())
				{
					layer._strName = db.getVarchar(j, i, 1);
					layer._strText = db.getText(j, i, 2);
				}
			} catch (Exception exception1)
			{
				throw new SQLException(exception1.toString());
			} finally
			{
				db.close();
			}
			_htLayer.put(new Integer(i), layer);
		}
		return layer;
	}

	private int getLanguage(int language) throws SQLException
	{
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT language FROM ShippingLayer WHERE shipping=" + _nShipping);
			while (db.next())
			{
				v.addElement(new Integer(db.getInt(1)));
			}} finally
		{
			db.close();
		}
		if (v.indexOf(new Integer(language)) != -1)
			return language;
		else
		{			if (language == 1)
			{
				if (v.indexOf(new Integer(2)) != -1)
					return 2;
			} else if (language == 2)
			{
				if (v.indexOf(new Integer(1)) != -1)
					return 1;
			}
			if (v.size() < 1)
				return 0;
		}
		return ((Integer) v.elementAt(0)).intValue();
	}

	public String getParameters() throws SQLException
	{
		loadBasic();
		return _strParameters;
	}

	public static int count(String community, String sql) throws SQLException
	{
		int i = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			i = db.getInt("SELECT COUNT(shipping)  FROM Shipping  WHERE community=" + DbAdapter.cite(community) + sql);
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			db.close();
		}
		return i;
	}

	public static Shipping find(int _nShipping)
	{
		Shipping shipping = (Shipping) _cache.get(new Integer(_nShipping));
		if (shipping == null)
		{
			shipping = new Shipping(_nShipping);
			_cache.put(new Integer(_nShipping), shipping);
		}
		return shipping;
	}

	public static Enumeration find(String community, String member, int currency, int options) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT shipping FROM Shipping WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member) + " AND currency=" + currency + " AND (options&" + options + ")<>0");
			for (; db.next(); vector.addElement(new Integer(db.getInt(1))))
			{
				;
			}
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public static Enumeration find(String community, String sql) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT shipping  FROM Shipping  WHERE community=" + DbAdapter.cite(community) + sql);
			for (; db.next(); vector.addElement(new Integer(db.getInt(1))))
			{
				;
			}
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public void delete(int i) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM ShippingLayer WHERE shipping=" + _nShipping + "  AND language=" + i);
			db.executeQuery("SELECT shipping FROM ShippingLayer WHERE shipping=" + _nShipping);
			if (!db.next())
			{
				db.executeUpdate("DELETE FROM Shipping WHERE shipping=" + _nShipping);
			}
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(_nShipping));
	}

	public String getText(int language) throws SQLException
	{
		return getLayer(language)._strText;
	}

	public int getCurrency() throws SQLException
	{
		loadBasic();
		return _nCurrency;
	}

	public String getCommunity()
	{
		return _strCommunity;
	}

	public static final String CURRENCY[] = { "US$", "RMB", "HK$", "NT$", "EURO", "JY", "CC" };
	public static final int CURRENCY_USD = 0;
	public static final int CURRENCY_RMB = 1;
	public static String PAYMETHOD[][] = { { "Offline", "ITransact" }, { "Offline", "CyberBJ" }, { "Offline", "Offline" }, { "Offline", "Offline" }, { "Offline", "Offline" }, { "Offline", "Offline" }, { "Offline", "Offline" } };
	public static int PAYMETHOD_OFFLINE;
	public static int PAYMETHOD_ITRANSACT = 1;
	public static int PAYMETHOD_CYBERBJ = 1;
	public static final int SHIPPINGO_ACCESS = 32768;
	public static final int SHIPPINGO_AD = 16384;
	public static final int SHIPPINGO_BUY = 8192;
	public static final int SHIPPINGO_BID = 4096;
	public static final int SHIPPINGO_BARGAIN = 2048;
	public static final int SHIPPINGO_PERCENTAGE = 2;
	public static final int SHIPPINGO_TAX = 1;
	private int _nShipping;
	private String _strMember;
	private int _nCurrency;
	private int _nOptions;
	private BigDecimal _bdPerShipment;
	private BigDecimal _bdPerItem;
	private int _nPayMethod;
	private String _strParameters;
	private BigDecimal _bdTaxRate;
	private boolean _blLoaded;
	private Hashtable _htLayer;
	private static Cache _cache = new Cache(100);
	private String _strCommunity;
}
