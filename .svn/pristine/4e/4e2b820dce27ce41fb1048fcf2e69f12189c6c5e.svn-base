package tea.entity.yl.shop;

import java.util.*;
import java.sql.SQLException;

import tea.db.DbAdapter;
import tea.entity.*;

/**
 * 邮件记录
 * @author Administrator
 *
 */
public class MessageList
{
    protected static Cache c = new Cache(50);
    public int id; 
    public int profile; //用户id
    public String email; 
    public int ispass; //0未访问 1已访问

    public MessageList(int id)
    {
        this.id = id;
    }

    public static MessageList find(int id) throws SQLException
    {
        MessageList t = (MessageList) c.get(id);
        if (t == null)
        {
            ArrayList al = find(" AND id=" + id, 0, 1);
            t = al.size() < 1 ? new MessageList(id) : (MessageList) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("select id,profile,email,ispass from MessageList WHERE 1=1" + sql, pos, size);
            while (rs.next())
            {
                int i = 1;
                MessageList t = new MessageList(rs.getInt(i++));
                t.profile = rs.getInt(i++);
                t.email = rs.getString(i++);
                t.ispass = rs.getInt(i++);
                c.put(t.id, t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM MessageList WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if (id < 1)
            sql = "INSERT INTO MessageList(id,profile,email,ispass)VALUES(" + (id = Seq.get()) + "," + profile + "," + DbAdapter.cite(email) + "," + ispass  + ")";
        else
            sql = "UPDATE MessageList SET profile=" + profile + ",email=" + DbAdapter.cite(email) + ",ispass=" + ispass + " WHERE id=" + id;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id, sql);
        } finally
        {
            db.close();
        }
        c.remove(id);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id, "DELETE FROM MessageList WHERE id=" + id);
        } finally
        {
            db.close();
        }
        c.remove(id);
    }

    public void set(String f, String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id, "UPDATE MessageList SET " + f + "=" + DbAdapter.cite(v) + " WHERE id=" + id);
        } finally
        {
            db.close();
        }
        c.remove(id);
    }


}
