package tea.entity.admin.im;

import java.io.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class Imdirectory extends Entity implements Serializable
{
	private static Cache _cache = new Cache(100);
	public static final String IMD_TYPE[] = { "按钮", "频道" };
	private int imdirectory;
	private String community;
	private String name;
	private String picture;
	private String url;
	private int type;
	private int sequence;

	public Imdirectory(int imdirectory) throws SQLException
	{
		this.imdirectory = imdirectory;
		load();
	}

	private void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT community,name,picture,url,type,sequence FROM Imdirectory WHERE imdirectory=" + imdirectory);
			if (db.next())
			{
				community = db.getString(1);
				name = db.getString(2);
				picture = db.getString(3);
				url = db.getString(4);
				type = db.getInt(5);
				sequence = db.getInt(6);
			} else
			{

			}
	} finally
		{
			db.close();
		}

	}

	public static Imdirectory find(int _nImdirectory) throws SQLException
	{
		Imdirectory obj = (Imdirectory) _cache.get(new Integer(_nImdirectory));
		if (obj == null)
		{
			obj = new Imdirectory(_nImdirectory);
			_cache.put(new Integer(_nImdirectory), obj);
		}
		return obj;
	}

	public static int create(String community, String name, String picture, String url, int type) throws SQLException
	{
		int j2 = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO Imdirectory (community,name,picture,url,type,sequence)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(picture) + "," + DbAdapter.cite(url) + "," + type + ",0)");
			j2 = db.getInt("SELECT imdirectory FROM Imdirectory ORDER BY imdirectory DESC");
	} finally
		{
			db.close();
		}
		return j2;
	}

	public void set(String name, String picture, String url, int type) throws SQLException
	{
		StringBuilder sql = new StringBuilder();
		sql.append("UPDATE Imdirectory SET name=").append(DbAdapter.cite(name));
		if (picture != null)
		{
			sql.append(",picture=").append(DbAdapter.cite(picture));
			this.picture = picture;
		}
		sql.append(",url=").append(DbAdapter.cite(url)).append(",type=").append(type).append(" WHERE imdirectory=").append(imdirectory);
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate(sql.toString());
	} finally
		{
			db.close();
		}
		this.name = name;
		this.url = url;
		this.type = type;
	}

	public void setSequence(int sequence) throws SQLException
	{
		StringBuilder sql = new StringBuilder();
		sql.append("UPDATE Imdirectory SET sequence=").append(sequence).append(" WHERE imdirectory=").append(imdirectory);
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate(sql.toString());
	} finally
		{
			db.close();
		}
		this.sequence = sequence;
	}

	public void delete() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM Imdirectory WHERE imdirectory=" + imdirectory);
	} finally
		{
			db.close();
		}
		_cache.remove(new Integer(imdirectory));
	}

	public static Enumeration find(String community, String sql, int pos, int size) throws SQLException
	{
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT imdirectory FROM Imdirectory WHERE community=" + DbAdapter.cite(community) + sql + " ORDER BY sequence");
			while (db.next())
			{
				v.addElement(new Integer(db.getInt(1)));
			}
	} finally
		{
			db.close();
		}
		return v.elements();
	}

	public int getImdirectory()
	{
		return imdirectory;
	}

	public String getCommunity()
	{
		return community;
	}

	public String getPicture()
	{
		return picture;
	}

	public String getName()
	{
		return name;
	}

	public String getUrl()
	{
		return url;
	}

	public int getType()
	{
		return type;
	}

	public int getSequence()
	{
		return sequence;
	}
}
