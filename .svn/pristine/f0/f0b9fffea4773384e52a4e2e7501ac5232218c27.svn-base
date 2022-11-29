package tea.entity.node;

import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class QuizR extends Entity
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
		int k = 0;
		if (_blVoiceFlag)
		{
			Layer layer = getLayer(i);
			if (layer._abVoice == null)
			{
				DbAdapter db = new DbAdapter();
				try
				{
					// db.getInt("QuizRGetVoiceLanguage " + _nQuizR + ", " + i)
					db.executeQuery("SELECT language 	FROM QuizRLayer	   WHERE quizr=" + _nQuizR + "     AND language=" + i + "   AND voice IS NOT NULL");
					if (db.next())
					{
						k = db.getInt("SELECT " + i);
					} else
					{
						k = db.getInt("SELECT  language 	  FROM QuizRLayer	 WHERE quizr=" + _nQuizR + "   AND voice IS NOT NULL");
					}
					layer._abVoice = db.getImage("SELECT DATALENGTH(voice), voice  FROM QuizRLayer  WHERE quizr=" + _nQuizR + " AND language=" + k);
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

	public void set(int i, int j, int k, String s, boolean flag, byte abyte0[], String s1, int l, boolean flag1, byte abyte1[], boolean flag2, String s2, byte abyte2[]) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			// db.executeUpdate("QuizREdit " + _nQuizR + ", " + i + ", " + j + ", " + k + ", " +
			// DbAdapter.cite(s) + ", " + (flag ? "1" : "0") + ", " +
			// DbAdapter.cite(abyte0) + ", " + DbAdapter.cite(s1) + ", " + l + ", " +
			// (flag1 ? "1" : "0") + ", " + DbAdapter.cite(abyte1) + ", " + (
			// flag2 ? "1" : "0") + ", " + DbAdapter.cite(s2) + ", " + DbAdapter.cite(abyte2));
			db.executeUpdate("UPDATE QuizR  SET floorscore=" + i + ",   ceilscore=" + j + " WHERE quizr=" + _nQuizR);
			db.executeQuery("SELECT quizr FROM QuizRLayer WHERE quizr=" + _nQuizR + " AND language=" + k);
			if (db.next())
			{
				db.executeUpdate("UPDATE QuizRLayer   SET text=" + DbAdapter.cite(s) + ",   alt=" + DbAdapter.cite(s1) + ",   align=" + l + "	 WHERE quizr=" + _nQuizR + "   AND language=" + k);
				if ((flag ? 1 : 0) != 0 || DbAdapter.cite(abyte0) != null)
				{
					db.executeUpdate("UPDATE QuizRLayer  SET picture=" + DbAdapter.cite(abyte0) + "	 WHERE quizr=" + _nQuizR + " AND language=" + k);
				}
				if ((flag1 ? 1 : 0) != 0 || DbAdapter.cite(abyte1) != null)
				{
					db.executeUpdate("UPDATE QuizRLayer   SET voice=" + DbAdapter.cite(abyte1) + " WHERE quizr=" + _nQuizR + "  AND language=" + k);
				}
				if ((flag2 ? 1 : 0) != 0 || DbAdapter.cite(abyte2) != null)
				{
					db.executeUpdate("UPDATE QuizRLayer  SET filename=" + DbAdapter.cite(s2) + ",   filedata=" + DbAdapter.cite(abyte2) + " WHERE quizr=" + _nQuizR + " AND language=" + k);
				}
			} else
			{
				db.executeUpdate("INSERT INTO QuizRLayer (quizr, language, text, picture, alt, align, voice, filename, filedata)VALUES (" + _nQuizR + ", " + k + ", " + DbAdapter.cite(s) + ", " + DbAdapter.cite(abyte0) + ", " + DbAdapter.cite(s1) + ", " + l + ", " + DbAdapter.cite(abyte1) + ", " + DbAdapter.cite(s2) + ", " + DbAdapter.cite(abyte2) + ")");
			}
		} finally
		{
			db.close();
		}
		_nFloorScore = i;
		_nCeilScore = j;
		_htLayer.clear();
	}

	public boolean getPictureFlag() throws SQLException
	{
		load();
		return _blPictureFlag;
	}

	private QuizR(int i)
	{
		_nQuizR = i;
		_htLayer = new Hashtable();
		_blLoaded = false;
	}

	public static Enumeration findByNode(int i) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT quizr FROM QuizR WHERE node=" + i);
			for (; db.next(); vector.addElement(new Integer(db.getInt(1))))
				;
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public static void create(int i, int j, int k, int l, String s, byte abyte0[], String s1, int i1, byte abyte1[], String s2, byte abyte2[]) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		int kk = 0;
		try
		{
			db.executeUpdate("INSERT INTO QuizR (node, floorscore, ceilscore) VALUES (" + i + ", " + j + ", " + k + ")");
			kk = db.getInt("SELECT MAX(quizr) FROM QuizR");
			db.executeUpdate("INSERT INTO QuizRLayer (quizr, language, text, picture, alt, align, voice, filename, filedata)VALUES (" + kk + ", " + l + ", " + DbAdapter.cite(s) + ", " + DbAdapter.cite(abyte0) + ", " + DbAdapter.cite(s1) + "," + i1 + ", " + DbAdapter.cite(abyte1) + ", " + DbAdapter.cite(s2) + ", " + DbAdapter.cite(abyte2) + ")");
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
			db.executeQuery("SELECT quizr  FROM QuizRLayer  WHERE quizr=" + _nQuizR + " AND language=" + i);
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
					// db.getInt("QuizRGetPictureLanguage " + _nQuizR + ", " + i)
					db.equals("SELECT language 	FROM QuizRLayer   WHERE quizr=" + _nQuizR + "     AND language=" + i + "    AND picture IS NOT NULL");
					if (db.next())
					{
						k = db.getInt("SELECT " + i);
					} else
					{
						k = db.getInt("SELECT  language   FROM QuizRLayer	 WHERE quizr=" + _nQuizR + "   AND picture IS NOT NULL");
					}
					layer._abPicture = db.getImage("SELECT DATALENGTH(picture), picture  FROM QuizRLayer  WHERE quizr=" + _nQuizR + " AND language=" + k);
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
				db.executeQuery("SELECT node, floorscore, ceilscore FROM QuizR  WHERE quizr=" + _nQuizR);
				if (db.next())
				{
					_nNode = db.getInt(1);
					_nFloorScore = db.getInt(2);
					_nCeilScore = db.getInt(3);
				}
				db.executeQuery("SELECT quizr FROM QuizRLayer  WHERE quizr=" + _nQuizR + " AND picture IS NOT NULL");
				_blPictureFlag = db.next();
				db.executeQuery("SELECT quizr FROM QuizRLayer  WHERE quizr=" + _nQuizR + " AND voice IS NOT NULL");
				_blVoiceFlag = db.next();
				db.executeQuery("SELECT quizr FROM QuizRLayer  WHERE quizr=" + _nQuizR + " AND filedata IS NOT NULL");
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

	public int getFloorScore() throws SQLException
	{
		load();
		return _nFloorScore;
	}

	public int getCeilScore() throws SQLException
	{
		load();
		return _nCeilScore;
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
					// db.getInt("QuizRGetFileLanguage " + _nQuizR + ", " + i)
					db.executeQuery("SELECT language FROM QuizRLayer   WHERE quizr=" + _nQuizR + "     AND language=" + i + "    AND filedata IS NOT NULL");
					if (db.next())
					{
						k = db.getInt("SELECT " + i);
					} else
					{
						k = db.getInt("SELECT  language   FROM QuizRLayer WHERE quizr=" + _nQuizR + "  AND filedata IS NOT NULL");
					}
					layer._abFileData = db.getImage("SELECT DATALENGTH(filedata), filedata  FROM QuizRLayer  WHERE quizr=" + _nQuizR + " AND language=" + k);
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
				db.executeQuery("SELECT text FROM QuizRLayer  WHERE quizr=" + _nQuizR + " AND language=" + j);
				if (db.next())
					layer._strText = db.getText(j, i, 1);
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
			db.executeQuery("SELECT language FROM QuizRLayer WHERE quizr=" + _nQuizR);
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
			// db.executeUpdate("QuizRDeleteLayer " + _nQuizR + ", " + i);
			db.executeUpdate("DELETE FROM QuizRLayer  WHERE quizr=" + _nQuizR + "   AND language=" + i);
			db.executeQuery("SELECT quizr FROM QuizRLayer WHERE quizr=" + _nQuizR);
			if (db.next())
			{
				db.executeUpdate("DELETE FROM QuizR WHERE quizr=" + _nQuizR);
			}
		} finally
		{
			db.close();
		}
	}

	public static QuizR find(int i)
	{
		QuizR quizr = (QuizR) _cache.get(new Integer(i));
		if (quizr == null)
		{
			quizr = new QuizR(i);
			_cache.put(new Integer(i), quizr);
		}
		return quizr;
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

	private int _nQuizR;
	private int _nNode;
	private int _nFloorScore;
	private int _nCeilScore;
	private boolean _blPictureFlag;
	private boolean _blVoiceFlag;
	private boolean _blFileFlag;
	private Hashtable _htLayer;
	private boolean _blLoaded;
	private static Cache _cache = new Cache(100);

}
