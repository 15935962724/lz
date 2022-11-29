package tea.entity.member;

import java.util.*;

import tea.db.DbAdapter;
import tea.entity.*;
import tea.translator.Translator;
import java.sql.SQLException;

public class Feedback extends Entity
{
    private static Cache _cache = new Cache(100);
    private int _nFeedback;
    private String _strMember;
    private RV _rv;
    private Date _time;
    private int _nHint;
    private int _nLanguage;
    private String _strSubject;
    private String _strContent;
    private String _strPicture;
    private String _strVoice;
    private String _strFileName;
    private String _strFileData;
    private boolean _blLoaded;
    private String _strCommunity;

    public String getVoice(int i) throws SQLException
    {
        load();
        return _strVoice;
    }

    public String getMember() throws SQLException
    {
        load();
        return _strMember;
    }

    public String getFileName(int i) throws SQLException
    {
        load();
        return _strFileName;
    }

    public void set(int hint, int language, String subject, String content, String picture, String voice, String filename, String filedata) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Feedback  SET hint=" + hint + ",language=" + language + ",subject=" + DbAdapter.cite(subject) + ",content=" + DbAdapter.cite(content) + ",picture=" + DbAdapter.cite(picture) + ",voice=" + DbAdapter.cite(voice) + ",filename=" + DbAdapter.cite(filename) + ",filedata=" + DbAdapter.cite(filedata) + " WHERE feedback=" + _nFeedback);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(_nFeedback));
    }

    public String getContent(int i) throws SQLException
    {
        load();
        if (_strContent == null)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT content FROM Feedback WHERE feedback=" + _nFeedback);
                if (db.next())
                {
                    _strContent = db.getText(1);
                }
            } finally
            {
                db.close();
            }
        }
        return Translator.getInstance().translate(_strContent, _nLanguage, i);
    }

    private Feedback(int i)
    {
        _nFeedback = i;
    }

    public static Feedback create(String community, String member, RV rv, int hint, int language, String subject, String content, String picture, String voice, String filename, String filedata) throws SQLException
    {
        int k = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Feedback(community,member, rmember, vmember, hint, language, subject,content, picture, voice, filename, filedata)VALUES (" + DbAdapter.cite(community) + "," + DbAdapter.cite(member) + ", " + DbAdapter.cite(rv._strR) + ", 	" + DbAdapter.cite(rv._strV) + ", " + hint + ", " + language + ", " + DbAdapter.cite(subject) + ",	" + DbAdapter.cite(content) + ", " + DbAdapter.cite(picture) + ", " + DbAdapter.cite(voice) + ", " + DbAdapter.cite(filename) + ", "
                             + DbAdapter.cite(filedata) + ")");
            k = db.getInt("SELECT MAX(feedback) FROM Feedback");
        } finally
        {
            db.close();
        }
        return find(k);
    }

    public Date getTime() throws SQLException
    {
        load();
        return _time;
    }

    public String getPicture(int i) throws SQLException
    {
        load();
        return _strPicture;
    }

    private void load() throws SQLException
    {
        if (!_blLoaded)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT member, rmember, vmember, time, hint, language, subject,picture,voice,filedata,filename FROM Feedback  WHERE feedback=" + _nFeedback);
                if (db.next())
                {
                    _strMember = db.getString(1);
                    _rv = new RV(db.getString(2), db.getString(3));
                    _time = db.getDate(4);
                    _nHint = db.getInt(5);
                    _nLanguage = db.getInt(6);
                    _strSubject = db.getString(7);
                    _strPicture = db.getString(8);
                    _strVoice = db.getString(9);
                    _strFileData = db.getString(10);
                    _strFileName = db.getString(11);
                }
            } finally
            {
                db.close();
            }
            _blLoaded = true;
        }
    }

    public String getFileData(int i) throws SQLException
    {
        load();

        return _strFileData;
    }

    public static void deleteByMember(String community, String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Feedback WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
        _cache.clear();
    }

    public RV getRV() throws SQLException
    {
        load();
        return _rv;
    }

    public static int count(String community, String member) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            i = db.getInt("SELECT COUNT(feedback) FROM Feedback WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
        return i;
    }

    public static Feedback find(int i)
    {
        Feedback feedback = (Feedback) _cache.get(new Integer(i));
        if (feedback == null)
        {
            feedback = new Feedback(i);
            _cache.put(new Integer(i), feedback);
        }
        return feedback;
    }

    public static Enumeration find(String community, String member, int i, int j) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT feedback FROM Feedback WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member));
            for (int k = 0; k < i + j && db.next(); k++)
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Feedback WHERE feedback=" + _nFeedback);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(_nFeedback));
    }

    public int getHint() throws SQLException
    {
        load();
        return _nHint;
    }

    public String getVoiceFlag() throws SQLException
    {
        load();
        return _strVoice;
    }

    public String getSubject(int i) throws SQLException
    {
        load();
        return Translator.getInstance().translate(_strSubject, _nLanguage, i);
    }

    public String getCommunity()
    {
        return _strCommunity;
    }

}
