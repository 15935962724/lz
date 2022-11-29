package tea.entity.admin;

import java.io.*;
import java.util.*;
import tea.db.DbAdapter;
import java.sql.SQLException;
import tea.entity.*;

public class RankClass extends Entity
{
    private int id;
    private String rankclass;
    private String enrol1;
    private String duty1;
    private String enrol2;
    private String duty2;
    private String enrol3;
    private String duty3;
    private String enrol4;
    private String duty4;
    private String enrol5;
    private String duty5;
    private String enrol6;
    private String duty6;

    private boolean exists;
    private static Cache _cache = new Cache(100);

    public RankClass(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static RankClass find(int id) throws SQLException
    {
        /*
         * Bulletin obj = (Bulletin) _cache.get(new Integer(bull_id)); if (obj == null) { obj = new Bulletin(bull_id); _cache.put(new Integer(bull_id), obj); }
         */
        return new RankClass(id);
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT rankclass,enrol1,duty1,enrol2,duty2,enrol3,duty3,enrol4,duty4,enrol5,duty5,enrol6,duty6 FROM RankClass where id =" + id);
            if (db.next())
            {
                rankclass = db.getVarchar(1, 1, 1);
                enrol1 = db.getString(2);
                duty1 = db.getString(3);
                enrol2 = db.getString(4);
                duty2 = db.getString(5);
                enrol3 = db.getString(6);
                duty3 = db.getString(7);
                enrol4 = db.getString(8);
                duty4 = db.getString(9);
                enrol5 = db.getString(10);
                duty5 = db.getString(11);
                enrol6 = db.getString(12);
                duty6 = db.getString(13);
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

    // 数据第一次插入是的方法
    public static int create(String rankclass, String enrol1, String duty1, String enrol2, String duty2, String enrol3, String duty3, String enrol4, String duty4, String enrol5, String duty5, String enrol6, String duty6, String community, RV _rv) throws SQLException
    {
        int id = 0;

        DbAdapter db = new DbAdapter();
        try
        {

            db.executeUpdate("INSERT INTO RankClass(rankclass,enrol1,duty1,enrol2,duty2,enrol3,duty3,enrol4,duty4,enrol5,duty5,enrol6,duty6,community,member) VALUES(" + DbAdapter.cite(rankclass) + "," + DbAdapter.cite(enrol1) + "," + DbAdapter.cite(duty1) + "," + DbAdapter.cite(enrol2) + "," + DbAdapter.cite(duty2) + "," + DbAdapter.cite(enrol3) + "," + DbAdapter.cite(duty3) + "," + DbAdapter.cite(enrol4) + "," + DbAdapter.cite(duty4) + "," + DbAdapter.cite(enrol5) + "," + DbAdapter.cite(duty5) + "," + DbAdapter.cite(enrol6) + "," + DbAdapter.cite(duty6) + "," + DbAdapter.cite(community)
                             + ",'" + _rv + "')");
            id = db.getInt("SELECT MAX(id) FROM RankClass");
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
        return id;
    }

    // 数据编辑是的方法

    public void set(String rankclass, String enrol1, String duty1, String enrol2, String duty2, String enrol3, String duty3, String enrol4, String duty4, String enrol5, String duty5, String enrol6, String duty6, String community, RV _rv) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM RankClass WHERE id =" + id);
            if (db.next())
            {
                db.executeUpdate("UPDATE RankClass SET rankclass =" + DbAdapter.cite(rankclass) + ",enrol1=" + DbAdapter.cite(enrol1) + ",duty1=" + DbAdapter.cite(duty1) + ",enrol2=" + DbAdapter.cite(enrol2) + ",duty2=" + DbAdapter.cite(duty2) + ",enrol3=" + DbAdapter.cite(enrol3) + ",duty3=" + DbAdapter.cite(duty3) + ",enrol4=" + DbAdapter.cite(enrol4) + ",duty4=" + DbAdapter.cite(duty4) + ",enrol5=" + DbAdapter.cite(enrol5) + ",duty5=" + DbAdapter.cite(duty5) + ",enrol6=" + DbAdapter.cite(enrol6) + ",duty6=" + DbAdapter.cite(duty6) + ",community=" + DbAdapter.cite(community) + ",member='" + _rv + "'   WHERE id =" + id);
            } else
            {
                db.executeUpdate("INSERT INTO RankClass(rankclass,enrol1,duty1,enrol2,duty2,enrol3,duty3,enrol4,duty4,enrol5,duty5,enrol6,duty6,community,member) VALUES(" + DbAdapter.cite(rankclass) + "," + DbAdapter.cite(enrol1) + "," + DbAdapter.cite(duty1) + "," + DbAdapter.cite(enrol2) + "," + DbAdapter.cite(duty2) + "," + DbAdapter.cite(enrol3) + "," + DbAdapter.cite(duty3) + "," + DbAdapter.cite(enrol4) + "," + DbAdapter.cite(duty4) + "," + DbAdapter.cite(enrol5) + "," + DbAdapter.cite(duty5) + "," + DbAdapter.cite(enrol6) + "," + DbAdapter.cite(duty6) + "," + DbAdapter.cite(community) + ",'" + _rv + "')");
            }
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
    }

    // 用枚举的类型 来列出数据库的字段
    public static Enumeration findByCommunity(String community, String sql) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM RankClass WHERE community=" + DbAdapter.cite(community) + sql);
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

    // 删除定义的排班类型
    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM RankClass WHERE id =" + id);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
    }
//上下班登记 ip限制
    public static boolean isIp(String community,String ip) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        boolean fa = false;
        try
        {
            db.executeQuery("SELECT ip FROM SettingIp WHERE community=" + db.cite(community));
            while(db.next())
            {
                if(ip.equals(db.getString(1)))
                {
                    fa = true;
                    break;
                }
				//System.out.println(db.getString(1).replaceAll("\\.\\*",""));
                if(ip.indexOf(db.getString(1).replaceAll("\\.\\*","")) != -1)
                {
                    fa = true;
                    break;
                }
            }
        } finally
        {
            db.close();
        }
        return fa;
    }
//判断是否有记录
	public static boolean isSip(String community) throws SQLException
	  {
          DbAdapter db = new DbAdapter();
          boolean fa = false;
          try
          {
              db.executeQuery("SELECT ip FROM SettingIp WHERE community=" + db.cite(community));
              if(db.next())
              {
                  fa = true;
              }
          } finally
          {
              db.close();
          }
          return fa;
      }
    public String getRankClass()
    {
        return rankclass;
    }

    public String getEnrol1()
    {
        return enrol1;
    }

    public String getDuty1()
    {
        return duty1;
    }

    public String getEnrol2()
    {
        return enrol2;
    }

    public String getDuty2()
    {
        return duty2;
    }

    public String getEnrol3()
    {
        return enrol3;
    }

    public String getDuty3()
    {
        return duty3;
    }

    public String getEnrol4()
    {
        return enrol4;
    }

    public String getDuty4()
    {
        return duty4;
    }

    public String getEnrol5()
    {
        return enrol5;
    }

    public String getDuty5()
    {
        return duty5;
    }

    public String getEnrol6()
    {
        return enrol6;
    }

    public String getDuty6()
    {
        return duty6;
    }

    public boolean isExists()
    {
        return exists;
    }
}
