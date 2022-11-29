package tea.entity.admin;

import tea.entity.*;
import tea.db.*;
import java.sql.SQLException;

public class SFAccountYearAccessories
{

    private static tea.entity.Cache _cache = new tea.entity.Cache(100);
    private boolean exists;
    private int sfaccountYearAccessories;
    private String name;
    private String picture;
    private int formsYear;
    private int sfaccount;


    public SFAccountYearAccessories(int sfaccountYearAccessories) throws SQLException
    {
        this.sfaccountYearAccessories = sfaccountYearAccessories;
        load();
    }

    public static SFAccountYearAccessories find(int sfaccountYearAccessories) throws SQLException
    {
        SFAccountYearAccessories obj = (SFAccountYearAccessories) _cache.get(new Integer(sfaccountYearAccessories));
        if(obj == null)
        {
            obj = new SFAccountYearAccessories(sfaccountYearAccessories);
            _cache.put(new Integer(sfaccountYearAccessories),obj);
        }
        return obj;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM SFAccountYearAccessories WHERE sfaccountyearaccessories=" + sfaccountYearAccessories);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(sfaccountYearAccessories));
    }


    public void set(int formsYear,int sfaccount,String name,String picture) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT sfaccountyearaccessories FROM  SFAccountYearAccessories WHERE sfaccountyearaccessories=" + sfaccountYearAccessories);
            if(db.next())
            {
                db.executeUpdate("UPDATE SFAccountYearAccessories SET name=" + DbAdapter.cite(name) + ",picture=" + DbAdapter.cite(picture) + ",formsyear=" + formsYear + ",sfaccount=" + sfaccount + "	 WHERE sfaccountyearaccessories=" + sfaccountYearAccessories);
            } else
            {
                db.executeUpdate("INSERT INTO SFAccountYearAccessories(formsyear,sfaccount,name,picture)VALUES(" + formsYear + "," + sfaccount + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(picture) + ")");
            }
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(sfaccountYearAccessories));
    }


    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT  name,picture,formsyear,sfaccount    FROM SFAccountYearAccessories WHERE sfaccountyearaccessories=" + sfaccountYearAccessories);
            if(db.next())
            {
                name = db.getVarchar(1,1,1);
                picture = db.getString(2);
                formsYear = db.getInt(3);
                sfaccount = db.getInt(4);
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

    public static java.util.Enumeration find(int formsYear,int sfaccount) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT sfaccountyearaccessories FROM SFAccountYearAccessories WHERE formsyear=" + formsYear + " AND sfaccount=" + sfaccount);
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

    public boolean isExists()
    {
        return exists;
    }


    public int getSfaccountAccessories()
    {
        return sfaccountYearAccessories;
    }

    public String getName()
    {
        return name;
    }

    public String getPicture()
    {
        return picture;
    }

    public int getFormsYear()
    {

        return formsYear;
    }

    public int getSfaccount()
    {
        return sfaccount;
    }


}
