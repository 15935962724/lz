package tea.entity.csvclub;

import java.sql.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class Csvdogfzbu extends Entity
{
    private int id;
    private String earid; //耳号
    private String breedid; //繁殖证书编号(血统证书号)
    private Date breedtime; //提交补做时间,注册时间
    private String member; //
    private String community; //社区
    private int itfz; //标示  0 表示没有交费，1等待交费,2已交费
    private int state; //状态
    private int mendwhys; //补做原因
    private String other; //其他
    private String mailnum; //邮寄编号
    private String newbreedid; //生成的新繁殖证书号
    private Date datezz; //邮寄时间
    private Date datecnt; //财务确认时间




    public static final String MEND[] =
        {"-------", "遗失", "损坏", "其他原因"};
    public static final String ITFZ[] =
        {"未接受", "等待交费", "已交费"};
    public static final String STATE[] =
        {"-------", "未接受", "不办理", "完成"};
    public static Csvdogfzbu find(String earid) throws SQLException
    {
        return new Csvdogfzbu(earid);
    }

    public Csvdogfzbu(String earid) throws SQLException
    {
        this.earid = earid;
        Load();
    }

    public static Csvdogfzbu find(int id) throws SQLException
    {
        return new Csvdogfzbu(id);
    }

    public Csvdogfzbu(int id) throws SQLException
    {
        this.id = id;
        Loadid();
    }

    public Csvdogfzbu()
    {

    }

    public void Load() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select id ,earid,member ,breedid,breedtime,itfz,community,state,mendwhys,other,mailnum,newbreedid,datezz,datecnt from Csvdogfzbu where earid= " + dbadapter.cite(earid));
            if (dbadapter.next())
            {
                id = dbadapter.getInt(1);
                earid = dbadapter.getString(2); //耳号
                member = dbadapter.getString(3); //
                breedid = dbadapter.getString(4); //繁殖证书编号
                breedtime = dbadapter.getDate(5); //提交补做时间
                community = dbadapter.getString(7); //社区
                itfz = dbadapter.getInt(6); //标示  0 表示没有交费，1标示交费了
                state = dbadapter.getInt(8);
                mendwhys = dbadapter.getInt(9);
                other = dbadapter.getString(10);
                mailnum = dbadapter.getString(11);
                newbreedid = dbadapter.getString(12);
                datezz = dbadapter.getDate(13);//,datezz,datecnt
                datecnt  = dbadapter.getDate(14);

            }

        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    public void Loadid() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select id ,earid,member ,breedid,breedtime,itfz,community,state,mendwhys,other,mailnum,newbreedid,datezz,datecnt   from Csvdogfzbu where id =" + id);
            if (dbadapter.next())
            {
                id = dbadapter.getInt(1);
                earid = dbadapter.getString(2); //耳号
                member = dbadapter.getString(3); //
                breedid = dbadapter.getString(4); //繁殖证书编号
                breedtime = dbadapter.getDate(5); //提交补做时间
                community = dbadapter.getString(7); //社区
                itfz = dbadapter.getInt(6); //标示  0 表示没有交费，1标示交费了
                state = dbadapter.getInt(8);
                mendwhys = dbadapter.getInt(9);
                other = dbadapter.getString(10);
                mailnum = dbadapter.getString(11);
                newbreedid = dbadapter.getString(12);
                datezz = dbadapter.getDate(13);//,datezz,datecnt
                datecnt  = dbadapter.getDate(14);
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    public static void create(String earid, String member, String breedid, Date breedtime, int itfz, String community, int state, int mendwhys, String other, String mailnum) throws SQLException
    {
        itfz = 1;
        Date dates = new Date();
        breedtime = dates;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("insert into Csvdogfzbu(earid,member ,breedid,breedtime,itfz,community,state,mendwhys,other,mailnum)values (" + dbadapter.cite(earid) + "," + dbadapter.cite(member) + "," +
                                    dbadapter.cite(breedid) + "," + dbadapter.cite(breedtime) + "," + itfz + "," + dbadapter.cite(community) + "," + state + "," + mendwhys + "," + other + "," + mailnum + ")");
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    public static void set(int id, String earid, String member, String breedid, Date breedtime, int itfz, int state, int mendwhys, String other, String mailnum) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("update Csvdogfzbu set earid = " + dbadapter.cite(earid) + " ,member= " + dbadapter.cite(member) + " ,breedid= " + dbadapter.cite(breedid) + ",breedtime= " +
                                    dbadapter.cite(breedtime) + ",itfz= " + itfz + ",state= " + state + ",mendwhys=" + mendwhys + ",other=" + dbadapter.cite(other) + ",mailnum =" + dbadapter.cite(mailnum) + " where id = " + id);
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
            dbadapter.executeQuery("SELECT id FROM Csvdogfzbu WHERE community=" + DbAdapter.cite(community) + sql);
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
            dbadapter.executeQuery("select count(id) from Csvdogfzbu where community =" + dbadapter.cite(community) + sql);
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

    //根据耳号和idss号 来更改   确认---财务确认
    public static void updateEnter(int id, String earid, String breedids) throws SQLException
    {
        int max = 0; //最大值,生成的繁育证书号
        Date dates = new Date();

        DbAdapter dbadapter = new DbAdapter();
        try
        {

            dbadapter.executeQuery("select count(breedexamid) from csvdogcheck");
            if (dbadapter.next())
            {
                max = dbadapter.getInt(1) + 1;
                dbadapter.executeUpdate("update Csvdogfzbu set datecnt="+dbadapter.cite(dates)+",itfz=2,state=3,newbreedid=" + max + " where id =" + id);
            }
            //dbadapter.executeUpdate("update csvdogcheck set breedexamid = " + max + "   where  earid = earid and breedexamid = " + dbadapter.cite(breedids));
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    /**
     * 2007年8月31日//判断输入是否正确
     * */
    public static boolean getOption(String earid, String breedid, String member) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
         DbAdapter dbadapter2 = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select earid from Csvdog where earid =" + dbadapter.cite(earid) + "  and member =" + dbadapter.cite(member));
            if (dbadapter.next())
            {
                dbadapter2.executeQuery("select earid  from Csvdogcheck where earid = " + dbadapter.cite(earid) + " and boolid = " + dbadapter.cite(breedid));
                if (dbadapter2.next())
                {
                    return true;
                } else
                {
                    return false;
                }
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
            dbadapter2.close();
        }

    }

    //判断是否存在
    public static boolean getcsvfz(int id) throws SQLException
    {

        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select  earid from Csvdogfzbu where id =" + id);
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

    public int getState()
    {
        return state;
    }

    public String getBreedid()
    {
        return breedid;
    }

    public Date getBreedtime()
    {
        return breedtime;
    }

    public String getEarid()
    {
        return earid;
    }

    public int getId()
    {
        return id;
    }

    public String getMember()
    {
        return member;
    }

    public int getItfz()
    {
        return itfz;
    }

    public String getCommunity()
    {
        return community;
    }

    public int getMendwhys()
    {
        return mendwhys;
    }

    public String getMailnum()
    {
        return mailnum;
    }

    public String getOther()
    {
        return other;
    }

    public String getNewbreedid()
    {
        return newbreedid;
    }

    public Date getDatezz()
    {
        return datezz;
    }

    public String getDatezzToString()
    {
        if(datezz==null)
        {
            return "";
        }
        return Csvdogfzbu.sdf.format(datezz);
    }

    public Date getDatecnt()
    {
        return datecnt;
    }


}
