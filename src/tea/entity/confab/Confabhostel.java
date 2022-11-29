package tea.entity.confab;

import java.util.Date;
import java.sql.SQLException;
import tea.db.DbAdapter;
import tea.entity.*;
import java.math.*;

public class Confabhostel extends Entity
{
    private static Cache _cache = new Cache(100);

    private int language;
    private int node;
    private boolean exists;
    private String linkman;
    private String cabaret;
    private String roots;
    private int human;
    private int days;
    private java.math.BigDecimal outlay;
    private Date time1;
    private Date time2;
    public Confabhostel(int node, int language) throws SQLException
    {
        this.node = node;
        this.language = language;
        load();
    }

    public static Confabhostel find(int node, int language) throws SQLException
    {
        Confabhostel obj = (Confabhostel) _cache.get(node + ":" + language);
        if (obj == null)
        {
            obj = new Confabhostel(node, language);
            _cache.put(node + ":" + language, obj);
        }
        return obj;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT linkman,cabaret,roots,human,days,outlay,time1,time2 FROM Confabhostel WHERE node=" + node + " AND language=" + language);
            if (db.next())
            {
                linkman = db.getString(1);
                cabaret = db.getString(2);
                roots = db.getString(3);
                human = db.getInt(4);
                days = db.getInt(5);
                outlay = db.getBigDecimal(6, 2);
                time1 = db.getDate(7);
                time2 = db.getDate(8);
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

    public void set(String linkman, String cabaret, String roots, int human, int days, java.math.BigDecimal outlay, Date time1, Date time2) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if (exists)
            {
                db.executeUpdate("UPDATE Confabhostel SET linkman=" + DbAdapter.cite(linkman) + ",cabaret=" + DbAdapter.cite(cabaret) + ",roots=" + DbAdapter.cite(roots) + ",human=" + human + ",days=" + days + ",outlay=" + outlay + ",time1=" + DbAdapter.cite(time1) + ",time2=" + DbAdapter.cite(time2) + " WHERE node=" + node + " AND language=" + language);
            } else
            {
                db.executeUpdate("INSERT INTO Confabhostel(node,language,linkman,cabaret,roots,human,days,outlay,time1,time2)VALUES(" +
                                 node + "," + language + "," + DbAdapter.cite(linkman) + "," + DbAdapter.cite(cabaret) + "," + DbAdapter.cite(roots) + "," + human + "," + days + "," + outlay + "," + DbAdapter.cite(time1) + "," + DbAdapter.cite(time2) + " )");
                _cache.remove(node + ":" + language);
            }
	} finally
        {
            db.close();
        }
        exists = true;
        this.linkman = linkman;
        this.cabaret = cabaret;
        this.roots = roots;
        this.human = human;
        this.days = days;
        this.outlay = outlay;
        this.time1 = time1;
        this.time2 = time2;
    }


    public int getLanguage()
    {
        return language;
    }

    public int getNode()
    {
        return node;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getLinkman()
    {
        return linkman;
    }

    public String getCabaret()
    {
        return cabaret;
    }

    public String getRoots()
    {
        return roots;
    }

    public int getHuman()
    {
        return human;
    }

    public int getDays()
    {
        return days;
    }

    public BigDecimal getOutlay()
    {
        return outlay;
    }

    public Date getTime1()
    {
        return time1;
    }

    public Date getTime2()
    {
        return time2;
    }
}
