package tea.entity.csvclub;

import java.io.*;
import java.util.Date;
import tea.db.DbAdapter;
import java.sql.SQLException;
import tea.entity.*;
import java.text.*;
import java.util.Calendar;


public class Insidertype extends Entity
{
    private int id;
    private String intype;
    private java.math.BigDecimal enrol;
    private java.math.BigDecimal yearexes;
    private String explains;
    private Date times;
    private Date time_j;

    private boolean exists;
    private static Cache _cache = new Cache(100);

    public Insidertype(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static Insidertype find(int id) throws SQLException
    {
        return new Insidertype(id);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT intype,enrol,yearexes,explains,times,time_j FROM Insidertype WHERE id = " + id);
            if (db.next())
            {
                intype = db.getVarchar(1, 1, 1);
                enrol = db.getBigDecimal(2, 2);
                yearexes = db.getBigDecimal(3, 2);
                explains = db.getVarchar(1, 1, 4);
                times = db.getDate(5);
                time_j = db.getDate(6);
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

    public static int create(String intype, java.math.BigDecimal enrol, java.math.BigDecimal yearexes, String explains, String member, String community, Date time_j) throws SQLException
    {
        int id = 0;
        Date times = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Insidertype(intype,enrol,yearexes,explains,times,member,community,time_j)VALUES( " + DbAdapter.cite(intype) + "," + enrol + "," + yearexes + " ," + DbAdapter.cite(explains) + "," + DbAdapter.cite(times) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + " ," + DbAdapter.cite(time_j) + "     )");
            id = db.getInt("SELECT @@IDENTITY");

        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
        return id;
    }

    public void set(String intype, java.math.BigDecimal enrol, java.math.BigDecimal yearexes, String explains, Date time_j) throws SQLException
    {

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Insidertype SET intype=" + DbAdapter.cite(intype) + " ,enrol=" + enrol + ",yearexes=" + yearexes + ",explains=" + DbAdapter.cite(explains) + ",time_j=" + DbAdapter.cite(time_j) + "  where id =" + id);

        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
    }

    public static java.util.Enumeration findByCommunity(String community, String sql) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT id FROM Insidertype WHERE community=" + DbAdapter.cite(community) + sql);

            while (dbadapter.next())
            {
                vector.addElement(new Integer(dbadapter.getInt(1)));
            }
        } catch (SQLException ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    public void delete() throws SQLException, SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Insidertype WHERE id =" + id);

        } finally
        {
            db.close();
        }
    }

    //在CsvRegMember2.jsp中的时间季度的判断
    public static String getQuarter() throws SQLException
    {
        String quarter = null;
        Date d = new Date();
        java.util.Calendar c = java.util.Calendar.getInstance();
        c.setTime(d);
        int time = c.get(c.MONTH); //d.getMonth();
        if (time == 0 || time == 1 || time == 2)
        {
            quarter = "一";
        }
        if (time == 3 || time == 4 || time == 5)
        {
            quarter = "二";
        }
        if (time == 6 || time == 7 || time == 8)
        {
            quarter = "三";
        }
        if (time == 9 || time == 10 || time == 11)
        {
            quarter = "四";
        }
        return quarter;
    }

    public String getIntype()
    {
        return intype;
    }

    public java.math.BigDecimal getEnrol()
    {
        return enrol;
    }

    public java.math.BigDecimal getYearexes()
    {
        return yearexes;
    }

    public String getExplain()
    {
        return explains;
    }

    public Date getTimes()
    {
        return times;
    }
    public Date getTime_j()
    {
        return time_j;
    }
}
