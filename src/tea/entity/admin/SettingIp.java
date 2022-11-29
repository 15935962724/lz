package tea.entity.admin;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class SettingIp extends Entity
{
    private int ipid;
    private String ip;
    private String ip2;
    private String ip3;
    private String community;
    public SettingIp(int ipid) throws SQLException
    {
        this.ipid = ipid;
        load();
    }

    public static SettingIp find(int ipid) throws SQLException
    {
        return new SettingIp(ipid);

    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT ip,ip2,ip3,community FROM SettingIp WHERE ipid =  " + ipid);
            while(db.next())
            {
                ip = db.getString(1);
                ip2 = db.getString(2);
                ip3 = db.getString(3);
                community = db.getString(4);
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(String ip,String ip2,String ip3,String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("INSERT INTO SettingIp(ip,ip2,ip3,community)VALUES (" + db.cite(ip) + "," + db.cite(ip2) + "," + db.cite(ip3) + "," + db.cite(community) + ")");
        } finally
        {
            db.close();
        }
    }

    public void set(String ip,String ip2,String ip3) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE SettingIp SET ip =" + db.cite(ip) + ", ip2 =" + db.cite(ip2) + ", ip3 =" + db.cite(ip3) + " WHERE ipid=" + ipid);
        } finally
        {
            db.close();
        }
    }

    public static Enumeration find(String community,String sql,int pos,int size)
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT ipid FROM SettingIp WHERE community= " + db.cite(community) + sql,pos,size);
            while(db.next())
            {
                vector.add(new Integer(db.getInt(1)));
            }
        } catch(Exception exception3)
        {
            System.out.print(exception3);
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
            db.executeUpdate("DELETE FROM  SettingIp WHERE ipid = " + ipid);
        } finally
        {
            db.close();
        }
    }

    public String getCommunity()
    {
        return community;
    }

    public String getIp()
    {
        return ip;
    }

    public String getIp2()
    {
        return ip2;
    }

    public String getIp3()
    {
        return ip3;
    }


}
