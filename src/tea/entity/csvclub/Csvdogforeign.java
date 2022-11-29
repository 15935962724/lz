package tea.entity.csvclub;

import java.sql.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class Csvdogforeign extends Entity
{


    private int id; //
    private String Ename; //英文名称
    private Date applydate; //申请时间
    private Date birthdate; //出生日期
    private String earid; //耳号
    private String member; //会员id
    private int itm; //标识原件证书是否已邮寄
    private int itprice; //标识是否已经缴费
    private Date mailingdate; //邮寄时间
    private int sex; //性别
    private String foreignblood; //国外证书号
    private String foreigndetect; //国外检测
    private String pathz; //证书正面路径
    private String pathf; //证书背面路径
    private String name; //繁殖人
    private int states;
    private String mailnum; //邮寄编号
    private int itf; //确认交费
    private String bloodf; //父犬血统证书号
    private String bloodm; //母犬血统证书号
    private Date datecnt; //财务确认时间
    private String newblood;//生成的新的血统证书号
    /***
     * 2008年5月26日11:38:48 新加繁殖人，繁殖人地址 字段
     * *******/
    private String breedpeople;//繁殖人
    private String breedaddr;//繁殖人地址

    private boolean exists;



    public int getItf()
    {
        return itf;
    }

    public static final String ITFS[] =
        {"未接受", "等待交费", "已交费"};

    public static final String ITMS[] =
        {"是", "否"};

    public static final String FOREIGNDETECTS[] =
        {"A6", "ED6"};

    public static final String SEXS[] =
        {"公", "母"};

    public static final String STATE[] =
        {"-------", "未接受", "确认", "完成", "不办理"};

    public static Csvdogforeign find(String earid) throws SQLException
    {
        return new Csvdogforeign(earid);
    }

    public Csvdogforeign(String earid) throws SQLException
    {
        this.earid = earid;
        Load();
    }

    public static Csvdogforeign find(int id) throws SQLException
    {
        return new Csvdogforeign(id);
    }

    public Csvdogforeign(int id) throws SQLException
    {
        this.id = id;
        Loadid();
    }

    public void Loadid() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery(
                "select id,ename,applydate,birthdate,earid,member,itm,mailingdate,sex,foreignblood,foreigndetect,pathz,pathf,itprice,states,mailnum,name,datecnt,newblood,itf,bloodf,bloodm,breedpeople,breedaddr from Csvdogforeign where id=" + id);
            if (dbadapter.next())
            {
                id = dbadapter.getInt(1);
                Ename = dbadapter.getString(2);
                applydate = dbadapter.getDate(3);
                birthdate = dbadapter.getDate(4);
                earid = dbadapter.getString(5);
                member = dbadapter.getString(6);
                itm = dbadapter.getInt(7);
                mailingdate = dbadapter.getDate(8);
                sex = dbadapter.getInt(9);
                foreignblood = dbadapter.getString(10);
                foreigndetect = dbadapter.getString(11);
                pathz = dbadapter.getString(12);
                pathf = dbadapter.getString(13);
                itprice = dbadapter.getInt(14);
                states = dbadapter.getInt(15);
                mailnum = dbadapter.getString(16);
                name = dbadapter.getString(17);
                datecnt = dbadapter.getDate(18);
                newblood = dbadapter.getString(19);
                itf = dbadapter.getInt(20);
                bloodf = dbadapter.getString(21);
                bloodm = dbadapter.getString(22);
                breedpeople=dbadapter.getString(23);
                breedaddr=dbadapter.getString(24);
                exists = true;
            }
            else
            {
                exists = false;
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    public void Load() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select id,ename,applydate,birthdate,earid,member,itm,mailingdate,sex,foreignblood,foreigndetect,pathz,pathf,itprice,bloodf,bloodm,name,datecnt,newblood,itf,bloodf,bloodm,breedpeople,breedaddr from Csvdogforeign where earid=" +
                                   dbadapter.cite(earid));
            if (dbadapter.next())
            {
                id = dbadapter.getInt(1);
                Ename = dbadapter.getString(2);
                applydate = dbadapter.getDate(3);
                birthdate = dbadapter.getDate(4);
                earid = dbadapter.getString(5);
                member = dbadapter.getString(6);
                itm = dbadapter.getInt(7);
                mailingdate = dbadapter.getDate(8);
                sex = dbadapter.getInt(9);
                foreignblood = dbadapter.getString(10);
                foreigndetect = dbadapter.getString(11);
                pathz = dbadapter.getString(12);
                pathf = dbadapter.getString(13);
                itprice = dbadapter.getInt(14);
                bloodf = dbadapter.getString(15);
                bloodm = dbadapter.getString(16);
                name = dbadapter.getString(17);
                datecnt = dbadapter.getDate(18);
                newblood = dbadapter.getString(19);
                itf  =  dbadapter.getInt(20);
                bloodf = dbadapter.getString(21);
                bloodm = dbadapter.getString(22);
                breedpeople=dbadapter.getString(23);
                breedaddr=dbadapter.getString(24);
                exists = true;
            } else
            {
                exists = false;
            }

            }

        catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    public static void create(String ename, Date applydate, Date birthdate, String earid, String member, int itm, Date mailingdate, int sex, String foreignblood, String foreigndetect, String pathz,
                              String pathf, int itprice, String community, String states, String mailnum, String name, String bloodf, String bloodm,String breedpeople,String breedaddr) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        int itf = 0;
        try
        {
            dbadapter.executeUpdate(
                "insert into Csvdogforeign(ename,applydate,birthdate,earid,member,itm,mailingdate,sex,foreignblood,foreigndetect,pathz,pathf,itprice,community,states,mailnum,name,itf,bloodf,bloodm,breedpeople,breedaddr) values ("
                + dbadapter.cite(ename) + "," + dbadapter.cite(applydate) + "," + dbadapter.cite(birthdate) + "," + dbadapter.cite(earid) + "," + dbadapter.cite(member) + "," + itm + "," +
                dbadapter.cite(mailingdate) + "," + sex + "," + dbadapter.cite(foreignblood) + "," + dbadapter.cite(foreigndetect) + "," + dbadapter.cite(pathz) + "," + dbadapter.cite(pathf) + "," + itprice +
                "," + dbadapter.cite(community) + "," + dbadapter.cite(states) + "," + dbadapter.cite(mailnum) + "," + dbadapter.cite(name) + "," + itf + "," + dbadapter.cite(bloodf) + "," + dbadapter.cite(bloodm) + ","+dbadapter.cite(breedpeople)+","+dbadapter.cite( breedaddr)+")");
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    public static void set(String ename, Date applydate, Date birthdate, String earid, String member, int itm, Date mailingdate, int sex, String foreignblood, String foreigndetect, String pathz,
                           String pathf, int itprice, String states, int ids, String mailnum, String name, String bloodf, String bloodm,String breedpeople,String breedaddr) throws SQLException
    {

        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate(" update Csvdogforeign set  ename=" + dbadapter.cite(ename) + ",applydate=" + dbadapter.cite(applydate) + ",birthdate=" + dbadapter.cite(birthdate) + ",earid=" +
                                    dbadapter.cite(earid) + ",member=" + dbadapter.cite(member) + ",itm=" + itm + ",mailingdate=" + dbadapter.cite(mailingdate) + ",sex=" + sex + ",foreignblood=" +
                                    dbadapter.cite(foreignblood) + ",foreigndetect=" + dbadapter.cite(foreigndetect) + ",pathz=" + dbadapter.cite(pathz) + ",pathf=" + dbadapter.cite(pathf) + ",itprice=" + itprice +
                                    ",states =" + states + ", mailnum=" + dbadapter.cite(mailnum) + ",name = " + dbadapter.cite(name) + ", bloodf=" + dbadapter.cite(bloodf) + ", bloodm=" + dbadapter.cite(bloodm) + ",breedpeople="+dbadapter.cite(breedpeople)+",breedaddr="+dbadapter.cite(breedaddr)+" where id = " + ids);
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
            dbadapter.executeQuery("SELECT id FROM Csvdogforeign WHERE community=" + DbAdapter.cite(community) + sql);
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
            dbadapter.executeQuery("select count(id) from Csvdogforeign where community =" + dbadapter.cite(community) + sql);
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

    //修改itm方法 , 并且修改csvdog表
    public static void updateitm(int id, String earid, String community) throws SQLException
    {

        DbAdapter dbadapter = new DbAdapter();
        try
        { //foreignloginletterid itforeign; //标识国外证书是否转发  1 标识转发了，0标识没有转发 blood
            //需要做判断数据库中是否存储过这条狗。
            Csvdogforeign dogfor = Csvdogforeign.find(id);
            String breedpeople = dogfor.getBreedpeople();
            String breedaddr = dogfor.getBreedaddr();
            String blood = dogfor.getForeignblood();

            Date birthdate = dogfor.getBirthdate();
            Date datetimes = new Date();

            //标示
            String a = Csvdogforeign.CsvNum(dogfor.getForeigndetect(), 0, earid);
            String b = Csvdogforeign.CsvNum(dogfor.getForeigndetect(), 1, earid);
            String newblood = null;
            if (a != null && b != null)
            {
                newblood = Csvdog.getMarkblood(1, 1, 1);
            } else
            {
                newblood = Csvdog.getMarkblood(2, 1, 1);
            }
            int sex = dogfor.getSex();
            String member = null;
            //如果繁殖人 为空 那这个犬只为申请人所有
            member = dogfor.getMember();
            dbadapter.executeUpdate("update Csvdogforeign set newblood="+ dbadapter.cite(newblood)+" ,states = 3 , itf =2,datecnt ="+dbadapter.cite(datetimes)+"  where id =" + id);

            if (Csvdog.getfalg(earid)) //有
            {
                dbadapter.executeUpdate("update Csvdog set ename="+dbadapter.cite(dogfor.getEname())+",breedaddr="+dbadapter.cite(breedaddr)+",breedpeople="+dbadapter.cite(breedpeople)+",member ="+dbadapter.cite(member)+" , foreignloginletterid=" + dbadapter.cite(blood) + ",bloodlineletterid =" + dbadapter.cite(newblood) + ", itforeign = 1  ,f_bloodlineletterid=" + dbadapter.cite(dogfor.getBloodf()) + ",m_bloodlineletterid=" + dbadapter.cite(dogfor.getBloodm()) + "   where earid = " + dbadapter.cite(earid));

            } else //没有
            {
                dbadapter.executeUpdate("insert into Csvdog (foreignloginletterid,bloodlineletterid,earid,birthdate,sex,member,itforeign,community,f_bloodlineletterid,m_bloodlineletterid,breedpeople,breedaddr,ename) values (" + dbadapter.cite(blood) + "," + dbadapter.cite(newblood) + "," + dbadapter.cite(earid) + "," +
                                        dbadapter.cite(birthdate) + "," + sex + "," + dbadapter.cite(member) + "," + 1 + "," + dbadapter.cite(community) + "," + dbadapter.cite(dogfor.getBloodf()) + "," + dbadapter.cite(dogfor.getBloodm()) +","+dbadapter.cite(breedpeople)+","+dbadapter.cite(breedaddr)+","+dbadapter.cite(dogfor.getEname())+ ")");
            }
            //dbadapter.executeUpdate("update csvdog set member ");
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }

    }

////
    public static void createCsv(String foreignloginletterid, String bloodlineletterid, String earid, Date birthdate, int sex, String member, String community) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("insert into Csvdog(foreignloginletterid,bloodlineletterid,earid,birthdate,sex,member,itforeign,community)values(" + dbadapter.cite(foreignloginletterid) + "," + dbadapter.cite(bloodlineletterid) + "," + dbadapter.cite(earid) + "," + dbadapter.cite(birthdate) + "," + sex + "," + dbadapter.cite(member) + "," + 0 + "," + dbadapter.cite(community) + "," + ")");
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    public static void setCsv(String foreignloginletterid, String bloodlineletterid, String earid, Date birthdate, int sex, String member) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("update Csvdog set foreignloginletterid=" + dbadapter.cite(foreignloginletterid) + ",bloodlineletterid=" + dbadapter.cite(bloodlineletterid) + ",earid=" + dbadapter.cite(earid) + ",birthdate=" + dbadapter.cite(birthdate) + ",sex=" + sex + ",member=" + dbadapter.cite(member) + "  where earid = " + dbadapter.cite(earid));
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    ///
    public static String Csvcheckbox(String str, int values, String earid)
    {
        boolean falg = false;

        try
        {
            falg = Csvdogforeign.getearidboolean(earid);
        } catch (SQLException ex)
        {
            ex.printStackTrace();
        }
        if (falg && str.length() > 0)
        {
            String charflag[] = str.split("/");
            if (charflag != null)
            {
                for (int i = 0; i < charflag.length; i++)
                {
                    if (Integer.parseInt(charflag[i]) == values)
                    {
                        return "checked=checked";
                    }
                }
            }
        }
        return "";
    }

    ////返回的数量
    public static String CsvNum(String str, int values, String earid)
    {
        boolean falg = false;

        try
        {
            falg = Csvdogforeign.getearidboolean(earid);
        } catch (SQLException ex)
        {
            ex.printStackTrace();
        }
        if (falg && str.length() > 0)
        {
            String charflag[] = str.split("/");
            if (charflag != null)
            {
                for (int i = 0; i < charflag.length; i++)
                {
                    if (Integer.parseInt(charflag[i]) == values)
                    {
                        return charflag[i];
                    }
                }
            }
        }
        return "";
    }

    public static boolean getearidboolean(String earid) throws SQLException
    {
        DbAdapter dbadpter = new DbAdapter();
        try
        {
            dbadpter.executeQuery("select * from Csvdogforeign where earid=" + dbadpter.cite(earid));
            if (dbadpter.next())
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
            dbadpter.close();
        }
    }

    public static boolean getidboolean(int id) throws SQLException
    {
        DbAdapter dbadpter = new DbAdapter();
        try
        {
            dbadpter.executeQuery("select * from Csvdogforeign where id=" + id);
            if (dbadpter.next())
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
            dbadpter.close();
        }
    }

    public static boolean getEarid_blood(String earid,String foreignblood)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select * from Csvdogforeign where earid ="+db.cite(earid)+" or  foreignblood="+db.cite(foreignblood));
            if(db.next())
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        finally
        {
            db.close();
        }

    }

    public String getMailnum()
    {
        return mailnum;
    }

    public int getStates()
    {
        return states;
    }


    public String getName()
    {
        return name;
    }

    public int getId()
    {
        return id;
    }


    public Date getApplydate()
    {
        return applydate;
    }

    public Date getBirthdate()
    {
        return birthdate;
    }

    public String getEarid()
    {
        return earid;
    }

    public String getForeignblood()
    {
        return foreignblood;
    }

    public String getForeigndetect()
    {
        return foreigndetect;
    }

    public int getItm()
    {
        return itm;
    }

    public int getItprice()
    {
        return itprice;
    }

    public Date getMailingdate()
    {
        return mailingdate;
    }

    public String getMember()
    {
        return member;
    }

    public String getPathf()
    {
        return pathf;
    }

    public String getPathz()
    {
        return pathz;
    }

    public int getSex()
    {
        return sex;
    }

    public String getBloodm()
    {
        return bloodm;
    }

    public String getBloodf()
    {
        return bloodf;
    }

    public Date getDatecnt()
    {
        return datecnt;
    }

    public String getNewblood()
    {
        return newblood;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getBreedpeople()
    {
        return breedpeople;
    }

    public String getBreedaddr()
    {
        return breedaddr;
    }

    public String getEname()
    {
        return Ename;
    }
}
