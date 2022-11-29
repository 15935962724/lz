package tea.entity.node;

import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;

public class Expenserecord extends Entity
{
    private int destine; //定单号
    private String kipdate; //入住日期
    private String leavedate; //离开日期
    private int roomprice; //房间类型
    private int roomcount; //房间数量
    private float money; //金额
    private int audit;

    public Expenserecord()
    {
    }

    //用于向数据库中插入一条记录
    public static void create(int destine,String kipdate,String leavedate,int roomprice,int roomcount,float money,int audit,int flag) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        String sql = "insert into expenserecord values(" + destine + ",'" + kipdate + "','" + leavedate + "'," + roomprice + "," + roomcount + "," + money + "," + audit + ")";
        System.out.println(sql);
        try
        {
            db.executeUpdate(sql);
        } finally
        {
            db.close();
        }
    }

    public static int count(String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int i = 0;
        try
        {
            db.executeQuery("select count(*) from expenserecord where 1=1 " + sql);
            if(db.next())
            {
                i = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return i;
    }

    public void sqlExe(String sql)
    { //用于执行增删改操作的sql语句
        DbAdapter db = new DbAdapter();

        try
        {
            db.executeUpdate(sql);
        } catch(SQLException ex)
        {
            ex.printStackTrace();
        } finally
        {
            db.close();
        }
    }

    public void create() throws SQLException //利用本类对像向数据库中插入一条记录
    {
        DbAdapter db = new DbAdapter();
        String sql = "insert into expenserecord values(" + destine + ",'" + kipdate + "','" + leavedate + "'," + roomprice + "," + roomcount + "," + money + "," + audit + ")";
        System.out.println(sql);
        try
        {
            db.executeUpdate(sql);
        } finally
        {
            db.close();
        }

    }

    public static List select(String sql)
    { //用于执行查询语句
        ArrayList al = new ArrayList();
        Expenserecord exp = new Expenserecord();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(sql);
            while(db.next())
            {
                exp = new Expenserecord();
                exp.setDestine(db.getInt(1));
                exp.setKipdate(db.getString(2));
                exp.setLeavedate(db.getString(3));

                exp.setRoomprice(db.getInt(4));
                exp.setRoomcount(db.getInt(5));
                exp.setMoney(db.getFloat(6));
                exp.setAudit(db.getInt(7));

                al.add(exp);
                exp = null;

            }
        } catch(Exception e)
        {
            e.printStackTrace();
        } finally
        {
            db.close();
        }

        return al;
    }

    public static List select(String sql,int pos,int size) throws SQLException
    { //用于分页查询 sql 查询语句 pos 表示每页的开始的记录号 size表示 每页多少条记录
        ArrayList al = new ArrayList();
        Expenserecord exp = new Expenserecord();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(sql,pos,size);
            while(db.next())
            {
                exp = new Expenserecord();
                exp.setDestine(db.getInt(1));
                exp.setKipdate(db.getString(2));
                exp.setLeavedate(db.getString(3));
                exp.setRoomprice(db.getInt(4));
                exp.setRoomcount(db.getInt(5));
                exp.setMoney(db.getFloat(6));
                exp.setAudit(db.getInt(7));
                al.add(exp);
                exp = null;
            }
        } finally
        {
            db.close();
        }

        return al;
    }

    //用于增加或修改记录
    public static void set(int destine,String kipdate,String leavedate,int roomprice,int roomcount,float money,int audit,int flag) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        String sql;
        db.executeQuery("select * from expenserecord where destine ='" + destine);
        try
        {
            if(db.next())
            {
                sql = "update expenserecord set kipdate='" + kipdate + "',leavedate='" + leavedate + "',roomprice=" + roomprice + ",roomcount=" + roomcount + ",money=" + money + ",audit=" + audit + " where destine=" + destine;
                db.executeUpdate(sql);

            } else
            {
                sql = "insert into expenserecord values(" + destine + ",'" + kipdate + "','" + leavedate + "'," + roomprice + "," + roomcount + "," + money + "," + audit + ")";
            }
        } finally
        {
            db.close();
        }
    }

    public void set() throws SQLException //利用本类对像增加或修改记录
    {
        DbAdapter db = new DbAdapter();
        String sql;

        db.executeQuery("select * from expenserecord where destine =" + destine);
        try
        {
            if(db.next())
            {
                sql = "update expenserecord set kipdate='" + kipdate + "',leavedate='" + leavedate + "',roomprice=" + roomprice + ",roomcount=" + roomcount + ",money=" + money + ",audit=" + audit + " where destine=" + destine;
              //  System.out.println(sql.toString());
                db.executeUpdate(sql);
            } else
            {
                sql = "insert into expenserecord values(" + destine + ",'" + kipdate + "','" + leavedate + "'," + roomprice + "," + roomcount + "," + money + "," + audit + ")";
                db.executeUpdate(sql);
            }
        } finally
        {
            db.close();
        }

    }

    public static List findAll()
    { //返回所有记录列表
        DbAdapter db = new DbAdapter();
        ArrayList list = new ArrayList();
        Expenserecord exp = null;
        String sql = "select * from expenserecord";
        try
        {
            db.executeQuery(sql);
            while(db.next())
            {
                exp = new Expenserecord();
                exp.setDestine(db.getInt(1));
                exp.setKipdate(db.getString(2));
                exp.setLeavedate(db.getString(3));

                exp.setRoomprice(db.getInt(4));
                exp.setRoomcount(db.getInt(5));
                exp.setMoney(db.getFloat(6));
                exp.setAudit(db.getInt(7));

                list.add(exp);
                exp = null;
            }
        } catch(SQLException ex)
        {
        } finally
        {
            db.close();
        }
        return list;
    }

    public int getDestine()
    {
        return destine;
    }

    public String getKipdate()
    {
        return kipdate;
    }

    public String getLeavedate()
    {
        return leavedate;
    }

    public float getMoney()
    {
        return money;
    }

    public int getRoomcount()
    {
        return roomcount;
    }

    public int getRoomprice()
    {
        return roomprice;
    }

    public int getAudit()
    {
        return audit;
    }


    public void setRoomprice(int roomprice)
    {
        this.roomprice = roomprice;
    }

    public void setRoomcount(int roomcount)
    {
        this.roomcount = roomcount;
    }

    public void setMoney(float money)
    {
        this.money = money;
    }

    public void setLeavedate(String leavedate)
    {
        this.leavedate = leavedate;
    }

    public void setKipdate(String kipdate)
    {
        this.kipdate = kipdate;
    }

    public void setDestine(int destine)
    {
        this.destine = destine;
    }

    public void setAudit(int audit)
    {
        this.audit = audit;
    }


}
