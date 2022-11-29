package tea.entity.csvclub;

import java.math.*;
import java.sql.*;
import java.util.Date;
import tea.db.*;
import tea.entity.*;

public class Csvjoinoutlay extends Entity
{
    private static Cache _cache = new Cache(20);
    public static final String SERVICE_TYPE[] =
                                                {"AAA", "BBB", "CCC", "DDD"};
    public static final String SORT_TYPE[] =
        {"A", "B", "C", "D"};
    private int csvjoinoutlay;
    private String content;
    private String community;
    private String name;
    private boolean exists;
    private BigDecimal season1;
    private BigDecimal season2;
    private BigDecimal season3;
    private BigDecimal season4;
    private Date time_j;
    private Date times;
    private String typeid;
    private int integrals;//积分
    private String photo;
    private int agio;


    public Csvjoinoutlay(int csvjoinoutlay) throws SQLException
    {
        this.csvjoinoutlay = csvjoinoutlay;
        loadBasic();
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT community,name,season1,season2,season3,season4,content,time_j,times,typeid,integrals,photo FROM Csvjoinoutlay WHERE csvjoinoutlay=" + csvjoinoutlay);
            if (dbadapter.next())
            {
                community = dbadapter.getString(1);
                name = dbadapter.getVarchar(1, 1, 2);
                season1 = dbadapter.getBigDecimal(3, 2);
                season2 = dbadapter.getBigDecimal(4, 2);
                season3 = dbadapter.getBigDecimal(5, 2);
                season4 = dbadapter.getBigDecimal(6, 2);
                content = dbadapter.getVarchar(1, 1, 7);
                time_j = dbadapter.getDate(8);
                times = dbadapter.getDate(9);
                typeid = dbadapter.getString(10);
                integrals = dbadapter.getInt(11);
                photo = dbadapter.getString(12);
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
            dbadapter.executeUpdate("DELETE Csvjoinoutlay WHERE csvjoinoutlay=" + csvjoinoutlay);
        } finally
        {
            dbadapter.close();
        }
        exists = false;
        _cache.remove(new Integer(csvjoinoutlay));
    }

    public static void create(String community, String name, BigDecimal season1, BigDecimal season2, BigDecimal season3, BigDecimal season4, String content, Date time_j, String typeid,String photo) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        Date times = new Date();
        try
        {
            dbadapter.executeUpdate("INSERT INTO Csvjoinoutlay(community,name,season1,season2,season3,season4,content,time_j,times,typeid,photo) VALUES(" + dbadapter.cite(community) + "," + dbadapter.cite(name) + "," +
                                    season1 + "," + season2 + "," + season3 + "," + season4 + "," + dbadapter.cite(content) + "," + dbadapter.cite(time_j) + "," + dbadapter.cite(times) + " ," + dbadapter.cite(typeid) + ","+dbadapter.cite(photo)+" )");
        } finally
        {
            dbadapter.close();
        }
    }

    public void set(String name, BigDecimal season1, BigDecimal season2, BigDecimal season3, BigDecimal season4, String content, Date time_j, String typeid,String photo) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        Date times = new Date();
        try
        {
            dbadapter.executeUpdate("UPDATE Csvjoinoutlay SET name=" + dbadapter.cite(name) +
                                    ",season1 =" + season1 +
                                    ",season2 =" + season2 +
                                    ",season3 =" + season3 +
                                    ",season4 =" + season4 +
                                    ",content =" + dbadapter.cite(content) +
                                    ",time_j =" + dbadapter.cite(time_j) +
                                    ",times =" + dbadapter.cite(times) +
                                    ",typeid= " + dbadapter.cite(typeid) + ",photo="+dbadapter.cite(photo)+" WHERE csvjoinoutlay=" + csvjoinoutlay);
        } finally
        {
            dbadapter.close();
        }
        this.name = name;
        this.season1 = season1;
        this.season2 = season2;
        this.season3 = season3;
        this.season4 = season4;
        this.content = content;
        this.time_j = time_j;
        this.times = times;
        this.typeid = typeid;
        this.photo = photo;
    }

    public static java.util.Enumeration find(String community, String sql, int pos, int pageSize) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT csvjoinoutlay FROM Csvjoinoutlay  WHERE community=" + dbadapter.cite(community) + sql);
            for (int l = 0; dbadapter.next(); l++)
            {
                if (l >= pos)
                {
                    int csvjoinoutlay = dbadapter.getInt(1);
                    vector.addElement(new Integer(csvjoinoutlay));
                }
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    public static int count(String community, String sql) throws SQLException
    {
        int count = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT COUNT(cs.csvjoinoutlay) FROM Csvjoinoutlay cs WHERE cs.community=" + dbadapter.cite(community) + sql);
            if (dbadapter.next())
            {
                count = dbadapter.getInt(1);
            }
        } finally
        {
            dbadapter.close();
        }
        return count;
    }

    public static Csvjoinoutlay find(int csvjoinoutlay) throws SQLException
    {
        Csvjoinoutlay obj = (Csvjoinoutlay) _cache.get(new Integer(csvjoinoutlay));
        if (obj == null)
        {
            obj = new Csvjoinoutlay(csvjoinoutlay);
            _cache.put(new Integer(csvjoinoutlay), obj);
        }
        return obj;
    }
    //循环修改会员积分
    public static void updatememberInt(int integrals, int id) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update Csvjoinoutlay set integrals =  " + integrals + " where csvjoinoutlay=" + id);
        } finally
        {
            db.close();
        }

    }
    public int getCsvjoinoutlay()
    {
        return csvjoinoutlay;
    }

    public String getContent()
    {
        return content;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getName()
    {
        return name;
    }

    public boolean isExists()
    {
        return exists;
    }

    public BigDecimal getSeason4()
    {
        return season4;
    }

    public BigDecimal getSeason3()
    {
        return season3;
    }

    public BigDecimal getSeason2()
    {
        return season2;
    }

    public BigDecimal getSeason1()
    {
        return season1;
    }

    public Date getTime_j()
    {
        return time_j;
    }

    public String getTime_jToString()
    {
        if (time_j == null)
            return "";
        return sdf.format(time_j);
    }

    public Date getTimes()
    {
        return times;
    }

    public String getTimesTostring()
    {
        if (times == null)
            return "";
        return sdf.format(times);
    }

    public String getTypeid()
    {
        return typeid;
    }

    public int getIntegrals()
    {
        return integrals;
    }

    public int getAgio()
    {
        return agio;
    }

    public String getPhoto()
    {
        return photo;
    }
}
