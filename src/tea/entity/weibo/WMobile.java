package tea.entity.weibo;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.DbAdapter;
import tea.entity.*;
import tea.entity.stat.*;

public class WMobile
{
    protected static Cache c = new Cache(50);
    public int wmobile;
    public String manufacturer; //制造商
    public String product; //型号
    public String version; //固件版本
    public String deviceid; //设备ID,IMEI/MEID
    public String number; //手机号
    public String display; //分辨率
    public String ip; //IP地址
    public String city; //城市/地区
    public Date time; //时间

    public WMobile(int wmobile)
    {
        this.wmobile = wmobile;
    }

    public static WMobile find(int wmobile) throws SQLException
    {
        WMobile t = (WMobile) c.get(wmobile);
        if(t == null)
        {
            ArrayList al = find(" AND wmobile=" + wmobile,0,1);
            t = al.size() < 1 ? new WMobile(wmobile) : (WMobile) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT wmobile,manufacturer,product,version,deviceid,number,display,ip,city,time FROM wmobile WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                WMobile t = new WMobile(rs.getInt(i++));
                t.manufacturer = rs.getString(i++);
                t.product = rs.getString(i++);
                t.version = rs.getString(i++);
                t.deviceid = rs.getString(i++);
                t.number = rs.getString(i++);
                t.display = rs.getString(i++);
                t.ip = rs.getString(i++);
                t.city = rs.getString(i++);
                t.time = db.getDate(i++);
                c.put(t.wmobile,t);
                al.add(t);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM wmobile WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(wmobile < 1)
            sql = "INSERT INTO wmobile(manufacturer,product,version,deviceid,number,display,ip,city,time)VALUES(" + DbAdapter.cite(manufacturer) + "," + DbAdapter.cite(product) + "," + DbAdapter.cite(version) + "," + DbAdapter.cite(deviceid) + "," + DbAdapter.cite(number) + "," + DbAdapter.cite(display) + "," + DbAdapter.cite(ip) + "," + DbAdapter.cite(city) + "," + DbAdapter.cite(time) + ")";
        else
            sql = "UPDATE wmobile SET manufacturer=" + DbAdapter.cite(manufacturer) + ",product=" + DbAdapter.cite(product) + ",version=" + DbAdapter.cite(version) + ",deviceid=" + DbAdapter.cite(deviceid) + ",number=" + DbAdapter.cite(number) + ",display=" + DbAdapter.cite(display) + ",ip=" + DbAdapter.cite(ip) + ",city=" + DbAdapter.cite(city) + ",time=" + DbAdapter.cite(time) + " WHERE wmobile=" + wmobile;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(wmobile,sql);
        } finally
        {
            db.close();
        }
        c.remove(wmobile);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(wmobile,"DELETE FROM wmobile WHERE wmobile=" + wmobile);
        } finally
        {
            db.close();
        }
        c.remove(wmobile);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(wmobile,"UPDATE wmobile SET " + f + "=" + DbAdapter.cite(v) + " WHERE wmobile=" + wmobile);
        } finally
        {
            db.close();
        }
        c.remove(wmobile);
    }

    //
    public static void ref() throws SQLException
    {
        DbAdapter db = new DbAdapter(),d2 = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT ip FROM wmobile WHERE city IS NULL GROUP BY ip",0,Integer.MAX_VALUE);
            while(rs.next())
            {
                String ip = rs.getString(1);
                String city = Ip.findByIp(ip);
                city = city.substring(0,(city.startsWith("内蒙古") || city.startsWith("黑龙江")) ? 3 : 2);
                d2.executeUpdate(0,"UPDATE wmobile SET city=" + DbAdapter.cite(city) + " WHERE ip=" + DbAdapter.cite(ip));
            }
            rs.close();
        } finally
        {
            db.close();
            d2.close();
        }
    }
}
