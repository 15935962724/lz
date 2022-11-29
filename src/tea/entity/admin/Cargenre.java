package tea.entity.admin;

import java.io.*;
import java.util.*;
import tea.db.DbAdapter;
import java.sql.SQLException;
import tea.entity.*;
import tea.entity.admin.Bulletin;
import java.sql.SQLException;

public class Cargenre extends Entity
{
    private int id;
    private String cargenrename;
    private Date times;

    private boolean exists;
    private static Cache _cache = new Cache(100);

    public Cargenre(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static Cargenre find(int id) throws SQLException
    {
        return new Cargenre(id);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT cargenrename,times  FROM Cargenre WHERE id = " + id);
            if (db.next())
            {
                cargenrename = db.getVarchar(1, 1, 1);
                times = db.getDate(2);
            } else
            {
                this.exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(String cargenrename, String community, RV _rv) throws SQLException
    {
        Date d = new Date();
        DbAdapter db = new DbAdapter();
        try
        {

            db.executeUpdate("INSERT INTO Cargenre (cargenrename,times,community,member)VALUES(" + DbAdapter.cite(cargenrename) + "," + DbAdapter.cite(d) + "," + DbAdapter.cite(community) + ",'" + _rv + "')");
        } finally
        {
            db.close();
        }

    }

    public void set(String cargenrename) throws SQLException
    {
        // Date d = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Cargenre SET cargenrename =" + DbAdapter.cite(cargenrename) + "  WHERE id =" + id);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));

    }

    public static Enumeration findByCommunity(String community, String sql) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM Cargenre WHERE community=" + DbAdapter.cite(community) + sql);
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

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Cargenre WHERE id=" + id);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
    }

    public String getCargenrename()
    {
        return cargenrename;
    }

    public Date getTimes()
    {
        return times;
    }
}
