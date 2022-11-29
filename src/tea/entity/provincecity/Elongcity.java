package tea.entity.provincecity;

import java.sql.SQLException;
import java.util.Date;
import java.util.Enumeration;
import java.util.Vector;

import tea.db.DbAdapter;

public class Elongcity
{
    private int geoid; //主键ID
    private String country; //国家名称
    private String provinceName_CN; //省份中文名称
    private String provinceName_EN; //省份 英文
    private String cityName_CN; //城市中文
    private String cityName_EN; //城市英文
    private String cityid; //城市ID --唯一
    private int provinceId; // 省份ID
    private int hotcity;
    private boolean exists;

    public Elongcity(String cityid) throws SQLException
    {
        this.cityid = cityid;
        load();
    }

    public static Elongcity find(String cityid) throws SQLException
    {
        return new Elongcity(cityid);
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT geoid,country,provinceName_CN,provinceName_EN,cityName_CN,cityName_EN,provinceId,hotcity FROM elong_city  WHERE cityid=" + db.cite(cityid));
            if(db.next())
            {
                int x = 1;
                geoid = db.getInt(x++);
                country = db.getString(x++);
                provinceName_CN = db.getString(x++);
                provinceName_EN = db.getString(x++);
                cityName_CN = db.getString(x++);
                cityName_EN = db.getString(x++);
                provinceId = db.getInt(x++);
                hotcity = db.getInt(x++);
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


    public static Enumeration find(String sql,int pos,int size)
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT provinceId FROM elong_city WHERE 1=1 " + sql,pos,size);
            while(db.next())
            {
                vector.add(db.getString(1));
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

    public static String getProvincename(String provinceid) throws SQLException
    {
        String pname = "";
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(" select provinceName_CN from elong_city  WHERE provinceid=" + db.cite(provinceid));
            if(db.next())
            {
                pname = db.getString(1);
            }
        } finally
        {
            db.close();
        }
        return pname;
    }

    public static String getCityname(String cityid) throws SQLException
    {
        String pname = "";
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(" select cityName_CN from elong_city  WHERE cityid=" + db.cite(cityid));
            if(db.next())
            {
                pname = db.getString(1);
            }
        } finally
        {
            db.close();
        }
        return pname;
    }

    public static Enumeration findCity(String sql,int pos,int size)
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT cityid FROM elong_city WHERE 1=1 " + sql,pos,size);
            while(db.next())
            {
                vector.add(db.getString(1));
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

    public void set(String country,String provinceName_CN,String provinceName_EN,int hotcity) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE  elong_city set country=" + db.cite(country) + ",provinceName_CN=" + db.cite(provinceName_CN) + ",provinceName_EN=" + db.cite(provinceName_EN) + ",hotcity=" + hotcity + " WHERE cityid=" + db.cite(cityid));
        } finally
        {
            db.close();
        }
    }

    public void setCity(int provinceId,String cityName_CN,String cityName_EN,int hotcity) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE  elong_city set provinceId=" + provinceId + ",cityName_CN=" + db.cite(cityName_CN) + ",cityName_EN=" + db.cite(cityName_EN) + ",hotcity=" + hotcity + " WHERE cityid=" + db.cite(cityid));
        } finally
        {
            db.close();
        }
    }

    public static String create(String country,String provinceName_CN,String provinceName_EN,String cityName_CN,String cityName_EN,String cityid,int provinceId,int hotcity) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        String c = "0";
        try
        {
            db.executeUpdate("INSERT INTO elong_city (country,provinceName_CN,provinceName_EN,cityName_CN,cityName_EN,cityid,provinceId,hotcity)VALUES(" + db.cite(country) + "," +
                             " " + db.cite(provinceName_CN) + "," + db.cite(provinceName_EN) + "," + db.cite(cityName_CN) + "," + db.cite(cityName_EN) + "," + db.cite(cityid) + "," + provinceId + "," + hotcity + " ) ");
            db.executeQuery("select  MAX(cityid) from elong_city");
            if(db.next())
            {
                c = db.getString(1);
            }
        } finally
        {
            db.close();
        }
        return c;
    }

    public static synchronized String getMaxcityid() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        String c = "0";
        try
        {
            db.executeQuery("select  MAX(cityid) from elong_city");
            if(db.next())
            {
                c = db.getString(1);
            }
        } finally
        {
            db.close();
        }
        return c;
    }

    public static synchronized String getMaxcityid(int provinceId) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        String c = "0";
        try
        {
            db.executeQuery("select  MAX(cityid) from elong_city where provinceId=" + provinceId);
            if(db.next())
            {
                c = db.getString(1);
            }
        } finally
        {
            db.close();
        }
        return c;
    }

    public static synchronized String getMincityid(int provinceId) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        String c = "0";
        try
        {
            db.executeQuery("select  Min(cityid) from elong_city where provinceId=" + provinceId);
            if(db.next())
            {
                c = db.getString(1);
            }
        } finally
        {
            db.close();
        }
        return c;
    }

    public static synchronized int getMaxprovinceIdint() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int c = 0;
        try
        {
            db.executeQuery("select  MAX(provinceId) from elong_city");
            if(db.next())
            {
                c = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return c;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM elong_city WHERE cityid=" + db.cite(cityid));
        } finally
        {
            db.close();
        }
    }


    public static int count(String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(DISTINCT(provinceId)) FROM elong_city WHERE 1=1" + sql);
            if(db.next())
            {
                count = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return count;
    }

    public static int countCity(String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(cityid) FROM elong_city WHERE 1=1" + sql);
            if(db.next())
            {
                count = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return count;
    }

    public int getGeoid()
    {
        return geoid;
    }

    public String getCountry()
    {
        return country;
    }

    public String getProvinceName_CN()
    {
        return provinceName_CN;
    }

    public String getProvinceName_EN()
    {
        return provinceName_EN;
    }

    public String getCityName_CN()
    {
        return cityName_CN;
    }

    public String getCityName_EN()
    {
        return cityName_EN;
    }

    public String getCityid()
    {
        return cityid;
    }

    public int getProvinceId()
    {
        return provinceId;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getHotcity()
    {
        return hotcity;
    }

    public void setHotcity(int hotcity)
    {
        this.hotcity = hotcity;
    }
}
