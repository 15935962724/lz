package tea.entity.provincecity;

import java.sql.SQLException;
import java.util.Enumeration;
import java.util.Vector;

import tea.db.DbAdapter;
public class Elonglocation {

	private String id;
	private String Name_EN;
	private String Name_CN;
	private String locationtype;
	private String cityid;
	private boolean exists;
	
	public static final String LOCATION_TYPE[] = {"县或市区",	"商圈",	"地标"};
	
	public Elonglocation(String id,String cityid)throws SQLException
	{
		this.id = id;
		this.cityid=cityid;
		load();
	}
	
	public static Elonglocation find(String id,String cityid)throws SQLException
	{
		return new Elonglocation(id, cityid);
	}

	private void load()throws SQLException
	{

		DbAdapter db = new DbAdapter();
	
		try
		{
			db.executeQuery("SELECT Name_EN,Name_CN,locationtype,cityid FROM  elong_location WHERE id="+db.cite(id)+" and cityid = "+db.cite(cityid));
			
			if(db.next())
			{
				int x = 1;
				
				Name_EN=db.getString(x++);
				Name_CN=db.getString(x++);
				locationtype=db.getString(x++);
			
				
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
	
	public static Enumeration find(String sql,int pos,int size)
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM elong_location WHERE 1=1 " + sql,pos,size);
            while(db.next())
            {
                vector.add(db.getString(1));
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
	
	public  void set(String Name_CN,String Name_EN,String locationtype,String cityid) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{

			
				db.executeUpdate("UPDATE  elong_location set Name_CN="+db.cite(Name_CN)+",Name_EN="+db.cite(Name_EN)+",locationtype="+db.cite(locationtype)+"," +
						" cityid ="+db.cite(cityid)+" WHERE id="+db.cite(id)+" and cityid = "+db.cite(cityid));
			
		} finally
		{
			db.close();
		}
	}
	
	public static boolean isName(String name,String name2,String locationtype ,String cityid)throws SQLException
	{
		DbAdapter db = new DbAdapter();
		boolean f = false;
		try
		{

			
				db.executeQuery("SELECT  id FROM  elong_location WHERE "+name+"="+db.cite(name2)+" and locationtype="+db.cite(locationtype)+" and cityid = "+db.cite(cityid));
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
	
	public static String create(String Name_CN,String Name_EN,String locationtype,String cityid,String elid) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		String c = "0";
		try
		{
			
				
				db.executeUpdate("INSERT INTO elong_location (Name_CN,Name_EN,locationtype,cityid,id)VALUES("+db.cite(Name_CN)+"," +
						" "+db.cite(Name_EN)+","+db.cite(locationtype)+","+db.cite(cityid)+","+db.cite(elid)+" ) ");
				
				db.executeQuery("select  MAX(id) from elong_location");
				if(db.next())
				{
					c = db.getString(1); 
				}
			
		
		
		} finally
		{
			db.close();
		}
		return c;
	}
	public static String getEid(String ltype,String cityid)throws SQLException
	{
		String count = null;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT MAX(id) FROM elong_location WHERE locationtype ="+db.cite(ltype)+" AND cityid = "+db.cite(cityid));
            if(db.next())
            {
                count = db.getString(1);
            }
        } finally
        {
            db.close();
        }
        return count;
	}
	public static String getEid(String cityid)throws SQLException
	{
		String count = null;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT MAX(id) FROM elong_location WHERE locationtype!='commercial' and cityid = "+db.cite(cityid));
            if(db.next())
            {
                count = db.getString(1);
            }
        } finally
        {
            db.close();
        }
        return count;
	}
	
	
	public static int count(String sql) throws SQLException
	  {
	        int count = 0;
	        DbAdapter db = new DbAdapter();
	        try
	        {
	            db.executeQuery("SELECT COUNT(id) FROM elong_location WHERE 1=1"+ sql);
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
	
	public void delete ()throws SQLException
	{
		 DbAdapter db = new DbAdapter();
	        try
	        {
	            db.executeUpdate("DELETE FROM elong_location WHERE id ="+id+" and cityid="+ db.cite(cityid)+" and locationtype ="+db.cite(locationtype));
	            
	        } finally
	        {
	            db.close();
	        } 
	}
	public static  void delete (String cityid)throws SQLException
	{
		 DbAdapter db = new DbAdapter();
	        try
	        {
	            db.executeUpdate("DELETE FROM elong_location WHERE cityid="+ db.cite(cityid));
	            
	        } finally
	        {
	            db.close();
	        }
	}

	public String getName_EN() {
		return Name_EN;
	}

	public String getName_CN() {
		return Name_CN;
	}

	public String getLocationtype() {
		return locationtype;
	}

	public String getCityid() {
		return cityid;
	}

	public boolean isExists() {
		return exists;
	}
	
	
	
	
	
	
}
