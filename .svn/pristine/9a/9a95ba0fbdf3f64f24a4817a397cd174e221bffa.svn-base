package tea.entity.alisoft;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class AliCompany extends Entity
{

   private String comId;
   private String comCreator;
   private String comName;
   private String comEmail;
   private int comUserCount;
   private Date gmtStart;
   private Date gmtEnd;
   private boolean exists;

   public AliCompany(String comId) throws SQLException
   {
	   this.comId = comId;
	   load();
   }

   public AliCompany(String comId,String comCreator,String comName,String comEmail,int comUserCount, Date gmtStart, Date gmtEnd) throws SQLException
   {
	   this.comId = comId;
	   this.comCreator = comCreator;
	   this.comName = comName;
	   this.comEmail=comEmail;
	   this.comUserCount=comUserCount;
	   this.gmtStart=gmtStart;
	   this.gmtEnd=gmtEnd;
	   this.exists = true;
   }

   public static AliCompany find(String comId) throws SQLException
   {
	   return new AliCompany(comId);
   }

   public void load() throws SQLException
   {
	   DbAdapter db = new DbAdapter();
	   try
	   {
		   db.executeQuery("Select comid,comcreator,comname,comemail,comusercount,gmtstart,gmtend from alicompany where comid=" + comId);
		   if(db.next())
		   {
			   comId = db.getString(1);
			   comCreator = db.getString(2);
			   comName = db.getString(3);
			   comEmail = db.getString(4);
			   comUserCount = db.getInt(5);
			   gmtStart = db.getDate(6);
			   gmtEnd = db.getDate(7);
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



   public static void create(String comId,String comCreator,String comName,String comEmail,int comUserCount, Date gmtStart) throws SQLException
   {

	   DbAdapter db = new DbAdapter();
	   try
	   {
		   db.executeUpdate("Insert into  alicompany(comid,comcreator,comname,comemail,comusercount,gmtstart) values(" + db.cite(comId) + "," + db.cite(comCreator) + ","+db.cite(comName)+","+db.cite(comEmail)+","+comUserCount+","+db.cite(gmtStart)+")");
	   } finally
	   {
		   db.close();
	   }
   }


   public static boolean isExisted(String comId) throws SQLException
   {
	   boolean flag = false;

		   StringBuilder sb = new StringBuilder();
		   sb.append("SELECT comid FROM alicompany WHERE comid=").append(DbAdapter.cite(comId));
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



   public static void set(String comId,String comCreator,String comName,String comEmail,int comUserCount, Date gmtStart,Date gmtEnd)throws SQLException
   {
	   DbAdapter db = new DbAdapter();
	   try
	   {
		   db.executeUpdate("Update alicompany set comcreator="+db.cite(comCreator)+",comname="+db.cite(comName)+",comemail="+db.cite(comEmail)+",comusercount="+comUserCount+",gmtstart="+db.cite(gmtStart)+",gmtend="+db.cite(gmtEnd)+" where comid="+db.cite(comId));
	   }
	   finally
	   {
		   db.close();
	   }
   }





   public static void delete (String comId)throws SQLException
   {
	   DbAdapter db = new DbAdapter();
	   try
	   {
		   db.executeUpdate("delete from alicompany where comid="+db.cite(comId));
	   }
	   finally
	   {
		   db.close();
	   }
   }



   public boolean isExists()
   {
	   return exists;
   }

    public String getComCreator()
    {
        return comCreator;
    }

    public String getComEmail()
    {
        return comEmail;
    }

    public String getComId()
    {
        return comId;
    }

    public String getComName()
    {
        return comName;
    }

    public int getComUserCount()
    {
        return comUserCount;
    }

    public Date getGmtEnd()
    {
        return gmtEnd;
    }

    public Date getGmtStart()
    {
        return gmtStart;
    }


}

