package tea.entity.admin.mov;

import java.math.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class AuditingOrder extends Entity
{
    private String memberorder;
    private BigDecimal paymoney;
    private String auditingmember;
    private String community;
    private Date times;

    public AuditingOrder(String memberorder) throws SQLException
    {
        this.memberorder = memberorder;
        load();
    }

    public static AuditingOrder find(String memberorder) throws SQLException
    {
        return new AuditingOrder(memberorder);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT paymoney,auditingmember,community,times FROM AuditingOrder WHERE memberorder=" + db.cite(memberorder));
            if(db.next())
            {
                paymoney = db.getBigDecimal(1,2);
                auditingmember = db.getString(2);
                community = db.getString(3);
                times = db.getDate(4);
            }
        } finally
        {
            db.close();
        }

    }


    public static void create(String memberorder,BigDecimal paymoney,String auditingmember,String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("INSERT INTO AuditingOrder(memberorder,paymoney,auditingmember,community,times) VALUES(" + db.cite(memberorder) + "," + (paymoney) + "," + db.cite(auditingmember) + "," + db.cite(community) + "," + db.cite(times) + " )");
        } finally
        {
            db.close();
        }
    }

    public void set(BigDecimal paymoney,String auditingmember) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE AuditingOrder SET paymoney=" + paymoney + ",auditingmember=" + auditingmember + " WHERE memberorder=" + db.cite(memberorder));
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
            db.executeQuery("SELECT memberorder FROM AuditingOrder WHERE community=" + db.cite(community) + sql,pos,size);
            while(db.next())
            {
                v.addElement(new String(db.getString(1)));
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
            db.executeUpdate("DELETE FROM AuditingOrder WHERE memberorder=" + db.cite(memberorder));
        } finally
        {
            db.close();
        }
    }

    public String getAuditingmember()
    {
        return auditingmember;
    }

    public String getCommunity()
    {
        return community;
    }

    public BigDecimal getPaymoney()
    {
        return paymoney;
    }

    public Date getTimes()
    {
        return times;
    }


}
