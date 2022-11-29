package tea.entity.node;

import java.util.Date;

import tea.db.DbAdapter;
import java.sql.SQLException;
import tea.entity.*;
import java.util.*;

public class ApplyTable extends Entity
{
    private static Cache _cache = new Cache(100);
    private int applytable;
    private String member;
    private String community;
    private String name;
    private boolean exists;
    private Date time;


    public int getApplytable()
    {
        return applytable;
    }

    public static ApplyTable find(int applytable) throws SQLException
    {
        ApplyTable obj = (ApplyTable) _cache.get(new Integer(applytable));
        if (obj == null)
        {
            obj = new ApplyTable(applytable);
            _cache.put(new Integer(applytable), obj);
        }
        return obj;
    }

    public ApplyTable(int applytable) throws SQLException
    {
        this.applytable = applytable;
        loadBasic();
    }


    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE ApplyTable SET member=" + DbAdapter.cite(member) + ",community=" + DbAdapter.cite(community) + ",  name=" + DbAdapter.cite(name) + ",time=getDate()  WHERE applytable=" + this.applytable);
            //db.executeUpdate("ApplyTableEdit " + this.applytable + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(name));
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(applytable));
    }

    public static java.util.Enumeration findByMember(String member, String community) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT  applytable FROM ApplyTable WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
            while (db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static ApplyTable create(String member, String community, String name) throws SQLException
    {
        int k = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO ApplyTable (member,community, name,time)VALUES (" + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + ", " + DbAdapter.cite(name) + ",getDate())");
            k = db.getInt("SELECT MAX(applytable) FROM ApplyTable");
        } finally
        {
            db.close();
        }
        return find(k);
    }

    public void delete()
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM ApplyTable WHERE applytable=" + this.applytable);
        } catch (SQLException ex)
        {
            ex.printStackTrace();
        } finally
        {
            db.close();
        }
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT member,community,name,time FROM ApplyTable WHERE applytable=" + applytable);
            if (db.next())
            {
                member = db.getString(1);
                community = db.getString(2);
                name = db.getVarchar(1, 1, 3);
                time = db.getDate(4);
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

    public void setMember(String member)
    {
        this.member = member;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public String getMember()
    {
        return member;
    }

    public String getName()
    {
        return name;
    }

    public String getFile()
    {
        return "/res/" + community + "/applytable/" + member + "." + applytable + ".doc";
    }

    public boolean isExists()
    {
        return exists;
    }

    public Date getTime()
    {
        return time;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getTimeToString()
    {
        if (time == null)
        {
            return "";
        } else
        {
            return sdf.format(time);
        }
    }
}
