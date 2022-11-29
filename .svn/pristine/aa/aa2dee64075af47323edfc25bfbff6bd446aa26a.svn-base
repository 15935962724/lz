package tea.entity.site;

import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class Communitysubscriber
{
	private static Cache _cache = new Cache(100);
	private String community;
	private boolean exists;
	private String exports;
	public static final String FIELD_TYPE[] = { "MemberId", "Password", "Birth", "Time", "Mobile", "Sex", "Polity", "Card", "Email", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, "FirstName", "LastName", "Telephone", "Fax", "Organization", "Zip", "Address", "City", "State", "Country", "WebPage" };

	public static Communitysubscriber find(String community) throws SQLException
	{
		Communitysubscriber obj = (Communitysubscriber) _cache.get(community);
		if (obj == null)
		{
			obj = new Communitysubscriber(community);
			_cache.put(community, obj);
		}
		return obj;
	}

	public Communitysubscriber(String community, String exports) throws SQLException
	{
		this.community = community;
		this.exports = exports;
		this.exists = true;
	}

	public Communitysubscriber(String community) throws SQLException
	{
		this.community = community;
		loadBasic();
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT exports FROM Communitysubscriber WHERE community=" + DbAdapter.cite(community));
			if (db.next())
			{
				exports = db.getString(1);
				exists = true;
			} else
			{
				exports = "/0/32/8/4/5/7/33/36/37";
				exists = false;
			}
		} finally
		{
			db.close();
		}
	}

	public void set(String exports) throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("UPDATE Communitysubscriber SET exports=" + DbAdapter.cite(exports) + " WHERE community=" + DbAdapter.cite(community));
		} finally
		{
			dbadapter.close();
		}
		this.exports = exports;
	}

	public static void create(String community, String exports) throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("INSERT INTO Communitysubscriber(community,exports)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(exports) + ")");
		} finally
		{
			dbadapter.close();
		}
		_cache.remove(community);
	}

	public void delete() throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("DELETE FROM Communitysubscriber WHERE community=" + DbAdapter.cite(community));
		} finally
		{
			dbadapter.close();
		}
		exists = false;
		_cache.remove(community);
	}

	public String getCommunity()
	{
		return community;
	}

	public boolean isExists()
	{
		return exists;
	}

	public String getExports()
	{
		return exports;
	}
}
