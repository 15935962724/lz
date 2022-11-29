package tea.entity.csvclub;

import java.math.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;
import java.util.*;

public class Csvdogfamily extends Entity
{
    private int id;
    private String f_blood; //父犬的血统证书号
    private String earid; //犬的耳号
    private String member;
    private String community;
    private int type;
    private Date times;
    private int coid;

    private String f_bloodearid; //父耳号
    private int typef; //参加标示

    private static Cache _cache = new Cache(100);
    private boolean exists;

    public Csvdogfamily(int id) throws SQLException
    {
        this.id = id;
        load();

    }

    public static Csvdogfamily find(int id) throws SQLException
    {
        return new Csvdogfamily(id);
    }

    public Csvdogfamily(String f_bloodearid) throws SQLException
    {
        this.f_bloodearid = f_bloodearid;
        load_family();
    }

    public static Csvdogfamily find_family(String f_bloodearid) throws SQLException
    {
        return new Csvdogfamily(f_bloodearid);
    }

    public Csvdogfamily(String earid, String str) throws SQLException
    {
        this.earid = earid;
        load_earid();
    }

    public static Csvdogfamily find_earid(String earid) throws SQLException
    {
        return new Csvdogfamily(earid, "");
    }

    //
    public void load_earid() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select f_blood,earid,member,type,times,coid from Csvdogfamily where earid = " + DbAdapter.cite(earid));
            if (db.next())
            {
                f_blood = db.getString(1);
                earid = db.getString(2);
                member = db.getVarchar(1, 1, 3);
                type = db.getInt(4);
                times = db.getDate(5);
                coid = db.getInt(6);
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

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select f_blood,earid,member,type,times,coid from Csvdogfamily where id = " + id);
            if (db.next())
            {
                f_blood = db.getString(1);
                earid = db.getString(2);
                member = db.getVarchar(1, 1, 3);
                type = db.getInt(4);
                times = db.getDate(5);
                coid = db.getInt(6);
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

    //标示参加的表 ////////------------------------------------------------------------------
    public void load_family() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select f_bloodearid,type from Csvfamily_type where f_bloodearid =" + DbAdapter.cite(f_bloodearid));
            if (db.next())
            {
                f_bloodearid = db.getString(1);
                typef = db.getInt(2);
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


    public static void create(String f_bloodearid, String community, int type) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("insert into Csvfamily_type (f_bloodearid,community,type) values (" + DbAdapter.cite(f_bloodearid) + "," + DbAdapter.cite(community) + "," + type + ")");
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
            db.executeUpdate("update Csvfamily_type set type=" + type + " where f_bloodearid=" + DbAdapter.cite(f_bloodearid));
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
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
            dbadapter.executeQuery("SELECT id FROM Csvfamily_type WHERE community = " + dbadapter.cite(community) + sql);

            flag = dbadapter.next();
        } finally
        {
            dbadapter.close();
        }
        return flag;
    }

    public static java.util.Enumeration findByCommunity(String community, String sql) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT f_bloodearid FROM Csvfamily_type WHERE community=" + DbAdapter.cite(community) + sql);

            while (dbadapter.next())
            {
                vector.addElement(String.valueOf(dbadapter.getString(1)));
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

/////////-------------------------//-----------------------//----------------------------------------------
    public static void create(String f_blood, String earid, String member, String community, int type, int coid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("insert into Csvdogfamily (f_blood,earid,member,community,type,times,coid) values (" + DbAdapter.cite(f_blood) + "," + DbAdapter.cite(earid) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + "," + type + "," + DbAdapter.cite(times) + "," + coid + ")");
        } finally
        {
            db.close();
        }
    }

    public void set(String f_blood, String earid, String member, int type, int coid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Csvdogfamily set  f_blood=" + DbAdapter.cite(f_blood) + ",earid=" + DbAdapter.cite(earid) + ",member=" + DbAdapter.cite(member) + ",type=" + type + "  ,coid=" + coid + " where id=" + id);
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }

    }

    public static void detele(String f_blood) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from Csvdogfamily where f_blood=" + DbAdapter.cite(f_blood));
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    public static void detele_member(String member, int coid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from Csvdogfamily where member=" + DbAdapter.cite(member) + " and coid=" + coid);
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
            dbadapter.executeQuery("SELECT id FROM Csvdogfamily WHERE community=" + DbAdapter.cite(community) + sql);
            for (int l = 0; l < pos + pageSize && dbadapter.next(); l++)
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

    //统计参加比赛的犬的数目
    public static int countint(String community, String f) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(id) FROM Csvdogfamily WHERE community=" + DbAdapter.cite(community) + " and f_blood=" + DbAdapter.cite(f));

            if (db.next())
            {
                j = db.getInt(1);
            }

        } catch (Exception e)
        {
            throw new SQLException(e.toString());
        } finally
        {
            db.close();
        }
        return j;
    }

    public static int count(String community, String sql) throws SQLException
    {
        int count = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT COUNT(id) FROM Csvdogfamily  WHERE community=" + dbadapter.cite(community) + sql);
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

    public String getEarid()
    {
        return earid;
    }


    public String getF_blood()
    {
        return f_blood;
    }

    public String getMember()
    {
        return member;
    }

    public Date getTimes()
    {
        return times;
    }

    public int getType()
    {
        return type;
    }

    public String getF_bloodearid()
    {
        return f_bloodearid;
    }

    public int getTypef()
    {
        return typef;
    }

    public int getCoid()
    {
        return coid;
    }


}
