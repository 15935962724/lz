package tea.entity.util;

import java.io.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class ClickHistoryDetail extends Entity implements Serializable
{
	private static Cache _cache = new Cache(100);
	private int clickhistorydetail;
	private int clickhistory;
	private String field;
	private int quantity;
	private int sequence;
	private int anchor;
	private boolean exists;
	private Hashtable _htLayer;

	class Layer
	{
		private String subject;
		private String beforeitem;
		private String afteritem;
		private boolean layerExists;
	}

	public ClickHistoryDetail(int clickhistorydetail) throws SQLException
	{
		this.clickhistorydetail = clickhistorydetail;
		_htLayer = new Hashtable();
		loadBasic();
	}

	public ClickHistoryDetail(int clickhistorydetail, int clickhistory, int qtype, int itype, int sequence) throws SQLException
	{
		this.clickhistorydetail = clickhistorydetail;
		this.clickhistory = clickhistory;
		this.sequence = sequence;
	}

	public static ClickHistoryDetail find(int clickhistorydetail) throws SQLException
	{
		ClickHistoryDetail node = (ClickHistoryDetail) _cache.get(new Integer(clickhistorydetail));
		if (node == null)
		{
			node = new ClickHistoryDetail(clickhistorydetail);
			_cache.put(new Integer(clickhistorydetail), node);
		}
		return node;
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT clickhistory,field,quantity,sequence,anchor FROM clickhistorydetail WHERE clickhistorydetail=" + clickhistorydetail);
			if (db.next())
			{
				clickhistory = db.getInt(1);
				field = db.getString(2);
				quantity = db.getInt(3);
				sequence = db.getInt(4);
				anchor = db.getInt(5);
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

	public static Enumeration findByClickHistory(int clickhistory) throws SQLException
	{
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT clickhistorydetail FROM clickhistorydetail WHERE clickhistory=" + clickhistory + " ORDER BY sequence");
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

	/*
	 * private static java.util.Enumeration findNtypeByCommunity(String community) throws SQLException { java.util.Vector vector = new java.util.Vector(); DbAdapter db = new DbAdapter(); try { db.executeQuery("SELECT DISTINCT ntype FROM ClickHistoryDetail WHERE ntype!=255 AND community=" + DbAdapter.cite(community)); while (db.next()) { vector.addElement(new Integer(db.getInt(1))); } } catch (Exception exception) { throw new SQLException(exception.toString()); } finally { db.close(); } Object is[] =
	 * vector.toArray(); return vector.elements(); }
	 */
	public void set(String field, int quantity, int sequence, int anchor, int language, String subject, String beforeitem, String afteritem) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE clickhistorydetail SET field=" + DbAdapter.cite(field) + ",sequence=" + sequence + ",anchor=" + anchor + " WHERE clickhistorydetail=" + clickhistorydetail);
			int j = db.executeUpdate("UPDATE clickhistorydetaillayer SET subject=" + DbAdapter.cite(subject) + ",beforeitem=" + DbAdapter.cite(beforeitem) + ",afteritem=" + DbAdapter.cite(afteritem) + " WHERE clickhistorydetail=" + clickhistorydetail + " AND language=" + language);
			if (j < 1)
			{
				db.executeUpdate("INSERT INTO clickhistorydetaillayer(clickhistorydetail,language,subject,beforeitem,afteritem)VALUES(" + clickhistorydetail + "," + language + "," + DbAdapter.cite(subject) + "," + DbAdapter.cite(beforeitem) + "," + DbAdapter.cite(afteritem) + ")");
			}
		} finally
		{
			db.close();
		}
		this.field = field;
		this.quantity = quantity;
		this.sequence = sequence;
		this.anchor = anchor;
		_htLayer.clear();
	}

	public void delete(int language) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM clickhistorydetaillayer WHERE clickhistorydetail=" + clickhistorydetail + " AND language=" + language);
			db.executeQuery("SELECT clickhistorydetail FROM clickhistorydetaillayer WHERE clickhistorydetail=" + clickhistorydetail);
			if (!db.next())
			{
				db.executeUpdate("DELETE FROM clickhistorydetail WHERE clickhistorydetail=" + clickhistorydetail);
				_cache.remove(new Integer(clickhistorydetail));
				exists = false;
			} else
			{
				_htLayer.clear();
			}
		} finally
		{
			db.close();
		}
	}

	public static int create(int clickhistory, String field, int quantity, int sequence, int anchor, int language, String subject, String beforeitem, String afteritem) throws SQLException
	{
		int chd = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT clickhistorydetail(clickhistory,field,quantity,sequence,anchor)VALUES(" + clickhistory + "," + DbAdapter.cite(field) + "," + quantity + "," + sequence + "," + anchor + ")");
			chd = db.getInt("SELECT MAX(clickhistorydetail) FROM clickhistorydetail");
			db.executeUpdate("INSERT INTO clickhistorydetaillayer(clickhistorydetail,language,subject,beforeitem,afteritem)VALUES(" + chd + "," + language + "," + DbAdapter.cite(subject) + "," + DbAdapter.cite(beforeitem) + "," + DbAdapter.cite(afteritem) + ")");
		} finally
		{
			db.close();
		}
		return chd;
	}

	private int getLanguage(int language) throws SQLException
	{
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT language FROM clickhistorydetaillayer WHERE clickhistorydetail=" + clickhistorydetail);
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
		{
			if (language == 1)
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

	private Layer getLayer(int language) throws SQLException
	{
		Layer layer = (Layer) _htLayer.get(new Integer(language));
		if (layer == null)
		{
			layer = new Layer();
			int j = getLanguage(language);
			layer.layerExists = j == language;
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery("SELECT subject,beforeitem,afteritem FROM clickhistorydetaillayer WHERE clickhistorydetail=" + clickhistorydetail + " AND language=" + j);
				if (db.next())
				{
					layer.subject = db.getVarchar(j, language, 1);
					layer.beforeitem = db.getVarchar(j, language, 2);
					layer.afteritem = db.getVarchar(j, language, 3);
				}
			} finally
			{
				db.close();
			}
			_htLayer.put(new Integer(language), layer);
		}
		return layer;
	}

	public int getClickHistoryDetail()
	{
		return clickhistorydetail;
	}

	public int getClickHistory()
	{
		return clickhistory;
	}

	public String getSubject(int language) throws SQLException
	{
		return getLayer(language).subject;
	}

	public String getBefore(int language) throws SQLException
	{
		return getLayer(language).beforeitem;
	}

	public String getAfter(int language) throws SQLException
	{
		return getLayer(language).afteritem;
	}

	public boolean isLayerExists(int language) throws SQLException
	{
		return getLayer(language).layerExists;
	}

	public int getSequence()
	{
		return sequence;
	}

	public boolean isExists()
	{
		return exists;
	}

	public String getField()
	{
		return field;
	}

	public int getQuantity()
	{
		return quantity;
	}

	public int getAnchor()
	{
		return anchor;
	}

}
