package tea.entity.csvclub;

import java.math.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class Csvtemplet extends Entity
{
    //public static final String LOCATION = "/doghouse/csvtemplet/";
    private static Cache _cache = new Cache(10);
    private int csvtemplet;
    private String name;
    private String picture;
    private String picture2;
    private boolean exists;
    private String community;
    public Csvtemplet(int csvtemplet) throws SQLException
    {
        this.csvtemplet = csvtemplet;
        loadBasic();
    }

    public Csvtemplet(int csvtemplet, int item, BigDecimal money, int poyear, int outlay, java.util.Date time)
    {

    }

    private void loadBasic() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT community,name,picture,picture2 FROM Csvtemplet WHERE csvtemplet=" + csvtemplet);
            if (dbadapter.next())
            {
                community = dbadapter.getString(1);
                name = dbadapter.getString(2);
                picture = dbadapter.getString(3);
                picture2 = dbadapter.getString(4);
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            dbadapter.close();
        }
    }

    public void delete() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("DELETE Csvtemplet WHERE csvtemplet=" + csvtemplet);
        } finally
        {
            dbadapter.close();
        }
        _cache.remove(new Integer(csvtemplet));
    }

    public static void create(int csvtemplet, String community, String name, String picture, String picture2) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("INSERT INTO Csvtemplet(csvtemplet,community,name,picture,picture2) VALUES(" +
                                    csvtemplet + "," + dbadapter.cite(community) + "," + dbadapter.cite(name) + "," + dbadapter.cite(picture) + "," + dbadapter.cite(picture2) + ")");
        } finally
        {
            dbadapter.close();
        }
        _cache.remove(new Integer(csvtemplet));
    }

    public void set(String name, String picture, String picture2) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("UPDATE Csvtemplet SET name=" + dbadapter.cite(name) + ",picture=" + dbadapter.cite(picture) + ",picture2=" + dbadapter.cite(picture2) +
                                    " WHERE csvtemplet=" + csvtemplet);
        } finally
        {
            dbadapter.close();
        }
        this.name = name;
        this.picture = picture;
        this.picture2 = picture2;
    }

    public static java.util.Enumeration findByCommunity(String community) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT ct.csvtemplet FROM Csvtemplet ct WHERE community=" + dbadapter.cite(community));
            while (dbadapter.next())
            {
                int csvtemplet = dbadapter.getInt(1);
                vector.addElement(new Integer(csvtemplet));
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    public static Csvtemplet find(int csvtemplet) throws SQLException
    {
        Csvtemplet obj = (Csvtemplet) _cache.get(new Integer(csvtemplet));
        if (obj == null)
        {
            obj = new Csvtemplet(csvtemplet);
            _cache.put(new Integer(csvtemplet), obj);
        }
        return obj;
    }

    public int getCsvtemplet()
    {
        return csvtemplet;
    }

    public String getName()
    {
        return name;
    }

    public String getPicture2()
    {
        return picture2;
    }

    public String getPicture()
    {
        return picture;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getCommunity()
    {
        return community;
    }

    public static int count(String community, String sql) throws SQLException
    {
        int j = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT COUNT(community) FROM Csvtemplet WHERE community=" + DbAdapter.cite(community) + sql);
            if (dbadapter.next())
            {
                j = dbadapter.getInt(1);
            }
        } finally
        {
            dbadapter.close();
        }
        return j;
    }
}
