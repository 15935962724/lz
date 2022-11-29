package tea.entity.member;

import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;
import java.util.*;

public class AttributeValue
{
	private static Cache _cache = new Cache(100);
	private java.util.Hashtable _htLayer;
	private int attribute;
	private int node;
	private boolean exists;

	class Layer
	{
		private String attrvalue;
	}

	public static AttributeValue find(int node, int attribute) throws SQLException
	{
		AttributeValue obj = (AttributeValue) _cache.get(node + ":" + attribute);
		if (obj == null)
		{
			obj = new AttributeValue(node, attribute);
			_cache.put(node + ":" + attribute, obj);
		}
		return obj;
	}

	public AttributeValue(int node, int attribute) throws SQLException
	{
		this.node = node;
		this.attribute = attribute;
		_htLayer = new Hashtable();
	}

	public void set(int language, String attrvalue) throws SQLException
	{
		if (isExists())
		{
			DbAdapter db = new DbAdapter();
			try
			{
				String sql;
				db.executeQuery("SELECT attribute FROM AttributeValue WHERE attribute=" + attribute + " AND node=" + node + " AND language=" + language);
				if (db.next())
				{
					sql = "UPDATE AttributeValue SET attrvalue=" + DbAdapter.cite(attrvalue) + " WHERE attribute=" + attribute + " AND node=" + node + " AND language=" + language;
					_htLayer.remove(new Integer(language));
				} else
				{
					sql = "INSERT INTO AttributeValue(attribute,node,language,attrvalue)VALUES(" + attribute + "," + node + "," + language + "," + DbAdapter.cite(attrvalue) + ")";
					_htLayer.clear();
				}
				db.executeUpdate(sql);
			} finally
			{
				db.close();
			}
		} else
		{
			create(attribute, node, language, attrvalue);
		}
	}

	private Layer getLayer(int language) throws SQLException
	{
		Layer layer = (Layer) _htLayer.get(new Integer(language));
		if (layer == null)
		{
			layer = new Layer();
			int j = this.getLanguage(language);
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery("SELECT attrvalue FROM AttributeValue WHERE node=" + node + " AND attribute=" + attribute + " AND language=" + j);
				if (db.next())
				{
					layer.attrvalue = db.getText(j, language, 1);
				}
			} finally
			{
				db.close();
			}
			_htLayer.put(new Integer(language), layer);
		}
		return layer;
	}

	private int getLanguage(int language) throws SQLException
	{
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT language FROM AttributeValue WHERE node=" + node + " AND attribute=" + attribute);
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

	public static java.util.Enumeration findByNode(int node) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT av.attribute FROM AttributeValue av,Attribute a WHERE av.node=" + node + " AND av.attribute=a.attribute");
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

	public static java.util.Enumeration findByNode2(int node) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT av.attribute FROM AttributeValue av,Attribute a,GoodsType gt WHERE av.node=" + node + " AND av.attribute=a.attribute AND gt.goodstype=a.goodstype");
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

	public static void create(int attribute, int node, int language, String attrvalue) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO AttributeValue(attribute,node,language,attrvalue)VALUES(" + attribute + "," + node + "," + language + "," + DbAdapter.cite(attrvalue) + ")");
		} finally
		{
			db.close();
		}
		_cache.remove(node + ":" + attribute);
	}

	public void delete() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE AttributeValue WHERE  attribute=" + attribute + " AND node=" + node);
		} finally
		{
			db.close();
		}
		_cache.remove(node + ":" + attribute);
	}

	private void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT language FROM AttributeValue WHERE attribute=" + attribute + " AND node=" + node);
			if (db.next())
			{
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

	public int getNode()
	{
		return node;
	}

	public String getAttrvalue(int language) throws SQLException
	{
		return getLayer(language).attrvalue;
	}

	public boolean isExists() throws SQLException
	{
		load();
		return exists;
	}

	public int getAttribute()
	{
		return attribute;
	}
}
