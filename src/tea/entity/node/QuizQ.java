package tea.entity.node;

import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class QuizQ extends Entity
{
	class Layer
	{

		String _strText;
		byte _abPicture[];
		String _strAlt;
		int _nAlign;
		byte _abVoice[];
		String _strFileName;
		byte _abFileData[];

		Layer()
		{
		}
	}

	public byte[] getVoice(int i) throws SQLException
	{
		load();
		if (_blVoiceFlag)
		{
			Layer layer = getLayer(i);
			int k = 0;
			if (layer._abVoice == null)
			{
				DbAdapter db = new DbAdapter();
				try
				{
					// db.getInt("QuizQGetVoiceLanguage " + _nQuizQ + ", " + i
					db.executeQuery("SELECT language 	FROM QuizQLayer WHERE quizq=" + _nQuizQ + "  AND language=" + i + "   AND filedata IS NOT NULL");
					if (db.next())
					{
						k = db.getInt("select " + i);
					} else
					{
						k = db.getInt("SELECT  language   FROM QuizQLayer WHERE quizq=" + _nQuizQ + " AND filedata IS NOT NULL");
					}
					layer._abVoice = db.getImage("SELECT DATALENGTH(voice), voice  FROM QuizQLayer  WHERE quizq=" + _nQuizQ + " AND language=" + k);
				} finally
				{
					db.close();
				}
			}
			return layer._abVoice;
		} else
		{
			return null;
		}
	}

	public String getFileName(int i) throws SQLException
	{
		return getLayer(i)._strFileName;
	}

	public void set(int i, String s, boolean flag, byte abyte0[], String s1, int j, boolean flag1, byte abyte1[], boolean flag2, String s2, byte abyte2[]) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			// db.executeUpdate("QuizQEdit " + _nQuizQ + ", " + i + ", " + DbAdapter.cite(s) + ", " +
			// (flag ? "1" : "0") + ", " + DbAdapter.cite(abyte0) + ", " + DbAdapter.cite(s1) + ", " + j + ", " +
			// (flag1 ? "1" : "0") + ", " + DbAdapter.cite(abyte1) + ", " + (flag2 ? "1" : "0") + ", " +
			// DbAdapter.cite(s2) + ", " + DbAdapter.cite(abyte2));

			db.executeUpdate("UPDATE QuizA   SET score=" + i + " WHERE quiza=" + _nQuizQ);
			db.executeQuery("SELECT quiza FROM QuizALayer WHERE quiza=" + _nQuizQ + " AND language=" + i);
			if (db.next())
			{
				db.executeUpdate("UPDATE QuizALayer  SET text=" + DbAdapter.cite(s) + ", alt=" + DbAdapter.cite(s1) + ",align=" + j + " WHERE quiza=" + _nQuizQ + "  AND language=" + i);
				if ((flag ? 1 : 0) != 0 || DbAdapter.cite(abyte0) != null)
				{
					db.executeUpdate("UPDATE QuizALayer  SET picture=" + DbAdapter.cite(abyte0) + " WHERE quiza=" + _nQuizQ + "   AND language=" + i);
				}
				if ((flag1 ? 1 : 0) != 0 || DbAdapter.cite(s2) != null)
				{
					db.executeUpdate("UPDATE QuizALayer  SET voice=" + DbAdapter.cite(s2) + " WHERE quiza=" + _nQuizQ + "   AND language=" + i);
				}
				if ((flag2 ? 1 : 0) != 0 || DbAdapter.cite(abyte2) != null)
				{
					db.executeUpdate("UPDATE QuizALayer  SET filename=" + DbAdapter.cite(s2) + ", filedata=" + DbAdapter.cite(abyte2) + " WHERE quiza=" + _nQuizQ + "  AND language=" + i);
				}
			} else
			{
				db.executeUpdate("INSERT INTO QuizALayer (quiza, language, text, picture, alt, align, voice, filename, filedata)VALUES (" + _nQuizQ + ", " + i + ", " + DbAdapter.cite(s) + ", " + DbAdapter.cite(abyte0) + ", " + DbAdapter.cite(s1) + ", " + j + ", " + DbAdapter.cite(abyte1) + ", " + DbAdapter.cite(s2) + ", " + DbAdapter.cite(abyte2) + ")");
			}
		} finally
		{
			db.close();
		}
		_htLayer.clear();
	}

	public boolean getPictureFlag() throws SQLException
	{
		load();
		return _blPictureFlag;
	}

	private QuizQ(int i)
	{
		_nQuizQ = i;
		_htLayer = new Hashtable();
		_blLoaded = false;
	}

	public static Enumeration findByNode(int i) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT quizq FROM QuizQ WHERE node=" + i);
			for (; db.next(); vector.addElement(new Integer(db.getInt(1))))
			{
				;
			}
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public static void create(int node, int language, String text, byte picture[], String alt, int align, byte voice[], String filename, byte filedata[]) throws SQLException
	{
		int k = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO QuizQ (node) VALUES (" + node + ")");
			k = db.getInt("select MAX(quizq) FROM QuizQ");
			db.executeUpdate("INSERT INTO QuizQLayer (quizq, language, text, picture, alt, align, voice, filename, filedata)VALUES (" + k + ", " + language + ", " + DbAdapter.cite(text) + ", " + DbAdapter.cite(picture) + "," + DbAdapter.cite(alt) + ", " + align + ", " + DbAdapter.cite(voice) + ", " + DbAdapter.cite(filename) + ", " + DbAdapter.cite(filedata) + ")");
		} finally
		{
			db.close();
		}
	}

	public boolean isLayerExisted(int i) throws SQLException
	{
		boolean flag = false;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT quizq  FROM QuizQLayer  WHERE quizq=" + _nQuizQ + " AND language=" + i);
			flag = db.next();
		} finally
		{
			db.close();
		}
		return flag;
	}

	public int getNode() throws SQLException
	{
		load();
		return _nNode;
	}

	public byte[] getPicture(int i) throws SQLException
	{
		load();
		int k = 0;
		if (_blPictureFlag)
		{
			Layer layer = getLayer(i);
			if (layer._abPicture == null)
			{
				DbAdapter db = new DbAdapter();
				try
				{
					// db.getInt("QuizQGetPictureLanguage " + _nQuizQ + ", " + i)
					db.executeQuery("SELECT language 	FROM QuizQLayer WHERE quizq=" + _nQuizQ + "  AND language=" + i + "   AND filedata IS NOT NULL");
					if (db.next())
					{
						k = db.getInt("select " + i);
					} else
					{
						k = db.getInt("SELECT  language   FROM QuizQLayer WHERE quizq=" + _nQuizQ + " AND filedata IS NOT NULL");
					}
					layer._abPicture = db.getImage("SELECT DATALENGTH(picture), picture  FROM QuizQLayer  WHERE quizq=" + _nQuizQ + " AND language=" + k);
				} finally
				{
					db.close();
				}
			}
			return layer._abPicture;
		} else
		{
			return null;
		}
	}

	public int getAlign(int i) throws SQLException
	{
		return getLayer(i)._nAlign;
	}

	private void load() throws SQLException
	{
		if (!_blLoaded)
		{
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery("SELECT node FROM QuizQ  WHERE quizq=" + _nQuizQ);
				if (db.next())
				{
					_nNode = db.getInt(1);
				}
				db.executeQuery("SELECT quizq FROM QuizQLayer  WHERE quizq=" + _nQuizQ + " AND picture IS NOT NULL");
				_blPictureFlag = db.next();
				db.executeQuery("SELECT quizq FROM QuizQLayer  WHERE quizq=" + _nQuizQ + " AND voice IS NOT NULL");
				_blVoiceFlag = db.next();
				db.executeQuery("SELECT quizq FROM QuizQLayer  WHERE quizq=" + _nQuizQ + " AND filedata IS NOT NULL");
				_blFileFlag = db.next();
			} finally
			{
				db.close();
			}
			_blLoaded = true;
		}
	}

	public boolean getFileFlag() throws SQLException
	{
		load();
		return _blFileFlag;
	}

	public byte[] getFileData(int i) throws SQLException
	{
		load();
		int k = 0;
		if (_blFileFlag)
		{
			Layer layer = getLayer(i);
			if (layer._abFileData == null)
			{
				DbAdapter db = new DbAdapter();
				try
				{
					// db.getInt("QuizQGetFileLanguage " + _nQuizQ + ", " + i)
					db.executeQuery("SELECT language 	FROM QuizQLayer WHERE quizq=" + _nQuizQ + "  AND language=" + i + "   AND filedata IS NOT NULL");
					if (db.next())
					{
						k = db.getInt("select " + i);
					} else
					{
						k = db.getInt("SELECT  language   FROM QuizQLayer WHERE quizq=" + _nQuizQ + " AND filedata IS NOT NULL");
					}
					layer._abFileData = db.getImage("SELECT DATALENGTH(filedata), filedata  FROM QuizQLayer  WHERE quizq=" + _nQuizQ + " AND language=" + k);
				} finally
				{
					db.close();
				}
			}
			return layer._abFileData;
		} else
		{
			return null;
		}
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
				db.executeQuery("SELECT text FROM QuizQLayer WHERE quizq=" + _nQuizQ + " AND language=" + j);
				if (db.next())
				{
					layer._strText = db.getText(j, i, 1);
				}
			} finally
			{
				db.close();
			}
			_htLayer.put(new Integer(i), layer);
		}
		return layer;
	}

	public void delete(int i) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			// db.executeUpdate("QuizQDeleteLayer " + _nQuizQ + ", " + i);
			db.executeQuery("SELECT quizq FROM QuizQLayer WHERE quizq=" + _nQuizQ);
			if (!db.next())
			{
				db.executeUpdate("DELETE FROM QuizQ WHERE quizq=" + _nQuizQ);
			}
		} finally
		{
			db.close();
		}
	}

	private int getLanguage(int language) throws SQLException
	{
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT language FROM QuizQLayer WHERE quizq=" + _nQuizQ);
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

	public static QuizQ find(int i)
	{
		QuizQ quizq = (QuizQ) _cache.get(new Integer(i));
		if (quizq == null)
		{
			quizq = new QuizQ(i);
			_cache.put(new Integer(i), quizq);
		}
		return quizq;
	}

	public boolean getVoiceFlag() throws SQLException
	{
		load();
		return _blVoiceFlag;
	}

	public String getText(int i) throws SQLException
	{
		return getLayer(i)._strText;
	}

	public String getAlt(int i) throws SQLException
	{
		return getLayer(i)._strAlt;
	}

	private int _nQuizQ;
	private int _nNode;
	private boolean _blPictureFlag;
	private boolean _blVoiceFlag;
	private boolean _blFileFlag;
	private Hashtable _htLayer;
	private boolean _blLoaded;
	private static Cache _cache = new Cache(100);

}
