package tea.entity.csvclub;

import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class Csvdogzxprove extends Entity
{
    private int id;
    private int mendwhys; //补做原因
    private String proveNum; //配犬证明号
    private String other; //其他
    private String member; //用户名
    private String community; //社区
    private int itj; //标识注销，0 是表示 没有确定注销，1是 表示已经确定注销
    private Date logoutdate;////确认注销的时间
    private Date applydate;
    public static final String ITJS[] =
                                        {"等待注销", "已确认注销"};
    public static final String MEND[] =
                                        {"-------", "丢失", "损坏", "其他原因"};

    public Csvdogzxprove(String proveNum) throws SQLException
    {
        this.proveNum = proveNum;
        Load();
    }

    public static Csvdogzxprove find(String proveNum) throws SQLException
    {
        return new Csvdogzxprove(proveNum);
    }

    public Csvdogzxprove(int id) throws SQLException
    {
        this.id = id;
        Loadid();
    }

    public static Csvdogzxprove find(int id) throws SQLException
    {
        return new Csvdogzxprove(id);
    }

    public void Loadid() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select id , mendwhys, proveNum,other,member,community,itj,logoutdate,applydate from Csvdogzxprove where id =" + id);
            if (dbadapter.next())
            {
                id = dbadapter.getInt(1);
                mendwhys = dbadapter.getInt(2);
                proveNum = dbadapter.getString(3);
                other = dbadapter.getString(4);
                member = dbadapter.getString(5);
                community = dbadapter.getString(6);
                itj = dbadapter.getInt(7);
                logoutdate = dbadapter.getDate(8);
                applydate = dbadapter.getDate(9);
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

//读取  Csvdogzxprove 表中的全部值
    public void Load() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select id , mendwhys, proveNum,other,member,community,itj,logoutdate,applydate from csvdogzxprove where proveNum=" + dbadapter.cite(proveNum));
            if (dbadapter.next())
            {
                id = dbadapter.getInt(1);
                mendwhys = dbadapter.getInt(2);
                proveNum = dbadapter.getString(3);
                other = dbadapter.getString(4);
                member = dbadapter.getString(5);
                community = dbadapter.getString(6);
                itj = dbadapter.getInt(7);
                logoutdate = dbadapter.getDate(8);
                applydate = dbadapter.getDate(9);
            }

        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

///插入Csvdogzxprove表的申请记录
    public static void create(int mendwhys, String proveNum, String other, String member, String community, Date applydate) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        int itj = 0; //标识，0标识没有交费，1标识已经缴费
        try
        {
            dbadapter.executeUpdate("insert into Csvdogzxprove (mendwhys, proveNum,other,member,community,itj,applydate) values (" + mendwhys + ", " + dbadapter.cite(proveNum) + ", " + dbadapter.cite(other) + ", " + dbadapter.cite(member) + ", " + dbadapter.cite(community) + ", " + itj + ", " + dbadapter.cite(applydate) + ")");
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    //修改数据

    public static void set(int id, int mendwhys, String proveNum, String other, String member, Date applydate) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("update Csvdogzxprove set mendwhys=" + mendwhys + ", proveNum=" + dbadapter.cite(proveNum) + ",other=" + dbadapter.cite(other) + ",member=" + dbadapter.cite(member) + ",applydate=" + dbadapter.cite(applydate) + " where id = " + id);
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    //枚举
    public static java.util.Enumeration findByCommunity(String community, String sql, int pos, int size) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT id FROM Csvdogzxprove WHERE community=" + DbAdapter.cite(community) + sql);
            for (int l = 0; l < pos + size && dbadapter.next(); l++)
            {
                if (l >= pos)
                {
                    vector.addElement(new Integer(dbadapter.getInt(1)));
                }
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    //返回总数量
    public static int count(String community, String sql) throws SQLException
    {
        int i = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select count(id) from Csvdogzxprove where community =" + dbadapter.cite(community) + sql);
            if (dbadapter.next())
            {
                i = dbadapter.getInt(1);
            }
            return i;

        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

//判断数据是否存在
    public static boolean Option(int id) throws SQLException
    {
        boolean falg = false;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select proveNum from Csvdogzxprove where id =" + id);
            if (dbadapter.next())
            {
                return falg = true;
            } else
            {
                return falg = false;
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

//修改方法。确定注销配犬证明
    public static void getEnter(int id, String proveNum) throws SQLException
    {
        Date date = new Date();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("update Csvdogzxprove set logoutdate="+dbadapter.cite(date)+",itj =1 where id =" + id);
            dbadapter.executeUpdate("update Csvdogprove set itzx =1 ,itzxid = " + id + " where proveNum = " + dbadapter.cite(proveNum));
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    //判断配犬证明是否符合
    public static boolean Optionprove(String proveNum, String member) throws SQLException
    {

        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select * from Csvdogprove where proveNum = " + dbadapter.cite(proveNum) + " and vipid = " + dbadapter.cite(member));
            if (dbadapter.next())
            {
                return true;
            } else
            {
                return false;
            }

        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    public Date getApplydate()
    {
        return applydate;
    }

    public String getCommunity()
    {
        return community;
    }

    public int getId()
    {
        return id;
    }

    public int getItj()
    {
        return itj;
    }

    public Date getLogoutdate()
    {
        return logoutdate;
    }

    public String getMember()
    {
        return member;
    }

    public int getMendwhys()
    {
        return mendwhys;
    }

    public String getOther()
    {
        return other;
    }

    public String getProveNum()
    {
        return proveNum;
    }

}
