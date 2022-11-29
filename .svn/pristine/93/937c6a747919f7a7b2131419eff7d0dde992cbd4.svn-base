package tea.entity.criterion;

import java.math.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class Itemoutlay extends Entity
{
	private static Cache _cache = new Cache(100);
	// private static final java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-hh HH:mm");
	private int outlay;
	private int poyear;
	private java.math.BigDecimal money;
	private Date time;
	private String community;
	private int item;
	private int itemoutlay;

	public Itemoutlay(int itemoutlay) throws SQLException
	{
		this.itemoutlay = itemoutlay;
		loadBasic();
	}

	public Itemoutlay(int itemoutlay, int item, BigDecimal money, int poyear, int outlay, java.util.Date time)
	{
		this.itemoutlay = itemoutlay;
		this.item = item;
		this.outlay = outlay;
		this.poyear = poyear;
		this.money = money;
		this.time = time;
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT  item,time  ,poyear,money,outlay	 FROM Itemoutlay WHERE itemoutlay=" + (itemoutlay));
			if (db.next())
			{
				item = db.getInt(1);
				time = db.getDate(2);
				poyear = db.getInt(3);
				money = db.getBigDecimal(4, 2);
				outlay = db.getInt(5);
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
			db.executeUpdate("DELETE Itemoutlay WHERE itemoutlay=" + itemoutlay);
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(itemoutlay));
	}

	public static void create(int item, int poyear, BigDecimal money, int outlay, Date time) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO Itemoutlay( item  , poyear,  money    ,outlay,time ) VALUES(" + (item) + "," + (poyear) + "," + (money) + "," + (outlay) + "," + DbAdapter.cite(time) + ")");
		} finally
		{
			db.close();
		}
	}

	public void set(int item, int poyear, BigDecimal money, int outlay, Date time) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Itemoutlay SET item=" + (item) + "  , poyear=" + (poyear) + ",money=" + (money) + ",outlay=" + (outlay) + ",time =" + DbAdapter.cite(time) + " WHERE itemoutlay=" + itemoutlay);
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(itemoutlay));
	}

	public static java.util.Enumeration find(String community, String sql, int pos, int pageSize) throws SQLException
	{
		java.util.Vector vector = new java.util.Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT itemoutlay FROM Itemoutlay io,Item i,Outlay o WHERE io.item=i.item AND io.outlay=o.outlay AND i.community=" + DbAdapter.cite(community) + " AND o.community=" + DbAdapter.cite(community) + sql);
			for (int l = 0; l < (pos + pageSize) && db.next(); l++)
			{
				if (l >= pos)
				{
					int itemoutlay = db.getInt(1);
					vector.addElement(new Integer(itemoutlay));
				}
			}
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public static Itemoutlay find(int Itemoutlay) throws SQLException
	{
		Itemoutlay obj = (Itemoutlay) _cache.get(new Integer(Itemoutlay));
		if (obj == null)
		{
			obj = new Itemoutlay(Itemoutlay);
			_cache.put(new Integer(Itemoutlay), obj);
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

	public static BigDecimal findPaymentByItem(int item) throws SQLException
	{
		java.math.BigDecimal payment = new java.math.BigDecimal("0.00");
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT money,itemoutlay FROM Itemoutlay io  WHERE io.item=" + item);
			while (db.next())
			{
				payment = payment.add(db.getBigDecimal(1, 2));
			}
		} finally
		{
			db.close();
		}
		return payment;
	}

	public static BigDecimal findPaymentByOutlay(int outlay) throws SQLException
	{
		java.math.BigDecimal payment = new java.math.BigDecimal("0.00");
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT money,itemoutlay FROM Itemoutlay io  WHERE io.outlay=" + outlay);
			while (db.next())
			{
				payment = payment.add(db.getBigDecimal(1, 2));
			}
		} finally
		{
			db.close();
		}
		return payment;
	}

	public String getCommunity()
	{
		return community;
	}

	public int getItem()
	{
		return item;
	}

	public int getOutlay()
	{
		return outlay;
	}

	public int getPoyear()
	{
		return poyear;
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
			db.executeQuery("SELECT COUNT(community) FROM Itemoutlay WHERE community=" + DbAdapter.cite(community));
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
			count = db.executeUpdate("DELETE Itemoutlay WHERE item NOT IN(SELECT item FROM Item)");// + DbAdapter.cite(community));

		} finally
		{
			db.close();
		}
		_cache.clear();
		return count;
	}
}
