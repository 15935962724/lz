package tea.entity.work;

import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import tea.translator.Translator;
import java.sql.SQLException;

public class WorkTable extends Entity
{
    private static Cache _cache = new Cache(100);
    public int _nWorks;
    private String _strProjectName;
    private int _nLanguage;
    private String _strSendDpt;
    private String _strSender;
    private String _strReciever;
    private Date _dCreateDate;
    private Date _dPStartDate;
    private Date _dPStopDate;
    private String _strManager;
    private Date _dSendSignDate;
    private String _strRequire;
    private Date _dStartDate;
    private Date _dStopDate;
    private String _strComplete;
    private Date _dCompleteDate;
    private int _nStatus;
    private boolean _blFile;
    private String _strFileName;
    private byte _abFileData[];
    private boolean _blLoad;


    private WorkTable(int works)
    {
        _nWorks = works;
        _blLoad = false;
    }

    public static WorkTable find(int works)
    {
        WorkTable worktable = (WorkTable) _cache.get(new Integer(works));
        if(worktable == null)
        {
            worktable = new WorkTable(works);
            _cache.put(new Integer(works),worktable);
            _cache.clear();
        }
        return worktable;
    }

    public static WorkTable Create(String projectname,int language,String senddpt,String sender,String reciever,Date pstartdate,Date pstopdate,String manager,String request,String filenames,byte filedata[]) throws SQLException
    {
        int w = 0;
        DbAdapter db = new DbAdapter();
        StringBuilder sql = new StringBuilder("INSERT INTO WorkTable(projectname, language, senddpt, sender, reciever, pstartdate,pstopdate, manager, request, filename, filedata)VALUES(").append(DbAdapter.cite(projectname)).append(", ").append(language).append(", ").append(DbAdapter.cite(senddpt)).append(", ").append(DbAdapter.cite(sender)).append(", ").append(DbAdapter.cite(reciever)).append(", ").append(DbAdapter.cite(pstartdate)).append(", ").append(DbAdapter.cite(pstopdate)).append(", ").append(
                DbAdapter.cite(manager)).append(", ").append(DbAdapter.cite(request)).append(", ").append(DbAdapter.cite(filenames)).append(", ").append(DbAdapter.cite(filedata)).append(")");
        try
        {
            db.executeUpdate(sql.toString());
            w = db.getInt("SELECT MAX(works) FROM WorkTable");
        } finally
        {
            db.close();
        }
        return find(w);
    }

    private void load() throws SQLException
    {
        if(!_blLoad)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT projectname, language, senddpt, sender, reciever, createdate, pstartdate, pstopdate, manager, sendsigndate, startdate, stopdate, complete, completedate, status FROM WorkTable WHERE works=".concat(String.valueOf(String.valueOf(_nWorks))));
                if(db.next())
                {
                    _strProjectName = db.getString(1);
                    _nLanguage = db.getInt(2);
                    _strSendDpt = db.getString(3);
                    _strSender = db.getString(4);
                    _strReciever = db.getString(5);
                    _dCreateDate = db.getDate(6);
                    _dPStartDate = db.getDate(7);
                    _dPStopDate = db.getDate(8);
                    _strManager = db.getString(9);
                    _dSendSignDate = db.getDate(10);
                    _dStartDate = db.getDate(11);
                    _dStopDate = db.getDate(12);
                    _strComplete = db.getString(13);
                    _dCompleteDate = db.getDate(14);
                    _nStatus = db.getInt(15);
                }
                db.executeQuery(String.valueOf(String.valueOf((new StringBuilder("SELECT works FROM WorkTable WHERE works=")).append(_nWorks).append(" AND filedata IS NOT NULL"))));
                _blFile = db.next();
                if(_blFile)
                {
                    db.executeQuery("SELECT filename FROM WorkTable WHERE works=".concat(String.valueOf(String.valueOf(_nWorks))));
                    if(db.next())
                    {
                        _strFileName = db.getString(1);
                    }
                }
            } finally
            {
                db.close();
            }
            _blLoad = true;
        }
    }

    public String getProjectName(int language) throws SQLException
    {
        load();
        return Translator.getInstance().translate(_strProjectName,_nLanguage,language);
    }

    public String getSendDpt(int language) throws SQLException
    {
        load();
        return Translator.getInstance().translate(_strSendDpt,_nLanguage,language);
    }

    public String getSender() throws SQLException
    {
        load();
        return _strSender;
    }

    public String getReciever() throws SQLException
    {
        load();
        return _strReciever;
    }

    public Date getCreateDate() throws SQLException
    {
        load();
        return _dCreateDate;
    }

    public Date getPStartDate() throws SQLException
    {
        load();
        return _dPStartDate;
    }

    public Date getPStopDate() throws SQLException
    {
        load();
        return _dPStopDate;
    }

    public String getManager() throws SQLException
    {
        load();
        return _strManager;
    }

    public Date getSendSignDate() throws SQLException
    {
        load();
        return _dSendSignDate;
    }

    public String getRequire(int language) throws SQLException
    {
        load();
        if(_strRequire == null)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT request FROM WorkTable WHERE works=".concat(String.valueOf(String.valueOf(_nWorks))));
                if(db.next())
                {
                    _strRequire = db.getText(1);
                }
            } finally
            {
                db.close();
            }
        }
        return Translator.getInstance().translate(_strRequire,_nLanguage,language);
    }

    public Date getStartDate() throws SQLException
    {
        load();
        return _dStartDate;
    }

    public Date getStopDate() throws SQLException
    {
        load();
        return _dStopDate;
    }

    public String getComplete(int language) throws SQLException
    {
        load();
        return Translator.getInstance().translate(_strComplete,_nLanguage,language);
    }

    public Date getCompleteDate() throws SQLException
    {
        load();
        return _dCompleteDate;
    }

    public int getStatus() throws SQLException
    {
        load();
        return _nStatus;
    }

    public boolean getFileFlag() throws SQLException
    {
        load();
        return _blFile;
    }

    public String getFileName() throws SQLException
    {
        load();
        return _strFileName;
    }

    public byte[] getFileData() throws SQLException
    {
        load();
        if(_blFile)
        {
            if(_abFileData == null)
            {
                DbAdapter db = new DbAdapter();
                try
                {
                    _abFileData = db.getImage("SELECT " + db.length("filedata") + ",filedata  FROM WorkTable WHERE works=".concat(String.valueOf(String.valueOf(_nWorks))));
                } catch(Exception exception1)
                {
                    throw new SQLException(exception1.toString());
                } finally
                {
                    db.close();
                }
            }
            return _abFileData;
        } else
        {
            return null;
        }
    }

    public void setSendDesignDate() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE WorkTable SET sendsigndate=" + db.citeCurTime() + " WHERE works=".concat(String.valueOf(String.valueOf(_nWorks))));
        } finally
        {
            db.close();
        }
    }

    public void setStartDate() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE WorkTable SET startdate=" + db.citeCurTime() + " WHERE works=".concat(String.valueOf(String.valueOf(_nWorks))));
        } finally
        {
            db.close();
        }
    }

    public void setStopDate() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE WorkTable SET stopdate=" + db.citeCurTime() + " WHERE works=".concat(String.valueOf(String.valueOf(_nWorks))));
        } finally
        {
            db.close();
        }
    }

    public void setCompleteDate() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE WorkTable SET completedate=" + db.citeCurTime() + " WHERE works=".concat(String.valueOf(String.valueOf(_nWorks))));
        } finally
        {
            db.close();
        }
    }

    public void setComplete(String completes) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(String.valueOf(String.valueOf((new StringBuilder("UPDATE WorkTable SET complete=")).append(DbAdapter.cite(completes)).append(" WHERE works=").append(_nWorks))));
        } finally
        {
            db.close();
        }
    }

    public void setStatus(int statu) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(String.valueOf(String.valueOf((new StringBuilder("UPDATE WorkTable SET status=")).append(statu).append(" WHERE works=").append(_nWorks))));
        } finally
        {
            db.close();
        }
    }

    public boolean isSender(String id) throws SQLException
    {
        boolean bl = false;
        load();
        if(_strSender.equals(id))
        {
            bl = true;
        }
        return bl;
    }

    public boolean isReciever(String id) throws SQLException
    {
        boolean bl = false;
        load();
        if(_strReciever.equals(id))
        {
            bl = true;
        }
        return bl;
    }

    public boolean isManager(String id) throws SQLException
    {
        boolean bl = false;
        load();
        if(_strManager.equals(id))
        {
            bl = true;
        }
        return bl;
    }

    public static Enumeration findBySender(String senders) throws SQLException
    {
        int w = 0;
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT works FROM WorkTable WHERE sender=".concat(String.valueOf(String.valueOf(DbAdapter.cite(senders)))));
            for(;db.next();vector.addElement(new Integer(db.getInt(1))))
            {
                ;
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static Enumeration findByReciever(String recievers) throws SQLException
    {
        int w = 0;
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT works FROM WorkTable WHERE sender=".concat(String.valueOf(String.valueOf(DbAdapter.cite(recievers)))));
            for(;db.next();vector.addElement(new Integer(db.getInt(1))))
            {
                ;
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static Enumeration findByManager(String managers) throws SQLException
    {
        int w = 0;
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT works FROM WorkTable WHERE sender=".concat(String.valueOf(String.valueOf(DbAdapter.cite(managers)))));
            for(;db.next();vector.addElement(new Integer(db.getInt(1))))
            {
                ;
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
            db.executeUpdate("DELETE WorkTable WHERE works=".concat(String.valueOf(String.valueOf(_nWorks))));
        } finally
        {
            db.close();
        }
        _cache.clear();
    }

    public static int newWorkTable(String member) throws SQLException
    {
        int w = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(String.valueOf(String.valueOf((new StringBuilder("SELECT Top 1 works FROM WorkTable WHERE sender=")).append(DbAdapter.cite(member)).append(" ORDER BY works DESC"))));
            if(db.next())
            {
                w = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return w;
    }

    public static int PrevWorkTable(int work,String member) throws SQLException
    {
        int w = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(String.valueOf(String.valueOf((new StringBuilder("SELECT Top 1 works FROM WorkTable WHERE works<")).append(work).append(" AND sender=").append(DbAdapter.cite(member)).append(" ORDER BY works DESC"))));
            if(db.next())
            {
                w = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return w;
    }

    public static int NextWorkTable(int work,String member) throws SQLException
    {
        int w = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(String.valueOf(String.valueOf((new StringBuilder("SELECT Top 1 works FROM WorkTable WHERE works>")).append(work).append(" AND sender=").append(DbAdapter.cite(member)).append(" ORDER BY works ASC"))));
            if(db.next())
            {
                w = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return w;
    }

    public static Enumeration findManagerStatus(String member) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT works FROM WorkTable WHERE status=0 AND manager=".concat(String.valueOf(String.valueOf(DbAdapter.cite(member)))));
            for(;db.next();vector.addElement(new Integer(db.getInt(1))))
            {
                ;
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static Enumeration findRecieverStatus(String member) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT works FROM WorkTable WHERE (status=1 OR status=2) AND reciever=".concat(String.valueOf(String.valueOf(DbAdapter.cite(member)))));
            for(;db.next();vector.addElement(new Integer(db.getInt(1))))
            {
                ;
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static Enumeration findSenderStatus(String member) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT works FROM WorkTable WHERE status=3 AND sender=".concat(String.valueOf(String.valueOf(DbAdapter.cite(member)))));
            for(;db.next();vector.addElement(new Integer(db.getInt(1))))
            {
                ;
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static int countSearch(String sender,String reciever,String Days[],boolean ignoredate) throws SQLException
    {
        int w = 0;
        StringBuilder sub = new StringBuilder();
        if(ignoredate)
        {
            String month = Days[0];
            String day = Days[1];
            String year = Days[2];
            sub.append(" AND YEAR(createdate) =").append(DbAdapter.cite(year));
            if(!month.equals("0"))
            {
                sub.append(" AND MONTH(createdate)=").append(DbAdapter.cite(month));
            }
            if(!day.equals("0"))
            {
                sub.append(" AND DAY(createdate)=").append(DbAdapter.cite(day));
            }
        }
        DbAdapter db = new DbAdapter();
        try
        {
            if(ignoredate)
            {
                w = db.getInt(String.valueOf(String.valueOf((new StringBuilder("SELECT COUNT(works) FROM WorkTable WHERE sender LIKE '%")).append(sender).append("%' AND reciever LIKE '%").append(reciever).append("%'").append(sub.toString()))));
            } else
            {
                w = db.getInt(String.valueOf(String.valueOf((new StringBuilder("SELECT COUNT(works) FROM WorkTable WHERE sender LIKE '%")).append(sender).append("%' AND reciever LIKE '%").append(reciever).append("%'"))));
            }
        } finally
        {
            db.close();
        }
        return w;
    }

    public static Enumeration findSearch(String sender,String reciever,String Days[],boolean ignoredate,int start,int all) throws SQLException
    {
        StringBuilder sub = new StringBuilder();
        if(ignoredate)
        {
            String month = Days[0];
            String day = Days[1];
            String year = Days[2];
            sub.append(" AND YEAR(createdate) =").append(DbAdapter.cite(year));
            if(!month.equals("0"))
            {
                sub.append(" AND MONTH(createdate)=").append(DbAdapter.cite(month));
            }
            if(!day.equals("0"))
            {
                sub.append(" AND DAY(createdate)=").append(DbAdapter.cite(day));
            }
        }
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            if(ignoredate)
            {
                db.executeQuery(String.valueOf(String.valueOf((new StringBuilder("SELECT works FROM WorkTable WHERE sender LIKE '%")).append(sender).append("%' AND reciever LIKE '%").append(reciever).append("%'").append(sub.toString()))));
            } else
            {
                db.executeQuery(String.valueOf(String.valueOf((new StringBuilder("SELECT works FROM WorkTable WHERE sender LIKE '%")).append(sender).append("%' AND reciever LIKE '%").append(reciever).append("%'"))));
            }
            for(int k = 0;k < start + all && db.next();k++)
            {
                if(k >= start)
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


}
