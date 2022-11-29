package tea.entity.node;

import tea.entity.*;
import tea.db.*;
import java.sql.SQLException;

public class Template
{
	private int id;
	private int node;
	private int category;
	private String name;

	public Template(int id) throws SQLException
	{
		this.id = id;
		load();
	}

	public static Template find(int id) throws SQLException
	{
		return new Template(id);
	}

	private void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT node,category,name FROM Template WHERE id=" + id);
			if (db.next())
			{
				node = db.getInt(1);
				category = db.getInt(2);
				name = db.getVarchar(1, 1, 3);
			}
		} finally
		{
			db.close();
		}
	}

	public static void create(int node, int category, String name) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO Template(node,category,name)VALUES(" + node + "," + category + "," + DbAdapter.cite(name) + ")");
		} finally
		{
			db.close();
		}
	}

	public void set(int node, int category, String name) throws SQLException
	{
		name = DbAdapter.cite(name);
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Template SET node=" + node + ",category=" + category + ",name=" + name + " WHERE id=" + id);
		} finally
		{
			db.close();
		}
		this.node = node;
		this.category = category;
		this.name = name;
	}

	public static java.util.Enumeration findByPath(String path) throws SQLException
	{
		java.util.Vector vector = new java.util.Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT id FROM Template WHERE " + DbAdapter.cite(path + "/") + " LIKE " + db.concat("'%/'", db.cast("category", "VARCHAR(10)"), "'/%'"));
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

	public void delete() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM Template WHERE id=" + id);
		} finally
		{
			db.close();
		}
	}

	public int getId()
	{
		return id;
	}

	public int getNode()
	{
		return node;
	}

	public int getCategory()
	{
		return category;
	}

	public String getName()
	{
		return name;
	}
}
