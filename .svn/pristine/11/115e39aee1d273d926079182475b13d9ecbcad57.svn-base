package tea.entity.member;

import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class Impower
{
	private int node;
	private String object;
	private boolean type;
	private String id;
	private int scope;
	private boolean exists;

	public Impower()
	{
	}

	public Impower(int node, String object, boolean type) throws SQLException
	{
		this.node = node;
		this.object = object;
		this.type = type;
		loadBasic();
	}

	public static Impower find(int node, String object, boolean type) throws SQLException
	{
		return new Impower(node, object, type);
	}

	public void set() throws SQLException
	{
		DbAdapter dbadapter = null;
		try
		{
			if (this.exists)
			{
				int bit = type ? 1 : 0;
				dbadapter = new DbAdapter();
				// dbadapter.executeUpdate("ImpowerEdit " + (node) + "," + DbAdapter.cite(object) + "," +
				// (bit) + "," + DbAdapter.cite(id) + "," + (scope));
				dbadapter.executeUpdate("UPDATE Impower  SET object	=" + DbAdapter.cite(object) + "	,type 	=" + (bit) + " 	,id	=" + DbAdapter.cite(id) + "	,scope=" + (scope) + "	WHERE node=" + node);
			} else
			{
				create();
			}
		} finally
		{
			if (dbadapter != null)
			{
				dbadapter.close();
			}
		}
	}

	public void create() throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			int bit = type ? 1 : 0;
			// dbadapter.executeUpdate("ImpowerCreate " + (node) + "," + DbAdapter.cite(object)
			// + "," + (bit) + "," + DbAdapter.cite(id) + "," + (scope));
			dbadapter.executeUpdate("INSERT INTO Impower (node,	object,	type,	id, 	scope) VALUES (" + node + ",	" + DbAdapter.cite(object) + ",	" + (bit) + ",	" + DbAdapter.cite(id) + ", " + (scope) + ")");
		} finally
		{
			dbadapter.close();
		}
	}

	private void loadBasic() throws SQLException
	{
		// if (!_blLoaded)
		{
			DbAdapter dbadapter = new DbAdapter();
			try
			{
				int bit = type ? 1 : 0;
				dbadapter.executeQuery("SELECT id, scope FROM Impower  WHERE node=" + this.node + " AND object=" + DbAdapter.cite(this.object) + " AND type=" + bit);
				if (dbadapter.next())
				{
					// object = dbadapter.getString(1);
					// type = dbadapter.getInt(2) != 0;
					id = dbadapter.getString(1);
					scope = dbadapter.getInt(2);
					exists = true;
				} else
				{
					exists = false;
					object = "";
				}
			} finally
			{
				dbadapter.close();
			}
			// _blLoaded = true;
		}
	}

	public void setNode(int node)
	{
		this.node = node;
	}

	public void setObject(String object)
	{
		this.object = object;
	}

	public void setType(boolean type)
	{
		this.type = type;
	}

	public void setId(int id)
	{
		this.id = String.valueOf(id);
	}

	public void setId(int id[])
	{
		// this.id = id;
		this.id = new String();
		for (int len = 0; len < id.length; len++)
		{
			this.id = this.id + "/" + id[len];
		}
	}

	public void setId(String id[])
	{
		// this.id = id;
		this.id = new String();
		for (int len = 0; len < id.length; len++)
		{
			this.id = this.id + "/" + id[len];
		}
	}

	public void setScope(int scope)
	{
		this.scope = scope;
	}

	public int getNode()
	{
		return node;
	}

	public String getObject()
	{
		return object;
	}

	public boolean isType()
	{
		return type;
	}

	public java.util.Enumeration getId()
	{
		java.util.Vector vector = new java.util.Vector();
		java.util.StringTokenizer tokenizer = new java.util.StringTokenizer(id, "/");
		while (tokenizer.hasMoreTokens())
		{
			vector.addElement(tokenizer.nextToken());
		}
		return vector.elements();
	}

	public int getScope()
	{
		return scope;
	}

	public boolean isExists()
	{
		return exists;
	}
}
