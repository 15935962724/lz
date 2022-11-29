package tea.entity.csvclub;

import java.math.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;
import java.util.*;

public class Csvdogsmall extends Entity
{
    private int id;
    private String dogname;
    private String pic;
    private Date birtimes;
    private String intro;
    private String member;
    private Date times;
    private String picname;

    private static Cache _cache = new Cache(100);
    private boolean exists;

    public Csvdogsmall(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static Csvdogsmall find(int id) throws SQLException
    {
        return new Csvdogsmall(id);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT dogname,pic,birtimes,intro,member,times,picname FROM Csvdogsmall WHERE id=" + id);
            if (db.next())
            {
                dogname = db.getVarchar(1, 1, 1);
                pic = db.getVarchar(1, 1, 2);
                birtimes = db.getDate(3);
                intro = db.getVarchar(1, 1, 4);
                member = db.getVarchar(1, 1, 5);
                times = db.getDate(6);
                picname = db.getVarchar(1, 1, 7);
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

    public static void create(String dogname, String pic, Date birtimes, String intro, String member, String community, String picname) throws SQLException
    {
        Date times = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("insert into Csvdogsmall (dogname,pic,birtimes,intro,member,times,community,picname) values (" + DbAdapter.cite(dogname) + "," + DbAdapter.cite(pic) + "," + DbAdapter.cite(birtimes) + "," + DbAdapter.cite(intro) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(times) + " ," + DbAdapter.cite(community) + "," + DbAdapter.cite(picname) + ")");
        } finally
        {
            db.close();
        }

    }

    public void set(String dogname, String pic, Date birtimes, String intro, String picname) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Csvdogsmall set  dogname=" + DbAdapter.cite(dogname) + ",pic=" + DbAdapter.cite(pic) + ",birtimes=" + DbAdapter.cite(birtimes) + ",intro=" + DbAdapter.cite(intro) + ",picname=" + DbAdapter.cite(picname) + " where id=" + id);
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    public void detele() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from Csvdogsmall where id=" + id);
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    public static java.util.Enumeration findByCommunity(String community, String sql, int pos, int pageSize) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT id FROM Csvdogsmall WHERE community=" + DbAdapter.cite(community) + sql);

            for (int l = 0; dbadapter.next(); l++)
            {
                if (l >= pos)
                {
                    int id = dbadapter.getInt(1);
                    vector.addElement(new Integer(id));
                }
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    public static java.util.Enumeration findByCommunity(String community, String sql) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT id FROM Csvdogsmall WHERE community=" + DbAdapter.cite(community) + sql);

            while (dbadapter.next())
            {
                int id = dbadapter.getInt(1);
                vector.addElement(new Integer(id));
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
            dbadapter.executeQuery("SELECT COUNT(cs.id) FROM Csvdogsmall cs WHERE cs.community=" + dbadapter.cite(community) + sql);
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


    //添加的小犬的名字不能是重复的
    public static boolean isExisted(String dogname, String community) throws SQLException
    {
        boolean flag = false;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT id FROM Csvdogsmall WHERE community=" + dbadapter.cite(community) + "  and dogname=" + DbAdapter.cite(dogname));
            flag = dbadapter.next();
        } finally
        {
            dbadapter.close();
        }
        return flag;
    }

    public Date getBirtimes()
    {
        return birtimes;
    }
    public String getBirtimesToString()
    {
        if(birtimes==null)
            return "";
        return sdf.format(birtimes);
    }

    public String getDogname()
    {
        return dogname;
    }

    public String getIntro()
    {
        return intro;
    }

    public String getMember()
    {
        return member;
    }

    public String getPic()
    {
        return pic;
    }

    public Date getTimes()
    {
        return times;
    }

    public String getPicname()
    {
        return picname;
    }


}
