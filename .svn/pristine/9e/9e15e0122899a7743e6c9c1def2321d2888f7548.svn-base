package tea.entity.lvyou;

import java.io.*;
import java.sql.SQLException;
import java.util.*;
import java.text.*;
import jxl.*;
import jxl.write.*;
import tea.db.*;
import tea.entity.*;
import tea.resource.*;

public class LvyouJobCatagory
{
	 public int id;
    public String name;


    public LvyouJobCatagory()
    {
   
    }
    
    public static void delete(int id) throws SQLException
    {
        DbAdapter db = new DbAdapter();
       
        try
        {
         db.executeUpdate("delete from lvyoujobcatagory where  id="+id);
          } finally
        {
            db.close();
        }
    
    }
    public void set(int id,	String name) throws SQLException
    {
        DbAdapter db = new DbAdapter();
     
        try
        {
            int j = db.executeUpdate("UPDATE lvyoujobcatagory SET  name =" +DbAdapter.cite(name)  +
            		                 " WHERE id=" + id);
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO lvyoujobcatagory (name)VALUES (" + DbAdapter.cite(name)+")");
            }
        } finally
        {
            db.close();
        }
    
    }
    public static LvyouJobCatagory find(int id) throws SQLException
    {
         
            DbAdapter db = new DbAdapter();
            LvyouJobCatagory city=new LvyouJobCatagory();
            try
            {
                db.executeQuery("SELECT	 id,name  FROM lvyoujobcatagory WHERE id=" + id);
                if(db.next())
                { 
                  city.setId(id);
                  city.setName(db.getString(2));
               } else
                {city.setId(id);
                city.setName("");
               }
            } finally
            {
                db.close();
            }
          return city;
    }
    public static ArrayList<LvyouJobCatagory> find() throws SQLException
    {
    	ArrayList<LvyouJobCatagory> al = new ArrayList<LvyouJobCatagory>();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id,name FROM lvyoujobcatagory");
            while(db.next())
            {
               LvyouJobCatagory g = new LvyouJobCatagory();
               g.setId(db.getInt(1));
               g.setName(db.getString(2));
               al.add(g);
            }
        } finally
        {
            db.close();
        }
        return al;
    }
	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}

  

  

}
