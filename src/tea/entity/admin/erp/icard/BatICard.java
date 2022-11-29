package tea.entity.admin.erp.icard;

import java.math.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import java.text.DecimalFormat;

//批量发卡记录
public class BatICard extends Entity
{
    int baticard;
    int icardtype; //卡类型
    String prefix; //前缀
    int median; //位数
    int startcode; //起始卡号
    int endcode; //结束卡号
    String password; //密码
    BigDecimal money; //存入金额
    Date invaliddate; //作废日期
    Date time;
    boolean exists;
    public BatICard(int baticard) throws SQLException
    {
        this.baticard = baticard;
        load();
    }

    public static BatICard find(int icard) throws SQLException
    {
        return new BatICard(icard);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT icardtype,prefix,median,startcode,endcode,password,money,invaliddate,time FROM BatICard WHERE baticard=" + baticard);
            if(db.next())
            {
                icardtype = db.getInt(1);
                prefix = db.getString(2);
                median = db.getInt(3);
                startcode = db.getInt(4);
                endcode = db.getInt(5);
                password = db.getString(6);
                money = db.getBigDecimal(7,2);
                invaliddate = db.getDate(8);
                time = db.getDate(9);
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

    public static int create(int icardtype,String prefix,int median,int startcode,int endcode,String password,BigDecimal money,Date invaliddate,boolean filter) throws SQLException
    {
        Date time = new Date();
        StringBuilder f = new StringBuilder();
        for(int i = 0;i < median;i++)
        {
            f.append("0");
        }
        int j = 0; //发行的卡数
        DecimalFormat df = new DecimalFormat(f.toString());
        for(int i = startcode;i <= endcode;i++)
        {
            String tmp = df.format(i);
            if(filter)
            {
                tmp = tmp.replace('4','5');
            }
            boolean flag = ICard.create(prefix + tmp,icardtype,password == null ? String.valueOf(Math.random()).substring(2,8) : password,money,invaliddate,time);
            if(flag)
            {
                j++;
            }
        }
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO BatICard(icardtype,prefix,median,startcode,endcode,password,money,invaliddate,time)VALUES(" + icardtype + "," + db.cite(prefix) + "," + median + "," + startcode + "," + endcode + "," + db.cite(password) + "," + money + "," + db.cite(invaliddate) + "," + db.cite(time) + ")");
        } finally
        {
            db.close();
        }
        return j;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM ICard WHERE time=" + db.cite(time));
            db.executeUpdate("DELETE FROM BatICard WHERE baticard=" + baticard);
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
            db.executeQuery("SELECT baticard FROM BatICard WHERE icardtype IN(SELECT icardtype FROM ICardType WHERE community=" + db.cite(community) + ")" + sql,pos,size);
            while(db.next())
            {
                v.add(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Enumeration findICardType(String community,String sql) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT icardtype FROM BatICard WHERE icardtype IN(SELECT icardtype FROM ICardType WHERE community=" + db.cite(community) + ")" + sql + " GROUP BY icardtype");
            while(db.next())
            {
                v.add(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getBatICard()
    {
        return baticard;
    }

    public int getEndCode()
    {
        return endcode;
    }

    public int getICardType()
    {
        return icardtype;
    }

    public Date getInvalidDate()
    {
        return invaliddate;
    }

    public String getInvalidDateToString()
    {
        return Entity.sdf.format(invaliddate);
    }

    public int getMedian()
    {
        return median;
    }

    public BigDecimal getMoney()
    {
        return money;
    }

    public String getPassword()
    {
        return password;
    }

    public String getPrefix()
    {
        return prefix;
    }

    public int getStartCode()
    {
        return startcode;
    }

    public Date getTime()
    {
        return time;
    }

    public String getTimeToString()
    {
        return Entity.sdf.format(time);
    }
}
