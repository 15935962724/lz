package tea.entity.csvclub;

import java.math.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;
import java.util.*;

public class Csvpresent extends Entity
{
    private int id;
    private int warename; //赠送的商品的id
    private BigDecimal price; //赠品价格
    private String mbertype; // 会员的类型
    private BigDecimal consume; //一次性消费的钱数
    private int bindware; //绑定的商品的id
    private String remark; // 备注
    private Date times; //添加时间


    private static Cache _cache = new Cache(100);
    private boolean exists;

    public Csvpresent(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static Csvpresent find(int id) throws SQLException
    {
        return new Csvpresent(id);
    }


    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select warename,price,mbertype,consume,bindware,remark,times from Csvpresent where id=" + id);
            if (db.next())
            {
                warename = db.getInt(1);
                price = db.getBigDecimal(2, 2);
                mbertype = db.getString(3);
                consume = db.getBigDecimal(4, 2);
                bindware = db.getInt(5);
                remark = db.getVarchar(1, 1, 6);
                times = db.getDate(7);

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

    public static void create(int warename, BigDecimal price, String mbertype, BigDecimal consume, int bindware, String remark, String member, String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("insert into Csvpresent (warename,price,mbertype,consume,bindware,remark,times,member,community) values (" + warename + "," + price + "," + DbAdapter.cite(mbertype) + "," + consume + "," + bindware + "," + DbAdapter.cite(remark) + "," + DbAdapter.cite(times) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + " )");
        } finally
        {
            db.close();
        }
    }


    public void set(int warename, BigDecimal price, String mbertype, BigDecimal consume, int bindware, String remark) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("update Csvpresent set  warename=" + warename + ",price=" + price + ",mbertype=" + DbAdapter.cite(mbertype) + ",consume=" + consume + ",bindware=" + bindware + ",remark=" + DbAdapter.cite(remark) + ",times=" + DbAdapter.cite(times) + " where id=" + id);
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    public void detele() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from Csvpresent where id=" + id);
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    public static java.util.Enumeration findByCommunity(String community, String sql, int pos, int pageSize) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT  id FROM Csvpresent WHERE community=" + DbAdapter.cite(community) + sql);

            for (int l = 0; l < pos + pageSize && dbadapter.next(); l++)
            {
                if (l >= pos)
                {
                    int id = dbadapter.getInt(1);
                    vector.addElement(new Integer(id));
                }
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    public static int count(String community, String sql) throws SQLException
    {
        int count = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT COUNT(cs.id) FROM Csvpresent cs WHERE cs.community=" + dbadapter.cite(community) + sql);
            if (dbadapter.next())
            {
                count = dbadapter.getInt(1);
            }
        } finally
        {
            dbadapter.close();
        }
        return count;
    }

    //判断用户是否在赠品里是否存在
    public static boolean isBind(int warename) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id  FROM Csvpresent  where bindware=" + warename);

            if (db.next())
            {
                flag = true;
            }

        } finally
        {
            db.close();
        }
        return flag;
    }

    //判断一次性购买东西的钱数
    public static boolean isConsume(BigDecimal p, int warename) throws SQLException
    {
        boolean flag = false;
        BigDecimal a = new BigDecimal(0);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT consume  FROM Csvpresent  where warename=" + warename);

            if (db.next())
            {
                a = db.getBigDecimal(1, 2);
                if (p.compareTo(a) == 1)
                {
                    flag = true;
                }
            }

        } finally
        {
            db.close();
        }
        return flag;
    }

    //判断用户类型是否符合赠品要求的用户类型
    public static boolean isMember(int layid, int warename) throws SQLException
    {
        boolean flag = false;

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT consume  FROM Csvpresent  where warename=" + warename + " and mbertype like " + DbAdapter.cite("%/" + layid + "%"));

            if (db.next())
            {
                flag = true;
            }

        } finally
        {
            db.close();
        }
        return flag;
    }

    public int getWarename()
    {
        return warename;
    }

    public BigDecimal getPrice()
    {
        return price;
    }

    public String getMbertype()
    {
        return mbertype;
    }

    public BigDecimal getConsume()
    {
        return consume;
    }

    public int getBindware()
    {
        return bindware;
    }

    public String getRemark()
    {
        return remark;
    }

    public Date getTimes()
    {
        return times;
    }

}
