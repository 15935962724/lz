package tea.entity.csvclub;

import java.math.*;
import java.sql.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import tea.resource.*;
import java.text.*;
import java.util.Calendar;

/*
 2007年8月28 添加判断父母血统号和耳号是否符合，并且判断这个犬只是否属于这个主人
 */

public class Csvdogprove extends Entity
{
    private String proveNum; //证明编号
    private String earid; //耳号
    private String vipid; //会员
    private BigDecimal price; //
    private String serviceshow; //服务说明
    private int number; //数量
    private int drawmode; //领取方式
    private String remark; //备注 申请时，这一次的备注
    private int printnums; //打印数量
    private int sunnums; //总数量
    private int drawnums; //领取数量
    private String servicename; //标识到没到账
    private String community; //社区
    private int id; //id
    private Date csvprovedate; //申请日期
    private String its; //标识是否确认缴费 0 表示没有到帐 1表示已经到帐配犬证明
    private String itp; //标识是否确认打印 0 表示没有打印 1表示已经打印
    private Date ensuredate; //确认到帐的时间
    private String oldprovenum; //在补做配犬证明时候，记录的原配犬证明
    private String f_blood; // 父血统证书号
    private String m_blood; // 母血统证书号
    private String f_earid; // 父耳号
    private String m_earid; //母耳号
    private int nums; // 总犬主数量
    private int fnums; //公犬数量
    private int mnums; //母犬数量
    private Date fmprovetime; //配种日期
    private int bloodtype; //血统证书总类
    private int csvbloodtype; //白色血统证书 ，类型
    private String near; //是否近亲结婚
    private int fdeath; //死胎
    private int mdeath; //
    private int fabortion; //夭折犬
    private int mabortion; //
    private int fdeathyou; //死亡幼犬
    private int mdeathyou; //
    private int ffosterage; //寄养犬
    private int mfosterage; //
    private int famount; //存栏犬数
    private int mamount; //
    private int fregister; //登记犬数
    private int mregister; //
    private int itj; //标识已经收费  1 标识已经缴费 0表示还没有点击交费 按钮
    private int itc; //财务确认到帐。1 标识已经确认到帐 0表示还没有确认到帐
    private int sprice;
    private int itzxid; //确定是否注销 注销的id号是多少。
    private int itzx; // 0 表示没有注销，1表示已经注销
    private String breedpeople; //繁殖人 这个地方要记录的是主人的id csvdog的繁殖人 记录的是主人的名称，地址也是相对不变的

    ///////2008-04-29
    private String remarkprove; // 关于这个配犬证明的备注
    private int ithuishou; //在补做时 标明状态。

    public static final String DRAWMODES[] =
            {"--------", "自取", "代领(请把代理人姓名填入备注)", "邮寄"};
    public static final String yesNos[] =
            {"-------", "是", "否"};
    public Csvdogprove() throws SQLException
    {}

    public Csvdogprove(String proveNum, int aa) throws SQLException
    {
        this.proveNum = proveNum;
        loadprove();

    }

    public Csvdogprove(String vipid) throws SQLException
    {
        this.vipid = vipid;
        load();
    }

    public Csvdogprove(int id, String community) throws SQLException
    {
        this.id = id;
        loadnum();
    }

    public Csvdogprove(String vipid, String community) throws SQLException
    {
        this.vipid = vipid;
        loadmember();
    }


    public Csvdogprove(String vipid, String community, int id) throws SQLException
    {
        this.vipid = vipid;
        this.id = id;
        this.community = community;
        load_id();
    }

    public static Csvdogprove find(String vipid, String communty, int id) throws SQLException
    {
        return new Csvdogprove(vipid, communty, id);
    }


    public static Csvdogprove find(String vipid) throws SQLException
    {
        return new Csvdogprove(vipid);
    }

    public static Csvdogprove find(String proveNum, int aa) throws SQLException
    {
        return new Csvdogprove(proveNum, aa);
    }


    public static Csvdogprove findnum(int id, String community) throws SQLException
    {
        return new Csvdogprove(id, community);
    }

    public static Csvdogprove findmember(String vipid, String community) throws SQLException
    {
        return new Csvdogprove(vipid, community);
    }

    public void load() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("Select proveNum,vipid,price,f_blood,m_blood, f_earid,m_earid,nums,fnums,mnums ,fmprovetime,bloodtype,near,itzx,itzxid,csvbloodtype,remarkprove from Csvdogprove where vipid= " + dbadapter.cite(vipid));
            if (dbadapter.next())
            {
                proveNum = dbadapter.getString(1);
                vipid = dbadapter.getString(2);
                price = dbadapter.getBigDecimal(3, 2);
                f_blood = dbadapter.getString(4); // 父血统证书号
                m_blood = dbadapter.getString(5); // 母血统证书号
                f_earid = dbadapter.getString(6); // 父耳号
                m_earid = dbadapter.getString(7); //母耳号
                nums = dbadapter.getInt(8); // 总犬主数量
                fnums = dbadapter.getInt(9); //公犬数量
                mnums = dbadapter.getInt(10); //母犬数量
                fmprovetime = dbadapter.getDate(11); //配犬日期
                bloodtype = dbadapter.getInt(12);
                near = dbadapter.getString(13);
                itzx = dbadapter.getInt(14);
                itzxid = dbadapter.getInt(15);
                csvbloodtype = dbadapter.getInt(16);
                remarkprove = dbadapter.getString(17);
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    public void load_id() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("Select proveNum,vipid,price,f_blood,m_blood, f_earid,m_earid,nums,fnums,mnums ,fmprovetime,bloodtype,near,itzx,itzxid,csvbloodtype,remarkprove from Csvdogprove where vipid= " + dbadapter.cite(vipid) + " and id=" + id);
            if (dbadapter.next())
            {
                proveNum = dbadapter.getString(1);
                vipid = dbadapter.getString(2);
                price = dbadapter.getBigDecimal(3, 2);
                f_blood = dbadapter.getString(4); // 父血统证书号
                m_blood = dbadapter.getString(5); // 母血统证书号
                f_earid = dbadapter.getString(6); // 父耳号
                m_earid = dbadapter.getString(7); //母耳号
                nums = dbadapter.getInt(8); // 总犬主数量
                fnums = dbadapter.getInt(9); //公犬数量
                mnums = dbadapter.getInt(10); //母犬数量
                fmprovetime = dbadapter.getDate(11); //配犬日期
                bloodtype = dbadapter.getInt(12);
                near = dbadapter.getString(13);
                itzx = dbadapter.getInt(14);
                itzxid = dbadapter.getInt(15);
                csvbloodtype = dbadapter.getInt(16);
                remarkprove = dbadapter.getString(17);
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    public void loadprove() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("Select proveNum,vipid,price,f_blood,m_blood, f_earid,m_earid,nums,fnums,mnums ,fmprovetime,bloodtype,near,fdeath,mdeath,fabortion,mabortion,fdeathyou,mdeathyou,ffosterage,mfosterage,famount,mamount,fregister,mregister,itj,itzx,itzxid,breedpeople,csvbloodtype,remarkprove,oldprovenum,id from Csvdogprove where proveNum= " +
                                   dbadapter.cite(proveNum));
            if (dbadapter.next())
            {
                proveNum = dbadapter.getString(1);
                vipid = dbadapter.getString(2);
                price = dbadapter.getBigDecimal(3, 2);
                f_blood = dbadapter.getString(4); // 父血统证书号
                m_blood = dbadapter.getString(5); // 母血统证书号
                f_earid = dbadapter.getString(6); // 父耳号
                m_earid = dbadapter.getString(7); //母耳号
                nums = dbadapter.getInt(8); // 总犬主数量
                fnums = dbadapter.getInt(9); //公犬数量
                mnums = dbadapter.getInt(10); //母犬数量
                fmprovetime = dbadapter.getDate(11); //配犬日期
                bloodtype = dbadapter.getInt(12);
                near = dbadapter.getString(13);
                fdeath = dbadapter.getInt(14);
                mdeath = dbadapter.getInt(15);
                fabortion = dbadapter.getInt(16);
                mabortion = dbadapter.getInt(17);
                fdeathyou = dbadapter.getInt(18);
                mdeathyou = dbadapter.getInt(19);
                ffosterage = dbadapter.getInt(20);
                mfosterage = dbadapter.getInt(21);
                famount = dbadapter.getInt(22);
                mamount = dbadapter.getInt(23);
                fregister = dbadapter.getInt(24);
                mregister = dbadapter.getInt(25);
                itj = dbadapter.getInt(26);
                itzx = dbadapter.getInt(27);
                itzxid = dbadapter.getInt(28);
                breedpeople = dbadapter.getString(29);
                csvbloodtype = dbadapter.getInt(30);
                remarkprove = dbadapter.getString(31);
                oldprovenum = dbadapter.getString(32);
                id = dbadapter.getInt(33);
            }

        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    public void loadnum() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select number,sunnums ,vipid,drawnums,servicename,printnums,drawmode,id,community,csvprovedate,remark,its,itp,id,ensuredate from csvdogprovenum where id=" + id);
            if (dbadapter.next())
            {
                number = dbadapter.getInt(1);
                sunnums = dbadapter.getInt(2);
                vipid = dbadapter.getString(3);
                drawnums = dbadapter.getInt(4);
                servicename = dbadapter.getString(5);
                printnums = dbadapter.getInt(6);
                drawmode = dbadapter.getInt(7);
                id = dbadapter.getInt(8);
                community = dbadapter.getString(9);
                csvprovedate = dbadapter.getDate(10);
                remark = dbadapter.getString(11);
                its = dbadapter.getString(12);
                itp = dbadapter.getString(13);
                id = dbadapter.getInt(14);
                ensuredate = dbadapter.getDate(15);
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    public void loadmember() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select number,sunnums ,vipid,drawnums,servicename,printnums,drawmode,id,community,csvprovedate,remark,its,itp from csvdogprovenum where vipid=" + dbadapter.cite(vipid));
            if (dbadapter.next())
            {
                number = dbadapter.getInt(1);
                sunnums = dbadapter.getInt(2);
                vipid = dbadapter.getString(3);
                drawnums = dbadapter.getInt(4);
                servicename = dbadapter.getString(5);
                printnums = dbadapter.getInt(6);
                drawmode = dbadapter.getInt(7);
                id = dbadapter.getInt(8);
                community = dbadapter.getString(9);
                csvprovedate = dbadapter.getDate(10);
                remark = dbadapter.getString(11);
                its = dbadapter.getString(12);
                itp = dbadapter.getString(13);
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

///////-----修改csvprove-------在申请配犬证明三联的时候 通过配犬证明编号 填进去关于 这个配犬证明中父母犬的资料。。。这个表只是暂时存储，一旦添加近csvdog表后 所有的更改以 csvdog表为准
    public static void bloodupdate(String provenum, String f_blood, String m_blood, String f_earid, String m_earid, int nums, int fnums, int mnums, Date fmprovetime, String breedpeople) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("update csvdogprove set f_blood=" + dbadapter.cite(f_blood) + ",m_blood=" + dbadapter.cite(m_blood) + ", f_earid=" + dbadapter.cite(f_earid) + ",m_earid=" + dbadapter.cite(m_earid) + ",nums=" + nums + ",fnums=" + fnums + ",mnums=" + mnums + " ,fmprovetime=" +
                                    dbadapter.cite(fmprovetime) + " ,breedpeople=" + dbadapter.cite(breedpeople) + " where proveNum =" + dbadapter.cite(provenum));
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    public static void create(String proveNum, String VIPid, BigDecimal price, String serviceshow, int number, String drawmode, String remark, int printnums, int sunnums, int drawnums, String servicename, String community, String earid) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("insert into Csvdogprove (proveNum,VIPid,price,serviceshow,number,drawmode,remark,printnums,sunnums,drawnums,servicename,community,earid) values (" + dbadapter.cite(proveNum) + "," + dbadapter.cite(VIPid) + "," + price + "," + dbadapter.cite(serviceshow) + "," +
                                    number +
                                    "," + drawmode + "," + dbadapter.cite(remark) + "," + printnums + "," + sunnums + "," + drawnums + "," + dbadapter.cite(servicename) + "," + dbadapter.cite(community) + "," + dbadapter.cite(earid) + ");");
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    //插入Csvdogprove表
    public static void createp(String proveNum, String vipid, BigDecimal price, String serviceshow, int id, String servicename, String community) throws SQLException
    {
        int itj = 0; //新加入的字段 由于后面耳号 刺青中判断是否点击过 0 表示没有点击过，1标识点击过。
        int itc = 0; //新加入的字段，由于标识财务确认到帐。 0 标识没有到帐，1标识财务已经确认到帐。
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("insert into Csvdogprove (proveNum,VIPid,price,serviceshow,id,servicename,community,itj,itc) values (" + dbadapter.cite(proveNum) + "," + dbadapter.cite(vipid) + "," + price + "," + dbadapter.cite(serviceshow) + "," + id + "," + dbadapter.cite(servicename) + "," +
                                    dbadapter.cite(community) + "," + itj + "," + itc + ");");
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    //插入csvdogprovenum
    public static void createn(String vipid, int number, int printnums, int sunnums, int drawnums, String remark, String servicename, String community, int drawmode) throws SQLException
    {
        Date date = new Date();
        String its = "0";
        String itp = "0";
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("insert into Csvdogprovenum (vipid,number,printnums,sunnums,drawnums,csvprovedate,remark,servicename,community,its,itp,drawmode) values (" + dbadapter.cite(vipid) + "," + number + "," + printnums + "," + sunnums + "," + drawnums + "," + dbadapter.cite(date) + "," +
                                    dbadapter.cite(remark) + "," + dbadapter.cite(servicename) + "," + dbadapter.cite(community) + "," + dbadapter.cite(its) + "," + dbadapter.cite(itp) + "," + drawmode + ");");
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

//等用到的时候在改 配犬证明补做 2007-8-28
// 配犬证明补做 2008-4-28

    public void setpro(String provenum, String vipid, String community, String oldprovenum) throws SQLException
    {
        //itzx  0 没有注销，1注销了
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("update Csvdogprove set itzx=1, oldprovenum = " + dbadapter.cite(provenum) + "  where community =" + dbadapter.cite(community) + "  and vipid = " + dbadapter.cite(vipid) + "  and proveNum=" + dbadapter.cite(oldprovenum));
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    /*****判断用户ID和配犬证明号是否符合*************/
    public static boolean Optionprove(String proveNum, String member) throws SQLException
    {
        boolean falg = false;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select vipid from Csvdogprove where vipid =" + dbadapter.cite(member) + " and provenum=" + dbadapter.cite(proveNum));
            if (dbadapter.next())
            {
                falg = true;
            } else
            {
                falg = false;
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
        return falg;
    }

    /**     * 2007-8-17修改新添加一个方法setnums     * **/

    public void setnums(int fdeath, int mdeath, int fabortion, int mabortion, int fdeathyou, int mdeathyou, int ffosterage, int mfosterage, int famount, int mamount, int fregister, int mregister, String proveNum) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("update csvdogprove set fdeath=" + fdeath + ",mdeath=" + mdeath + ",fabortion=" + fabortion + ",mabortion=" + mabortion + ",fdeathyou=" + fdeathyou + ",mdeathyou=" + mdeathyou + ",ffosterage=" + ffosterage + ",mfosterage=" + mfosterage + ",famount=" + famount +
                                    ",mamount=" + mamount + ",fregister=" + fregister + ",mregister=" + mregister + " where  proveNum =" + dbadapter.cite(proveNum));
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }

    }

    //取得犬舍编号的最后几位 并且补充为5位的数字 例如   会员犬舍编号组成： 地区代码+K+数字`  A-K-1265 取得1265          CHC01265 001 这个是最后的效果
    public static String gethouseString(String membernumstr)
    {
        String str1 = "-";
        int index = membernumstr.lastIndexOf(str1);
        return membernumstr.substring(index + 1);
    }

    //生成配全证明编号
    public static String getprove(String csvdoghouse, int citys, String vipid) throws SQLException
    {
        String str = null;
        String house = gethouseString(csvdoghouse);
        String num = getlast(vipid);
        String cityss = null;
        cityss = Common.CSVDMCITYS[citys][1];
        if (citys != 0 && citys > 0)
        {
            str = "CH" + cityss + house + num;
        }
        return str;
    }

    //返回这个会员的在csvdogprovenum中的编号
    public static int getprovenum(String vipid) throws SQLException
    {
        int i = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            i = dbadapter.getInt("select max(id) from csvdogprovenum where vipid =" + dbadapter.cite(vipid));
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
        return i;
    }

    //返回这个主人以前添加过狗 数量 的信息
    public static StringBuilder getStr(String vipid) throws SQLException
    {
        StringBuilder str = new StringBuilder();
        String f = null;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select number from csvdogprovenum where vipid=" + dbadapter.cite(vipid));
            while (dbadapter.next())
            {
                str.append(dbadapter.getInt(1)).append("+");
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
        return str;
    }

    //返回这个主人的第几只狗
    public static String getlast(String vipid) throws SQLException
    {
        String str = null;
        int i = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            str = dbadapter.getString("select count(proveNum) from csvdogprove where vipid = " + dbadapter.cite(vipid));
            if (str != null && str.length() > 0)
            {
                int index = Integer.parseInt(str);
                return ""; //SeqTable.df4.format(index + 1);
            } else
            {
                return "";//SeqTable.df4.format("1");
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    //返回分页的页数
    public static int counthipByCommunity(String community, String sql) throws SQLException
    {
        int i = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            i = dbadapter.getInt("SELECT count(id) FROM Csvdogprovenum WHERE community=" + dbadapter.cite(community) + sql);

        } finally
        {
            dbadapter.close();
        }
        return i;
    }

    //返回分页的页数 已打印中的分页 方法
    public static int countProNumByCommunity(String community, String sql) throws SQLException
    {
        int i = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            i = dbadapter.getInt("select count(distinct(vipid)) from csvdogprovenum  where community=" + dbadapter.cite(community) + sql);

        } finally
        {
            dbadapter.close();
        }
        return i;
    }

    //返回打印时候的分页数量
    public static int countprintByCommunity(String community, String sql) throws SQLException
    {
        int i = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            i = dbadapter.getInt("SELECT distinct(count(id)) FROM Csvdogprove WHERE community=" + dbadapter.cite(community) + sql);

        } finally
        {
            dbadapter.close();
        }
        return i;
    }

    ///取得资金

    //显示Csvdogprovenum中的数据
    public static java.util.Enumeration findproveByCommunity(String community, String sql, int pos, int size) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT id FROM Csvdogprovenum WHERE  community=" + DbAdapter.cite(community) + sql);

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

    //显示Csvdogprovenum中的数据 在已打印中的数据显示
    public static java.util.Enumeration findproveNumByCommunity(String community, String sql, int pos, int size) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select distinct(vipid) from csvdogprovenum WHERE  community=" + DbAdapter.cite(community) + sql);

            for (int l = 0; l < pos + size && dbadapter.next(); l++)
            {
                if (l >= pos)
                {
                    vector.addElement(dbadapter.getString(1));
                }
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    //显示csvdogprove
    public static java.util.Enumeration findhipByCommunity(String community, String sql, int pos, int size) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT provenum FROM Csvdogprove WHERE community=" + DbAdapter.cite(community) + sql);
            for (int l = 0; l < pos + size && dbadapter.next(); l++)
            {
                if (l >= pos)
                {
                    vector.addElement(dbadapter.getString(1));
                }
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }


    public static java.util.Enumeration Proveallmember(String sql) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();

        try
        {
            db.executeQuery("SELECT distinct vip FROM Csvdogprove" + sql);
            while (db.next())
            {
                vector.addElement(String.valueOf(db.getString(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    ////xintian fangfa返回id
    public static void createupdate(String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        DbAdapter db2 = new DbAdapter();
        int id = 0;
        try
        {
            db.executeQuery("select count(vipid) from Csvdogprove where vipid =" + db.cite(member));
            if (db.next())
            {
                //number ===  vipid
                int intdb = db.getInt(1);
                db.executeUpdate("insert into Csvdogprovenum (number,vipid) values (" + intdb + "," + db.cite(member) + ")");
                db2.executeQuery("select id from Csvdogprovenum where vipid =" + db.cite(member));
                if (db2.next())
                {
                    id = db2.getInt(1);
                    db.executeUpdate("update csvdogprove set  id=" + id + " where vipid =" + db.cite(member));
                }

            }

        } finally
        {

            db.close();
            db2.close();
        }

    }


    //显示csvdogprove
    public static java.util.Enumeration findprintByCommunity(String community, String sql, int pos, int size) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT distinct(proveNum) FROM Csvdogprove WHERE  community=" + DbAdapter.cite(community) + sql);
            for (int l = 0; l < pos + size && dbadapter.next(); l++)
            {
                if (l >= pos)
                {
                    vector.addElement(dbadapter.getString(1));
                }
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    //确认方法
    public static void ensure(int id) throws SQLException
    {
        Date date = new Date();

        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("update Csvdogprovenum set its = '1' , ensuredate=" + dbadapter.cite(date) + " where id = " + id);

        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    //打印新配犬证明----确认已打印
    public static void getPrint(int id) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("update Csvdogprovenum set itp = '1' where id = " + id);

        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    //申请次数
    public static int getTrynum(String vipid) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        int s = 0;
        try
        {
            s = dbadapter.getInt(" select count(vipid) from csvdogprovenum where vipid=" + dbadapter.cite(vipid) + "  group by vipid");

        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
        return s;

    }

    //申请的总数量
    public static int getTrySnum(String vipid) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        int s = 0;
        try
        {
            s = dbadapter.getInt("select  sum(number) from csvdogprovenum where vipid=" + dbadapter.cite(vipid) + "  group by vipid");

        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
        return s;
    }

    //领取的总数量
    public static int getDrawSnum(String vipid) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        int s = 0;
        try
        {
            s = dbadapter.getInt("select sum(number) from Csvdogprovenum where its =1 and itp=1 and vipid =" + dbadapter.cite(vipid));

        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
        return s;
    }

    //根据会员id 补做配全证明号
    public static String getMemberpro(String vipid) throws SQLException
    {
        String str = null;
        int i = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            str = dbadapter.getString("select max(proveNum) from csvdogprove where vipid = " + dbadapter.cite(vipid));
            if (str != null && str.length() > 0)
            {
                int index = str.length();
                return "";//str.substring(0, index - 3) + SeqTable.df3.format(Integer.parseInt(str.substring(index - 3)) + 1);
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
        return str;
    }

    // 相对应的会员id和配全证明编号的ajax校验bean
    public static boolean isExisted(String provenum, String vipid) throws SQLException
    {

        boolean flag = false;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT provenum FROM Csvdogprove WHERE vipid=" + DbAdapter.cite(vipid) + " and provenum='" + provenum + "'");
            flag = dbadapter.next();
        } finally
        {
            dbadapter.close();
        }
        return flag;
    }

///判断配犬证明编号是否存在
    public static boolean isProve(String provenum) throws SQLException
    {
        boolean falg = false;
        // int num = 0; //未知错误
        DbAdapter dbadapter = new DbAdapter();
        try
        {

            dbadapter.executeQuery("select provenum from Csvdog where provenum=" + dbadapter.cite(provenum));
            if (dbadapter.next())
            {
                falg = false; //无此配犬证明1
                //num = 1;
            } else
            {

                dbadapter.executeQuery("select provenum from csvdogprove where provenum=" + dbadapter.cite(provenum) + " and  f_blood is null and itzx!=1  ");
                //System.out.print("select provenum from csvdogprove where provenum=" + dbadapter.cite(provenum) + " and  f_blood is null and itzx!=1  ");

                if (dbadapter.next())
                {
                    falg = true; //符合要求3
                    // num = 3;
                } else
                {
                    falg = false; //已注销或已申请2
                    //num = 2;
                }
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
        return falg; ////1
        // return num;
    }

    public static int isProveNum(String provenum) throws SQLException
    {
        // boolean falg = false;
        int num = 0; //未知错误
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select provenum from Csvdog where provenum=" + dbadapter.cite(provenum));
            if (dbadapter.next())
            {
                //      falg= false;//无此配犬证明1
                num = 1;
            } else
            {
                dbadapter.executeQuery("select provenum from csvdogprove where provenum=" + dbadapter.cite(provenum));
                if (dbadapter.next())
                {
                    dbadapter.executeQuery("select provenum from csvdogprove where provenum=" + dbadapter.cite(provenum) + " and  f_blood is null and itzx!=1  ");
                    //System.out.print("select provenum from csvdogprove where provenum=" + dbadapter.cite(provenum) + " and  f_blood is null and itzx!=1  ");
                    if (dbadapter.next())
                    {
                        //falg = true;//符合要求3
                        num = 3;
                    } else
                    {
                        //falg = false;//已注销或已申请2
                        num = 2;
                    }
                } else
                {
                    num = 4; //无此配犬证明
                }
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
        //   return falg;////1
        return num;
    }

    ///通过配犬证明号 返回 犬主人
    public static String getHost(String provenum) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        String vipid = null;
        try
        {
            dbadapter.executeQuery("select vipid from csvdogprove where provenum =" + dbadapter.cite(provenum));
            if (dbadapter.next())
            {
                return vipid = dbadapter.getString(1);
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
        return vipid;
    }

//在三联中提交时只修改 csvdogprove表中的 bloodtype和near字段 分别代表血统证书类型 近亲
    public static void setupdate(int bloodtype, String proveNum, String near, int csvbloodtype) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("update csvdogprove set bloodtype =" + bloodtype + ", near =" + dbadapter.cite(near) + " ,csvbloodtype =" + csvbloodtype + " where proveNum =" + dbadapter.cite(proveNum));
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    public static int count(String community, String sql) throws SQLException
    {
        int i = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            i = dbadapter.getInt("SELECT count(proveNum) FROM Csvdogprove WHERE community=" + dbadapter.cite(community) + sql);

        } finally
        {
            dbadapter.close();
        }
        return i;
    }

    /**
     * 新添加的方法 相关数据的 犬只出生率的 添加和修改
     */
    //1  添加相关数量
    /*/   public static void insertNum(int fdeath,int mdeath,int fabortion,int mabortion,int fdeathyou,int mdeathyou,int ffosterage,int mfosterage,int famount,int mamount,int fregister,int mregister,int itj,String proveNum)throws SQLException
//   {
//       DbAdapter dbadapter = new DbAdapter();
//       try
//       {
//           dbadapter .executeUpdate("");
//       }
//       catch(Exception ex)
//       {
//           throw new SQLException(ex.toString());
//       }
//       finally
//       {
//           dbadapter.close();
//       }
//   }
    */
   //2 修改相关数量

   public static void updateNum(int fdeath, int mdeath, int fabortion, int mabortion, int fdeathyou, int mdeathyou, int ffosterage, int mfosterage, int famount, int mamount, int fregister, int mregister, int itj, String proveNum) throws SQLException
   {
       DbAdapter dbadapter = new DbAdapter();
       itj = 1;
       try
       {
           dbadapter.executeUpdate("update csvdogprove set fdeath=" + fdeath + ",mdeath=" + mdeath + ",fabortion=" + fabortion + ",mabortion=" + mabortion + ",fdeathyou=" + fdeathyou + ",mdeathyou=" + mdeathyou + ",ffosterage=" + ffosterage + ",mfosterage=" + mfosterage + ",famount=" + famount +
                                   ",mamount=" + mamount + ",fregister=" + fregister + ",mregister=" + mregister + ",itj=" + itj + ", proveNum=" + dbadapter.cite(proveNum) + " where proveNum =" + dbadapter.cite(proveNum));
       } catch (Exception ex)
       {
           throw new SQLException(ex.toString());
       } finally
       {
           dbadapter.close();
       }
   }

    //财务确认到帐。
    public static void setItc(String provenum) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        Date date = new Date();
        // Csvdogprove.sdf.format(date)
        try
        {
            dbadapter.executeUpdate("update csvdogprove set itc=1 where  proveNum = " + dbadapter.cite(provenum));
            dbadapter.executeUpdate("update csvdog set addtime=" + dbadapter.cite(Csvdogprove.sdf.format(date)) + " where ite=1 and itb=1 and proveNum = " + dbadapter.cite(provenum));
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }


//修改总金额
    public static boolean setSprice(int sprice, String proveNum) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("update csvdogprove set sprice = " + sprice + " where proveNum =" + dbadapter.cite(proveNum));
            return true;
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }

    }


//添加判断父母血统号和耳号是否符合，并且判断这个犬只是否属于这个主人

    public static boolean Opinion(String earid, String blood, String hostname, int sex) throws SQLException
    {
        boolean falg = false;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select earid from Csvdog where earid =" + dbadapter.cite(earid) + "  and bloodlineletterid =" + dbadapter.cite(blood) + "  and sex =" + sex + " and member in (select member from profilelayer where firstname =" + dbadapter.cite(hostname) + ")");
            if (dbadapter.next())
            {
                falg = true;
                return falg;
            } else
            {
                falg = false;
                return falg;
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    //添加判断父母血统号和耳号是否符合，并且判断这个犬只是否属于这个主人  new
    public static boolean Opinion(String blood, String hostname, int sex) throws SQLException
    {
        boolean falg = false;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select earid from Csvdog where  bloodlineletterid =" + dbadapter.cite(blood) + "  and sex =" + sex + " and member in (select member from profilelayer where firstname =" + dbadapter.cite(hostname) + ")");
            if (dbadapter.next())
            {
                falg = true;
                return falg;
            } else
            {
                falg = false;
                return falg;
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

///根据id号，查询出这次配犬证明的单价
    public static BigDecimal pricenum(int id) throws SQLException
    {
        BigDecimal falg = null;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select price from csvdogprove where id =" + id);
            if (dbadapter.next())
            {
                return dbadapter.getBigDecimal(1, 2);
            } else
            {
                return null;
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    public static boolean freeOption(String provenum) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        String falg = null;
        try
        {
            dbadapter.executeQuery("select its from csvdogprovenum where id in (select id from csvdogprove where provenum =" + dbadapter.cite(provenum) + ")");
            if (dbadapter.next())
            {
                falg = dbadapter.getString(1);
                if (falg.equals("1"))
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
        }
    }

    ///
    public static void updateprovetype(String provenum, int bloodtype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Csvdogprove set bloodtype = " + bloodtype + "  where  provenum=" + db.cite(provenum));
        } finally
        {
            db.close();
        }
    }

//////累计的资金计算
    public static int getProveMoney(String community, String sql) throws SQLException
    {
        int num = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select sum(price) from csvdogprove  where id in (select id from csvdogprovenum where community=" + db.cite(community) + " " + sql + ") ");
            if (db.next())
            {
                num = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return num;
    }

    public int getItc()
    {
        return itc;
    }

    public int getSprice()
    {
        return sprice;
    }

    public int getItj()
    {
        return itj;
    }

    public String getNear()
    {
        return near;
    }

    public int getBloodtype()
    {
        return bloodtype;
    }

    public Date getFmprovetime()
    {
        return fmprovetime;
    }

    public String getFmprovetimeToString()
    {
        if (fmprovetime != null)
        {
            return Csvdogprove.sdf.format(fmprovetime);
        } else
        {
            return "";
        }
    }

    public String getF_blood()
    {
        return f_blood;
    }

    public String getItp()
    {
        return itp;
    }

    public Date geteEnsuredate()
    {
        return ensuredate;
    }

    public String getEnsuredateToString()
    {
        if (ensuredate == null)
            return "";
        return sdf.format(ensuredate);
    }

    public Date getCsvprovedate()
    {
        return csvprovedate;
    }

    public String getCsvprovedateToString()
    {
        if (csvprovedate == null)
            return "";
        return sdf.format(csvprovedate);
    }

    public int getId()
    {
        return id;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getEarid()
    {
        return earid;
    }

    public String getProvenum()
    {
        return proveNum;
    }

    public int getDrawmode()
    {
        return drawmode;
    }

    public int getDrawnums()
    {
        return drawnums;
    }

    public String getServicename()
    {
        return servicename;
    }

    public int getNumber()
    {
        return number;
    }

    public BigDecimal getPrice()
    {

        return price;
    }

    public static BigDecimal getPrice(String member, int id) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        BigDecimal price = new BigDecimal(0);
        try
        {
            db.executeQuery("select distinct(price) from Csvdogprove where vipid = " + db.cite(member) + "  and id =" + id);
            if (db.next())
            {
                price = db.getBigDecimal(1, 1);
            }
        } finally
        {
            db.close();
        }
        return price;
    }

    //修改配犬证明对应的血统证书的类型
    public static void UpdateBloodtype(int bloodtype, int csvbloodtype, String provenum) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update Csvdogprove set bloodtype=" + bloodtype + ",csvbloodtype=" + csvbloodtype + "  where provenum=" + db.cite(provenum));
        } finally
        {
            db.close();
        }
    }

    public static void setRemarkupdate(String provenum, String remarkprove) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update Csvdogprove set remarkprove=" + db.cite(remarkprove) + " where provenum=" + db.cite(provenum));
        } finally
        {
            db.close();
        }
    }

    public int getPrintnums()
    {
        return printnums;
    }

    public String getRemark()
    {
        return remark;
    }

    public String getServiceshow()
    {
        return serviceshow;
    }

    public int getSunnums()
    {
        return sunnums;
    }

    public String getVipid()
    {
        return vipid;
    }

    public String getIts()
    {
        return its;
    }

    public String getF_earid()
    {
        return f_earid;
    }

    public int getFnums()
    {
        return fnums;
    }

    public String getM_blood()
    {
        return m_blood;
    }

    public String getM_earid()
    {
        return m_earid;
    }

    public int getMnums()
    {
        return mnums;
    }

    public int getNums()
    {
        return nums;
    }

    public String getOldprovenum()
    {
        return oldprovenum;
    }

    public String getProveNum()
    {
        return proveNum;
    }

    public Date getEnsuredate()
    {
        return ensuredate;
    }

    public int getFabortion()
    {
        return fabortion;
    }

    public int getFamount()
    {
        return famount;
    }

    public int getFdeath()
    {
        return fdeath;
    }

    public int getFdeathyou()
    {
        return fdeathyou;
    }

    public int getFfosterage()
    {
        return ffosterage;
    }

    public int getFregister()
    {
        return fregister;
    }

    public int getMabortion()
    {
        return mabortion;
    }

    public int getMamount()
    {
        return mamount;
    }

    public int getMdeath()
    {
        return mdeath;
    }

    public int getMdeathyou()
    {
        return mdeathyou;
    }

    public int getMfosterage()
    {
        return mfosterage;
    }

    public int getMregister()
    {
        return mregister;
    }

    public int getItzx()
    {
        return itzx;
    }

    public int getItzxid()
    {
        return itzxid;
    }

    public String getBreedpeople()
    {
        return breedpeople;
    }

    public int getCsvbloodtype()
    {
        return csvbloodtype;
    }

    public String getRemarkprove()
    {
        return remarkprove;
    }

    public int getIthuishou()
    {
        return ithuishou;
    }

    /*******
     *2008年6月4日11:33:51
     **********/
    public static int getFalse(String bloodlineletterid, String earid, String member, String provenum) throws SQLException
    {
        int falg = 0; // 0 耳号与血统证书号输入有误,
        DbAdapter db = new DbAdapter();
        try
        {

            if (member != null && member.length() > 0)
            {
                db.executeQuery("SELECT earid FROM Csvdog WHERE bloodlineletterid=" + db.cite(bloodlineletterid) + " and earid=" + db.cite(earid)); //判断犬只血统证书号和耳号是否符合
                if (db.next())
                {
                    db.executeQuery("SELECT earid FROM Csvdog WHERE bloodlineletterid=" + db.cite(bloodlineletterid) + " and earid=" + db.cite(earid) + " and member=" + db.cite(member)); //判断犬只血统证书号和耳号是否符合
                    if (db.next())
                    {
                        db.executeQuery("Select provenum from Csvdogprove where provenum=" + db.cite(provenum) + " and vipid=" + db.cite(member));
                        if (db.next())
                        {
                            falg = 1; // 1 符合要求且配犬证明属于公犬主人,
                        } else
                        {
                            falg = 2; // 2 符合要求,配犬证明不属于公犬主人,
                        }
                    } else
                    {
                        db.executeQuery("Select provenum from Csvdogprove where provenum=" + db.cite(provenum) + " and vipid=" + db.cite(member));
                        if (db.next())
                        {
                            falg = 3; // 3 犬只不属于此人，配犬证明属于此人,
                        } else
                        {
                            falg = 4; // 4  犬只不属于此人，配犬证明属于不此人,
                        }
                    }
                } else
                {
                    falg = 0; //不符合要求耳号和血统证书号不符合
                }

            } else
            {
                db.executeQuery("SELECT earid FROM Csvdog WHERE bloodlineletterid=" + db.cite(bloodlineletterid) + " and earid=" + db.cite(earid)); //判断犬只血统证书号和耳号是否符合
                if (db.next())
                {
                    falg = 5; //耳号和血统证书号符合,其他信息无！
                } else
                {
                    falg = 0; //不符合要求耳号和血统证书号不符合
                }

            }

        } finally
        {
            db.close();
        }
        return falg;
    }

    public static int getFalse_m(String bloodlineletterid, String earid,int sex,String datetimes) throws SQLException
    {
        int falg = 0; // 0 耳号与血统证书号输入有误,
        DbAdapter db = new DbAdapter();
        Date datesprove = new Date();
        Date dates = new Date();
        Calendar calendar = Calendar.getInstance(); ///要配犬的日期
        try
        {
            try
            {
                datesprove = Csvdogprove.sdf.parse(datetimes);
                calendar.setTime(datesprove);
                calendar.add(calendar.MONTH, -3);
            }
            catch (ParseException ex)
            {
                ex.printStackTrace();
            }
            if(sex==1)
            {
                db.executeQuery("SELECT earid FROM Csvdog WHERE bloodlineletterid=" + db.cite(bloodlineletterid) + " and earid=" + db.cite(earid)); //判断犬只血统证书号和耳号是否符合
                if(db.next())
                {
                    db.executeQuery("SELECT max(birthdate) FROM Csvdog WHERE m_bloodlineletterid=" + db.cite(bloodlineletterid)); //判断犬只血统证书号和耳号是否符合
                    if(db.next())
                    {
                       dates = db.getDate(1);
                       if(dates.compareTo(calendar.getTime())>0)//出生日期 大于 配犬日期 -4个月
                       {
                           falg = 1; //4个月内生过犬只
                       }
                       else
                       {
                           falg = 2; //符合要求
                       }
                    }

                }
                else
                {
                     falg = 0; //不符合要求耳号和血统证书号不符合
                }

            }
        }
        finally
        {
            db.close();
        }
        return falg;
    }

}
