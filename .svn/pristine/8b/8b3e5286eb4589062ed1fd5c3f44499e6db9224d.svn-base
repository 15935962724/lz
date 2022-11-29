package tea.entity.csvclub;

import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class Csvdogzx extends Entity
{
    private int id;
    private String earid; //耳号
    private String oldblood; //血统号
    private int mendwhys; //补做原因
    private String other; //其他
    private int state; //状态
    private String mailnum; //邮寄编号
    private String member; //用户名
    private String community; //社区
    private String newblood; //新血统证书号
    private int itj; //标识注销，0 是表示 没有确定注销，1是 表示已经确定注销
    private Date birthdate;
    private String cname;
    private Date applydate;
    public static final String ITJS[] =
            {"等待注销", "已确认注销", "取消注销"};
    public static final String MEND[] =
            {"-------", "犬只遗失", "犬只死亡", "其他原因"};
    public static final String STATE[] =
            {"-------", "未接受", "确认", "完成", "不办理"};
    //未接受/已交费
    public static final String STATES[] =
            {"等待交费", "已交费"};

    public Csvdogzx(String earid) throws SQLException
    {
        this.earid = earid;
        Load();
    }

    public static Csvdogzx find(String earid) throws SQLException
    {
        return new Csvdogzx(earid);
    }

    public Csvdogzx(int id) throws SQLException
    {
        this.id = id;
        Loadid();
    }

    public static Csvdogzx find(int id) throws SQLException
    {
        return new Csvdogzx(id);
    }

    public void Loadid() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select id,earid,oldblood,mendwhys,other,member,state,mailnum,community,newblood,itj,birthdate,cname,applydate from Csvdogzx where id =" + id);
            if (dbadapter.next())
            {
                id = dbadapter.getInt(1);
                earid = dbadapter.getString(2);
                oldblood = dbadapter.getString(3);
                mendwhys = dbadapter.getInt(4);
                other = dbadapter.getString(5);
                member = dbadapter.getString(6);
                state = dbadapter.getInt(7);
                mailnum = dbadapter.getString(8);
                community = dbadapter.getString(9);
                newblood = dbadapter.getString(10);
                itj = dbadapter.getInt(11);
                birthdate = dbadapter.getDate(12);
                cname = dbadapter.getString(13);
                applydate = dbadapter.getDate(14);
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    //读取Csvdogzx 表中的全部值
    public void Load() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select id,earid,oldblood,mendwhys,other,member,state,mailnum,community,newblood,itj,birthdate,cname,applydate from Csvdogzx where earid =" + dbadapter.cite(earid));
            if (dbadapter.next())
            {
                id = dbadapter.getInt(1);
                earid = dbadapter.getString(2);
                oldblood = dbadapter.getString(3);
                mendwhys = dbadapter.getInt(4);
                other = dbadapter.getString(5);
                member = dbadapter.getString(6);
                state = dbadapter.getInt(7);
                mailnum = dbadapter.getString(8);
                community = dbadapter.getString(9);
                newblood = dbadapter.getString(10);
                itj = dbadapter.getInt(11);
                birthdate = dbadapter.getDate(12);
                cname = dbadapter.getString(13);
                applydate = dbadapter.getDate(14);

            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    ///插入Csvdogzx表的申请记录
    public static void create(String earid, String oldblood, int mendwhys, String other, String member, int state, String mailnum, String community, Date birthdate, String cname, Date applydate) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        int itj = 0; //标识，0标识没有交费，1标识已经缴费
        try
        {
            dbadapter.executeUpdate("insert into Csvdogzx(earid,oldblood,mendwhys,other,member,state,mailnum,community,itj,birthdate,cname,applydate) values (" + dbadapter.cite(earid) + "," + dbadapter.cite(oldblood) + "," + mendwhys + "," + dbadapter.cite(other) + "," + dbadapter.cite(member) + "," + state + "," + dbadapter.cite(mailnum) + "," + dbadapter.cite(community) + "," + itj + "," + dbadapter.cite(birthdate) + "," + dbadapter.cite(cname) + "," + dbadapter.cite(applydate) + ") ");
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    //修改数据
    public static void set(String earid, String oldblood, int mendwhys, String other, String member, int state, String mailnum, Date birthdate, String cname, Date applydate, int id) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("update Csvdogzx set earid =" + dbadapter.cite(earid) + ",oldblood=" + dbadapter.cite(oldblood) + ",mendwhys=" + mendwhys + ",other=" + dbadapter.cite(other) + ",member=" + dbadapter.cite(member) + ",state=" + state + ",mailnum=" + dbadapter.cite(mailnum) + ", birthdate=" + dbadapter.cite(birthdate) + ", cname=" + dbadapter.cite(cname) + ", applydate=" + dbadapter.cite(applydate) + "  where id =" + id);
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
            dbadapter.executeQuery("SELECT id FROM Csvdogzx WHERE community=" + DbAdapter.cite(community) + sql);
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
            dbadapter.executeQuery("select count(id) from Csvdogzx where community =" + dbadapter.cite(community) + sql);
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

    //根据旧证书生成新证书
    public static String getOldblood(String earid) throws SQLException
    {
        String newblood = null;
        Csvdog dog = Csvdog.find(earid);
        dog.getItforeign();
        dog.getProve();
        int aa = 0;

        Csvdogprove dogprove = Csvdogprove.find(dog.getProve(), aa);
        dogprove.getBloodtype();

        newblood = dog.getMarkblood(dogprove.getBloodtype(), dog.getItforeign(), 1);
        return newblood;
    }

    //通过输入的新证书，替换原来旧证书  用于修改csvdog表中的数据 、、修改时间2007-8-21
    public static void getMarknewblood(String newblood, String oldblood) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("update csvdog set bloodlineletterid = " + dbadapter.cite(newblood) + " , old_bloodlineletterid = " + dbadapter.cite(oldblood) + " where bloodlineletterid = " + dbadapter.cite(oldblood));
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    //修改确认交费的方法
    public static void getItjprice(int id, String oldblood) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("update Csvdogzx set itj =1 where id =" + id);
            dbadapter.executeQuery("select newblood from  Csvdogzx where id = " + id);
            if (dbadapter.next())
            {
                String blood = dbadapter.getString(1);
                Csvdogzx.getMarknewblood(blood, oldblood);
            }

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
            dbadapter.executeQuery("select earid from Csvdogzx where id =" + id);
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

    //修改方法。确定注销犬只
    public static void getEnter(int id) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("update Csvdogzx set itj =1 where id =" + id);
            Csvdogzx dogzx = Csvdogzx.find(id);
            Csvdog dogobj = Csvdog.find(dogzx.getEarid());
            dbadapter.executeUpdate("update Csvdog set dogstatic ="+dogzx.getMendwhys()+" where Bloodlineletterid =" + dbadapter.cite(dogobj.getBloodlineletterid()));
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    /////////恢复
    public static void getEnterhuifu(int id) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("update Csvdogzx set itj=2 where id =" + id);
            Csvdogzx dogzx = Csvdogzx.find(id);
            Csvdog dogobj = Csvdog.find(dogzx.getEarid());
            dbadapter.executeUpdate("update Csvdog set dogstatic =0  where Bloodlineletterid =" + dbadapter.cite(dogobj.getBloodlineletterid()));

        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    public int getItj()
    {
        return itj;
    }


    public String getNewblood()
    {
        return newblood;
    }


    public String getEarid()
    {
        return earid;
    }

    public int getId()
    {
        return id;
    }

    public String getMailnum()
    {
        return mailnum;
    }

    public int getMendwhys()
    {
        return mendwhys;
    }

    public String getOldblood()
    {
        return oldblood;
    }

    public String getOther()
    {
        return other;
    }

    public int getState()
    {
        return state;
    }

    public String getMember()
    {
        return member;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getCname()
    {
        return cname;
    }

    public Date getBrithdate()
    {
        return birthdate;
    }

    public Date getApplydate()
    {
        return applydate;
    }
}
