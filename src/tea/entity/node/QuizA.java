package tea.entity.node;

import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class QuizA extends Entity
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
			if (layer._abVoice == null)
			{
				int k = 0;
				DbAdapter db = new DbAdapter();
				try
				{
					// db.getInt("QuizAGetVoiceLanguage " + _nQuizA + ", " + i)
					db.executeQuery("SELECT language 	FROM QuizALayer  WHERE quiza=" + _nQuizA + "  AND language=" + i + "  AND picture IS NOT NULL");
					if (db.next())
					{
						k = db.getInt("SELECT " + i);
					} else
					{
						k = db.getInt("SELECT  language   FROM QuizALayer WHERE quiza=" + _nQuizA + "   AND picture IS NOT NULL");
					}
					layer._abVoice = db.getImage("SELECT DATALENGTH(voice), voice  FROM QuizALayer  WHERE quiza=" + _nQuizA + " AND language=" + k);
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

	public void set(int i, int j, String s, boolean flag, byte abyte0[], String s1, int k, boolean flag1, byte abyte1[], boolean flag2, String s2, byte abyte2[]) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			/*
			 * db.executeUpdate("QuizAEdit " + _nQuizA + ", " + i + ", " + j + ", " + DbAdapter.cite(s) + ", " + (flag ? "1" : "0") + ", " + DbAdapter.cite(abyte0) + ", " + DbAdapter.cite(s1) + ", " + k + ", " + (flag1 ? "1" : "0") + ", " + DbAdapter.cite(abyte1) + ", " + (flag2 ? "1" : "0") + ", " + DbAdapter.cite(s2) + ", " + DbAdapter.cite(abyte2));
			 */
			db.executeUpdate("UPDATE QuizA   SET score=" + i + " WHERE quiza=" + _nQuizA);
			db.executeQuery("SELECT quiza FROM QuizALayer WHERE quiza=" + _nQuizA + " AND language=" + j);
			if (db.next())
			{
				db.executeUpdate("UPDATE QuizALayer  SET text=" + DbAdapter.cite(s) + ", alt=" + DbAdapter.cite(s1) + ",align=" + k + " WHERE quiza=" + _nQuizA + "  AND language=" + j);
				if ((flag ? 1 : 0) != 0 || DbAdapter.cite(abyte0) != null)
				{
					db.executeUpdate("UPDATE QuizALayer  SET picture=" + DbAdapter.cite(abyte0) + " WHERE quiza=" + _nQuizA + "   AND language=" + j);
				}
				if ((flag1 ? 1 : 0) != 0 || DbAdapter.cite(s2) != null)
				{
					db.executeUpdate("UPDATE QuizALayer  SET voice=" + DbAdapter.cite(s2) + " WHERE quiza=" + _nQuizA + "   AND language=" + j);
				}
				if ((flag2 ? 1 : 0) != 0 || DbAdapter.cite(abyte2) != null)
				{
					db.executeUpdate("UPDATE QuizALayer  SET filename=" + DbAdapter.cite(s2) + ", filedata=" + DbAdapter.cite(abyte2) + " WHERE quiza=" + _nQuizA + "  AND language=" + j);
				}
			} else
			{
				db.executeUpdate("INSERT INTO QuizALayer (quiza, language, text, picture, alt, align, voice, filename, filedata)VALUES (" + _nQuizA + ", " + j + ", " + DbAdapter.cite(s) + ", " + DbAdapter.cite(abyte0) + ", " + DbAdapter.cite(s1) + ", " + k + ", " + DbAdapter.cite(abyte1) + ", " + DbAdapter.cite(s2) + ", " + DbAdapter.cite(abyte2) + ")");
			}
		} finally
		{
			db.close();
		}
		_nScore = i;
		_htLayer.clear();
	}

	public boolean getPictureFlag() throws SQLException
	{
		load();
		return _blPictureFlag;
	}

	private QuizA(int i)
	{
		_nQuizA = i;
		_htLayer = new Hashtable();
		_blLoaded = false;
	}

	public static void create(int i, int j, int k, String s, byte abyte0[], String s1, int l, byte abyte1[], String s2, byte abyte2[]) throws SQLException
	{
		int kk = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO QuizA (quizq, score) VALUES (" + i + ", " + j + ")");
			kk = db.getInt("SELECT MAX(quiza) FROM QuizA");
			db.executeUpdate("INSERT INTO QuizALayer (quiza, language, text, picture, alt, align, voice, filename, filedata)VALUES (" + kk + ", " + k + ", " + DbAdapter.cite(s) + ", " + DbAdapter.cite(abyte0) + ", " + DbAdapter.cite(s1) + ", 	" + l + ", " + DbAdapter.cite(abyte1) + ", " + DbAdapter.cite(s2) + ", " + DbAdapter.cite(abyte2) + ")");
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
			db.executeQuery("SELECT quiza  FROM QuizALayer  WHERE quiza=" + _nQuizA + " AND language=" + i);
			flag = db.next();
		} finally
		{
			db.close();
		}
		return flag;
	}

	public int getScore() throws SQLException
	{
		load();
		return _nScore;
	}

	public byte[] getPicture(int i) throws SQLException
	{
		load();
		if (_blPictureFlag)
		{
			int k = 0;
			Layer layer = getLayer(i);
			if (layer._abPicture == null)
			{
				DbAdapter db = new DbAdapter();
				try
				{
					// db.getInt("QuizAGetPictureLanguage " + _nQuizA + ", " + i)
					db.executeQuery("SELECT language 	FROM QuizALayer  WHERE quiza=" + _nQuizA + "  AND language=" + i + "  AND picture IS NOT NULL");
					if (db.next())
					{
						k = db.getInt("SELECT " + i);
					} else
					{
						k = db.getInt("SELECT  language   FROM QuizALayer WHERE quiza=" + _nQuizA + "   AND picture IS NOT NULL");
					}
					layer._abPicture = db.getImage("SELECT DATALENGTH(picture), picture  FROM QuizALayer  WHERE quiza=" + _nQuizA + " AND language=" + k);
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

	public static Enumeration findByQuizQ(int i) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT quiza FROM QuizA WHERE quizq=" + i);
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

	public int getQuizQ() throws SQLException
	{
		load();
		return _nQuizQ;
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
				db.executeQuery("SELECT quizq, score FROM QuizA  WHERE quiza=" + _nQuizA);
				if (db.next())
				{
					_nQuizQ = db.getInt(1);
					_nScore = db.getInt(2);
				}
				db.executeQuery("SELECT quiza FROM QuizALayer  WHERE quiza=" + _nQuizA + " AND picture IS NOT NULL");
				_blPictureFlag = db.next();
				db.executeQuery("SELECT quiza FROM QuizALayer  WHERE quiza=" + _nQuizA + " AND voice IS NOT NULL");
				_blVoiceFlag = db.next();
				db.executeQuery("SELECT quiza FROM QuizALayer  WHERE quiza=" + _nQuizA + " AND filedata IS NOT NULL");
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

					// db.getInt("QuizAGetFileLanguage " + _nQuizA + ", " + i)
					db.executeQuery("SELECT language 	FROM QuizALayer  WHERE quiza=" + _nQuizA + "   AND language=" + i + "  AND filedata IS NOT NULL");
					if (db.next())
					{
						k = db.getInt("SELECT " + i);
					} else
					{
						k = db.getInt("SELECT  language FROM QuizALayer WHERE quiza=" + _nQuizA + "  AND filedata IS NOT NULL");
					}
					layer._abFileData = db.getImage("SELECT DATALENGTH(filedata), filedata  FROM QuizALayer  WHERE quiza=" + _nQuizA + " AND language=" + k);
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
				db.executeQuery("SELECT text FROM QuizALayer WHERE quiza=" + _nQuizA + " AND language=" + j);
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

	private int getLanguage(int language) throws SQLException
	{
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT language FROM QuizALayer WHERE quiza=" + _nQuizA);
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
			// db.executeUpdate("QuizADeleteLayer " + _nQuizA + ", " + i);
			db.executeUpdate("DELETE FROM QuizALayer  WHERE quiza=" + _nQuizA + "   AND language=" + i);
			db.executeQuery("SELECT quiza FROM QuizALayer WHERE quiza=" + _nQuizA);
			if (!db.next())
			{
				db.executeUpdate("DELETE FROM QuizA WHERE quiza=" + _nQuizA);
			}
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(_nQuizA));
	}

	public static QuizA find(int i)
	{
		QuizA quiza = (QuizA) _cache.get(new Integer(i));
		if (quiza == null)
		{
			quiza = new QuizA(i);
			_cache.put(new Integer(i), quiza);
		}
		return quiza;
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

	private int _nQuizA;
	private int _nQuizQ;
	private int _nScore;
	private boolean _blPictureFlag;
	private boolean _blVoiceFlag;
	private boolean _blFileFlag;
	private Hashtable _htLayer;
	private boolean _blLoaded;
	private static Cache _cache = new Cache(100);

}
