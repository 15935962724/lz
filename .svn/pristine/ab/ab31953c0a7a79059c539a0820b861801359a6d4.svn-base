package tea.entity.csvclub;

import java.sql.*;
import java.util.Date;
import tea.db.*;
import tea.entity.*;

public class Csvdoginterface extends Entity
{
    private int id;
    private String member;
    private String community;
    private String lineaddr;
    private String lineshow;
    private Date times;
    private boolean exists;

    public Csvdoginterface(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static Csvdoginterface find(int id) throws SQLException
    {
        return new Csvdoginterface(id);
    }


    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select id,member,community,lineaddr,lineshow,times from Csvdoginterface where id =" + id);
            if(db.next())
            {
                id = db.getInt(1);
                member = db.getString(2);
                community = db.getString(3);
                lineaddr = db.getString(4);
                lineshow = db.getString(5);
                times = db.getDate(6);
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

    public static void create(String member,String community,String lineaddr,String lineshow) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            //
            db.executeUpdate("insert into Csvdoginterface (member,community,lineaddr,lineshow) values(" + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(lineaddr) + "," + DbAdapter.cite(lineshow) + ")");
        } finally
        {
            db.close();

        }
    }

    public static void set(int id,String member,String community,String lineaddr,String lineshow) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Csvdoginterface set member = " + DbAdapter.cite(member) + ",community=" + DbAdapter.cite(community) + ",lineaddr=" + DbAdapter.cite(lineaddr) + ",lineshow=" + DbAdapter.cite(lineshow) + " where id =" + id);
        } finally
        {
            db.close();
        }
    }

    public static void delete(int id) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete Csvdoginterface where id=" + id);
        } finally
        {
            db.close();
        }
    }

    public static java.util.Enumeration findlist(String community,String sql,int pos,int size) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select id from Csvdoginterface where community=" + DbAdapter.cite(community) + sql,pos,size);
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


    public String getCommunity()
    {
        return community;
    }

    public int getId()
    {
        return id;
    }

    public String getLineaddr()
    {
        return lineaddr;
    }

    public String getLineshow()
    {
        return lineshow;
    }

    public String getMember()
    {
        return member;
    }

    public boolean isExists()
    {
        return exists;
    }

    public Date getTimes()
    {
        return times;
    }


}
