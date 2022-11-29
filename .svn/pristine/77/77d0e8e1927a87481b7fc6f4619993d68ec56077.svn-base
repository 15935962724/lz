package tea.entity.admin;

import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;

public class Hostelpay extends Exception
{
    private int id;
    private int node;
    private int payment;
    private String paymenttext;

    private static Cache _cache = new Cache(100);
    private boolean exists;
//创建构造函数 初始调用
    public Hostelpay(int id) throws SQLException
    {
        this.id = id;
        load();
    }
//创建静态函数，传值调用 构造函数
    public static Hostelpay find(int id) throws SQLException
    {
        Hostelpay obj = (Hostelpay) _cache.get(new Integer(id));
        if (obj == null)
        {
            obj = new Hostelpay(id);
            _cache.put(new Integer(id), obj);
        }
        return obj;
    }
//通过主键ID 查询数据
    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node,payment,paymenttext FROM Hostelpay WHERE id = " + id);
            if (db.next())
            {
                node = db.getInt(1);
                payment = db.getInt(2);
                paymenttext = db.getString(3);
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

     public static void create(int node,int payment,String paymenttext)throws SQLException
     {
         DbAdapter db = new DbAdapter();
         try{
             db.executeUpdate("INSERT INTO Hostelpay(node,payment,paymenttext)VALUES("+node+","+payment+","+db.cite(paymenttext)+" )");
         }finally
         {
           db.close();
         }
     }

     public void set (int payment,String paymenttext) throws SQLException
     {
         DbAdapter db = new DbAdapter();
         try{
              db.executeUpdate("UPDATE Hostelpay set payment ="+payment+",paymenttext="+db.cite(paymenttext)+" WHERE id= "+id);
         }finally
         {
             db.close();
         }
         this.payment=payment;
         this.paymenttext=paymenttext;
     }

     public static  void delete(int node ) throws SQLException
     {
         DbAdapter db = new DbAdapter();
         try{
             db.executeUpdate("DELETE FROM Hostelpay WHERE node ="+node);
         }
         finally{
             db.close();
         }
     }
     public static Enumeration  find(String sql)throws SQLException
     {
         Vector v =new Vector();
         DbAdapter db = new DbAdapter();
         try{
             db.executeQuery("SELECT id FROM Hostelpay WHERE 1=1 "+sql );
             while(db.next())
             {
                 v.addElement(new Integer(db.getInt(1)));
             }
         }finally
         {
             db.close();
         }
         return v.elements();
     }

     public static Enumeration  findPandT(int node)throws SQLException
     {
         Vector v =new Vector();
         DbAdapter db = new DbAdapter();
         try{
             db.executeQuery("SELECT payment FROM Hostelpay WHERE node="+node );
             while(db.next())
             {
                 v.addElement(new Integer(db.getInt(1)));
             }
         }finally
         {
             db.close();
         }
         return v.elements();
     }


     public static boolean isExisted(int node,int payment) throws SQLException
     {
         boolean flag = false;
         StringBuilder sb = new StringBuilder();
         sb.append("SELECT payment FROM Hostelpay WHERE node="+node+" and payment="+payment);
         DbAdapter db = new DbAdapter(1);
         try
         {
             db.executeQuery(sb.toString());
             flag = db.next();
         } finally
         {
             db.close();
         }
         return flag;
    }
    public static String getPaymenttexts(int node,int payment)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        String str = null;
        try
        {
            db.executeQuery("SELECT paymenttext FROM Hostelpay WHERE node ="+node+" and payment ="+payment);
            while(db.next())
            {
                str = db.getString(1);
            }
        }finally
        {
            db.close();
        }
        return str;
    }
    public boolean isExists()
    {
        return exists;
    }

    public int getNode()
    {
        return node;
    }

    public int getPayment()
    {
        return payment;
    }

    public String getPaymenttext()
    {
        return paymenttext;
    }
}
