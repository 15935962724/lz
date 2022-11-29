package tea.entity.node;

import tea.entity.*;
import tea.db.DbAdapter;
import java.util.*;
import java.sql.SQLException;

public class Berth extends Entity
{

	private static Cache _cache = new Cache(100);
	private Hashtable _htLayer;
	private int node;

	class Layer
	{
		public Layer()
		{
		}

		public String name;
	}

	private boolean exists;
	private int aagio;
	private float price;
	private int berth;

	public Berth(int berth)
	{
		this.berth = berth;
		_htLayer = new Hashtable();
		loadBasic();
	}

	private void loadBasic()
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT node,aagio, price FROM Berth WHERE berth=" + berth);
			if (db.next())
			{
				this.node = db.getInt(1);
				this.aagio = db.getInt(2);
				this.price = db.getFloat(3);
				exists = true;
			} else
			{
				exists = false;
			}
		} catch (Exception exception)
		{
			exception.printStackTrace();
		} finally
		{
			db.close();
		}

	}

	/*
	 * private void loadBasic() {
	 *
	 * DbAdapter db = new DbAdapter(); try { db.executeQuery("SELECT berth, aagio, price FROM Berth WHERE node=" + node + " AND flight='" + this.flight + "'"); if (db.next()) { this.berth = new String(db.getString(1).getBytes("ISO-8859-1")); this.aagio = new String(db.getString(2).getBytes("ISO-8859-1")); this.price = new String(db.getString(3).getBytes("ISO-8859-1")); } } catch (Exception exception) { exception.printStackTrace(); } finally { db.close(); } }
	 */
	public void delete()
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM Berth WHERE berth=" + this.berth);
			_cache.remove(new Integer(this.berth));
		} catch (Exception exception)
		{
			exception.printStackTrace();
		} finally
		{
			db.close();
		}
	}

	public static java.util.Enumeration findByNode(int node)
	{
		java.util.Vector vector = new java.util.Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT berth FROM Berth WHERE node=" + node);
			while (db.next())
			{
				vector.addElement(new Integer(db.getInt(1)));
			}
		} catch (Exception exception)
		{
			exception.printStackTrace();
		} finally
		{
			db.close();
		}
		return vector.elements();
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
				// int j = db.getInt("BerthGetLanguage " + berth + ", " + i);
				int j = this.getLanguage(i);
				db.executeQuery("SELECT name FROM BerthLayer  WHERE berth=" + berth + " AND language=" + j);
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
			db.executeQuery("SELECT language FROM BerthLayer WHERE berth=" + berth);
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
		{
			if (language == 1)
			{
				if (v.indexOf(new Integer(2)) != -1)
					return 2;
			} else if (language == 2)
			{
				if (v.indexOf(new Integer(1)) != -1)
					return 1;
			}
			if (v.size() == 0)
				return 0;
		}
		return ((Integer) v.elementAt(0)).intValue();
	}

	public static Berth find(int berth)
	{
		Berth obj = (Berth) _cache.get(new Integer(berth));
		if (obj == null)
		{
			obj = new Berth(berth);
			_cache.put(new Integer(berth), obj);
		}
		return obj;
		// return new Berth(id);
	}

	/*
	 * public static java.util.Enumeration findNode(int node) { DbAdapter db = new DbAdapter(); java.util.Vector vector = new java.util.Vector(); try { db.executeQuery("SELECT id FROM Berth WHERE node=" + node); for (; db.next(); vector.addElement(new Integer(db.getInt(1)))) { ; } } catch (Exception exception) { exception.printStackTrace(); } finally { db.close(); } return vector.elements(); }
	 */

	public void set(int node, int aagio, float price, int language, String name)
	{
		DbAdapter db = new DbAdapter();
		try
		{
			// db.executeUpdate("BerthEdit " + berth + "," + (node) + ", " + aagio + "," + price + "," + language + "," + DbAdapter.cite(name));
			db.executeUpdate("UPDATE Berth SET node =" + node + ",aagio =" + aagio + ",price =" + price + " WHERE berth=" + berth);
			db.executeQuery("SELECT berth FROM BerthLayer WHERE berth=" + berth + " AND language=" + language);
			if (db.next())
			{
				db.executeUpdate("UPDATE BerthLayer SET  name =" + DbAdapter.cite(name) + "  WHERE berth=" + berth + " AND language=" + language);
			} else
			{
				db.executeUpdate("INSERT INTO BerthLayer(berth,language,name) VALUES(" + berth + "," + language + "," + DbAdapter.cite(name) + ")");
			}
			this.node = node;
			this.aagio = aagio;
			this.price = price;
			_htLayer.clear();
		} catch (Exception exception)
		{
			exception.printStackTrace();
		} finally
		{
			db.close();
		}
	}

	public static int create(int node, int aagio, float price, int language, String name)
	{
		DbAdapter db = new DbAdapter();
		int berth = 0;
		try
		{
			db.executeUpdate("INSERT INTO Berth(node,aagio,price)VALUES(" + (node) + "," + aagio + "," + price + ")");
			berth = db.getInt("SELECT MAX(berth) FROM Berth");
			db.executeUpdate("INSERT INTO BerthLayer(berth,language,name)VALUES(" + berth + "," + language + "," + DbAdapter.cite(name) + ")");
		} catch (Exception exception)
		{
			exception.printStackTrace();
		} finally
		{
			db.close();
		}
		return berth;
	}

	public boolean isExists()
	{
		return exists;
	}

	public int getNode()
	{
		return node;
	}

	public String getName(int language) throws SQLException
	{
		return getLayer(language).name;
	}

	public int getAagio()
	{
		return aagio;
	}

	public float getPrice()
	{
		return price;
	}

	public int getBerth()
	{
		return berth;
	}

}
