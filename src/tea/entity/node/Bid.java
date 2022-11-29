package tea.entity.node;

import java.sql.SQLException;
import java.math.BigDecimal;
import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import tea.translator.Translator;

public class Bid extends Entity
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
					_abVoice = db.getImage("SELECT DATALENGTH(voice), voice  FROM Bid  WHERE bid=" + _nBid);
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

	public String getRemark(int i) throws SQLException
	{
		load();
		return Translator.getInstance().translate(_strRemark, _nLanguage, i);
	}

	private Bid(int i)
	{
		_nBid = i;
		_blLoaded = false;
	}

	public static Bid create(int i, RV rv, Date date, int j, BigDecimal bigdecimal, int k, int l, String s, byte abyte0[]) throws SQLException
	{
		int i1 = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			i1 = db.getInt("BidCreate " + i + ", " + DbAdapter.cite(rv._strR) + ", " + DbAdapter.cite(rv._strV) + ", " + 0 + ", " + DbAdapter.cite(date) + ", " + j + ", " + bigdecimal + ", " + k + ", " + l + ", " + DbAdapter.cite(s) + ", " + DbAdapter.cite(abyte0));
		} finally
		{
			db.close();
		}
		return find(i1);
	}

	public static boolean isBided(int i, RV rv) throws SQLException
	{
		boolean flag = false;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT bid  FROM Bid  WHERE node=" + i + " AND rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV));
			flag = db.next();
		} finally
		{
			db.close();
		}
		return flag;
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

	private void load() throws SQLException
	{
		if (!_blLoaded)
		{
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery("SELECT rmember, vmember, status, stoptime, time, currency, price, quantity, language, remark, DATALENGTH(voice)  FROM Bid  WHERE bid=" + _nBid);
				if (db.next())
				{
					_rv = new RV(db.getString(1), db.getString(2));
					_nStatus = db.getInt(3);
					_stopTime = db.getDate(4);
					_time = db.getDate(5);
					_nCurrency = db.getInt(6);
					_bdPrice = db.getBigDecimal(7, 2);
					_nQuantity = db.getInt(8);
					_nLanguage = db.getInt(9);
					_strRemark = db.getText(_nLanguage, _nLanguage, 10);
					_blVoiceFlag = db.getInt(11) != 0;
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
				if (k >= i)
					vector.addElement(new Integer(db.getInt(1)));
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
			db.executeQuery("SELECT DISTINCT stoptime  FROM Bid  WHERE node=" + i + " AND stoptime<>'' " + " ORDER BY stoptime ");
			for (; db.next(); vector.addElement(db.getDate(1)))
				;
		} finally
		{
			db.close();
		}
		return vector.elements();
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

	public static Bid find(int i)
	{
		Bid bid = (Bid) _cache.get(new Integer(i));
		if (bid == null)
		{
			bid = new Bid(i);
			_cache.put(new Integer(i), bid);
		}
		return bid;
	}

	public static Enumeration find(int i, Date date) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT bid  FROM Bid  WHERE node=" + i + " AND stoptime=" + DbAdapter.cite(date) + " ORDER BY time DESC ");
			for (; db.next(); vector.addElement(new Integer(db.getInt(1))))
				;
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	private static String getNodesSql(RV rv)
	{
		return " FROM Bid  WHERE rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV) + " AND status=" + 0;
	}

	public boolean getVoiceFlag() throws SQLException
	{
		load();
		return _blVoiceFlag;
	}

	public int getCurrency() throws SQLException
	{
		load();
		return _nCurrency;
	}

	public static final int BID_PENDING = 0;
	public static final int BID_PROCESSING = 1;
	public static final int BID_PROCESSED = 2;
	private int _nBid;
	private int _nNode;
	private RV _rv;
	private int _nStatus;
	private Date _stopTime;
	private Date _time;
	private int _nCurrency;
	private BigDecimal _bdPrice;
	private int _nQuantity;
	private int _nLanguage;
	private String _strRemark;
	private boolean _blVoiceFlag;
	private byte _abVoice[];
	private boolean _blLoaded;
	private static Cache _cache = new Cache(100);

}
