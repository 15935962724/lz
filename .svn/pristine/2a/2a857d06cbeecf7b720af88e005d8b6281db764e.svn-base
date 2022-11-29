package tea.entity.csvclub;

import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;


public class CsvdogXfund extends Entity
{
    private int id;
    private String member;
    private Date datetimes;
    private int hipprice;
    private int DNAprice;
    private int proveprice;
    private int sunprice;

    public CsvdogXfund()
    {

    }

    public static void create(String member, int hipprice, int DNAprice, int proveprice, int sunprice) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        Date datetimes = new Date();
        try
        {
            dbadapter.executeUpdate("insert into CsvdogXfund (member ,datetimes,hipprice,DNAprice,proveprice,sunprice) values (" + dbadapter.cite(member) + "," + dbadapter.cite(datetimes) + "," + hipprice + "," + DNAprice + "," + proveprice + "," + sunprice + ")");
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    public Date getDatetimes()
    {
        return datetimes;
    }

    public int getHipprice()
    {
        return hipprice;
    }

    public int getId()
    {
        return id;
    }

    public String getMember()
    {
        return member;
    }

    public int getProveprice()
    {
        return proveprice;
    }

    public int getSunprice()
    {
        return sunprice;
    }

    public int getDNAprice()
    {
        return DNAprice;
    }
}
