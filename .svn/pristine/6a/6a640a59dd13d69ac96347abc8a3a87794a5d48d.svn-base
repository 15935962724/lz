package tea.entity.node;

import java.util.Hashtable;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class Custom extends Entity
{
	class Layer
	{

		public String _strName;
		public String _strSex;
		public String _strAdress;
		public String _strTelephone;

		Layer()
		{
		}
	}

	public void set(int i, String s, String s1, String s2, String s3) throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("CustomEdit " + _nNode + ", " + i + ", " + DbAdapter.cite(s) + ", " + DbAdapter.cite(s1) + ", " + DbAdapter.cite(s2) + ", " + DbAdapter.cite(s3));
		} finally
		{
			dbadapter.close();
		}
		_htLayer.clear();
	}

	private Custom(int i)
	{
		_nNode = i;
		_htLayer = new Hashtable();
	}

	public boolean isLayerExisted(int i) throws SQLException
	{
		boolean flag = false;
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeQuery("SELECT node  FROM Custom  WHERE node=" + _nNode + " AND language=" + i);
			flag = dbadapter.next();
		} finally
		{
			dbadapter.close();
		}
		return flag;
	}

	public String getName(int i) throws SQLException
	{
		return getLayer(i)._strName;
	}

	public String getSex(int i) throws SQLException
	{
		return getLayer(i)._strSex;
	}

	public String getAdress(int i) throws SQLException
	{
		return getLayer(i)._strAdress;
	}

	public String getTelephone(int i) throws SQLException
	{
		return getLayer(i)._strTelephone;
	}

	private Layer getLayer(int i) throws SQLException
	{
		Layer layer = (Layer) _htLayer.get(new Integer(i));
		if (layer == null)
		{
			layer = new Layer();
			DbAdapter dbadapter = new DbAdapter();
			try
			{
				int j = dbadapter.getInt("CustomGetLanguage " + _nNode + ", " + i);
				dbadapter.executeQuery("SELECT cname,sex,adress,teletphone  FROM Custom  WHERE node=" + _nNode + " AND language=" + j);
				if (dbadapter.next())
				{
					layer._strName = dbadapter.getVarchar(j, i, 1);
					layer._strSex = dbadapter.getVarchar(j, i, 2);
					layer._strAdress = dbadapter.getVarchar(j, i, 3);
					layer._strTelephone = dbadapter.getVarchar(j, i, 4);
				}
			} finally
			{
				dbadapter.close();
			}
			_htLayer.put(new Integer(i), layer);
		}
		return layer;
	}

	public void delete(int i) throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("DELETE FROM Custom  WHERE node=" + _nNode + " AND language=" + i);
		} finally
		{
			dbadapter.close();
		}
		_htLayer.remove(new Integer(i));
	}

	public static Custom find(int i)
	{
		Custom custom = (Custom) _cache.get(new Integer(i));
		if (custom == null)
		{
			custom = new Custom(i);
			_cache.put(new Integer(i), custom);
		}
		return custom;
	}

	private int _nNode;
	private Hashtable _htLayer;
	private static Cache _cache = new Cache(100);

}
