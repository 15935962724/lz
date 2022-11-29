package tea.ui.member;

import java.util.*;
import java.sql.SQLException;
import tea.entity.*;
import tea.db.*;

public class MessageFolder
{
    protected static Cache c = new Cache(200);
    public int message;
    public int member;
    public int folder; //9:删除

    public MessageFolder(int message,int member)
    {
        this.message = message;
        this.member = member;
    }

    public static MessageFolder find(int message,int member) throws SQLException
    {
        MessageFolder t = (MessageFolder) c.get(message + ":" + member);
        if(t == null)
        {
            ArrayList al = find(" AND message=" + message + " AND member=" + member,0,1);
            t = al.size() < 1 ? new MessageFolder(message,member) : (MessageFolder) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT message,member,folder FROM messagefolder WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                MessageFolder t = new MessageFolder(rs.getInt(i++),rs.getInt(i++));
                t.folder = rs.getInt(i++);
                c.put(t.message + ":" + t.member,t);
                al.add(t);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM messagefolder WHERE 1=1" + sql);
    }

    public static void create(int message,int member,int folder) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int i = db.executeUpdate("INSERT INTO messagefolder(message,member,folder)VALUES(" + message + "," + member + "," + folder + ")");
            if(i < 1)
            {
                db.executeUpdate("UPDATE messagefolder SET folder=" + folder + " WHERE message=" + message + " AND member=" + member);
            }
        } finally
        {
            db.close();
        }
    }

//    public void delete() throws SQLException
//    {
//        DbAdapter.execute("DELETE FROM messagefolder WHERE messagefolder=" + messagefolder);
//        c.remove(messagefolder);
//    }
//
//    public void set(String f, String v) throws SQLException
//    {
//        DbAdapter.execute("UPDATE messagefolder SET " + f + "=" + DbAdapter.cite(v) + " WHERE messagefolder=" + messagefolder);
//        c.remove(messagefolder);
//    }
}
