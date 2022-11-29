package tea.entity.csvclub;

import java.sql.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class CsvdogTransmit extends Entity
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
    private Date datereg; //注册时间
    private Date datecnt; //财务确认时间
    private int itj; //标识交费没有交费，0 是等待交费，1是已经交费
    //*****需求变动添加的新字段2008- 04- 10****//
    private String datezz; //转做日期
    private Date dateemail; //邮寄时间
    private String remark; //备注
    private int hdint; // 是否做髋肘 0否  1是
    private int bloodtype; //血统证书总类
    private int csvbloodtype; //白色血统证书 ，类型
    private int huanfa; //0 , 1 , 2    如果是0不如需财务确认。 1 换发，2补做新的血统证书号


    private boolean exists;

    public static final String HUANFAS[] =
            {"----", "换发证书", "补做新证书"};

    public static final String ITJS[] =
            {"未接受", "等待交费", "已交费"};
    public static final String MEND[] =
            {"-------", "遗失", "损坏", "其他原因"};
    public static final String STATE[] =
            {"-------", "未处理", "不办理", "财务确认"};
    //未接受/已交费
    public static final String STATES[] =
            {"未处理", "已交费"};

    public CsvdogTransmit(String earid) throws SQLException
    {
        this.earid = earid;
        Load();
    }

    public static CsvdogTransmit find(String earid) throws SQLException
    {
        return new CsvdogTransmit(earid);
    }

    public static CsvdogTransmit find(String oldblood, int ix) throws SQLException
    {
        return new CsvdogTransmit(oldblood, ix);

    }

    public CsvdogTransmit(String oldblood, int ix) throws SQLException
    {
        this.oldblood = oldblood;
        Load_blood();
        //  this
    }

    public CsvdogTransmit(int id) throws SQLException
    {
        this.id = id;
        Loadid();
    }

    public static CsvdogTransmit find(int id) throws SQLException
    {
        return new CsvdogTransmit(id);
    }

    public void Loadid() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select id,earid,oldblood,mendwhys,other,member,state,mailnum,community,newblood,itj,datereg,datecnt,datezz,remark,hdint,dateemail,bloodtype,csvbloodtype,huanfa from CsvdogTransmit where id =" + id);
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
                datereg = dbadapter.getDate(12);
                datecnt = dbadapter.getDate(13);
                datezz = dbadapter.getString(14);
                remark = dbadapter.getString(15);
                hdint = dbadapter.getInt(16);
                dateemail = dbadapter.getDate(17);
                bloodtype = dbadapter.getInt(18); //血统证书总类
                csvbloodtype = dbadapter.getInt(19); //白色血统证书 ，类型
                huanfa = dbadapter.getInt(20); //0 , 1 , 2    如果是0不如需财务确认。 1 换发，2补做新的血统证书号

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


//读取  CsvdogTransmit 表中的全部值
    public void Load() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select id,earid,oldblood,mendwhys,other,member,state,mailnum,community,newblood,itj,datereg,datecnt,datezz,remark,hdint,dateemail,bloodtype,csvbloodtype,huanfa from CsvdogTransmit where earid =" + dbadapter.cite(earid));
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
                datereg = dbadapter.getDate(12);
                datecnt = dbadapter.getDate(13);
                datezz = dbadapter.getString(14);
                remark = dbadapter.getString(15);
                hdint = dbadapter.getInt(16);
                dateemail = dbadapter.getDate(17);
                bloodtype = dbadapter.getInt(18); //血统证书总类
                csvbloodtype = dbadapter.getInt(19); //白色血统证书 ，类型
                huanfa = dbadapter.getInt(20); //0 , 1 , 2    如果是0不如需财务确认。 1 换发，2补做新的血统证书号
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

    public void Load_blood() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select id,earid,oldblood,mendwhys,other,member,state,mailnum,community,newblood,itj,datereg,datecnt,datezz,remark,hdint,dateemail,bloodtype,csvbloodtype,huanfa from CsvdogTransmit where oldblood =" + dbadapter.cite(oldblood));
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
                datereg = dbadapter.getDate(12);
                datecnt = dbadapter.getDate(13);
                datezz = dbadapter.getString(14);
                remark = dbadapter.getString(15);
                hdint = dbadapter.getInt(16);
                dateemail = dbadapter.getDate(17);
                bloodtype = dbadapter.getInt(18); //血统证书总类
                csvbloodtype = dbadapter.getInt(19); //白色血统证书 ，类型
                huanfa = dbadapter.getInt(20); //0 , 1 , 2    如果是0不如需财务确认。 1 换发，2补做新的血统证书号
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


///插入CsvdogTransmit表的申请记录
    public static void create(String earid, String oldblood, int mendwhys, String other, String member, int state, String mailnum, String newblood, String community) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        Date datereg = new Date();

        int itj = 0; //标识，0标识没有交费，1标识已经缴费
        try
        {
            dbadapter.executeUpdate("insert into CsvdogTransmit(earid,oldblood,mendwhys,other,member,state,mailnum,newblood,community,itj,datereg) values (" + dbadapter.cite(earid) + "," + dbadapter.cite(oldblood) + "," + mendwhys + "," + dbadapter.cite(other) + "," + dbadapter.cite(member) + "," + state + "," + dbadapter.cite(mailnum) + "," + dbadapter.cite(newblood) + "," + dbadapter.cite(community) + "," + itj + "," + dbadapter.cite(datereg) + ") ");
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    //修改数据

    public static void set(String earid, String oldblood, int mendwhys, String other, String member, int state, String mailnum, int id) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("update CsvdogTransmit set earid =" + dbadapter.cite(earid) + ",oldblood=" + dbadapter.cite(oldblood) + ",mendwhys=" + mendwhys + ",other=" + dbadapter.cite(other) + ",member=" + dbadapter.cite(member) + ",state=" + state + ",mailnum=" + dbadapter.cite(mailnum) + "  where id =" + id);
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
            dbadapter.executeQuery("SELECT id FROM CsvdogTransmit WHERE community=" + DbAdapter.cite(community) + sql);
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
            dbadapter.executeQuery("select count(id) from CsvdogTransmit where community =" + dbadapter.cite(community) + sql);
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
            dbadapter.executeQuery("select sex from csvdog where bloodlineletterid="+dbadapter.cite(oldblood));
            if(dbadapter.next())
            {
                int sex =dbadapter.getInt(1);
                if (sex == 0)
                {

                    dbadapter.executeUpdate("update csvdog set bloodlineletterid = " + dbadapter.cite(newblood) + " , old_bloodlineletterid = " + dbadapter.cite(oldblood) + " where bloodlineletterid = " + dbadapter.cite(oldblood));
                    dbadapter.executeUpdate("update csvdog set  f_bloodlineletterid = " + dbadapter.cite(newblood) + " where f_bloodlineletterid = " + dbadapter.cite(oldblood));
                } else if (sex == 1)
                {

                    dbadapter.executeUpdate("update csvdog set bloodlineletterid = " + dbadapter.cite(newblood) + " , old_bloodlineletterid = " + dbadapter.cite(oldblood) + " where bloodlineletterid = " + dbadapter.cite(oldblood));
                    dbadapter.executeUpdate("update csvdog set  m_bloodlineletterid = " + dbadapter.cite(newblood) + " where m_bloodlineletterid = " + dbadapter.cite(oldblood));
                }
                /*修改赛事表中的血统证书号
                 */
                dbadapter.executeUpdate("update csvrundog set blood="+dbadapter.cite(newblood)+" where blood="+dbadapter.cite(oldblood));
            }
       } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

//修改确认交费的方法  新 2008-04-10
//修改确认交费的方法  新 2008-04-17
//修改确认交费的方法  新 2008-04-23
//修改确认交费的方法  新 2008年5月28日9:41:59
    public static void getItjprice(int id, String oldblood) throws SQLException
    {
        String newblood = null;
        DbAdapter dbadapter = new DbAdapter();
        try
        {

            Date dates = new Date();
            int itforeign = 0;
            int bloodtype = 0;
            Csvdog dogobj = Csvdog.find_blood(oldblood, "");
            CsvdogTransmit csvdogts = CsvdogTransmit.find(id);
            csvdogts.getCsvbloodtype();
            csvdogts.getHuanfa(); //1，换发，2 补做
            bloodtype = csvdogts.getBloodtype(); //证书的类型
            dogobj.getForeignloginletterid();
            if (csvdogts.getHuanfa() == 1) ///换发
            {
                if (oldblood.startsWith("CSZW")) //////以前国外的证书补做生成新的国外证书
                {
                    newblood = "CSZ" + oldblood.substring(4);
                    dbadapter.executeUpdate("update Csvdogtransmit set datecnt =" + dbadapter.cite(dates) + " , itj =2 ,state = 3,newblood=" + dbadapter.cite(newblood) + " where id =" + id);
                    CsvdogTransmit.getMarknewblood(newblood, oldblood);
                    Csvdogprove.UpdateBloodtype(bloodtype, csvdogts.getCsvbloodtype(), dogobj.getProvenum());
                }
            } else if (csvdogts.getHuanfa() == 2) ///补做
            {
                if (oldblood.startsWith("CSZ8")) //////以前国外的证书补做生成新的国外证书
                {
                    newblood = Csvdog.getMarkblood(1, 1, 1);
                    dbadapter.executeUpdate("update Csvdogtransmit set datecnt =" + dbadapter.cite(dates) + " , itj =2 ,state = 3,newblood=" + dbadapter.cite(newblood) + " where id =" + id);
                    CsvdogTransmit.getMarknewblood(newblood, oldblood);
                    Csvdogprove.UpdateBloodtype(bloodtype, csvdogts.getCsvbloodtype(), dogobj.getProvenum());
                }
                else
                {
                    newblood = Csvdog.getMarkblood(bloodtype, 0, 1);
                    dbadapter.executeUpdate("update Csvdogtransmit set datecnt =" + dbadapter.cite(dates) + " , itj =2 ,state = 3,newblood=" + dbadapter.cite(newblood) + " where id =" + id);
                    CsvdogTransmit.getMarknewblood(newblood, oldblood);
                    Csvdogprove.UpdateBloodtype(bloodtype, csvdogts.getCsvbloodtype(), dogobj.getProvenum());
                }
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }

    }

    //判断数据数否存在
    public static boolean Optionts(int id) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select id from CsvdogTransmit  where id =" + id);
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

///判断血统号和耳号是否对应
    public static boolean Optiontearid(String earid, String blood, String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select id from Csvdog  where earid =" + db.cite(earid) + " and bloodlineletterid =" + db.cite(blood) + " and member = " + db.cite(member));
             //System.out.print("select id from Csvdog  where earid =" + db.cite(earid) + " and bloodlineletterid =" + db.cite(blood) + " and member = " + db.cite(member));
            if (db.next())
            {
                return true;
            } else
            {
                return false;
            }
        } finally
        {
            db.close();
        }
    }

    public static void updataHuanfa(int id, int bloodtype, int csvbloodtype, int huanfa) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update CsvdogTransmit set bloodtype=" + bloodtype + ",csvbloodtype=" + csvbloodtype + ",huanfa=" + huanfa + "  where id =" + id);
        } finally
        {
            db.close();
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

    public Date getDatecnt()
    {
        return datecnt;
    }

    public Date getDatereg()
    {
        return datereg;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getRemark()
    {
        return remark;
    }

    public int getHdint()
    {
        return hdint;
    }

    public String getDatezz()
    {
        return datezz;
    }

    public Date getDateemail()
    {
        return dateemail;
    }

    public int getHuanfa()
    {
        return huanfa;
    }

    public int getCsvbloodtype()
    {
        return csvbloodtype;
    }

    public int getBloodtype()
    {
        return bloodtype;
    }

    public String getDateregToString()
    {
        if (datereg == null)
        {
            return "";
        }
        return CsvdogTransmit.sdf.format(datereg);
    }

    public String getDatecntToString()
    {
        if (datecnt == null)
        {
            return "";
        }
        return CsvdogTransmit.sdf.format(datecnt);
    }

}
