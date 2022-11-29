package tea.entity.member;

import java.math.*;
import java.util.*;
import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

//xjk:支入 xfk:支出
public class StoredValueList extends Entity
{
    private static Cache _cache = new Cache(100);
    private int id;
    private String code;
    private BigDecimal outlay;
    private Date time;
    private String content;
    private boolean exists;

    public StoredValueList(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public StoredValueList(String code,BigDecimal outlay,Date time,String content)
    {
        this.code = code;
        this.outlay = outlay;
        this.time = time;
        this.content = content;
    }

    public static StoredValueList find(int id) throws SQLException
    {
        StoredValueList obj = (StoredValueList) _cache.get(new Integer(id));
        if(obj == null)
        {
            obj = new StoredValueList(id);
            // _cache.put(code, obj);
        }
        return obj;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter(3);
        try
        {
            db.executeQuery("SELECT kh,date,time,je,lx FROM xjk WHERE id=" + id);
            if(db.next())
            {
                code = db.getString(1);
                Date d = db.getDate(2);
                Date t = db.getDate(3);
                if(t != null)
                {
                    d = new Date(d.getTime() + t.getTime() + 2209190400000L); // 1899-12-30
                }
                time = d;
                outlay = db.getBigDecimal(4,2);
                content = db.getString(5);
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

    public static int count(String code,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter(3);
        try
        {
            db.executeQuery("SELECT COUNT(id) FROM xjk WHERE kh=" + DbAdapter.cite(code) + sql);
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

    public static java.util.Enumeration find(String code,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter(3);
        try
        {
            db.executeQuery("SELECT id FROM xjk WHERE kh=" + DbAdapter.cite(code) + sql + " ORDER BY date DESC",pos,size);
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

    public static void create(String code,BigDecimal outlay,String content) throws SQLException
    {
        java.text.SimpleDateFormat d = new java.text.SimpleDateFormat("yyyy-MM-ddHH:mm:ss");
        String str = d.format(new java.util.Date());
        DbAdapter db = new DbAdapter(3);
        try
        {
            db.executeUpdate("INSERT INTO xjk(date,time,kh,je,lx)VALUES(" + DbAdapter.cite(str.substring(0,10)) + "," + DbAdapter.cite("1899-12-30 " + str.substring(11)) + "," + DbAdapter.cite(code) + "," + outlay + "," + DbAdapter.cite(content) + ")");
        } finally
        {
            db.close();
        }
        StoredValue sv = StoredValue.find(code);
        sv.setOutlay(outlay);
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
                db.executeUpdate("INSERT INTO xjk(password    ,parvalue       ,community   ,time)VALUES(" + DbAdapter.cite(sb.toString()) + "," + (parvalue) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(time) + ")");
            }
        } finally
        {
            db.close();
        }
    }

    public void set(BigDecimal outlay) throws SQLException
    {
        DbAdapter db = new DbAdapter(3);
        try
        {
            db.executeUpdate("UPDATE xjk SET mm=" + outlay + " WHERE kh=" + DbAdapter.cite(code));
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
    }

    public boolean isFull() throws SQLException
    {
        DbAdapter db = new DbAdapter(3);
        try
        {
            db.executeQuery("SELECT * FROM xjk WHERE NOT member IS NULL AND NOT time2 IS NULL AND code=" + DbAdapter.cite(code));
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
            db.executeUpdate("DELETE FROM xjk WHERE kh=" + DbAdapter.cite(code));
        } catch(SQLException ex)
        {
            ex.printStackTrace();
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
    }

    public synchronized static String getLast() throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        DbAdapter db = new DbAdapter(3);
        try
        {
            db.executeQuery("SELECT orderid FROM Xjk");
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

    public String getXjk()
    {
        return code;
    }

    public BigDecimal getOutlay()
    {
        return outlay;
    }

    public String getCode()
    {
        return code;
    }

    public Date getTime()
    {
        return time;
    }

    public String getTimeToString()
    {
        if(time == null)
        {
            return "";
        }
        return sdf2.format(time);
    }

    public String getContent()
    {
        return content;
    }
}
