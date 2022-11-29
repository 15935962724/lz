package tea.entity.csvclub;

import java.math.*;
import java.sql.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class Finance extends Entity
{

    private int id;
    private String member;
    private Date times;///财务确认日期
    private Date time_z;///转账日期
    private BigDecimal exes;//金额
    private int type;
    private int linetype;
    private int province;
    private String card;
    private String firstname;
    private int radioid; //会员类型的iD
    private int puttype;
    private String putmember;
    private Date puttime;
    private int defray;///支付的类型
    private static Cache _cache = new Cache(100);
    private boolean exists;

    public Finance(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public Finance(String member) throws SQLException
    {
        this.member = member;
        load_member();
    }

    public static Finance find(int id) throws SQLException
    {
        return new Finance(id);
    }


    public static Finance find(String member) throws SQLException
    {

        return new Finance(member);
    }

    public void load_member() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select member,exes,times,time_z,type,linetype,province,card,firstname,radioid,puttype,putmember,puttime,id,defray from Finance where member=" + db.cite(member));
            if (db.next())
            {
                member = db.getVarchar(1, 1, 1);
                exes = db.getBigDecimal(2, 2);
                times = db.getDate(3);
                time_z = db.getDate(4);
                type = db.getInt(5);
                linetype = db.getInt(6);
                province = db.getInt(7);
                card = db.getString(8);
                firstname = db.getVarchar(1, 1, 9);
                radioid = db.getInt(10);
                puttype = db.getInt(11);
                putmember = db.getVarchar(1, 1, 12);
                puttime = db.getDate(13);
                id = db.getInt(14);
                defray = db.getInt(15);

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

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select member,exes,times,time_z,type,linetype,province,card,firstname,radioid,puttype,putmember,puttime,id,defray from Finance where id=" + id);
            if (db.next())
            {
                member = db.getVarchar(1, 1, 1);
                exes = db.getBigDecimal(2, 2);
                times = db.getDate(3);
                time_z = db.getDate(4);
                type = db.getInt(5);
                linetype = db.getInt(6);
                province = db.getInt(7);
                card = db.getString(8);
                firstname = db.getVarchar(1, 1, 9);
                radioid = db.getInt(10);
                puttype = db.getInt(11);
                putmember = db.getVarchar(1, 1, 12);
                puttime = db.getDate(13);
                id = db.getInt(14);
                defray = db.getInt(15);
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

    public static void create(String member, BigDecimal exes, Date time_z, String community, int type, int linetype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("insert into Finance (member,exes,time_z,community,times,type,linetype) values (" + DbAdapter.cite(member) + "," + exes + "," + DbAdapter.cite(time_z) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(times) + " ," + type + "," + linetype + ")");
        } finally
        {
            db.close();
        }
    }
    ////
    public static void create_new(String member, BigDecimal exes, Date time_z, String community, int type, int linetype,int defray) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("insert into Finance (member,exes,time_z,community,times,type,linetype,defray) values (" + DbAdapter.cite(member) + "," + exes + "," + DbAdapter.cite(time_z) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(times) + " ," + type + "," + linetype + ","+defray+")");
        } finally
        {
            db.close();
        }
    }




    public static void create(String member, BigDecimal exes, Date time_z, String community, int type, int linetype, int province, String card, String firstname, int radioid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("insert into Finance (member,exes,time_z,community,times,type,linetype, province, card,firstname,radioid) values (" + DbAdapter.cite(member) + "," + exes + "," + DbAdapter.cite(time_z) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(times) + " ," + type + "," + linetype + "," + province + "," + DbAdapter.cite(card) + "," + DbAdapter.cite(firstname) + "," + radioid + ")");

        } finally
        {
            db.close();
        }
    }

    public void set(String member, BigDecimal exes, Date time_z) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Finance set  member=" + DbAdapter.cite(member) + ",exes=" + exes + ",time_z=" + DbAdapter.cite(time_z) + " where id=" + id);
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    public void set(String member, BigDecimal exes, Date time_z, int type, int linetype, int province, String card, String firstname, int radioid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Finance set  member=" + DbAdapter.cite(member) + ",exes=" + exes + ",time_z=" + DbAdapter.cite(time_z) + ",type=" + type + ",linetype=" + linetype + ",province=" + province + ",card=" + DbAdapter.cite(card) + ",firstname=" + DbAdapter.cite(firstname) + ",radioid=" + radioid + " where id=" + id);

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
            db.executeUpdate("delete from Finance where id=" + id);
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

// fenye de fanhui meiju leixing de ... ...
    public static java.util.Enumeration findByCommunity(String community, String sql, int pos, int pageSize) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT  id FROM Finance WHERE community=" + DbAdapter.cite(community) + sql);

            for (int l = 0; l < pos + pageSize && dbadapter.next(); l++)
            {
                if (l >= pos)
                {
                    int id = dbadapter.getInt(1);
                    vector.addElement(new Integer(id));
                }
            }

//            for (int l = 0; l < pos + size && db.next(); l++)
//            {
//                if (l >= pos)
//                {
//                    v.addElement(db.getString(1));
//                }
//            }

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
            dbadapter.executeQuery("SELECT COUNT(cs.id) FROM Finance cs WHERE cs.community=" + dbadapter.cite(community) + sql);
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

    public void set(int ty) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Finance set type=" + ty + " where id=" + id);
        } catch (Exception e)
        {
            throw new SQLException(e.toString());
        } finally
        {
            db.close();
        }
    }


    public static boolean isExisted(String member) throws SQLException
    {
        boolean flag = false;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT member FROM Finance WHERE member=" + DbAdapter.cite(member) + " and type=1");

            flag = dbadapter.next();
        } finally
        {
            dbadapter.close();
        }
        return flag;
    }

    public static boolean isExisted(String member, String sql) throws SQLException
    {
        boolean flag = false;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT member FROM Finance WHERE member=" + DbAdapter.cite(member) + sql);

            flag = dbadapter.next();
        } finally
        {
            dbadapter.close();
        }
        return flag;
    }

//对会员的是否打印的修改
    public void setput(int puttype, String putmember) throws SQLException
    {
        Date puttime = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Finance set puttype=" + puttype + ",putmember=" + DbAdapter.cite(putmember) + ",puttime=" + DbAdapter.cite(puttime) + " where id=" + id);
        } catch (Exception e)
        {
            throw new SQLException(e.toString());
        } finally
        {
            db.close();
        }
    }

//根据用户名和转账时间 取得这次交易的相关信息


    public static int getID_time(String member, Date time_z) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select id from Finance where member =" + db.cite(member) + "  and  time_z=" + db.cite(time_z));
            if (db.next())
            {
                return db.getInt(1);
            } else
            {
                return 0;
            }
        } finally
        {
            db.close();
        }
    }

    public static int getFinancemoneny(String community,String sql,String membertype)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select sum(exes) from Finance ,profilecsv where Finance.community="+db.cite(community)+" "+sql+"  and  Finance.member=profilecsv.member and  membernumber like "+db.cite("%"+membertype+"%"));
//            System.out.print("select sum(exes) from Finance ,profilecsv where Finance.community="+db.cite(community)+" "+sql+"  and  Finance.member=profilecsv.member and  membernumber like "+db.cite("%"+membertype+"%"));

            if (db.next())
            {
                return db.getInt(1);
            } else
            {
                return 0;
            }
        } finally
        {
            db.close();
        }
    }

    public String getMember()
    {
        return member;
    }

    public BigDecimal getExes()
    {
        return exes;
    }

    public Date getTime_z()
    {
        return time_z;
    }

    public Date getTimes()
    {
        return times;
    }

    public int getType()
    {
        return type;
    }

    public String getTime_ztoString()
    {
        if (time_z == null)
            return "";
        return sdf.format(time_z);
    }

    public int getLinetype()
    {
        return linetype;
    }

    public int getProvince()
    {
        return province;
    }

    public String getCard()
    {
        return card;
    }

    public String getFirstname()
    {
        return firstname;
    }

    public int getRadioid()
    {
        return radioid;
    }

    public int getPuttype()
    {
        return puttype;
    }

    public String getPutmember()
    {

        return putmember;
    }

    public Date getPuttime()
    {
        return puttime;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getDefray()
    {
        return defray;
    }
}
