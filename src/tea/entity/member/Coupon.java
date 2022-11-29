package tea.entity.member;

import java.math.BigDecimal;
import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

//优惠卷
public class Coupon extends Entity
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

	public void set(int i, int j, int k, BigDecimal bigdecimal, BigDecimal bigdecimal1, String s, int l, String s1, String s2, String memberx, java.math.BigDecimal bank) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			// db.executeUpdate("CouponEdit " + _nCoupon + ", " + i + ", " + j + ", " + k + ", " +
			// "" + bigdecimal + ", " + bigdecimal1 + ", " + DbAdapter.cite(s) + ", " + l + "," +
			// " " + DbAdapter.cite(s1) + ", " + DbAdapter.cite(s2) + "," + DbAdapter.cite(memberx)
			// + "," + bank);
			db.executeUpdate("UPDATE Coupon  SET currency=" + i + ", type=" + j + ", options=" + k + ", minimum=" + bigdecimal1 + ",discount=" + bigdecimal1 + ",code=" + DbAdapter.cite(s) + ",memberx=" + DbAdapter.cite(memberx) + ", bank=" + bank + " WHERE coupon=" + _nCoupon);
			db.executeQuery("SELECT coupon FROM CouponLayer	WHERE coupon=" + _nCoupon + "  AND language=" + l);
			if (db.next())
			{
				db.executeUpdate("UPDATE CouponLayer  SET name=" + DbAdapter.cite(s1) + ",  text=" + DbAdapter.cite(s2) + " WHERE coupon=" + _nCoupon + "   AND language=" + l);
			} else
			{
				db.executeUpdate("INSERT CouponLayer(coupon, language, name, text)VALUES (" + _nCoupon + ", " + l + ", " + DbAdapter.cite(s1) + ", " + DbAdapter.cite(s2) + ")");
			}
		} finally
		{
			db.close();
		}
		_nCurrency = i;
		_nType = j;
		_bdMinimum = bigdecimal;
		_bdDiscount = bigdecimal1;
		_strCode = s;
		this.memberx = memberx;
		this.bank = bank;
		_htLayer.clear();
	}

	public BigDecimal getMinimum() throws SQLException
	{
		loadBasic();
		return _bdMinimum;
	}

	private Coupon(int _nCoupon)
	{
		this._nCoupon = _nCoupon;
		_blLoaded = false;
		_htLayer = new Hashtable();
	}

	public static void create(String community, String member, int currency, int type, int options, BigDecimal bigdecimal, BigDecimal bigdecimal1, String s1, int l, String s2, String s3, String memberx, java.math.BigDecimal bank) throws SQLException
	{
		int k = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO Coupon(community,member, currency, type, options, minimum, discount, code,memberx,bank) VALUES (" + DbAdapter.cite(community) + "," + DbAdapter.cite(member) + ", " + currency + ", " + type + ", " + options + ", " + bigdecimal + ", " + bigdecimal1 + ", " + DbAdapter.cite(s1) + "," + DbAdapter.cite(memberx) + "," + bank + ")");
			k = db.getInt("SELECT MAX(coupon) FROM Coupon");
			db.executeUpdate("INSERT INTO CouponLayer(coupon, language, name, text) values(" + k + ", " + l + ", " + DbAdapter.cite(s2) + ", " + DbAdapter.cite(s3) + ")");
		} finally
		{
			db.close();
		}
	}

	public boolean isLayerExisted(int i) throws SQLException
	{
		boolean flag = false;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT coupon  FROM CouponLayer  WHERE coupon=" + _nCoupon + " AND language=" + i);
			flag = db.next();
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

	private void loadBasic() throws SQLException
	{
		if (!_blLoaded)
		{
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery("SELECT community,member, currency, type, options, minimum, discount, code,memberx,bank  FROM Coupon  WHERE coupon=" + _nCoupon);
				if (db.next())
				{
					_strCommunity = db.getString(1);
					_strMember = db.getString(2);
					_nCurrency = db.getInt(3);
					_nType = db.getInt(4);
					_nOptions = db.getInt(5);
					_bdMinimum = db.getBigDecimal(6, 2);
					_bdDiscount = db.getBigDecimal(7, 2);
					_strCode = db.getString(8);
					memberx = db.getString(9);
					bank = db.getBigDecimal(10, 4);
				}
			} finally
			{
				db.close();
			}
			_blLoaded = true;
		}
	}

	public BigDecimal getDiscount() throws SQLException
	{
		loadBasic();
		return _bdDiscount;
	}

	public int getType() throws SQLException
	{
		loadBasic();
		return _nType;
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
				db.executeQuery("SELECT name,text FROM CouponLayer WHERE coupon=" + _nCoupon + " AND language=" + j);
				if (db.next())
				{
					layer._strName = db.getVarchar(j, i, 1);
					layer._strText = db.getText(j, i, 2);
				}
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
			db.executeQuery("SELECT language FROM CouponLayer WHERE coupon=" + _nCoupon);
			while (db.next())
			{
				v.addElement(new Integer(db.getInt(1)));
			}
		} finally
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

	public static int count(String community, String sql) throws SQLException
	{
		int i = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			i = db.getInt("SELECT COUNT(coupon)  FROM Coupon  WHERE community=" + DbAdapter.cite(community) + sql);
		} finally
		{
			db.close();
		}
		return i;
	}

	public static Coupon find(int _nCoupon)
	{
		Coupon coupon = (Coupon) _cache.get(new Integer(_nCoupon));
		if (coupon == null)
		{
			coupon = new Coupon(_nCoupon);
			_cache.put(new Integer(_nCoupon), coupon);
		}
		return coupon;
	}

	public static Enumeration find(String community, String sql) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT coupon  FROM Coupon WHERE community=" + DbAdapter.cite(community) + sql);
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

	public static int find(String community, String member, int currency, int options, String code) throws SQLException
	{
		int k = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			k = db.getInt("SELECT coupon  FROM Coupon WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member) + " AND currency=" + currency + " AND (options&" + options + ")<>0" + " AND code=" + DbAdapter.cite(code));
		} finally
		{
			db.close();
		}
		return k;
	}

	public void delete(int i) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			// db.executeUpdate("CouponDeleteLayer " + _nCoupon + ", " + i);
			db.executeUpdate("DELETE FROM CouponLayer WHERE coupon=" + _nCoupon + " AND language=" + i);
			db.executeQuery("SELECT coupon   FROM CouponLayer  WHERE coupon=" + _nCoupon);
			if (db.next())
			{
				db.executeUpdate("DELETE FROM Coupon WHERE coupon=" + _nCoupon);
			}
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(_nCoupon));
	}

	public String getCode() throws SQLException
	{
		loadBasic();
		return _strCode;
	}

	public String getText(int i) throws SQLException
	{
		return getLayer(i)._strText;
	}

	public int getCurrency() throws SQLException
	{
		loadBasic();
		return _nCurrency;
	}

	public String getMemberx() throws SQLException
	{
		loadBasic();
		return memberx;
	}

	public BigDecimal getBank() throws SQLException
	{
		loadBasic();
		return bank;
	}

	public String getCommunity()
	{
		return _strCommunity;
	}

	public void setBank(BigDecimal bank) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Coupon SET bank=" + bank + " WHERE coupon=" + _nCoupon);
			this.bank = bank;
		} finally
		{
			db.close();
		}
	}

	public static final String COUPON_TYPE[] = { "FixAmount", "PercentageList", "PercentageSale", "PercentageShipping" };
	public static final int COUPONT_FIXAMOUNT = 0;
	public static final int COUPONT_PERCENTAGELIST = 1;
	public static final int COUPONT_PERCENTAGESALE = 2;
	public static final int COUPONT_PERCENTAGESSHIPPING = 3;
	public static final int COUPONO_ACCESS = 32768;
	public static final int COUPONO_AD = 16384;
	public static final int COUPONO_BUY = 8192;
	public static final int COUPONO_BID = 4096;
	public static final int COUPONO_BARGAIN = 2048;
	private int _nCoupon;
	private String _strMember;
	private int _nCurrency;
	private int _nType;
	private int _nOptions;
	private BigDecimal _bdMinimum;
	private BigDecimal _bdDiscount;
	private String _strCode;
	private boolean _blLoaded;
	private Hashtable _htLayer;
	private static Cache _cache = new Cache(100);
	private String memberx;
	private BigDecimal bank;
	private String _strCommunity;
}
