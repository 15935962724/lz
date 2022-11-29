package tea.entity.csvclub;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Entity;

import java.sql.SQLException;

//列出会员的信息
public class Csvdoghostinfo extends Entity
{
    private static Cache _cache = new Cache(100);


    private int id;
    private String member; //用户名
    private String firstname; //姓名
    private String card; //身份证
    private boolean exists; //判断值

    public Csvdoghostinfo(String member) throws SQLException
    {
        this.member = member;
        load();
    }

    public Csvdoghostinfo(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static Csvdoghostinfo find(String member) throws SQLException
    {
        return new Csvdoghostinfo(member);
    }

    public static Csvdoghostinfo find(int id) throws SQLException
    {
        return new Csvdoghostinfo(id);
    }

    // 返回数据库中对应的全部字段
    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select  a.member,firstname,a.member,card from profile as  a,profilelayer  as b where a.member=b.member and a.member=" + "'" + member + "'");
            if (db.next())
            {
                this.member = member;
                this.firstname = firstname;
                this.card = card;
                exists = true;
            } else
            {
                exists = false;
            }
        }  finally
        {
            db.close();
        }
    }

    public static java.util.Enumeration findByCommunity(String community, String sql) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select member from Profile where community=" + DbAdapter.cite(community) + sql);
            while (dbadapter.next())
            {
                vector.addElement(String.valueOf(dbadapter.getString(1)));
            }
        } catch (SQLException ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    public String getCard()
    {
        return card;
    }

    public void setCard(String card)
    {
        this.card = card;
    }

    public String getFirstname()
    {
        return firstname;
    }

    public void setFirstname(String firstname)
    {
        this.firstname = firstname;
    }

    public String getMember()
    {
        return member;
    }

    public void setMember(String member)
    {
        this.member = member;
    }
}
