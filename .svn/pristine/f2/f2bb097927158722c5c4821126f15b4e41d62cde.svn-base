package tea.entity.csvclub;

import java.math.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class Csvtempletstyle extends Entity
{
    private static Cache _cache = new Cache(100);
    private int csvtempletstyle;
    private int csvtemplet;
    private String name;
    private String picture;
    private String picture2;
    private String community;
    private String member;
    private boolean exists;
    public Csvtempletstyle(int csvtempletstyle) throws SQLException
    {
        this.csvtempletstyle = csvtempletstyle;
        loadBasic();
    }

    public Csvtempletstyle(int csvtemplet, int item, BigDecimal money, int poyear, int outlay, java.util.Date time)
    {

    }

    private void loadBasic() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT csvtemplet,name,picture,picture2,community,member FROM Csvtempletstyle WHERE csvtempletstyle=" + csvtempletstyle);
            if (dbadapter.next())
            {
                csvtemplet = dbadapter.getInt(1);
                name = dbadapter.getString(2);
                picture = dbadapter.getString(3);
                picture2 = dbadapter.getString(4);
                community = dbadapter.getString(5);
                member = dbadapter.getString(6);
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
            dbadapter.executeUpdate("DELETE Csvtempletstyle WHERE csvtempletstyle=" + csvtempletstyle);
        } finally
        {
            dbadapter.close();
        }
        _cache.remove(new Integer(csvtempletstyle));
    }

    public static int create(int csvtemplet, String name, String picture, String picture2, String community, String member) throws SQLException
    {
        int id = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("INSERT INTO Csvtempletstyle(csvtemplet,name,picture,picture2,community,member) VALUES(" +
                                    csvtemplet + "," + dbadapter.cite(name) + "," + dbadapter.cite(picture) + "," + dbadapter.cite(picture2) + "," + dbadapter.cite(community) + "," + dbadapter.cite(member) +
                                    ")");
            id = dbadapter.getInt("SELECT @@IDENTITY");
        } finally
        {
            dbadapter.close();
        }
        _cache.remove(new Integer(id));
        return id;
    }

    public void set(String name, String picture, String picture2, String member) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("UPDATE Csvtempletstyle SET name=" + dbadapter.cite(name) + ",picture=" + dbadapter.cite(picture) + ",picture2=" + dbadapter.cite(picture2) + ",member=" +
                                    dbadapter.cite(member) + " WHERE csvtempletstyle=" + csvtempletstyle);
        } finally
        {
            dbadapter.close();
        }
        this.name = name;
        this.picture = picture;
        this.picture2 = picture2;
        this.member = member;
    }

    public static java.util.Enumeration findByCsvtemplet(int csvtemplet, String sql, int pos, int size) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT ct.csvtempletstyle FROM Csvtempletstyle ct WHERE ct.csvtemplet=" + csvtemplet + sql);
            for (int l = 0; l < pos + size && dbadapter.next(); l++)
            {
                if (l >= pos)
                {
                    int csvtempletstyle = dbadapter.getInt(1);
                    vector.addElement(new Integer(csvtempletstyle));
                }
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    public static Csvtempletstyle find(int csvtempletstyle) throws SQLException
    {
        Csvtempletstyle obj = (Csvtempletstyle) _cache.get(new Integer(csvtempletstyle));
        if (obj == null)
        {
            obj = new Csvtempletstyle(csvtempletstyle);
            _cache.put(new Integer(csvtempletstyle), obj);
        }
        return obj;
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

    public int getCsvtemplet()
    {
        return csvtemplet;
    }

    public int getCsvtempletstyle()
    {
        return csvtempletstyle;
    }

    public String getMember()
    {
        return member;
    }

    public String getCommunity()
    {
        return community;
    }

    public static int countByCsvtemplet(int csvtemplet, String sql) throws SQLException
    {
        int j = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT COUNT(community) FROM Csvtempletstyle WHERE csvtemplet=" + csvtemplet + sql);
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
