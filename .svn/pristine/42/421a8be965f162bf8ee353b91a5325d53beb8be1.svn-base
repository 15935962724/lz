package tea.entity.member;

import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class Power
{
	private int id;
	private int type;
	private String name;
	private boolean exists;

	public Power()
	{
	}

	public Power(int id) throws SQLException
	{
		this.id = id;
		loadBasic();
	}

	public static Power find(int id) throws SQLException
	{
		return new Power(id);
	}

	public static java.util.Enumeration find() throws SQLException
	{
		java.util.Vector vector = new java.util.Vector();
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeQuery("SELECT id FROM Power");
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

	public static java.util.Enumeration findByType(int type) throws SQLException
	{
		java.util.Vector vector = new java.util.Vector();
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeQuery("SELECT id FROM Power WHERE type=" + type);
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

	public void set() throws SQLException
	{
		DbAdapter dbadapter = null;
		try
		{
			if (this.exists)
			{
				dbadapter = new DbAdapter();
				dbadapter.executeUpdate("UPDATE Power SET name=" + DbAdapter.cite(name) + ",type=" + type + " WHERE id=" + (this.id));
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
			dbadapter.executeUpdate("INSERT INTO Power(type,name) VALUES (" + (type) + "," + DbAdapter.cite(name) + ")");
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
				dbadapter.executeQuery("SELECT name,type FROM Power WHERE id=" + this.id);
				if (dbadapter.next())
				{
					name = dbadapter.getVarchar(1, 1, 1);
					type = dbadapter.getInt(2);
					exists = true;
				} else
				{
					exists = false;
					name = "";
				}
			} finally
			{
				dbadapter.close();
			}
			// _blLoaded = true;
		}
	}

	public void setId(int id)
	{
		this.id = id;
	}

	public void setType(int type)
	{
		this.type = type;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public int getId()
	{
		return id;
	}

	public int getType()
	{
		return type;
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
