package tea.entity.admin;

import java.io.*;
import java.sql.SQLException;
import java.util.*;
import tea.db.*;
import tea.entity.*;

//记录每步跳转的时间///
public class FlowbusinessStep extends Entity implements Serializable
{
  private static Cache _cache = new Cache(100);
  private int flowbusinessstep;
  private int flowbusiness;
  private int step;
  private Date time;
  private boolean exists;

  public FlowbusinessStep(int flowbusinessstep) throws SQLException
  {
    this.flowbusinessstep = flowbusinessstep;
    load();
  }

  public static FlowbusinessStep find(int flowview) throws SQLException
  {
    FlowbusinessStep obj = (FlowbusinessStep) _cache.get(new Integer(flowview));
    if (obj == null)
    {
      obj = new FlowbusinessStep(flowview);
      _cache.put(new Integer(flowview), obj);
    }
    return obj;
  }

  //
  public static FlowbusinessStep find(int flowbusiness, int step) throws SQLException
  {
    int id = 0;
    DbAdapter db = new DbAdapter();
    try
    {
      id = db.getInt("SELECT flowbusinessstep FROM FlowbusinessStep WHERE flowbusiness=" + flowbusiness + " AND step=" + step + " ORDER BY flowbusinessstep DESC");
    } finally
    {
      db.close();
    }
    return find(id);
  }

  //{STEP}的上一步
  public static FlowbusinessStep findPrev(int flowbusiness, int step) throws SQLException
  {
    int id = 0;
    DbAdapter db = new DbAdapter();
    try
    {
      int max = db.getInt("SELECT flowbusinessstep FROM FlowbusinessStep WHERE flowbusiness=" + flowbusiness + " AND step=" + step + " ORDER BY flowbusinessstep DESC");
      db.executeQuery("SELECT flowbusinessstep FROM FlowbusinessStep WHERE flowbusinessstep<" + max + " AND flowbusiness=" + flowbusiness + " AND step!=" + step + " ORDER BY flowbusinessstep DESC");
      if (db.next())
      {
        id = db.getInt(1);
      }
    } finally
    {
      db.close();
    }
    return find(id);
  }

  //事务的最后一步
  public static FlowbusinessStep findLast(int flowbusiness) throws SQLException
  {
    int id = 0;
    DbAdapter db = new DbAdapter();
    try
    {
      id = db.getInt("SELECT flowbusinessstep FROM FlowbusinessStep WHERE flowbusiness=" + flowbusiness + " ORDER BY flowbusinessstep DESC");
    } finally
    {
      db.close();
    }
    return find(id);
  }

  public static int countByMember(String community, String transactor, String sql) throws SQLException
  {
    int count = 0;
    DbAdapter db = new DbAdapter();
    try
    {
      db.executeQuery("SELECT COUNT(DISTINCT flowbusiness) FROM FlowbusinessStep WHERE community=" + DbAdapter.cite(community) + " AND transactor=" + DbAdapter.cite(transactor) + sql);
      if (db.next())
      {
        count = db.getInt(1);
      }
    } finally
    {
      db.close();
    }
    return count;
  }

  public static Enumeration find(int flowbusiness, String sql) throws SQLException
  {
    Vector v = new Vector();
    DbAdapter db = new DbAdapter();
    try
    {
      db.executeQuery("SELECT flowview FROM FlowbusinessStep WHERE flowbusiness=" + flowbusiness + sql);
      while (db.next())
      {
        v.add(new Integer(db.getInt(1)));
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
      db.executeUpdate("DELETE FROM FlowbusinessStep WHERE flowbusinessstep=" + flowbusinessstep + " OR ( flowbusinessstep>" + flowbusinessstep + " AND flowbusiness=" + flowbusiness + " )");
    } finally
    {
      db.close();
    }
    _cache.remove(new Integer(flowbusinessstep));
  }

  public static void create(int flowbusiness, int step) throws SQLException
  {
    DbAdapter db = new DbAdapter();
    try
    {
      db.executeUpdate("INSERT INTO FlowbusinessStep(flowbusiness,step,time) VALUES (" + flowbusiness + "," + step + "," + db.cite(new Date()) + ")");
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
      db.executeQuery("SELECT flowbusiness,step,time FROM FlowbusinessStep WHERE flowbusinessstep=" + flowbusinessstep);
      if (db.next())
      {
        flowbusiness = db.getInt(1);
        step = db.getInt(2);
        time = db.getDate(3);
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

  public boolean isExists()
  {
    return exists;
  }

  public Date getTime()
  {
    return time;
  }

  public String getTimeToString()
  {
    if (time == null)
    {
      return "";
    }
    return sdf2.format(time);
  }

  public int getStep()
  {
    return step;
  }

  public int getFlowbusiness()
  {
    return flowbusiness;
  }

}
