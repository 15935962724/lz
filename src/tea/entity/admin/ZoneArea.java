package tea.entity.admin;

import tea.db.*;
import java.sql.SQLException;
import java.sql.SQLException;

public class ZoneArea
{
    private int area;
    private static tea.entity.Cache _cache = new tea.entity.Cache(100);
    private boolean exists;
    private int zone;
    public ZoneArea()
    {
    }

    public ZoneArea(int zone,int area) throws SQLException
    {
        this.zone = zone;
        this.area = area;
        load();
    }

    public static ZoneArea find(int zone,int area) throws SQLException
    {
        ZoneArea obj = (ZoneArea) _cache.get(zone + ":" + area);
        if(obj == null)
        {
            obj = new ZoneArea(zone,area);
            _cache.put(zone + ":" + area,obj);
        }
        return obj;
    }

    public static void delete(int zone) throws SQLException
    {
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        try
        {
            db.executeUpdate("delete from ZoneArea where [zone]=" + zone);
            _cache.clear();
        } finally
        {
            db.close();
        }
    }

    /*
        public void set(String area, String zone) throws SQLException
        {
            tea.db.DbAdapter db = new tea.db.DbAdapter();
            try
            {
                if (exists)
                {
                    db.executeUpdate("UPDATE ZoneArea SET " +
                                            "area   =" + DbAdapter.cite(area) + "," +
                                            "[zone]   =" + DbAdapter.cite(zone) +
                                            " WHERE member=" + DbAdapter.cite(member)
                            );
                    _cache.remove(member);
                } else
                {
                    create(member, area, zone);
                }} finally
            {
                db.close();
            }
        }*/

    public static void create(int zone,int area) throws SQLException
    {
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        try
        {
            db.executeUpdate("insert into ZoneArea(zone,area) values (" +
                             zone + "," +
                             area +
                             ")");
            _cache.remove(zone + ":" + area);
        } finally
        {
            db.close();
        }
    }

    private void load() throws SQLException
    {
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        try
        {
            db.executeQuery("SELECT area FROM ZoneArea WHERE area=" + (area) + " AND zone=" + zone);
            if(db.next())
            {
                this.exists = true;
            } else
            {
                this.exists = false;
            }
            /* if (new tea.entity.site.License().getWebMaster().equals(member))
             {
                 db.executeQuery("SELECT id FROM AdminRole");
                 StringBuilder sb = new StringBuilder();
                 while (db.next())
                 {
                     sb.append("/" + db.getInt(1) + "/");
                 }
                 area = sb.toString();
             }*/
        } finally
        {
            db.close();
        }
    }

    public static java.util.Enumeration findByZone(int zone) throws SQLException
    {
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        java.util.Vector vector = new java.util.Vector();
        try
        {
            db.executeQuery("SELECT DISTINCT area FROM ZoneArea WHERE zone=" + zone);
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

    public static int findByArea(int area) throws SQLException
    {
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        try
        {
            return db.getInt("SELECT DISTINCT zone FROM ZoneArea WHERE area=" + area);
        } finally
        {
            db.close();
        }
    }

    public int getArea()
    {
        return area;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getZone()
    {
        return zone;
    }
}
