package tea.entity.pic;

import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class PicNews
{
    protected static Cache c = new Cache(50);
    public int picnews;
    public String community;
    public String name;
    public int sequence;

    public PicNews(int picnews)
    {
        this.picnews = picnews;
    }

    public static PicNews find(int picnews) throws SQLException
    {
        PicNews t = (PicNews) c.get(picnews);
        if(t == null)
        {
            ArrayList al = find(" AND picnews=" + picnews,0,1);
            t = al.size() < 1 ? new PicNews(picnews) : (PicNews) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT picnews,community,name,sequence FROM PicNews WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                PicNews t = new PicNews(rs.getInt(i++));
                t.community = rs.getString(i++);
                t.name = rs.getString(i++);
                t.sequence = rs.getInt(i++);
                c.put(t.picnews,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM PicNews WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if(picnews < 1)
                db.executeUpdate("INSERT INTO PicNews(community,name,sequence)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(name) + "," + sequence + ")");
            else
                db.executeUpdate("UPDATE PicNews SET name=" + DbAdapter.cite(name) + ",sequence=" + sequence + " WHERE picnews=" + picnews);
        } finally
        {
            db.close();
        }
        c.remove(picnews);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM PicNews WHERE picnews=" + picnews);
        c.remove(picnews);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE PicNews SET " + f + "=" + DbAdapter.cite(v) + " WHERE picnews=" + picnews);
        c.remove(picnews);
    }
}
