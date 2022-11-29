package tea.entity.league;

import java.math.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class LeagueShopImprest extends Entity
{
    private int id;
    private int lsid; //加盟店id,lsid,yfmoney,regmember,member,zzdate
    private BigDecimal yfmoney; //
    private Date regdate;
    private String regmember;
    private Date zzdate; //转账时间
    private String community;
    private int payment; //支付方式
    private int type; // 0 存入 1提取`
    private int lsistatic; /** 0应付金额，1进货单 and lsistatic=1 and type=1 and and audittype=1，2冻结金额，3配送金额  and lsistatic=3 and type=1 and audittype=1，4返还金额，5运费金额,6实付金额   ********/
    private int audittype; // 0没有审核，1审核通过。
    private String info;
	private String summary;
    private boolean exists;


    public static final String[] PAYMENT =
            {"-----","现金","刷卡","其他"};
    public static final String[] TYPES =
            {"存入","提取"};
    public static final String[] LSISTATIC =
            {"应付金额","进货单","冻结金额","配送金额","返还金额","运费金额","实付金额"};
    public static final String[] AUDITTYPE =
            {"未审核","已审核"};
    public static LeagueShopImprest find(int id) throws SQLException
    {
        return new LeagueShopImprest(id);
    }

    public LeagueShopImprest(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select id,lsid,yfmoney,regdate,regmember,zzdate,community,payment,type,lsistatic,audittype,info,summary from LeagueShopImprest where id=" + id);
            if(db.next())
            {
                int j = 1;
                id = db.getInt(j++);
                lsid = db.getInt(j++);
                yfmoney = db.getBigDecimal(j++,2);
                regdate = db.getDate(j++);
                regmember = db.getString(j++);
                zzdate = db.getDate(j++);
                community = db.getString(j++);
                payment = db.getInt(j++);
                type = db.getInt(j++);
                lsistatic = db.getInt(j++);
                audittype = db.getInt(j++);
                info = db.getString(j++);
				summary =db.getString(j++);
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

    public static void set(int id,int lsid,BigDecimal yfmoney,Date regdate,String regmember,Date zzdate,String community,int payment,int type,int lsistatic,int audittype,String info,String summary) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            Date date = new Date();
            db.executeQuery("Select id from LeagueShopImprest where id=" + id);
            if(db.next())
            {
                db.executeUpdate("Update LeagueShopImprest set lsid=" + lsid + ",yfmoney=" + yfmoney + ",regmember=" + db.cite(regmember) + ",zzdate=" + db.cite(zzdate) + ",community=" + db.cite(community) + ",payment=" + payment + ",lsistatic=" + lsistatic + ",type=" + type + ",audittype=" + audittype + ",info=" + db.cite(info) + ",summary="+db.cite(summary)+"  where id=" + id);
            } else
            {
                db.executeUpdate("Insert into LeagueShopImprest (lsid,yfmoney,regdate,regmember,zzdate,community,payment,type,lsistatic,audittype,info,summary)values(" + lsid + "," + yfmoney + "," + db.cite(date) + "," + db.cite(regmember) + "," + db.cite(zzdate) + "," + db.cite(community) + "," + payment + "," + type + "," + lsistatic + "," + audittype + "," + db.cite(info) + ","+db.cite(summary)+")");
            }
        } finally
        {
            db.close();
        }
    }

    public static Enumeration findByCommunity(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM LeagueShopImprest WHERE community=" + db.cite(community) + sql,pos,size);
            while(db.next())
            {
                v.addElement(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static int count(String community,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int num = 0;
        try
        {
            db.executeQuery("Select count(id) from LeagueShopImprest where 1=1 " + sql);
            if(db.next())
            {

                num = db.getInt(1);
                return num;
            } else
            {
                return num;
            }
        } finally
        {
            db.close();
        }
    }

    public static void delete(int id) throws SQLException
    {
        DbAdapter db = new DbAdapter();

        try
        {
            db.executeUpdate("Delete  LeagueShopImprest where id= " + id);

        } finally
        {
            db.close();
        }
    }

    public static BigDecimal SumMoney(String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        BigDecimal bb = new BigDecimal("0");
        try
        {
            db.executeQuery("Select sum(yfmoney) from LeagueShopImprest where 1=1 " + sql);
//			System.out.println("Select sum(yfmoney) from LeagueShopImprest where 1=1 " + sql);
            if(db.next())
            {
                bb = db.getBigDecimal(1,2);
            } else
            {
                bb = new BigDecimal("0");
            }
        } finally
        {
            db.close();
        }
        return bb;
    }


    //期初余额
    public static BigDecimal firstMoney(String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        BigDecimal cr = new BigDecimal("0");
        BigDecimal hh = new BigDecimal("0");
        try
        {
			/** 0应付金额，1进货单 and lsistatic=1 and type=1 and and audittype=1，2冻结金额，3配送金额  and lsistatic=3 and type=1 and audittype=1，4返还金额，5运费金额,6实付金额   ********/
            db.executeQuery("Select sum(yfmoney) from LeagueShopImprest where type=0  and (lsistatic=0 or lsistatic=4 or lsistatic=1 )  and audittype=1 " + sql);//应付+ 返回+ 退货单
            if(db.next())
            {
                cr = db.getBigDecimal(1,2);
            } else
            {
                cr = new BigDecimal("0");
            }
            db.executeQuery("Select sum(yfmoney) from LeagueShopImprest where type=1   and ( lsistatic=2 or lsistatic=1 or lsistatic=5  ) and audittype=1 " + sql);//进货单+冻结+
            if(db.next())
            {
                hh = db.getBigDecimal(1,2);
            } else
            {
                hh = new BigDecimal("0");
            }

        } finally
        {
            db.close();
        }
        return cr.subtract(hh);
    }

    //期初余额
    public static BigDecimal dispatchMoney(String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        BigDecimal cr = new BigDecimal("0");
        BigDecimal hh = new BigDecimal("0");
        try
        {
            /** 0应付金额，1进货单 and lsistatic=1 and type=1 and and audittype=1，2冻结金额，3配送金额  and lsistatic=3 and type=1 and audittype=1，4返还金额，5运费金额,6实付金额   ********/
            db.executeQuery("Select sum(yfmoney) from LeagueShopImprest where type=0  and lsistatic=3  and audittype=1 " + sql); //3配送金额
            if(db.next())
            {
                cr = db.getBigDecimal(1,2);
            } else
            {
                cr = new BigDecimal("0");
            }
            db.executeQuery("Select sum(yfmoney) from LeagueShopImprest where type=1   and lsistatic=3 and audittype=1 " + sql); //3配送销售单
            if(db.next())
            {
                hh = db.getBigDecimal(1,2);
            } else
            {
                hh = new BigDecimal("0");
            }

        } finally
        {
            db.close();
        }
        return cr.subtract(hh);
    }

    public static int getIdnew(String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int ids = 0;
        try
        {
            db.executeQuery("Select max(id) from LeagueShopImprest where 1=1" + sql);
            if(db.next())
            {
                ids = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return ids;
    }

    public static BigDecimal lastMoney(String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        BigDecimal qq = new BigDecimal("0");
        BigDecimal hh = new BigDecimal("0");
        try
        {
            db.executeQuery("Select sum(yfmoney) from LeagueShopImprest where type=0 " + sql);
            if(db.next())
            {
                qq = db.getBigDecimal(1,2);
            } else
            {
                qq = new BigDecimal("0");
            }
            db.executeQuery("Select sum(yfmoney) from LeagueShopImprest where type=1 " + sql);
            if(db.next())
            {
                hh = db.getBigDecimal(1,2);
            } else
            {
                hh = new BigDecimal("0");
            }

        } finally
        {
            db.close();
        }
        return qq.subtract(hh);
    }

    //审核通过。
    public static void setAudittype(int id) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            String str = "id";
            LeagueShopImprest lsobj = LeagueShopImprest.find(id);
            if(lsobj.getAudittype() == 0)
            {
                lsobj.getLsistatic();
                if(lsobj.getLsistatic() == 0 && lsobj.getType() == 0) //添加应付款
                {
                    LeagueShop.setUpdatemoney(lsobj.getLsid(),lsobj.getYfmoney(),0);
                }
				if(lsobj.getLsistatic() == 0 && lsobj.getType() == 1) //添加应付款
				{
					LeagueShop.setUpdatemoney(lsobj.getLsid(),lsobj.getYfmoney(),1);
				}

                if(lsobj.getLsistatic() == 1) //1进货单
                {
//					str="costmoney";
                }
                if(lsobj.getLsistatic() == 2) //2冻结金额
                {
                    str = "block";
                    LeagueShop.setmoney(lsobj.getLsid(),lsobj.getYfmoney(),0,str);
                    LeagueShop.setUpdatemoney(lsobj.getLsid(),lsobj.getYfmoney(),1);
                }
                if(lsobj.getLsistatic() == 3) //3配送金额
                {
                    str = "dispatchmoney";
                    LeagueShop.setmoney(lsobj.getLsid(),lsobj.getYfmoney(),lsobj.getType(),str);
                }
                if(lsobj.getLsistatic() == 4) //4返还金额
                {
                    str = "returnmoney";
                    LeagueShop.setmoney(lsobj.getLsid(),lsobj.getYfmoney(),0,str);
                    LeagueShop.setUpdatemoney(lsobj.getLsid(),lsobj.getYfmoney(),0);
                }
                if(lsobj.getLsistatic() == 5) //5运费金额
                {
                    str = "faremoney";
                    LeagueShop.setmoney(lsobj.getLsid(),lsobj.getYfmoney(),0,str);
                    LeagueShop.setUpdatemoney(lsobj.getLsid(),lsobj.getYfmoney(),1);
                }
                if(lsobj.getLsistatic()==6&&lsobj.getType()==0) //6实付金额
                {
                    str = "costmoney";
                    LeagueShop.setmoney(lsobj.getLsid(),lsobj.getYfmoney(),lsobj.getType(),str);
                }
				if(lsobj.getLsistatic()==6&&lsobj.getType()==1) //6实付金额
				{
					str = "costmoney";
					LeagueShop.setmoney(lsobj.getLsid(),lsobj.getYfmoney(),lsobj.getType(),str);
				}

                db.executeUpdate("Update LeagueShopImprest set audittype=1 where id=" + id);
            } else
            {
                if(lsobj.getLsistatic() == 2) //2冻结金额
                {
                    str = "block";
                    if(lsobj.getAudittype() == 1)
                    {
                        LeagueShop.setUpdatemoney(lsobj.getLsid(),lsobj.getYfmoney(),0);
                        db.executeUpdate("Update LeagueShopImprest set audittype=0 where id=" + id);
                    }
                }
            }
        } finally
        {
            db.close();
        }

    }

    public int getId()
    {
        return id;
    }

    public int getLsid()
    {
        return lsid;
    }

    public String getRegmember()
    {
        return regmember;
    }

    public Date getRegdate()
    {
        return regdate;
    }

    public String getRegdatetoString()
    {
        if(regdate == null)
        {
            return "";
        } else
        {
            return LeagueShopImprest.sdf.format(regdate);
        }

    }

    public BigDecimal getYfmoney()
    {
        return yfmoney;
    }

    public Date getZzdate()
    {
        return zzdate;
    }

    public String getCommunity()
    {
        return community;
    }

    public int getPayment()
    {
        return payment;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getType()
    {
        return type;
    }

    public int getLsistatic()
    {
        return lsistatic;
    }

    public int getAudittype()
    {
        return audittype;
    }

    public String getInfo()
    {
        return info;
    }

    public String getSummary()
    {
        return summary;
    }

    public String getZzdatetoString()
    {
        if(zzdate == null)
        {
            return "";
        } else
        {
            return LeagueShopImprest.sdf.format(zzdate);
        }
    }
}
