package tea.entity.admin.earth;

import java.sql.SQLException;
import java.util.*;
import tea.entity.*;
import tea.db.*;

public class EarthCdn extends Entity
{
    private String earthcdn;
    private String pwd;
    private String ip;
    private Date time;
    private boolean exists;

    public EarthCdn(String earthcdn) throws SQLException
    {
        this.earthcdn = earthcdn;
        load();
    }

    public static EarthCdn find(String earthcdn) throws SQLException
    {
        EarthCdn obj = new EarthCdn(earthcdn);
        return obj;
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT pwd,ip,time FROM EarthCdn WHERE earthcdn=" + DbAdapter.cite(earthcdn));
            if (db.next())
            {
                pwd = db.getString(1);
                ip = db.getString(2);
                time = db.getDate(3);
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

    public static void create(String earthcdn, String pwd) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO EarthCdn(earthcdn,pwd)VALUES(" + db.cite(earthcdn) + "," + db.cite(pwd) + ")");
        } finally
        {
            db.close();
        }
    }

    public static Enumeration find(String sql, int pos, int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT earthcdn FROM EarthCdn WHERE 1=1" + sql);
            while (db.next())
            {
                v.add(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public boolean isPassword(String p, String ip) throws SQLException
    {
        if (pwd.equals(p))
        {
            Date time = new Date();
            p = String.valueOf(System.currentTimeMillis()).substring(7);
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeUpdate("UPDATE EarthCdn SET pwd=" + db.cite(p) + ",ip=" + db.cite(ip) + ",time=" + db.cite(time) + " WHERE earthcdn=" + DbAdapter.cite(earthcdn));
            } finally
            {
                db.close();
            }
            this.pwd = p;
            this.ip = ip;
            this.time = time;
            return true;
        }
        return false;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getIp()
    {
        return ip;
    }

    public String getPwd()
    {
        return pwd;
    }

    public Date getTime()
    {
        return time;
    }

    public String getTimeToString()
    {
        if (time == null)
        {
            return "";
        }
        return sdf.format(time);
    }
}
