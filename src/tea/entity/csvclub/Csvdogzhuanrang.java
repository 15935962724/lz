package tea.entity.csvclub;

import java.sql.*;
import java.util.Date;
import tea.db.*;
import tea.entity.*;


public class Csvdogzhuanrang extends Entity
{


    /*   犬只名称
     血统证书号  耳号
     转让日期
     新的犬主:姓名  联系方式
     身份证号
     地址
     */
    private int id;
    private String cname; //犬只名称
    private String blood; //血统证书号
    private String earid; //耳号
    private String hostname; //以前犬只的主人的id
    private String tel; //
    private String card; //
    private String addr; //
    private Date zrdate; //
    private Date quedate;//确认日期
    private String member; //申请人id 也就是新主任的id
    private String community; //
    private int itz; // 未接受，等待交费，已交费
    private String zrremark; //犬只变更备注
    private int staticdoghost; //犬只状态
    private int lianxistatic;//联系状态
    private boolean exists; // 是否存在

    public static final String ZRSTATICS[] =
                                             {"邮寄", "赛场耳号", "髋肘现场", "其他","---"};

    public static final String ITZS[] =
            {"等待变更", "---", "已变更"};

    public static final String LIANXISTATIC[] =
            {"---", "电话未接通", "需电话确认","资料不全","其他"};

    public static Csvdogzhuanrang find(String earid) throws SQLException
    {
        return new Csvdogzhuanrang(earid);
    }

    public Csvdogzhuanrang(String earid) throws SQLException
    {
        this.earid = earid;
        Load();
    }

    public static Csvdogzhuanrang find(int id) throws SQLException
    {
        return new Csvdogzhuanrang(id);
    }

    public Csvdogzhuanrang(int id) throws SQLException
    {
        this.id = id;
        Loadid();
    }

    public void Loadid() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select id,cname,blood,earid,hostname,tel,card,addr,zrdate,member,itz,community,zrremark,staticdoghost,lianxistatic,quedate from Csvdogzhuanrang where id=" + id);
            if (dbadapter.next())
            {
                id = dbadapter.getInt(1);
                cname = dbadapter.getString(2);
                blood = dbadapter.getString(3);
                earid = dbadapter.getString(4);
                hostname = dbadapter.getString(5);
                tel = dbadapter.getString(6);
                card = dbadapter.getString(7);
                addr = dbadapter.getString(8);
                zrdate = dbadapter.getDate(9);
                member = dbadapter.getString(10);
                itz = dbadapter.getInt(11);
                community = dbadapter.getString(12);
                zrremark = dbadapter.getString(13); //犬只变更备注
                staticdoghost = dbadapter.getInt(14); //犬只状态
                lianxistatic = dbadapter.getInt(15);//联系状态
                quedate = dbadapter.getDate(16);//确认时间
                exists = true;
            }
            else
            {
                exists= false;
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
            dbadapter.executeQuery("select  id,cname,blood,earid,hostname,tel,card,addr,zrdate,member,itz,community,zrremark,staticdoghost,lianxistatic,quedate from Csvdogzhuanrang where earid=" + dbadapter.cite(earid));
            if (dbadapter.next())
            {
                id = dbadapter.getInt(1);
                cname = dbadapter.getString(2);
                blood = dbadapter.getString(3);
                earid = dbadapter.getString(4);
                hostname = dbadapter.getString(5);
                tel = dbadapter.getString(6);
                card = dbadapter.getString(7);
                addr = dbadapter.getString(8);
                zrdate = dbadapter.getDate(9);
                member = dbadapter.getString(10);
                itz = dbadapter.getInt(11);
                community = dbadapter.getString(12);
                zrremark = dbadapter.getString(13); //犬只变更备注
                staticdoghost = dbadapter.getInt(14); //犬只状态
                lianxistatic = dbadapter.getInt(15); //联系状态
                quedate = dbadapter.getDate(16); //确认时间
                exists = true;
            } else
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
    ///// 提交
    public static void create(String cname, String blood, String earid, String hostname, String tel, String card, String addr, Date zrdate, String member, int itz, String community) throws SQLException
    {
        //// 未接受0，等待交费1，已交费2
        itz = 1;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("insert into Csvdogzhuanrang( cname,blood,earid,hostname,tel,card,addr,zrdate,member,itz,community) values("
                                    + dbadapter.cite(cname) + "," + dbadapter.cite(blood) + "," + dbadapter.cite(earid) + "," + dbadapter.cite(hostname) + "," + dbadapter.cite(tel) + "," + dbadapter.cite(card) + "," + dbadapter.cite(addr) + "," + dbadapter.cite(zrdate) + "," + dbadapter.cite(member) +
                                    "," + itz + "," + dbadapter.cite(community) + ")");
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }
    public static void createupdate(String cname, String blood, String earid, String hostname, String tel, String card, String addr, Date zrdate, String member, int itz, String community,int staticdoghost,String zrremark,int lianxistatic) throws SQLException
    {
        //// 未接受0，等待交费1，已交费2
        itz = 1;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("insert into Csvdogzhuanrang( cname,blood,earid,hostname,tel,card,addr,zrdate,member,itz,community,staticdoghost,zrremark,lianxistatic) values("
                                    + dbadapter.cite(cname) + "," + dbadapter.cite(blood) + "," + dbadapter.cite(earid) + "," + dbadapter.cite(hostname) + "," + dbadapter.cite(tel) + "," + dbadapter.cite(card) + "," + dbadapter.cite(addr) + "," + dbadapter.cite(zrdate) + "," + dbadapter.cite(member) +
                                    "," + itz + "," + dbadapter.cite(community) +","+staticdoghost+","+dbadapter.cite(zrremark)+","+lianxistatic+")");
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }
    public static void set(String cname, String blood, String earid, String hostname, String tel, String card, String addr, Date zrdate, String member, int id) throws SQLException
    {

        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("update Csvdogzhuanrang set  cname=" + dbadapter.cite(cname) + ", blood=" + dbadapter.cite(blood) + " ,earid =" + dbadapter.cite(earid) + ",hostname=" + dbadapter.cite(hostname) + ",tel=" + dbadapter.cite(tel) + ",card=" + dbadapter.cite(card) + ",addr=" +
                                    dbadapter.cite(addr) + ",zrdate=" + dbadapter.cite(zrdate) + ",member=" + dbadapter.cite(member) + " where id = " + id);

        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    public static void setupdate(String cname, String blood, String earid, String hostname, String tel, String card, String addr, Date zrdate, String member, int id, int staticdoghost,String zrremark,int lianxistatic) throws SQLException
    {

        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("update Csvdogzhuanrang set  cname=" + dbadapter.cite(cname) + ", blood=" + dbadapter.cite(blood) + " ,earid =" + dbadapter.cite(earid) + ",hostname=" + dbadapter.cite(hostname) + ",tel=" + dbadapter.cite(tel) + ",card=" + dbadapter.cite(card) + ",addr=" +
                                    dbadapter.cite(addr) + ",zrdate=" + dbadapter.cite(zrdate) + ",member=" + dbadapter.cite(member) + ",staticdoghost=" + staticdoghost + ",zrremark="+dbadapter.cite(zrremark)+",lianxistatic="+lianxistatic+" where id = " + id);

        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }


    //////////////确认提交
    public static void createHost(String cname, String blood, String earid, String hostname, String tel, String card, String addr, Date zrdate, String member, int itz, String community) throws SQLException
    {
        //// 未接受0，等待交费1，已交费2
        itz = 2;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("insert into Csvdogzhuanrang( cname,blood,earid,hostname,tel,card,addr,zrdate,member,itz,community) values("
                                    + dbadapter.cite(cname) + "," + dbadapter.cite(blood) + "," + dbadapter.cite(earid) + "," + dbadapter.cite(hostname) + "," + dbadapter.cite(tel) + "," + dbadapter.cite(card) + "," + dbadapter.cite(addr) + "," + dbadapter.cite(zrdate) + "," + dbadapter.cite(member) +
                                    "," + itz + "," + dbadapter.cite(community) + ")");
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }

    }

    public static void setHost(String cname, String blood, String earid, String hostname, String tel, String card, String addr, Date zrdate, String member, int itz, int id) throws SQLException
    {

        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("update Csvdogzhuanrang set cname=" + dbadapter.cite(cname) + ", blood=" + dbadapter.cite(blood) + " ,earid =" + dbadapter.cite(earid) + ",hostname=" + dbadapter.cite(hostname) + ",tel=" + dbadapter.cite(tel) + ",card=" + dbadapter.cite(card) + ",addr=" +
                                    dbadapter.cite(addr) + ",zrdate=" + dbadapter.cite(zrdate) + ",member=" + dbadapter.cite(member) + ",itz=" + itz + " where id = " + id);
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

////////////////////
    public static void createHostupdate(String cname, String blood, String earid, String hostname, String tel, String card, String addr, Date zrdate, String member, int itz, String community,int staticdoghost,String zrremark,int lianxistatic) throws SQLException
    {
        //// 未接受0，等待交费1，已交费2  quedate,lianxistatic
        Date dates = new Date();

        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("insert into Csvdogzhuanrang( cname,blood,earid,hostname,tel,card,addr,zrdate,member,itz,community, staticdoghost, zrremark,lianxistatic,quedate) values("
                                    + dbadapter.cite(cname) + "," + dbadapter.cite(blood) + "," + dbadapter.cite(earid) + "," + dbadapter.cite(hostname) + "," + dbadapter.cite(tel) + "," + dbadapter.cite(card) + "," + dbadapter.cite(addr) + "," + dbadapter.cite(zrdate) + "," + dbadapter.cite(member) +
                                    "," + itz + "," + dbadapter.cite(community) + ","+ staticdoghost+","+ dbadapter.cite(zrremark)+","+lianxistatic+","+dbadapter.cite( Csvdogzhuanrang.sdf.format(dates))+")");
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }

    }

    public static void setHostupdate(String cname, String blood, String earid, String hostname, String tel, String card, String addr, Date zrdate, String member, int itz, int id,int staticdoghost,String zrremark,int lianxistatic) throws SQLException
    {
        Date dates = new Date();

        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("update Csvdogzhuanrang set cname=" + dbadapter.cite(cname) + ", blood=" + dbadapter.cite(blood) + " ,earid =" + dbadapter.cite(earid) + ",hostname=" + dbadapter.cite(hostname) + ",tel=" + dbadapter.cite(tel) + ",card=" + dbadapter.cite(card) + ",addr=" +
                                    dbadapter.cite(addr) + ",zrdate=" + dbadapter.cite(zrdate) + ",member=" + dbadapter.cite(member) + ",itz=" + itz +",staticdoghost="+staticdoghost+ ",zrremark="+dbadapter.cite(zrremark)+",lianxistatic="+lianxistatic+",quedate="+dbadapter.cite( Csvdogzhuanrang.sdf.format(dates))+" where id = " + id);

        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }







    //判断数据库中是否有这条数据
    public static java.util.Enumeration findByCommunity(String community, String sql, int pos, int size) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT id FROM Csvdogzhuanrang WHERE community=" + DbAdapter.cite(community) + sql);
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
            dbadapter.executeQuery("select count(id) from Csvdogzhuanrang where community =" + dbadapter.cite(community) + sql);
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

    //确认犬主变更
    public static void Option(int ids) throws SQLException
    {
         Date dates = new Date();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("update csvdogzhuanrang set itz = 2,quedate="+dbadapter.cite( Csvdogzhuanrang.sdf.format(dates))+" where id =" + ids);
            Csvdogzhuanrang csvdogzr = Csvdogzhuanrang.find(ids);
            String doghost = csvdogzr.getHostname();
            String member = csvdogzr.getMember();
            dbadapter.executeUpdate("update csvdog set member = " + dbadapter.cite(member) + " ,doghost=" + dbadapter.cite(doghost) + " where earid =" + dbadapter.cite(csvdogzr.getEarid()));
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }


    //核实新犬主任信息
    public static boolean hostOption(String name, String card) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select member from profilelayer where firstname = " + dbadapter.cite(name) + " and member in (select member from profile where card = " + dbadapter.cite(card) + ")");
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

    public static boolean Optionmember(String hostname, String blood) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        boolean falg = false;
        try
        {
            db.executeQuery("select blood from csvdogzhuanrang where hostname=" + db.cite(hostname) + " and blood =" + db.cite(blood));
            if (db.next())
            {
                falg = true;
            } else
            {
                falg = false;
            }
        } finally
        {
            db.close();
        }
        return falg;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getMember()
    {
        return member;
    }

    public String getAddr()
    {
        return addr;
    }

    public String getBlood()
    {
        return blood;
    }

    public String getCard()
    {
        return card;
    }

    public String getCname()
    {
        return cname;
    }

    public String getEarid()
    {
        return earid;
    }

    public String getHostname()
    {
        return hostname;
    }

    public int getItz()
    {
        return itz;
    }

    public String getTel()
    {
        return tel;
    }

    public Date getZrdate()
    {
        return zrdate;
    }
    public String getZrdateToString()
    {
        if(zrdate!=null)
        {

            return Csvdogzhuanrang.sdf.format(zrdate);
        }
        else
        {
            return "";
        }
    }
    public int getId()
    {
        return id;
    }

    public String getZrremark()
    {
        return zrremark;
    }

    public int getStaticdoghost()
    {
        return staticdoghost;
    }

    public Date getQuedate()
    {
        return quedate;
    }

    public int getLianxistatic()
    {
        return lianxistatic;
    }

    public boolean isExists()
    {
        return exists;
    }
}
