package tea.entity.contract;

import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;

/** 合同id*/
public class Contract extends Entity
{
    private String conid; /** 合同id*/
    private String cname; /** 合同名*/
    private float money; /** 金额*/
    private String time; /** 合同签定时间*/
    private String outtime; /** 合同到期时间*/
    private String member; /** 用户名*/
    private String e_contract; /** 电子合同*/
    private String community; /** 所属社区*/
    private float prepay; /** 合同预交金额id*/
    private String type; /** 项目类型*/
    public Contract()
    {
    }

    public Contract(String member) throws SQLException /** 构造方法  按用户名来查询数据库通过load方法初始化类型对像*/
    {

        this.member = member;
        load1();
    }

    public Contract(String id,String member) throws SQLException /** 构造方法 按用户名 和合同不ID来查询数据库再通过LOAD方法初始化类对像*/
    {
        this.conid = id;
        this.member = member;
        load();
    }

    public String name() throws SQLException /** 从dprofilelayer 表里 查询 用户的姓名*/
    {
        StringBuilder sql = new StringBuilder();
        DbAdapter db = new DbAdapter();
        String name = null;
        sql.append("select firstname,lastname from profilelayer where member=").append(db.cite(member));
        db.executeQuery(sql.toString());
        if(db.next())
        {
            name = db.getString(2);
            name = name + db.getString(1);
        }
        return name;
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select conid,cname,money,time,outtime,member,e_contract,community,prepay,type from Contract where conid=" + db.cite(conid));
            if(db.next())
            {
                conid = db.getString(1);
                cname = db.getString(2);
                money = db.getFloat(3);
                time = db.getString(4);
                outtime = db.getString(5);
                member = db.getString(6);
                e_contract = db.getString(7);
                community = db.getString(8);
                prepay = db.getFloat(9);
                type = db.getString(10);
            }
        } finally
        {
            db.close();
        }

    }

    public void load1() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select conid,cname,money,time,outtime,member,e_contract ,community,prepay,type from Contract where member=" + db.cite(member));
            if(db.next())
            {
                conid = db.getString(1);
                cname = db.getString(2);
                money = db.getFloat(3);
                time = db.getString(4);
                outtime = db.getString(5);
                member = db.getString(6);
                e_contract = db.getString(7);
                community = db.getString(8);
                prepay = db.getFloat(9);
                type = db.getString(10);

            }
        } finally
        {
            db.close();
        }

    }

    public static void del(String id) throws SQLException /** 用来删除合同表中ID和参数一样的记录*/
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete contract where conid=" + db.cite(id));
        } finally
        {
            db.close();
        }
    }

    /** 增加或修改记录*/
    public static void create(String conid,String cname,float money,String time,String outtime,String member,String e_contract,String community,float prepay,String type) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select conid from contract where conid=" + db.cite(conid));
            if(db.next())
            {
                db.executeUpdate("update contract set conid=" + db.cite(conid) + ",cname=" + db.cite(cname) + ",money=" + money + ",time=" + db.cite(time) + ",outtime=" + db.cite(outtime) + ",member=" + db.cite(member) + ",e_contract=" + db.cite(e_contract) + ", community=" + db.cite(community) + ",prepay=" + prepay + ",type=" + db.cite(type) + " where conid=" + db.cite(conid));
            } else
            {

                db.executeUpdate("insert into contract (conid,cname,money,time,outtime,member,e_contract,community,prepay,type) values(" + db.cite(conid) + "," + db.cite(cname) + "," + money + "," + db.cite(time) + "," + db.cite(outtime) + "," + db.cite(member) + "," + db.cite(e_contract) + "," + db.cite(community) + "," + prepay + "," + db.cite(type) + ")");
            }
        } finally
        {
            db.close();
        }
    }

    /** 修改记录*/
    public static void set(String conid,String cname,float money,String time,String outtime,String member,String e_contract,String community,float prepay,String type) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update contract set conid=" + db.cite(conid) + ",cname=" + db.cite(cname) + ",money=" + money + ",time=" + db.cite(time) + ",outtime=" + db.cite(outtime) + ",member=" + db.cite(member) + ",e_contract=" + db.cite(e_contract) + ", community=" + db.cite(community) + ",prepay=" + prepay + ",type=" + db.cite(type) + " where conid=" + db.cite(conid));
        } finally
        {
            db.close();
        }
    }

    /**查询相同的记录个数*/
    public static int findSame(String conid) throws SQLException
    {
        StringBuilder sql = new StringBuilder();
        DbAdapter db = new DbAdapter();
        int same = 0;
        sql.append("select count(*) from contract where conid=").append(db.cite(conid));
        try
        {
            db.executeQuery(sql.toString());
            if(db.next())
            {
                same = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return same;
    }

    /**在数据库中找到合同ID和用户名 生成对像并反回*/
    public static Contract find(String conid,String member) throws SQLException
    {
        Contract obj = new Contract(conid,member);
        return obj;
    }

    public String getCname()
    {
        return cname;
    }

    public String getConid()
    {
        return conid;
    }

    public String getE_contract()
    {
        return e_contract;
    }

    public String getMember()
    {
        return member;
    }

    public float getMoney()
    {
        return money;
    }

    public String getOuttime()
    {
        return outtime;
    }

    public String getTime()
    {
        return time;
    }

    public String getType()
    {
        return type;
    }

    public float getPrepay()
    {
        return prepay;
    }

    public void setCname(String cname)
    {
        this.cname = cname;
    }

    public void setTime(String time)
    {
        this.time = time;
    }

    public void setOuttime(String outtime)
    {
        this.outtime = outtime;
    }

    public void setMoney(float money)
    {
        this.money = money;
    }

    public void setMember(String member)
    {
        this.member = member;
    }

    public void setE_contract(String e_contract)
    {
        this.e_contract = e_contract;
    }

    public void setConid(String conid)
    {
        this.conid = conid;
    }

    public void setCommunity(String community)
    {
        this.community = community;
    }

    public void setType(String type)
    {
        this.type = type;
    }

    public void setPrepay(float prepay)
    {
        this.prepay = prepay;
    }

    public String getCommunity(String community)
    {

        return this.community;
    }

    /** 求参数传来的社区中的记录条数*/
    public static int count(String community) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(distinct member) FROM contract where community= " + db.cite(community));
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

    /** 求当前社区中用户名和传来member值相同的记录条数*/
    public static int count(String community,String member,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM contract  where community=" + DbAdapter.cite(community) + " and member=" + db.cite(member));
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

    /**该方法的用途是 按参数给出的条件：社区 用户ID 前台拼出的SQL 查找从第POS开始的 SIZE条记录 以枚举的形式返回*/
    public static Enumeration find(String community,String member,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            // System.out.print(community);
            db.executeQuery("SELECT conid FROM contract WHERE community=" + DbAdapter.cite(community) + " and member=" + db.cite(member) + sql,pos,size);
            while(db.next())
            {
                v.addElement(db.getString(1)); /*可以用vector 接收对像的方法最后反回 list 以提高性能 */
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    /**该方法的用途是 按参数给出的条件：社区 用户ID 前台拼出的SQL 查找从第POS开始的 SIZE条记录 以list的形式返回*/
    public static List findList(String community,String member,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        Contract c = null;
        DbAdapter db = new DbAdapter();
        try
        {
            // System.out.print(community);
            db.executeQuery("SELECT conid,cname,money,time,outtime,member,e_contract ,community,prepay,type FROM contract WHERE community=" + DbAdapter.cite(community) + " and member=" + db.cite(member) + sql,pos,size);
            while(db.next())
            {

                while(c != null)
                {
                    c = null;
                }
                c = new Contract();
                c.setConid(db.getString(1));
                c.setCname(db.getString(2));
                c.setMoney(db.getFloat(3));
                c.setTime(db.getString(4));
                c.setOuttime(db.getString(5));
                c.setMember(db.getString(6));
                c.setE_contract(db.getString(7));
                c.setCommunity(db.getString(8));
                c.setPrepay(db.getFloat(9));
                c.setType(db.getString(10));
                v.add(c);

            }
        } finally
        {
            db.close();
        }
        return v;
    }

    /**该方法的用途和上面的类似 按参数给出的条件：社区 查找从第POS开始的 SIZE条记录 以枚举的形式返回*/
    public static Enumeration find(String community,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT distinct member FROM contract where community=" + db.cite(community),pos,size);
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

    /**
     * 返回一个List的对像 该对像中包含了 按参数给出的条件：社区 查找从第POS开始的 SIZE条记录
     *
     */
    public static List findList(String community,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        Contract c = null;
        DbAdapter db = new DbAdapter();
        try
        {
            //System.out.println("select conid,cname,money,time,outtime,member,e_contract ,community,prepay,type from contract where conid in(select min(conid)  from contract group by member) and community=" + db.cite(community) );
            db.executeQuery("select conid,cname,money,time,outtime,member,e_contract ,community,prepay,type from contract where conid in(select min(conid)  from contract group by member) and community=" + db.cite(community),pos,size);
            while(db.next())
            {
                while(c != null)
                {
                    c = null;
                }
                c = new Contract();
                c.setConid(db.getString(1));
                c.setCname(db.getString(2));
                c.setMoney(db.getFloat(3));
                c.setTime(db.getString(4));
                c.setOuttime(db.getString(5));
                c.setMember(db.getString(6));
                c.setE_contract(db.getString(7));
                c.setCommunity(db.getString(8));
                c.setPrepay(db.getFloat(9));
                c.setType(db.getString(10));
                v.add(c);

            }
        } finally
        {
            db.close();
        }
        return v;
    }


    /**在数据库中以用户名为条件查找 并生成对像返回*/
    public static Contract find(String member) throws SQLException
    {
        Contract obj = new Contract(member);
        return obj;
    }

    /**求XX社区XX用户从当前月的第一天到当前之间 这些天的合同金额*/
    public float month() throws SQLException
    {
        float num = 0;

        StringBuilder sql = new StringBuilder();

        DbAdapter db = new DbAdapter();
        sql.append("select sum(money)  from contract where time>=getdate()-day(getdate()) and time<=getdate() and member= ").append(db.cite(member)).append(" and community=").append(db.cite(community));
        try
        {
            db.executeQuery(sql.toString());
            if(db.next())
            {
                num = db.getFloat(1);
            }
        } finally
        {
            db.close();
        }
        return num;
    }

    /**求XX社区XX用户的总合同金额*/
    public float sum() throws SQLException
    {
        float sum = 0;
        DbAdapter db = new DbAdapter();
        StringBuilder sql = new StringBuilder();
        sql.append("select sum(money) from contract where community=").append(db.cite(community)).append(" and member =").append(db.cite(member));
        System.out.print(sql.toString());
        try
        {
            db.executeQuery(sql.toString());
            if(db.next())
            {
                sum = db.getFloat(1);
            }
            System.out.println(sum);
        } finally
        {
            db.close();
        }
        return sum;
    }

    /**查找XX用户的所在地*/
    public String area() throws SQLException
    {
        String area = null;
        DbAdapter db = new DbAdapter();
        StringBuilder sql = new StringBuilder();
        sql.append("select city from ProfileLayer where member=").append(db.cite(member));
        try
        {
            db.executeQuery(sql.toString());
            if(db.next())
            {
                area = db.getString(1);
            }
        } finally
        {
            db.close();
        }
        return area;
    }

}
