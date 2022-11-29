package tea.entity.member;

import java.sql.SQLException;
import tea.db.DbAdapter;
import java.util.Vector;
import java.util.Enumeration;

public class InCarteMethod
{
    public static void insertCarte(String member,String companyname) throws SQLException
    {

        //创建DbAdapter实例
        DbAdapter db = new DbAdapter();
        try
        {
            //返回一条SQL语句为插入注册信息

            db.executeUpdate("INSERT INTO storecarte(member, operate, company, Idate, cartypeid) VALUES(" + db.cite(member) + ", 0, " + db.cite(companyname) + ", getDate(), 1)");

        } finally
        {
            //关闭数据库连接
            db.close();
        }
    }

    public static void addCard(String cardName,String member) throws SQLException
    {

        //创建DbAdapter实例
        DbAdapter db = new DbAdapter();
        try
        {
            //返回一条SQL语句为插入注册信息

            db.executeUpdate("INSERT INTO cartewarehouse(cardtypename, member) VALUES(" + db.cite(cardName) + ", " + db.cite(member) + ")");

        } finally
        {
            //关闭数据库连接
            db.close();
        }
    }

    public static void upCardName(int cid,String cardName) throws SQLException
    {

        //创建DbAdapter实例
        DbAdapter db = new DbAdapter();
        try
        {
            //返回一条SQL语句为插入注册信息

            db.executeUpdate("UPDATE cartewarehouse SET cardtypename=" + db.cite(cardName) + "WHERE cardtypeid=" + cid);
            System.out.println("UPDATE cartewarehouse SET cardtypename=" + db.cite(cardName) + "WHERE cardtypeid=" + cid);
        } finally
        {
            //关闭数据库连接
            db.close();
        }
    }

    public static void upLocation(int cartypeid,int cid) throws SQLException
    {

        //创建DbAdapter实例
        DbAdapter db = new DbAdapter();
        try
        {
            //返回一条SQL语句为插入注册信息

            db.executeUpdate("UPDATE storecarte SET cartypeid=" + cartypeid + "WHERE cid=" + cid);

        } finally
        {
            //关闭数据库连接
            db.close();
        }
    }


    public static int findCarteOper(int cid) throws SQLException
    {
        int i = 2;
        //创建DbAdapter实例
        DbAdapter db = new DbAdapter();
        try
        {
            //返回一条SQL语句为插入注册信息

            db.executeQuery("SELECT operate FROM storecarte WHERE cid=" + cid);
            if(db.next())
            {
                i = db.getInt(1);
            }
        } finally
        {
            //关闭数据库连接
            db.close();
        }
        return i;
    }

    public static void updateCarteOper(int cid,int oper) throws SQLException
    {

        //创建DbAdapter实例
        DbAdapter db = new DbAdapter();
        try
        {
            //返回一条SQL语句为插入注册信息

            db.executeUpdate("UPDATE storecarte SET operate=" + oper + " where cid=" + cid);

        } finally
        {
            //关闭数据库连接
            db.close();
        }

    }

    public static void deleteCarte(int checkbox) throws SQLException
    {

        //创建DbAdapter实例
        DbAdapter db = new DbAdapter();
        try
        {
            //返回一条SQL语句为插入注册信息

            db.executeUpdate("DELETE FROM storecarte where cid=" + checkbox);

        } finally
        {
            //关闭数据库连接
            db.close();
        }

    }

    public static void delCarteHouse(int cardtypeid) throws SQLException
    {

        //创建DbAdapter实例
        DbAdapter db = new DbAdapter();
        try
        {
            //返回一条SQL语句为插入注册信息

            db.executeUpdate("DELETE FROM cartewarehouse where cardtypeid=" + cardtypeid);
            db.executeUpdate("DELETE FROM storecarte where cartypeid=" + cardtypeid);
        } finally
        {
            //关闭数据库连接
            db.close();
        }

    }

    public static int findNode(String subject) throws SQLException
    {
        int i = 0;
        //创建DbAdapter实例
        DbAdapter db = new DbAdapter();
        try
        {
            //返回一条SQL语句为插入注册信息

            db.executeQuery("select node from nodelayer where subject=" + db.cite(subject));
            while(db.next())
            {
                i = db.getInt(1);
            }
        } finally
        {
            //关闭数据库连接
            db.close();
        }
        return i;

    }


    public static String findCarte(int checkbox) throws SQLException
    {
        String result = "此名片夹无名片！";
        //创建DbAdapter实例
        DbAdapter db = new DbAdapter();
        try
        {
            //返回一条SQL语句为插入注册信息

            db.executeUpdate("select t2.company from cartewarehouse t1 right join storecarte t2 on t1.cardtypeid = t2.cartypeid where t1.cardtypeid=" + checkbox);
            while(db.next())
            {
                result = db.getString(1);
            }
        } finally
        {
            //关闭数据库连接
            db.close();
        }
        return result;
    }

    public static Enumeration findCbInfo(int pos,int size,int checkbox) throws SQLException
    {
        //创建相关集合类的对象
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();

        try
        {
            //查询出订单编号
            db.executeQuery("select t2.cid from cartewarehouse t1 right join storecarte t2 on t1.cardtypeid = t2.cartypeid where t2.operate=1 and t1.cardtypeid=" + checkbox,pos,size);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1))); //循环遍历订单编号，每循环一次把编号放入集合V中
            }
        } finally
        {
            db.close();
        }
        //返回此集合
        return v.elements();
    }

    public static Enumeration findCarte(int pos,int size,String member) throws SQLException
    {
        //创建相关集合类的对象
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();

        try
        {
            //查询出订单编号
            db.executeQuery("SELECT Cid FROM storecarte where member=" + db.cite(member),pos,size);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1))); //循环遍历订单编号，每循环一次把编号放入集合V中
            }
        } finally
        {
            db.close();
        }
        //返回此集合
        return v.elements();
    }

    public static Enumeration findCompanye(String member,String company) throws SQLException
    {
        //创建相关集合类的对象
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();

        try
        {
            //查询出订单编号
            db.executeQuery("select company from storecarte where member=" + db.cite(member) + " and company=" + db.cite(company));
            //循环遍历订单编号，每循环一次把编号放入集合V中
            for(int k = 0;db.next();k++)
            {
                v.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        //返回此集合
        return v.elements();
    }


    public static Enumeration noKind(int pos,int size,String member) throws SQLException
    {
        //创建相关集合类的对象
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();

        try
        {
            //查询出订单编号
            db.executeQuery("select t2.cid, t2.company, t2.idate from cartewarehouse t1 right join storecarte t2 on t1.cardtypeid = t2.cartypeid where t1.cardtypeid=1 and t2.operate=1 and t2.member=" + db.cite(member) + " order by t2.idate asc",pos,size);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        //返回此集合
        return v.elements();
    }

}
