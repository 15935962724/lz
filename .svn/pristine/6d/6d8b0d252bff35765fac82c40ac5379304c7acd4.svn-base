package tea.entity.member;

import java.math.*;
import java.util.*;
import java.math.*;
import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

//kxx 卡余额
public class StoredValue extends Entity
{
    private static Cache _cache = new Cache(100);
    private String code;
    private String password;
    private BigDecimal outlay;
    private String hardid;
    private String desKey;
    private Date time;
    private boolean exists;

    public StoredValue(String code) throws SQLException
    {
        this.code = code;
        load();
    }

    public StoredValue(String code,String password,java.math.BigDecimal parvalue,String member,String community,Date time,Date time2)
    {
        this.code = code;
        this.password = password;
    }

    public static StoredValue find(String code) throws SQLException
    {
        /*
         * StoredValue obj = (StoredValue) _cache.get(code); if (obj == null) { obj = new StoredValue(code); _cache.put(code, obj); } return obj;
         */
        return new StoredValue(code);
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter(3);
        try
        {
            db.executeQuery("SELECT je,mm,hardid,deskey,[发卡日期] FROM kxx WHERE kh=" + DbAdapter.cite(code));
            if(db.next())
            {
                outlay = db.getBigDecimal(1,2);
                password = db.getString(2);
                hardid = db.getString(3);
                desKey = db.getString(4);
                time = db.getDate(5);
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

    public static String findByHardid(String hardid) throws SQLException
    {
        String code = null;
        DbAdapter db = new DbAdapter(3);
        try
        {
            db.executeQuery("SELECT kh FROM kxx WHERE hardid=" + DbAdapter.cite(hardid));
            if(db.next())
            {
                code = db.getString(1);
            }
        } finally
        {
            db.close();
        }
        return code;
    }

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter(3);
        try
        {
            db.executeQuery("SELECT COUNT(kh) FROM kxx WHERE 1=1" + sql);
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

    public static java.util.Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter(3);
        try
        {
            db.executeQuery("SELECT kh FROM kxx WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                v.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static void create(String code,String password,java.math.BigDecimal outlay,String hardid,String deskey) throws SQLException
    {
        java.util.Date time = new java.util.Date();
        DbAdapter db = new DbAdapter(3);
        try
        {
            db.executeUpdate("INSERT INTO kxx(kh,mm,je,hardid,deskey,[发卡日期])VALUES(" + DbAdapter.cite(code) + "," + DbAdapter.cite(password) + "," + outlay + "," + DbAdapter.cite(hardid) + "," + DbAdapter.cite(deskey) + "," + DbAdapter.cite(time) + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(code);
    }

    public void set(BigDecimal outlay,String hardid,String deskey) throws SQLException
    {
        DbAdapter db = new DbAdapter(3);
        try
        {
            db.executeUpdate("UPDATE kxx SET mm=" + DbAdapter.cite(password) + ",je=" + outlay + ",hardid=" + DbAdapter.cite(hardid) + ",deskey=" + DbAdapter.cite(deskey) + " WHERE kh=" + DbAdapter.cite(code));
        } finally
        {
            db.close();
        }
        this.password = password;
        this.hardid = hardid;
        this.desKey = deskey;
    }

    public synchronized static void create(java.math.BigDecimal parvalue,int quantity,String community) throws SQLException
    {
        java.util.Random r = new java.util.Random();
        java.util.Date time = new java.util.Date();
        DbAdapter db = new DbAdapter(3);
        try
        {
            for(;quantity > 0;quantity--)
            {
                StringBuilder sb = new StringBuilder(10);
                for(int index = 0;index < 10;index++)
                {
                    int value = r.nextInt(36);
                    sb.append(value > 9 ? String.valueOf((char) (value + 55)) : String.valueOf(value));
                }
                db.executeUpdate("INSERT INTO StoredValue(password,parvalue,community,time)VALUES(" + DbAdapter.cite(sb.toString()) + "," + (parvalue) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(time) + ")");
            }
        } finally
        {
            db.close();
        }
    }

    public void setOutlay(BigDecimal outlay) throws SQLException
    {
        outlay = this.outlay.add(outlay);
        DbAdapter db = new DbAdapter(3);
        try
        {
            db.executeUpdate("UPDATE kxx SET je=" + outlay + " WHERE kh=" + DbAdapter.cite(code));
        } finally
        {
            db.close();
        }
        this.outlay = outlay;
    }

    public boolean isFull() throws SQLException
    {
        DbAdapter db = new DbAdapter(3);
        try
        {
            db.executeQuery("SELECT * FROM StoredValue WHERE NOT member IS NULL AND NOT time2 IS NULL AND code=" + DbAdapter.cite(code));
            return db.next();
        } finally
        {
            db.close();
        }
    }

    public void delete()
    {
        DbAdapter db = new DbAdapter(3);
        try
        {
            db.executeUpdate("DELETE FROM StoredValue WHERE kh=" + DbAdapter.cite(code));
        } catch(SQLException ex)
        {
            ex.printStackTrace();
        } finally
        {
            db.close();
        }
        _cache.remove(code);
    }

    public synchronized static String getLast() throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        DbAdapter db = new DbAdapter(3);
        try
        {
            db.executeQuery("SELECT orderid FROM StoredValue");
            if(db.next())
            {
                sb.append(db.getString(1));
                while(db.next())
                {
                    sb.append("," + db.getString(1));
                }
            }
        } finally
        {
            db.close();
        }
        return sb.toString();
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getStoredValue()
    {
        return code;
    }

    public String getPassword()
    {
        return password;
    }

    public BigDecimal getOutlay()
    {
        return outlay;
    }

    public String getCode()
    {
        return code;
    }

    public String getDesKey()
    {
        return desKey;
    }

    public String getHardid()
    {
        return hardid;
    }

    public Date getTime()
    {
        return time;
    }
}
