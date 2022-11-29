package tea.entity.site;

import java.util.Enumeration;
import java.util.Vector;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class GrantAccess extends Entity
{

	public static void create(String s, String s1) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			// db.executeUpdate("GrantAccessCreate " + DbAdapter.cite(s) + ", " + DbAdapter.cite(s1));
			db.executeQuery("SELECT community  FROM GrantAccess	WHERE community=" + DbAdapter.cite(s) + "  AND member=" + DbAdapter.cite(s1));
			if (db.next())
			{
				db.executeUpdate("INSERT INTO GrantAccess(community, member)VALUES (" + DbAdapter.cite(s) + ", " + DbAdapter.cite(s1) + ")");
			}
		} finally
		{
			db.close();
		}
	}

	public GrantAccess()
	{
	}

	public static int countOrganizing(RV rv) throws SQLException
	{
		int i = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			i = db.getInt("SELECT COUNT(community) " + getOrganizingSql(rv));
		} finally
		{
			db.close();
		}
		return i;
	}

	private static String getOrganizingSql(RV rv) throws SQLException
	{
		if (rv.isWebMaster())
		{
			return " FROM Community  ";
		} else
		{
			return " FROM GrantAccess  WHERE member=" + DbAdapter.cite(rv._strR);
		}
	}

	public static Enumeration findOrganizing(RV rv) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT community " + getOrganizingSql(rv));
			while (db.next())
			{
				vector.addElement(db.getString(1));
			}
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public static boolean isGrantAccess(String s, String s1) throws SQLException
	{
		boolean flag = false;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT community   FROM GrantAccess  WHERE community=" + DbAdapter.cite(s) + " AND member=" + DbAdapter.cite(s1));
			flag = db.next();
		} finally
		{
			db.close();
		}
		return flag;
	}

	public static void deleteByCommunity(String s) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM GrantAccess  WHERE community=" + DbAdapter.cite(s));
		} finally
		{
			db.close();
		}
	}

	public static int count(String s) throws SQLException
	{
		int i = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			i = db.getInt("SELECT COUNT(community)  FROM GrantAccess  WHERE community=" + DbAdapter.cite(s));
		} finally
		{
			db.close();
		}
		return i;
	}

	public static Enumeration find(String s, int i, int j) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT member FROM GrantAccess  WHERE community=" + DbAdapter.cite(s) + " ORDER BY member ");
			for (int k = 0; k < i + j && db.next(); k++)
			{
				if (k >= i)
				{
					vector.addElement(db.getString(1));
				}
			}
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public static Enumeration find(String s, int i, int j, boolean flag) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT rmember FROM " + db.citeTab("Subscriber") + " WHERE rmember not in (SELECT member FROM GrantAccess  WHERE community=" + DbAdapter.cite(s) + ") and community=" + DbAdapter.cite(s) + " ORDER BY rmember");
			for (int k = 0; k < i + j && db.next(); k++)
			{
				if (k >= i)
				{
					vector.addElement(db.getString(1));
				}
			}
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public static void delete(String community, String s1) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM GrantAccess  WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(s1));
		} finally
		{
			db.close();
		}
	}
}
