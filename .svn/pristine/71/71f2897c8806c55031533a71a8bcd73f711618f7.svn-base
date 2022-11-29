package tea.entity.admin.mov;


import java.math.*;
import java.sql.*;
import java.util.*;
import java.util.Calendar;
import java.util.Date;

import tea.db.*;
import tea.entity.Entity;
import java.text.SimpleDateFormat;

public class MemberPay extends Entity
{

    private int payid;
    private int membertype;
    private BigDecimal paymoney;
    private int paytime;
    private String paycontent;
    private String member;
    private String community;
    private Date times;

    public MemberPay(int payid) throws SQLException
    {
        this.payid = payid;
        load();
    }

    public static MemberPay find(int payid) throws SQLException
    {
        return new MemberPay(payid);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT paymoney,paytime,paycontent,member,community,times,membertype FROM MemberPay WHERE payid=" + payid);
            if(db.next())
            {
                paymoney = db.getBigDecimal(1,2);
                paytime = db.getInt(2);
                paycontent = db.getString(3);
                member = db.getString(4);
                community = db.getString(5);
                times = db.getDate(6);
                membertype = db.getInt(7);
            }
        } finally
        {
            db.close();
        }
    }


    public static void create(java.math.BigDecimal paymoney,int paytime,String paycontent,String member,String community,int membertype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("INSERT INTO MemberPay(paymoney,paytime,paycontent,member,community,times,membertype) VALUES(" + paymoney + "," + (paytime) + "," + db.cite(paycontent) + "," + db.cite(member) + "," + db.cite(community) + "," + db.cite(times) + "," + membertype + "  )");
        } finally
        {
            db.close();
        }
    }

    public void set(java.math.BigDecimal paymoney,int paytime,String paycontent,String member,String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE MemberPay SET paymoney=" + paymoney + ", paytime=" + paytime + " ,paycontent=" + db.cite(paycontent) + ",member=" + db.cite(member) + " WHERE payid=" + payid);
        } finally
        {
            db.close();
        }
    }

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT payid FROM MemberPay WHERE community=" + db.cite(community) + sql,pos,size);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }

        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM MemberPay WHERE payid=" + payid);
        } finally
        {
            db.close();
        }
    }

    public static void delete(int membertype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM MemberPay WHERE membertype=" + membertype);
        } finally
        {
            db.close();
        }
    }

    public static void WholeDelete(int membertype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM MemberPay WHERE membertype=" + membertype);
        } finally
        {
            db.close();
        }
    }

    public boolean isMember(int payid) throws SQLException
    {
        boolean fa = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT payid FROM MemberPay WHERE payid=" + payid);
            if(db.next())
            {
                fa = true;
            }
        } finally
        {
            db.close();
        }

        return fa;
    }

    public static boolean isMembertype(int membertype) throws SQLException
    {
        boolean fa = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT membertype FROM MemberPay WHERE membertype=" + membertype);
            if(db.next())
            {
                fa = true;
            }
        } finally
        {
            db.close();
        }

        return fa;
    }

    public static String getMemberType(String community) throws SQLException
    {
        //select distinct(membertype) from MemberPay
        int d = 0;
        boolean fa = false;
        DbAdapter db = new DbAdapter();
        StringBuffer sp = new StringBuffer();
        try
        {
            db.executeQuery("select distinct(membertype) from MemberPay where community =" + db.cite(community));
            if(db.next())
            {
                sp.append("(");
            } while(db.next())
            {
                fa = true;
                sp.append("  membertype = ").append(db.getInt(1)).append(" OR ");
            }
            if(fa)
            {
                sp.append(" 1!=1 )");
            }

        } finally
        {
            db.close();
        }
        return sp.toString();

    }

    //计算到期期限
    public String getTimeLimit(int paytime) throws SQLException
    {
        //java.text.SimpleDateFormat ymd = new java.text.SimpleDateFormat("yyyy");
        GregorianCalendar now = new GregorianCalendar();
        SimpleDateFormat fmtrq = new SimpleDateFormat("yyyy-MM-dd",Locale.US);
        java.text.DateFormat df = java.text.DateFormat.getDateInstance();
        //System.out.println(fmtrq.format(now.getTime()));
        now.add(GregorianCalendar.YEAR, +paytime);
        String str = fmtrq.format(now.getTime());
        return str;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getMember()
    {
        return member;
    }

    public String getPaycontent()
    {
        return paycontent;
    }

    public BigDecimal getPaymoney()
    {
        return paymoney;
    }

    public int getPaytime()
    {
        return paytime;
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

    public int getMemberType()
    {
        return membertype;
    }

}
