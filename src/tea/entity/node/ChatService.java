package tea.entity.node;

import java.io.*;
import java.sql.*;
import tea.entity.*;
import tea.db.*;

public class ChatService implements Serializable
{
    public static Cache cache = new Cache(100);
    private boolean exists;
    private String member;
    private java.util.Date time;
    private int chatservice;
    private String community;
    public ChatService(int chatservice) throws SQLException
    {
        this.chatservice = chatservice;
        load();
    }

    public static ChatService find(int chatservice) throws SQLException
    {
        ChatService obj = (ChatService) cache.get(new Integer(chatservice));
        if (obj == null)
        {
            obj = new ChatService(chatservice);
            cache.put(new Integer(chatservice), obj);
        }
        return obj;
    }

    public void set(String member, String community) throws SQLException
    {
        if (this.isExists())
        {
            time = new java.util.Date();
            tea.db.DbAdapter dbadapter = new tea.db.DbAdapter();
            try
            {
                dbadapter.executeUpdate("UPDATE ChatService SET member=" + DbAdapter.cite(member) + " WHERE chatservice=" + (chatservice));
            } finally
            {
                dbadapter.close();
            }
        } else
        {
            create(member, community);
            this.exists = true;
        }
        this.member = member;
        this.community = community;
    }

    public void load() throws SQLException
    {
        tea.db.DbAdapter dbadapter = new tea.db.DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT member,community FROM ChatService WHERE chatservice=" + (chatservice));
            if (dbadapter.next())
            {
                member = dbadapter.getString(1);
                community = dbadapter.getString(2);
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            dbadapter.close();
        }
    }


    public static int create(String member, String community) throws SQLException
    {
        tea.db.DbAdapter dbadapter = new tea.db.DbAdapter();
        try
        {
            dbadapter.executeUpdate("INSERT INTO ChatService(member,community)VALUES(" + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + ")");
        } catch (SQLException ex)
        {
            ex.printStackTrace();
        } finally
        {
            dbadapter.close();
        }
        return 0;
    }

    public static java.util.Enumeration findByCommunity(String community)
    {
        java.util.Vector vector = new java.util.Vector();
        tea.db.DbAdapter dbadapter = new tea.db.DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT chatservice FROM ChatService WHERE community=" + DbAdapter.cite(community));
            while (dbadapter.next())
            {
                vector.addElement(new Integer(dbadapter.getInt(1)));
            }
        } catch (SQLException ex)
        {
            ex.printStackTrace();
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    public void delete() throws SQLException
    {
        tea.db.DbAdapter dbadapter = new tea.db.DbAdapter();
        try
        {
            dbadapter.executeUpdate("DELETE ChatService WHERE chatservice=" + chatservice);
        } finally
        {
            dbadapter.close();
        }
        cache.remove(new Integer(chatservice));
    }

    private void readObject(ObjectInputStream ois) throws IOException, ClassNotFoundException
    {
        ois.defaultReadObject();
    }

    private void writeObject(ObjectOutputStream oos) throws IOException
    {
        oos.defaultWriteObject();
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getMember()
    {
        return member;
    }

    public int getChatservice()
    {
        return chatservice;
    }

    public String getCommunity()
    {
        return community;
    }


}
