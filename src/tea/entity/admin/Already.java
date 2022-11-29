package tea.entity.admin;

import java.math.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class Already extends Entity
{

    private int alid;
    private int flowitem; //项目ID
    private int workproject; //客户id
    private java.math.BigDecimal amount; //收款金额
    private Date timemoney; //收款时间
    private String project; //收款项目
    private int way; //收款方式
    private String membera; //甲方
    private String memberb; //乙方
    private int invoice; //发票情况
    private Date times;
    private String member;
    private String community;
    private boolean exists;
    private int atype; //实收类型


    public static final String WAY_TYPE[] =
            {"转账","支票","现金"};

    public static final String ALREADYTYPE[] =
            {"实际收入","市场费用","其他费用"};

    public Already(int alid) throws SQLException
    {
        this.alid = alid;
        load();
    }

    public static Already find(int alid) throws SQLException
    {
        return new Already(alid);
    }


    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT flowitem,workproject,amount,timemoney,project,way,membera,memberb,invoice,times,member,community,atype FROM Already WHERE alid = " + alid);
            if(db.next())
            {
                flowitem = db.getInt(1);
                workproject = db.getInt(2);
                amount = db.getBigDecimal(3,2);
                timemoney = db.getDate(4);
                project = db.getString(5);
                way = db.getInt(6);
                membera = db.getString(7);
                memberb = db.getString(8);
                invoice = db.getInt(9);
                times = db.getDate(10);
                member = db.getString(11);
                community = db.getString(12);
                atype = db.getInt(13);
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

    //2009年6月8日11:51:38 唐
    public static void create(int flowitem,int workproject,java.math.BigDecimal amount,Date timemoney,String project,int way,String membera,String memberb,int invoice,String member,String community,int atype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("INSERT INTO Already (flowitem,workproject,amount,timemoney,project,way,membera,memberb,invoice,times,member,community,atype) VALUES (" + flowitem + "," + (workproject) + "," + amount + "," + db.cite(timemoney) + "," + db.cite(project) + "," + way + "," + db.cite(membera) + "," + db.cite(memberb) + "," + invoice + "," + db.cite(times) + "," + db.cite(member) + "," + db.cite(community) + "," + atype + " )");
            Flowitem.setEatype2(flowitem);
        } finally
        {
            db.close();
        }
    }

    //2009年6月8日11:51:38 唐
    public void set(int flowitem,int workproject,java.math.BigDecimal amount,Date timemoney,String project,int way,String membera,String memberb,int invoice,String member,int atype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("UPDATE Already SET flowitem=" + (flowitem) + ",workproject=" + workproject + ",amount=" + amount + ",timemoney=" + db.cite(timemoney) + ",project=" + db.cite(project) + ",way=" + way + ",membera=" + db.cite(membera) + ",memberb=" + db.cite(memberb) + ",community=" + db.cite(community) + ",invoice=" + invoice + ",member=" + db.cite(member) + ",atype=" + atype + " WHERE alid = " + alid);
            Flowitem.setEatype2(flowitem);
        } finally
        {
            db.close();
        }
    }

    public static Enumeration find(String community,String sql,int pos,int size)
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT alid FROM Already WHERE community= " + db.cite(community) + sql);
            for(int i = 0;db.next() && i < pos + size;i++)
            {
                if(i >= pos)
                {
                    vector.addElement(new Integer(db.getInt(1)));

                }
            }
        } catch(Exception exception3)
        {
            System.out.print(exception3);
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM  Already WHERE alid = " + alid);
        } finally
        {
            db.close();
        }
    }

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(alid) FROM Already  WHERE community=" + db.cite(community) + sql);
            if(db.next())
            {
                count = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return count;
    }

    public static java.math.BigDecimal getTotalamount(String community,String sql) throws SQLException
    {
        java.math.BigDecimal amount = new java.math.BigDecimal("0");
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT SUM(amount) FROM Already WHERE community=" + DbAdapter.cite(community) + sql);
            if(db.next())
            {
                amount = db.getBigDecimal(1,2);
            }
        } finally
        {
            db.close();
        }
        return amount;

    }

//实际收入
    public static BigDecimal getAmountTotalSum(int flowitem,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        BigDecimal m = BigDecimal.ZERO;
        try
        {
            db.executeQuery("SELECT SUM(amount) FROM Already WHERE flowitem=" + flowitem + "  " + sql);
            if(db.next())
            {
                m = db.getBigDecimal(1,2);
            }
        } finally
        {
            db.close();
        }
        return m;
    }


    public BigDecimal getAmount()
    {
        return amount;
    }

    public String getCommunity()
    {
        return community;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getFlowitem()
    {
        return flowitem;
    }

    public int getInvoice()
    {
        return invoice;
    }

    public String getMember()
    {
        return member;
    }

    public String getMembera()
    {
        return membera;
    }

    public String getMemberb()
    {
        return memberb;
    }

    public String getProject()
    {
        return project;
    }

    public Date getTimemoney()
    {
        return timemoney;
    }

    public String getTimemoneyToString()
    {
        if(timemoney == null)
        {
            return "";
        }
        return sdf.format(timemoney);
    }

    public Date getTimes()
    {
        return times;
    }

    public String getTimesToString()
    {
        if(times == null)
        {
            return "";
        }
        return sdf.format(times);
    }

    public int getWay()
    {
        return way;
    }

    public int getWorkproject()
    {
        return workproject;
    }

    public int getAtype()
    {
        return atype;
    }


}
