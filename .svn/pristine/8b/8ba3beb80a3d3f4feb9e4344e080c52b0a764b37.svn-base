package tea.entity.admin;

import java.io.*;
import java.util.Date;
import tea.db.DbAdapter;
import java.sql.SQLException;
import tea.entity.*;

public class Sort extends Entity
{
	private int id;
	private String sortname;
	private String community;
	private String member;

	private boolean exists;
	private static Cache _cache = new Cache(100);

	public Sort(int id) throws SQLException
	{
		this.id = id;
		load();
	}

	public static Sort find(int id) throws SQLException
	{
		return new Sort(id);
	}

	public void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("select sortname,community,member from Sort where id=" + id);
			if (db.next())
			{
				sortname = db.getVarchar(1, 1, 1);
				community = db.getVarchar(1, 1, 2);
				member = db.getVarchar(1, 1, 3);
				this.exists = true;
			} else
			{
				this.exists = false;
			}} finally
		{
			db.close();
		}
	}

	public static int create(String community, RV _rv, String sortname) throws SQLException
	{
		int id = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO Sort(community,member,sortname) VALUES(" + DbAdapter.cite(community) + ",'" + _rv + "'," + DbAdapter.cite(sortname) + ")");
			id = db.getInt("SELECT MAX(id) FROM Sort");} finally
		{
			db.close();
		}
		_cache.remove(new Integer(id));
		return id;
	}

	public void set(String sortname) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Sort set sortname=" + DbAdapter.cite(sortname) + " where id =" + id);} finally
		{
			db.close();
		}

	}

	public static java.util.Enumeration findByCommunity(String community, String sql) throws SQLException
	{
		java.util.Vector vector = new java.util.Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT id FROM Sort WHERE community=" + DbAdapter.cite(community) + sql);

			while (db.next())
			{
				vector.addElement(new Integer(db.getInt(1)));
			}} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public void delete() throws SQLException, SQLException
	{

		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate(" delete from Sort where id =" + id);} finally
		{
			db.close();
		}

	}

	public String getSortname()
	{
		return sortname;
	}

	public String getCommunity()
	{
		return community;
	}

	public String getMember()
	{
		return member;
	}
}
