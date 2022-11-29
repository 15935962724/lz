package tea.entity.im;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class ImMessage extends Entity
{
  private static Cache _cache = new Cache(100);
  private int immessage;
  private String community;
  private String sessionid;
  private String fmember;
  private String tmember;
  private String content;
  private String ip;
  private boolean reader;
  private Date time;

  public ImMessage(int immessage) throws SQLException
  {
    this.immessage = immessage;
    load();
  }

  public ImMessage(int immessage, String community, String sessionid, String fmember, String tmember, String content, String ip, Date time)
  {
    this.immessage = immessage;
    this.community = community;
    this.sessionid = sessionid;
    this.fmember = fmember;
    this.tmember = tmember;
    this.content = content;
    this.ip = ip;
    this.time = time;
  }

  private void load() throws SQLException
  {
    DbAdapter db = new DbAdapter();
    try
    {
      db.executeQuery("SELECT community,sessionid,fmember,tmember,content,ip,reader,time FROM ImMessage WHERE immessage=" + immessage);
      if (db.next())
      {
        community = db.getString(1);
        sessionid = db.getString(2);
        fmember = db.getString(3);
        tmember = db.getString(4);
        content = db.getString(5);
        ip = db.getString(6);
        reader = db.getInt(7) != 0;
        time = db.getDate(8);
      }
    } finally
    {
      db.close();
    }
  }

  //查询：（枚举类型）
  public static Enumeration find(String community, String sql, int pos, int size) throws SQLException
  {
    Vector v = new Vector();
    DbAdapter db = new DbAdapter();
    try
    {
      db.executeQuery("SELECT immessage,community,sessionid,fmember,tmember,content,ip,time FROM ImMessage WHERE community=" + DbAdapter.cite(community) + sql);
      while (db.next())
      {
        ImMessage obj = new ImMessage(db.getInt(1), db.getString(2), db.getString(3), db.getString(4), db.getString(5), db.getString(6), db.getString(7), db.getDate(8));
        v.addElement(obj);
      }
    } finally
    {
      db.close();
    }
    return v.elements();
  }

  public static Enumeration findByTMember(String community, String tmember, String sql) throws SQLException
  {
    Vector v = new Vector();
    DbAdapter db = new DbAdapter();
    try
    {
      db.executeQuery("SELECT DISTINCT fmember FROM ImMessage WHERE community=" + DbAdapter.cite(community) + " AND tmember=" + DbAdapter.cite(tmember) + sql);
      while (db.next())
      {
        v.addElement(db.getString(1));
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
      db.executeUpdate("DELETE FROM ImMessage WHERE immessage=" + immessage);
    } finally
    {
      db.close();
    }
    _cache.remove(new Integer(immessage));
  }

  public static void create(String community, String sessionid, String fmember, String tmember, String content, String ip) throws SQLException
  {
    //content = content.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("&", "&amp;");
    DbAdapter db = new DbAdapter();
    try
    {
      db.executeUpdate("INSERT INTO ImMessage(community,sessionid,fmember,tmember,content,ip,reader,time) VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(sessionid) + "," + DbAdapter.cite(fmember) + "," + DbAdapter.cite(tmember) + "," + DbAdapter.cite(content) + "," + DbAdapter.cite(ip) + ",0," + db.citeCurTime() + ")");
    } finally
    {
      db.close();
    }
  }

  public static ImMessage find(int immessage) throws SQLException
  {
    ImMessage obj = (ImMessage) _cache.get(new Integer(immessage));
    if (obj == null)
    {
      obj = new ImMessage(immessage);
      _cache.put(new Integer(immessage), obj);
    }
    return obj;
  }

  public String getCommunity()
  {
    return community;
  }

  public String getSessionid()
  {
    return sessionid;
  }

  public int getImMessage()
  {
    return immessage;
  }

  public String getFMember()
  {
    return fmember;
  }

  public String getTMember()
  {
    return tmember;
  }

  public String getContent()
  {
    return content;
  }

  public Date getTime()
  {
    return time;
  }

  public String getTimeToString()
  {
    return sdf2.format(time);
  }

  public String getIp()
  {
    return ip;
  }

  public boolean isReader()
  {
    return reader;
  }

  public static int count(String community, String sql) throws SQLException
  {
    int j = 0;
    DbAdapter db = new DbAdapter();
    try
    {
      db.executeQuery("SELECT COUNT(*) FROM ImMessage WHERE community=" + DbAdapter.cite(community) + sql);
      if (db.next())
      {
        j = db.getInt(1);
      }
    } finally
    {
      db.close();
    }
    return j;
  }

  public void setReader() throws SQLException
  {
    DbAdapter db = new DbAdapter();
    try
    {
      db.executeUpdate("UPDATE ImMessage SET reader=1 WHERE immessage=" + immessage);
    } finally
    {
      db.close();
    }
  }
}
