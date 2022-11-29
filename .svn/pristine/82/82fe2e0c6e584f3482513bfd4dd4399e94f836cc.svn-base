package tea.entity.csvclub;

import java.math.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;
import java.util.*;

public class Csvdogpic extends Entity
{
    private int id;
    private String bloodlineletterid;
    private String small_pic;
    private String big_pic;
    private Date times;
    private String member;
    private String picname;

    private static Cache _cache = new Cache(100);
    private boolean exists;

    public Csvdogpic(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static Csvdogpic find(int id) throws SQLException
    {
        return new Csvdogpic(id);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select bloodlineletterid,small_pic,big_pic,times,member,picname from Csvdogpic where id =" + id);
            if (db.next())
            {
                bloodlineletterid = db.getString(1);
                small_pic = db.getVarchar(1, 1, 2);
                big_pic = db.getVarchar(1, 1, 3);
                times = db.getDate(4);
                member = db.getVarchar(1, 1, 5);
                picname = db.getVarchar(1, 1, 6);
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

    //通过血统证书号 取出信息
    public Csvdogpic(String bloodlineletterid) throws SQLException
    {
        this.bloodlineletterid = bloodlineletterid;
        loadblood();
    }

    public static Csvdogpic find(String bloodlineletterid) throws SQLException
    {
        return new Csvdogpic(bloodlineletterid);
    }

    public void loadblood() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select bloodlineletterid,small_pic,big_pic,times,member,picname,id from Csvdogpic where bloodlineletterid =" + DbAdapter.cite(bloodlineletterid));
            if (db.next())
            {
                bloodlineletterid = db.getString(1);
                small_pic = db.getVarchar(1, 1, 2);
                big_pic = db.getVarchar(1, 1, 3);
                times = db.getDate(4);
                member = db.getVarchar(1, 1, 5);
                picname = db.getVarchar(1, 1, 6);
                id = db.getInt(7);
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

    public static void create(String bloodlineletterid, String small_pic, String big_pic, String member, String picname, String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("insert into Csvdogpic (bloodlineletterid,small_pic,big_pic,times,member,picname,community) values (" + DbAdapter.cite(bloodlineletterid) + "," + DbAdapter.cite(small_pic) + "," + DbAdapter.cite(big_pic) + "," + DbAdapter.cite(times) + "," + DbAdapter.cite(member) + " ," + DbAdapter.cite(picname) + "," + DbAdapter.cite(community) + ")");
        } finally
        {
            db.close();
        }
    }

    public void set(String bloodlineletterid, String small_pic, String big_pic, String picname) throws SQLException
    {
        Date times = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Csvdogpic set  bloodlineletterid=" + DbAdapter.cite(bloodlineletterid) + ",small_pic=" + DbAdapter.cite(small_pic) + ",big_pic=" + DbAdapter.cite(big_pic) + ",picname=" + DbAdapter.cite(picname) + ",times=" + DbAdapter.cite(times) + " where id=" + id);
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
            db.executeUpdate("delete from Csvdogpic where id=" + id);
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
            dbadapter.executeQuery("SELECT  id FROM Csvdogpic WHERE community=" + DbAdapter.cite(community) + sql);

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


    public static int count(String community, String sql) throws SQLException
    {
        int count = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT COUNT(cs.id) FROM Csvdogpic cs WHERE cs.community=" + dbadapter.cite(community) + sql);
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

    //只能添加一个犬的照片
    public static boolean isExisted(String bloodlineletterid, String community, String member) throws SQLException
    {
        boolean flag = false;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT id FROM Csvdogpic WHERE member =" + dbadapter.cite(member) + " and community=" + dbadapter.cite(community) + "  and bloodlineletterid=" + DbAdapter.cite(bloodlineletterid));
            flag = dbadapter.next();
        } finally
        {
            dbadapter.close();
        }
        return flag;
    }


    public String getBig_pic()
    {
        return big_pic;
    }

    public String getBloodlineletterid()
    {
        return bloodlineletterid;
    }

    public String getMember()
    {
        return member;
    }

    public String getPicname()
    {
        return picname;
    }

    public String getSmall_pic()
    {
        return small_pic;
    }

    public Date getTimes()
    {
        return times;
    }


}
