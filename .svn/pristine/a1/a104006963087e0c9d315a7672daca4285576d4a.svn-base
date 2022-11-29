package tea.entity.criterion;

import java.math.BigDecimal;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class ItemBudget extends Entity
{
	private static Cache _cache = new Cache(100);
	private int item;
	private boolean budgettype; // true>总经费预算 false>年度经费预算
	private int budgetyear;
	private BigDecimal budgetoutlay;
	private int itembudget;
	private boolean exists;
	private String outlayapp;
	private String outlayappname;

	public ItemBudget(int itembudget) throws SQLException
	{
		this.itembudget = itembudget;
		load();
	}

	public static ItemBudget find(int itembudget) throws SQLException
	{
		ItemBudget obj = (ItemBudget) _cache.get(new Integer(itembudget));
		if (obj == null)
		{
			obj = new ItemBudget(itembudget);
			_cache.put(new Integer(itembudget), obj);
		}
		return obj;
	}

	public static int find(int item, int budgetyear) throws SQLException
	{
		int itembudget = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT itembudget FROM ItemBudget WHERE item=" + (item) + " AND budgetyear=" + budgetyear);
			if (db.next())
			{
				itembudget = db.getInt(1);
			}
		} finally
		{
			db.close();
		}
		return itembudget;
	}

	public static java.util.Enumeration find(String community, String sql, int pos, int pageSize) throws SQLException
	{
		java.util.Vector vector = new java.util.Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT ib.itembudget FROM ItemBudget ib,Item i WHERE ib.item=i.item AND i.community=" + DbAdapter.cite(community) + sql); // + " ORDER BY updatetime");
			for (int l = 0; l < (pos + pageSize) && db.next(); l++)
			{
				if (l >= pos)
				{
					int item = db.getInt(1);
					vector.addElement(new Integer(item));
				}
			}
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	private void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT item,budgettype,budgetyear,budgetoutlay,outlayapp,outlayappname FROM ItemBudget WHERE itembudget=" + (itembudget));
			if (db.next())
			{
				item = db.getInt(1);
				budgettype = db.getInt(2) != 0;
				budgetyear = db.getInt(3);
				budgetoutlay = db.getBigDecimal(4, 2);
				outlayapp = db.getString(5);
				outlayappname = db.getString(6);
				exists = true;
			} else
			{
				exists = false;
			}
		} finally
		{
			db.close();
		}
	}

	public static BigDecimal getTotal(int item) throws SQLException
	{
		BigDecimal bd = null;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT SUM(budgetoutlay) FROM ItemBudget WHERE item=" + item);
			if (db.next())
			{
				bd = db.getBigDecimal(1, 2);
			}
		} finally
		{
			db.close();
		}
		if (bd == null)
		{
			bd = new BigDecimal("0.00");
		}
		return bd;
	}

	public void delete() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE ItemBudget WHERE itembudget=" + itembudget);
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(itembudget));
	}

	public static int create(int item, boolean budgettype, int budgetyear, BigDecimal budgetoutlay, String outlayapp, String outlayappname) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO ItemBudget(item,budgettype,budgetyear,budgetoutlay,outlayapp,outlayappname) VALUES(" + item + "," + (budgettype ? "1" : "0") + "," + budgetyear + "," + budgetoutlay + "," + DbAdapter.cite(outlayapp) + "," + DbAdapter.cite(outlayappname) + ")");
			db.executeQuery("SELECT MAX(itembudget) FROM ItemBudget");
			if (db.next())
			{
				return db.getInt(1);
			}
		} finally
		{
			db.close();
		}
		return 0;
	}

	public void set(int item, boolean budgettype, int budgetyear, BigDecimal budgetoutlay, String outlayapp, String outlayappname) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE ItemBudget SET item=" + item + ",budgettype=" + (budgettype ? "1" : "0") + ",budgetyear=" + budgetyear + ",budgetoutlay=" + budgetoutlay + ",outlayapp=" + DbAdapter.cite(outlayapp) + ",outlayappname=" + DbAdapter.cite(outlayappname) + " WHERE itembudget=" + itembudget);
		} finally
		{
			db.close();
		}
		this.item = item;
		this.budgettype = budgettype;
		this.budgetyear = budgetyear;
		this.budgetoutlay = budgetoutlay;
		this.outlayapp = outlayapp;
		this.outlayappname = outlayappname;
	}

	public int getItem()
	{
		return item;
	}

	public boolean isBudgettype()
	{
		return budgettype;
	}

	public int getBudgetyear()
	{
		return budgetyear;
	}

	public BigDecimal getBudgetoutlay()
	{
		return budgetoutlay;
	}

	public int getItembudget()
	{
		return itembudget;
	}

	public boolean isExists()
	{
		return exists;
	}

	public String getOutlayapp()
	{
		return outlayapp;
	}

	public String getOutlayappname()
	{
		return outlayappname;
	}

	public static int clear(String community) throws SQLException
	{
		int count = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			count = db.executeUpdate("DELETE ItemBudget WHERE item NOT IN(SELECT item FROM Item)"); // community=" + DbAdapter.cite(community));

		} finally
		{
			db.close();
		}
		_cache.clear();
		return count;
	}
}
