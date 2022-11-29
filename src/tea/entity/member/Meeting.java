package tea.entity.member;

import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import tea.translator.Translator;
import java.sql.SQLException;

public class Meeting extends Entity
{

	public int getAction() throws SQLException
	{
		load();
		return _nAction;
	}

	public static Enumeration findByMember(RV rv, int i) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT meeting  FROM Meeting  WHERE meeting>" + i + " AND ((rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV) + ") " + " OR (trmember=" + DbAdapter.cite(rv._strR) + " AND tvmember=" + DbAdapter.cite(rv._strV) + ")) " + " ORDER BY meeting ASC ");
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

	public String getAlt(int i) throws SQLException
	{
		load();
		return Translator.getInstance().translate(_strAlt, _nLanguage, i);
	}

	public byte[] getVoice() throws SQLException
	{
		load();
		if (_blVoiceFlag && _abVoice == null)
		{
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery("SELECT DATALENGTH(voice), voice  FROM Meeting  WHERE meeting=" + _nMeeting);
				if (db.next())
				{
					_abVoice = db.getImage(1);
				}
			} finally
			{
				db.close();
			}
		}
		return _abVoice;
	}

	public String getFileName() throws SQLException
	{
		load();
		return _strFileName;
	}

	public boolean getPictureFlag() throws SQLException
	{
		load();
		return _blPictureFlag;
	}

	private Meeting(int i)
	{
		_nMeeting = i;
		_blLoaded = false;
	}

	public static Meeting create(RV rv, RV rv1, int i) throws SQLException
	{
		return create(rv, rv1, i, 0, null, null, null, 0, null, null, null);
	}

	public static Meeting create(RV rvMember, RV rvTMember, int action, int language, String text, byte picture[], String alt, int align, byte voice[], String filename, byte filedata[]) throws SQLException
	{
		int l = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			if (action == 0)
			{
				db.executeUpdate("DELETE FROM Meeting  WHERE rmember=" + DbAdapter.cite(rvMember._strR) + " AND vmember=" + DbAdapter.cite(rvMember._strV) + " AND trmember=" + DbAdapter.cite(rvTMember._strR) + " AND tvmember=" + DbAdapter.cite(rvTMember._strV) + " AND action=" + 0);
				db.executeUpdate("DELETE FROM Meeting  WHERE trmember=" + DbAdapter.cite(rvMember._strR) + " AND tvmember=" + DbAdapter.cite(rvMember._strV) + " AND action=" + 1);
				db.executeUpdate("DELETE FROM Meeting  WHERE rmember=" + DbAdapter.cite(rvMember._strR) + " AND vmember=" + DbAdapter.cite(rvMember._strV) + " AND trmember=" + DbAdapter.cite(rvTMember._strR) + " AND tvmember=" + DbAdapter.cite(rvTMember._strV) + " AND action=" + 3);
				db.executeUpdate("DELETE FROM Meeting  WHERE trmember=" + DbAdapter.cite(rvMember._strR) + " AND tvmember=" + DbAdapter.cite(rvMember._strV) + " AND rmember=" + DbAdapter.cite(rvTMember._strR) + " AND vmember=" + DbAdapter.cite(rvTMember._strV) + " AND action=" + 3);
			}
			db.executeUpdate("INSERT INTO Meeting(rmember, vmember, trmember, tvmember, action, language, text, picture, alt, align, voice, filename, filedata)  VALUES(" + DbAdapter.cite(rvMember._strR) + ", " + DbAdapter.cite(rvMember._strV) + ", " + DbAdapter.cite(rvTMember._strR) + ", " + DbAdapter.cite(rvTMember._strV) + ", " + action + ", " + language + ", " + DbAdapter.cite(text) + ", " + DbAdapter.cite(picture) + ", " + DbAdapter.cite(alt) + ", " + align + ", " + DbAdapter.cite(voice)
					+ ", " + DbAdapter.cite(filename) + ", " + DbAdapter.cite(filedata) + ") ");
			l = db.getInt("SELECT MAX(meeting) FROM Meeting");
		} finally
		{
			db.close();
		}
		return find(l);
	}

	public Date getTime() throws SQLException
	{
		load();
		return _time;
	}

	public byte[] getPicture() throws SQLException
	{
		load();
		if (_blPictureFlag && _abPicture == null)
		{
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery("SELECT DATALENGTH(picture), picture  FROM Meeting  WHERE meeting=" + _nMeeting);
				if (db.next())
				{
					_abPicture = db.getImage(1);
				}
			} finally
			{
				db.close();
			}
		}
		return _abPicture;
	}

	public int getAlign() throws SQLException
	{
		load();
		return _nAlign;
	}

	public RV getFrom() throws SQLException
	{
		load();
		return _rvFrom;
	}

	public RV getTo() throws SQLException
	{
		load();
		return _rvTo;
	}

	private void load() throws SQLException
	{
		if (!_blLoaded)
		{
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery("SELECT rmember, vmember, trmember, tvmember, time, action,   language, DATALENGTH(text), text,  DATALENGTH(picture), alt, align,  DATALENGTH(voice),  filename, DATALENGTH(filedata)  FROM Meeting  WHERE meeting=" + _nMeeting);
				if (db.next())
				{
					_rvFrom = new RV(db.getString(1), db.getString(2));
					_rvTo = new RV(db.getString(3), db.getString(4));
					_time = db.getDate(5);
					_nAction = db.getInt(6);
					_nLanguage = db.getInt(7);
					_strText = db.getText(8);
					_blPictureFlag = db.getInt(10) != 0;
					_strAlt = db.getString(11);
					_nAlign = db.getInt(12);
					_blVoiceFlag = db.getInt(13) != 0;
					_strFileName = db.getString(14);
					_blFileFlag = db.getInt(15) != 0;
				}
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

	public static RV getAcker(RV rv) throws SQLException
	{
		RV rv1 = null;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT rmember, vmember  FROM Meeting  WHERE trmember=" + DbAdapter.cite(rv._strR) + " AND tvmember=" + DbAdapter.cite(rv._strV) + " AND action=" + 1);
			if (db.next())
			{
				rv1 = new RV(db.getString(1), db.getString(2));
			}
		} finally
		{
			db.close();
		}
		return rv1;
	}

	public byte[] getFileData() throws SQLException
	{
		load();
		if (_blFileFlag && _abFileData == null)
		{
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery("SELECT DATALENGTH(filedata), filedata  FROM Meeting  WHERE meeting=" + _nMeeting);
				if (db.next())
				{
					_abFileData = db.getImage(1);
				}
			} finally
			{
				db.close();
			}
		}
		return _abFileData;
	}

	public void delete() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM Meeting  WHERE meeting=" + _nMeeting);
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(_nMeeting));
	}

	public static Meeting find(int i)
	{
		Meeting meeting = (Meeting) _cache.get(new Integer(i));
		if (meeting == null)
		{
			meeting = new Meeting(i);
			_cache.put(new Integer(i), meeting);
		}
		return meeting;
	}

	public boolean getVoiceFlag() throws SQLException
	{
		load();
		return _blVoiceFlag;
	}

	public String getText(int i) throws SQLException
	{
		load();
		return Translator.getInstance().translate(_strText, _nLanguage, i);
	}

	public static Meeting findIn(RV rv) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT meeting  FROM Meeting  WHERE (trmember=" + DbAdapter.cite(rv._strR) + " OR tvmember=" + DbAdapter.cite(rv._strR) + " OR trmember=" + DbAdapter.cite(rv._strV) + " OR tvmember=" + DbAdapter.cite(rv._strV) + ") " + " AND action=" + 0);
			if (db.next())
			{
				return find(db.getInt(1));
			}
		} finally
		{
			db.close();
		}
		return null;
	}

	public static final int MEETINGA_DIALUP = 0;
	public static final int MEETINGA_ACK = 1;
	public static final int MEETINGA_MSG = 2;
	public static final int MEETINGA_HANGUP = 3;
	private int _nMeeting;
	private RV _rvFrom;
	private RV _rvTo;
	private Date _time;
	private int _nAction;
	private int _nLanguage;
	private String _strText;
	private boolean _blPictureFlag;
	private byte _abPicture[];
	private String _strAlt;
	private int _nAlign;
	private boolean _blVoiceFlag;
	private byte _abVoice[];
	private boolean _blFileFlag;
	private String _strFileName;
	private byte _abFileData[];
	private boolean _blLoaded;
	private static Cache _cache = new Cache(100);

}
