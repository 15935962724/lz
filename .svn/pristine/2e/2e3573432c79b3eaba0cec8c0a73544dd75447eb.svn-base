package tea.entity.member;

import java.math.*;
import java.util.Date;
import java.text.*;
import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class SMSEnterprise extends Entity
{
    public static BigDecimal SMS_PRICE = new BigDecimal("0.1");
    public static DecimalFormat df = new DecimalFormat("#.00");
    private static Cache _cache = new Cache(100);
    private BigDecimal money;
    private BigDecimal summoney;
    private boolean exists;
    private int code; //企业编号
    private String pwd;
    private Date time;
    private BigDecimal balance;
    private int hits;
    private BigDecimal price;
    private String name;
    private String scode; //特服号(00-99)
    public SMSEnterprise(int code) throws SQLException
    {
        this.code = code;
        loadBasic();
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT name,pwd,scode,time,balance,hits,price FROM SMSEnterprise  WHERE code=" + code);
            if (db.next())
            {
                name = db.getVarchar(1, 1, 1);
                pwd = db.getString(2);
                scode = db.getString(3);
                time = db.getDate(4);
                balance = db.getBigDecimal(5, 2);
                hits = db.getInt(6);
                price = db.getBigDecimal(7, 2);
                exists = true;
            } else
            {
                exists = false;
                balance = price = new BigDecimal(0);
            }
        } finally
        {
            db.close();
        }
    }

    public static BigDecimal getBalance(String code) throws SQLException
    {
        int k = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            k = db.getInt("SELECT MAX(smsenterprise) FROM SMSEnterprise WHERE code=" + DbAdapter.cite(code));
        } finally
        {
            db.close();
        }
        return find(k).getBalance();
    }

    /*
        public BigDecimal getPrevBalance() throws SQLException
        {
            int k = 0;
            DbAdapter db = new DbAdapter();
            try
            {
                k = db.getInt("SELECT MAX(smsenterprise) FROM SMSEnterprise WHERE smsenterprise<" + smsenterprise + " AND code=" + (code));
                return find(k).getBalance();
      } finally
            {
                db.close();
            }
        }
     */
    public BigDecimal getBalance() throws SQLException
    {

        return balance; //summoney.subtract(SMS_PRICE.multiply(new BigDecimal(payout)));
    }

    public void setBalance(BigDecimal balance) throws SQLException
    {
        this.balance = this.balance.add(balance);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE SMSEnterprise SET balance=" + this.balance + " WHERE code=" + code);
        } finally
        {
            db.close();
        }
    }

    public void setHits(int hits) throws SQLException
    {
        this.balance = balance.subtract(price.multiply(new BigDecimal(hits)));
        this.hits += hits;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE SMSEnterprise SET hits=" + this.hits + ",balance=" + this.balance + " WHERE code=" + code);
        } finally
        {
            db.close();
        }
    }

    public BigDecimal getSummoney() throws SQLException
    {
        return summoney;
    }

    public static java.util.Enumeration find() throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT code FROM SMSEnterprise ");
            while (db.next())
            {
                vector.addElement(new java.lang.Integer(db.getInt(1)));
            }
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
            db.executeUpdate("DELETE FROM SMSEnterprise WHERE code=" + code);
            _cache.remove(new Integer(code));
        } finally
        {
            db.close();
        }
    }

    public void set(String pwd, String scode, String name) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if (exists)
            {
                db.executeUpdate("UPDATE SMSEnterprise SET pwd=" + DbAdapter.cite(pwd) + ",scode=" + DbAdapter.cite(scode) + ",name=" + DbAdapter.cite(name) + " WHERE code=" + (code));
            } else
            {
                time = new Date();
                db.executeUpdate("INSERT INTO SMSEnterprise(code,pwd,scode,name,time,balance,hits,price)VALUES(" + code + "," + DbAdapter.cite(pwd) + "," + DbAdapter.cite(scode) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(time) + ",0,0,0.1)");
            }
        } finally
        {
            db.close();
        }
        this.exists = true;
        this.pwd = pwd;
        this.scode = scode;
        this.name = name;
        _cache.remove(new Integer(code));
    }

    public static SMSEnterprise find(int code) throws SQLException
    {
        SMSEnterprise obj = (SMSEnterprise) _cache.get(new Integer(code));
        if (obj == null)
        {
            obj = new SMSEnterprise(code);
            _cache.put(new Integer(code), obj);
        }
        return obj;
    }

    public static SMSEnterprise find(String code) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int k = db.getInt("SELECT smsenterprise FROM SMSEnterprise WHERE code=" + DbAdapter.cite(code) + " ORDER BY smsenterprise DESC");
            return find(k);
        } finally
        {
            db.close();
        }
    }

    public String getTimeToString()
    {
        return sdf.format(time);
    }


    public BigDecimal getMoney()
    {
        return money;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getCode()
    {
        return code;
    }

    public String getPwd()
    {
        return pwd;
    }

    public Date getTime()
    {
        return time;
    }

    public int getHits()
    {
        return hits;
    }

    public BigDecimal getPrice()
    {
        return price;
    }

    public String getName()
    {
        return name;
    }

    public String getScode()
    {
        return scode;
    }
}
