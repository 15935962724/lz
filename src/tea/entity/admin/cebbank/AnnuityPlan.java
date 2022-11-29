package tea.entity.admin.cebbank;

import tea.db.DbAdapter;
import tea.entity.*;
import java.util.*;
import java.sql.SQLException;

public class AnnuityPlan extends Entity
{
	public static Cache _cache = new Cache(100);
	private int annuityplan;
	private String community;
	private String name;
	private boolean exists;

	public AnnuityPlan(int annuityplan) throws SQLException
	{
		this.annuityplan = annuityplan;
		load();
	}

	private void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT name,community FROM annuityplan WHERE annuityplan=" + annuityplan);
			if (db.next())
			{
				name = db.getString(1);
				community = db.getString(2);
				exists=true;
			}else
			{
				exists=false;
			}
		}  finally
		{
			db.close();
		}
	}

	public static void create(int annuityplan, String name, String community) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO annuityplan(annuityplan,name,community)VALUES(" + annuityplan + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(community) + ")");
		}  finally
		{
			db.close();
		}
		_cache.remove(new Integer(annuityplan));
	}

	public void set(String name, String community) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE annuityplan SET name=" + DbAdapter.cite(name) + ",community=" + DbAdapter.cite(community) + " WHERE annuityplan=" + annuityplan);
		}  finally
		{
			db.close();
		}
		this.community = community;
		this.name = name;
	}

	public void delete() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM annuityplan WHERE annuityplan=" + annuityplan);
		}  finally
		{
			db.close();
		}
		_cache.remove(new Integer(annuityplan));
	}

	public String getName()
	{
		return name;
	}

	public int getAnnuityPlan()
	{
		return annuityplan;
	}

	public static AnnuityPlan find(int annuityplan) throws SQLException
	{
		AnnuityPlan obj = (AnnuityPlan) _cache.get(new Integer(annuityplan));
		if (obj == null)
		{
			obj = new AnnuityPlan(annuityplan);
			_cache.put(new Integer(annuityplan), obj);
		}
		return obj;
	}

	public static int count(String sql) throws SQLException
	{
		int count = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT COUNT(annuityplan) FROM annuityplan WHERE 1=1" +  sql);
			if (db.next())
			{
				count = db.getInt(1);
			}
		}  finally
		{
			db.close();
		}
		return count;
	}

	public static Enumeration find(String sql, int pos, int size) throws SQLException
	{
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT annuityplan FROM annuityplan WHERE 1=1" + sql,pos,size);
			while(db.next())
			{
					v.addElement(new Integer(db.getInt(1)));
			}
		}  finally
		{
			db.close();
		}
		return v.elements();
	}

	public String getCommunity()
	{
		return community;
	}

	public boolean isExists()
	{
		return exists;
	}
}
