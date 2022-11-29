package tea.entity.node;

import java.math.BigDecimal;
import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import tea.translator.Translator;
import java.sql.SQLException;

// Referenced classes of package tea.entity.node:
//            BargainGroup
public class Bargain extends Entity
{
	public byte[] getVoice() throws SQLException
	{
		load();
		if (_blVoiceFlag)
		{
			if (_abVoice == null)
			{
				DbAdapter db = new DbAdapter();
				try
				{
					_abVoice = db.getImage("SELECT DATALENGTH(voice), voice  FROM Bargain  WHERE bargain=" + _nBargain);
				} finally
				{
					db.close();
				}
			}
			return _abVoice;
		} else
		{
			return null;
		}
	}

	public RV getMember() throws SQLException
	{
		load();
		return _rv;
	}

	private Bargain(int i)
	{
		_nBargain = i;
		_blLoaded = false;
	}

	public static Bargain create(int i, RV rv, int j, Date date, int k, BigDecimal bigdecimal, int l, int i1, String s, byte abyte0[]) throws SQLException
	{
		int j1 = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO Bargain (node, rmember, vmember, type, status, stoptime, currency, price, quantity, language, text, voice) VALUES (" + i + ", " + DbAdapter.cite(rv._strR) + ", " + DbAdapter.cite(rv._strV) + ", " + j + ", " + 0 + ", " + DbAdapter.cite(date) + ", " + k + ", " + bigdecimal + ", " + l + ", " + i1 + ", " + DbAdapter.cite(s) + ", " + DbAdapter.cite(abyte0) + ")");
			j1 = db.getInt("SELECT MAX(bargain) FROM Bargain");
		} finally
		{
			db.close();
		}
		return find(j1);
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

	public static int countNodes(RV rv) throws SQLException
	{
		int i = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			i = db.getInt("SELECT COUNT(DISTINCT(node)) " + getNodesSql(rv));
		} finally
		{
			db.close();
		}
		return i;
	}

	public BigDecimal getPrice() throws SQLException
	{
		load();
		return _bdPrice;
	}

	public int getQuantity() throws SQLException
	{
		load();
		return _nQuantity;
	}

	public static boolean isBargained(int i, RV rv) throws SQLException
	{
		boolean flag = false;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT bargain  FROM Bargain  WHERE node=" + i + " AND rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV));
			flag = db.next();
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
				db.executeQuery("SELECT rmember, vmember, type, status, stoptime, time, currency, price, quantity, language,text, DATALENGTH(voice)  FROM Bargain  WHERE bargain=" + _nBargain);
				if (db.next())
				{
					_rv = new RV(db.getString(1), db.getString(2));
					_nType = db.getInt(1);
					_nStatus = db.getInt(2);
					_stopTime = db.getDate(3);
					_time = db.getDate(4);
					_nCurrency = db.getInt(5);
					_bdPrice = db.getBigDecimal(6, 2);
					_nQuantity = db.getInt(7);
					_nLanguage = db.getInt(8);
					_strText = db.getText(_nLanguage, _nLanguage, 9);
					_blVoiceFlag = db.getInt(10) != 0;
				}
			} finally
			{
				db.close();
			}
			_blLoaded = true;
		}
	}

	public static Enumeration findNodes(RV rv, int i, int j) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT DISTINCT(node) " + getNodesSql(rv));
			for (int k = 0; k < i + j && db.next(); k++)
			{
				if (k >= i)
				{
					vector.addElement(new Integer(db.getInt(1)));
				}
			}
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public static Enumeration findStopTime(int i) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT DISTINCT stoptime  FROM Bargain  WHERE node=" + i + " AND stoptime<>'' " + " ORDER BY stoptime ");
			for (; db.next(); vector.addElement(db.getDate(1)))
			{
				;
			}
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public int getType() throws SQLException
	{
		load();
		return _nType;
	}

	public int getStatus() throws SQLException
	{
		load();
		return _nStatus;
	}

	public Date getStopTime() throws SQLException
	{
		load();
		return _stopTime;
	}

	public static Bargain find(int i)
	{
		Bargain bargain = (Bargain) _cache.get(new Integer(i));
		if (bargain == null)
		{
			bargain = new Bargain(i);
			_cache.put(new Integer(i), bargain);
		}
		return bargain;
	}

	public static Enumeration find(int i, Date date) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT rmember, vmember, currency, lasttime=MAX(time), maxprice=MAX(price), maxquantity=MAX(quantity)  FROM Bargain  WHERE node=" + i + " AND type=" + 0 + " AND stoptime=" + DbAdapter.cite(date) + " GROUP BY rmember, vmember, currency " + " ORDER BY maxprice DESC ");
			BargainGroup bargaingroup;
			for (; db.next(); vector.addElement(bargaingroup))
			{
				bargaingroup = new BargainGroup();
				bargaingroup._rv = new RV(db.getString(1), db.getString(2));
				bargaingroup._lastTime = db.getDate(3);
				bargaingroup._bdLastPrice = db.getBigDecimal(4, 2);
				bargaingroup._nMaxQuantity = db.getInt(5);
			}
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public static Enumeration find(int i, Date date, RV rv) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT bargain  FROM Bargain  WHERE node=" + i + " AND stoptime=" + DbAdapter.cite(date) + " AND rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV) + " ORDER BY time DESC ");
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

	private static String getNodesSql(RV rv)
	{
		return " FROM Bargain  WHERE rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV) + " AND status=" + 0;
	}

	public boolean getVoiceFlag() throws SQLException
	{
		load();
		return _blVoiceFlag;
	}

	public String getText(int i) throws SQLException
	{
		load();
		return Translator.getInstance().translate(_strText, _nLanguage, i);
	}

	public int getCurrency() throws SQLException
	{
		load();
		return _nCurrency;
	}

	public static final int BARGAIN_NONE = -1;
	public static final int BARGAIN_OFFER = 0;
	public static final int BARGAIN_COUNTEROFFER = 1;
	public static final int BARGAIN_PENDING = 0;
	public static final int BARGAIN_PROCESSING = 1;
	public static final int BARGAIN_PROCESSED = 2;
	private int _nBargain;
	private int _nNode;
	private RV _rv;
	private int _nType;
	private int _nStatus;
	private Date _stopTime;
	private Date _time;
	private int _nCurrency;
	private BigDecimal _bdPrice;
	private int _nQuantity;
	private int _nLanguage;
	private String _strText;
	private boolean _blVoiceFlag;
	private byte _abVoice[];
	private boolean _blLoaded;
	private static Cache _cache = new Cache(100);
}
