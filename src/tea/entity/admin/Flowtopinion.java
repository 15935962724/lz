package tea.entity.admin;

import java.sql.*;
import java.util.*;
import tea.db.*;
import tea.entity.*;

//常用意见
public class Flowtopinion
{
  private static Cache _cache = new Cache(100);
  public static String OPTINION_TYPE[] =
      {"公用意见", "私用意见"};
  private int flowtopinion;
  private String community;
  private int type;
  private String member;
  private String content;
  private boolean exists;

  public Flowtopinion(int flowtopinion) throws SQLException
  {
    this.flowtopinion = flowtopinion;
    load();
  }

  public static Flowtopinion find(int flowtopinion) throws SQLException
  {
    Flowtopinion obj = (Flowtopinion) _cache.get(flowtopinion);
    if (obj == null)
    {
      obj = new Flowtopinion(flowtopinion);
      _cache.put(flowtopinion, obj);
    }
    return obj;
  }

  public static Enumeration find(String community, String sql) throws SQLException
  {
    Vector v = new Vector();
    DbAdapter db = new DbAdapter();
    try
    {
      db.executeQuery("SELECT flowtopinion FROM Flowtopinion WHERE community=" + DbAdapter.cite(community) + sql);
      while (db.next())
      {
        v.addElement(db.getInt(1));
      }
    } finally
    {
      db.close();
    }
    return v.elements();
  }

  public void delete() throws SQLException
  {
    DbAdapter db = new DbAdapter();
    try
    {
      db.executeUpdate("DELETE FROM Flowtopinion WHERE flowtopinion=" + flowtopinion);
    } finally
    {
      db.close();
    }
    _cache.remove(flowtopinion);
  }

  public void set(int type, String content) throws SQLException
  {
    StringBuffer sql = new StringBuffer();
    sql.append("UPDATE Flowtopinion SET type=" + type + ",content=").append(DbAdapter.cite(content)).append(" WHERE flowtopinion=").append(flowtopinion);
    DbAdapter db = new DbAdapter();
    try
    {
      db.executeUpdate(sql.toString());
    } finally
    {
      db.close();
    }
    this.type = type;
    this.content = content;
  }

  public static void create(String community, int type, String member, String content) throws SQLException
  {
    DbAdapter db = new DbAdapter();
    try
    {
      db.executeUpdate("INSERT INTO Flowtopinion(community,type,member,content)VALUES(" + DbAdapter.cite(community) + "," + type + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(content) + ")");
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
      db.executeQuery("SELECT community,type,member,content FROM Flowtopinion WHERE flowtopinion=" + flowtopinion);
      if (db.next())
      {
        community = db.getString(1);
        type = db.getInt(2);
        member = db.getString(3);
        content = db.getText(4);
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

  public int getType()
  {
    return type;
  }

  public boolean isExists()
  {
    return exists;
  }

  public String getCommunity()
  {
    return community;
  }

  public String getMember()
  {
    return member;
  }

  public String getContent()
  {
    return content;
  }

}
