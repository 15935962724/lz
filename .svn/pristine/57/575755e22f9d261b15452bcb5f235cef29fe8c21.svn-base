package tea.entity.member;

import java.math.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;
public class SMSEnterprise2 extends tea.entity.Entity
{
    public static BigDecimal SMS_PRICE = new java.math.BigDecimal("0.1");
    public static java.text.DecimalFormat df = new java.text.DecimalFormat("#.00");
    private static Cache _cache = new Cache(100);
    private int smsenterprise;
    private boolean exists;
    private int code;
    private String pwd;
    private Date time;
    private BigDecimal balance;
    private int count;
    private BigDecimal price;
    public SMSEnterprise2(int smsenterprise) throws SQLException
    {
        this.smsenterprise = smsenterprise;
        loadBasic();
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT code   ,time  ,balance    ,count     FROM SMSEnterprise2  WHERE smsenterprise=" + smsenterprise);
            if (db.next())
            {
                code = db.getInt(1);
                time = db.getDate(2);
                balance = db.getBigDecimal(3, 2);
                count = db.getInt(4);
                exists = true;
            } else
            {
                exists = false;
                balance = new BigDecimal(0);
            }
        } finally
        {
            db.close();
        }
    }


    public java.math.BigDecimal getBalance() throws SQLException
    {
        return balance; //summoney.subtract(SMS_PRICE.multiply(new java.math.BigDecimal(payout)));
    }


    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM SMSEnterprise2 WHERE smsenterprise=" + smsenterprise);
            _cache.remove(new Integer(smsenterprise));
        } finally
        {
            db.close();
        }
    }

    public static void create(int code, java.math.BigDecimal balance) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO SMSEnterprise2(code,balance,time)VALUES(" + code + "," + balance + "," + DbAdapter.cite(new java.util.Date()) + ")");} finally
        {
            db.close();
        }
    }


    public static SMSEnterprise2 find(int smsenterprise) throws SQLException
    {
        SMSEnterprise2 obj = (SMSEnterprise2) _cache.get(new Integer(smsenterprise));
        if (obj == null)
        {
            obj = new SMSEnterprise2(smsenterprise);
            _cache.put(new Integer(smsenterprise), obj);
        }
        return obj;
    }

    public static java.util.Enumeration findByCode(int code) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT smsenterprise FROM SMSEnterprise2 WHERE code=" + (code));
            while (db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }} finally
        {
            db.close();
        }
        return vector.elements();
    }


    public String getTimeToString()
    {
        return sdf.format(time);
    }


    public boolean isExists()
    {
        return exists;
    }

    public int getCode()
    {
        return code;
    }


    public Date getTime()
    {
        return time;
    }

    public int getCount()
    {
        return count;
    }

    public BigDecimal getPrice()
    {
        return price;
    }

}
