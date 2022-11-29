package tea.entity.csvclub;

import java.math.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

//
public class Csvyearcharge extends Entity
{
    private String member;

    private BigDecimal m_04;
    private BigDecimal m_05;
    private BigDecimal m_06;
    private BigDecimal m_07;
    private BigDecimal m_08;
    private BigDecimal m_09;
    private BigDecimal m_10;
    private BigDecimal m_zhuce;
    private BigDecimal h_04;
    private BigDecimal h_05;
    private BigDecimal h_06;
    private BigDecimal h_07;
    private BigDecimal h_08;
    private BigDecimal h_09;
    private BigDecimal h_10;
    private BigDecimal h_hou;
    private BigDecimal h_forever;

    private boolean exists;

    public Csvyearcharge(String member) throws SQLException
    {
        this.member = member;
        load();
    }

    public static Csvyearcharge find(String member) throws SQLException
    {
        return new Csvyearcharge(member);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT member,m_04,m_05,m_06,m_07,m_08,m_09,m_10,m_zhuce,h_04,h_05,h_06,h_07,h_08,h_09,h_10,h_hou,h_forever FROM Csvyearcharge WHERE  member = " +DbAdapter.cite(member) );
            if (db.next())
            {
                member = db.getVarchar(1, 1, 2);
                m_04 = db.getBigDecimal(2, 2);
                m_05 = db.getBigDecimal(3, 2);
                m_06 = db.getBigDecimal(4, 2);
                m_07 = db.getBigDecimal(5, 2);
                m_08 = db.getBigDecimal(6, 2);
                m_09 = db.getBigDecimal(7, 2);
                m_10 = db.getBigDecimal(8, 2);
                m_zhuce = db.getBigDecimal(9, 2);
                h_04 = db.getBigDecimal(10, 2);
                h_05 = db.getBigDecimal(11, 2);
                h_06 = db.getBigDecimal(12, 2);
                h_07 = db.getBigDecimal(13, 2);
                h_08 = db.getBigDecimal(14, 2);
                h_09 = db.getBigDecimal(15, 2);
                h_10 = db.getBigDecimal(16, 2);
                h_hou = db.getBigDecimal(17, 2);
                h_forever = db.getBigDecimal(18, 2);

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

    //导入数据时使用的
    public static void create(String member, String community, BigDecimal m_04, BigDecimal m_05, BigDecimal m_06, BigDecimal m_07, BigDecimal m_08, BigDecimal m_09, BigDecimal m_10, BigDecimal m_zhuce, BigDecimal h_04, BigDecimal h_05, BigDecimal h_06, BigDecimal h_07, BigDecimal h_08, BigDecimal h_09, BigDecimal h_10, BigDecimal h_hou, BigDecimal h_forever) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Csvyearcharge(member,community,m_04,m_05,m_06,m_07,m_08,m_09,m_10,m_zhuce,h_04,h_05,h_06,h_07,h_08,h_09,h_10,h_hou,h_forever) VALUES(" + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + " ," + m_04 + "," + m_05 + "," + m_06 + "," + m_07 + "," + m_08 + "," + m_09 + "," + m_10 + "," + m_zhuce + "," + h_04 + "," + h_05 + "," + h_06 + "," + h_07 + "," + h_08 + "," + h_09 + "," + h_10 + "," + h_hou + "," + h_forever + ")");

        } finally
        {
            db.close();
        }
    }

    //注册用户时给费用表添加次用户
    public static void create(String member, String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("insert into Csvyearcharge(member,community)values(" + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + ")");
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    public BigDecimal getH_04()
    {
        return h_04;
    }

    public BigDecimal getH_05()
    {
        return h_05;
    }

    public BigDecimal getH_06()
    {
        return h_06;
    }

    public BigDecimal getH_07()
    {
        return h_07;
    }

    public BigDecimal getH_08()
    {
        return h_08;
    }

    public BigDecimal getH_09()
    {
        return h_09;
    }

    public BigDecimal getH_10()
    {
        return h_10;
    }

    public BigDecimal getH_forever()
    {
        return h_forever;
    }

    public BigDecimal getH_hou()
    {
        return h_hou;
    }

    public BigDecimal getM_04()
    {
        return m_04;
    }

    public BigDecimal getM_05()
    {
        return m_05;
    }

    public BigDecimal getM_06()
    {
        return m_06;
    }

    public BigDecimal getM_07()
    {
        return m_07;
    }

    public BigDecimal getM_08()
    {
        return m_08;
    }

    public BigDecimal getM_09()
    {
        return m_09;
    }

    public BigDecimal getM_10()
    {
        return m_10;
    }

    public BigDecimal getM_zhuce()
    {
        return m_zhuce;
    }

    public String getMember()
    {
        return member;
    }


}
