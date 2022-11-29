package tea.entity.admin;
import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;

public class City extends Entity
{
   private int id;
   private int father;
   private String cityname;
   private String member;
   private String community;

   private static Cache _cache = new Cache(100);
   private boolean exists;

   public City(int id) throws SQLException
   {
       this.id = id;
       load();
   }

   public static City find (int id)throws SQLException
   {
       City  obj =(City)_cache.get(new Integer(id));
       if(obj == null)
       {
           obj = new City(id);
           _cache.put(new Integer(id),obj);
       }
       return obj;
   }

   public void load() throws SQLException
   {
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeQuery("SELECT father,cityname,member,community FROM City WHERE id ="+id);
           if(db.next())
           {
               father = db.getInt(1);
               cityname = db.getString(2);
               member = db.getString(3);
               community = db.getString(4);
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

   public static void create(int father,String cityname,String member,String community)throws SQLException
   {
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeUpdate("INSERT INTO City(father,cityname,member,community)VALUES("+father+","+db.cite(cityname)+","+db.cite(member)+","+db.cite(community)+"  )");
       }finally
       {
           db.close();
       }
   }

   public void set(int father,String cityname)throws SQLException
   {
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeUpdate("UPDATE City SET father ="+father+" ,cityname ="+db.cite(cityname)+" where id="+id);
       }finally
       {
           db.close();
       }
       this.father= father;
       this.cityname=cityname;
   }
   public void delete () throws SQLException
   {
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeUpdate("DELETE FROM City WHERE id="+id);
       }finally
       {
       db.close();
       }
   }

   public void delete (int father) throws SQLException
   {
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeUpdate("DELETE FROM City WHERE father="+father);
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
           db.executeQuery("SELECT COUNT(*) FROM City WHERE community="+db.cite(community) + sql);
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
           db.executeQuery("SELECT id FROM City WHERE community="+db.cite(community) + sql+"  order by cityname asc");
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

    public String getCityname()
    {
        return cityname;
    }

    public String getCommunity()
    {
        return community;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getFather()
    {
        return father;
    }

    public String getMember()
    {
        return member;
    }

}
