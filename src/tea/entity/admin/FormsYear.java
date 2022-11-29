package tea.entity.admin;

import java.util.*;
import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class FormsYear
{
    private Hashtable _htLayer;
    private static tea.entity.Cache _cache = new tea.entity.Cache(100);

    private boolean exists;
    public static java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM");

    private int formsYear;
    private Date time;
    private String member;
    // private BigDecimal balance;
    // private BigDecimal subsidy;
    private int useper;
    private String sfaMember;
    private Date sfaTime;
    public FormsYear(int formsYear) throws SQLException
    {
        _htLayer = new Hashtable();
        this.formsYear = formsYear;
        load();
    }

    public static java.util.Enumeration find() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        java.util.Vector vector = new java.util.Vector();
        try
        {
            db.executeQuery("SELECT formsyear FROM FormsYear");
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

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT useper,member,time,sfamember,sfatime FROM FormsYear WHERE formsyear=" + (formsYear));
            if(db.next())
            {
                useper = db.getInt(1);
                member = db.getString(2);
                time = db.getDate(3);
                sfaMember = db.getString(4);
                sfaTime = db.getDate(5);
                exists = true;
            } else
            {
                useper = 90;
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public void set(String member) throws SQLException
    {
        this.time = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT formsyear FROM FormsYear WHERE formsyear=" + formsYear);
            if(db.next())
            {
                db.executeUpdate("UPDATE FormsYear SET member=" + DbAdapter.cite(member) + ",time=" + DbAdapter.cite(time) + ",sfamember=" + DbAdapter.cite(sfaMember) + "	,sfatime=" + DbAdapter.cite(sfaTime) + " WHERE formsyear=" + formsYear);
            } else
            {
                db.executeUpdate("INSERT INTO FormsYear(formsyear,sfamember,sfatime)VALUES(" + formsYear + "," + DbAdapter.cite(sfaMember) + "," + DbAdapter.cite(sfaTime) + ")");
            }
        } finally
        {
            db.close();
        }
        this.member = member;
        _htLayer.clear();
    }


    public static FormsYear find(int formsYear) throws SQLException
    {
        FormsYear obj = (FormsYear) _cache.get(new Integer(formsYear));
        if(obj == null)
        {
            obj = new FormsYear(formsYear);
            _cache.put(new Integer(formsYear),obj);
        }
        return obj;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getFormsYear()
    {
        return formsYear;
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
        if(time == null)
        {
            return "";
        }
        return Entity.sdf2.format(time);
    }


    /*
     * public BigDecimal getBalance() { return balance; }
     *
     * public BigDecimal getSubsidy() { return subsidy; }
     */
    public int getUseper()
    {
        return useper;
    }

    public String getSfaMember()
    {
        return sfaMember;
    }

    public Date getSfaTime()
    {
        return sfaTime;
    }

    public String getSfaTimeToString()
    {
        if(sfaTime == null)
        {
            return "";
        }
        return Entity.sdf2.format(sfaTime);
    }


    public void setUseper(int useper) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE FormsYear SET useper=" + useper + " WHERE formsyear=" + formsYear);
        } finally
        {
            db.close();
        }
        this.useper = useper;
    }

    public void setSfa(String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            this.sfaTime = new Date();
            // db.executeUpdate("FormsYearEdit " +
            // formsYear + "," +
            // DbAdapter.cite(this.member) + "," +
            // DbAdapter.cite(time) + "," +
            // DbAdapter.cite(member) + "," +
            // DbAdapter.cite(sfaTime));
            db.executeQuery("SELECT formsyear FROM FormsYear WHERE formsyear=" + formsYear);
            if(db.next())
            {
                db.executeUpdate("UPDATE FormsYear SET member=" + DbAdapter.cite(member) + ",time=" + DbAdapter.cite(time) + ",sfamember=" + DbAdapter.cite(sfaMember) + "	,sfatime=" + DbAdapter.cite(sfaTime) + " WHERE formsyear=" + formsYear);
            } else
            {
                db.executeUpdate("INSERT INTO FormsYear(formsyear,sfamember,sfatime)VALUES(" + formsYear + "," + DbAdapter.cite(sfaMember) + "," + DbAdapter.cite(sfaTime) + ")");
            }
        } finally
        {
            db.close();
        }
        this.sfaMember = member;
        _htLayer.clear();
    }
}
