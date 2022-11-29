package tea.entity.node;

import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.translator.*;

public class PollResult extends Entity
{
    private static Cache _cache = new Cache(100);
    private int _nPollResult;
    private int _nPoll;
    private RV _rv;
    private Date _time;
    private int _nAnswer;
    private int _nLanguage;
    private String _strText;
    private boolean _blVoiceFlag;
    private byte _abVoice[];
    private boolean _blLoaded;
    private int node;

    public RV getMember() throws SQLException
    {
        load();
        return _rv;
    }

    private PollResult(int i)
    {
        _nPollResult = i;
        _blLoaded = false;
    }

    public static void create(int node,int _nPoll,RV rv,int answer,int langu,String text,byte voice[]) throws SQLException
    {
        String r = "";
        String v = "";
        if(rv != null)
        {
            r = rv._strR;
            v = rv._strV;
        }
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO PollResult(node,poll, rmember, vmember,time, answer, language, text, voice)  VALUES(" + node + "," + _nPoll + ", " + DbAdapter.cite(r) + ", " + DbAdapter.cite(v) + "," + DbAdapter.cite(new Date()) + ", " + answer + ", " + langu + ", " + DbAdapter.cite(text) + ", " + DbAdapter.cite(voice) + ") ");
        } finally
        {
            db.close();
        }
    }

    public static boolean isVoted(int node,RV rv) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT pollresult  FROM PollResult  WHERE node=" + node + " AND rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV));
            flag = db.next();
        } finally
        {
            db.close();
        }
        return flag;
    }


    public static boolean isVoted(int node,RV rv,int poll,int answer) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT pollresult  FROM PollResult  WHERE node=" + node + " AND poll =" + poll + " AND answer=" + answer + " AND rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV));

            flag = db.next();
        } finally
        {
            db.close();
        }
        return flag;
    }


    public static int findPointByMember(String member,String community) throws SQLException
    {
        int point = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT poll,answer FROM PollResult  WHERE node IN (SELECT node FROM Node WHERE community=" + DbAdapter.cite(community) + ") AND rmember=" + DbAdapter.cite(member) + " AND vmember=" + DbAdapter.cite(member));
            while(db.next())
            {
                Poll obj = Poll.find(db.getInt(1));
                if(obj.getCorrect() == db.getInt(2))
                {
                    point += obj.getPoint();
                }
            }
        } finally
        {
            db.close();
        }
        return point;
    }


    public int getPoll() throws SQLException
    {
        load();
        return _nPoll;
    }

    public Date getTime() throws SQLException
    {
        load();
        return _time;
    }

    public String getTimeToString() throws SQLException
    {
        load();
        if(_time == null)
        {
            return "";
        }
        return sdf2.format(_time);
    }


    public static java.util.Date getStartTime(int _nPoll,int langu) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT  time FROM PollResult  WHERE poll=" + _nPoll + " and language=" + langu + " ORDER BY time");
            if(db.next())
            {
                return db.getDate(1);
            }
        } finally
        {
            db.close();
        }
        return null;
    }

    private void load() throws SQLException
    {
        if(!_blLoaded)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT node,poll,rmember, vmember, time, answer, language,text," + db.length("voice") + " FROM PollResult WHERE pollresult=" + _nPollResult);
                if(db.next())
                {
                    node = db.getInt(1);
                    _nPoll = db.getInt(2);
                    _rv = new RV(db.getString(3),db.getString(4));
                    _time = db.getDate(5);
                    _nAnswer = db.getInt(6);
                    _nLanguage = db.getInt(7);
                    _strText = db.getText(_nLanguage,_nLanguage,8);
                    _blVoiceFlag = db.getInt(9) != 0;
                }
            } finally
            {
                db.close();
            }
            _blLoaded = true;
        }
    }

    public static int getResult(int _nPoll,int langu,int answer,int time,boolean percent) throws SQLException
    {
        String timeSql;
        DbAdapter db = new DbAdapter();
        switch(time)
        {
        case 1: //总
            timeSql = "";
            break;
        case 2: //月
            timeSql = " AND time>=" + DbAdapter.cite(new Date(System.currentTimeMillis() - (30L * 24L * 60L * 60L * 1000L)));
            break;
        default: //周
            timeSql = " AND time>=" + DbAdapter.cite(new Date(System.currentTimeMillis() - (7 * 24 * 60 * 60 * 1000)));
        }
        db.close();
        return getResult(_nPoll,langu,answer,timeSql,percent);
    }

    public static int getResult(int _nPoll,int langu,int answer,String sqlWhereTime,boolean percent) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if(percent) //投票结果是否是你百分比的方式输出,百分比的算法是 "XXX投票数/最大数投票数"
            {
                int big = db.getInt("SELECT COUNT(poll)  FROM PollResult  WHERE poll=" + _nPoll + "  AND language=" + langu + sqlWhereTime + " group by answer order by COUNT(poll) desc");
                if(big != 0)
                {
                    return(int) (100f * (((float) db.getInt("SELECT COUNT(poll)  FROM PollResult  WHERE poll=" + _nPoll + " AND answer=" + answer + sqlWhereTime)) / ((float) big))); //(100 / big) * db.getInt("SELECT COUNT(node)  FROM PollResult  WHERE node=" + node + " AND answer=" + answer + timeSql);
                }
            } else
            {
//System.out.print("SELECT COUNT(poll)  FROM PollResult  WHERE poll=" + _nPoll + " AND answer=" + answer + sqlWhereTime);
                return db.getInt("SELECT COUNT(poll)  FROM PollResult  WHERE poll=" + _nPoll + " AND answer=" + answer + sqlWhereTime);

            }
        } finally
        {
            db.close();
        }
        return 0;
    }

    public static int count(String sql) throws SQLException
    {
        int c = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM PollResult WHERE 1=1" + sql.toString());
            if(db.next())
            {
                c = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return c;
    }


    public int getAnswer() throws SQLException
    {
        load();
        return _nAnswer;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM PollResult  WHERE pollresult=" + _nPollResult);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(_nPollResult));
    }

    public static PollResult find(int i)
    {
    	PollResult pollresult = (PollResult) _cache.get(new Integer(i));
        if(pollresult == null)
        {
            pollresult = new PollResult(i);
            _cache.put(new Integer(i),pollresult);
        }
        return pollresult;
    }

    public static PollResult find(int _nPoll,String member) throws SQLException
    {
        int pollresult = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT pollresult FROM PollResult WHERE poll=" + _nPoll + " AND vmember=" + DbAdapter.cite(member));
            if(db.next())
            {
                pollresult = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return find(pollresult);
    }

    public static Enumeration find(int _nPoll,int j,int k) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT pollresult FROM PollResult WHERE poll=" + _nPoll);
            for(int l = 0;l < j + k && db.next();l++)
            {
                if(l >= j)
                {
                    vector.addElement(new Integer(db.getInt(1)));
                }
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT pollresult FROM PollResult WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                vector.addElement(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static int getSumResult(int _nPoll,int time) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            String timeSql;
            switch(time)
            {
            case 1: //总
                timeSql = "";
                break;
            case 2: //月
                timeSql = " AND time>=" + DbAdapter.cite(new Date(System.currentTimeMillis() - (30L * 24L * 60L * 60L * 1000L)));
                break;
            default: //周
                timeSql = " AND time>=" + DbAdapter.cite(new Date(System.currentTimeMillis() - (7 * 24 * 60 * 60 * 1000)));
            }
            return db.getInt("SELECT COUNT(poll)  FROM PollResult  WHERE poll=" + _nPoll + timeSql);
        } finally
        {
            db.close();
        }
    }

    public boolean getVoiceFlag() throws SQLException
    {
        load();
        return _blVoiceFlag;
    }

    public static void deleteByPoll(int _nPoll) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM PollResult  WHERE poll=" + _nPoll);
        } finally
        {
            db.close();
        }
    }

    public String getText(int i) throws SQLException
    {
        load();
        return Translator.getInstance().translate(_strText,_nLanguage,i);
    }

    public byte[] getVoice() throws SQLException
    {
        load();
        if(_blVoiceFlag && _abVoice == null)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT " + db.length("voice") + ",voice FROM PollResult WHERE pollresult=" + _nPollResult);
                if(db.next())
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

    public int getNode()
    {
        return node;
    }


}
