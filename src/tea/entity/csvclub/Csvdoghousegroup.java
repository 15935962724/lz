package tea.entity.csvclub;

import java.math.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;
import java.util.*;

public class Csvdoghousegroup extends Entity
{
    private String earid;
    private String member;
    private int coid;
    private String community;
    private int type;

    private static Cache _cache = new Cache(100);
    private boolean exists;

    public Csvdoghousegroup(String earid) throws SQLException
    {
        this.earid = earid;
        load();
    }

    public static Csvdoghousegroup find_earid(String earid) throws SQLException
    {
        return new Csvdoghousegroup(earid);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select earid,member,coid,type from Csvdoghousegroup where earid =" + DbAdapter.cite(earid));
            if (db.next())
            {
                earid = db.getString(1);
                member = db.getVarchar(1, 1, 2);
                coid = db.getInt(3);
                type = db.getInt(4);
                exists = true;
            } else
            {
                earid = null;
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    //通过用户名查找犬只
    public Csvdoghousegroup(String member, String str) throws SQLException
    {
        this.member = member;
        load_member();
    }

    public static Csvdoghousegroup find_member(String member) throws SQLException
    {
        return new Csvdoghousegroup(member, "");
    }

    public void load_member() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select earid,member,coid,type from Csvdoghousegroup where member =" + DbAdapter.cite(member));
            if (db.next())
            {
                earid = db.getString(1);
                member = db.getVarchar(1, 1, 2);
                coid = db.getInt(3);
                type = db.getInt(4);
                exists = true;
            } else
            {
                earid = null;
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(String earid, String member, int coid, int type, String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("insert into Csvdoghousegroup (earid,member,coid,type,community) values (" + DbAdapter.cite(earid) + "," + DbAdapter.cite(member) + "," + coid + "," + type + "," + DbAdapter.cite(community) + ")");
        } finally
        {
            db.close();
        }
    }

    //判断父犬是否存在
    public static boolean isExisted(String community, String sql) throws SQLException
    {
        boolean flag = false;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT earid FROM Csvdoghousegroup WHERE community = " + dbadapter.cite(community) + sql);

            flag = dbadapter.next();
        } finally
        {
            dbadapter.close();
        }
        return flag;
    }

    public static java.util.Enumeration findByCommunity(String community, String sql, int pos, int pageSize) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT earid FROM Csvdoghousegroup WHERE community=" + DbAdapter.cite(community) + sql);
            for (int l = 0; l < pos + pageSize && dbadapter.next(); l++)
            {
                if (l >= pos)
                {
                    String earid = dbadapter.getString(1);
                    vector.addElement(String.valueOf(earid));
                }
            }

        } catch (SQLException ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    public static java.util.Enumeration findBy(String community, String sql, int pos, int pageSize) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT  distinct(member) FROM Csvdoghousegroup WHERE community=" + DbAdapter.cite(community) + sql);

            for (int l = 0; dbadapter.next(); l++)
            {
                if (l >= pos)
                {
                    String member = dbadapter.getVarchar(1, 1, 1);
                    vector.addElement(String.valueOf(member));
                }
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    //通过耳号统计
    public static int count(String community, String sql) throws SQLException
    {
        int count = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT COUNT(earid) FROM Csvdoghousegroup  WHERE community=" + dbadapter.cite(community) + sql);
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

    //通过用户名统计
    public static int count_member(String community, String sql) throws SQLException
    {
        int count = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT COUNT(distinct(member)) FROM Csvdoghousegroup  WHERE community=" + dbadapter.cite(community) + sql);
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

    //统计type字段
    public static int count_type(String community, String sql) throws SQLException
    {
        int count = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT distinct(type)  FROM Csvdoghousegroup  WHERE community=" + dbadapter.cite(community) + sql);

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

    //通过用户名删除
    public static void detele_member(String member, int coid) throws SQLException //
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from Csvdoghousegroup where member=" + DbAdapter.cite(member) + " and coid=" + coid);

        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    public void set(int type) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Csvdoghousegroup set type=" + type + " where coid=" + coid + " and member=" + DbAdapter.cite(member));

        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }

    }

    public int getCoid()
    {
        return coid;
    }

    public String getEarid()
    {
        return earid;
    }

    public String getMember()
    {
        return member;
    }

    public int getType()
    {
        return type;
    }


}

