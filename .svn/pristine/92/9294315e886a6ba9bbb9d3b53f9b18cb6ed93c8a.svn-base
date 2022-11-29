package tea.entity.member;

import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class BuyInstruction extends Entity
{
	class Layer
	{
		public String _strText;

		Layer()
		{
		}
	}

	public String getMember() throws SQLException
	{
		load();
		return _strMember;
	}

	public void set(int i, String s) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("BuyInstructionEdit " + _nBuyInstruction + ", " + i + ", " + DbAdapter.cite(s));
			db.executeQuery("SELECT buyinstruction FROM BuyInstructionLayer	WHERE buyinstruction=" + _nBuyInstruction + "  AND language" + i);
			if (db.next())
			{
				db.executeUpdate("UPDATE BuyInstructionLayer  SET text=" + DbAdapter.cite(s) + " WHERE buyinstruction=" + _nBuyInstruction + " AND language=" + i);
			} else
			{
				db.executeUpdate("INSERT BuyInstructionLayer(buyinstruction, language, text)	VALUES (" + _nBuyInstruction + ", " + i + ", " + DbAdapter.cite(s) + ")");
			}
		} finally
		{
			db.close();
		}
		_htLayer.clear();
	}

	private BuyInstruction(int i)
	{
		_nBuyInstruction = i;
		_blLoaded = false;
		_htLayer = new Hashtable();
	}

	public static BuyInstruction create(String member, int currency, int language, String text) throws SQLException
	{
		int buyinstruction = 0;
		int k = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			// k = db.getInt("BuyInstructionCreate " + DbAdapter.cite(member) + ", " + currency + ", " + language + ", " + DbAdapter.cite(text));
			db.executeUpdate("INSERT INTO BuyInstruction(member, currency) VALUES (" + DbAdapter.cite(member) + ", " + currency + ")");

			buyinstruction = db.getInt("SELECT @@IDENTITY");
			db.executeUpdate("INSERT INTO BuyInstructionLayer(buyinstruction, language, text) VALUES (" + buyinstruction + ", " + language + ", " + DbAdapter.cite(text) + ")");
			k = buyinstruction;
		} finally
		{
			db.close();
		}
		return find(k);
	}

	public boolean isLayerExisted(int i) throws SQLException
	{
		boolean flag = false;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT buyinstruction  FROM BuyInstructionLayer  WHERE buyinstruction=" + _nBuyInstruction + " AND language=" + i);
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
				db.executeQuery("SELECT member, currency  FROM BuyInstruction  WHERE buyinstruction=" + _nBuyInstruction);
				if (db.next())
				{
					_strMember = db.getString(1);
					_nCurrency = db.getInt(2);
				}
			} finally
			{
				db.close();
			}
		}
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
				db.executeQuery("SELECT text FROM BuyInstructionLayer  WHERE buyinstruction=" + _nBuyInstruction + " AND language=" + j);
				if (db.next())
					layer._strText = db.getText(j, i, 1);
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
			db.executeQuery("SELECT language FROM BuyInstructionLayer WHERE buyinstruction=" + _nBuyInstruction);
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

	public static int count(String s) throws SQLException
	{
		int i = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			i = db.getInt("SELECT COUNT(buyinstruction)  FROM BuyInstruction  WHERE member=" + DbAdapter.cite(s));
		} finally
		{
			db.close();
		}
		return i;
	}

	public static BuyInstruction find(int i)
	{
		BuyInstruction buyinstruction = (BuyInstruction) _cache.get(new Integer(i));
		if (buyinstruction == null)
		{
			buyinstruction = new BuyInstruction(i);
			_cache.put(new Integer(i), buyinstruction);
		}
		return buyinstruction;
	}

	public static Enumeration find(String s) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT buyinstruction FROM BuyInstruction  WHERE member=" + DbAdapter.cite(s));
			for (; db.next(); vector.addElement(new Integer(db.getInt(1))))
				;
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public static int find(String memeber, int currency) throws SQLException
	{
		int j = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			j = db.getInt("SELECT buyinstruction FROM BuyInstruction WHERE member=" + DbAdapter.cite(memeber) + " AND currency=" + currency);
		} finally
		{
			db.close();
		}
		return j;
	}

	public void delete(int i) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			// db.executeUpdate("BuyInstructionDeleteLayer " + _nBuyInstruction + ", " + i);
			db.executeUpdate("DELETE FROM BuyInstructionLayer WHERE buyinstruction=" + _nBuyInstruction + " AND language=" + i);
			db.executeQuery("SELECT buyinstruction   FROM BuyInstructionLayer  WHERE buyinstruction=" + _nBuyInstruction);
			if (db.next())
			{
				db.executeUpdate("DELETE FROM BuyInstruction WHERE buyinstruction=" + _nBuyInstruction);
			}
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(_nBuyInstruction));
	}

	public String getText(int i) throws SQLException
	{
		return getLayer(i)._strText;
	}

	public int getCurrency() throws SQLException
	{
		load();
		return _nCurrency;
	}

	private int _nBuyInstruction;
	private String _strMember;
	private int _nCurrency;
	private boolean _blLoaded;
	private Hashtable _htLayer;
	private static Cache _cache = new Cache(100);

}
