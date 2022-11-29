package tea.entity.node;

//import org.apache.struts.action.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class MessageBoardReply extends Entity
{
	private static Cache _cache = new Cache(100);
	private int id;
    private int node;
    private int language;
    private boolean exists;
    private String member;
    private String text;
    private Date time;
    private boolean hidden;

    public static MessageBoardReply find(int id) throws SQLException
    {
        MessageBoardReply obj = (MessageBoardReply) _cache.get(new Integer(id));
        if(obj == null)
        {
            obj = new MessageBoardReply(id);
            _cache.put(new Integer(id),obj);
        }
        return obj;
    }

    public MessageBoardReply(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    /*
     * public void set() throws SQLException { DbAdapter dbadapter = new DbAdapter(); try { dbadapter.executeUpdate("UPDATE MessageBoardReply SET hint=" + (hint) + " WHERE node=" + this.node + " AND language=" + this.language); _cache.remove(new Integer(id)); } finally { dbadapter.close(); } }
     */

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM MessageBoardReply WHERE id=" + this.id);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
    }

    public static void create(int node,int language,String member,String text,boolean hidden) throws SQLException
    {
        int id = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(node,"INSERT INTO MessageBoardReply(node,language,member,text,hidden,time)VALUES(" + node + "," + language + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(text) + "," + DbAdapter.cite(hidden) + "," + db.citeCurTime() + ")");
            id = db.getInt("SELECT MAX(id) FROM MessageBoardReply");
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
    }

    public static int findLast(int node,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            return db.getInt("SELECT  id  FROM MessageBoardReply WHERE node=" + node + " AND language=" + language + " ORDER BY time DESC");
        } finally
        {
            db.close();
        }
    }

    public static Enumeration find(int node,int language) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id  FROM MessageBoardReply WHERE node=" + node + " AND language=" + language + " ORDER BY id DESC");
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static int count(int node,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            return db.getInt("SELECT COUNT(id) FROM MessageBoardReply WHERE node=" + node + " AND language=" + language);
        } finally
        {
            db.close();
        }
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node,language,member,text,hidden,time FROM MessageBoardReply WHERE id=" + id);
            if(db.next())
            {
                node = db.getInt(1);
                language = db.getInt(2);
                member = db.getString(3);
                text = db.getText(language,language,4);
                hidden = db.getInt(5) != 0;
                time = db.getDate(6);
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

    public int getNode()
    {
        return node;
    }

    public int getLanguage()
    {
        return language;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getId()
    {
        return id;
    }

    public String getMember()
    {
        return member;
    }

    public String getText()
    {
        return text;
    }

    public Date getTime()
    {
        return time;
    }

    public boolean isHidden()
    {
        return hidden;
    }

    public String getTimeToString()
    {
        return sdf.format(time);
    }
}
