package tea.entity.member;

import tea.entity.node.Node;
import tea.entity.Cache;
import tea.entity.RV;
import java.sql.SQLException;
import tea.db.DbAdapter;
import java.util.Date;
import java.util.Hashtable;
import java.util.*;

public class Callboard extends tea.entity.Entity
{
    class Layer
    {
        public String subject;
        public String content;

        Layer()
        {
        }
    }


    private static Cache _cache = new Cache(100);
    private Hashtable _htLayer;
    private int callboard;
    private Date time;
    private boolean exists;
    private String member;

    public Callboard(int callboard) throws SQLException
    {
        this.callboard = callboard;
        _htLayer = new Hashtable();
        loadBasic();
    }

    public static Callboard find(int callboard) throws SQLException
    {
        Callboard obj = (Callboard) _cache.get(new Integer(callboard));
        if(obj == null)
        {
            obj = new Callboard(callboard);
            _cache.put(new Integer(callboard),obj);
        }
        return obj;
    }

    public static int create(String member,int language,String subject,String content) throws SQLException
    {
        Date d = new Date();
        int callboard = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Callboard (member  ,time )VALUES (" + DbAdapter.cite(member) + "  ," + DbAdapter.cite(d) + " )");
            callboard = db.getInt(" SELECT MAX(callboard) FROM Callboard");
            db.executeUpdate("INSERT INTO CallboardLayer (callboard,language,subject  ,content )VALUES (" + callboard + "  ," + language + ", " + DbAdapter.cite(subject) + "," + DbAdapter.cite(content) + ")");
        } finally
        {
            db.close();
        }
        return callboard;
    }

    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT callboard FROM Callboard WHERE 1=1" + sql + " ORDER BY time DESC",pos,size);
            while(db.next())
            {
                v.addElement(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static int count(String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            return db.getInt("SELECT COUNT(callboard) FROM Callboard WHERE 1=1" + sql);
        } finally
        {
            db.close();
        }
    }

    public void set(String member,int language,String subject,String content) throws SQLException
    {
        Date d = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Callboard  SET  time=" + DbAdapter.cite(d) + " WHERE callboard=" + callboard);
            int j = db.executeUpdate("UPDATE CallboardLayer SET subject=" + DbAdapter.cite(subject) + ",content=" + DbAdapter.cite(content) + " WHERE callboard=" + callboard + " AND language=" + language);
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO CallboardLayer (callboard,language,subject  ,content )VALUES (" + callboard + "  ," + language + ", " + DbAdapter.cite(subject) + "," + DbAdapter.cite(content) + ")");
            }
        } finally
        {
            db.close();
        }
        this.time = new java.util.Date();
        _htLayer.clear();
    }

    private Layer getLayer(int i) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(new Integer(i));
        if(layer == null)
        {
            layer = new Layer();
            int j = this.getLanguage(i);
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT subject,content FROM CallboardLayer WHERE callboard=" + callboard + " AND language=" + j);
                if(db.next())
                {
                    layer.subject = db.getVarchar(j,i,1);
                    layer.content = db.getText(j,i,2);
                }
            } finally
            {
                db.close();
            }
            _htLayer.put(new Integer(i),layer);
        }
        return layer;
    }

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language FROM CallboardLayer WHERE callboard=" + callboard);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        if(v.indexOf(new Integer(language)) != -1)
        {
            return language;
        } else
        {
            if(language == 1)
            {
                if(v.indexOf(new Integer(2)) != -1)
                {
                    return 2;
                }
            } else if(language == 2)
            {
                if(v.indexOf(new Integer(1)) != -1)
                {
                    return 1;
                }
            }
            if(v.size() < 1)
            {
                return 0;
            }
        }
        return((Integer) v.elementAt(0)).intValue();
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT member,time FROM Callboard WHERE callboard=" + callboard);
            if(db.next())
            {
                member = db.getString(1);
                time = db.getDate(2);
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public int getCallboard()
    {
        return callboard;
    }

    public String getContent(int language) throws SQLException
    {
        return getLayer(language).content;
    }

    public void delete(int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM CallboardLayer   WHERE callboard=" + callboard + "  AND language=" + language);
            db.executeQuery("SELECT callboard FROM CallboardLayer WHERE callboard=" + callboard);
            if(!db.next())
            {
                db.executeUpdate("DELETE FROM Callboard  WHERE callboard=" + callboard);
            }
        } finally
        {
            db.close();
        }
        _cache.remove(callboard);
    }

    public String getSubject(int language) throws SQLException
    {
        return getLayer(language).subject;
    }

    public Date getTime()
    {
        return time;
    }

    public String getTimeToString()
    {
        if(time == null)
        {
            return "";
        }
        return sdf2.format(time);
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getMember()
    {
        return member;
    }
}
