package tea.entity.csvclub.testing;

import java.math.*;
import java.util.*;
import tea.db.*;
import tea.entity.*;
import tea.resource.*;
import java.util.*;
import java.text.*;
import java.sql.SQLException;

public class Csvdogplay extends Entity
{

    private int id;
    private String xvhao;
    private String host;
    private Date datetimes;
    private int idnum;

    public Csvdogplay()
    {
    }

    public static void getOption() throws SQLException
    {
        int id = 0;
        int idnum = 0;
        String dates = null;
        DbAdapter dbadapter = new DbAdapter();
        DbAdapter dbadapter2 = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select  id ,id号 from bbb ");
            while (dbadapter.next())
            {
                id = dbadapter.getInt(1);
                idnum = dbadapter.getInt(2);
                dates = Csvdogplay.getDatetime(idnum);
                dbadapter2.executeUpdate("update bbb set 时间 =" + dbadapter.cite(dates) + " where id =" + id);
            }
        } catch (Exception ex)
        {

        } finally
        {
            dbadapter.close();
            dbadapter2.close();
        }
    }

    public static void getOptionA() throws SQLException
    {
        int id = 0;
        int idnum = 0;
        String dates = null;
        DbAdapter dbadapter = new DbAdapter();
        DbAdapter dbadapter2 = new DbAdapter();
        try
        {

            dbadapter.executeQuery("select  id ,id号 from csv1_A ");
            while (dbadapter.next())
            {
                id = dbadapter.getInt(1);
                idnum = dbadapter.getInt(2);
                dates = Csvdogplay.getDatetimeX(idnum);
                dbadapter2.executeUpdate("update csv1_A set 时间 =" + dbadapter.cite(dates) + " where id =" + id);

            }

        } finally
        {
            dbadapter.close();
            dbadapter2.close();
        }

    }

    public static void getOptionB() throws SQLException
    {
        int id = 0;
        int idnum = 0;
        String dates = null;
        DbAdapter dbadapter = new DbAdapter();
        DbAdapter dbadapter2 = new DbAdapter();
        try
        {

            dbadapter.executeQuery("select  id ,id号 from csv1_B ");
            while (dbadapter.next())
            {
                id = dbadapter.getInt(1);
                idnum = dbadapter.getInt(2);
                dates = Csvdogplay.getDatetimeX(idnum);
                dbadapter2.executeUpdate("update csv1_B set 时间 =" + dbadapter.cite(dates) + " where id =" + id);

            }

        } finally
        {
            dbadapter.close();
            dbadapter2.close();
        }

    }

    public static String getDatetime(int num) throws SQLException, ParseException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            if (num <= 296)
            {
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                java.util.Date date1 = format.parse("2007-10-12 7:40:00");

                long Time = (date1.getTime() / 1000) + 120 * (num - 1);

                date1.setTime(Time * 1000);

                String mydate1 = format.format(date1);

                return mydate1;
            } else
            {
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                java.util.Date date1 = format.parse("2007-10-13 11:30:00");

                long Time = (date1.getTime() / 1000) + 120 * (num - 296 - 1);

                date1.setTime(Time * 1000);

                String mydate1 = format.format(date1);

                return mydate1;
            }
        } finally
        {
            dbadapter.close();
        }
    }

    public static String getDatetimeX(int num) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            if (num <= 296)
            {
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                java.util.Date date1 = format.parse("2007-10-12 7:40:00");

                long Time = (date1.getTime() / 1000) + 180 * (num - 1);

                date1.setTime(Time * 1000);

                String mydate1 = format.format(date1);

                return mydate1;
            } else
            {
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                java.util.Date date1 = format.parse("2007-10-13 11:30:00");

                long Time = (date1.getTime() / 1000) + 180 * (num - 296 - 1);

                date1.setTime(Time * 1000);

                String mydate1 = format.format(date1);

                return mydate1;
            }
        } catch (Exception ex)
        {
            ex.printStackTrace();
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

}
