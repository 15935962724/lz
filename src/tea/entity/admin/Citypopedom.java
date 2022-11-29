package tea.entity.admin;

import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;

public class Citypopedom extends Entity
{
    private int id;
    private String cityid;
    private String member;
    private String community;

    private static Cache _cache = new Cache(100);
    private boolean exists;

    public Citypopedom(int id) throws SQLException
   {
       this.id = id;
       load();
   }

   public static Citypopedom find(int id) throws SQLException
   {
       Citypopedom obj = (Citypopedom) _cache.get(new Integer(id));
       if (obj == null)
       {
           obj = new Citypopedom(id);
           _cache.put(new Integer(id), obj);
       }
       return obj;
   }

   public Citypopedom(String member) throws SQLException
   {
       this.member = member;
       loadmember();
   }

   public static Citypopedom find(String member) throws SQLException
   {
//       Citypopedom obj = (Citypopedom) _cache.get(member);
//       if (obj == null)
//       {
//           obj = new Citypopedom(member);
//           _cache.put(member, obj);
//       }
//       return obj;
       return new Citypopedom(member);
   }



   public void load() throws SQLException
   {
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeQuery("SELECT cityid,member,community FROM Citypopedom WHERE id ="+id);
           if(db.next())
           {
               cityid = db.getString(1);
               member = db.getString(2);
               community = db.getString(3);
               exists = true;
           }else
           {
               exists =false;
           }
       }finally
       {
           db.close();
       }
   }


   public void loadmember() throws SQLException
     {
         DbAdapter db = new DbAdapter();
         try
         {
             db.executeQuery("SELECT cityid,member,community FROM Citypopedom WHERE member ="+db.cite(member));
             if(db.next())
             {
                 cityid = db.getString(1);
                 member = db.getString(2);
                 community = db.getString(3);
                 exists = true;
             }else
             {
                 exists =false;
             }
         }finally
         {
             db.close();
         }
   }
   public static void create(String cityid,String member,String community)throws SQLException
      {
          DbAdapter db = new DbAdapter();
          try
          {
              db.executeUpdate("INSERT INTO Citypopedom(cityid,member,community)VALUES("+db.cite(cityid)+","+db.cite(member)+","+db.cite(community)+"  )");
          }finally
          {
              db.close();
          }
   }
   public void set(String cityid,String member)throws SQLException
  {
      DbAdapter db = new DbAdapter();
      try
      {
          db.executeUpdate("UPDATE Citypopedom SET cityid ="+db.cite(cityid)+" ,member ="+db.cite(member)+" where id="+id);
      }finally
      {
          db.close();
      }
      this.cityid=cityid;
      this.member=member;
  }
  public void delete () throws SQLException
     {
         DbAdapter db = new DbAdapter();
         try
         {
             db.executeUpdate("DELETE FROM Citypopedom WHERE id="+id);
         }finally
         {
         db.close();
         }
   }
   public static int count(String community,String sql)throws SQLException
   {
       int i =0;
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeQuery("SELECT COUNT(*) FROM Citypopedom WHERE community="+db.cite(community) + sql);
           while(db.next())
           {
               i = db.getInt(1);
           }
       }finally
       {
           db.close();
       }
       return i;
   }
   public static Enumeration find(String community ,String sql,int pos,int size)throws SQLException
  {
      Vector v = new Vector();
      DbAdapter db = new DbAdapter();
      try
      {
          db.executeQuery("SELECT id FROM Citypopedom WHERE community="+db.cite(community) + sql);
          for(int k =0;k<pos+size && db.next();k++)
          {
              if(k >= pos)
              {
                  v.addElement(new Integer(db.getInt(1)));
              }
          }
      }finally
      {
       db.close();
      }
      return v.elements();
  }

  public static boolean isExisted(String member) throws SQLException
     {
         boolean flag = false;
         StringBuilder sb = new StringBuilder();
         sb.append("SELECT member FROM Citypopedom WHERE member=").append(DbAdapter.cite(member));
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

    public String getCityid()
    {
        return cityid;
    }

    public String getCommunity()
    {
        return community;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getMember()
    {
        return member;
    }


}
