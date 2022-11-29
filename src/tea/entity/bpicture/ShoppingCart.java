package tea.entity.bpicture;
import java.sql.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import java.util.Vector;
import java.util.Enumeration;

public class ShoppingCart extends Entity
{
    public static void create(String email,int node) throws SQLException
   {
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeUpdate("Insert into bshopcart values("+db.cite(email)+", "+node+")");
       } finally
       {
           db.close();
       }
   }

   public static boolean isExisted(String email, int node) throws SQLException
    {
        boolean flag = false;

            StringBuilder sb = new StringBuilder();
            sb.append("SELECT email FROM bshopcart WHERE email=").append(DbAdapter.cite(email)).append(" and picid=").append(node);
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


   public static void delete(String email,int node) throws SQLException
   {
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeUpdate("delete from bshopcart where email="+db.cite(email)+" and picid="+node);
       } finally
       {
           db.close();
       }
   }

   public static int countPic(String email) throws SQLException
   {
       int i = 0;
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeQuery("select count(*) from bshopcart where email="+db.cite(email));
           while(db.next())
           {
               i = db.getInt(1);
           }
       } finally
       {
           db.close();
       }
       return i;
   }

   public static int countNoPrice(String email) throws SQLException
      {
          int i = 0;
          DbAdapter db = new DbAdapter();
          try
          {
              db.executeQuery("select count(*) from picture where node in(select picid from bshopcart where email="+db.cite(email)+") and price=0");
              while(db.next())
              {
                  i = db.getInt(1);
              }
          } finally
          {
              db.close();
          }
          return i;
   }


   public static Enumeration noPriceImage(String email) throws SQLException
   {
       Vector v = new Vector();
       DbAdapter db = new DbAdapter(1);
       try
       {

           db.executeQuery("select node from picture where node in(select picid from bshopcart where email="+db.cite(email)+") and price=0;");
           while(db.next())
           {
               v.addElement(db.getInt(1));
           }
       } finally
       {
           db.close();
       }
       return v.elements();
   }


   public static int countSumMoney(String email) throws SQLException
      {
          int i = 0;
          DbAdapter db = new DbAdapter();
          try
          {
              db.executeQuery("select sum(price) from picture where node in(select picid from bshopcart where email="+db.cite(email)+") and price!=0");
              while(db.next())
              {
                  i = db.getInt(1);
              }
          } finally
          {
              db.close();
          }
          return i;
   }


   public static Enumeration findShopping(String email) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {

            db.executeQuery("SELECT picid FROM bshopcart WHERE email=" + DbAdapter.cite(email));
            while(db.next())
            {
                v.addElement(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }



}
