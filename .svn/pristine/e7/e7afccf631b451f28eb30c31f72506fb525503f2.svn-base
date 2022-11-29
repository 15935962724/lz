package tea.entity.citybcst;

import java.sql.*;

import tea.db.*;
import tea.entity.*;
import java.util.Vector;
import java.util.Enumeration;

public class Cityname extends Entity
{
    private int id;
    private String cityname;
    private int fatherid;
    private int levelid;

    public static Cityname find(int id) throws SQLException
    {

        return new Cityname(id);
    }

    public Cityname(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select * from Cityname where id =" + id);
            if(db.next())
            {
                int j = 1;
                id = db.getInt(j++);
                cityname = db.getString(j++);
                fatherid = db.getInt(j++);
                levelid = db.getInt(j++);
            }
        } finally
        {
            db.close();
        }
    }

    public static Enumeration findByCommunity(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();

        try
        {
            db.executeQuery("SELECT id FROM cityname WHERE 1=1 " + sql,pos,size);
            while(db.next())
            {
                v.addElement(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public String getCityname()
    {
        return cityname;
    }

    public int getFatherid()
    {
        return fatherid;
    }

    public int getId()
    {
        return id;
    }

    public int getLevelid()
    {
        return levelid;
    }
}
