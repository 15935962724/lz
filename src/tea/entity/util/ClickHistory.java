package tea.entity.util;

import java.io.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class ClickHistory extends Entity implements Serializable
{
	private static Cache _cache = new Cache(100);
	private int clickhistory;
	private String community;
	private int type;
	private int quantity;
	private String name;
	private boolean exists;

	public ClickHistory(int clickhistory) throws SQLException
	{
		this.clickhistory = clickhistory;
		loadBasic();
	}

	public ClickHistory(int clickhistory, String community, int type, int quantity, String name) throws SQLException
	{
		this.clickhistory = clickhistory;
		this.community = community;
		this.type = type;
		this.quantity = quantity;
		this.name = name;
	}

	public static ClickHistory find(int clickhistory) throws SQLException
	{
		ClickHistory obj = (ClickHistory) _cache.get(new Integer(clickhistory));
		if (obj == null)
		{
			obj = new ClickHistory(clickhistory);
			_cache.put(new Integer(clickhistory), obj);
		}
		return obj;
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT community,type,quantity,name FROM clickhistory WHERE clickhistory=" + clickhistory);
			if (db.next())
			{
				community = db.getString(1);
				type = db.getInt(2);
				quantity = db.getInt(3);
				name = db.getString(4);
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

	public static Enumeration findByCommunity(String community) throws SQLException
	{
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT clickhistory FROM clickhistory WHERE community=" + DbAdapter.cite(community));
			while (db.next())
			{
				v.addElement(new Integer(db.getInt(1)));
			}
		} finally
		{
			db.close();
		}
		return v.elements();
	}

	public void set(int type, int quantity, String name) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE clickhistory SET type=" + type + ",quantity=" + quantity + ",name=" + DbAdapter.cite(name) + " WHERE clickhistory=" + clickhistory);
		} finally
		{
			db.close();
		}
		this.type = type;
		this.quantity = quantity;
		this.name = name;
	}

	public void delete() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM clickhistory WHERE clickhistory=" + clickhistory);
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(clickhistory));
	}

	public static int create(String community, int type, int quantity, String name) throws SQLException
	{
		int clickhistory = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT clickhistory(community, type, quantity, name)VALUES(" + DbAdapter.cite(community) + "," + type + "," + quantity + "," + DbAdapter.cite(name) + ")");
			clickhistory = db.getInt("SELECT MAX(clickhistory) FROM clickhistory");
		} finally
		{
			db.close();
		}
		_cache.remove(community);
		return clickhistory;
	}

	public int getClickHistory()
	{
		return clickhistory;
	}

	public String getCommunity()
	{
		return community;
	}

	public boolean isExists()
	{
		return exists;
	}

	public String getName()
	{
		return name;
	}

	public int getType()
	{
		return type;
	}

	public int getQuantity()
	{
		return quantity;
	}
}
