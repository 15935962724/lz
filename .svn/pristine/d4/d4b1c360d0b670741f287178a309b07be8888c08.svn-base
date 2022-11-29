package tea.entity.member;

import tea.db.DbAdapter;
import java.sql.SQLException;

public class Groups
{
	private String name;
	private String member;
	private boolean exists;
	private String depict;

	public Groups()
	{
	}

	public Groups(String member) throws SQLException
	{
		this.member = member;
		loadBasic();
	}

	public void create() throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("JobCreate " + name + "," + member);
			this.exists = true;
		} finally
		{
			dbadapter.close();
		}
	}

	public void set() throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			if (this.isExists())
				dbadapter.executeUpdate("JobEdit " + name + "," + member);
			else
				create();
		} finally
		{
			dbadapter.close();
		}
	}

	public boolean isExists() throws SQLException
	{
		// loadBasic();
		return exists;
	}

	private void loadBasic() throws SQLException
	{
		// if (!_blLoaded)
		{
			DbAdapter dbadapter = new DbAdapter();
			try
			{
				dbadapter.executeQuery("SELECT name FROM Groups  WHERE name=" + DbAdapter.cite(name));
				if (dbadapter.next())
				{
					name = dbadapter.getString(1);
					exists = true;
				} else
				{
					exists = false;
				}
			} finally
			{
				dbadapter.close();
			}
			// _blLoaded = true;
		}
	}

	public static Groups find(String member) throws SQLException
	{
		return new Groups(member);
	}

	public static java.util.Enumeration findByMember(String member) throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		java.util.Vector vector = new java.util.Vector();
		try
		{
			dbadapter.executeQuery("SELECT name FROM Groups WHERE member=" + DbAdapter.cite(member));
			while (dbadapter.next())
				vector.addElement(new Integer(dbadapter.getString(1)));
		} finally
		{
			dbadapter.close();
		}
		return vector.elements();
	}

	public void delete() throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeQuery("DELETE FROM Groups WHERE member=" + DbAdapter.cite(member));
		} finally
		{
			dbadapter.close();
		}
	}

	public static java.util.Enumeration findByGroup(String groupName) throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		java.util.Vector vector = new java.util.Vector();
		try
		{
			dbadapter.executeQuery("SELECT member FROM Groups WHERE name=" + DbAdapter.cite(groupName));
			while (dbadapter.next())
				vector.addElement(new Integer(dbadapter.getString(1)));
		} finally
		{
			dbadapter.close();
		}
		return vector.elements();
	}

	public static java.util.Enumeration find() throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		java.util.Vector vector = new java.util.Vector();
		try
		{
			dbadapter.executeQuery("SELECT name FROM Groups");
			while (dbadapter.next())
				vector.addElement(new Integer(dbadapter.getString(1)));
		} finally
		{
			dbadapter.close();
		}
		return vector.elements();
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public void setMember(String member)
	{
		this.member = member;
	}

	public void setDepict(String depict)
	{
		this.depict = depict;
	}

	public String getName()
	{
		return name;
	}

	public String getMember()
	{
		return member;
	}

	public String getDepict()
	{
		return depict;
	}
}
