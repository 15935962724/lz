package tea.entity.integral;


import java.sql.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;


public class IntegralUpdate extends Entity
{
    private int id;
    private String member; //管理员
    private String community;
    private String users; //用户ID
    private int add_int; //加
    private int minus_int; //减
    private String remarks; //内容
    private Date updatetimes; //提交时间
    private int statics; //状态  提出申请，审核，
    private String memberps;

    private boolean isexists;
    public static final String STATIC[] =
                                          {"    ", "未审核", "审核通过"};

    public IntegralUpdate(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static IntegralUpdate find(int id) throws SQLException
    {
        return new IntegralUpdate(id);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select id,member,community,add_int,minus_int,remarks,updatetimes,users,statics,memberps from IntegralUpdate where id =" + id);
            if (db.next())
            {
                id = db.getInt(1);
                member = db.getString(2);
                community = db.getString(3);
                add_int = db.getInt(4);
                minus_int = db.getInt(5);
                remarks = db.getString(6);
                updatetimes = db.getDate(7);
                users = db.getString(8);
                statics = db.getInt(9);
                memberps = db.getString(10);
                isexists = true;
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(String member, String community, int add_int, int minus_int, String remarks, Date updatetimes, String users, int statics) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("insert into IntegralUpdate(member,community,add_int,minus_int,remarks,updatetimes,users,statics) values (" + db.cite(member) + "," + db.cite(community) + "," + add_int + "," + minus_int + "," + db.cite(remarks) + "," + db.cite(updatetimes) + "," + db.cite(users) + "," + statics + " )");

        } finally
        {
            db.close();
        }
    }

    public static void set(int id, String member, String community, int add_int, int minus_int, String remarks, Date updatetimes, String users, int statics) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update IntegralUpdate set member=" + db.cite(member) + ",community=" + db.cite(community) + ",add_int=" + add_int + ",minus_int=" + minus_int + ",remarks=" + db.cite(remarks) + ",updatetimes=" + db.cite(updatetimes) + ",users=" + db.cite(users) + ",statics=" + statics + " where id =" + id);
        } finally
        {
            db.close();
        }
    }

    public static void delete(int id) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete IntegralUpdate where id =" + id);

        } finally
        {
            db.close();
        }
    }

    public static java.util.Enumeration findByIntegral(String community, String sql, int pos, int pageSize) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM IntegralUpdate WHERE community=" + DbAdapter.cite(community) + sql);

            for (int l = 0; l < pos + pageSize && db.next(); l++)
            {
                if (l >= pos)
                {
                    vector.addElement(String.valueOf(db.getInt(1)));
                }
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static void updatestatic(int id, int statics, String community, String memberps) throws SQLException
    {
        Date dates = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update IntegralUpdate set statics =" + statics + ",memberps=" + db.cite(memberps) + "where community=" + db.cite(community) + "and id =" + id);

            IntegralUpdate obj = IntegralUpdate.find(id);
            obj.getUsers();
            obj.getAdd_int();
            obj.getMinus_int();
            int integers = 0;
            int types = 0;
            if (obj.getAdd_int() > 0)
            {
                integers = obj.getAdd_int();
                types = 7;
                 IntegralCycle.create(obj.getUsers(), integers, dates, types, community);
            } else if (obj.getMinus_int() > 0)
            {
                integers = obj.getMinus_int();
                types = 8;
                 IntegralCycle.create(obj.getUsers(), integers, dates, types, community);
            }


            //IntegralCycle.create("user",1,dates,);
        } catch (Exception ex)
        {

            ex.printStackTrace();
        }

        finally
        {
            db.close();
        }

    }

    public static int findsum(String member, String community, String str) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int sum = 0;
        try
        {
            db.executeQuery("select SUM(" + str + ") from IntegralUpdate where community=" + db.cite(community) + " and users=" + db.cite(member) + " and statics=2");
            if (db.next())
            {
                sum = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return sum;
    }

    public static int findsum(String community, String sql) throws SQLException
        {
            DbAdapter db = new DbAdapter();
            int sum = 0;
            try
            {
                db.executeQuery("select count(id) from IntegralUpdate where community=" + db.cite(community) + sql.toString());
                if (db.next())
                {
                    sum = db.getInt(1);
                }
            } finally
            {
                db.close();
            }
            return sum;
    }



    public Date getUpdatetimes()
    {
        return updatetimes;

    }

    public int getAdd_int()
    {
        return add_int;
    }

    public String getCommunity()
    {
        return community;
    }

    public int getId()
    {
        return id;
    }

    public String getMember()
    {
        return member;
    }

    public int getMinus_int()
    {
        return minus_int;
    }

    public String getRemarks()
    {
        return remarks;
    }

    public boolean isIsexists()
    {
        return isexists;
    }

    public String getUsers()
    {
        return users;
    }

    public int getStatics()
    {
        return statics;
    }

    public String getMemberps()
    {
        return memberps;
    }
}
