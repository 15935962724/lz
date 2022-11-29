package tea.entity.admin;

import java.io.*;
import java.util.*;
import tea.db.DbAdapter;
import java.sql.SQLException;
import tea.entity.*;

public class Evection extends Entity
{

    private int eveid; // 主键ID
    private String area;
    private Date time_k;
    private Date time_j;
    private int type;
    private Date times;
    private int unid;
    private int classes;
    private boolean exists;
    private String member;
    private static Cache _cache = new Cache(100);

    public Evection(int eveid) throws SQLException
    {
        this.eveid = eveid;
        load();
    }

    public static Evection find(int eveid) throws SQLException
    {
        return new Evection(eveid);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select area,time_k,time_j,type,times,unit, classes,member from Evection where eveid =" + eveid + " order by [time_k]");
            if (db.next())
            {
                area = db.getVarchar(1, 1, 1);
                time_k = db.getDate(2);
                time_j = db.getDate(3);
                type = db.getInt(4);
                times = db.getDate(5);
                unid = db.getInt(6);
                classes = db.getInt(7);
                member = db.getVarchar(1, 1, 8);

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

    public static int create(String area, Date time_k, Date time_j, int unid, int classes, String community, RV _rv) throws SQLException
    {
        int id = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Evection(area,time_k,time_j,times,unit,classes,community,member) VALUES(" + DbAdapter.cite(area) + "," + DbAdapter.cite(time_k) + "," + DbAdapter.cite(time_j) + "," + DbAdapter.cite(DutyClass.GetNowDate()) + "," + unid + "," + classes + "," + DbAdapter.cite(community) + ",'" + _rv + "')");
            id = db.getInt("SELECT MAX(eveid) FROM Evection");
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
        return id;
    }

    public static Enumeration findByCommunity(String community, String sql) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            //db.executeQuery("SELECT eveid FROM Evection WHERE community=" + DbAdapter.cite(community) + sql);
            db.executeQuery("SELECT l.eveid FROM Evection l INNER JOIN AdminUsrRole aur ON l.community=" + DbAdapter.cite(community) + " AND aur.community=" + DbAdapter.cite(community) + " AND l.member=aur.member WHERE 1=1" + sql);
            while (db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public void seteve() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Evection set type=1 where eveid =" + eveid);
        } finally
        {
            db.close();
        }

    }

    public void delete() throws SQLException
    {

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from Evection  where eveid =" + eveid);
        } finally
        {
            db.close();
        }

    }

    public static void deletes() throws SQLException
    {

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from Evection ");
        } finally
        {
            db.close();
        }

    }

    public String getArea()
    {
        return area;
    }

    public Date getTime_k()
    {
        return time_k;
    }

    public Date getTime_j()
    {
        return time_j;
    }

    public int getType()
    {
        return type;
    }

    public Date getTimes()
    {
        return times;
    }

    public int getUnid()
    {
        return unid;
    }

    public int getClasses()
    {
        return classes;
    }

    public String getMember()
    {
        return member;
    }
}
