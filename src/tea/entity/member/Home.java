package tea.entity.member;

import java.util.Date;
import java.util.Hashtable;

import tea.db.DbAdapter;
import tea.entity.*;
import java.util.*;
import java.sql.SQLException;

public class Home extends Entity
{
	class Layer
	{

		public String _strContent;
		public String _strPicture;
		public String _strVoice;
		public String _strFile;
		public String _strFileName;

		Layer()
		{
		}
	}

	public String getFileName(int i) throws SQLException
	{
		return getLayer(i)._strFileName;
	}

	public void set(int language, String content, String picture, String voice, String filedata, String filename) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			/*
			 * db.executeUpdate("HomeEdit " + DbAdapter.cite(_strCommunity) + "," + DbAdapter.cite(_strMember) + ", " + DbAdapter.cite(new Date(System.currentTimeMillis())) + ", " + language + ", " + DbAdapter.cite(content) + ", " + DbAdapter.cite(picture) + ", " + DbAdapter.cite(voice) + ", " + DbAdapter.cite(filedata) + ", " + DbAdapter.cite(filename));
			 */
			db.executeQuery("SELECT member 	FROM HomeLayer	WHERE community=" + DbAdapter.cite(_strCommunity) + " AND member=" + DbAdapter.cite(_strMember) + " AND language=" + language);
			if (db.next())
			{
				db.executeUpdate("UPDATE HomeLayer SET time=" + DbAdapter.cite(new Date(System.currentTimeMillis())) + ", content=" + DbAdapter.cite(content) + ",picture=" + DbAdapter.cite(picture) + ",voice=" + DbAdapter.cite(voice) + ",filename=" + DbAdapter.cite(filename) + ", filedata=" + DbAdapter.cite(filedata) + " WHERE community=" + DbAdapter.cite(_strCommunity) + " AND member=" + DbAdapter.cite(_strMember) + " AND language=" + language);
			} else
			{
				db.executeUpdate("INSERT INTO HomeLayer (community,member,time, language, content, picture, voice, filename, filedata)VALUES (" + DbAdapter.cite(_strCommunity) + "," + DbAdapter.cite(_strMember) + ", " + DbAdapter.cite(new Date(System.currentTimeMillis())) + "," + language + ", " + DbAdapter.cite(content) + ", " + DbAdapter.cite(picture) + ", " + DbAdapter.cite(voice) + ", " + DbAdapter.cite(filename) + ", " + DbAdapter.cite(filedata) + ")");
			}
		} finally
		{
			db.close();
		}
		_htLayer.clear();
	}

	public String getContent(int i) throws SQLException
	{
		loadBasic();
		return getLayer(i)._strContent;
	}

	private Home(String community, String member)
	{
		_strCommunity = community;
		_strMember = member;
		_blLoaded = false;
		_htLayer = new Hashtable();
	}

	public static Home create(String community, String member, int language, String content, String picture, String voice, String filedata, String filename) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			// db.executeUpdate("HomeCreate " + DbAdapter.cite(community) + ","
			// + DbAdapter.cite(member) + ", " + DbAdapter.cite(new Date(System.currentTimeMillis()))
			// + ", " + language + ", " + DbAdapter.cite(content) + ", " + DbAdapter.cite(picture)
			// + ", " + DbAdapter.cite(voice) + ", " + DbAdapter.cite(filedata) + ", "
			// + DbAdapter.cite(filename));
			db.executeUpdate("INSERT INTO HomeLayer (community,member,time, language, content, picture, voice, filename, filedata)VALUES (" + DbAdapter.cite(community) + "," + DbAdapter.cite(member) + ", " + DbAdapter.cite(new Date(System.currentTimeMillis())) + "," + language + "," + DbAdapter.cite(content) + ", " + DbAdapter.cite(picture) + ", " + DbAdapter.cite(voice) + ", " + DbAdapter.cite(filedata) + ", " + DbAdapter.cite(filename) + ")");
		} finally
		{
			db.close();
		}
		_cache.remove(community + ":" + member);
		return find(community, member);
	}

	public boolean isLayerExisted(int i) throws SQLException
	{
		boolean flag = false;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT member  FROM HomeLayer  WHERE community=" + DbAdapter.cite(_strCommunity) + " AND member=" + DbAdapter.cite(_strMember) + " AND language=" + i);
			flag = db.next();
		} finally
		{
			db.close();
		}
		return flag;
	}

	public String getPicture(int i) throws SQLException
	{
		loadBasic();
		Layer layer = getLayer(i);
		if (layer._strPicture == null)
		{
			int k = 0;
			DbAdapter db = new DbAdapter();
			try
			{
				// + DbAdapter.cite(_strCommunity) + "," + DbAdapter.cite(_strMember) + ", " + i));
				db.executeQuery("SELECT language 	FROM HomeLayer WHERE member=" + DbAdapter.cite(_strMember) + " AND community=" + DbAdapter.cite(_strCommunity) + "  AND language=" + i + " AND picture IS NOT NULL");
				if (db.next())
				{
					k = db.getInt("SELECT " + i);
				} else
				{
					k = db.getInt("SELECT language  FROM HomeLayer WHERE member=" + DbAdapter.cite(_strMember) + " AND community=" + DbAdapter.cite(_strCommunity) + "  AND picture IS NOT NULL");
				}
				layer._strPicture = db.getString("SELECT picture  FROM HomeLayer  WHERE community=" + DbAdapter.cite(_strCommunity) + " AND member=" + DbAdapter.cite(_strMember) + " AND language=" + k);
			} finally
			{
				db.close();
			}
		}
		return layer._strPicture;

	}

	private void loadBasic() throws SQLException
	{
		/*
		 * if (!_blLoaded) { DbAdapter db = new DbAdapter(); try { db.executeQuery("SELECT member FROM HomeLayer WHERE community=" + DbAdapter.cite(_strCommunity) + " AND member=" + DbAdapter.cite(_strMember) + " AND picture IS NOT NULL"); _blPictureFlag = db.next(); db.executeQuery("SELECT member FROM HomeLayer WHERE community=" + DbAdapter.cite(_strCommunity) + " AND member=" + DbAdapter.cite(_strMember) + " AND voice IS NOT NULL"); _blVoiceFlag = db.next(); db.executeQuery("SELECT member FROM
		 * HomeLayer WHERE community=" + DbAdapter.cite(_strCommunity) + " AND member=" + DbAdapter.cite(_strMember) + " AND filedata IS NOT NULL"); _blFileFlag = db.next();} finally { db.close(); } _blLoaded = true; }
		 */
	}

	public String getFile(int i) throws SQLException
	{

		Layer layer = getLayer(i);
		if (layer._strFile == null)
		{
			int k = 0;
			DbAdapter db = new DbAdapter();
			try
			{
				// db.getInt("HomeGetFileLanguage " + DbAdapter.cite(_strCommunity) + "," + DbAdapter.cite(_strMember) + ", " + i)
				db.executeQuery("SELECT language FROM HomeLayer  WHERE community=" + DbAdapter.cite(_strCommunity) + " AND  member=" + DbAdapter.cite(_strMember) + "   AND language=" + i + " AND filedata IS NOT NULL");
				if (db.next())
				{
					k = db.getInt("SELECT " + i);
				} else
				{
					k = db.getInt("SELECT  language  FROM HomeLayer WHERE community=" + DbAdapter.cite(_strCommunity) + " AND member=" + DbAdapter.cite(_strMember) + "  AND filedata IS NOT NULL");
				}
				layer._strFile = db.getString("SELECT filedata  FROM HomeLayer  WHERE community=" + DbAdapter.cite(_strCommunity) + " AND member=" + DbAdapter.cite(_strMember) + " AND language=" + k);
			} finally
			{
				db.close();
			}
		}
		return layer._strFile;
	}

	private Layer getLayer(int i) throws SQLException
	{
		Layer layer = (Layer) _htLayer.get(new Integer(i));
		if (layer == null)
		{
			layer = new Layer();
			int j = this.getLanguage(i);
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery("SELECT content,filename FROM HomeLayer  WHERE community=" + DbAdapter.cite(_strCommunity) + " AND member=" + DbAdapter.cite(_strMember) + " AND language=" + j);
				if (db.next())
				{
					layer._strContent = db.getText(j, i, 1);
					layer._strFileName = db.getString(2);
				}
			} finally
			{
				db.close();
			}
			_htLayer.put(new Integer(i), layer);
		}
		return layer;
	}

	private int getLanguage(int language) throws SQLException
	{
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT language FROM HomeLayer WHERE community=" + DbAdapter.cite(_strCommunity) + " and member=" + DbAdapter.cite(_strMember));
			while (db.next())
			{
				v.addElement(new Integer(db.getInt(1)));
			}
		} finally
		{
			db.close();
		}
		if (v.indexOf(new Integer(language)) != -1)
			return language;
		else
		{			if (language == 1)
			{
				if (v.indexOf(new Integer(2)) != -1)
					return 2;
			} else if (language == 2)
			{
				if (v.indexOf(new Integer(1)) != -1)
					return 1;
			}
			if (v.size() < 1)
				return 0;
		}
		return ((Integer) v.elementAt(0)).intValue();
	}

	public void delete(int i) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM HomeLayer  WHERE community=" + DbAdapter.cite(_strCommunity) + " AND member=" + DbAdapter.cite(_strMember) + " AND language=" + i);
		} finally
		{
			db.close();
		}
		_cache.remove(_strCommunity + ":" + _strMember);
	}

	public static Home find(String community, String member)
	{
		Home home = (Home) _cache.get(community + ":" + member);
		if (home == null)
		{
			home = new Home(community, member);
			_cache.put(community + ":" + member, home);
		}
		return home;
	}

	public String getVoice(int i) throws SQLException
	{
		loadBasic();
		Layer layer = getLayer(i);
		if (layer._strVoice == null)
		{
			int k = 0;
			DbAdapter db = new DbAdapter();
			try
			{
				// HomeGetVoiceLanguage " + DbAdapter.cite(_strCommunity) + "," + DbAdapter.cite(_strMember) + ", " + i)
				db.executeQuery("SELECT language 	FROM HomeLayer	   WHERE member=" + DbAdapter.cite(_strMember) + " AND community=" + DbAdapter.cite(_strCommunity) + "   AND language=" + i + "   AND voice IS NOT NULL");
				if (db.next())
				{
					k = db.getInt("SELECT " + i);
				} else
				{
					k = db.getInt("SELECT  language   FROM HomeLayer WHERE member=" + DbAdapter.cite(_strMember) + " AND community=" + DbAdapter.cite(_strCommunity) + "   AND voice IS NOT NULL");
				}
				layer._strVoice = db.getString("SELECT  voice  FROM HomeLayer  WHERE community=" + DbAdapter.cite(_strCommunity) + " AND member=" + DbAdapter.cite(_strMember) + " AND language=" + k);
			} finally
			{
				db.close();
			}
		}
		return layer._strVoice;
	}

	public String getCommunity()
	{
		return _strCommunity;
	}

	private String _strMember;

	private boolean _blLoaded;
	private Hashtable _htLayer;
	private static Cache _cache = new Cache(100);
	private String _strCommunity;

}
