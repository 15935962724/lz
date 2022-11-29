package tea.entity.admin;

import java.sql.*;

import tea.db.*;
import tea.entity.*;

public class AdminList
{
  private static Cache _cache = new Cache(100);
  private String member;
  private String name;
  private String field;
  private boolean exists;
  public AdminList(String member, String name) throws SQLException
  {
    this.member = member;
    this.name = name;
    load();
  }

  public static AdminList find(String member, String name) throws SQLException
  {
    AdminList obj = (AdminList) _cache.get(member + ":" + name);
    if (obj == null)
    {
      obj = new AdminList(member, name);
      _cache.put(member + ":" + name, obj);
    }
    return obj;
  }

  public void delete() throws SQLException
  {
    DbAdapter db = new DbAdapter();
    try
    {
      db.executeUpdate("DELETE FROM AdminList WHERE member=" + DbAdapter.cite(member) + " AND name=" + DbAdapter.cite(name));
    } finally
    {
      db.close();
    }
    _cache.remove(member + ":" + name);
  }

  public void set(String field) throws SQLException
  {
    if (exists)
    {
      DbAdapter db = new DbAdapter();
      try
      {
        db.executeUpdate("UPDATE AdminList SET field=" + DbAdapter.cite(field) + " WHERE member=" + DbAdapter.cite(member) + " AND name=" + DbAdapter.cite(name));
      } finally
      {
        db.close();
      }
      this.field = field;
    } else
    {
      create(member, name, field);
      exists = true;
    }
  }

  public static void create(String member, String name, String field) throws SQLException
  {
    DbAdapter db = new DbAdapter();
    try
    {
      db.executeUpdate("INSERT INTO AdminList(member,name,field)VALUES(" + DbAdapter.cite(member) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(field) + ")");
    } finally
    {
      db.close();
    }
  }

  private void load() throws SQLException
  {
    DbAdapter db = new DbAdapter();
    try
    {
      db.executeQuery("SELECT field FROM AdminList WHERE member=" + DbAdapter.cite(member) + " AND name=" + DbAdapter.cite(name));
      if (db.next())
      {
        field = db.getString(1);
        exists = true;
      } else
      {
        exists = false;
        if (name.equals("adminunit"))
        {
          field = "/name/father/linkmanname/address/";
        } else if (name.equals("message"))
        {
          field = "/subject/fmember/time/";
        }
      }
    } finally
    {
      db.close();
    }
  }

  public String getAllField()
  {
    String af = "/";
    if (name.equals("adminunit"))
    {
      af = "/name/ename/father/linkmanname/address/";
    }else if (name.equals("message"))
    {
      af = "/subject/fmember/content/time/";
    }
    return af;
  }

  public String getName()
  {
    return name;
  }

  public String getMember()
  {
    return member;
  }

  public String getField()
  {
    return field;
  }

  public boolean isExists()
  {
    return exists;
  }

  //  public static Enumeration findByMember(String member, String name) throws SQLException
//  {
//    StringBuilder sql = new StringBuilder();
//    sql.append("SELECT adminlist FROM AdminList WHERE member=").append(DbAdapter.cite(member)).append(" AND name=").append(DbAdapter.cite(name));
//    Vector v = new Vector();
//    DbAdapter db = new DbAdapter(1);
//    try
//    {
//      db.executeQuery(sql.toString());
//      while (db.next())
//      {
//        v.addElement(new Integer(db.getInt(1)));
//      }
//    } finally
//    {
//      db.close();
//    }
//    return v.elements();
//  }

}
