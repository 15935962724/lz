package tea.entity.csvclub;

import java.math.BigDecimal;
import java.util.Date;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class Csvxfilm extends Entity
{
    private static Cache _cache = new Cache(100);

    private int csvxfilm;
    private String content;
    private java.util.Date time;
    private String member;
    private String community;
    private int csvdog;
    private BigDecimal money;
    ////////////////////////////////
    private int ed;
    private int ederror;
    private String remark;
    private String remark2;
    private String member2;
    private Date time2;
    private boolean exists;
    private int illness;
    private String illnesstext;
    private String illnessedtext;

    public Csvxfilm(int csvxfilm) throws SQLException
    {
        this.csvxfilm = csvxfilm;
        loadBasic();
    }

    public Csvxfilm(int csvxfilm, int item, BigDecimal money, int poyear, int outlay, java.util.Date time)
    {

    }

    private void loadBasic() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT csvdog,time,member,community,content,ed,ederror,DATALENGTH(remark),remark,DATALENGTH(remark2),remark2,member2,time2,illness,illnesstext,illnessedtext,money FROM Csvxfilm WHERE csvxfilm=" + csvxfilm);
            if (dbadapter.next())
            {
                csvdog = dbadapter.getInt(1);
                time = dbadapter.getDate(2);
                member = dbadapter.getString(3);
                community = dbadapter.getString(4);
                content = dbadapter.getString(5);
                ed = dbadapter.getInt(6);
                ederror = dbadapter.getInt(7);
                remark = dbadapter.getText(8);
                remark2 = dbadapter.getText(10);
                member2 = dbadapter.getString(12);
                time2 = dbadapter.getDate(13);
                illness = dbadapter.getInt(14);
                illnesstext = dbadapter.getString(15);
                illnessedtext = dbadapter.getString(16);
                money = dbadapter.getBigDecimal(17, 2);
                exists = true;
            } else
            {
                exists = false;
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
            dbadapter.executeUpdate("DELETE Csvxfilm WHERE csvxfilm=" + csvxfilm);
        } finally
        {
            dbadapter.close();
        }
        _cache.remove(new Integer(csvxfilm));
    }

    public static void create(int csvdog, Date time, String member, String community, String content, BigDecimal money) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("INSERT INTO Csvxfilm(csvdog,time,member,community,content,money)VALUES(" +
                                    csvdog + "," + dbadapter.cite(time) + "," + dbadapter.cite(member) + "," + dbadapter.cite(community) + "," + dbadapter.cite(content) + "," + money + ")");
        } finally
        {
            dbadapter.close();
        }
    }

    public void set(int csvdog, Date time, String member, String community, String content, BigDecimal money) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("UPDATE Csvxfilm SET csvdog=" + csvdog +
                                    ",time =" + dbadapter.cite(time) +
                                    ",member =" + dbadapter.cite(member) +
                                    ",community =" + dbadapter.cite(community) +
                                    ",content =" + dbadapter.cite(content) +
                                    ",money =" + money +
                                    " WHERE csvxfilm=" + csvxfilm);
        } finally
        {
            dbadapter.close();
        }
        this.csvdog = csvdog;
        this.time = time;
        this.member = member;
        this.community = community;
        this.content = content;
        this.money = money;
    }

    public void set(int ed, int ederror, String remark, String remark2, String member, Date time, int illness, String illnesstext, String illnessedtext) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("UPDATE Csvxfilm SET ed=" + ed +
                                    ",ederror =" + (ederror) +
                                    ",remark =" + dbadapter.cite(remark) +
                                    ",remark2 =" + dbadapter.cite(remark2) +
                                    ",member2 =" + dbadapter.cite(member) +
                                    ",time2 =" + dbadapter.cite(time) +
                                    ",illness =" + illness +
                                    ",illnesstext =" + dbadapter.cite(illnesstext) +
                                    ",illnessedtext =" + dbadapter.cite(illnessedtext) +
                                    " WHERE csvxfilm=" + csvxfilm);
        } finally
        {
            dbadapter.close();
        }
        this.ed = ed;
        this.ederror = ederror;
        this.remark = remark;
        this.remark2 = remark2;
        this.member2 = member;
        this.time2 = time;
        this.illness = illness;
        this.illnesstext = illnesstext;
        this.illnessedtext = illnessedtext;
    }

    public static java.util.Enumeration find(String community, String sql, int pos, int pageSize) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT TOP " + (pos + pageSize) + " cx.csvxfilm FROM Csvxfilm cx WHERE cx.community=" + dbadapter.cite(community) + sql);
            for (int l = 0; dbadapter.next(); l++)
            {
                if (l >= pos)
                {
                    int csvxfilm = dbadapter.getInt(1);
                    vector.addElement(new Integer(csvxfilm));
                }
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }


    public static Csvxfilm find(int csvxfilm) throws SQLException
    {
        Csvxfilm obj = (Csvxfilm) _cache.get(new Integer(csvxfilm));
        if (obj == null)
        {
            obj = new Csvxfilm(csvxfilm);
            _cache.put(new Integer(csvxfilm), obj);
        }
        return obj;
    }

    public static Csvxfilm findLastByCsvdog(int csvdog) throws SQLException
    {
        int csvxfilm = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT TOP 1 cx.csvxfilm FROM Csvxfilm cx WHERE cx.csvdog=" + csvdog + " ORDER BY time DESC");
            if (dbadapter.next())
            {
                csvxfilm = dbadapter.getInt(1);
            }
        } finally
        {
            dbadapter.close();
        }
        return find(csvxfilm);
    }

    public String getCommunity()
    {
        return community;
    }

    public String getMember()
    {
        return member;
    }

    public int getCsvxfilm()
    {
        return csvxfilm;
    }

    public Date getTime()
    {
        return time;
    }

    public int getCsvdog()
    {
        return csvdog;
    }

    public String getContent()
    {
        return content;
    }

    public int getEd()
    {
        return ed;
    }

    public int getEderror()
    {
        return ederror;
    }

    public String getRemark()
    {
        return remark;
    }

    public String getRemark2()
    {
        return remark2;
    }

    public String getMember2()
    {
        return member2;
    }

    public Date getTime2()
    {
        return time2;
    }

    public String getTime2ToString()
    {
        if (time2 == null)
        {
            return "";
        }
        return sdf.format(time2);
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getIllness()
    {
        return illness;
    }

    public String getIllnesstext()
    {
        return illnesstext;
    }

    public String getIllnessedtext()
    {
        return illnessedtext;
    }

    public BigDecimal getMoney()
    {
        return money;
    }


    public String getTimeToString()
    {
        if (time == null)
        {
            return "";
        }
        return sdf.format(time);
    }

    public static int count(String community, String sql) throws SQLException
    {
        int j = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT COUNT(community) FROM Csvxfilm WHERE community=" + DbAdapter.cite(community) + sql);
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
    /*
        public void setReceipt(boolean receipt) throws SQLException
        {
            DbAdapter dbadapter = new DbAdapter();
            try
            {
                dbadapter.executeUpdate("UPDATE Csvxfilm SET receipt=" + (receipt ? "1" : "0") + " WHERE csvxfilm=" + csvxfilm);
            } finally
            {
                dbadapter.close();
            }
            this.receipt = receipt;
        }
     */
}
