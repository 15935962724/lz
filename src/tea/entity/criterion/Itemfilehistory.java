package tea.entity.criterion;

import tea.db.*;
import tea.entity.*;
import java.util.*;
import java.sql.SQLException;

public class Itemfilehistory extends Entity
{
	private static Cache _cache = new Cache(100);
	private int itemfilehistory;
	private int item;
	private String keywords;
	private String uri;
	private String name;
	private boolean exists;

	public Itemfilehistory(int itemfilehistory) throws SQLException
	{
		this.itemfilehistory = itemfilehistory;
		load();
	}

	public static Itemfilehistory find(int item) throws SQLException
	{
		Itemfilehistory obj = (Itemfilehistory) _cache.get(new Integer(item));
		if (obj == null)
		{
			obj = new Itemfilehistory(item);
			_cache.put(new Integer(item), obj);
		}
		return obj;
	}

	private void load() throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeQuery("SELECT item,keywords,uri,name FROM Itemfilehistory WHERE itemfilehistory=" + (itemfilehistory));
			if (dbadapter.next())
			{
				item = dbadapter.getInt(1);
				keywords = dbadapter.getString(2);
				uri = dbadapter.getString(3);
				name = dbadapter.getString(4);
				exists = true;
			} else
			{
				exists = false;
			}
		} finally
		{
			dbadapter.close();
		}
	}

	public void delete() throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("DELETE Itemfilehistory WHERE itemfilehistory=" + (itemfilehistory));
		} finally
		{
			dbadapter.close();
		}
	}

	public static void create(int item, String keywords, String uri, String name) throws SQLException
	{
		if (uri != null && uri.length() > 0)
		{
			DbAdapter dbadapter = new DbAdapter();
			try
			{
				dbadapter.executeUpdate("INSERT INTO Itemfilehistory(item,keywords,uri,name)VALUES(" + item + "," + DbAdapter.cite(keywords) + "," + DbAdapter.cite(uri) + "," + DbAdapter.cite(name) + ")");
			} finally
			{
				dbadapter.close();
			}
		}
	}

	public static java.util.Enumeration find(int item, String keywords) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeQuery("SELECT itemfilehistory FROM Itemfilehistory WHERE item=" + (item) + " AND keywords=" + DbAdapter.cite(keywords));
			while (dbadapter.next())
			{
				vector.addElement(new Integer(dbadapter.getInt(1)));
			}
		} finally
		{
			dbadapter.close();
		}
		return vector.elements();
	}

	public static int findLast(int item, String keywords) throws SQLException
	{
		int id = 0;
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeQuery("SELECT MAX(itemfilehistory) FROM Itemfilehistory WHERE item=" + (item) + " AND keywords=" + DbAdapter.cite(keywords));
			if (dbadapter.next())
			{
				id = dbadapter.getInt(1);
			}
		} finally
		{
			dbadapter.close();
		}
		return id;
	}

	public int getItemfilehistory()
	{
		return itemfilehistory;
	}

	public int getItem()
	{
		return item;
	}

	public String getKeywords()
	{
		return keywords;
	}

	public String getUri()
	{
		return uri;
	}

	public String getName()
	{
		return name;
	}

	public boolean isExists()
	{
		return exists;
	}
}
