package tea.entity.netdisk;

import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;
import tea.entity.admin.*;

public class FileCenterSafety
{
  private static Cache _cache = new Cache(100);
  public static final String APPLY_STYLE[] =
      {"只有该文件夹", "只有子文件夹", "该文件夹及子文件夹"};
  public static final String PUR_TYPE[] =
      {"列出文件夹目录", "读取", "写入", "修改", "完全控制"};
  private int filecentersafety;
  private String community;
  private int filecenter;
  //private String path; //为了解决:向上继承
  private int style;
  private int purview; //0:列出文件夹目录,1:读取,2:写入,3:修改,4:删除
  private String role;
  private String unit;
  private String member;
  private boolean exists;

  public FileCenterSafety(int filecentersafety) throws SQLException
  {
    this.filecentersafety = filecentersafety;
    load();
  }

  public static FileCenterSafety find(int filecentersafety) throws SQLException
  {
    return new FileCenterSafety(filecentersafety);
  }

  public void load() throws SQLException
  {
    DbAdapter db = new DbAdapter();
    try
    {
      db.executeQuery("SELECT community,filecenter,style,purview,role,unit,member FROM FileCenterSafety WHERE filecentersafety=" + filecentersafety);
      if (db.next())
      {
        community = db.getString(1);
        filecenter = db.getInt(2);
        style = db.getInt(3);
        purview = db.getInt(4);
        role = db.getString(5);
        unit = db.getString(6);
        member = db.getString(7);
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

  public static void create(String community, int filecenter, int style, int purview, String role, String unit, String member) throws SQLException
  {
    DbAdapter db = new DbAdapter();
    try
    {
      db.executeUpdate("INSERT INTO FileCenterSafety(community,filecenter,style,purview,role,unit,member)VALUES(" + db.cite(community) + "," + filecenter + "," + style + "," + purview + "," + db.cite(role) + "," + db.cite(unit) + "," + db.cite(member) + ")");
    } finally
    {
      db.close();
    }
  }

  public void delete() throws SQLException
  {
    DbAdapter db = new DbAdapter();
    try
    {
      db.executeUpdate("DELETE FROM FileCenterSafety WHERE filecentersafety=" + filecentersafety);
    } finally
    {
      db.close();
    }
    _cache.remove(new Integer(filecentersafety));
  }

  public void set(int style, int purview, String role, String unit, String member) throws SQLException
  {
    DbAdapter db = new DbAdapter();
    try
    {
      db.executeUpdate("UPDATE FileCenterSafety SET style=" + style + ",purview=" + purview + ",role=" + db.cite(role) + ",unit=" + db.cite(unit) + ",member=" + db.cite(member) + " WHERE filecentersafety=" + filecentersafety);
    } finally
    {
      db.close();
    }
    this.style = style;
    this.purview = purview;
    this.role = role;
    this.unit = unit;
    this.member = member;
  }

  /** **枚举列出那个路径对应的相应信息***** */
  public static Enumeration findByFileCenter(int filecenter, String sql) throws SQLException
  {
    FileCenter obj = FileCenter.find(filecenter);
    String path = obj.getPath();
    String extend = obj.getFatherEx();
    Vector v = new Vector();
    StringBuilder sb = new StringBuilder();
    DbAdapter db = new DbAdapter();
    sb.append("SELECT fcs.filecentersafety FROM FileCenterSafety fcs INNER JOIN FileCenter fc ON fcs.filecenter=fc.filecenter WHERE fc.community=").append(DbAdapter.cite(obj.getCommunity())).append(" AND (");
    sb.append("    ( fcs.style=0 AND fcs.filecenter=").append(filecenter).append(")");
    // 只有子文件夹////////
    sb.append(" OR ( fcs.style=1");
    if (extend != null && extend.length() > 0)
    {
      sb.append(" AND fc.path>=" + DbAdapter.cite(extend));
    }
    sb.append(" AND " + DbAdapter.cite(path) + " LIKE " + db.concat("fc.path", "'_%'") + ")");
    // 该文件夹及子文件夹////////
    sb.append(" OR ( fcs.style=2");
    if (extend != null && extend.length() > 0)
    {
      sb.append(" AND fc.path>=" + DbAdapter.cite(extend));
    }
    sb.append(" AND " + DbAdapter.cite(path) + " LIKE " + db.concat("fc.path", "'%'") + ")");
    // 向上继承//////////
    sb.append(" OR ( fc.path LIKE " + DbAdapter.cite(path + "%") + " )");
    sb.append(")").append(sql);
    try
    {
      db.executeQuery(sb.toString());
      while (db.next())
      {
        v.addElement(new Integer(db.getInt(1)));
      }
    } finally
    {
      db.close();
    }
    return v.elements();
  }

  public static int findByMember(int filecenter, String member) throws SQLException
  {
    FileCenter obj = FileCenter.find(filecenter);
    // if (obj.isType())
    // {
    // return findByMember(obj.getFather(), member);
    // }
    String community = obj.getCommunity();
    String path = obj.getPath();
    String extend = obj.getFatherEx();
    int j = -1;
    // =====会员=================================//
    AdminUsrRole aur = AdminUsrRole.find(community, member);
    int unit = aur.getUnit();
    String rs[] = aur.getRole().split("/");
    String cs[] = aur.getClasses().split("/");
    StringBuilder sql = new StringBuilder();
    sql.append("SELECT fcs.purview FROM FileCenterSafety fcs INNER JOIN FileCenter fc ON fcs.filecenter=fc.filecenter WHERE fc.community=").append(DbAdapter.cite(community));
    sql.append(" AND( fcs.unit LIKE ").append(DbAdapter.cite("%/" + unit + "/%"));
    for (int i = 1; i < cs.length; i++)
    {
      sql.append(" OR fcs.unit LIKE ").append(DbAdapter.cite("%/" + cs[i] + "/%"));
    }
    for (int i = 1; i < rs.length; i++)
    {
      sql.append(" OR fcs.role LIKE ").append(DbAdapter.cite("%/" + rs[i] + "/%"));
    }
    sql.append(" OR fcs.member LIKE ").append(DbAdapter.cite("%/" + member + "/%"));
    sql.append(")");
    // ======================================//
    DbAdapter db = new DbAdapter();
    StringBuilder s2 = new StringBuilder();
    s2.append(" AND(   ( fcs.style=0 AND fcs.filecenter=").append(filecenter).append(")");
    // 只有子文件夹////////
    s2.append(" OR ( fcs.style=1");
    if (extend != null && extend.length() > 0)
    {
      s2.append(" AND fc.path>=" + DbAdapter.cite(extend));
    }
    s2.append(" AND " + DbAdapter.cite(path) + " LIKE " + db.concat("fc.path", "'_%'") + ")");
    // 该文件夹及子文件夹////////
    s2.append(" OR ( fcs.style=2");
    if (extend != null && extend.length() > 0)
    {
      s2.append(" AND fc.path>=" + DbAdapter.cite(extend));
    }
    s2.append(" AND " + DbAdapter.cite(path) + " LIKE " + db.concat("fc.path", "'%'") + ")");
    s2.append(") ORDER BY fcs.purview DESC");
    // System.out.println(sql.toString() + s2.toString());
    try
    {
      db.executeQuery(sql.toString() + s2.toString());
      if (db.next())
      {
        j = db.getInt(1);
      } else
      { // 向上继承//////////
        db.executeQuery(sql.toString() + " AND fc.path LIKE " + DbAdapter.cite(path + "%"));
        if (db.next())
        {
          j = 0;
        }
      }
    } finally
    {
      db.close();
    }
    return j;
  }

  //{member}在{community}社区中的最高权限
  public static int findByMember(String community, String member) throws SQLException
  {
    int j = -1;
    // =====会员=================================//
    AdminUsrRole aur = AdminUsrRole.find(community, member);
    int unit = aur.getUnit();
    String rs[] = aur.getRole().split("/");
    String cs[] = aur.getClasses().split("/");
    StringBuilder sql = new StringBuilder();
    sql.append("SELECT fcs.purview FROM FileCenterSafety fcs INNER JOIN FileCenter fc ON fcs.filecenter=fc.filecenter WHERE fcs.community=").append(DbAdapter.cite(community));
    sql.append(" AND fc.community=").append(DbAdapter.cite(community));
    sql.append(" AND( fcs.unit LIKE ").append(DbAdapter.cite("%/" + unit + "/%"));
    for (int i = 1; i < cs.length; i++)
    {
      sql.append(" OR fcs.unit LIKE ").append(DbAdapter.cite("%/" + cs[i] + "/%"));
    }
    for (int i = 1; i < rs.length; i++)
    {
      sql.append(" OR fcs.role LIKE ").append(DbAdapter.cite("%/" + rs[i] + "/%"));
    }
    sql.append(" OR fcs.member LIKE ").append(DbAdapter.cite("%/" + member + "/%"));
    sql.append(") ORDER BY fcs.purview DESC");

    //System.out.println(sql.toString());
    DbAdapter db = new DbAdapter();
    try
    {
      db.executeQuery(sql.toString());
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

  public String getUnit()
  {
    return unit;
  }

  public int getFileCenterSafety()
  {
    return filecentersafety;
  }

  public String getRole()
  {
    return role;
  }

  public String getRoleToHtml(String s) throws SQLException
  {
    String rs[] = role.split("/");
    StringBuilder sb = new StringBuilder();
    for (int j = 1; j < rs.length; j++)
    {
      AdminRole ar = AdminRole.find(Integer.parseInt(rs[j]));
      if (ar.isExists())
      {
        sb.append(ar.getName()).append(s);
      }
    }
    return sb.toString();
  }

  public String getUnitToHtml(String s) throws SQLException
  {
    String us[] = unit.split("/");
    StringBuilder sb = new StringBuilder();
    for (int j = 1; j < us.length; j++)
    {
      AdminUnit au = AdminUnit.find(Integer.parseInt(us[j]));
      if (au.isExists())
      {
        sb.append(au.getName()).append(s);
      }
    }
    return sb.toString();
  }

  public String getMemberToHtml(String s) throws SQLException
  {
    return member.substring(1).replaceAll("/", s);
  }

  public int getPurview()
  {
    return purview;
  }

  public int getPurview(String p) throws SQLException
  {
    int i = -1;
    FileCenter fc = FileCenter.find(filecenter);
    String path = fc.getPath();
    if (style == 1 && path.equals(p))
    {
      i = 0;
    } else if (p.startsWith(path))
    {
      i = purview;
    } else if (path.startsWith(p))
    {
      i = 0;
    }
//    else //FileCenter.path 和 FileCenterSafety.path不同步了...
//    {
//      System.out.println("同步文件权限...");
//      DbAdapter db = new DbAdapter();
//      DbAdapter db2 = new DbAdapter();
//      try
//      {
//        db.executeQuery("SELECT DISTINCT fcs.filecenter FROM FileCenterSafety fcs INNER JOIN FileCenter fc ON fcs.filecenter=fc.filecenter AND fcs.path!=fc.path"); //"SELECT DISTINCT filecenter FROM FileCenterSafety"
//        while (db.next())
//        {
//          int fcid = db.getInt(1);
//          FileCenter fc = FileCenter.find(fcid);
//          String path = fc.getPath();
//          db2.executeUpdate("UPDATE FileCenterSafety SET path=" + DbAdapter.cite(path) + " WHERE filecenter=" + fcid);
//        }
//      } finally
//      {
//        db.close();
//        db2.close();
//      }
//      this.path = path;
//      _cache.clear();
//      i = getPurview(p);
//    }
    return i;
  }

//  public String getPath()
//  {
//    return path;
//  }

  public String getMember()
  {
    return member;
  }

  public int getStyle()
  {
    return style;
  }

  public boolean isExists()
  {
    return exists;
  }

  public String getCommunity()
  {
    return community;
  }

  public int getFileCenter()
  {
    return filecenter;
  }
}
