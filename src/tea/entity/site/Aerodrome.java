package tea.entity.site;

import tea.entity.*;
import java.util.Hashtable;
import tea.entity.node.Node;
import tea.db.DbAdapter;
import java.util.*;
import java.sql.SQLException;

public class Aerodrome extends Entity
{
	private static Cache _cache = new Cache(100);
	private Hashtable _htLayer;
	private String community;

	class Layer
	{
		private String name;
	}

	private int language;
	private int aerodrome;

	public Aerodrome(int aerodrome)
	{
		_htLayer = new Hashtable();
		this.aerodrome = aerodrome;
	}

	public static Aerodrome find(int aerodrome)
	{
		Aerodrome node = (Aerodrome) _cache.get(new Integer(aerodrome));
		if (node == null)
		{
			node = new Aerodrome(aerodrome);
			_cache.put(new Integer(aerodrome), node);
		}
		return node;
	}

	public String getCommunity()
	{
		return community;
	}

	private Layer getLayer(int i) throws SQLException
	{
		Layer layer = (Layer) _htLayer.get(new Integer(i));
		if (layer == null)
		{
			layer = new Layer();
			DbAdapter db = new DbAdapter();
			try
			{
				// int j = db.getInt("AerodromeGetLanguage " + aerodrome + "," + i);
				int j = this.getLanguage(i);
				db.executeQuery("SELECT name FROM AerodromeLayer  WHERE aerodrome=" + aerodrome + " AND language=" + j);
				if (db.next())
				{
					layer.name = db.getVarchar(j, i, 1);
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
			db.executeQuery("SELECT language FROM AerodromeLayer WHERE aerodrome=" + aerodrome);
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
		}
		return ((Integer) v.elementAt(0)).intValue();
	}

	public void set(String community, String name, int language) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			// db.executeUpdate("AerodromeEdit " + aerodrome + "," + DbAdapter.cite(community) + ","
			// + language+ "," + DbAdapter.cite(name) );
			db.executeQuery("SELECT aerodrome FROM Aerodrome WHERE aerodrome=" + aerodrome);
			if (db.next())
			{
				db.executeQuery("SELECT aerodrome FROM AerodromeLayer WHERE aerodrome=" + aerodrome + " AND language=" + language);
				if (db.next())
				{
					db.executeUpdate("  UPDATE AerodromeLayer SET name=" + DbAdapter.cite(name) + " WHERE aerodrome=" + aerodrome + " AND language=" + language);
				} else
				{
					db.executeUpdate("  INSERT INTO AerodromeLayer (aerodrome, language, name) VALUES (@aerodrome, @language, @name)");
				}
			} else
			{
				db.executeUpdate("INSERT INTO Aerodrome (community)VALUES (" + DbAdapter.cite(community) + ")");
				aerodrome = db.getInt("SELECT MAX(aerodrome) FROM Aerodrome");
				db.executeUpdate("INSERT INTO AerodromeLayer (aerodrome, language, name) VALUES (" + aerodrome + ", " + language + ", " + DbAdapter.cite(name) + ")");
			}
			_cache.remove(new Integer(aerodrome));
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
			db.executeUpdate("DELETE FROM Aerodrome WHERE  aerodrome=" + aerodrome);
			_cache.remove(new Integer(aerodrome));
		} finally
		{
			db.close();
		}
	}

	public static java.util.Enumeration findByCommunity(String community) throws SQLException
	{
		java.util.Vector vector = new java.util.Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT aerodrome FROM Aerodrome  WHERE community=" + DbAdapter.cite(community));
			while (db.next())
			{
				vector.addElement(new Integer(db.getInt(1)));
			}
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public String getName(int language) throws SQLException
	{
		return getLayer(language).name;
	}

	public int getAerodrome()
	{
		return aerodrome;
	}
}
