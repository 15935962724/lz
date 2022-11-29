package tea.entity.confab;

import java.util.*;
import java.sql.SQLException;
import tea.db.DbAdapter;
import tea.entity.*;

public class Confabreception extends Entity
{
    private static Cache _cache = new Cache(100);
    private String dest;
    private String flight;
    private int human;
    private Date time;
    private int language;
    private int node;
    private boolean exists;
    public Confabreception(int node, int language) throws SQLException
    {
        this.node = node;
        this.language = language;
        load();
    }

    public static Confabreception find(int node, int language) throws SQLException
    {
        Confabreception obj = (Confabreception) _cache.get(node + ":" + language);
        if (obj == null)
        {
            obj = new Confabreception(node, language);
            _cache.put(node + ":" + language, obj);
        }
        return obj;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT dest,flight,human,time FROM Confabreception WHERE node=" + node + " AND language=" + language);
            if (db.next())
            {
                dest = db.getString(1);
                flight = db.getString(2);
                human = db.getInt(3);
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

    public void set(String dest, String flight, int human, Date time) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if (exists)
            {
                db.executeUpdate("UPDATE Confabreception SET dest=" + DbAdapter.cite(dest) + ",flight=" + DbAdapter.cite(flight) + ",human=" + human + ",time=" + DbAdapter.cite(time) + " WHERE node=" + node + " AND language=" + language);
            } else
            {
                db.executeUpdate("INSERT INTO Confabreception(node,language,dest,flight,human,time)VALUES(" +
                                 node + "," + language + "," + DbAdapter.cite(dest) + "," + DbAdapter.cite(flight) + "," + human + "," + DbAdapter.cite(time) + " )");
                _cache.remove(node + ":" + language);
            }
	} finally
        {
            db.close();
        }
        this.dest = dest;
        this.flight = flight;
        this.human = human;
        this.time = time;
        exists = true;
    }

    public String getDest()
    {
        return dest;
    }

    public String getFlight()
    {
        return flight;
    }

    public int getHuman()
    {
        return human;
    }

    public Date getTime()
    {
        return time;
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
}
