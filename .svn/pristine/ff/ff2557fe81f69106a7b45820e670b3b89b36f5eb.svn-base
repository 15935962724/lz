package tea.entity.node;

import java.sql.SQLException;
import java.util.Enumeration;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.*;


public class ReportMember extends Entity
{
    private int id;
    private String author;
    private int times; //使用次数
    private String community;
    private boolean exists;

    public static ReportMember find(int id) throws SQLException
    {
        return new ReportMember(id);
    }

    public ReportMember(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select id,author,times,community from ReportMember where id=" + id);
            if(db.next())
            {
                id = db.getInt(1);
                author = db.getString(2);
                times = db.getInt(3);
                community = db.getString(4);
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

    public static int getID(String author) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int id = 0;
        try
        {
            db.executeQuery("select id from ReportMember where author=" + db.cite(author));
            if(db.next())
            {
                id = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return id;
    }

    public static void set(int id,String author,int times,String community) throws SQLException
    {
        String sql;
        if(id < 1)
            sql = "Insert into ReportMember(id,author,times,community)values(" + (id = Seq.get()) + "," + DbAdapter.cite(author) + "," + times + "," + DbAdapter.cite(community) + ")";
        else
            sql = "Update ReportMember SET author=" + DbAdapter.cite(author) + ",times=" + times + " where id=" + id;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id,sql);
        } finally
        {
            db.close();
        }
    }

    public static boolean isExists(String author) throws SQLException
    {
        boolean exists = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select id from ReportMember where author=" + db.cite(author));
            if(db.next())
            {
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
        return exists;
    }

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select count(id) from ReportMember where 1=1  " + sql);
            if(db.next())
            {
                count = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return count;

    }

    public static Enumeration findByCommunity(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM ReportMember WHERE 1=1   " + sql,pos,size);
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


    public String getAuthor()
    {
        return author;
    }

    public int getId()
    {
        return id;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getTimes()
    {
        return times;
    }

    public String getCommunity()
    {
        return community;
    }

}
