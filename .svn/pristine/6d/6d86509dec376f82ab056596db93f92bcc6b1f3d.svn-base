package tea.entity.site;

import java.util.Enumeration;
import java.util.Vector;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

//过时
public class Manager extends Entity
{

	public static void create(String s, String s1) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			// db.executeUpdate("ManagerCreate " + DbAdapter.cite(s) + ", " + DbAdapter.cite(s1));
			db.executeQuery("SELECT community 	 FROM Manager	WHERE community=" + DbAdapter.cite(s) + "  AND member=" + DbAdapter.cite(s1));
			if (db.next())
			{
			} else
			{
				db.executeUpdate("INSERT INTO Manager(community, member)VALUES (" + DbAdapter.cite(s) + ", " + DbAdapter.cite(s1) + ")");
			}
		} finally
		{
			db.close();
		}
	}

	public Manager()
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
			return " FROM Community  ";
		else
			return " FROM Manager  WHERE member=" + DbAdapter.cite(rv._strR);
	}

	public static Enumeration findOrganizing(RV rv) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT community " + getOrganizingSql(rv));
			for (; db.next(); vector.addElement(db.getString(1)))
				;
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public static boolean isManager(String community, String member) throws SQLException
	{
		boolean flag = false;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT community FROM Manager WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member));
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
			db.executeUpdate("DELETE FROM Manager  WHERE community=" + DbAdapter.cite(s));
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
			i = db.getInt("SELECT COUNT(community)  FROM Manager  WHERE community=" + DbAdapter.cite(s));
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
			db.executeQuery("SELECT member FROM Manager  WHERE community=" + DbAdapter.cite(s) + " ORDER BY member ");
			for (int k = 0; k < i + j && db.next(); k++)
				if (k >= i)
					vector.addElement(db.getString(1));
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
			db.executeQuery("SELECT rmember FROM Subscriber  WHERE  rmember not in (SELECT member FROM Manager  WHERE community=" + DbAdapter.cite(s) + ") and community=" + DbAdapter.cite(s) + " ORDER BY rmember");

			for (int k = 0; k < i + j && db.next(); k++)
				if (k >= i)
					vector.addElement(db.getString(1));
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public static void delete(String s, String s1) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM Manager  WHERE community=" + DbAdapter.cite(s) + " AND member=" + DbAdapter.cite(s1));
		} finally
		{
			db.close();
		}
	}
}
