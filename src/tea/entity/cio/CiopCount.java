package tea.entity.cio;

import java.sql.*;
import java.util.*;
import java.text.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import tea.entity.site.*;
import tea.entity.member.*;

public class CiopCount extends Entity
{
    public static Enumeration findDate(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select distinct(CONVERT(varchar(10), cometime, 120 )) from ciopart where 1=1" + sql);
            for(int i = 0;i < pos;i++)
                db.next();
            for(int i = 0;i < size && db.next();i++)
                v.add(db.getString(1));
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static int findSumCount(String sql) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select count(ciopart) from ciopart where 1=1" + sql);
            while(db.next())
            {
                i = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return i;
    }

    public static void upResetHouse(int ciopart,String rchamber) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update ciopart set rchamber=" + db.cite(rchamber) + " where ciopart=" + ciopart);
        } finally
        {
            db.close();
        }
    }

    public static void upResetRname(int ciopart,String rname) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update ciopart set rname=" + db.cite(rname) + " where ciopart=" + ciopart);
        } finally
        {
            db.close();
        }
    }


    public static String rehour(Date date) throws SQLException
    {
        String hour = "";
        SimpleDateFormat sdf = new SimpleDateFormat("HH");
        hour = sdf.format(date);

        if(hour.substring(0,1).equals("0"))
        {
            hour = hour.substring(1,2);
        }
        return hour;
    }

    public static String reMin(Date date) throws SQLException
    {
        String hour = "";
        SimpleDateFormat sdf = new SimpleDateFormat("mm");
        hour = sdf.format(date);

        if(hour.substring(0,1).equals("0"))
        {
            hour = hour.substring(1,2);
        }
        return hour;
    }


}
