package tea.entity.admin.orthonline;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class DoctorRanking extends Entity
{
  private int drid;
  private String hospitalname;
  private int mrnumber;
  private String community;
  private int sheng;
  private int shi;
  private String yyjibie;
  private boolean exists;

  public DoctorRanking(int drid) throws SQLException
   {
	   this.drid = drid;
	   load();
   }

   public static DoctorRanking find(int drid) throws SQLException
   {
	   return new DoctorRanking(drid);
   }

   public void load() throws SQLException
   {
	   DbAdapter db = new DbAdapter();
	   try
	   {
		   db.executeQuery("SELECT hospitalname ,mrnumber,community,sheng,shi,yyjibie FROM DoctorRanking WHERE drid =" + drid);
		   if(db.next())
		   {
			   hospitalname=db.getString(1);
			   mrnumber=db.getInt(2);
			   community=db.getString(3);
			   sheng = db.getInt(4);
			   shi = db.getInt(5);
			   yyjibie=db.getString(6);
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

   public static int create(String hospitalname,int mrnumber,int sheng,int shi,String community,String yyjibie) throws SQLException
   {
       DbAdapter db = new DbAdapter();
       Date times = new Date();
       int i = 0;
       try
       {
           db.executeUpdate("INSERT INTO DoctorRanking (hospitalname,mrnumber,sheng,shi,community,yyjibie) VALUES (" + db.cite(hospitalname) + "," + mrnumber + "," + sheng + "," + shi + "," + db.cite(community) + ","+db.cite(yyjibie)+" )");
           i = db.getInt("SELECT MAX(drid) FROM DoctorRanking");
       } finally
       {
           db.close();
       }
       return i;
   }

   public void set(String hospitalname,int mrnumber,int sheng,int shi,String yyjibie) throws SQLException
   {
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeUpdate("UPDATE DoctorRanking SET hospitalname=" + db.cite(hospitalname) + ",mrnumber=" + mrnumber + " ,sheng=" + sheng + ",shi=" + shi + ",yyjibie="+db.cite(yyjibie)+" WHERE drid=" + drid);
       } finally
       {
           db.close();
       }
   }

   public static Enumeration find(String community,String sql,int pos,int size)
   {
       Vector vector = new Vector();
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeQuery("SELECT drid FROM DoctorRanking WHERE community= " + db.cite(community) + sql,pos,size);
           while(db.next())
           {
               vector.add(new Integer(db.getInt(1)));
           }
       } catch(Exception exception3)
       {
           System.out.print(exception3);
       } finally
       {
           db.close();
       }
       return vector.elements();
   }

   public static int count(String community,String sql) throws SQLException
   {
       int count = 0;
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeQuery("SELECT COUNT(drid) FROM DoctorRanking  WHERE community=" + db.cite(community) + sql);
           if(db.next())
           {
               count = db.getInt(1);
           }
       } finally
       {
           db.close();
       }
       return count;
   }
   //判断是否有这家医院
   public static int isDrid(String community,String hospitalname,int sheng,int shi)throws SQLException
   {
	   int f = 0;
	     DbAdapter db = new DbAdapter();
		 try
		 {
			 db.executeQuery("SELECT drid FROM DoctorRanking WHERE hospitalname = "+db.cite(hospitalname)+" AND sheng="+sheng+" AND shi ="+shi);
			 if(db.next())
			 {
				 f = db.getInt(1);
			 }
		 }finally
		 {
		    db.close();
		 }
		 return f;
   }
   //修改医生报名这个医院的数值

   public void setQuantity(int mrnumber,int sheng,int shi,String yyjibie) throws SQLException
   {
       int count = 0;
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeUpdate("UPDATE DoctorRanking SET mrnumber =" + mrnumber + ",sheng="+sheng+",shi="+shi+",yyjibie="+db.cite(yyjibie)+" WHERE drid= " + drid);
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
		  db.executeUpdate("DELETE FROM DoctorRanking WHERE drid=" + drid);
	  } finally
	  {
		  db.close();
	  }
  }


    public String getCommunity()
    {
        return community;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getHospitalname()
    {
        return hospitalname;
    }

    public int getMrnumber()
    {
        return mrnumber;
    }

    public int getSheng()
    {
        return sheng;
    }

    public int getShi()
    {
        return shi;
    }
	public String getYyjibie()
	{
		return yyjibie;
	}


}
