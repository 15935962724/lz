package tea.entity.node;

import tea.db.*;
import tea.entity.*;
import java.util.*;
import java.sql.SQLException;

public class Correlative extends Entity
{
	class Layer
	{
		Layer()
		{

		}

		public String content;
		public String synopsis;
	}

	private static Cache _cache = new Cache(100);
	private Hashtable _htLayer;
	private int correlative;
	private int node;
	private int type;
	private int cnode;
	private boolean exists;
	private int options;
	private float price;
	private String other;

	public Correlative(int correlative) throws SQLException
	{
		this.correlative = correlative;
		_htLayer = new Hashtable();
		loadBasic();
	}

	public static Correlative find(int correlative) throws SQLException
	{
		Correlative obj = (Correlative) _cache.get(new Integer(correlative));
		if (obj == null)
		{
			obj = new Correlative(correlative);
			_cache.put(new Integer(correlative), obj);
		}
		return obj;
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT node,cnode,type,options,price,other FROM Correlative   WHERE correlative=" + correlative);
			if (db.next())
			{
				node = db.getInt(1);
				cnode = db.getInt(2);
				type = db.getInt(3);
				options = db.getInt(4);
				price = db.getFloat(5);
				other = db.getString(6);
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
				db.executeQuery("SELECT synopsis,content FROM CorrelativeLayer WHERE correlative=" + correlative + " AND language=" + j);
				if (db.next())
				{
					layer.synopsis = db.getVarchar(j, i, 1);
					layer.content = db.getText(j, i, 2);
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
			db.executeQuery("SELECT language FROM CorrelativeLayer WHERE correlative=" + correlative);
			while (db.next())
			{
				v.addElement(new Integer(db.getInt(1)));
			}
		} finally
		{
			db.close();
		}
		if (v.indexOf(new Integer(language)) != -1)
		{
			return language;
		} else
		{			if (language == 1)
			{
				if (v.indexOf(new Integer(2)) != -1)
				{
					return 2;
				}
			} else if (language == 2)
			{
				if (v.indexOf(new Integer(1)) != -1)
				{
					return 1;
				}
			}
			if (v.size() < 1)
			{
				return 0;
			}
		}
		return ((Integer) v.elementAt(0)).intValue();
	}

	public static int create(int node, int cnode, int type, int options, float price, String other, int language, String synopsis, String content) throws SQLException
	{
		int id = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO Correlative(node,cnode,type,options, price,other)VALUES (" + node + "," + cnode + "," + type + "," + options + "," + price + "," + other + ")");
			id = db.getInt("SELECT MAX(correlative) FROM Correlative");
			db.executeUpdate("INSERT INTO CorrelativeLayer(correlative,language,synopsis,content)VALUES(" + id + "," + language + "," + DbAdapter.cite(synopsis) + "," + DbAdapter.cite(content) + ")");
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(id));
		return id;
	}

	public void set(int node, int cnode, int type, int options, float price, String other, int language, String synopsis, String content) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Correlative SET cnode=" + node + ",options=" + options + ",price=" + price + ",other=" + other + " WHERE correlative=" + correlative);
			int j = db.executeUpdate("UPDATE CorrelativeLayer SET synopsis=" + DbAdapter.cite(synopsis) + ",content=" + DbAdapter.cite(content) + " WHERE correlative=" + correlative + " AND language=" + language);
			if (j < 1)
			{
				db.executeUpdate("INSERT INTO CorrelativeLayer(correlative,language,synopsis,content)VALUES(" + correlative + "," + language + "," + DbAdapter.cite(synopsis) + "," + DbAdapter.cite(content) + ")");
			}
		} finally
		{
			db.close();
		}
		this.cnode = cnode;
		this.options = options;
		this.price = price;
		this.other = other;
		_htLayer.clear();
	}

	public static Enumeration find(int node, int type) throws SQLException
	{
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT correlative FROM Correlative WHERE type=" + type + " AND node=" + node);
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

	public void delete() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM Correlative WHERE correlative=" + correlative);
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(correlative));
	}

	public int getCnode()
	{
		return cnode;
	}

	public int getNode()
	{
		return node;
	}

	public int getType()
	{
		return type;
	}

	public int getCorrelative()
	{
		return correlative;
	}

	public boolean isExists()
	{
		return exists;
	}

	public int getOptions()
	{
		return options;
	}

	public String getContent(int language) throws SQLException
	{
		return getLayer(language).content;
	}

	public String getSynopsis(int language) throws SQLException
	{
		return getLayer(language).synopsis;
	}

	public float getPrice()
	{
		return price;
	}

	public String getOther()
	{
		return other;
	}
}
