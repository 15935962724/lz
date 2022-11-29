package tea.entity.admin.orthonline;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class Doctoradmin extends Entity
{

    private int daid; //主键id
    private String member; //管理员用户
    private int datype; //级别
    private int sheng; //省
    private int shi; //市
    private int yiyuan; //医院
    private String community; //社区
    private Date times; //
    private boolean exists;

	public static final String DATYPE[]={"","1级,超级管理员","2级,省份级管理员","3级,市县级管理员","4级,大型医院管理员"};

	public Doctoradmin(int daid) throws SQLException
   {
	   this.daid = daid;
	   load();
   }

   public static Doctoradmin find(int daid) throws SQLException
   {
	   return new Doctoradmin(daid);
   }

   public void load() throws SQLException
   {
	   DbAdapter db = new DbAdapter();
	   try
	   {
		   db.executeQuery("SELECT member,datype,sheng,shi,yiyuan,community,times FROM Doctoradmin WHERE daid =" + daid);
		   if(db.next())
		   {
			   member=db.getString(1);
			   datype=db.getInt(2);
			   sheng=db.getInt(3);
			   shi=db.getInt(4);
			   yiyuan=db.getInt(5);
			   community=db.getString(6);
			   times=db.getDate(7);
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

   public static int create(String member,int datype,int sheng,int shi,int yiyuan,String community) throws SQLException
   {
	   DbAdapter db = new DbAdapter();
	   Date times = new Date();
	   int i = 0;
	   try
	   {
		   db.executeUpdate("INSERT INTO Doctoradmin (member,datype,sheng,shi,yiyuan,community,times) VALUES ("+db.cite(member)+","+datype+","+sheng+","+shi+","+yiyuan+","+db.cite(community)+","+db.cite(times)+" )");
			 i = db.getInt("SELECT MAX(daid) FROM Doctoradmin");
	   } finally
	   {
		   db.close();
	   }
	   return i;
   }

   public void set(String member,int datype,int sheng,int shi,int yiyuan) throws SQLException
   {
	   DbAdapter db = new DbAdapter();
	   try
	   {
		   db.executeUpdate("UPDATE Doctoradmin SET member="+db.cite(member)+",datype="+datype+" ,sheng="+sheng+",shi="+shi+",yiyuan="+yiyuan+"  WHERE daid="+daid);
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
		   db.executeQuery("SELECT daid FROM Doctoradmin WHERE community= " + db.cite(community) + sql,pos,size);
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

   public void delete() throws SQLException
   {
	   DbAdapter db = new DbAdapter();
	   try
	   {
		   db.executeUpdate("DELETE FROM  Doctoradmin WHERE daid = " + daid);

	   } finally
	   {
		   db.close();
	   }
   }
   public static int count(String community,String sql) throws SQLException
	  {
		  int count = 0;
		  DbAdapter db = new DbAdapter();
		  try
		  {
			  db.executeQuery("SELECT COUNT(daid) FROM Doctoradmin  WHERE community=" + db.cite(community) + sql);
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
	//判断管理员账户
	public static boolean isMember(String community,String member)throws SQLException
	{

		boolean f = false;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT daid FROM Doctoradmin  WHERE community=" + db.cite(community) + " AND member="+db.cite(member));
			if(db.next())
			{
				f = true;
			}
		} finally
		{
			db.close();
		}
		return f;
	}

    public static boolean isProfile(String community,String member) throws SQLException
    {

        boolean f = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT profile FROM Profile  WHERE community=" + db.cite(community) + " AND member=" + db.cite(member));
            if(db.next())
            {
                f = true;
            }
        } finally
        {
            db.close();
        }
        return f;
    }
//通过member获取ID
	public static int isMemberDaid(String community,String member) throws SQLException
	{
		int i = 0;
		DbAdapter db = new DbAdapter();
	   try
	   {
		   db.executeQuery("SELECT daid FROM Doctoradmin  WHERE community=" + db.cite(community) + " AND member="+db.cite(member));
		   if(db.next())
		   {
			   i = db.getInt(1);
		   }
	   } finally
	   {
		   db.close();
	   }
	   return i;

	}
    public String getCommunity()
    {
        return community;
    }

    public int getDatype()
    {
        return datype;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getSheng()
    {
        return sheng;
    }

    public int getShi()
    {
        return shi;
    }

    public String getMember()
    {
        return member;
    }

    public Date getTimes()
    {
        return times;
    }

    public int getYiyuan()
    {
        return yiyuan;
    }


}
