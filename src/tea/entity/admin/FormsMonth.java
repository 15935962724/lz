package tea.entity.admin;

import java.util.*;
import java.sql.SQLException;
import tea.entity.*;
import tea.db.*;

public class FormsMonth
{

    public FormsMonth(java.util.Date formsMonth) throws SQLException
    {
        _htLayer = new Hashtable();
        this.formsMonth = formsMonth;
        load();
    }

    public static java.util.Enumeration find() throws SQLException
    {
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        java.util.Vector vector = new java.util.Vector();
        try
        {
            db.executeQuery("SELECT formsmonth FROM FormsMonth ORDER BY formsmonth");
            while(db.next())
            {
                vector.addElement(db.getDate(1));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    private void load() throws SQLException
    {
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        try
        {
            db.executeQuery("SELECT member,time FROM FormsMonth WHERE formsmonth=" + DbAdapter.cite(formsMonth));
            if(db.next())
            {

                time = db.getDate(2);
                member = db.getString(1);
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

    public void set(String member) throws SQLException
    {
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        try
        {
            // java.util.Calendar c= java.util.Calendar.getInstance();
            // c.set(java.util.Calendar.DAY_OF_MONTH,1);
            this.time = new Date();
            // db.executeUpdate("FormsMonthEdit " +
            // DbAdapter.cite(formsMonth) + "," +
            // DbAdapter.cite(member) + "," +
            // DbAdapter.cite(time)
            // );
            db.executeQuery("SELECT formsmonth FROM FormsMonth WHERE formsmonth=" + DbAdapter.cite(formsMonth));
            if(db.next())
            {
                db.executeUpdate("UPDATE FormsMonth   SET member=" + DbAdapter.cite(member) + ",time=" + DbAdapter.cite(time) + " WHERE formsmonth=" + DbAdapter.cite(formsMonth));
            } else
            {
                db.executeUpdate("INSERT INTO FormsMonth(formsmonth,member,time)VALUES(" + DbAdapter.cite(formsMonth) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(time) + ")");
            }
            this.member = member;
            _htLayer.clear();
        } finally
        {
            db.close();
        }
    }

    private Hashtable _htLayer;
    private static tea.entity.Cache _cache = new tea.entity.Cache(100);

    private boolean exists;
    public static java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM");

    private Date formsMonth;
    private Date time;
    private String member;

    public static FormsMonth find(Date formsMonth) throws SQLException
    {
        FormsMonth obj = (FormsMonth) _cache.get(formsMonth);
        if(obj == null)
        {
            obj = new FormsMonth(formsMonth);
            _cache.put(formsMonth,obj);
        }
        return obj;
    }

    public boolean isExists()
    {
        return exists;
    }

    public Date getFormsMonth()
    {
        return formsMonth;
    }

    public String getMember()
    {
        return member;
    }

    public Date getTime()
    {
        return time;
    }

    public String getTimeToString()
    {
        return Entity.sdf2.format(time);
    }

}
