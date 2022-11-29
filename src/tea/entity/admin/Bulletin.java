package tea.entity.admin;

import java.sql.*;
import java.text.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class Bulletin extends Entity
{
    private static Cache _cache = new Cache(100);
    private int bull_id;
    private String community;
    private String member; // 鐢ㄦ埛鐨勭櫥褰旾D
    private String tmember;
    private String tunit;
    private Date time_s; // 璧峰鏃堕棿
    private Date time_e;
    private String caption; // 鏍囬
    private String content;
    private Date issuetime; // 鍙戝竷鏃堕棿

    private boolean exists;
    private int type;
    private String part;
    private String partid;

    private int naught;
    private int naught2;
    private int notread; // 标示公告是否读取

    public Bulletin(int bull_id) throws SQLException
    {
        this.bull_id = bull_id;
        load();
    }

    public static Bulletin find(int bull_id) throws SQLException
    {
        /*
         * Bulletin obj = (Bulletin) _cache.get(new Integer(bull_id)); if (obj == null) { obj = new Bulletin(bull_id); _cache.put(new Integer(bull_id), obj); }
         */
        return new Bulletin(bull_id);
    }

    private void load() throws SQLException
    {
        if(bull_id > 0)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT community,member,tmember,tunit,time_s,time_e,caption,content,issuetime,naught,naught2,type,notread FROM Bulletin WHERE bull_id=" + bull_id);
                if(db.next())
                {
                    community = db.getString(1);
                    member = db.getString(2);
                    tmember = db.getString(3);
                    tunit = db.getString(4);
                    time_s = db.getDate(5);
                    time_e = db.getDate(6);
                    caption = db.getVarchar(1,1,7);
                    content = db.getVarchar(1,1,8);
                    issuetime = db.getDate(9);
                    naught = db.getInt(10);
                    naught2 = db.getInt(11);
                    type = db.getInt(12);
                    notread = db.getInt(13);
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
    }

    public void set(String tmember,String tunit,Date time_s,Date time_e,String caption,String content,Date issuetime,int naught,int naught2,int type,int notread) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Bulletin SET tmember=" + db.cite(tmember) + ",tunit=" + db.cite(tunit) + ",time_s=" + db.cite(time_s) + ",time_e=" + db.cite(time_e) + ",caption=" + DbAdapter.cite(caption) + ",content=" + DbAdapter.cite(content) + " ,issuetime=" + db.cite(issuetime) + ",naught=" + naught + ",naught2=" + naught2 + ",type=" + type + ",notread=" + notread + " WHERE bull_id =" + bull_id);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(bull_id));
    }


    public static int create(String community,String member,String tmember,String tunit,Date time_s,Date time_e,String caption,String content,Date issuetime,int naught,int naught2,int type,int notread) throws SQLException
    {
        int bull_id = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Bulletin(community,member,tmember,tunit,time_s,time_e,caption,content,issuetime,naught,naught2,type,notread)VALUES(" +
                             DbAdapter.cite(community) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(tmember) + "," + DbAdapter.cite(tunit) + "," + db.cite(time_s) + "," + db.cite(time_e) + "," + DbAdapter.cite(caption) + "," + DbAdapter.cite(content) + "," + db.cite(issuetime) + "," + naught + "," + naught2 + "," + type + "," + notread + ")");
            bull_id = db.getInt("SELECT MAX(bull_id) FROM Bulletin");
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(bull_id));
        return bull_id;
    }

    public static java.util.Enumeration findByCommunity(String community,String sql) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT bull_id FROM Bulletin WHERE community=" + DbAdapter.cite(community) + sql);
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static java.util.Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        java.util.Vector v = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT bull_id FROM Bulletin WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

//  public static java.util.Enumeration yread(int dep, int newid) throws SQLException
//  {
//    java.util.Vector v = new java.util.Vector();
//    DbAdapter db = new DbAdapter();
//    DbAdapter db1 = new DbAdapter();
//    String member = "";
//    String date = null;
//    try
//    {
//      db.executeQuery("select member from adminunitseq where member in(select member from ifnotread where newid = " + newid + " and ynread = 1) and unit in(select id from adminunit where id=" + dep + ")");
//
//      for (int k = 0;db.next(); k++)
//      {
//
//          db1.executeQuery("select ndate from ifnotread where member=" + db.cite(db.getString(1)));
//          member = db.getString(1);
//          while (db1.next())
//          {
//
//            date = dateFormat(db1.getDate(1));
//
//          }
//            v.addElement(member + "(" + date + ")");
//
//      }
//    } finally
//    {
//      db.close();
//     db1.close();
//    }
//    return v.elements();
//  }
//
//  public static java.util.Enumeration nread(int dep,int newid) throws SQLException
// {
//   java.util.Vector v = new java.util.Vector();
//   DbAdapter db = new DbAdapter();
//
//   try
//   {
//     db.executeQuery("select member from adminunitseq where member not in(select member from ifnotread where newid="+newid+" and ynread = 1) and unit in(select id from adminunit where id=" + dep + ")");
//
//     for (int k = 0; db.next(); k++)
//     {
//             v.addElement(db.getString(1));
//     }
//   } finally
//   {
//     db.close();
//   }
//   return v.elements();
// }
////正确方法
// public static Enumeration NfindByCommunity(String community, int unit,int newid, boolean bool) throws SQLException
//   {
//     StringBuilder sql = new StringBuilder();
//     sql.append("SELECT aus.member FROM AdminUnitSeq aus INNER JOIN AdminUsrRole aur ON aus.member=aur.member WHERE aus.member not in(select member from ifnotread where newid=").append(newid).append(" and ynread = 1) and aur.community=").append(DbAdapter.cite(community, 1)).append(" AND aus.unit=").append(unit);
//     sql.append(" AND aur.role!='/' AND ( aur.unit=" + unit + " OR aur.classes LIKE ").append(DbAdapter.cite("%/" + unit + "/%")).append(")");
//     if (bool)
//     {
//       sql.append(" AND aur.options NOT LIKE '%/1/%'");
//     }
//     sql.append(" ORDER BY aus.sequence");
//     Vector v = new Vector();
//     DbAdapter db = new DbAdapter();
//     try
//     {
//       db.executeQuery(sql.toString());
//       while (db.next())
//       {
//         v.addElement(db.getString(1));
//       }
//     } finally
//     {
//       db.close();
//     }
//     return v.elements();
//   }
////
//
// public static java.util.Enumeration yreadFile(int dep, int newid) throws SQLException
//   {
//     java.util.Vector v = new java.util.Vector();
//     DbAdapter db = new DbAdapter();
//     DbAdapter db1 = new DbAdapter();
//     String member = "";
//     String date = null;
//     try
//     {
//       db.executeQuery("select member from adminunitseq where member in(select member from ifnotread where newid = " + newid + " and ynread = 1) and unit=" + dep);
//
//       for (int k = 0;db.next(); k++)
//       {
//
//           db1.executeQuery("select ndate from ifnotread where member=" + db.cite(db.getString(1)));
//           member = db.getString(1);
//           while (db1.next())
//           {
//
//             date = dateFormat(db1.getDate(1));
//
//           }
//             v.addElement(member + "(" + date + ")");
//
//       }
//     } finally
//     {
//       db.close();
//      db1.close();
//     }
//     return v.elements();
//   }
//
//   public static java.util.Enumeration nreadFile(int dep,int newid) throws SQLException
//  {
//    java.util.Vector v = new java.util.Vector();
//    DbAdapter db = new DbAdapter();
//
//    try
//    {
//      db.executeQuery("select member from adminunitseq where member not in(select member from ifnotread where newid="+newid+" and ynread = 1) and unit=" + dep);
//
//      for (int k = 0; db.next(); k++)
//      {
//              v.addElement(db.getString(1));
//      }
//    } finally
//    {
//      db.close();
//    }
//    return v.elements();
// }



    public static java.util.Enumeration yreadMessageDep(int dep,int newid) throws SQLException
    {
        java.util.Vector v = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        DbAdapter db1 = new DbAdapter();
        String member = "";
        String date = null;
        try
        {
            db.executeQuery("select member from AdminUnitSeq where member in(select member from ifnotread where newid = " + newid + " and ynread = 1) and unit=" + dep);

            for(int k = 0;db.next();k++)
            {

                db1.executeQuery("select ndate from ifnotread where member=" + db.cite(db.getString(1)));
                member = db.getString(1);
                while(db1.next())
                {

                    date = dateFormat(db1.getDate(1));

                }
                v.addElement(member + "(" + date + ")");

            }
        } finally
        {
            db.close();
            db1.close();
        }
        return v.elements();
    }

    public static java.util.Enumeration nreadMessageDep(int dep,int newid) throws SQLException
    {
        java.util.Vector v = new java.util.Vector();
        DbAdapter db = new DbAdapter();

        try
        {
            db.executeQuery("select member from AdminUnitSeq where member not in(select member from ifnotread where newid=" + newid + " and ynread = 1) and unit=" + dep);

            for(int k = 0;db.next();k++)
            {
                v.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static java.util.Enumeration yreadMessagePer(int newid) throws SQLException
    {
        java.util.Vector v = new java.util.Vector();

        DbAdapter db1 = new DbAdapter();

        try
        {

            db1.executeQuery("select member, ndate from ifnotread where newid=" + newid);

            while(db1.next())
            {

                v.addElement(db1.getString(1) + "(" + dateFormat(db1.getDate(2)) + ")");
            }

        } finally
        {

            db1.close();
        }
        return v.elements();
    }

    public static java.util.Enumeration nreadMessagePer(int newid) throws SQLException
    {
        java.util.Vector v = new java.util.Vector();
        DbAdapter db = new DbAdapter();

        try
        {
            db.executeQuery("select tmember from Message where message=" + newid);

            for(int k = 0;db.next();k++)
            {
                v.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static boolean showNreadPer(String name,int newid) throws SQLException
    {
        boolean yn = true;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select member from ifnotread where newid=" + newid);
            while(db.next())
            {
                if(name.equals(db.getString(1)))
                {
                    yn = false;
                }
            }
        } finally
        {
            db.close();
        }
        return yn;
    }

    public static boolean showMessage(String name,int newid) throws SQLException
    {
        boolean yn = false;
        DbAdapter db = new DbAdapter();

        try
        {
            db.executeQuery("select fmember from Message where message=" + newid);
            while(db.next())
            {

                if(name.equals(db.getString(1)))
                {
                    yn = true;
                }

            }
        } finally
        {
            db.close();
        }
        return yn;
    }

    public static boolean showYreadPer(String name,int newid) throws SQLException
    {
        boolean yn = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select member from ifnotread where newid=" + newid);
            while(db.next())
            {
                if(name.equals(db.getString(1)))
                {
                    yn = true;
                }
            }
        } finally
        {
            db.close();
        }
        return yn;
    }

    public static String readUnit(int filecenter,int purview) throws SQLException
    {
        String d = null;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select unit from FileCenterSafety where filecenter=" + filecenter + " and purview=" + purview);
            while(db.next())
            {
                d = db.getString(1);

            }

        } finally
        {
            db.close();
        }
        return d;
    }

    public static String findRole(String role) throws SQLException
    {
        String d = null;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select name from AdminRole where id=" + role);
            while(db.next())
            {
                d = db.getString(1);

            }

        } finally
        {
            db.close();
        }
        return d;
    }

    public static String findRoleName(String role) throws SQLException
    {
        String d = null;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select member from AdminUsrRole where role like '%" + role + "%'");
            while(db.next())
            {
                d = db.getString(1);

            }

        } finally
        {
            db.close();
        }
        return d;
    }

    public static java.util.Enumeration findRoleName1(String role) throws SQLException
    {
        java.util.Vector v = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select member from AdminUsrRole where role like '%" + role + "%'");
            while(db.next())
            {
                v.addElement(db.getString(1));

            }

        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static String dateFormat(Date date)
    {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String ndate = sdf.format(date);
        return ndate;
    }

    public static String readDate(String member,int newid) throws SQLException
    {
        String d = null;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select ndate from ifnotread where member=" + db.cite(member) + "and newid=" + newid);
            while(db.next())
            {
                d = "(" + dateFormat(db.getDate(1)) + ")";
            }
        } finally
        {
            db.close();
        }
        return d;
    }

    public static java.util.Enumeration findreadmen(int id,String member) throws SQLException
    {
        java.util.Vector v = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select member from ifnotread where newid=" + id + " and member=" + db.cite(member));
            for(int k = 0;db.next();k++)
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
            db.executeUpdate("DELETE FROM Bulletin WHERE bull_id=" + bull_id);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(bull_id));
    }

    public void set(String acceefile,String acceefileurl) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Bulletin SET acceefile=" + db.cite(acceefile) + ",  acceefilename=" + db.cite(acceefileurl) + " WHERE bull_id =" + bull_id);
        } finally
        {
            db.close();
        }
    }

    // 对公告通知如果读取的 把字段Notread由默认的0 修改成 1 代表次公告已经读取了
    public void set() throws SQLException,SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Bulletin SET notread=1 where bull_id=" + bull_id);
        } finally
        {
            db.close();
        }
    }

    public void endelete(String community,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Bulletin where community=" + db.cite(community) + sql);
        } finally
        {
            db.close();
        }
    }

    public void intovalue(int type) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Bulletin SET type=" + type + " WHERE bull_id =" + bull_id);
        } finally
        {
            db.close();
        }
    }

    public static int count(String community,String sql) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM Bulletin WHERE community=" + db.cite(community) + sql);
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

    public String getCaption()
    {
        return caption;
    }

    public Date getTime_s()
    {
        return time_s;
    }

    public Date getTime_e()
    {
        return time_e;
    }

    public String getContent()
    {
        return content;
    }

    public Date getIssuetime()
    {
        return issuetime;
    }

    public String getIssuetimeToString()
    {
        return sdf.format(issuetime);
    }

    public String getCommunity()
    {
        return community;
    }

    public String getMember()
    {
        return member;
    }

    public int getType()
    {
        return type;
    }

    public String getPart()
    {
        return part;
    }

    public String getPartid()
    {
        return partid;
    }

    public int getNaught()
    {
        return naught;
    }

    public int getNaught2()
    {
        return naught2;
    }

    public int getNotread()
    {
        return notread;
    }

    public String getTUnit()
    {
        return tunit;
    }

    public String getTo(int lang) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        sb.append(tmember.substring(1).replaceAll("/","; "));
        String ts[] = tunit.split("/");
        for(int i = 1;i < ts.length;i++)
        {
            AdminUnit au = AdminUnit.find(Integer.parseInt(ts[i]));
            if(au.isExists())
            {
                sb.append(au.getName()).append("; ");
            }
        }
        return sb.toString();
    }

    public String getTMember()
    {
        return tmember;
    }

    public boolean isExists()
    {
        return exists;
    }

    ////////////////////////////////////////
    public void addFile(String path,String name) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Bullfile(bull_id,file_name,name)VALUES(" + bull_id + "," + db.cite(path) + "," + db.cite(name) + ")");
        } finally
        {
            db.close();
        }
    }

    public void delFile(int file_id) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Bullfile WHERE file_id=" + file_id);
        } finally
        {
            db.close();
        }
    }

    public void moveFile(int newid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Bullfile SET bull_id=" + newid + " WHERE bull_id=" + bull_id);
        } finally
        {
            db.close();
        }
    }

    public Enumeration findFile() throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT file_id,file_name,name FROM Bullfile WHERE bull_id=" + bull_id);
            while(db.next())
            {
                int id = db.getInt(1);
                String path = db.getString(2);
                String name = db.getString(3);
                v.addElement(new Object[]
                             {new Integer(id),path,name});
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

}
