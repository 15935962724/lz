package tea.entity.admin;

import java.math.*;
import java.sql.*;
import java.util.Date;
import tea.db.*;
import java.io.*;
import java.util.*;
import tea.db.DbAdapter;
import java.sql.SQLException;
import tea.entity.*;
import java.text.*;

public class AuditingMember  extends Entity
{
    private int id;
    private String member;
    private BigDecimal moneys;//用户注册的费用
    private int role;//用户分配的权限
    private Date times; //添加时间
    private String community;
    private int type;//用户审核的标示
    private int node;//对应的Node号
    private BigDecimal factmoneys;//用户实际费用
    private Date timey;//有效期
    private int pay;//支付方式
    private int paystate;//支付状态
    private boolean exists;
    private static Cache _cache = new Cache(50);
    private static final java.text.SimpleDateFormat ymd = new java.text.SimpleDateFormat("yyyyMM");

    public AuditingMember(int id)throws SQLException
    {
        this.id = id;
        load();
    }

    public static AuditingMember find(int id)throws SQLException
    {
        return new AuditingMember(id);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select  member,moneys,role,times,community,type,node ,factmoneys,timey,pay from AuditingMember where id =" + (id));
            if (db.next())
            {
                member = db.getString(1);
                moneys = db.getBigDecimal(2, 2);
                role = db.getInt(3);
                times = db.getDate(4);
                community = db.getString(5);
                type = db.getInt(6);
                node=db.getInt(7);
                factmoneys=db.getBigDecimal(8,2);
                timey =db.getDate(9);
                pay = db.getInt(10);
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

    public static int create(String member, BigDecimal moneys, int role, String community, int type, int node) throws SQLException
    {

        Date times = new Date();
       /// String id = ymd.format(times) + SeqTable.getSeqNo("trade");
       String id = ymd.format(times) + SeqTable.getSeqNo("trade");

        int i =0;
        DbAdapter db = new DbAdapter();
        try
        {
           db.executeUpdate("INSERT INTO AuditingMember(id,member,moneys,role,times,community,type,node) VALUES("+Integer.parseInt(id)+"," + db.cite(member) + "," + (moneys) + "," + role + "," + db.cite(times) + "," + db.cite(community) + "," + type + "," + node + " )");
        } finally
        {
            db.close();
        }
        return i;
    }

    public void set (String member, int role, int node) throws SQLException
    {
          DbAdapter db = new DbAdapter();
          try
          {
            db.executeUpdate("update AuditingMember set member ="+db.cite(member)+",moneys= "+moneys+",role="+role+", type="+type+" ,node="+node+" where id =  "+id);
          }finally
          {
              db.close();
          }
    }
    public static boolean isMemeber(String member, int role) throws SQLException
    {
        boolean flag = false;
        StringBuffer sb = new StringBuffer();
        sb.append("SELECT member FROM AuditingMember WHERE role = " + role + "  and member=").append(DbAdapter.cite(member));
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
    public static boolean isMemeber_member(String member) throws SQLException
   {
       boolean flag = false;
       StringBuffer sb = new StringBuffer();
       sb.append("SELECT member FROM AuditingMember WHERE   member=").append(DbAdapter.cite(member));
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
   public static String isRole(String member) throws SQLException
 {
     StringBuffer sp = new StringBuffer("/");
     StringBuffer sb = new StringBuffer();
     sb.append("SELECT role FROM AuditingMember WHERE type=1 and    member=").append(DbAdapter.cite(member));
     DbAdapter db = new DbAdapter(1);
     try
     {
         db.executeQuery(sb.toString());
         while(db.next())
         {
             sp.append(db.getInt(1)+"/");
         }

     } finally
     {
         db.close();
     }
     return sp.toString();

 }


   public static boolean isMemeber_pay(String member,int role,int type) throws SQLException
  {
      boolean flag = false;
      StringBuffer sb = new StringBuffer();
      sb.append("SELECT member FROM AuditingMember WHERE role="+role+" and  type="+type+" and   member=").append(DbAdapter.cite(member));
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
  public static boolean isMemeber_pay2(String member,int role,int type) throws SQLException
 {
     boolean flag = false;
     StringBuffer sb = new StringBuffer();
     sb.append("SELECT member FROM AuditingMember WHERE pay=0 and role="+role+" and  type="+type+" and   member=").append(DbAdapter.cite(member));
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
    public static int isDingDan(String member,int role) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try{
            db.executeQuery("SELECT id FROM AuditingMember WHERE role = " + role + "  and member="+DbAdapter.cite(member));
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


    public static Enumeration find(String community, String sql, int pos, int pagesize) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT id FROM AuditingMember WHERE community=" + DbAdapter.cite(community) + sql);
            for (int l = 0; l < pos + pagesize && db.next(); l++)
            {
                if (l >= pos)
                {
                    v.addElement(new Integer(db.getInt(1)));

                }
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

   public static int count(String community, String sql) throws SQLException
   {
       int count = 0;
       DbAdapter db = new DbAdapter(1);
       try
       {
           db.executeQuery("SELECT COUNT(*) FROM AuditingMember WHERE community=" + DbAdapter.cite(community) + sql);
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

  public void set(int type )throws SQLException
  {
       DbAdapter db = new DbAdapter(1);
       try
       {
           db.executeUpdate("update AuditingMember set type="+type+" where id= "+(id));
       }finally
       {
           db.close();
       }
  }
  public void setPay(int pay,BigDecimal moneys)throws SQLException
  {
      DbAdapter db = new DbAdapter();
      try
      {
          db.executeUpdate("update AuditingMember set pay ="+pay+", moneys= "+moneys+" where id ="+(id));
      }finally
      {
          db.close();
      }
  }
  public void set(BigDecimal factmoneys,Date timey )throws SQLException
 {
      DbAdapter db = new DbAdapter(1);
      try
      {
          db.executeUpdate("update AuditingMember set factmoneys="+factmoneys+" ,timey ="+db.cite(timey)+"  where id= "+(id));
      }finally
      {
          db.close();
      }
 }

 public  void setPayState(int paystate) throws SQLException
 {
     DbAdapter db = new DbAdapter(1);
     try
     {
         db.executeUpdate("update AuditingMember set paystate=" + paystate + "   where id= " + (id));
     } finally
     {
         db.close();
     }

 }
 public static void delete(String member)throws SQLException
 {
     DbAdapter db = new DbAdapter();
     try
     {
        db.executeUpdate(" DELETE FROM AuditingMember WHERE member = "+db.cite(member));
     }finally
     {
         db.close();
     }
 }
    public String getCommunity()
    {
        return community;
    }

    public int getId()
    {
        return id;
    }

    public String getMember()
    {
        return member;
    }

    public BigDecimal getMoneys()
    {
        return moneys;
    }

    public int getRole()
    {
        return role;
    }

    public Date getTimes()
    {
        return times;
    }
    public String getTimeToString()
    {
        if(times == null)
            return "";
        return sdf.format(times);
    }

    public int getType()
    {
        return type;
    }

    public int getNode()
    {
        return node;
    }
    public BigDecimal getFactmoneys()
    {
        return factmoneys;
    }
    public Date getTimey()
    {
        return timey;
    }
    public String getTimeyToString()
    {
        if(timey == null)
            return "";
        return sdf.format(timey);
    }
    public int getPay()
    {
        return pay;
    }
}
