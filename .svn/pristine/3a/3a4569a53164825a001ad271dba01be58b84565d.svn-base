package tea.entity.node;

import java.sql.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class ScholarDown extends Entity
{
    private static Cache _cache = new Cache(100);
    private int node;
    private String member;
    private Date time;
    private boolean exists;

    public static void create(int node, String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            StringBuilder s1 = new StringBuilder();
            s1.append("INSERT INTO ScholarDown(node,member,time)VALUES(").append(node).append(", ").append(DbAdapter.cite(member)).append(", ").append(db.citeCurTime()).append(")");
            db.executeUpdate(s1.toString());
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + member);
    }

    public ScholarDown(int node, String member) throws SQLException
    {
        this.node = node;
        this.member = member;
        load();
    }


    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT time FROM ScholarDown WHERE node=" + node + " AND member=" + db.cite(member));
            if (db.next())
            {
                this.time = db.getDate(1);
                this.exists = true;
            } else
            {
                this.exists = false;
            }
        } finally
        {
            db.close();
        }
    }


    public static ScholarDown find(int node, String member) throws SQLException
    {
        ScholarDown obj = (ScholarDown) _cache.get(node + ":" + member);
        if (obj == null)
        {
            obj = new ScholarDown(node, member);
            _cache.put(node + ":" + member, obj);
        }
        return obj;
    }

    public static int count(String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.getInt("SELECT COUNT(node) FROM ScholarDown WHERE 1=1" + sql);
        } finally
        {
            db.close();
        }
        return j;
    }

    public String getTimeToString()
    {
        return sdf2.format(time);
    }

    public Date getTime()
    {
        return time;
    }

    public int getNode()
    {
        return node;
    }

    public String getMember()
    {
        return member;
    }

    public boolean isExists()
    {
        return exists;
    }

}
