package tea.entity.node;

import java.util.*;
import java.text.*;
import tea.db.*;
import tea.entity.*;
import tea.translator.*;
import java.sql.SQLException;

public class Chat extends Entity
{
    public static final int CHATO_SHOWTIME = 0x200000;
    public static final int CHATO_RECORDALL = 0x100000;
    public static final String CHAT_ACTION[] =
            {"ChatEnter","ChatLeave","ChatBroadcast","ChatWhisper","ChatSmile","ChatAngry","ChatLaugh","ChatCry","ChatPraise","ChatBelittle","ChatKiss","ChatKick"};
    public static final int CHATA_ENTER = 0;
    public static final int CHATA_LEAVE = 1;
    public static final int CHATA_BROADCAST = 2;
    private int chat;
    private int node;
    private RV from;
    private int action;
    private RV to;
    private Date time;
    private int language;
    private String text;
    private String attach;
    private boolean _blLoaded;
    private static Cache _cache = new Cache(100);

    public static Enumeration findMember(int node) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT DISTINCT rmember, vmember  FROM Chat  WHERE node=" + node + " AND action=" + 0 + " ORDER BY rmember ");
            while(db.next())
            {
                v.addElement(new RV(db.getString(1),db.getString(2)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public String getAttach() throws SQLException
    {
        load();
        return attach;
    }


    private Chat(int i)
    {
        chat = i;
        _blLoaded = false;
    }

    public static void create(int i,RV rv,int j,RV rv1) throws SQLException
    {
        create(i,rv,j,rv1,0,null,null);
    }

    public static void create(int node,RV rv,int action,RV rv1,int language,String text,String attach) throws SQLException
    {
        int i1 = Node.find(node).getOptions1();
        DbAdapter db = new DbAdapter();
        try
        {
            if((i1 & 0x100000) == 0 && db.getInt("SELECT COUNT(chat)  FROM Chat  WHERE node=" + node + " AND rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV)) > 20)
            {
                int j1 = db.getInt("SELECT chat  FROM Chat  WHERE node=" + node + " AND rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV) + " ORDER BY time ");
                db.executeUpdate("DELETE FROM Chat  WHERE chat=" + j1);
            }
            db.executeUpdate("INSERT INTO Chat(node, rmember, vmember, action, trmember, tvmember, language, text, attach)  VALUES(" + node + ", " + DbAdapter.cite(rv._strR) + ", " + DbAdapter.cite(rv._strV) + ", " + action + ", " + DbAdapter.cite(rv1._strR) + ", " + DbAdapter.cite(rv1._strV) + ", " + language + ", " + DbAdapter.cite(text) + ", " + DbAdapter.cite(attach) + ") ");
        } finally
        {
            db.close();
        }
    }


    public  void set(int action,String text,String attach) throws SQLException
    {

        DbAdapter db = new DbAdapter();
        StringBuffer sb = new StringBuffer(" action="+action+" ,");

        //if(attach!=null && attach.length()>0)
        {
        	 sb.append("attach="+DbAdapter.cite(attach)+",");
        }
        sb.append("text="+DbAdapter.cite(text));
        try
        {

            db.executeUpdate("UPdate Chat set  "+sb.toString()+" where chat="+chat);

        } finally
        {
            db.close();
        }
        _blLoaded = false;

    }


    public Date getTime() throws SQLException
    {
        load();
        return time;
    }

    public String getTimeToString() throws SQLException
    {
        load();
        return(new SimpleDateFormat("MM.dd HH:mm")).format(time);
    }

    public RV getFrom() throws SQLException
    {
        load();
        return from;
    }

    public RV getTo() throws SQLException
    {
        load();
        return to;
    }

    private void load() throws SQLException
    {
        if(!_blLoaded)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT rmember, vmember, action, trmember, tvmember, time,  language, text, attach FROM Chat  WHERE chat=" + chat);
                if(db.next())
                {
                    from = new RV(db.getString(1),db.getString(2));
                    action = db.getInt(3);
                    to = new RV(db.getString(4),db.getString(5));
                    time = db.getDate(6);
                    language = db.getInt(7);
                    text = db.getText(8);
                    attach = db.getString(9);
                }
            } finally
            {
                db.close();
            }
            _blLoaded = true;
        }
    }

    public static Chat find(int i)
    {
        Chat chat = (Chat) _cache.get(i);
        if(chat == null)
        {
            chat = new Chat(i);
            _cache.put(i,chat);
        }
        return chat;
    }

    public static Enumeration find(int node,RV rv,int chat) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT chat FROM Chat WHERE node=" + node + " AND chat>" + chat + " AND ( action <= 2 OR (rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV) + ") OR (trmember=" + DbAdapter.cite(rv._strR) + " AND tvmember=" + DbAdapter.cite(rv._strV) + ") OR (trmember=" + DbAdapter.cite("") + " AND tvmember=" + DbAdapter.cite("") + ")  ) ORDER BY time ASC");
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

    public static Enumeration find(int node,RV rv,int chat,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT chat FROM Chat WHERE node=" + node + " AND chat>" + chat + " AND ( action <= 2 OR (rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV) + ") OR (trmember=" + DbAdapter.cite(rv._strR) + " AND tvmember=" + DbAdapter.cite(rv._strV) + ") OR (trmember=" + DbAdapter.cite("") + " AND tvmember=" + DbAdapter.cite("") + ")  ) ORDER BY time desc",pos,size);
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
    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT chat FROM Chat WHERE 1=1 "+sql,pos,size);
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
       int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT count(chat) FROM Chat WHERE 1=1 "+sql);
            if(db.next())
            {
               i = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return i;
    }
    public void delete() throws SQLException
    {

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(" delete from Chat where chat = "+chat);

        } finally
        {
            db.close();
        }
        _blLoaded = false;

    }


    public String getText(int i) throws SQLException
    {
        load();
        return Translator.getInstance().translate(text,language,i);
    }

    public int getAction() throws SQLException
    {
        load();
        return action;
    }


}
