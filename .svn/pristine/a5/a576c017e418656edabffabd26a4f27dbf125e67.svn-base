package tea.entity.csvclub;

import java.math.BigDecimal;
import java.util.Date;
import java.sql.SQLException;
import tea.db.DbAdapter;
import tea.entity.*;

public class Csvcluboutlay extends Entity
{

    private static Cache _cache = new Cache(100);
//    private static final java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-hh HH:mm");
    private java.math.BigDecimal money;
    private Date time;
    private String member;
    private String community;
    private int csvcluboutlay;
    private boolean type; //flase: 会员费, true:犬只费
    private boolean receipt; //是否到账
    public Csvcluboutlay(int csvcluboutlay) throws SQLException
    {
        this.csvcluboutlay = csvcluboutlay;
        loadBasic();
    }

    public Csvcluboutlay(int csvcluboutlay, int item, BigDecimal money, int poyear, int outlay, java.util.Date time)
    {
        this.csvcluboutlay = csvcluboutlay;

        this.money = money;
        this.time = time;
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT member,community,money,time,receipt FROM Csvcluboutlay WHERE csvcluboutlay=" + (csvcluboutlay));
            if (dbadapter.next())
            {
                member = dbadapter.getString(1);
                community = dbadapter.getString(2);
                money = dbadapter.getBigDecimal(3, 2);
                time = dbadapter.getDate(4);
                receipt = dbadapter.getInt(5) != 0;
            }
        } finally
        {
            dbadapter.close();
        }
    }


    public void delete() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("DELETE Csvcluboutlay WHERE csvcluboutlay=" + csvcluboutlay);
        } finally
        {
            dbadapter.close();
        }
        _cache.remove(new Integer(csvcluboutlay));
    }

    public static void create(String member, String community, BigDecimal money, boolean type, Date time) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("INSERT INTO Csvcluboutlay(member,community,money,type,time) VALUES(" +
                                    dbadapter.cite(member) + "," + dbadapter.cite(community) + "," + money + "," + dbadapter.cite(type) + "," + dbadapter.cite(time) + ")");
        } finally
        {
            dbadapter.close();
        }
    }

    public void set(BigDecimal money, boolean type, Date time) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("UPDATE Csvcluboutlay SET money=" + (money) + ",type =" + dbadapter.cite(type) + ",time =" + dbadapter.cite(time) + " WHERE csvcluboutlay=" + csvcluboutlay);
        } finally
        {
            dbadapter.close();
        }
        this.money = money;
        this.type = type;
        this.time = time;
    }

    public static java.util.Enumeration findMember(String community, String sql) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT DISTINCT co.member FROM Csvcluboutlay co WHERE co.community=" + dbadapter.cite(community) + sql);
            for (int l = 0; dbadapter.next(); l++)
            {
                //if (l >= pos)
                {
                    vector.addElement(dbadapter.getString(1));
                }
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    public static java.util.Enumeration find(String community, String sql, int pos, int pageSize) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT TOP " + (pos + pageSize) + " co.csvcluboutlay FROM Csvcluboutlay co,Profile p WHERE p.member=co.member AND co.community=" + dbadapter.cite(community) + " AND p.community=" + dbadapter.cite(community) + sql);
            for (int l = 0; dbadapter.next(); l++)
            {
                if (l >= pos)
                {
                    int csvcluboutlay = dbadapter.getInt(1);
                    vector.addElement(new Integer(csvcluboutlay));
                }
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    private static void setIsmax(String community) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            java.util.Enumeration enumer = findMember(community, "");
            while (enumer.hasMoreElements())
            {
                int id = findLastByMember((String) enumer.nextElement());
                Csvcluboutlay obj = Csvcluboutlay.find(id);
                dbadapter.executeUpdate("UPDATE Csvcluboutlay SET ismax=1 WHERE time=" + dbadapter.cite(obj.getTime()));
                dbadapter.executeUpdate("UPDATE Csvcluboutlay SET ismax=0 WHERE time<" + dbadapter.cite(obj.getTime()));
            }
        } finally
        {
            dbadapter.close();
        }
    }

    public static java.util.Enumeration find(String community, String sql) throws SQLException
    {
        setIsmax(community);
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT DISTINCT p.member FROM Csvcluboutlay co,Profile p WHERE co.community=" + dbadapter.cite(community) + " AND p.community=" + dbadapter.cite(community) + sql);
            for (int l = 0; dbadapter.next(); l++)
            {
                //if (l >= pos)
                {
                    vector.addElement(dbadapter.getString(1));
                }
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    public static Csvcluboutlay find(int csvcluboutlay) throws SQLException
    {
        Csvcluboutlay obj = (Csvcluboutlay) _cache.get(new Integer(csvcluboutlay));
        if (obj == null)
        {
            obj = new Csvcluboutlay(csvcluboutlay);
            _cache.put(new Integer(csvcluboutlay), obj);
        }
        return obj;
    }

    public Date getTime()
    {
        return time;
    }


    public BigDecimal getMoney()
    {
        return money;
    }

    public static int findLastByMember(String member) throws SQLException
    {
        int csvcluboutlay = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT TOP 1 csvcluboutlay FROM Csvcluboutlay WHERE member=" + dbadapter.cite(member) + " ORDER BY time DESC");
            if (dbadapter.next())
            {
                csvcluboutlay = dbadapter.getInt(1);
            }
        } finally
        {
            dbadapter.close();
        }
        return csvcluboutlay;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getMember()
    {
        return member;
    }

    public int getCsvcluboutlay()
    {
        return csvcluboutlay;
    }

    public boolean isReceipt()
    {
        return receipt;
    }

    public boolean isType()
    {
        return type;
    }

    public String getTimeToString()
    {
        return sdf.format(time);
    }

    public static int count(String community, String sql) throws SQLException
    {
        int j = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT COUNT(community) FROM Csvcluboutlay WHERE community=" + DbAdapter.cite(community) + sql);
            if (dbadapter.next())
            {
                j = dbadapter.getInt(1);
            }
        } finally
        {
            dbadapter.close();
        }
        return j;
    }

    public void setReceipt(boolean receipt) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("UPDATE Csvcluboutlay SET receipt=" + (receipt ? "1" : "0") + " WHERE csvcluboutlay=" + csvcluboutlay);
        } finally
        {
            dbadapter.close();
        }
        this.receipt = receipt;
    }

}
