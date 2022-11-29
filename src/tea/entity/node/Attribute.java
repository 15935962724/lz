package tea.entity.node;

import tea.db.*;
import tea.entity.*;
import tea.entity.member.*;
import javax.servlet.ServletContext;
import java.util.*;
import java.sql.SQLException;

public class Attribute
{
	private static Cache _cache = new Cache(100);
	private Hashtable _htLayer;
	private int attribute;
	private int goodstype;
	private boolean exists;
	private String community;
	private String types;

	class Layer
	{
		private int language;
		private String name;
		private String text;
	}

	public static Attribute find(int attribute) throws SQLException
	{
		Attribute obj = (Attribute) _cache.get(new Integer(attribute));
		if (obj == null)
		{
			obj = new Attribute(attribute);
			_cache.put(new Integer(attribute), obj);
		}
		return obj;
	}

	public Attribute(int attribute) throws SQLException
	{
		this.attribute = attribute;
		_htLayer = new Hashtable();
		loadBasic();
	}

	public void set(String types, int goodstype, int language, String name, String text) throws SQLException
	{
		if (this.isExists())
		{
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeUpdate("UPDATE Attribute SET types=" + DbAdapter.cite(types) + " WHERE attribute=" + attribute);
				int j = db.executeUpdate("UPDATE AttributeLayer SET name=" + DbAdapter.cite(name) + ",text=" + DbAdapter.cite(text) + " WHERE attribute=" + attribute + " AND language=" + language);
				if (j < 1)
				{
					db.executeUpdate("INSERT INTO AttributeLayer(attribute,language,name,text)VALUES(" + attribute + "," + language + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(text) + ")");
				}
			} finally
			{
				db.close();
			}
			// _cache.remove(new Integer(attribute));
			this.types = types;
			_htLayer.clear();
		} else
		{
			create(community, types, goodstype, language, name, text);
		}
	}

	public static java.util.Enumeration findByGoodstype(int goodstype) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		java.util.Vector vector = new java.util.Vector();
		try
		{
			db.executeQuery("SELECT attribute FROM Attribute WHERE goodstype=" + goodstype);
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

	public static int countByGoodstype(int goodstype) throws SQLException
	{
		int count = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT COUNT(attribute) FROM Attribute WHERE goodstype=" + goodstype);
			if (db.next())
			{
				count = db.getInt(1);
			}
		} finally
		{
			db.close();
		}
		return count;
	}

	public static void deleteByGoodstype(int goodstype) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM Attribute WHERE goodstype=" + goodstype);
		} finally
		{
			db.close();
		}
		_cache.clear();
	}

	public static java.util.Enumeration findGoodstypeByCommunity(String community) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		java.util.Vector vector = new java.util.Vector();
		try
		{
			db.executeQuery("SELECT DISTINCT goodstype FROM Attribute WHERE community=" + DbAdapter.cite(community));
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

	public static void create(String community, String types, int goodstype, int language, String name, String text) throws SQLException
	{
		int attribute = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO Attribute(community,types,goodstype)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(types) + "," + goodstype + ")");
			attribute = db.getInt("SELECT MAX(attribute) FROM Attribute");
			db.executeUpdate("INSERT INTO AttributeLayer(attribute,language,name,text)VALUES( " + attribute + "," + language + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(text) + ")");
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(attribute));
	}

	public void delete(int language) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM AttributeLayer WHERE attribute=" + attribute + " AND language=" + language);
			db.executeQuery("SELECT attribute FROM AttributeLayer WHERE attribute=" + attribute);
			if (!db.next())
			{
				db.executeUpdate("DELETE FROM Attribute WHERE attribute=" + attribute);
				db.executeUpdate("DELETE FROM ListingDetail WHERE itemname=" + DbAdapter.cite("attribute" + attribute)); // 删除相关的列举细节
			}
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(attribute));
	}

	private int getLanguage(int language) throws SQLException
	{
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT language FROM AttributeLayer WHERE attribute=" + attribute);
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

	private Layer getLayer(int i) throws SQLException
	{
		Layer layer = (Layer) _htLayer.get(new Integer(i));
		if (layer == null)
		{
			layer = new Layer();
			layer.language = getLanguage(i);
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery("SELECT name,text FROM AttributeLayer WHERE attribute=" + attribute + " AND language=" + layer.language);
				if (db.next())
				{
					layer.name = db.getVarchar(layer.language, i, 1);
					layer.text = db.getVarchar(layer.language, i, 2);
				}
			} finally
			{
				db.close();
			}
			_htLayer.put(new Integer(i), layer);
		}
		return layer;
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT community,types,goodstype FROM Attribute WHERE attribute=" + attribute);
			if (db.next())
			{
				community = db.getString(1);
				types = db.getString(2);
				goodstype = db.getInt(3);
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

	public void setAttribute(int attribute)
	{
		this.attribute = attribute;
	}

	public int getAttribute()
	{
		return attribute;
	}

	public int getGoodstype()
	{
		return goodstype;
	}

	public String getName(int language) throws SQLException
	{
		return getLayer(language).name;
	}

	public String getText(int language) throws SQLException
	{
		return getLayer(language).text;
	}

	public String getText(tea.resource.Resource r, int _nLanguage) throws SQLException
	{
		/*
		 * if (text == null || text.length() <= 0) { return ""; } else
		 */
		{
			if ("img".equals(this.types) || "file".equals(this.types))
			{
				return "<INPUT TYPE=FILE NAME='attribute" + attribute + "'/><INPUT TYPE=checkbox onclick=\"document.all['attribute" + attribute + "'].disabled=this.checked;\" NAME=clearattribute" + attribute + " />" + r.getString(_nLanguage, "Clear");
			} else if ("select".equals(this.types))
			{
				tea.html.DropDown select = new tea.html.DropDown("attribute" + attribute);
				java.util.StringTokenizer tokenizer = new java.util.StringTokenizer(getText(_nLanguage), "/");
				while (tokenizer.hasMoreTokens())
				{
					String str = tokenizer.nextToken();
					select.addOption(str, str);
				}
				return select.toString();
			} else if ("radio".equals(this.types))
			{
				StringBuilder sb = new StringBuilder();
				java.util.StringTokenizer tokenizer = new java.util.StringTokenizer(getText(_nLanguage), "/");
				while (tokenizer.hasMoreTokens())
				{
					String str = tokenizer.nextToken();
					tea.html.Radio select = new tea.html.Radio("attribute" + attribute, str, true);
					select.setId(String.valueOf(attribute));
					sb.append(select + "<label for=" + attribute + ">" + str + "</label> ");
				}
				return sb.toString();
			} else if ("checkbox".equals(this.types))
			{
				StringBuilder sb = new StringBuilder();
				java.util.StringTokenizer tokenizer = new java.util.StringTokenizer(getText(_nLanguage), "/");
				while (tokenizer.hasMoreTokens())
				{
					String str = tokenizer.nextToken();
					tea.html.CheckBox select = new tea.html.CheckBox("attribute" + attribute, false, str);
					select.setId(String.valueOf(attribute));
					sb.append(select + "<label for=" + attribute + ">" + str + "</label> ");
				}
				return sb.toString();
			} else if ("textarea".equals(this.types))
			{
				return new tea.html.TextArea("attribute" + attribute, getText(_nLanguage), 5, 60).toString();
			} else
			{
				return new tea.html.TextField("attribute" + attribute, getText(_nLanguage)).toString();
			}
		}
	}

	public String getText(int node, ServletContext application, tea.resource.Resource r, int _nLanguage) throws SQLException
	{
		/*
		 * if (text == null || text.length() <= 0) { return ""; } else
		 */
		{
			AttributeValue av = AttributeValue.find(node, attribute);
			if ("img".equals(this.types) || "file".equals(this.types))
			{
				String len = "";
				if (av.getAttrvalue(_nLanguage) != null)
				{
					java.io.File file = new java.io.File(application.getRealPath(av.getAttrvalue(_nLanguage)));
					file.exists();
					long lo = file.length();
					if (lo != 0)
					{
						len = lo + r.getString(_nLanguage, "Bytes");
					}
				}
				return "<INPUT TYPE=FILE NAME='attribute" + attribute + "'/>" + len + "<INPUT TYPE=checkbox onclick=\"document.all['attribute" + attribute + "'].disabled=this.checked;\" NAME=clearattribute" + attribute + " />" + r.getString(_nLanguage, "Clear");
			} else if ("select".equals(this.types))
			{
				tea.html.DropDown select = new tea.html.DropDown("attribute" + attribute, av.getAttrvalue(_nLanguage));
				java.util.StringTokenizer tokenizer = new java.util.StringTokenizer(getText(_nLanguage), "/");
				while (tokenizer.hasMoreTokens())
				{
					String str = tokenizer.nextToken();
					select.addOption(str, str);
				}
				return select.toString();
			} else if ("radio".equals(this.types))
			{
				StringBuilder sb = new StringBuilder();
				java.util.StringTokenizer tokenizer = new java.util.StringTokenizer(getText(_nLanguage), "/");
				while (tokenizer.hasMoreTokens())
				{
					String str = tokenizer.nextToken();
					tea.html.Radio select = new tea.html.Radio("attribute" + attribute, str, str.equals(av.getAttrvalue(_nLanguage)));
					sb.append(select + str);
				}
				return sb.toString();
			} else if ("checkbox".equals(this.types))
			{
				StringBuilder sb = new StringBuilder();
				java.util.StringTokenizer tokenizer = new java.util.StringTokenizer(getText(_nLanguage), "/");
				for (int index = 0; tokenizer.hasMoreTokens(); index++)
				{
					String str = tokenizer.nextToken();
					boolean bool = av.getAttrvalue(_nLanguage) != null && av.getAttrvalue(_nLanguage).indexOf(str) != -1;
					tea.html.CheckBox select = new tea.html.CheckBox("attribute" + attribute, bool, str);
					sb.append(select + str);
				}
				return sb.toString();
			} else if ("textarea".equals(this.types))
			{
				return new tea.html.TextArea("attribute" + attribute, av.getAttrvalue(_nLanguage), 5, 60).toString();
			} else
			{
				return new tea.html.TextField("attribute" + attribute, av.getAttrvalue(_nLanguage)).toString();
			}
		}
	}

	public boolean isExists()
	{
		return exists;
	}

	public boolean isExistsLayer(int language) throws SQLException
	{
		return getLayer(language).language == language;
	}

	public String getCommunity()
	{
		return community;
	}

	public String getTypes()
	{
		return types;
	}
}
