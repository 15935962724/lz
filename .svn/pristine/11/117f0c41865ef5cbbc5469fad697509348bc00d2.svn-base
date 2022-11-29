package tea.entity.csvclub;

import java.sql.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class Csvdogzffz extends Entity
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
    private String foreignbreed; //国外繁育证书号
    private int foreigndetect; //国外检测
    private String pathz; //证书正面路径
    private String pathf; //证书背面路径
    private String name; //申请人
    private int states;
    private String mailnum; //邮寄编号
    private int itf; //确认交费
    private int newbreedid; //生成的新的繁殖证书号

    /*********
     2008年5月5日15:01:25 datecnt  添加时间字段
     **********************/
    private Date datecnt ;
    /*2008年6月18日16:40:36
     * hipid 髋肘
     * */
    private String hipid;//新生成的国外的髋肘测试号
    /*2008年6月20日0:30:07
     * */
    private String country;//国家

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

    public static Csvdogzffz find(String earid) throws SQLException
    {
        return new Csvdogzffz(earid);
    }

    public Csvdogzffz(String earid) throws SQLException
    {
        this.earid = earid;
        Load();
    }

    public static Csvdogzffz find(int id) throws SQLException
    {
        return new Csvdogzffz(id);
    }

    public Csvdogzffz(int id) throws SQLException
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
                "select id,ename,applydate,birthdate,earid,member,itm,mailingdate,sex,foreignbreed,foreigndetect,pathz,pathf,itprice,states,mailnum,name,datecnt,hipid,country from Csvdogzffz where id=" + id);
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
                foreignbreed = dbadapter.getString(10);
                foreigndetect = dbadapter.getInt(11);
                pathz = dbadapter.getString(12);
                pathf = dbadapter.getString(13);
                itprice = dbadapter.getInt(14);
                states = dbadapter.getInt(15);
                mailnum = dbadapter.getString(16);
                name = dbadapter.getString(17);
                datecnt = dbadapter.getDate(18);
                hipid = dbadapter.getString(19);
                country= dbadapter.getString(20);
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
            dbadapter.executeQuery("select id,ename,applydate,birthdate,earid,member,itm,mailingdate,sex,foreignbreed,foreigndetect,pathz,pathf,itprice,states,mailnum,name,datecnt,hipid,country from Csvdogzffz where earid=" +
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
                foreignbreed = dbadapter.getString(10);
                foreigndetect = dbadapter.getInt(11);
                pathz = dbadapter.getString(12);
                pathf = dbadapter.getString(13);
                itprice = dbadapter.getInt(14);
                states = dbadapter.getInt(15);
                mailnum = dbadapter.getString(16);
                name = dbadapter.getString(17);
                datecnt = dbadapter.getDate(18);
                hipid = dbadapter.getString(19);
                country = dbadapter.getString(20);

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

    public static void create(String ename, Date applydate, Date birthdate, String earid, String member, int itm, Date mailingdate, int sex, String foreignbreed, int foreigndetect, String pathz,
                              String pathf, int itprice, String community, int states, String mailnum, String name,String country) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        int itf = 0;
        try
        {
            dbadapter.executeUpdate(
                "insert into Csvdogzffz(ename,applydate,birthdate,earid,member,itm,mailingdate,sex,foreignbreed,foreigndetect,pathz,pathf,itprice,community,states,mailnum,name,itf,country) values ("
                + dbadapter.cite(ename) + "," + dbadapter.cite(applydate) + "," + dbadapter.cite(birthdate) + "," + dbadapter.cite(earid) + "," + dbadapter.cite(member) + "," + itm + "," +
                dbadapter.cite(mailingdate) + "," + sex + "," + dbadapter.cite(foreignbreed) + "," + foreigndetect + "," + dbadapter.cite(pathz) + "," + dbadapter.cite(pathf) + "," + itprice +
                "," + dbadapter.cite(community) + "," + states + "," + dbadapter.cite(mailnum) + "," + dbadapter.cite(name) + "," + itf + ","+dbadapter.cite(country)+") ");
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    public static void set(String ename, Date applydate, Date birthdate, String earid, String member, int itm, Date mailingdate, int sex, String foreignbreed, int foreigndetect, String pathz,
                           String pathf, int itprice, int states, int ids, String mailnum, String name,String country) throws SQLException
    {

        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate(" update Csvdogzffz set  ename=" + dbadapter.cite(ename) + ",applydate=" + dbadapter.cite(applydate) + ",birthdate=" + dbadapter.cite(birthdate) + ",earid=" +
                                    dbadapter.cite(earid) + ",member=" + dbadapter.cite(member) + ",itm=" + itm + ",mailingdate=" + dbadapter.cite(mailingdate) + ",sex=" + sex + ",foreignbreed=" +
                                    dbadapter.cite(foreignbreed) + ",foreigndetect=" + foreigndetect + ",pathz=" + dbadapter.cite(pathz) + ",pathf=" + dbadapter.cite(pathf) + ",itprice=" + itprice +
                                    ",states =" + states + ", mailnum=" + dbadapter.cite(mailnum) + ",name = " + dbadapter.cite(name) + ",country="+dbadapter.cite(country)+" where id = " + ids);
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
            dbadapter.executeQuery("SELECT id FROM Csvdogzffz WHERE community=" + DbAdapter.cite(community) + sql);
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
            dbadapter.executeQuery("select count(id) from Csvdogzffz where community =" + dbadapter.cite(community) + sql);
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

//确定缴费
    public static void updateEnter(int id, String earid, String community, String member) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();

        Csvdog dog = Csvdog.find(earid);

        Date dates = new Date();
        String hipid_f="";
        int hipid=0;
        try
        {
            dbadapter.executeQuery("select max(breedexamid) from csvdogcheck");
            if (dbadapter.next())
            {
                hipid_f=Csvdogcheck.Csvdoghip_f(community,member,"");
                hipid = Integer.parseInt(hipid_f)+1;
                hipid_f=String.valueOf(hipid);
                int max = dbadapter.getInt(1) + 1;
                dbadapter.executeUpdate("update Csvdogzffz  set hipid="+dbadapter.cite(hipid_f)+",datecnt="+dbadapter.cite(dates)+",itprice = 2,states=3,newbreedid=" + max + " where id =" + id);



                dbadapter.executeUpdate("insert into Csvdogcheck(idnum,boolid,earid,breedexamid,community,hipid) values (" + dbadapter.cite(member) + "," + dbadapter.cite(dog.getBloodlineletterid()) + "," + dbadapter.cite(earid) + "," + max + "," + dbadapter.cite(community) +","+dbadapter.cite(hipid_f)+")");
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    /**
     * 2008-08-30 判断数据是否存在。
     *  * */
    public static boolean getOption(String earid, String member) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select * from Csvdog where earid = " + dbadapter.cite(earid));
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
    public String getApplydateToString()
        {
            if(applydate!=null)
            {
                return Csvdogzffz.sdf.format(applydate);
            }
            else
            {
                return "";
            }

        }

    public Date getBirthdate()
    {
        return birthdate;
    }
    public String getBirthdateToString()
    {
        if(birthdate!=null)
        {
            return Csvdogzffz.sdf.format(birthdate);
        }
        else
        {
            return "";
        }

    }


    public String getEarid()
    {
        return earid;
    }

    public String getforeignbreed()
    {
        return foreignbreed;
    }

    public int getForeigndetect()
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

    public String getMailingdateToString()
    {
        if(mailingdate!=null)
        {
           return CsvdogTransmit.sdf.format(mailingdate);
        }
        else
        {
            return "";
        }

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

    public int getNewbreedid()
    {
        return newbreedid;
    }



    public Date getDatecnt()
    {
        return datecnt;
    }

    public String getHipid()
    {
        return hipid;
    }

    public String getCountry()
    {
        return country;
    }

    public String getDatecntToString()
    {
        if(datecnt!=null)
        {
           return CsvdogTransmit.sdf.format(datecnt);
        }
        else
        {
            return "";
        }
    }

    public String getEname()
    {
        return Ename;
    }
}
