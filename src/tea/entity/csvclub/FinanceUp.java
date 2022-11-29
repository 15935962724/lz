package tea.entity.csvclub;

import java.math.*;
import java.sql.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import tea.entity.member.*;


/**
 * 会员升级的操作 *
 * */
public class FinanceUp  extends Entity
{
    private int id ;//自动的ID
    private String member;//会员id
    private String community;//社区
    private Date datecnt;//财务确认
    private Date time_z;///转账日期
    private BigDecimal regcharge;//申请费用
    private BigDecimal fuwucharge;//服务费用
    private Date regdate;//申请时间
    private String handlemember;//提交确认的管理员
    private String Csvcluboutlay_new;//新会员编号
    private String Csvcluboutlay_old;//原有会员编号
    private int year;//年代
    private int type;//类型////0，其他，1 会员续费，2会员升级
    private int defray;///支付的类型~支付宝，汇款，pos，现金
    private String remark;//备注
    private int chargtype;//财务接受的状态，0财务未确认，1财务已确认
    private Date time_good;//有效期
    private int csvjoinoutlayid;//会员升级的类型,Csvjoinoutlayid,membernumberold
    private int up_type;//选择会员续费的类型。





    private static Cache _cache = new Cache(100);
    private boolean exists;

    public static final String UP_TYPES[]={"---","会员续费","犬舍续费"};


    public FinanceUp(int id)throws SQLException
    {
        this.id=id;
        load();
    }
    public static FinanceUp find (int id)throws SQLException
    {
        return new FinanceUp(id);
    }
    public void load()throws SQLException
    {
        DbAdapter db  = new  DbAdapter();
        try
        {
            db.executeQuery("Select id ,member,community,datecnt,  time_z,regcharge,fuwucharge,regdate,handlemember,Csvcluboutlay_new,Csvcluboutlay_old,year,type,defray,remark,chargtype,time_good,csvjoinoutlayid,up_type from FinanceUp where id="+id);
            if(db.next())
            {
                id = db.getInt(1);
                member = db.getString(2);
                community = db.getString(3);
                datecnt = db.getDate(4);
                time_z = db.getDate(5);
                regcharge = db.getBigDecimal(6,2);
                fuwucharge = db.getBigDecimal(7,2);
                regdate = db.getDate(8);
                handlemember = db.getString(9);
                Csvcluboutlay_new = db.getString(10);
                Csvcluboutlay_old = db.getString(11);
                year = db.getInt(12);
                type = db.getInt(13);
                defray = db.getInt(14);
                remark = db.getString(15);
                chargtype=db.getInt(16);
                time_good=db.getDate(17);
                csvjoinoutlayid= db.getInt(18);
                up_type=db.getInt(19);

                exists = true;
            }
            else
            {
                exists = false;
            }
        }
        finally
        {
            db.close();
        }
    }
    public static void create(String member,String community,Date datecnt,Date time_z,BigDecimal regcharge,BigDecimal fuwucharge,Date regdate,String handlemember,String Csvcluboutlay_new,String Csvcluboutlay_old,int year,int type,int defray,String remark,int chargtype,Date time_good,int up_type) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("insert into FinanceUp (member,community,datecnt,  time_z,regcharge,fuwucharge,regdate,handlemember,Csvcluboutlay_new,Csvcluboutlay_old,year,type,defray,remark,chargtype,time_good,up_type)values ("+db.cite(member)+","+db.cite(community)+","+db.cite(datecnt)+","+db.cite(time_z)+"  ,"+regcharge+","+fuwucharge+","+db.cite(regdate)+","+db.cite(handlemember)+","+db.cite(Csvcluboutlay_new)+","+db.cite(Csvcluboutlay_old)+","+year+","+type+","+defray+","+db.cite(remark)+","+chargtype+","+db.cite(time_good)+","+up_type+")");
        }
        finally
        {
            db.close();
        }
    }

    public static void creatego(String member,String community,Date datecnt,Date time_z,BigDecimal regcharge,BigDecimal fuwucharge,Date regdate,String handlemember,String Csvcluboutlay_new,String Csvcluboutlay_old,int year,int type,int defray,String remark,int chargtype,Date time_good,int csvjoinoutlayid) throws SQLException
   {
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeUpdate("insert into FinanceUp (member,community,datecnt,  time_z,regcharge,fuwucharge,regdate,handlemember,Csvcluboutlay_new,Csvcluboutlay_old,year,type,defray,remark,chargtype,time_good,csvjoinoutlayid)values ("+db.cite(member)+","+db.cite(community)+","+db.cite(datecnt)+","+db.cite(time_z)+"  ,"+regcharge+","+fuwucharge+","+db.cite(regdate)+","+db.cite(handlemember)+","+db.cite(Csvcluboutlay_new)+","+db.cite(Csvcluboutlay_old)+","+year+","+type+","+defray+","+db.cite(remark)+","+chargtype+","+db.cite(time_good)+","+csvjoinoutlayid+")");
       }
       finally
       {
           db.close();
       }
   }

    public static void set(Date time_z,BigDecimal fuwucharge,int year,int defray,String remark,int type,int id)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update FinanceUp set time_z="+db.cite(time_z)+",fuwucharge="+fuwucharge+",year="+year+",defray="+defray+",remark="+db.cite(remark)+",type="+type+" where id ="+id);
        }
        finally
        {
            db.close();
        }
    }


    public static int count(String community, String sql) throws SQLException
    {
        int count = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT COUNT(id) FROM FinanceUp  WHERE community=" + dbadapter.cite(community) + sql);
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

    public static java.util.Enumeration findByCommunity(String community, String sql, int pos, int pageSize) throws SQLException
   {
       java.util.Vector vector = new java.util.Vector();
       DbAdapter dbadapter = new DbAdapter();
       try
       {
           dbadapter.executeQuery("SELECT  id FROM FinanceUp WHERE community=" + DbAdapter.cite(community) + sql);

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
/*************
    * 判断信息是否重复添加
    * */
    public static boolean getFalg(String member,int type,int year)throws SQLException
    {
        boolean falg =false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select id from financeUp where member="+db.cite(member)+" and type="+type+" and year="+year);
            if(db.next())
            {
                falg= true;
            }
            else
            {
                falg= false;
            }
        }
        finally
        {
            db.close();
        }
        return falg;
    }

/*******
     *财务确认续费*
     * ********/
    public static void EnterCharge(int id,String handlemember)throws SQLException
    {
        Date dates = new Date();
        DbAdapter db = new DbAdapter();
        try
        {//time_goog,chargtype,handlemember,datecnt

            FinanceUp  obj = FinanceUp.find(id);
            obj.getMember();
            ProfileCsv procsv = ProfileCsv.find( obj.getMember());
            Csvjoinoutlay joobj = Csvjoinoutlay.find(procsv.getCsvjoinoutlayid());
            db.executeUpdate("Update financeUp set time_good="+db.cite(joobj.getTime_jToString())+", handlemember="+db.cite(handlemember)+",chargtype=1,datecnt="+db.cite(dates)+"  where id="+id);
            procsv.setMembertype(0);
        }
        finally
        {
            db.close();
        }
    }
    /****
     *
     *
     *
     * ******/
    public static void EnterChargeGo(int id,String handlemember)throws SQLException
   {
       Date dates = new Date();
       DbAdapter db = new DbAdapter();

       int oldtype = 0;
       int newtype = 0;
       String oldstrtype = null;
       String newstrtype = null;
       try
       {//time_goog,chargtype,handlemember,datecnt

           FinanceUp  obj = FinanceUp.find(id);
           obj.getMember();
           ProfileCsv procsv = ProfileCsv.find( obj.getMember());
           oldtype=procsv.getCsvjoinoutlayid();
           Csvjoinoutlay joobj = Csvjoinoutlay.find(obj.getCsvjoinoutlayid());
           newtype =obj.getCsvjoinoutlayid();
           db.executeUpdate("Update financeUp set Csvcluboutlay_old="+db.cite(procsv.getMembernumber())+",time_good="+db.cite(joobj.getTime_jToString())+", handlemember="+db.cite(handlemember)+",chargtype=1,datecnt="+db.cite(dates)+"  where id="+id);
           procsv.setMembertype(0);
           procsv.setCsvjoinoutlayid(obj.getCsvjoinoutlayid());
           if (newtype == 10 || newtype == 16)
           {
               newstrtype = "A";
           } else if (newtype == 11)
           {
               newstrtype = "B";
           } else if (newtype == 14)
           {
               newstrtype = "C";
           } else if (newtype == 15)
           {
               newstrtype = "D";
           }
           if (oldtype == 10 || oldtype == 16)
           {
               oldstrtype = "A";
           } else if (oldtype == 11)
           {
               oldstrtype = "B";
           } else if (oldtype == 14)
           {
               oldstrtype = "C";
           } else if (oldtype == 15)
           {
               oldstrtype = "D";
           }
           db.executeUpdate("update Profilecsv set Csvjoinoutlayid="+newtype+",membernumber=replace(membernumber,"+db.cite(oldstrtype)+","+db.cite(newstrtype)+") where member="+db.cite(obj.getMember()));
       }
       finally
       {
           db.close();
       }
   }


    public String getCommunity()
    {
        return community;
    }

    public Date getDatecnt()
    {
        return datecnt;
    }
    public String getDatecntToString()
    {
        if(datecnt==null)
        {
            return "";
        }
        else
        {
            return Finance.sdf.format(datecnt);
        }
    }
    public int getDefray()
    {
        return defray;
    }

    public String getHandlemember()
    {
        return handlemember;
    }

    public boolean isExists()
    {
        return exists;
    }

    public BigDecimal getFuwucharge()
    {
        return fuwucharge;
    }

    public int getId()
    {
        return id;
    }

    public String getMember()
    {
        return member;
    }

    public BigDecimal getRegcharge()
    {
        return regcharge;
    }

    public Date getRegdate()
    {
        return regdate;
    }



    public String getRegdateToString()
    {
        if(regdate==null)
        {
            return "";
        }
        else
        {
            return  FinanceUp.sdf.format(regdate);
        }
    }

    public Date getTime_z()
    {
        return time_z;
    }
    public String getTime_zToString()
    {
        if(time_z==null)
        {
            return "";
        }
        else
        {
            return FinanceUp.sdf.format(time_z);
        }
    }


    public int getType()
    {
        return type;
    }

    public int getYear()
    {
        return year;
    }

    public String getRemark()
    {
        return remark;
    }

    public Date getTime_good()
    {
        return time_good;
    }
    public String getTime_goodToString()
    {
        if(time_good==null)
        {
            return "";
        }
        else
        {
            return FinanceUp.sdf.format(time_good);
        }
    }
    public int getChargtype()
    {
        return chargtype;
    }

    public int getCsvjoinoutlayid()
    {
        return csvjoinoutlayid;
    }

    public int getUp_type()
    {
        return up_type;
    }

    public String getCsvcluboutlay_old()
    {
        return Csvcluboutlay_old;
    }

    public String getCsvcluboutlay_new()
    {
        return Csvcluboutlay_new;
    }
    public  void  setCsvjoinoutlayid(int csvjoinoutlayid)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update financeUp set csvjoinoutlayid ="+csvjoinoutlayid+" where id ="+id);
        }
        finally
        {
            db.close();
        }
    }

    public static void setUp_type(int up_type,int id)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update FinanceUp set up_type="+up_type+" where id ="+id);
        }
        finally
        {
            db.close();
        }
    }



}
