package tea.entity.node;

import tea.db.*;
import tea.entity.*;
import tea.html.*;
import java.sql.SQLException;

public class DownloadAddress
{
	private static Cache _cache = new Cache(100);
	private int node;
	private int language = 1;
	private int len;
	private boolean exists;
	private int id;
	private int type;
	private String ver;
	private String content;
	private String name;
	private String url;

	public DownloadAddress()
	{
	}

	public static DownloadAddress find(int id) throws SQLException
	{
		DownloadAddress obj = (DownloadAddress) _cache.get(new Integer(id));
		if (obj == null)
		{
			obj = new DownloadAddress(id);
			_cache.put(new Integer(id), obj);
		}
		return obj;
	}

	public DownloadAddress(int id) throws SQLException
	{
		this.id = id;
		loadBasic();
	}

	public DownloadAddress(int id, int node, String name, String url, int type, String ver, String content, int len) throws SQLException
	{
		this.id = id;
		this.node = node;
		this.name = name;
		this.url = url;
		this.type = type;
		this.ver = ver;
		this.content = content;
		this.len = len;
		this.language = language;

	}

	public void set(String name, String url, int type, String ver, String content, int len, int language) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE DownloadAddress SET name=" + DbAdapter.cite(name) + " ,url=" + DbAdapter.cite(url) + " ,type=" + (type) + " ,ver=" + DbAdapter.cite(ver) + " ,content=" + DbAdapter.cite(content) + " ,len=" + (len) + " ,language=" + (language) + " WHERE id=" + id);
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(id));
	}

	public static void create(int node, String name, String url, int type, String ver, String content, int len, int language) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO DownloadAddress(node,	name,	url,type,ver,content,len,language)VALUES( " + node + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(url) + "," + (type) + "," + DbAdapter.cite(ver) + "," + DbAdapter.cite(content) + "," + (len) + "," + (language) + ")");
		} finally
		{
			db.close();
		}
	}

	public void delete(int langauge) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE DownloadAddress WHERE id=" + id);
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(id));
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT node,name    ,url     ,type    ,ver     ,content ,len,language   FROM DownloadAddress WHERE id= " + id);
			if (db.next())
			{
				node = db.getInt(1);
				name = db.getVarchar(1, 1, 2);
				url = db.getVarchar(1, 1, 3);
				type = db.getInt(4);
				ver = db.getVarchar(1, 1, 5);
				content = db.getVarchar(1, 1, 6);
				len = db.getInt(7);
				language = db.getInt(8);
			} else
			{
				exists = false;
			}
		} finally
		{
			db.close();
		}
	}

	public static java.util.Enumeration findByNode(int node) throws SQLException
	{
		java.util.Vector vector = new java.util.Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT node,name    ,url     ,type    ,ver     ,content ,len,id   FROM DownloadAddress WHERE node= " + node);
			while (db.next())
			{
				node = db.getInt(1);
				String name = db.getVarchar(1, 1, 2);
				String url = db.getVarchar(1, 1, 3);
				int type = db.getInt(4);
				String ver = db.getVarchar(1, 1, 5);
				String content = db.getVarchar(1, 1, 6);
				int len = db.getInt(7);
				int id = db.getInt(8);
				vector.addElement(new DownloadAddress(id, node, name, url, type, ver, content, len));

			}
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public void setLanguage(int language)
	{
		this.language = language;
	}

	public void setSize(int len) throws SQLException
	{
		this.len = len;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Download SET len=" + this.len + " WHERE node= " + node);
		} catch (Exception e)
		{
			e.printStackTrace();
		} finally
		{
			db.close();
		}
	}

	public int getNode()
	{
		return node;
	}

	public int getLanguage()
	{
		return language;
	}

	public int getLen()
	{
		return len;
	}

	public boolean isExists()
	{
		return exists;
	}

	public int getType()
	{
		return type;
	}

	public String getVer()
	{
		return ver;
	}

	public String getContent()
	{
		return content;
	}

	public String getName()
	{
		return name;
	}

	public String getUrl()
	{
		return url;
	}

	public int getId()
	{
		return id;
	}
}
